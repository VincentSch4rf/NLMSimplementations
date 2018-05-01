#
# II. Funktionen zur Signalgenerierung
#   -> signal_from_image
#

function [signal, gray] = signal_from_image(path)
  printf("Lade Bild..\n");
  rgb_data = imread(path);
  if size(rgb_data) != 3
    error("'%s' enthaelt keine RGB Daten.", path);
  end
  
  gray_data = rgb2gray(rgb_data);
  signal = reshape(gray_data, 1, numel(gray_data));
  gray = gray_data;
end