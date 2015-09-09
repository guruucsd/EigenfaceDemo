function varargout = slider(varargin)
    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @slider_OpeningFcn, ...
                       'gui_OutputFcn',  @slider_OutputFcn, ...
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

% --- Executes just before slider is made visible.
function slider_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = slider_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;
    
% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;
    
% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;
    
% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider13_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider14_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider15_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;
    
% --- Executes during object creation, after setting all properties.
function slider16_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider17_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider18_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider19_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;

% --- Executes during object creation, after setting all properties.
function slider20_CreateFcn(hObject, eventdata, handles)
    if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor',[.9 .9 .9]);
    end;
    
% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);
    
% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);
    
% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider13_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider14_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider15_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider16_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider17_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);
   
% --- Executes on slider movement.
function slider18_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider19_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

% --- Executes on slider movement.
function slider20_Callback(hObject, eventdata, handles)
    adjust_sliders(handles);

function adjust_sliders(handles)
    global projected Vecs Psii Width Height idxImg;

    % display the reconstructed image
    X = projected(idxImg,:);
    X(1) = get(handles.slider1, 'Value');
    X(2) = get(handles.slider2, 'Value');
    X(3) = get(handles.slider3, 'Value');
    X(4) = get(handles.slider4, 'Value');
    X(5) = get(handles.slider5, 'Value');
    X(6) = get(handles.slider6, 'Value');
    X(7) = get(handles.slider7, 'Value');
    X(8) = get(handles.slider8, 'Value');
    X(9) = get(handles.slider9, 'Value');
    X(10) = get(handles.slider10, 'Value');
    X(11) = get(handles.slider11, 'Value');
    X(12) = get(handles.slider12, 'Value');
    X(13) = get(handles.slider13, 'Value');
    X(14) = get(handles.slider14, 'Value');
    X(15) = get(handles.slider15, 'Value');
    X(16) = get(handles.slider16, 'Value');
    X(17) = get(handles.slider17, 'Value');
    X(18) = get(handles.slider18, 'Value');
    X(19) = get(handles.slider19, 'Value');
    X(20) = get(handles.slider20, 'Value');
    axes(handles.axesReconstructed);
    cla;
    hold on;
    img = Vecs*X' + Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    % display the reconstructed image
    Y = projected(idxImg,:);
    axes(handles.axesOrig);
    cla;
    hold on;
    img = Vecs*Y' + Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
        
    clear projected Vecs Psii Width Height idxImg;
    

% --- Executes on button press in btnLoadPatterns.
function btnLoadPatterns_Callback(hObject, eventdata, handles)
    global Vecs Psii projected Width Height idxImg;

    % Ask the user to choose the pattern file for training
    [filename, pathname] = uigetfile({'*.mat';'*.*'}, 'Pick a pattern file');
    if (isequal(filename,0) | isequal(pathname,0))
        set(handles.btnLoadPattern, 'Enable', 'On');
        return;
    end;

    % Load the pattern file
    load([pathname filename]);
    projected = projected';
    [N D] = size(projected);
    
    % set the values for sliderImages
    set(handles.sliderImages, 'Enable', 'On');
    set(handles.sliderImages, 'Max', N);
    set(handles.sliderImages, 'Value', 1);    
    
    % Set the initial parameters of the sliders
    set(handles.slider1, 'Max', max(projected(:,1)));
    set(handles.slider1, 'Min', min(projected(:,1)));
    set(handles.slider2, 'Max', max(projected(:,2)));
    set(handles.slider2, 'Min', min(projected(:,2)));
    set(handles.slider3, 'Max', max(projected(:,3)));
    set(handles.slider3, 'Min', min(projected(:,3)));
    set(handles.slider4, 'Max', max(projected(:,4)));
    set(handles.slider4, 'Min', min(projected(:,4)));
    set(handles.slider5, 'Max', max(projected(:,5)));
    set(handles.slider5, 'Min', min(projected(:,5)));
    set(handles.slider6, 'Max', max(projected(:,6)));
    set(handles.slider6, 'Min', min(projected(:,6)));
    set(handles.slider7, 'Max', max(projected(:,7)));
    set(handles.slider7, 'Min', min(projected(:,7)));
    set(handles.slider8, 'Max', max(projected(:,8)));
    set(handles.slider8, 'Min', min(projected(:,8)));
    set(handles.slider9, 'Max', max(projected(:,9)));
    set(handles.slider9, 'Min', min(projected(:,9)));
    set(handles.slider10, 'Max', max(projected(:,10)));
    set(handles.slider10, 'Min', min(projected(:,10)));
    set(handles.slider11, 'Max', max(projected(:,11)));
    set(handles.slider11, 'Min', min(projected(:,11)));
    set(handles.slider12, 'Max', max(projected(:,12)));
    set(handles.slider12, 'Min', min(projected(:,12)));
    set(handles.slider13, 'Max', max(projected(:,13)));
    set(handles.slider13, 'Min', min(projected(:,13)));
    set(handles.slider14, 'Max', max(projected(:,14)));
    set(handles.slider14, 'Min', min(projected(:,14)));
    set(handles.slider15, 'Max', max(projected(:,15)));
    set(handles.slider15, 'Min', min(projected(:,15)));
    set(handles.slider16, 'Max', max(projected(:,16)));
    set(handles.slider16, 'Min', min(projected(:,16)));
    set(handles.slider17, 'Max', max(projected(:,17)));
    set(handles.slider17, 'Min', min(projected(:,17)));
    set(handles.slider18, 'Max', max(projected(:,18)));
    set(handles.slider18, 'Min', min(projected(:,18)));
    set(handles.slider19, 'Max', max(projected(:,19)));
    set(handles.slider19, 'Min', min(projected(:,19)));
    set(handles.slider20, 'Max', max(projected(:,20)));
    set(handles.slider20, 'Min', min(projected(:,20)));
    
    idxImg = 1;
    set_sliders(handles);
    
    axes(handles.axes1);    cla;
    hold on;
    img = Vecs(:,1);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;

    axes(handles.axes2);    cla;
    hold on;
    img = Vecs(:,2);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;

    axes(handles.axes3);    cla;
    hold on;
    img = Vecs(:,3);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;

    axes(handles.axes4);    cla;
    hold on;
    img = Vecs(:,4);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes5);    cla;
    hold on;
    img = Vecs(:,5);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes6);    cla;
    hold on;
    img = Vecs(:,6);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes7);    cla;
    hold on;
    img = Vecs(:,7);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes8);    cla;
    hold on;
    img = Vecs(:,8);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes9);    cla;
    hold on;
    img = Vecs(:,9);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes10);    cla;
    hold on;
    img = Vecs(:,10);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes11);    cla;
    hold on;
    img = Vecs(:,11);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;

    axes(handles.axes12);    cla;
    hold on;
    img = Vecs(:,12);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;

    axes(handles.axes13);    cla;
    hold on;
    img = Vecs(:,13);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;

    axes(handles.axes14);    cla;
    hold on;
    img = Vecs(:,14);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes15);    cla;
    hold on;
    img = Vecs(:,15);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes16);    cla;
    hold on;
    img = Vecs(:,16);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes17);    cla;
    hold on;
    img = Vecs(:,17);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes18);    cla;
    hold on;
    img = Vecs(:,18);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes19);    cla;
    hold on;
    img = Vecs(:,19);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    axes(handles.axes20);    cla;
    hold on;
    img = Vecs(:,20);
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis image ij off;
    hold off;
    
    adjust_sliders(handles);
    
    clear Vecs Psii projected Width Height idxImg;
    
