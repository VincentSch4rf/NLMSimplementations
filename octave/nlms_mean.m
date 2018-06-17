function [y, e, a] = nlms_mean(x, u, M)
  N = numel(x); %N = Anzahl Werte des Signals
  a = zeros(M,N); %Koeffizientenmatrix a..
  y = zeros(1,N); % ..und Ausgabevektor y mit Nullen initialisieren
  y(1) = x(1); %Erster Wert von x wird uebernommen
  for n = 2:N %Fuer jeden Wert des Signals x...
    if M < n-1
      m = M;
    else       %Solange Anzahl(Werte betrachtet) < M..
      m = n-1; % ..muss M angepasst werden sonst: IndexOutOfBounds
    end
    
    xd(n) = 0; %Lokaler Mittelwert �x[n]= ..
    for j = 1:m % ..Summe von j=1 bis M von..
      xd(n) += x(n-j); % ..x[n-j]^2..
    end
    xd(n) /= m; % ..mal 1/M
    
    for j = 1:m %Summe von j=1 bis M..
      % ..zu y[n] den Koeffizienten a_j[n] * x[n-j] addieren..
      y(n) += a(j,n)*(x(n-j)-xd(n)); % ..abzueglich dem lokalen Mittelwert
    end
    y(n) += xd(n); %y[n] = �x[n] + Summe(...)
    
    e(n) = x(n) - y(n); %Fehler als Differenz aus x[n] und y[n]
    
    absxn = 0; %||x[n]||^2 = ..
    for j = 1:m % ..Summe von j=1 bis M..
      absxn += (x(n-j)- xd(n)).^2; % ..von (x[n-j] - �x[n])^2
    end
    %Naechste Filterkoeffizienten nachgefuehrt berechnen
    % a_j[n+1] = a_j[n] + u * e[n] * ((x[n-j] - �x[n]) / ||x[n]||^2)
    for j = 1:m
      if absxn == 0 %Division durch 0 vermeiden
        a(j,n+1) = 1;
      else
        a(j,n+1) = a(j,n) + u * e(n) * ((x(n-j) - xd(n)) / absxn);
      end
    end
  end
end