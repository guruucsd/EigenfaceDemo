function [images, width, height] = pgmLoadImages(directory, filelist, downscale_f)

% initialization
if (nargin < 2 | nargin > 3)
    error('usage: pgmLoadImages(directory, filelist[,downscale_f]');
elseif (nargin == 2)
    downscale_f = 1.0;
end;
images = [];

% open input file
numImages = pgmLineCount(filelist);
fid = fopen(filelist, 'r');
if (fid < 0 | numImages < 1)
    error(['Cannot get list of images from file "' filelist, '"']);
end;

% get the images
for i = 1:numImages
    % get one image filename
    imageName = fgetl(fid);
    if ~ischar(imageName) break; end;
    while (isempty(imageName))
        imageName = fgetl(fid);
    end;
    fprintf(1,'loading image file %s\n', imageName);
    
    % read this image as a 2D array
    Img = imread([directory imageName]);
    
    % if this is a color image
    if (length(size(Img)) == 3)
        Img = rgb2gray(Img);
    end;
    Img = im2double(Img);
    
    % resize the image
    if (downscale_f > 1.0)
        Img = imresize(Img, 1/downscale_f, 'bicubic');
    end;

    % If this is first image, figure things out
    %   - like sizes of the downscaled images
    if (i==1)
        [height width] = size(Img);
        images = zeros(width*height, numImages);
    end;
    
    % make a column vector
    images(:,i) = reshape(Img, width*height, 1);
end;
fclose(fid);
fprintf(1, 'Read %d images.\n', numImages);