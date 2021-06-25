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

% Last Modified by GUIDE v2.5 25-Jun-2021 18:21:46

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


% --- Executes on button press in procces.
function procces_Callback(hObject, eventdata, handles)
% hObject    handle to procces (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Real_Estate.xlsx'); %mengimport file xlsx
opts.SelectedVariableNames = (2:5);
data = readmatrix('Real_Estate.xlsx', opts); 

k=[0,0,1,0]; %benefit dan cost
w=[3,5,4,1]; %bobot masing2 kriteria

[m n]=size (data); %inisialisasi ukuran matriks
w=w./sum(w); %membagi bobot masing2 kriteria dengan jumlah total seluruh bobot

for j=1:n, %perhitungan vektor(S) per baris (alternatif)
    if k(j)==0, w(j)=-1*w(j);
    end;
end;
for i=1:m,
    S(i)=prod(data(i,:).^w);
end;

V= S/sum(S) %perhitungan nilai vektor V

opts = detectImportOptions('Real_Estate.xlsx');
opts.SelectedVariableNames = (1);
baru = readmatrix('Real_Estate.xlsx', opts);
xlswrite('wpResult.xlsx', baru, 'Sheet1', 'A1'); %menulis data pada file colom A1
V=V'; %merubah data hasil perhitungan dari matriks horizontal menjadi matriks vertikal
xlswrite('wpResult.xlsx', V, 'Sheet1', 'B1'); %menulis data pada file colom B1

opts = detectImportOptions('wpResult.xlsx');
opts.SelectedVariableNames = (1:2);
data = readmatrix('wpResult.xlsx', opts); %membaca file wpResult.xlsx

X=sortrows(data,2,'descend'); %mengurutkan kolom kedua dari data dengan nilai paling besar
set(handles.tableResult,'data',X,'visible','on'); %menampilkan data yang telah diurutkan pada tabel GUI

% --- Executes on button press in view.
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('Real_Estate.xlsx');%mengimport file xlsx
opts.SelectedVariableNames = (1:5);
data = readmatrix('Real_Estate.xlsx', opts);
set(handles.tableData,'data',data,'visible','on'); %membaca file Real_Estate.xlsx dan menampilkan data pada tabel GUI
