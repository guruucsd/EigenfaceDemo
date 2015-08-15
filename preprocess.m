% -------------------------------------------------------------------------
function varargout = preprocess(varargin)
    if nargin == 0
        fig = openfig(mfilename,'reuse');    
        set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));
        handles = guihandles(fig);
        guidata(fig, handles);
        if nargout > 0
            varargout{1} = fig;
        end;
    elseif ischar(varargin{1})
        try
            if (nargout)
                [varargout{1:nargout}] = feval(varargin{:});
            else
                feval(varargin{:});
            end;
        catch
            disp(lasterr);
        end;
    end;

% -------------------------------------------------------------------------
function varargout = btnLoadImages_Callback(h, eventdata, handles, varargin)
    global rootDir Imgs Width Height;
    
    % Disable this button
    set(h, 'Enable', 'Off');
    
    % load the images
    datasetName = get(handles.listDataset, 'Value');
    if (datasetName == 1)
        datasetName = 'POFA';
        imageDir = [rootDir datasetName '/images/'];
        dataDir = [rootDir datasetName '/data/'];
        [Imgs, Width, Height] = pgmLoadImages(imageDir, [dataDir 'listFiles.txt'], 4);
    elseif (datasetName == 2)
        datasetName = 'CAFE';
        imageDir = [rootDir datasetName '/images/'];
        dataDir = [rootDir datasetName '/data/'];
        [Imgs, Width, Height] = pgmLoadImages(imageDir, [dataDir 'listFiles.txt'], 4);
    end;
    [D N] = size(Imgs);
    for i = 1:N
        Imgs(:,i) = zscore(Imgs(:,i));
    end;

    % display two images
    axes(handles.mapOrig1);
    img = reshape(Imgs(:,5), Height, Width);
    imagesc(img);
    colormap(gray);
    axis off image;
    axes(handles.mapOrig2);
    img = reshape(Imgs(:,20), Height, Width);
    imagesc(img);
    colormap(gray);
    axis off image;
    
    % clear the last three axes
    axes(handles.mapPCA);    cla;
    axes(handles.mapFace1);    cla;
    axes(handles.mapFace2);    cla;

    % enable the PCA button
    set(handles.btnPCA, 'Enable', 'On');
    set(handles.sliderPCA, 'Enable', 'Off');
    set(handles.btnSave, 'Enable', 'Off');
    set(handles.txtNumberOfComponents, 'Enable', 'Off');
    set(h, 'Enable', 'On');
    clear rootDir Imgs Width Height;

% -------------------------------------------------------------------------
function varargout = btnPCA_Callback(h, eventdata, handles, varargin)
    global Imgs Vecs Vals Psii;
    
    % Disable this button
    set(h, 'Enable', 'Off');

    % Get the original dimension and the sample size    
    [D N] = size(Imgs);

    % Get top N PC evectors of Imgs
    [Vecs, Vals, Psii] = pc_evectors(Imgs, N);

    % set the slide bar
    d = sum(Vals>0);
    set(handles.sliderPCA, 'Min', 1);
    set(handles.sliderPCA, 'Max', d);

    % Draw the eigenvalues
    axes(handles.mapPCA);
    plot(1:N, Vals(1:N));

    % Enable the Test button and the Save button
    set(handles.sliderPCA, 'Enable', 'On');
    set(handles.btnSave, 'Enable', 'On');
    set(handles.txtNumberOfComponents, 'Enable', 'On');
    set(h, 'Enable', 'On');
    clear Imgs Vecs Vals Psii;

% -------------------------------------------------------------------------
function varargout = txtNumberOfComponents_Callback(h, eventdata, handles, varargin)
    global d Imgs Vecs Psii Width Height;
    
    % get the number of principal components
    d = get(handles.txtNumberOfComponents, 'String');
    d = floor(str2num(d));
    set(handles.sliderPCA,'Value', d);

    % display the reconstructed face_5
    OrigImg = Imgs(:,5);
    Projection = Vecs(:,1:d)'*(OrigImg - Psii);
    Reconstruction = Vecs(:,1:d)*Projection+Psii;
    Reconstruction = reshape(Reconstruction, Height, Width);
    axes(handles.mapFace1);
    imagesc(Reconstruction);
    colormap(gray);
    axis off image;

    % display the reconstructed face_20
    OrigImg = Imgs(:,20);
    Projection = Vecs(:,1:d)'*(OrigImg - Psii);
    Reconstruction = Vecs(:,1:d)*Projection+Psii;
    Reconstruction = reshape(Reconstruction, Height, Width);
    axes(handles.mapFace2);
    imagesc(Reconstruction);
    colormap(gray);
    axis off image;
    
    clear d Imgs Vecs Psii Width Height;
    set(handles.btnSave, 'Enable', 'On');

% -------------------------------------------------------------------------
function varargout = btnSave_Callback(h, eventdata, handles, varargin)
    % disable this button
    set(h, 'Enable', 'Off');

    global Imgs Vecs Vals Psii d Width Height;
    % Project each image onto first d evectors
    [D N] = size(Imgs);
    projected = Vecs(:,1:d)' * (Imgs - repmat(Psii, 1, N));
    temp = Vecs;
    Vecs = Vecs(:,1:d);
    
    % Ask the user to save the PCA results
    [filename, pathname] = uiputfile({'*.mat';'*.*'}, 'Save as an MAT file');
    if (isequal(filename,0) | isequal(pathname,0))
        set(h, 'Enable', 'On');
        Vecs = temp;
        return;
    end;    
    save ([pathname filename], 'projected', 'Vecs', 'Psii', 'Width', 'Height', 'Vals');
    Vecs = temp;
    msgbox('All the pattern files have been saved.', 'Congratulations');    

    % Enable this button
    set(h, 'Enable', 'On');
    clear Imgs Vecs Vals Psii d;

% -------------------------------------------------------------------------
function sliderPCA_Callback(hObject, eventdata, handles)
    global d Imgs Vecs Psii Width Height;
    
    % get the number of principal components
    d = get(hObject,'Value');
    d = floor(d);
    set(handles.txtNumberOfComponents, 'String', d);

    % display the reconstructed face_5
    OrigImg = Imgs(:,5);
    Projection = Vecs(:,1:d)'*(OrigImg - Psii);
    Reconstruction = Vecs(:,1:d)*Projection+Psii;
    Reconstruction = reshape(Reconstruction, Height, Width);
    axes(handles.mapFace1);
    imagesc(Reconstruction);
    colormap(gray);
    axis off image;

    % display the reconstructed face_20
    OrigImg = Imgs(:,20);
    Projection = Vecs(:,1:d)'*(OrigImg - Psii);
    Reconstruction = Vecs(:,1:d)*Projection+Psii;
    Reconstruction = reshape(Reconstruction, Height, Width);
    axes(handles.mapFace2);
    imagesc(Reconstruction);
    colormap(gray);
    axis off image;
    
    clear d Imgs Vecs Psii Width Height;
    set(handles.btnSave, 'Enable', 'On');

% -------------------------------------------------------------------------
function sliderPCA_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end

% -------------------------------------------------------------------------
function listDataset_CreateFcn(hObject, eventdata, handles)
%    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%        set(hObject,'BackgroundColor','white');
%    end

% -------------------------------------------------------------------------
function listDataset_Callback(hObject, eventdata, handles)