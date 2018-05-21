pkg load signal;
#graphics_toolkit("gnuplot");

[file,file_path] = uigetfile({'*.txt'; '*.*' }, "Bitte Datendatei auswaehlen.");
x = dlmread(strcat(file_path, file));

figure('Name', 'Generiertes Signal');
plot(1:numel(x), x); #Synthetisiertes Signal
xlabel(["Signal (M=" num2str(M) ")"]);