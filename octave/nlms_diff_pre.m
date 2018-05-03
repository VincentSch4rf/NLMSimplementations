function [y, e, a] = nlms_diff_pre(x, u, M)
  N = numel(x);
  a = zeros(1,N);
  y = zeros(1,N);
  for k = 2:N
    if M < k-2
      m = M;
    else		#Solange Anzahl(Werte betrachtet) < M ..
      m = k-2;	#.. muss M angepasst werden sonst: IndexOutOfBounds
    end
    y(k) = x(k-1); #Setze y[n] auf Vorgänger des aktuell betrachteten Signals
    for j = 1:m #Summe von j=1 bis M..
	  # .. zu y[n] den Signalwert x[n-1] abzueglich des relativen Vorängers x[n-j-1]
	  # addieren und mit dem Koeffizienten a(j,k) gewichten
      y(k) += a(k)*(x(k - 1) - x(k - j - 1));
    end
    e(k) = x(k) - y(k); #Fehler als Different aus x[n] und y[n]
    absxn = 0; #||x[n]||^2 = ..
    for j = 1:m # .. Summe von j=1 bis M ..
	  #Differenzieller Bezug auf Vorgänger durch x[n-j] statt x[n-1]
      absxn += (x(k - j) - x(k - j - 1)).^2;
    end
	#Filterkoeffizienten nachfuehren
	for j = 1:m
		if absxn == 0 
			a(j,k + 1) = a(j,k); #Division furch 0 vermeiden
		else
			#Differenzieller Bezug auf Vorgänger durch x[n-j] statt x[n-1]
			a(k+1) = a(k) + u * e(k) * ((x(k - j) - x(k - j - 1)) / absxn);
		end
    end
  end
end