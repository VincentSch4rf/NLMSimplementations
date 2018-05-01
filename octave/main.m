check_packages;
[file,img_path] = uigetfile({'*.png'; '*.jpg' }, "Bitte Bilddatei auswaehlen.");

if img_path
  figure('Name', ['Graustufenbild von ' file]);
  
  #signal = sin([1:0.1:100]);
  #signal += randn(1,numel(signal)) * 0.1;
  [signal, gray] = signal_from_image(strcat(img_path, file));
  imshow(gray);
  rows = size(gray, 1)
  columns = size(gray, 2)
  
  signal = cast(signal, "double");
  signal -= 127.5;
  
  c = numel(signal);
  figure('Name', ['LMS von ' file ' mit d=x']);
  [y, e, w] = lms(signal, 0.99, d, 5);
  subplot(221);
  plot(1:c, signal);
  ylabel("Signal");
  subplot(222);
  plot(1:c, y);
  ylabel("Filter-Ausgabe");
  subplot(223);
  plot(1:c, e);
  ylabel("Fehler");
  subplot(224);
  w(401) = [];
  plot(1:c, w);
  ylabel("Koeffizienten");
  
  figure('Name', 'Bild aus Filter-Ausgabe');
  y += 127.5;
  y(y>255) = 255; y(y<0) = 0;
  gen = reshape(y, rows, columns);
  gen = cast(gen, "uint8");
  imshow(gen);  
else
  error("Kein Bild ausgewaehlt.")
end