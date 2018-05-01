function [y, e, a] = lms(x, u, M)
  N = numel(x);
  a = zeros(1,N);
  y = zeros(1,N);
  for k = 2:N
    if M < k-1
      m = M;
    else
      m = k-1;
    end
    for j = 1:m
      y(k) += a(k)*x(k-j);
    end
    e(k) = x(k) - y(k);
    absxn = 0;
    for j = 1:m
      absxn += x(k-j).^2;
    end
    a(k+1) = a(k) + u*e(k)*(x(k-j)/absxn);
  end
end