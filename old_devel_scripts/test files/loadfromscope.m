 % Find a VISA-USB object.
obj1 = instrfind('Type', 'visa-usb');

obj1.InputBufferSize= 2500;
% Connect to instrument object, obj1.
fopen(obj1);

% Communicating with instrument object, obj1.
fprintf(obj1,'DATA:ENCDG RIBinary');
fprintf(obj1,'DATa:WIDth 1');
fprintf(obj1, 'DATA:SOUR CH1');
fprintf(obj1, 'CURVE?');
X=fscanf(obj1,'%c',1);
N=str2double(fscanf(obj1,'%c',1));
Nt=str2num(fscanf(obj1,'%c',N));
data=fread(obj1,Nt,'int8');

dy=str2num(query(obj1,'WFMPre:YMULT?'));
unit = query(obj1,'WFMPre:YUNIT?');
dt=str2num(query(obj1,'WFMPre:XINcr?'));
Fs= 1/dt;
time=[0:Nt-1].*dt;
fclose(obj1);

Data=[time(:),dy*data(:)];

Twin=128;
Ndelay=ceil(Nt/Twin);
datapad=zeros(1,Twin*Ndelay);
datapad(1:Nt)=data;
datamat=reshape(datapad,Twin,Ndelay);

Spectrogram=20*log10(abs(fft(datamat,[],1)));
ff=[0:Twin/2-1]*Fs/Twin;
tt=[0:Ndelay-1]*dt*Twin;

figure(1),subplot(211),pcolor(tt,ff,Spectrogram(1:Twin/2,:))

xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Spectrogram')

subplot(212),plot(time,data)
xlabel('Time (s)')
ylabel('Amplitude (V)')


% figure(1)
% plot(time,dy*data),grid
% ylabel(['Amplitude (' unit(2:end-2) ')'])
% xlabel('Time (s)')