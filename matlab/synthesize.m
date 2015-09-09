function varargout = synthesize(varargin)
    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @synthesize_OpeningFcn, ...
                       'gui_OutputFcn',  @synthesize_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end;

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end;
    % End initialization code - DO NOT EDIT


% --- Executes just before synthesize is made visible.
function synthesize_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = synthesize_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;

% --- Executes on slider movement.
function sliderImage1_Callback(hObject, eventdata, handles)
    % Load the pattern file
    global Vecs Psii projected Width Height;
    
    % create the synthesized image
    idx1 = floor(get(handles.sliderImage1, 'Value'));
    idx2 = floor(get(handles.sliderImage2, 'Value'));
    idx3 = get(handles.sliderSynthesize, 'Value');
    
    % display the reconstructed image 1
    axes(handles.axes1);    cla;
    hold on;
    x1 = projected(:,idx1);
    img = Vecs*x1+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis off image ij;
    hold off;

    % display the reconstructed image 2
    axes(handles.axes2);
    cla;
    hold on;
    x2 = projected(:,idx2);
    img = Vecs*x2+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis off image ij;
    hold off;

    % display the synthesized image
    axes(handles.axes3);
    cla;
    hold on;
    x3 = x1*idx3 + x2*(1-idx3);
    img = Vecs*x3+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis off image ij;
    hold off;

    % Enable the "train" button and this button
    clear Vecs Psii projected Width Height;


% --- Executes during object creation, after setting all properties.
function sliderImage1_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end


% --- Executes on slider movement.
function sliderImage2_Callback(hObject, eventdata, handles)
    % Load the pattern file
    global Vecs Psii projected Width Height;
    
    % create the synthesized image
    idx1 = floor(get(handles.sliderImage1, 'Value'));
    idx2 = floor(get(handles.sliderImage2, 'Value'));
    idx3 = get(handles.sliderSynthesize, 'Value');
    
    % display the reconstructed image 1
    axes(handles.axes1);
    cla;
    hold on;
    x1 = projected(:,idx1);
    img = Vecs*x1+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis off image ij;
    hold off;

    % display the reconstructed image 2
    axes(handles.axes2);
    cla;
    hold on;
    x2 = projected(:,idx2);
    img = Vecs*x2+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis off image ij;
    hold off;

    % display the synthesized image
    axes(handles.axes3);
    cla;
    hold on;
    x3 = x1*idx3 + x2*(1-idx3);
    img = Vecs*x3+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis off image ij;
    hold off;

    % Enable the "train" button and this button
    clear Vecs Psii projected Width Height;


% --- Executes during object creation, after setting all properties.
function sliderImage2_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end


% --- Executes on slider movement.
function sliderSynthesize_Callback(hObject, eventdata, handles)
    % Load the pattern file
    global Vecs Psii projected Width Height;
    
    % create the synthesized image
    idx1 = floor(get(handles.sliderImage1, 'Value'));
    idx2 = floor(get(handles.sliderImage2, 'Value'));
    idx3 = get(handles.sliderSynthesize, 'Value');
    
    % display the reconstructed image 1
    axes(handles.axes1);
    cla;
    hold on;
    x1 = projected(:,idx1);
    img = Vecs*x1+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis off image ij;
    hold off;

    % display the reconstructed image 2
    axes(handles.axes2);
    cla;
    hold on;
    x2 = projected(:,idx2);
    img = Vecs*x2+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis off image ij;
    hold off;

    % display the synthesized image
    axes(handles.axes3);
    cla;
    hold on;
    x3 = x1*idx3 + x2*(1-idx3);
    img = Vecs*x3+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis off image ij;
    hold off;

    % Enable the "train" button and this button
    clear Vecs Psii projected Width Height;


% --- Executes during object creation, after setting all properties.
function sliderSynthesize_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end


% --- Executes on button press in btnLoadImages.
function btnLoadImages_Callback(hObject, eventdata, handles)

    % Disable this button
    set(handles.btnLoadImages, 'Enable', 'Off');

    % Ask the user to choose the pattern file for training
    [filename, pathname] = uigetfile({'*.mat';'*.*'}, 'Pick a pattern file');
    if (isequal(filename,0) | isequal(pathname,0))
        set(handles.btnLoadImages, 'Enable', 'On');
        return;
    end

    % Load the pattern file
    global Vecs Psii projected Width Height;
    load([pathname filename]);
    [d, N] = size(projected);
    
    set(handles.sliderImage1, 'Value', 1);
    set(handles.sliderImage2, 'Value', 1);
    
    % create the synthesized image
    set(handles.sliderImage1, 'Max', N);
    set(handles.sliderImage2, 'Max', N);
    idx1 = floor(get(handles.sliderImage1, 'Value'));
    idx2 = floor(get(handles.sliderImage2, 'Value'));
    idx3 = get(handles.sliderSynthesize, 'Value');
    
    % display the reconstructed image 1
    axes(handles.axes1);
    cla;
    hold on;
    x1 = projected(:,idx1);
    img = Vecs*x1+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis off image ij;
    hold off;

    % display the reconstructed image 2
    axes(handles.axes2);
    cla;
    hold on;
    x2 = projected(:,idx2);
    img = Vecs*x2+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis off image ij;
    hold off;

    % display the synthesized image
    axes(handles.axes3);
    cla;
    hold on;
    x3 = x1*idx3 + x2*(1-idx3);
    img = Vecs*x3+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis off image ij;
    hold off;

    % Enable the "train" button and this button
    set(handles.btnLoadImages, 'Enable', 'On');
    clear Vecs Psii projected Width Height;