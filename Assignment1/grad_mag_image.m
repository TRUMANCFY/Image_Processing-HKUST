% GRAD_MAG_IMAGE Compute a gradient magnitude image of the given image.
%
%   Y = GRAD_MAG_IMAGE(X) computes a gradient magnitude image of the image X.
%   Computation is based on the formula given in the lecture notes on image 
%   enhancement in spatial domain, pp.83.  The intensity values of the pixels 
%   that are out of the image boundary are treated as zeros.
%
%   REMINDER: The gradient magnitude image return should be in uint8 type.
%
function GMIm = grad_mag_image(Im)

assert_grayscale_image(Im);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 1: 
% Compute the gradient magnitude image.
% GMIm = ?;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Im=double(Im);
[m,n]=size(Im);
box=zeros(m+2,n+2);
%make box as a larger Im
for a=1:m
    for b=1:n
        box(a+1,b+1)=Im(a,b);
    end
end
GMIm=zeros(m,n);
%calculate GMIm
for i=1:m
    for j=1:n
        GMIm(i,j)=abs((box(i+2,j)+2*box(i+2,j+1)+box(i+2,j+2))-(box(i,j)+2*box(i,j+1)+box(i,j+2)))+...
            abs((box(i,j+2)+2*box(i+1,j+2)+box(i+2,j+2))-(box(i,j)+2*box(i+1,j)+box(i+2,j)));
    end
end
%GMIm=(GMIm-min(GMIm(:)))./(max(GMIm(:))-min(GMIm(:))).*255;
GMIm=uint8(GMIm);
assert_uint8_image(GMIm);






