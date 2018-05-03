pkg load signal;

# Signalsynthese
M = 5;
N = 1000;
x(1:M) = 100;
a = [1, -1, 1, -1, 1];

for n = M+1: N-1
  s = 0;
  for j = 1:M
    s += a(j) * x(n-j);
  end
  x(n) = s + randn(1,1)*5;
end

[y, e, w] = lms_revised(x, 0.8, M);

figure('Name', 'Signal / Filter Ausgabe [LMS_REVISED]');
subplot(211); 
plot(1:numel(x), x); hold on #Synthetisiertes Signal
plot(1:numel(y), y, 'Color', 'm'); #LMS Ausgabe
xlabel(["Signal (blau), LMS (pink, u=0.8, M=" num2str(M) ")"]);

subplot(212); 
plot(1:numel(a), a); hold on #Synthese-Koeffizienten
slice = w([1:M], N/2) #Vektor aus Koeffizientenmatrix an Stelle N/2 entnehmen
plot(1:M, slice, 'Color', 'r' ); #LMS-Koeffizienten
xlabel("Koeffizienten: Synthese (blau), LMS (rot)");

[y2, e2, w2] = nlms_mean_revised(x, 0.8, M);

figure('Name', 'Signal / Filter Ausgabe [NLMS_REVISED]');
subplot(211); 
plot(1:numel(x), x); hold on #Synthetisiertes Signal
plot(1:numel(y2), y2, 'Color', 'm'); #LMS Ausgabe
xlabel(["Signal (blau), NLMS (pink, u=0.8, M=" num2str(M) ")"]);

subplot(212); 
plot(1:numel(a), a); hold on #Synthese-Koeffizienten
slice2 = w2([1:M], N/2) #Vektor aus Koeffizientenmatrix an Stelle N/2 entnehmen
plot(1:M, slice2, 'Color', 'r' ); #NLMS-Koeffizienten
xlabel("Koeffizienten: Synthese (blau), NLMS (rot)");

[y3, e3, w3] = nlms_predecessor(x, 0.8, M);

figure('Name', 'Signal / Filter Ausgabe [NLMS_PREDECESSOR]');
subplot(211); 
plot(1:numel(x), x); hold on #Synthetisiertes Signal
plot(1:numel(y3), y3, 'Color', 'm'); #LMS Ausgabe
xlabel(["Signal (blau), NLMS_PREDECESSOR (pink, u=0.8, M=" num2str(M) ")"]);

subplot(212); 
plot(1:numel(a), a); hold on #Synthese-Koeffizienten
slice3 = w3([1:M], N/2) #Vektor aus Koeffizientenmatrix an Stelle N/2 entnehmen
plot(1:M, slice3, 'Color', 'r' ); #NLMS-Koeffizienten
xlabel("Koeffizienten: Synthese (blau), NLMS (rot)");

[y4, e4, w4] = nlms_predecessor(x, 0.8, M);

figure('Name', 'Signal / Filter Ausgabe [NLMS DIFF PRE]');
subplot(211); 
plot(1:numel(x), x); hold on #Synthetisiertes Signal
plot(1:numel(y4), y4, 'Color', 'm'); #LMS Ausgabe
xlabel(["Signal (blau), NLMS DIFF PRE (pink, u=0.8, M=" num2str(M) ")"]);

subplot(212); 
plot(1:numel(a), a); hold on #Synthese-Koeffizienten
slice4 = w4([1:M], N/2) #Vektor aus Koeffizientenmatrix an Stelle N/2 entnehmen
plot(1:M, slice4, 'Color', 'r' ); #NLMS-Koeffizienten
xlabel("Koeffizienten: Synthese (blau), NLMS (rot)");