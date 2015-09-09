function varargout = test(varargin)
% TEST Application M-file for test.fig
%    FIG = TEST launch test GUI.
%    TEST('callback_name', ...) invoke the named callback.

% Last Modified by GUIDE v2.0 05-Mar-2003 21:13:04

if nargin == 0  % LAUNCH GUI

	fig = openfig(mfilename,'reuse');

	% Use system color scheme for figure:
	set(fig,'Color',get(0,'defaultUicontrolBackgroundColor'));

	% Generate a structure of handles to pass to callbacks, and store it. 
	handles = guihandles(fig);
	guidata(fig, handles);

	if nargout > 0
		varargout{1} = fig;
	end

elseif ischar(varargin{1}) % INVOKE NAMED SUBFUNCTION OR CALLBACK

	try
		if (nargout)
			[varargout{1:nargout}] = feval(varargin{:}); % FEVAL switchyard
		else
			feval(varargin{:}); % FEVAL switchyard
		end
	catch
		disp(lasterr);
	end

end

% --------------------------------------------------------------------
function varargout = btnLoadNet_Callback(h, eventdata, handles, varargin)
% Disable this button
set(handles.btnLoadNet, 'Enable', 'Off');

% Ask the user to choose the pattern file for training
[filename, pathname] = uigetfile({'*.net';'*.*'}, 'Pick a net file');
if (isequal(filename,0) | isequal(pathname,0))
    set(handles.btnLoadNet, 'Enable', 'On');
    return;    
end

% Load the net
net = nnReadNet([pathname filename]);
set(handles.txtNumberOfInputUnits, 'String', int2str(net.nInputUnits));
set(handles.txtNumberOfOutputUnits, 'String', int2str(net.nOutputUnits));
set(handles.txtNumberOfHiddenUnits, 'String', int2str(net.nHiddenUnits));
handles = setfield(handles, 'net', net);
guidata(gcbo, handles);

% Load the PCA matrices
load './data/Vecs.mat';
load './data/Vals.mat';
load './data/Psii.mat';
load './data/meanProj.mat';
load './data/stdProj.mat';
handles = setfield(handles, 'Vecs', Vecs);
handles = setfield(handles, 'Vals', Vals);
handles = setfield(handles, 'Psii', Psii);
handles = setfield(handles, 'meanProj', meanProj);
handles = setfield(handles, 'stdProj', stdProj);
guidata(gcbo, handles);

% Guess this net's purpose
switch net.nOutputUnits
case 2
    set(handles.txtNetPurpose, 'String', 'Gender Classifier');
case 7
    set(handles.txtNetPurpose, 'String', 'Expression Classifier');
case 14
    set(handles.txtNetPurpose, 'String', 'Identity Classifier');
otherwise
    set(handles.txtNetPurpose, 'String', 'Unkown purpose');
end

% enable the load_image button
set(handles.btnLoadImage, 'Enable', 'On');
    

% --------------------------------------------------------------------
function varargout = btnLoadImage_Callback(h, eventdata, handles, varargin)
% Disable this button
set(handles.btnLoadImage, 'Enable', 'Off');

% Ask the user to choose the image to classify
[filename, pathname] = uigetfile({'*.pgm';'*.*'}, 'Pick a image file');
if (isequal(filename,0) | isequal(pathname,0))
    set(handles.btnLoadImage, 'Enable', 'On');
    return;    
end

% Load the image and display it
Img = pgmRead([pathname filename]);
load './data/Width.mat';
load './data/Height.mat';
Img = pgmResize(Img, Width, Height);
imagesc(Img);
colormap(gray);
daspect([1 1 1]);

% project this image to nInputUnits dimension vector
OrigImg = reshape(Img',Width*Height,1);
pattern = (handles.Vecs(:,1:handles.net.nInputUnits)'*(OrigImg - handles.Psii))';
pattern = (pattern - handles.meanProj')./handles.stdProj';

% calculate the output
handles.net = nnFeedForward(handles.net, pattern, zeros(1, handles.net.nOutputUnits));
class = 1;
for i=1:handles.net.nOutputUnits
    if (handles.net.vOutputs(1,class) < handles.net.vOutputs(1,i))
        class = i;
    end
end

% Display the result
if (handles.net.nOutputUnits == 2)
    switch class
    case 1
        set(handles.txtResult, 'String', 'Female');
    case 2
        set(handles.txtResult, 'String', 'Male');
    end
end
if (handles.net.nOutputUnits == 7)
    switch class
    case 1
        set(handles.txtResult, 'String', 'Angry');
    case 2
        set(handles.txtResult, 'String', 'Neutral');
    case 3
        set(handles.txtResult, 'String', 'Surprised');
    case 4
        set(handles.txtResult, 'String', 'Disgusted');
    case 5
        set(handles.txtResult, 'String', 'Happy');
    case 6
        set(handles.txtResult, 'String', 'Mirthless');
    case 7
        set(handles.txtResult, 'String', 'Frightened');
    end
end

if abs(handles.net.vOutputs(1,class)) < 0.1
    set(handles.txtResult, 'String', 'Hard to tell');
end;

% enable this button
set(handles.btnLoadImage, 'Enable', 'On');