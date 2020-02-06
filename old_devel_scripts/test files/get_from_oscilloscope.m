myScope = oscilloscope()
availableResources = getResources(myScope)
myScope.Resource = availableResources(1);

connect(myScope);
get(myScope);

% % Automatically configuring the instrument based on the input signal.
% autoSetup(myScope);
% 
% myScope.AcquisitionTime = 0.01;
% 
% myScope.WaveformLength = 2000;
% 
% myScope.TriggerMode = 'normal';
% 
% myScope.TriggerLevel = 0.1;
% 
% enableChannel(myScope, 'Channel1');
% 
% setVerticalCoupling (myScope, 'Channel1', 'AC');
% 
% setVerticalRange (myScope, 'Channel1', 5.0);

waveformArray = getWaveform(myScope, 'acquisition', true);

Fs= 1/dt;
spectrogram(waveformArray(:,2),100,0,100,Fs,'yaxis')

figure;

% Plot the spectrogram
subplot(211);
plot(waveformArray);
xlabel('Time (s)')
ylabel('Frequency (Hz)')
title('Spectrogram')

% Plot the waveform.
subplot(212)
plot(waveformArray);
xlabel('Time (s)')
ylabel('Amplitude (V)')


disconnect(myScope);
clear myScope;
