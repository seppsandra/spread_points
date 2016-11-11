function [out,y,skatpoints]=splash(varargin)
%developped by Sandra 26.04.2016
%redevelopped 04.05.2016
%for convex polygon skatters a given number of points (in the same plane) almost uniformly
%(equal areas are likely to be filled with a nearly equal 
%number  of points. The larger the number of points, the more uniform it will look in 
%a  statistical sense.

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% octave-forge package Geometry is needed
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

%inputs
 %n an integer -the number ofpoints to be skatter
%polygon array of  vertex of a convex polygon
% r is the minimum distance admitted between points

%outputs y  %y=-1  missing polygon array
            %Y=0 polygon is not convex
            %y=1 skaterred points less then requested number
            %y=2 all skatered points meet the conditions require
            %out array of skattered points which meet the condition(minimum distance betweeen them r)
            %skatpoints=number of skatterd points which meet the condition of minimum distance r between them
 
 
 
 
 % check input
  n=varargin{1}
  n=str2num(n)
  if (isempty(varargin{1}))
  %ensure that all pending output is written to the screen before your prompt.
  fflush (stdout)
  n=input("input number of points to be skattered ( a positive integer )")
 while (! (floor(n)==abs(n))) || n<1
  n=input("input number of points to be skattered ( a positive integer )")
 endwhile
  endif
 %p=floor(n)
 
 if (! (floor(n)==abs(n))) || (n<1)
while (! (floor(n)==abs(n))) || n<1
  n=input("input number of points to be skattered ( a positive integer )")
 endwhile 
 
 endif
 
 
 
 % check input
  if isempty(varargin{2})
  error('need to specify a polygon');
 
 end

  

 

poligon=varargin{2}

clf
h = drawPolygon (poligon(:,1),poligon(:,2),"r")
hold on

%check the poligon to be convex
isConvex = checkConvex(poligon(:,1),poligon(:,2));
if !(isConvex==1)
hi=["skatter can't be done with this algo ,polygon not convex"]
h=msgbox(hi,Erorr,eror)
y=0
return
endif

% r is the minimum distance admitted between points
 r=varargin{3}
  r=str2num(r)
  if (isempty(varargin{3}))
     
  %ensure that all pending output is written to the screen before your prompt.
  fflush (stdout)
  r=input("input minimum distance between points ( a positive real number )")
 while ! r>0
  n=input("input minimum distance between points ( a positive real number )")
 endwhile
  endif
 





%vertex number of the poligon
polgrad=max(size(poligon))
%number of the triangles built from the first vertex
numtrian=polgrad-2;
%initialize areas an array of the double areas of the triangles built from the first vertex
areas=[];


%calculate double area for each triangle
for i=1:numtrian
a = abs(det([poligon(i+1,1:2)-poligon(1,1:2);poligon(i+2,1:2)-poligon(1,1:2)]));% Twice the triangles' areas
areas=[areas a];
end
%calculate the number of points in a trinagle  
%Equal areas are likely to be filled with a nearly equal number  of points. 
%pointsnumb is the vector of the number of points to be skattered on each triangle 
%built from the first vertex
pointsnumb=floor(n*areas(:)/sum(areas));
pointsnumb(numtrian)=pointsnumb(numtrian)+n-sum(pointsnumb);
%initialize the array of skattered points 
skat=[];
%in each triangle built from the first vertex skatter the number of points from pointsnumb
for k=2:polgrad-1
%triangles built from the first vertex
v=[poligon(1,:); poligon(k,:) ; poligon(k+1,:)];
%number of points for each triangle generated
q=pointsnumb(k-1);
%produce a set of points which are uniformly distributed inside the specified triangle:

[p]=nn0(q,v);
skat=[skat;p];
endfor
out=[];
check=[skat(1,1),skat(1,2)];
pp=skat(2:end,:);
w=size(pp,1);

while w>=3
 out=[out;check];
 d = distancePoints(check, pp);

 

 pp(find(d<r),:)=[];
%distance between all generated( skattered )points is minimum r
 if isempty(pp)==1
scatter(out(:,1),out(:,2),"b");
 %for i=1:size(out,1)
%drawCircle(out(i,1),out(i,2),r);

%endfor
skatpoints=size(out,1);
y=2
 return
 endif
 %delete points which don't respect required condition(minimum distance between them r)


check=[pp(1,1),pp(1,2)];
pp=pp(2:end,:);

w=size(pp,1);

endwhile

scatter(out(:,1),out(:,2),"r");
%for i=1:size(out,1)
%drawCircle(out(i,1),out(i,2),r);

%endfor
skatpoints=size(out,1);
y=1

endfunction