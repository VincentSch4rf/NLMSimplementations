function [e,a]=lms(x,u,M)
  xpre = zeros(length(x), 1);
  a = zeros(length(x), M);
  e = zeros(length(x), 1);
  for n=1:length(x)
    for j=1:M
      if j<n
        xpre(n) = a(j,n)*x(n-j);
      end
    end
    e(n) = x(n) - xpre(n);
    xsum = 0;
    for j=1:M
      if j<n
        xsum = xsum + x(n-j)^2;
      end
    end
    for j=1:M
      if j<n
        a(j,n+1) = a(j,n) + u * e(n) * (x(n-j)/xsum);
      end
    end
end