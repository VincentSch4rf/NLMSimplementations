pkg load signal;

# Signalsynthese
M = 50;
N = 1000;
x(1:M) = 100;
a = sin(2 * pi * [1:M] * 1/M);

axn = @(j) a(j) .* x(n-j);
for n = M+1: N-1
  x(n) = sum(axn([1:M])) + randn(1,1)*5;
end

figure('Name', 'Synthetisiertes Signal');
subplot(211); 
plot(1:numel(x), x);
ylabel("Signal");

subplot(212); 
plot(1:numel(a), a);
ylabel("Synthese Koeffizienten");

# NLMS
[y, e, w] = nlms_mean(x, 0.75, 2);
y(1) = 100; #Schoenerer Graph
figure('Name', 'NLMS Ausgabe');
subplot(211);
plot(1:numel(y), y);
ylabel("Filter Ausgabe");

subplot(212);
plot(1:numel(w), w);
ylabel("Filter Koeffizienten");

figure('Name', 'a <=> w/a');
subplot(211); 
plot(1:numel(a), a);
ylabel("Synthese Koeffizienten");

subplot(212);
plot(1:M, (w(M:2*M-1)./a([1:M])));
ylabel("Filter/Synthese Koeffizienten");