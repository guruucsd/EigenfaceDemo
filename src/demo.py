"""Contains routines that are used for interactive demos."""

from numpy import *
from IPython.html.widgets import *
import matplotlib.pyplot as plt

#### Gabor Filter demo ####

from filters import gabor_filter
def plot_gabor_filtering(dataset, image_id, frequency, theta, real_or_imag=0):
    """Plots the results of the real part of the Gabor filter."""
    original=dataset.images[image_id]
    fig, axs = plt.subplots(1, 4, figsize=(15,5))
    axs[0].imshow(original,cmap='gray',interpolation='none')
    axs[0].set_title('Original Image')
    axs[0].axis('off')
    
    ri = 'real' if real_or_imag else 'imag'
    delta_image=zeros(original.shape, dtype=float)
    delta_image[tuple(array(delta_image.shape)/2)]=1.0 # 1.0 at the center
    kernel_real=gabor_filter(delta_image, frequency=frequency, theta=theta)[real_or_imag]
    axs[1].imshow(kernel_real,cmap='gray',interpolation='none')
    axs[1].set_title('Filter (%s)' % ri)
    axs[1].axis('off')
    
    
    filtered_real=gabor_filter(original, frequency=frequency, theta=theta)[real_or_imag]
    axs[2].imshow(filtered_real,cmap='gray',interpolation='none')
    axs[2].set_title('Filtered Image')
    axs[2].axis('off')
    
    axs[3].hist(filtered_real.flatten(), normed=True, bins=16)
    axs[3].set_title('Response Histogram')