function set_sliders(handles)
    global projected idxImg;
    set(handles.slider1, 'Value', projected(idxImg,1));
    set(handles.slider2, 'Value', projected(idxImg,2));
    set(handles.slider3, 'Value', projected(idxImg,3));
    set(handles.slider4, 'Value', projected(idxImg,4));
    set(handles.slider5, 'Value', projected(idxImg,5));
    set(handles.slider6, 'Value', projected(idxImg,6));
    set(handles.slider7, 'Value', projected(idxImg,7));
    set(handles.slider8, 'Value', projected(idxImg,8));
    set(handles.slider9, 'Value', projected(idxImg,9));
    set(handles.slider10, 'Value', projected(idxImg,10));
    set(handles.slider11, 'Value', projected(idxImg,11));
    set(handles.slider12, 'Value', projected(idxImg,12));
    set(handles.slider13, 'Value', projected(idxImg,13));
    set(handles.slider14, 'Value', projected(idxImg,14));
    set(handles.slider15, 'Value', projected(idxImg,15));
    set(handles.slider16, 'Value', projected(idxImg,16));
    set(handles.slider17, 'Value', projected(idxImg,17));
    set(handles.slider18, 'Value', projected(idxImg,18));
    set(handles.slider19, 'Value', projected(idxImg,19));
    set(handles.slider20, 'Value', projected(idxImg,20));
    clear projected idxImg;

% --- Executes on slider movement.
function sliderImages_Callback(hObject, eventdata, handles)
    global projected idxImg Vecs Width Height Psii;
    idxImg = floor(get(handles.sliderImages, 'Value'));
    set_sliders(handles);
    adjust_sliders(handles);
    clear projected idxImg Vecs Width Height Psii;

% --- Executes during object creation, after setting all properties.
function sliderImages_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in btnReset.
function btnReset_Callback(hObject, eventdata, handles)
    global projected idxImg;
    idxImg = floor(get(handles.sliderImages, 'Value'));
    set_sliders(handles);
    adjust_sliders(handles);
    clear projected idxImg;

% --- Executes on button press in btnZero.
function btnZero_Callback(hObject, eventdata, handles)
    set(handles.slider1, 'Value', 0);
    set(handles.slider2, 'Value', 0);
    set(handles.slider3, 'Value', 0);
    set(handles.slider4, 'Value', 0);
    set(handles.slider5, 'Value', 0);
    set(handles.slider6, 'Value', 0);
    set(handles.slider7, 'Value', 0);
    set(handles.slider8, 'Value', 0);
    set(handles.slider9, 'Value', 0);
    set(handles.slider10, 'Value', 0);
    set(handles.slider11, 'Value', 0);
    set(handles.slider12, 'Value', 0);
    set(handles.slider13, 'Value', 0);
    set(handles.slider14, 'Value', 0);
    set(handles.slider15, 'Value', 0);
    set(handles.slider16, 'Value', 0);
    set(handles.slider17, 'Value', 0);
    set(handles.slider18, 'Value', 0);
    set(handles.slider19, 'Value', 0);
    set(handles.slider20, 'Value', 0);
    adjust_sliders(handles);