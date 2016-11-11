function [p]=nn0(q,v)
 %This function produces a set of points which are uniformly distributed inside the specified triangle
 %Inputs
 % v= Triangle vertices, pairs of (x, y)
  % q=number of points for each triangle generated
 %outputs 
 %p=array of points coordonates uniformly distributed
  
  t = sqrt(rand(q, 1));
s = rand(q, 1);
p = (1 - t) * v(1, :) + bsxfun(@times, ((1 - s) * v(2, :) + s * v(3, :)), t);
%This will produce a set of points which are uniformly distributed inside the specified triangle:
[in on] = inpolygon (p(:,1), p(:,2), v(:,1),v(:,2));
inside = in & !on;


%scatter(p(:,1),p(:,2),"g")
%hold on

endfunction