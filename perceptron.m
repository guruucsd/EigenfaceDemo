function varargout = perceptron(varargin)
    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @perceptron_OpeningFcn, ...
                       'gui_OutputFcn',  @perceptron_OutputFcn, ...
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

% --- Executes just before perceptron is made visible.
function perceptron_OpeningFcn(hObject, eventdata, handles, varargin)
    handles.output = hObject;
    guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = perceptron_OutputFcn(hObject, eventdata, handles) 
    varargout{1} = handles.output;

function txtCov1_11_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtCov1_11_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtCov1_12_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtCov1_12_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtCov1_21_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtCov1_21_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtCov1_22_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtCov1_22_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtMean1X_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtMean1X_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtMean1Y_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtMean1Y_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtCov2_11_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtCov2_11_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtCov2_12_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtCov2_12_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtCov2_21_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtCov2_21_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtCov2_22_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtCov2_22_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtMean2X_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtMean2X_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtMean2Y_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtMean2Y_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

% --- Executes on button press in btnReset.
function btnReset_Callback(hObject, eventdata, handles)
    global X1 X2 W N X_max X_min Y_max Y_min;
    
    % get the number of samples per class
    N = get(handles.txtNumSamples, 'String');
    N = floor(str2num(N));
    
    % get the distributions of the two classes
    Cov1 = zeros(2,2);
    Cov1(1,1) = str2double(get(handles.txtCov1_11, 'String'));
    Cov1(1,2) = str2double(get(handles.txtCov1_12, 'String'));
    Cov1(2,1) = str2double(get(handles.txtCov1_21, 'String'));
    Cov1(2,2) = str2double(get(handles.txtCov1_22, 'String'));
    Cov2 = zeros(2,2);
    Cov2(1,1) = str2double(get(handles.txtCov2_11, 'String'));
    Cov2(1,2) = str2double(get(handles.txtCov2_12, 'String'));
    Cov2(2,1) = str2double(get(handles.txtCov2_21, 'String'));
    Cov2(2,2) = str2double(get(handles.txtCov2_22, 'String'));
    Mean1 = zeros(1,2);
    Mean1(1) = str2double(get(handles.txtMean1X, 'String'));
    Mean1(2) = str2double(get(handles.txtMean1Y, 'String'));
    Mean2 = zeros(1,2);
    Mean2(1) = str2double(get(handles.txtMean2X, 'String'));
    Mean2(2) = str2double(get(handles.txtMean2Y, 'String'));

    % create sample points
    X1 = randn(N,2)*Cov1 + repmat(Mean1, N,1);
    X2 = randn(N,2)*Cov2 + repmat(Mean2, N,1);

    % get the range of the samples
    X = [X1; X2];
    X_max = max(X(:,1));
    X_min = min(X(:,1));
    Y_max = max(X(:,2));
    Y_min = min(X(:,2));

    % plot these sample points
    axes(handles.axesPlot);
    hold off;
    plot(X1(:,1), X1(:,2), 'b*');
    hold on;
    plot(X2(:,1), X2(:,2), 'r.');
    axis([X_min X_max Y_min Y_max]);

    % randomly assign the network weights
    W = rand(3,1);

    % plot the classifier
    x = X_min:0.1:X_max;
    y = -(W(3)+W(1)*x)/W(2);
    plot(x,y,'g.');
    drawnow;
    
    % enable Start Button
    set(handles.btnStart, 'Enable', 'On');

function txtLearningRate_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtLearningRate_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtMomentumRate_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtMomentumRate_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

% --- Executes on button press in btnStart.
function btnStart_Callback(hObject, eventdata, handles)
    set(handles.btnStart, 'Enable', 'Off');
    
    global X1 X2 W N X_max X_min Y_max Y_min;

    % get the sample patterns and targets
    Y = [zeros(N,1); ones(N,1)];
    X = [X1; X2];
    X = [X ones(2*N,1)];
    
    % get learning rate and momentum rate
    learningRate = get(handles.txtLearningRate,'String');
    learningRate = str2double(learningRate);
    momentumRate = get(handles.txtMomentumRate,'String');
    momentumRate = str2double(momentumRate);
    nEpochs = get(handles.txtNumEpochs,'String');
    nEpochs =  floor(str2num(nEpochs));

    % display the learning progress
    W_momentum = 0;
    axes(handles.axesPlot);
    for i = 1:nEpochs
        idx = randperm(2*N);
        X = X(idx,:);
        Y = Y(idx,:);
        for j = 1:N*2
            % caculate W
            Y_hat = 1/(1+exp(-X(j,:)*W));
            error = Y(j,:) - Y_hat;
           % W_delta = error * Y_hat * (1-Y_hat);
           W_delta = error;
            W_momentum = learningRate * (X(j,:)' * W_delta + momentumRate * W_momentum);
            W = W + W_momentum;
        end;

        % plot sample points
        hold off;
        plot(X1(:,1), X1(:,2), 'b*');
        hold on;
        axis([X_min X_max Y_min Y_max]);
        plot(X2(:,1), X2(:,2), 'r.');

        % plot the classifier
        x = X_min:0.1:X_max;
        y = -(W(3)+W(1)*x)/W(2);
        plot(x,y,'g.');
        drawnow;
    end;
    % enable Start Button
    set(handles.btnReset, 'Enable', 'On');
    set(handles.btnStart, 'Enable', 'On');

function txtNumSamples_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtNumSamples_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;

function txtNumEpochs_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtNumEpochs_CreateFcn(hObject, eventdata, handles)
    if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
        set(hObject,'BackgroundColor','white');
    end;