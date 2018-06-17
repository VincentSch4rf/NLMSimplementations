function [signal, koeff] = read_synth_file()
  [file,file_path] = uigetfile({'*.txt'; '*.*' }, ['Bitte Signalmatrix-Datei auswaehlen.']);
  signal = dlmread(strcat(file_path, file));
  [file,file_path] = uigetfile({'*.txt'; '*.*' }, ['Bitte Koeffizienten-Datei auswaehlen.']);
  koeff = dlmread(strcat(file_path, file));
end