clear all;

% set the root directory that contains the images
global rootDir imageDir dataDir;
rootDir = './';

% the images, to be loaded by the GUI
global Imgs Width Height;

% PCA results, to be calculted.
global Vecs;    % eigenvectors
global Vals;    % eigenvalues
global Psii;    % mean
global d;       % number of principal components to be kept
global projected; % images projected to low dimensions

% run the GUI program
preprocess;