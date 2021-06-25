function varargout = C_123190059_Responsi(varargin)
% C_123190059_RESPONSI MATLAB code for C_123190059_Responsi.fig
%      C_123190059_RESPONSI, by itself, creates a new C_123190059_RESPONSI or raises the existing
%      singleton*.
%
%      H = C_123190059_RESPONSI returns the handle to a new C_123190059_RESPONSI or the handle to
%      the existing singleton*.
%
%      C_123190059_RESPONSI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in C_123190059_RESPONSI.M with the given input arguments.
%
%      C_123190059_RESPONSI('Property','Value',...) creates a new C_123190059_RESPONSI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before C_123190059_Responsi_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to C_123190059_Responsi_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help C_123190059_Responsi

% Last Modified by GUIDE v2.5 25-Jun-2021 19:08:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @C_123190059_Responsi_OpeningFcn, ...
                   'gui_OutputFcn',  @C_123190059_Responsi_OutputFcn, ...
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


% --- Executes just before C_123190059_Responsi is made visible.
function C_123190059_Responsi_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to C_123190059_Responsi (see VARARGIN)

% Choose default command line output for C_123190059_Responsi
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes C_123190059_Responsi wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = C_123190059_Responsi_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in view.
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Data_Rumah.xlsx');
opts.SelectedVariableNames = (1:7);
data = readmatrix('Data_Rumah.xlsx', opts);
set(handles.tableData,'data',data,'visible','on'); %membaca file Data_Rumah.xlsx dan menampilkan pada tabel GUI


% --- Executes on button press in result.
function result_Callback(hObject, eventdata, handles)
% hObject    handle to result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Data_Rumah.xlsx'); %mengimport file Data_Rumah.xlsx
opts.SelectedVariableNames = (2:7);
data = readmatrix('Data_Rumah.xlsx', opts); %membaca file Data_Rumah.xlsx

k=[0,1,1,1,1,1]; %benefit dan cost
w=[0.3,0.2,0.23,0.1,0.07,0.1]; %bobot kriteria
[m n]=size (data);
R=zeros (m,n); %membuat matriks R
Y=zeros (m,n); %membuat matriks Y

for j=1:n,
    if k(j)==1, %untuk kriteria dengan atribut benefit
        R(:,j)=data(:,j)./max(data(:,j));
    else %untuk kriteria dengan atribut cost
        R(:,j)=min(data(:,j))./data(:,j);
    end;
end;
for i=1:m,
    V(i)= sum(w.*R(i,:)) %perhitungan nilai   
end;

opts = detectImportOptions('Data_Rumah.xlsx');
opts.SelectedVariableNames = (1);
temp = readmatrix('Data_Rumah.xlsx', opts);

xlswrite('sawResult.xlsx', temp, 'Sheet1', 'A1'); %menulis data pada file colom A1
V=V'; %merubah data hasil perhitungan dari matriks horizontal menjadi matriks vertikal
xlswrite('sawResult.xlsx', V, 'Sheet1', 'B1'); %menulis data pada file colom B1

opts = detectImportOptions('sawResult.xlsx');
opts.SelectedVariableNames = (1:2);
data = readmatrix('sawResult.xlsx', opts); %membaca file sawResult.xlsx

X=sortrows(data,2,'descend'); %mengurutkan data kolom kedua dari yang paling besar
X=X(1:20,1:2); %memilih 20 data teratas
set(handles.tableResult,'data',X,'visible','on'); %menampilkan data yang telah diurutkan ke tabel
