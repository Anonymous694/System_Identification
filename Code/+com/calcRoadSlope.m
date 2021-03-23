function [slope] = calcRoadSlope(TransMat)
O = [0,0,0];
A = [1,0,0];
B = [0,1,0];
AT = TransMat*A';
BT = TransMat*B';

% normal vector
NV_OAB   = cross(A-O,B-O);
NV_OATBT = cross(AT'-O,BT'-O);
slope = acos(dot(NV_OAB,NV_OATBT)/(norm(NV_OAB)*norm(NV_OATBT)));
end