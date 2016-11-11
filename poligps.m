## Copyright (C) 2016 Admin
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {Function File} {@var{retval} =} poligps (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Admin <Admin@SANDRA>
## Created: 2016-09-28

function [skat] = poligps (poli)
param='+proj=latlong +datum=WGS84 ';
param=cstrcat(param);

x(:,1)=poli(:,1);
y(:,1)=poli(:,2);




[lon,lat] = _op_inv( x,y,param);
lon = lon*180/pi;
lat=lat*180/pi;
skat=[lon,lat];



endfunction
