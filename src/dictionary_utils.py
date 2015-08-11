'''
Contains methods related to dictionary visualization and convolution operations.
Since 4-D convolution could take a while, we use Theano, which can utilize the GPUs.

@author: Tomoki Tsuchida <ttsuchida@ucsd.edu>
'''
from numpy import *
import numpy.distutils
import numpy.distutils.__config__

import matplotlib.cm as cmx

import theano
from theano.tensor.nnet.conv import conv2d

from numpy.testing import *

def activations(images, D):
    """Calculates the activations for the image given the dictionary D.
    The images tensor should have shape (N, F, Y, X), where
      N - number of images
      C - number of image channel (1 for grayscale, 3 for RGB, etc.)
      Y - height of the images
      X - width of the images
     
    and the dictionary set D should have shape (K, F, Y, X), where
      K - number of dictionary elements
      C - number of channels (same as above)
      y - height of each dictionary patch
      x - widgth of each dictionary patch
    
    returns an array of size (C, K, Y-y+1, X-x+1).
    """
    _, _, y, x = D.shape
    return corr4(images, D)[:, :, :-(y-1), :-(x-1)]

def reconstruct(S, D):
    """Reconstruct the images from a stack of activations S.
    The activation stack S should have size (N, K, Y, X), where
      N - number of images
      K - number of dictionary elements
      Y - height of the images
      X - width of the images
    
    and the dictionary set D should have shape (K, F, Y, X), where
      K - number of dictionary elements
      C - number of channels
      Y - height of each dictionary patch
      X - widgth of each dictionary patch
    
    returns an array of size (N, C, Y-y+1, X-x+1).
    """
    N, K, Y, X = S.shape
    K, C, y, x = D.shape
    Ds = swapaxes(D, 0, 1)
    R = zeros((N, C, Y, X))
    
    for k in range(K):
        R += conv4(S[:,k:k+1], Ds[:,k:k+1])[:, :, :Y, :X]
    return R[:, :, (y-1):, (x-1):]

def to_image(D, border=1, colorize=True, SZ=None):
    """Creates an image that displays the whole dictinoary set.  The result can then be used in the `imshow` function.

        The dictionary set D should have shape (K, F, Y, X), where
          K - number of dictionary elements
          C - number of channels
          Y - height of each dictionary patch
          X - widgth of each dictionary patch
       
       SZ is the size of the image tile, which defaults to (int(ceil(sqrt(K))), int(ceil(sqrt(K)))).
    
    >>> D = normalize(matrix([[2,0,0],[0,-2,0],[0,0,2],[0,0,0]]))
    
    >>> assert_array_equal(to_image(A, colorize = False), array([[1,.5,.5,.5,0],[.5,.5,.5,.5,.5],[.5,.5,.5,.5,.5],[.5,.5,.5,.5,.5],[1,.5,.5,.5,.5]]))

    >>> assert_allclose(to_image(A, colorize = True)[2,2], array([0.9657055,   0.96724337,  0.9680892,   1.]))
    """
    D = D.copy()  # It's passed by reference!
    K, C, Y, X = D.shape
    
    # image patch size
    sz = (Y, X)
    
    # the big image size
    if SZ is None:
        SZ = (int(ceil(sqrt(K))), int(ceil(sqrt(K))))
    
    image = ones(((border + sz[0]) * SZ[0] - border, (border + sz[1]) * SZ[1] - border, C)) * .5
    
    # scale images but with 0.5 as the center
    scaling = nanmax(abs(D)) * 2
    D /= scaling  # D in [-.5,.5]
    D += .5  # D in [0, 1]
    
    for k in range(K):
        x = (k % SZ[1]) * (border + sz[1])
        y = (k / SZ[1]) * (border + sz[0])
        image[y:(y + sz[0]), x:(x + sz[1])] = swapaxes(rollaxis(D[k],1),1,2)
    
    if C == 1:
        if colorize:
            smap = cmx.ScalarMappable(cmap=cmx.get_cmap('RdBu'))
            smap.set_clim(0, 1.0)
            return smap.to_rgba(image.squeeze())
        else:
            return image.squeeze()
        
    return image

conv2d_function = None

def conv4(A, B, border_mode='full'):
    """4-D convolution.
    
    A - mini-batch of feature map stacks, of shape (N, F, Y, X)
    B - set of filters used in CNN layer of shape (K, F, y, x)
    
    output - (N, K, Y+y-1, X+x-1)
    
    >>> K = 2; F = 3; Y = 3; X = 3; N = 2; A = zeros((N,F,Y,X)); B = zeros((K,F,Y,X));
    
    >>> A[0, :2, :, :]=array([[[1,0,0],[0,0,0],[0,0,0]],[[-1,0,0],[0,0,0],[0,0,0]]])
    
    >>> A[1, :2, :, :]=array([[[0,0,0],[0,0,0],[0,0,-1]],[[0,0,0],[0,0,0],[0,0,1]]])

    >>> B[0, :2, :, :]=array([[[1,2,3],[4,5,6],[7,8,9]],[[-1,-2,-3],[-4,-5,-6],[-7,-8,-9]]])
    
    >>> B[1, :2, :, :]=array([[[1,2,3],[4,5,6],[7,8,9]],[[-1,-2,-3],[-4,-5,-6],[-7,-8,-9]]])*2

    >>> C = conv4(A, B)

    >>> assert_equal(C.shape, (N, K, Y+Y-1, X+X-1))
    
    >>> assert_allclose(C[0, 0, :Y, :X], 2*B[0,0,:,:])

    >>> assert_allclose(C[0, 1, :Y, :X], 2*B[1,0,:,:])

    >>> assert_allclose(C[1, 0, (Y-1):, (X-1):], 2*B[0,1,:,:])    
    
    """
    global conv2d_function
    if conv2d_function is None:
        input_tensor = theano.tensor.tensor4(name='input')
        filters = theano.tensor.tensor4(name='filters')
        conv2d_function = theano.function([input_tensor, filters], conv2d(input_tensor, filters, border_mode=border_mode))
    return conv2d_function(asarray(A, dtype=float32), asarray(B, dtype=float32))

def corr4(A, B):
    """4-D correlation.
    A - mini-batch of feature map stacks, of shape (N, F, Y, X)
    B - set of filters used in CNN layer of shape (K, F, y, x)
    
    output - (N, K, Y, X)

    """
    _, _, Y, X = A.shape
    _, _, y, x = B.shape
    return conv4(A, B[:,:,::-1,::-1])[:, :, (y-1):(Y+y-1), (x-1):(X+x-1)]

if __name__ == '__main__':
    import doctest
    doctest.testmod()