img=double(imread('cameraman.tif'))/255;
img=imresize(img,[256 256]);

figure(1)
colormap(gray)
imagesc(img)
title('original image')

% create patches
% N(1024) x D(64) 
patches=im2col(img, [8 8], 'distinct')';

%% Part 0. Whitening
% Subtract mean and divide by the variance for each dimension
patch_mean=mean(patches);
patch_std=std(patches);

whitened_patches=...
  bsxfun(@rdivide, ...
    bsxfun(@minus, patches, patch_mean), ...
    patch_std);

%% Part 1. PCA
 [~,lambda,VV]=svd(whitened_patches,0);
lambda=diag(lambda);

% Find 95% variance
pca_var=.95;
k=find(cumsum(lambda.^2)>=pca_var*sum(lambda.^2), 1, 'first');
V=VV(:,1:k);
fprintf('Captured %f %% variance using %d dims\n', ...
    sum(lambda(1:k).^2)/sum(lambda.^2)*100, k);
pca_patches=whitened_patches*V;

% Display PCA patches
figure(2)
colormap(gray)
plot_h=ceil(sqrt(64)); plot_w=ceil(sqrt(64));
for i=1:64
  subplot(plot_h,plot_w,i)
  imagesc(reshape(VV(:,i),[8 8]))
  axis off
  title(i)
end

% Display reconstruction
reconstruction_img=...
  col2im(bsxfun(@plus, ...
    bsxfun(@times, pca_patches*V', patch_std), ...
  patch_mean)', [8 8], [256 256], 'distinct');
figure(3)
colormap(gray)
imagesc(reconstruction_img);
title('PCA reconstruction')

%% Part 2. ICA
[W, ISR]=efica3(whitened_patches');
A=pinv(W);

% Display ICA patches
figure(4)
colormap(gray)
for i=1:64
  subplot(8,8,i)
  imagesc(reshape(W(i,:),[8 8]))
  axis off
  title(i)
end

figure(5)
colormap(gray)
for i=1:64
  subplot(8,8,i)
  imagesc(reshape(A(:,i),[8 8]))
  axis off
  title(i)
end

