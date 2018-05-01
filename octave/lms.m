function [y, e, w] = lms(x, u, M)
# lms adaptiert ein Signal, bei einem gegebenen Eingangssignal x,
# einer Lernrate u, sowie einer Filterordnung M
  N = numel(x);
  w = zeros(1,N);
  y = zeros(1,N);
  for k = 2:N
    if M < k-1
      m = M;
    else
      m = 1;
    end
    for j = 1:m
      y(k) += w(k)'*x(k-j);
    end
    e(k) = x(k) - y(k);
    absxn = 0;
    for j = 1:m
      absxn += x(k-j).^2;
    end
    w(k+1) = w(k) + u*e(k)*(x(k-j)/absxn);
  end
end