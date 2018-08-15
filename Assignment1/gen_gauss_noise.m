% GEN_GAUSS_NOISE Generate additive Gaussian noise.
%
%   Y = GEN_GAUSS_NOISE(m,n,sigma) generates an additive Gaussian noise image of
%   size m-by-n with the standard deviation of the noise equals sigma.
%
function Noise = gen_gauss_noise(sizeX, sizeY, sigma)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO 2:
% Generate white Gaussian noise with the given sigma.
%
% Noise = ?

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ensure the noise is of double datatype.
Noise=normrnd(0,sigma,sizeX,sizeY);
assert_double_image(Noise);