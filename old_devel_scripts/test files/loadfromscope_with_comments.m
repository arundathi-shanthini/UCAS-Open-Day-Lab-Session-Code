%% Connect to the instrument

% Find a VISA-USB object.
obj1 = instrfind('Type', 'visa-usb');

% Set input buffer size
obj1.InputBufferSize= 2500;

% Connect to instrument object, obj1.
fopen(obj1);

%% Communicating with instrument object, obj1.
%%% Read the data

% Request binary data on the CURVE query
fprintf(obj1,'DATA:ENCDG RIBinary'); 
% Request 8 bit data on the CURVE query
fprintf(obj1,'DATa:WIDth 1'); 
% Set channel 1 as source
fprintf(obj1, 'DATA:SOUR CH1'); 
% Get curve
fprintf(obj1, 'CURVE?'); 

% Read the first character
X=fscanf(obj1,'%c',1); 
% Read the second character returned
N=str2double(fscanf(obj1,'%c',1)); 
 % Number of data points
Nt=str2num(fscanf(obj1,'%c',N));
% Read the data (Y-axis)
data=fread(obj1,Nt,'int8');

% Query the vertical scale factor
dy=str2num(query(obj1,'WFMPre:YMULT?')); 
% Query the vertical units
unit = query(obj1,'WFMPre:YUNIT?'); 
% Query the horizontal sampling interval
dt=str2num(query(obj1,'WFMPre:XINcr?')); 

%% Disconnect from the instrument

% Close the instrument object, obj1
fclose(obj1); 

%Data=[time(:),dy*data(:)];

%% Plotting the signal and spectrogram

% Sampling frequency 
Fs= 1/dt; 
% Define the x-axis
time=[0:Nt-1].*dt; 

Twin=128; % Define time window
Ndelay=ceil(Nt/Twin); % Divide number of points by the time window size 
datapad=zeros(1,Twin*Ndelay); % Define data array as 
datapad(1:Nt)=data;
datamat=reshape(datapad,Twin,Ndelay);

Spectrogram=20*log10(abs(fft(datamat,[],1)));
ff=[0:Twin/2-1]*Fs/Twin;
tt=[0:Ndelay-1]*dt*Twin;

% Plot the Spectrogram
figure(1),subplot(211),pcolor(tt,ff,Spectrogram(1:Twin/2,:))
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Spectrogram')

% Plot the signal
subplot(212),plot(time,data)
xlabel('Time (s)')
ylabel('Amplitude (V)')


% figure(1)
% plot(time,dy*data),grid
% ylabel(['Amplitude (' unit(2:end-2) ')'])
% xlabel('Time (s)')