# UCAS-Open-Day-Lab-Session-Code

The file __`load_from_scope.m`__ contains the MATLAB code that allows acquisiton of data points as displayed on the screen from Rhode & Schwarz RTB-2004 Oscilloscope using SCPI commands.

The following [documentation](https://www.rohde-schwarz.com/webhelp/RTB_HTML_UserManual_en/Content/f04d8c7e15c9475d.htm) of remote control commands for R&S RTB Oscilloscopes was heavily used as reference to develop this file.

This script connects to the oscilloscope (R&S - RTB2004) fetches the signal. It then plots the signal in time domain and plots a spectrogram for it in the frequency domain.

___Developed for:__  
Department of ELectrical and Electronic Engineering  
University College London  
February 2020_
