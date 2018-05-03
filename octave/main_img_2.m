pkg load image;

#Signal aus Bild
[file,img_path] = uigetfile({'*.png'; '*.jpg' }, "Bitte Bilddatei auswaehlen.");
if img_path
  figure('Name', 'Graustufenbild, NLMS_MEAN, NLMS_PREDECESSOR & LMS im Vergleich')
  
  [signal, gray] = signal_from_image(strcat(img_path, file));
  subplot(131), subimage(gray), xlabel("Graustufenbild");
  rows = size(gray, 1)
  columns = size(gray, 2)
  
  signal = cast(signal, "double");
%  signal -= 127.5;
  
  u = 0.8;
  M = 2;
  
  [y, e, w] = nlms_mean_revised(signal, u, M);
  
%  y += 127.5;
  y(y>255) = 255; y(y<0) = 0;
  gen = reshape(y, rows, columns);
  gen = cast(gen, "uint8");
  subplot(132), subimage(gen), xlabel(["NLMS MEAN (u=" num2str(u) ", M=" num2str(M) ")"]);

  
  [y2, e2, w2] = lms_revised(signal, u, M);
%  y2 += 127.5;
  y2(y2>255) = 255; y2(y2<0) = 0;
  gen2 = reshape(y2, rows, columns);
  gen2 = cast(gen2, "uint8");
  subplot(133), subimage(gen2), xlabel(["LMS (u=" num2str(u) ", M=" num2str(M) ")"]);
  
  figure('Name', 'Graustufenbild & NLMS PREDECESSOR & NLMS DIFF PRE')
  
  subplot(131), subimage(gray), xlabel("Graustufenbild");
  
  [y3, e3, w3] = nlms_predecessor(signal, u, M);
  
%  y3 += 127.5;
  y3(y3>255) = 255; y3(y3<0) = 0;
  gen3 = reshape(y3, rows, columns);
  gen3 = cast(gen, "uint8");
  subplot(132), subimage(gen3), xlabel(["NLMS PREDECESSOR (u=" num2str(u) ", M=" num2str(M) ")"]);
  
  [y4, e4, w4] = nlms_diff_pre(signal, u, M);
  
%  y4 += 127.5;
  y4(y4>255) = 255; y4(y4<0) = 0;
  gen4 = reshape(y4, rows, columns);
  gen4 = cast(gen, "uint8");
  subplot(133), subimage(gen4), xlabel(["NLMS DIFF PRE (u=" num2str(u) ", M=" num2str(M) ")"]);
else
  error("Kein Bild ausgewaehlt.")
end