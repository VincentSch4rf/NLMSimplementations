pkg load signal;
#graphics_toolkit("gnuplot");

# Signalsynthese
[x, w] = read_synth_file();
M = 5#input ("M? ")
N = 1000#input ("N? ")

[y, e, a] = lms(x, 0.8, M);

figure('Name', 'Signal / Filter Ausgabe [LMS]');
set(gcf, 'Position', [  218 ,  299  , 803  , 660])
subplot(421); 
plot(1:numel(x), x); hold on #Synthetisiertes Signal
xlabel(["Synthetisiertes Signal (M=" num2str(M) ")"]);
subplot(423); 
plot(1:numel(y), y);#, 'Color', 'm'); #LMS Ausgabe
xlabel(["Filterausgabe (M=" num2str(M) ")"]);
subplot(425); 
plot(1:numel(e), e);#, 'Color', 'm'); #Fehlerrate
xlabel(["Filterfehler"]);

Schaetzfehler_Energie = 0;
for i = 1:N
  Schaetzfehler_Energie += (e(i) .^ 2);
end
Schaetzfehler_Energie /= N

a_sim = zeros(1,N);
for i=1:N
  q = a(i);
  v = norm(q - w(mod(i,M)+1));
  a_sim(i) = v;
end

subplot(427); 
plot(1:numel(a_sim), a_sim);#, 'Color', 'm'); #Fehlerrate
xlabel(["Abweichung der Koeffizienten"]);

Abweichungen_Energie = 0;
for i = 1:N
  Abweichungen_Energie += (a_sim(i) .^ 2);
end
Abweichungen_Energie /= N

#Bild
[file,img_path] = uigetfile({'*.png'; '*.jpg' }, "Bitte Bilddatei auswaehlen.");
[signal, gray] = signal_from_image(strcat(img_path, file));
signal = cast(signal, "double");
signal -= 127.5;
[y, e, a] = lms(signal, 0.8, M);

subplot(422); 
plot(1:N, signal(1:N)); hold on #Synthetisiertes Signal
xlabel(["Bildsignal"]);
subplot(424); 
plot(1:N, y(1:N));#, 'Color', 'm'); #LMS Ausgabe
xlabel(["Filterausgabe (M=" num2str(M) ")"]);
subplot(426); 
plot(1:N, e(1:N));#, 'Color', 'm'); #Fehlerrate
xlabel(["Filterfehler"]);

Schaetzfehler_Energie_Bild = 0;
for i = 1:N
  Schaetzfehler_Energie_Bild += (e(i) .^ 2);
end
Schaetzfehler_Energie_Bild /= N

[file,path,indx] = uiputfile('lms_ausgabe.pdf');
print (gcf, [path file], "-dpdfwrite");