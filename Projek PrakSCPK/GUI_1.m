function varargout = GUI_1(varargin)
% GUI_1 MATLAB code for GUI_1.fig
%      GUI_1, by itself, creates a new GUI_1 or raises the existing
%      singleton*.
%
%      H = GUI_1 returns the handle to a new GUI_1 or the handle to
%      the existing singleton*.
%
%      GUI_1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_1.M with the given input arguments.
%
%      GUI_1('Property','Value',...) creates a new GUI_1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_1

% Last Modified by GUIDE v2.5 03-Jul-2021 19:18:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_1_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_1_OutputFcn, ...
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


% --- Executes just before GUI_1 is made visible.
function GUI_1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_1 (see VARARGIN)

% Choose default command line output for GUI_1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Lomba Masak.xlsx');
opts.SelectedVariableNames = (2:5);
data = readmatrix('Lomba Masak.xlsx', opts);

maksKerapian = 100;
maksRasa = 100;
maksGizi = 100;
maksVarian = 100;

data(:,1) = data(:,1) / maksKerapian;
data(:,2) = data(:,2) / maksRasa;
data(:,3) = data(:,3) / maksGizi;
data(:,4) = data(:,4) / maksVarian;

relasiAntarKriteria = [1 3 2 2 
                       0 1 3 2 
                       0 0 1 3 
                       0 0 0 1];
                      
                       
TFN = {[-100/3 0 100/3]     [3/100 0 -3/100]
       [0 100/3 200/3]      [3/200 3/100 0]
       [100/3 200/3 300/3]  [3/300 3/200 3/100]
       [200/3 300/3 400/3]  [3/400 3/300 3/200]};
   
[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria);

if RasioKonsistensi < 0.10
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);
    ahp = data * bobotAntarKriteria';
end

temp = {'Istimewa' 'Sangat Baik' 'Cukup Baik' 'Kurang Baik' 'Buruk' 'Busuk!!'};
for i = 1:size(ahp, 1)
    if ahp(i) >= 0.90
        kualitas(i) = temp(1);
    elseif ahp(i) >= 0.80 
        kualitas(i) = temp(2);
    elseif ahp(i) >= 0.70 
        kualitas(i) = temp(3);
    elseif ahp(i) >= 0.50 
        kualitas(i) = temp(4);
    elseif ahp(i) >= 0.35 
        kualitas(i) = temp(5);
    else
        kualitas(i) = temp(6);
    end
end


opts = detectImportOptions('Lomba Masak.xlsx');
opts.SelectedVariableNames = (1);
data = readmatrix('Lomba Masak.xlsx', opts);

opts2 = detectImportOptions('Lomba Masak.xlsx');
opts2.SelectedVariableNames = (6);
data2 = readmatrix('Lomba Masak.xlsx', opts2);

kualitas = kualitas';
xlswrite('Rangking.xlsx', data, 'Sheet1', 'A1');
xlswrite('Rangking.xlsx', data2, 'Sheet1', 'B1');
xlswrite('Rangking.xlsx', ahp, 'Sheet1', 'C1');
xlswrite('Rangking.xlsx', kualitas, 'Sheet1', 'D1');

data = readcell('Rangking.xlsx')
X=sortrows(data,3,'descend');
set(handles.tabelRanking,'data',X,'visible','on');

% --- Executes on button press in view.
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = readcell('Lomba Masak.xlsx');
set(handles.tabelData,'data',data,'visible','on');


% --- Executes on button press in back.
function back_Callback(hObject, eventdata, handles)
% hObject    handle to back (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
mainGUI;
close('GUI_1');
