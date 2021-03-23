function varargout = matplot_gui(varargin)
% MATPLOT_GUI MATLAB code for matplot_gui.fig
%      MATPLOT_GUI, by itself, creates a new MATPLOT_GUI or raises the existing
%      singleton*.
%
%      H = MATPLOT_GUI returns the handle to a new MATPLOT_GUI or the handle to
%      the existing singleton*.
%
%      MATPLOT_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MATPLOT_GUI.M with the given input arguments.
%
%      MATPLOT_GUI('Property','Value',...) creates a new MATPLOT_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before matplot_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to matplot_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help matplot_gui

% Last Modified by GUIDE v2.5 23-Mar-2021 15:58:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @matplot_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @matplot_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before matplot_gui is made visible.
function matplot_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to matplot_gui (see VARARGIN)

% Choose default command line output for matplot_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes matplot_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = matplot_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_path_Callback(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_path as text
%        str2double(get(hObject,'String')) returns contents of edit_path as a double


% --- Executes during object creation, after setting all properties.
function edit_path_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_show.
function pb_show_Callback(hObject, eventdata, handles)
% hObject    handle to pb_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.m_matpath = get(handles.edit_path,'String');
handles.m_pathfiles = what(handles.m_matpath);
if isempty(handles.m_pathfiles) || isempty(handles.m_matpath)
    selpathname = uigetdir();
else
    selpathname = uigetdir(handles.m_matpath);
end
if selpathname ~= 0
    handles.m_matpath = selpathname;
    set(handles.edit_path, 'String', selpathname);
    handles.m_pathfiles = what(selpathname);
end
set(handles.lb_mats, 'String', handles.m_pathfiles.mat);
guidata(hObject, handles);

% --- Executes on selection change in lb_mats.
function lb_mats_Callback(hObject, eventdata, handles)
% hObject    handle to lb_mats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lb_mats contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_mats


% --- Executes during object creation, after setting all properties.
function lb_mats_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_mats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_confirm.
function pb_confirm_Callback(hObject, eventdata, handles)
% hObject    handle to pb_confirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.lb_mats,'Value');
filename = handles.m_pathfiles.mat(val);
fullpath = [char(handles.m_matpath), '\', char(filename)];
[handles.messdaten handles.messdaten_name] = load_messdaten(fullpath);
set(handles.lb_matx, 'String', {handles.messdaten.X.Raster});
set(handles.lb_maty, 'String', {handles.messdaten.Y.Name});
guidata(hObject, handles);


% --- Executes on selection change in lb_matx.
function lb_matx_Callback(hObject, eventdata, handles)
% hObject    handle to lb_matx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lb_matx contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_matx


% --- Executes during object creation, after setting all properties.
function lb_matx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_matx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lb_maty.
function lb_maty_Callback(hObject, eventdata, handles)
% hObject    handle to lb_maty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lb_maty contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lb_maty


% --- Executes during object creation, after setting all properties.
function lb_maty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lb_maty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pb_plot.
function pb_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pb_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val_x = get(handles.lb_matx,'Value');
val_y = get(handles.lb_maty,'Value');
figure();
subplot(3,1,1);
plot(handles.messdaten.X(val_x).Data);
subplot(3,1,2);
plot(handles.messdaten.Y(val_y).Data);
subplot(3,1,3);
plot(handles.messdaten.X(val_x).Data,handles.messdaten.Y(val_y).Data);


% --- Executes on key press with focus on pb_show and none of its controls.
function pb_show_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pb_show (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pb_show.
function pb_show_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pb_show (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on lb_maty and none of its controls.
function lb_maty_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lb_maty (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key,'1')
    set(handles.lb_matx,'Value',get(handles.lb_maty,'Value'));
end


% --- Executes on key press with focus on lb_matx and none of its controls.
function lb_matx_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lb_matx (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key,'2')
    set(handles.lb_matx,'String',{});
    set(handles.lb_maty,'String',{});
end


% --- Executes on key press with focus on lb_mats and none of its controls.
function lb_mats_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lb_mats (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
if strcmp(eventdata.Key,'2')
    set(handles.lb_mats,'String',{});
end


% --- Executes on key press with focus on edit_path and none of its controls.
function edit_path_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_path (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
