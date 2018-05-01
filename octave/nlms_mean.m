function [y, e, a] = nlms_mean(x, u, M)
  N = numel(x);
  a = zeros(1,N);
  y = zeros(1,N);
  for k = 2:N
    if M < k-1
      m = M;
    else
      m = k-1;
    end
    xd(k) = 0;
    for j = 1:m
      xd(k) += x(k-j);
    end
    xd(k) /= m;
    for j = 1:m
      y(k) += a(k)*(x(k-j)-xd(k));
    end
    y(k) += xd(k);
    e(k) = x(k) - y(k);
    absxn = 0;
    for j = 1:m
      absxn += (x(k-j)-xd(k)).^2;
    end
    if absxn == 0 absxn = 1; end
    a(k+1) = a(k) + u*e(k)*((x(k-j)-xd(k))/absxn);
  end
end