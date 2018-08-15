% ARITHMETIC_MEAN_FILTER Filter a noisy image with an arithmetic mean filter.
%
%   Y = ARITHMETIC_MEAN_FILTER(X) filters a noisy image X with an arithmetic mean filter.
%   A 3-by-3 window is used in the filtering process.
%
function Im = arithmetic_mean_filter(NoisyIm)

% Check if the noisy image is grayscale and of uint8 datatype.
assert_grayscale_image(NoisyIm);
assert_uint8_image(NoisyIm);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 3:
% Filter the noisy image with arithmetic mean filter.  Use a 3x3 window to
% filter the image.
%
% Im = ?
h=ones(3,3)/9;
NoisyIm=double(NoisyIm);
Im=imfilter(NoisyIm,h);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rescale the grayscale values of the filtered image to 0-255 and convert
% the image to uint8 datatype.
Im = (Im-min(Im(:)))./(max(Im(:))-min(Im(:))).*255;
Im = uint8(Im);