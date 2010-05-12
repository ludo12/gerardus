function z = coords_from_dist_gower(x, d)
% COORDS_FROM_DIST_GOWER  Compute point coordinates from distances to a set
% of landmarks, as described in Gower (1986)
%
% Z = COORDS_FROM_DIST_GOWER(X, D)
%
%   For 2D points, X is a (2, P)-matrix with the coordinates of P
%   landmarks. (Note that points can have any dimension.)
%
%   D is a P-vector with the distance of point Z to each of the landmarks.
%
%   Gower(1986) showed that the coordinates of Z can be computed from X and
%   D.
%
% J.C. Gower. Adding a point to vector diagrams in multivariate analysis.
% Biometrika, 55(3):582–585, 1968.

% Author: Ramon Casero <rcasero@gmail.com>
% Copyright © 2010 University of Oxford
% 
% University of Oxford means the Chancellor, Masters and Scholars of
% the University of Oxford, having an administrative office at
% Wellington Square, Oxford OX1 2JD, UK. 
%
% This file is part of Gerardus.
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details. The offer of this
% program under the terms of the License is subject to the License
% being interpreted in accordance with English Law and subject to any
% action against the University of Oxford being under the jurisdiction
% of the English Courts.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

% check arguments
error( nargchk( 2, 2, nargin, 'struct' ) );
error( nargoutchk( 0, 1, nargout, 'struct' ) );

if (length(d) ~= size(x, 2))
    error('There must be a distance value for each landmark')
end

% make sure distance vector is vertical
d = d';

% compute centroid of landmarks
xmean = mean(x, 2);

% center landmarks
x = x - xmean(:, ones(1, length(d)));

% compute point coordinates
z = xmean + .5 * pinv(x)' * ( sum(x.^2, 1) - d.^2 )';
