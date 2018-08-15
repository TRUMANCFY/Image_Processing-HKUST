% COMP4421_ASSIGN1 COMP4421 assignment 1 main routine.
%
function comp4421_assign1()

ImFileName = 'leaf.jpg';

% Read the grayscale image, check if it is a grayscale image of uint8
% datatype.
Im = imread(ImFileName);
Im=rgb2gray(Im);
assert_grayscale_image(Im);
assert_uint8_image(Im);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 1:
% Build gradient magnitude image.
% Please fill in code in "grad_mag_image.m" to accomplish function
% grad_mag_image
GMIm = grad_mag_image(Im);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Get the image size.
[sizeX sizeY] = size(Im);

sigma = 7;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 2:
% Generate additive Gaussian noise with the given sigma.
% You are required to complete the implementation in gen_gauss_noise.m.
GaussNoise = gen_gauss_noise(sizeX,sizeY,sigma);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Add Gaussian noise to the image.
GaussIm = add_noise(Im,GaussNoise);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 3:
% Filter the noisy image with arithmetic mean filter.
% You need to complete the implementation in arithmetic_mean_filter.m.
ArithIm = arithmetic_mean_filter(GaussIm);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Estimate the degradation function by image observation, suppose we use the
% observed subimage gs and the undegraded subimage fs for the estimation.
gs = GaussIm(158:226,164:241);
fs = Im(158:226,164:241);
H = estimate_degradation_func(gs,fs,sizeX,sizeY);

Sn = conj(fft2(GaussNoise)).*fft2(GaussNoise);
Sf = conj(fft2(Im)).*fft2(Im);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 4:
% Filter the noisy image with Wiener filter, suppose we know the power
% spectra of the noise Sn and the undegraded image Sf.
% You are required to complete the implementation in wiener_filter_1.m.
WienerIm1 = wiener_filter_1(GaussIm,H,Sn,Sf);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 5:
% Filter the noisy image with Wiener filter, suppose we DO NOT know the power
% spectra of the noise Sn and the undegraded image Sf.  We use a
% constant K to estimate the ratio of Sn to Sf.
% You are required to complete the implementation in wiener_filter_2.m.
K = 0.01;
WienerIm2 = wiener_filter_2(GaussIm,H,K);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 6:
% Emphasis the high frequency components of the images in the frequency
% domain by high frequency emphasis filter.By adjusting the two parameters
% a and b, we will receive different resultes.
% You will use the Butterworth filter in the high_freq_emphasis function, 
% you need to build a Butterworth filter in ButterWorth.m.
% The values of parameters are listed in the functions below.
% You are required to complete the implementation in high_freq_emphasis.m.
FEIm1=high_freq_emphasis(Im, 0.05, 0.3);
FEIm2=high_freq_emphasis(Im, 0.05, 0.7);
FEIm3=high_freq_emphasis(Im, 0.2, 0.3);
FEIm4=high_freq_emphasis(Im, 0.2, 0.7);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 7:
% Filter the noisy image with alpha-trimmed mean filter with different
% values of d (listed in the functions below).
% the size of mask should be set to 3x3
% You are required to complete the implementation in atrimmed_mean_fliter.m.
atrim1=atrimmed_mean_filter(GaussIm,2);
atrim2=atrimmed_mean_filter(GaussIm,4);
atrim3=atrimmed_mean_filter(GaussIm,6);
atrim4=atrimmed_mean_filter(GaussIm,8);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% show the result of part 1 to 5
figure;
subplot(2,3,1);imshow(Im);title('Original Image');
subplot(2,3,2);imshow(GMIm);title('Gradient magnitude image');
subplot(2,3,3);imshow(GaussNoise,[min(GaussNoise(:)) max(GaussNoise(:))]);title('Gaussian Noise');
subplot(2,3,4);imshow(ArithIm);title('Arithmetic Mean Filtered');
subplot(2,3,5);imshow(WienerIm1);title('Wiener Filtered 1');
subplot(2,3,6);imshow(WienerIm2);title('Wiener Filtered 2');

% show the result of part 6
figure;
subplot(2,2,1);imshow(FEIm1);
subplot(2,2,2);imshow(FEIm2);
subplot(2,2,3);imshow(FEIm3);
subplot(2,2,4);imshow(FEIm4);
suptitle('high frequency emphasis filter');

% show the reslut of part 7
figure;
subplot(2,2,1);imshow(atrim1);
subplot(2,2,2);imshow(atrim2);
subplot(2,2,3);imshow(atrim3);
subplot(2,2,4);imshow(atrim4);
suptitle('alpha trimmed mean filter');

disp('Done.');