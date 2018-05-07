function [y, e, a] = nlms_diff_pre(x, u, M)
  N = numel(x);
  a = zeros(M,N);
  y = zeros(1,N);
  for n = 2:N
    if M < n-2
      m = M;
    else		#Solange Anzahl(Werte betrachtet) < M ..
      m = n-2;	#.. muss M angepasst werden sonst: IndexOutOfBounds
    end
    y(n) = x(n-1); #Setze y[n] auf Vorgänger des aktuell betrachteten Signals
    for j = 1:m #Summe von j=1 bis M..
	  # .. zu y[n] den Signalwert x[n-1] abzueglich des relativen Vorängers x[n-j-1]
	  # addieren und mit dem Koeffizienten a(j,n) gewichten
      y(n) += a(n)*(x(n - 1) - x(n - j - 1));
    end
    e(n) = x(n) - y(n); #Fehler als Different aus x[n] und y[n]
    absxn = 0; #||x[n]||^2 = ..
    for j = 1:m # .. Summe von j=1 bis M ..
	  #Differenzieller Bezug auf Vorgänger durch x[n-j] statt x[n-1]
      absxn += (x(n - j) - x(n - j - 1)).^2;
    end
	#Filterkoeffizienten nachfuehren
	for j = 1:m
		if absxn == 0 
			a(j,n + 1) = 1;
		else
			#Differenzieller Bezug auf Vorgänger durch x[n-j] statt x[n-1]
			a(n+1) = a(n) + u * e(n) * ((x(n - j) - x(n - j - 1)) / absxn);
		end
    end
  end
end