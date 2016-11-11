function isConvex = checkConvex(px,py)
%This entry was posted in Computational Geometry and tagged concave, convex, geometry, matlab, polygon, regular by Vipul Lugade. 

% Given a set of points determine if they form a convex polygon
% Inputs 
%  px, py: x and y coordinates of the vertices for a given polygon

% Output 
%  isConvex: 1 or 0 for polygon being convex or concave

numPoints = size(px,1);
if numPoints < 4
    isConvex = 1;
    return
end

% can determine if the polygon is convex based on the direction the angles
% turn.  If all angles are the same direction, it is convex.
v1 = [px(1) - px(end), py(1) - py(end)];
v2 = [px(2) - px(1), py(2) - py(1)];
signPoly = sign(det([v1; v2]));
%We use the MATLAB built in function sign to see if the resultant determinant (ad – bc) is negative or positive. Now we check each subsequent vertex, with any vertex having a different sign for the oriented area signifying a vertex with an internal angle of > 180, or making the polynomial concave.

% check subsequent vertices
for k = 2:numPoints-1
    v1 = v2;
    v2 = [px(k+1) - px(k), py(k+1) - py(k)]; 
    curr_signPoly = sign(det([v1; v2]));
    % check that the sign matches the first vectors or is 0
    if curr_signPoly * signPoly < 0
        isConvex = 0;
        return
    end
end
% check the last vectors
v1 = v2;
v2 = [px(1) - px(end), py(1) - py(end)];
curr_signPoly = sign(det([v1; v2]));
if curr_signPoly * signPoly < 0
    isConvex = 0;
else
    isConvex = 1;
end
endfunction