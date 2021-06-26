function varargout = Rumah_SAW_123190023(varargin)
% RUMAH_SAW_123190023 MATLAB code for Rumah_SAW_123190023.fig
%      RUMAH_SAW_123190023, by itself, creates a new RUMAH_SAW_123190023 or raises the existing
%      singleton*.
%
%      H = RUMAH_SAW_123190023 returns the handle to a new RUMAH_SAW_123190023 or the handle to
%      the existing singleton*.
%
%      RUMAH_SAW_123190023('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUMAH_SAW_123190023.M with the given input arguments.
%
%      RUMAH_SAW_123190023('Property','Value',...) creates a new RUMAH_SAW_123190023 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Rumah_SAW_123190023_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Rumah_SAW_123190023_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Rumah_SAW_123190023

% Last Modified by GUIDE v2.5 25-Jun-2021 23:11:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Rumah_SAW_123190023_OpeningFcn, ...
                   'gui_OutputFcn',  @Rumah_SAW_123190023_OutputFcn, ...
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


% --- Executes just before Rumah_SAW_123190023 is made visible.
function Rumah_SAW_123190023_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Rumah_SAW_123190023 (see VARARGIN)

% Choose default command line output for Rumah_SAW_123190023
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Rumah_SAW_123190023 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Rumah_SAW_123190023_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
global nomerRumah;
num = xlsread('DATA RUMAH.xlsx');%Import dari file excel
num(:,2)= [];%menghapus kolom 2

data = num(:,2:7);%menyimpan di variabel data kolom 2-7
nomerRumah = num(:,1);%menyimpan nomer rumah
set(handles.uitable1,'data',num);%menampilkan

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global data;
global nomerRumah;
k = [0,1,1,1,1,1];
w = [0.3, 0.2, 0.23, 0.1, 0.07, 0.1];

[m n]=size (data);
R=zeros (m,n);
%normalisasi data
for j=1:n
    if k(j)==1 %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=data(:,j)./max(data(:,j));
    else
        R(:,j)=min(data(:,j))./data(:,j);
    end
end
V = zeros(1,m);
%melakukan perangkingan, kolom pada baris dikali bobot
for i=1:m
    V(i)= sum(w.*R(i,:))
end

V = V.';%tranpose agar data ditulis kebawah

%Menggabungkan antara hasil dan nomer rumah
hasil = [nomerRumah V]; 
temp = zeros(1,2);

%Melakukan sorting
for i=1:m
   for j=i:m
      if hasil(i,2) < hasil(j,2)
          temp(1,1) = hasil(i,1);
          temp(1,2) = hasil(i,2);
          
          hasil(i,1)=hasil(j,1);
          hasil(i,2)=hasil(j,2);
          
          hasil(j,1)= temp(1,1);
          hasil(j,2)= temp(1,2);
      end
   end
end


%Diambil terbaik 20
hasil = hasil(1:20,:);
set(handles.uitable2,'data',hasil);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close('Rumah_SAW_123190023');
