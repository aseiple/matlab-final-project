
function varargout = Spaceship(varargin)
% SPACESHIP MATLAB code for Spaceship.fig
%      SPACESHIP, by itself, creates a new SPACESHIP or raises the existing
%      singleton*.
%
%      H = SPACESHIP returns the handle to a new SPACESHIP or the handle to
%      the existing singleton*.
%
%      SPACESHIP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPACESHIP.M with the given input arguments.
%
%      SPACESHIP('Property','Value',...) creates a new SPACESHIP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Spaceship_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Spaceship_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
 
% Edit the above text to modify the response to help Spaceship
 
% Last Modified by GUIDE v2.5 30-Mar-2018 21:50:59
 
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Spaceship_OpeningFcn, ...
                   'gui_OutputFcn',  @Spaceship_OutputFcn, ...
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
 
 
% --- Executes just before Spaceship is made visible.
function Spaceship_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Spaceship (see VARARGIN)
 
% Choose default command line output for Spaceship
handles.output = hObject;
 
% Update handles structure
global ship;
global currentValue;

guidata(hObject, handles);
ship.row = 8;
ship.col = 1;
ship.speed = 1;
%Spaceship direction values are as follow
%0 is moving to the right
%1 is moving to the bottom
%2 is moving to the left
%3 is moving to the top
ship.direction = 0;
map = cell(16,25);
<<<<<<< HEAD
for i=1:16
    for j=1:25
        asteroidChance=rand;
        if asteroidChance <= .1
            map{i,j}='1';
        else
            map{i,j}='0';
        end
    end
end
map{8,1} = '!=>'
=======
map = num2cell(randi([0 1], 16,25));
currentValue = map{8,1};
map{8,1} = '!=>';
>>>>>>> 62303f938fef8006641052e43be051f73f320250
handles.map = map;
set(handles.uitable1,'Data',map);
guidata(hObject, handles);
% UIWAIT makes Spaceship wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Outputs from this function are returned to the command line.
function varargout = Spaceship_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Get default command line output from handles structure
varargout{1} = handles.output;
 
 
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global ship;
global currentValue;
global gameOver;
gameOver = true;
while gameOver
    get(gcf,'CurrentCharacter')
    switch get(gcf,'CurrentCharacter')
        case 'd'
            ship.direction = 0;
        case 'a'        
            ship.direction = 2;
        case 'w'
            ship.direction = 3;
        case 's'
        case 'q'
            ship.speed = ship.speed - 1;
        case 'e'
            ship.speed = ship.speed + 1;
    case 'd'
        ship.direction = 0;
    case 'a'        
        ship.direction = 2;
    case 'w'
        ship.direction = 3;
    case 's'
        ship.direction = 1;
        otherwise
    end
    if ship.direction == 0
        if ship.col ~= 25
            map = handles.map;
            hasCrashed = crashCheck(map,ship);
            if(~hasCrashed)
                map(ship.row,ship.col) = {'0'};
                map(ship.row,ship.col + 1) = {'!=>'};
                ship.col = ship.col + 1;
                handles.ship = ship;
                handles.map = map;
                set(handles.uitable1,'Data',map);
            end
        end
    end
    if ship.direction == 1
        if ship.row ~= 16
            map = handles.map;
            hasCrashed = crashCheck(map,ship);
            if(~hasCrashed)
                map(ship.row,ship.col) = {'0'};
                map(ship.row + 1,ship.col) = {'!=>'};
                ship.row = ship.row + 1;
                handles.ship = ship;
                handles.map = map;
                set(handles.uitable1,'Data',map);
            end
        end
    end
    if ship.direction == 2
        if ship.col ~= 1
            map = handles.map;
            if(~hasCrashed)
                map(ship.row,ship.col) = {'0'};
                map(ship.row,ship.col - 1) = {'!=>'};
                ship.col = ship.col - 1;
                handles.ship = ship;
                handles.map = map;
                set(handles.uitable1,'Data',map);    
            end
        end
    end
    if ship.direction == 3
        if ship.row ~= 1
            map = handles.map;
            if(~hasCrashed)
                map(ship.row,ship.col) = {'0'};
                map(ship.row - 1,ship.col) = {'!=>'};
                ship.row = ship.row - 1;
                handles.ship = ship;
                handles.map = map;
                set(handles.uitable1,'Data',map);
            end
        end
    end
    pause(1 / ship.speed);
end 
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
 
 
function edit1_Callback(hObject, eventdata, handles)
global ship
get(hObject,'String')
ship.speed = str2double(get(hObject,'String'));
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
 
 
% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function hit = crashCheck(map, ship)
    position = [ship.row,ship.col];
    
    if(isequal(map(position),'1'))
        hit = true;
        button = questdlg('Your spaceship has crashed! Would you like to play again?', 'You have crashed!', 'Yes', 'No', 'Yes');
        if strcmpi(button, 'Yes')
            newGame_Callback;
        else
            close(Spaceship.fig);
        end
    else
        hit = false;
    end
