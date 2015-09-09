function varargout = train(varargin)
% TRAIN Application M-file for train.fig
%    FIG = TRAIN launch train GUI.
%    TRAIN('callback_name', ...) invoke the named callback.
% Last Modified by GUIDE v2.5 06-Jul-2005 12:37:02
    if nargin == 0  % LAUNCH GUI
        fig = openfig(mfilename,'reuse');
        set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));
        handles = guihandles(fig);
        guidata(fig, handles);

        % Set the initial parameter values
        set(handles.txtMomentumRate, 'String', num2str(0.9));
        set(handles.txtMaxNumerOfEpochs, 'String', num2str(200));
        set(handles.txtBestRMSE, 'String', num2str(0.001));
        set(handles.txtNumberOfValidations, 'String', num2str(0));
        set(handles.txtNumberOfTestData, 'String', num2str(0));    
        set(handles.txtHiddenLearningRate, 'String', num2str(0.1));
        set(handles.txtOutputLearningRate, 'String', num2str(0.1));    

        if nargout > 0
            varargout{1} = fig;
        end;
    elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK
        try
            if (nargout)
                [varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
            else
                feval(varargin{:}); % FEVAL switchyard
            end;
        catch
            disp(lasterr);
        end;
    end;


% --------------------------------------------------------------------
function varargout = btnLoadPattern_Callback(h, eventdata, handles, varargin)
    % Disable this button
    set(handles.btnLoadPattern, 'Enable', 'Off');

    % Ask the user to choose the pattern file for training
    [filename, pathname] = uigetfile({'*.mat';'*.*'}, 'Pick a pattern file');
    if (isequal(filename,0) | isequal(pathname,0))
        set(handles.btnLoadPattern, 'Enable', 'On');
        return;
    end

    % Load the pattern file
    global Vals Vecs Psii projected patterns Width Height;
    load([pathname filename]);
    [nInputSize, nPatternSize] = size(projected);
    Vals = Vals(1:nInputSize);
    patterns = projected ./ repmat(sqrt(Vals),1,nPatternSize);
    patterns = patterns';
    
    % Set the initial parameters of the net
    set(handles.txtNumberOfInputUnits, 'String', int2str(nInputSize));
    set(handles.txtNumberOfHiddenUnits, 'String', int2str(10));
    set(handles.txtNumerOfPatterns, 'String', int2str(nPatternSize));

    % Enable the "train" button and this button
    set(handles.btnTarget, 'Enable', 'On');
    clear Vals Vecs Psii projected patterns Width Height;


% --------------------------------------------------------------------
function varargout = btnTrain_Callback(h, eventdata, handles, varargin)
    global Vals net patterns targets Vecs Psii Width Height imgIdx;

    % Disable this button
    set(handles.btnTrain, 'Enable', 'Off');

    % Get the user's configuraton on the bp-net
    nInputUnits = str2num(get(handles.txtNumberOfInputUnits, 'String'));
    nHiddenUnits = str2num(get(handles.txtNumberOfHiddenUnits, 'String'));
    nOutputUnits = str2num(get(handles.txtNumberOfOutputUnits, 'String'));
    nPatterns = str2num(get(handles.txtNumerOfPatterns, 'String'));
    dHiddenUnitLearningRate = str2num(get(handles.txtHiddenLearningRate, 'String'));
    dOutputUnitLearningRate = str2num(get(handles.txtOutputLearningRate, 'String'));
    dMomentumRate = str2num(get(handles.txtMomentumRate, 'String'));
    nMaxEpochs = str2num(get(handles.txtMaxNumerOfEpochs, 'String'));
    dBestRMSE = str2num(get(handles.txtBestRMSE, 'String'));
    nValidationData = str2num(get(handles.txtNumberOfValidations, 'String'));
    nTestData = str2num(get(handles.txtNumberOfTestData, 'String'));

    % Do bp-net training for nMaxEpochs times, or until the best RMS has reached
    net = nnCreateNet(nInputUnits, nHiddenUnits, nOutputUnits, ...
        dHiddenUnitLearningRate, dOutputUnitLearningRate, dMomentumRate);    

    net = nnTrain(net, patterns, targets, nValidationData, nTestData, nMaxEpochs, dBestRMSE);

    % Plot the changes of RMSE on training data
    axes(handles.mapRMSE);    cla;
    hold on;
    plot(1:net.nEpoch, net.vRMSEonTrainingData(1:net.nEpoch), 'b');
    % Plot the changes of RMSE on validation data
    plot(1:net.nEpoch, net.vRMSEonValidationData(1:net.nEpoch),'k');
    % Plot the changes of RMSE on validation data
    plot(1:net.nEpoch, net.vRMSEonTestData(1:net.nEpoch),'r');
    legend('train','validation','test');
    hold off;
    
    net = nnFeedForward(net, patterns(imgIdx,:));
    
    % Show the reconstructed image from PCA projection
    axes(handles.mapOrig);
    cla;
    hold on;
    x = net.vInputs;
    x = x(1:nInputUnits);
    x = x.*sqrt(Vals)';
    img = Vecs*x' + Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis ij image off;
    hold off;
    
    % Show the reconstructed image from hidden layer activation
    axes(handles.mapReconstructed);
    cla;
    hold on;
    y = net.vHiddenUnits;
    x = nnFunnyTanh_Reverse(y,2);
    w = net.vHiddenUnitWeights;
    x = x*pinv(w);
    x = x(1:nInputUnits);
    x = x.*sqrt(Vals)';
    img = Vecs*x'; %+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis ij image off;
    hold off;
    
    clear Vals net patterns targets Vecs Psii Width Height imgIdx;

    % Enable this button and the "save" button
    guidata(gcbo, handles);
    set(handles.btnTrain, 'Enable', 'On');
    set(handles.btnSave, 'Enable', 'On');


% --------------------------------------------------------------------
function varargout = btnSave_Callback(h, eventdata, handles, varargin)

    % Disable this button
    set(handles.btnSave, 'Enable', 'Off');

    % Ask the user to choose the pattern file for training
    [filename, pathname] = uiputfile({'*.net';'*.*'}, 'Save a net file');
    if (isequal(filename,0) | isequal(pathname,0))
        set(handles.btnSave, 'Enable', 'On');
        return;    
    end;

    % Save the net
    global net;
    nnWriteNet(net, [pathname filename]);
    clear net;

    % Enable this button
    set(handles.btnSave, 'Enable', 'On');


% --- Executes on button press in btnTarget.
function btnTarget_Callback(hObject, eventdata, handles)
    global targets;
    
    % Disable this button
    set(handles.btnTarget, 'Enable', 'Off');

    % Ask the user to choose the pattern file for training
    [filename, pathname] = uigetfile({'*.txt';'*.*'}, 'Pick a target file');
    if (isequal(filename,0) | isequal(pathname,0))
        set(handles.btnTarget, 'Enable', 'On');
        return;
    end

    % Load the pattern file
    classes = load([pathname filename]);
    nOutputSize = max(classes);
    N = size(classes,1);
    targets = ones(N, nOutputSize)*(-1);
    for m = 1:N
        targets(m,classes(m)) = 1;
    end;
   
    % Set the initial parameters of the net
    set(handles.txtNumberOfOutputUnits, 'String', int2str(nOutputSize));

    % Enable the "train" button and this button
    set(handles.btnTrain, 'Enable', 'On');
    
    % set the slide bar
    set(handles.sliderImage, 'Min', 1);
    set(handles.sliderImage, 'Max', N);
    set(handles.btnTarget, 'Enable', 'On');

    clear targets;


% --- Executes on slider movement.
function sliderImage_Callback(hObject, eventdata, handles)
    global Vals net patterns Width Height Vecs Psii imgIdx;
    
    % get the class label
    imgIdx = get(handles.sliderImage, 'Value');
    imgIdx = floor(imgIdx);
    net = nnFeedForward(net, patterns(imgIdx,:));
    d = size(patterns,2);
    [ignore label] = max(net.vOutputs);
    if (net.nOutputUnits == 2)
        if (label == 1)
            class = 'female';
        else
            class = 'male';
        end;
    elseif (net.nOutputUnits == 7)
        if (label == 1)
            class = 'anger';
        elseif (label == 2)
            class = 'neutral';
        elseif (label == 3)
            class = 'surprise';
        elseif (label == 4)
            class = 'disgusted';
        elseif (label == 5)
            class = 'happy';
        elseif (label == 6)
            class = 'sad';
        elseif (label == 7)
            class = 'fear';
        end;
    else
        class = num2str(label);
    end;
    set(handles.txtLabel, 'String', class);
    
    % Show the reconstructed image from PCA projection
    axes(handles.mapOrig);
    cla;
    hold on;
    x = net.vInputs;
    x = x(1:d);
    x = x.*sqrt(Vals');
    img = Vecs*x' + Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis ij image off;
    hold off;
    
    % Show the reconstructed image from hidden layer activation
    axes(handles.mapReconstructed);
    cla;
    hold on;
    y = net.vHiddenUnits;
    x = nnFunnyTanh_Reverse(y,2);
    w = net.vHiddenUnitWeights;
    x = x*pinv(w);
    x = x(1:d);
    x = x.*sqrt(Vals');
    img = Vecs*x'; %+Psii;
    img = reshape(img, [Height Width]);
    imagesc(img);
    colormap(gray);
    axis ij image off;
    hold off;    
    
    clear Vals net patterns Width Height Vecs Psii imgIdx;

% --- Executes during object creation, after setting all properties.
function sliderImage_CreateFcn(hObject, eventdata, handles)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end;

function txtLabel_Callback(hObject, eventdata, handles)
% hObject    handle to txtLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtLabel as text
%        str2double(get(hObject,'String')) returns contents of txtLabel as a double


% --- Executes during object creation, after setting all properties.
function txtLabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtLabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end;