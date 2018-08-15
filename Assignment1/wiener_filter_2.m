% WIENER_FILTER_2 Filter a noisy image with Wiener filter, suppose we DO NOT know the power
% spectra of the noise and the undegraded image.
%
%   Y = WIENER_FILTER_2(X,H,K) filters a noisy image X with Wiener filter. H defines
%   the degradation function and K is a constant to approximate the ratio of the power
%   spectrum of the noise image to the power spectrum of the undegraded image.
%
function Im = wiener_filter_2(NoisyIm, H, K)

% Check if the noisy image is grayscale and of uint8 datatype.
assert_grayscale_image(NoisyIm);
assert_uint8_image(NoisyIm);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 5:
% Filter the noisy image with Wiener filter, suppose we do not know the power
% spectra of the noise (Sn) and the undegraded image (Sf).  We use a
% constant K to estimate the ratio of Sn to Sf.
%
% Im = ?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
box=fft2(NoisyIm);
%box=fftshift(box);
Im=((1./H).*(conj(H).*H)./(conj(H).*H+K)).*box;
Im=ifft2(Im);
% Convert the image to uint8 datatype.
Im = uint8(Im);