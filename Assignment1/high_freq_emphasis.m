function FEIm=high_freq_emphasis(Im, a,b)

% TODO:
% Emphasis the high frequency components of the images in the frequency domain.
% You will use the Butterworth filter in the high_freq_emphasis function, 
% you need to build a Butterworth filter in ButterWorth.m.
% 
% e.g.:
% H=ButterWorth([m, n], 0.2, 1); 
% The size of ButterWorth filter equal to the size of input image, 
% The cutoff frequency is 0.2.
% The order is 1.
Im=double(Im);
Imf=fft2(Im);
Imf=fftshift(Imf);
[m,n]=size(Imf);
Hb=ButterWorth([m,n],0.2,1);
I=ones(m,n);
H=a+b*(I-Hb);
FEImF=H.*Imf;
FEIm=abs(ifft2(FEImF));
FEIm=uint8(FEIm);

