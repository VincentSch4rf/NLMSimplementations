function [y, e, a] = lms(x, u, M)
  N = numel(x); # N = Anzahl Werte des Signals
  a = zeros(1,N); #Koeffizientenvektor a..
  y = zeros(1,N); # ..und Ausgabe y mit Nullen initialisieren
  y(1) = x(1); #Erster Wert von x wird uebernommen
  for n = 2:N #Fuer jeden Wert des Signals x...
    if M < n-1
      m = M;
    else       #Solange Anzahl(Werte betrachtet) < M..
      m = n-1; # ..muss M angepasst werden sonst: IndexOutOfBounds
    end        
    for j = 1:m #Summe von j=1 bis M
      y(n) += a(n)*x(n-j); #zu y(n) den Koeffizienten a(n) * x(n-j) addieren
    end
    e(n) = x(n) - y(n); #Berechnung des Fehlers als Differenz von x(n) und y(n)
    absxn = 0; #||x[n]||^2 = ..
    for j = 1:m # ..Summe von j=1 bis M..
      absxn += x(n-j).^2; # ..von x[n-j]^2
    end
    #Naechsten Filterkoeffizienten nachgefuehrt berechnen
    # a[n+1] = a[n] + u * e[n] * (x[n-j] / ||x[n]||^2)
    a(n+1) = a(n) + u*e(n)*(x(n-j)/absxn);
  end
end