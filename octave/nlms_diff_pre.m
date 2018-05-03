function [y, e, a] = nlms_diff_pre(x, u, M)
  N = numel(x);
  a = zeros(1,N);
  y = zeros(1,N);
  for k = 2:N
    if M < k-2
      m = M;
    else
      m = k-2;
    end
    y(k) = x(k-1);
    for j = 1:m
      y(k) += a(k)*(x(k-1)-x(k-j-1));
    end
    e(k) = x(k) - y(k);
    absxn = 0;
    for j = 1:m
      absxn += (x(k-j)-x(k-j-1)).^2;
    end
    if absxn == 0 absxn = 1; end
    for j = 1:m
      a(k+1) = a(k) + u*e(k)*((x(k-j)-x(k-j-1))/absxn);
    end
  end
end