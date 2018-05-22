pkg load signal;
#graphics_toolkit("gnuplot");

# Signalsynthese
M = 1;
N = 1000;
x(1:M) = 1;
a = rand(1,M)-0.5; % random impulse response
a = a / sqrt(a * a'); % unit norm

for n = M+1: N
  s = 0;
  for j = 1:M
    s += a(j) * x(n-j);
  end
  x(n) = s + randn(1,1)*5;
end

hf = figure('Name', 'Generiertes Signal');
plot(1:numel(x), x); #Synthetisiertes Signal
xlabel(["Signal (M=" num2str(M) ")"]);

dtnow = datestr(now,'HH-MM-SS-FFF')

print (hf, ["gen/synthese_M-" num2str(M) "_N-" num2str(N) "_" dtnow ".pdf"], "-dpdfwrite");

dlmwrite(["gen/synthese_M-" num2str(M) "_N-" num2str(N) "_" dtnow ".txt"],x);
dlmwrite(["gen/koeffizienten_M-" num2str(M) "_N-" num2str(N) "_" dtnow ".txt"],a);