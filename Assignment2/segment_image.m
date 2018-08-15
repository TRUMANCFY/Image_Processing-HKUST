% SEGMENT_PANDA contains the implementation of the main routine for Assignment 2. 
% This routine reads a image, which contains three intensity classes.
% The routine employs the Expectation-maximization method to estimate the parameters
% of the three intensity classes with a mixture of three Gaussian distributions, and
% segment the image with minimum error thresholds.
%  
function segment_image() 

% Define convergence threshold.
threshold = 0.01;

% Read the panda image and convert the color image into grayscale image.
Im = imread('sunset.jpg');
Im = rgb2gray(Im);
% Build a histgoram of the image, it is for the sake of
% parameter estimations and visualization.
%Im=double(Im);
Hist = imhist(Im,256)';
Hist=double(Hist);
%
% The Expectation-maximization algorithm.
%

% Initialize the paramters.
Weight = zeros(3,1);
Mu = zeros(3,1);
Sigma = zeros(3,1);
Weight(1) = 0.45;
Weight(2) = 0.35;
Weight(3) = 0.20;
Mu(1) = 5;
Mu(2) = 90;
Mu(3) = 230;
Sigma(1) = 1;
Sigma(2) = 10;
Sigma(3) = 20;

itn = 1;
while(1)

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% TODO_1: Estimate the expected posterior probabilities
    for z=1:256 %for each intensity
        Pz=0;
        for j=1:3
            Pz=Pz+Weight(j)*exp(-((z-1)-Mu(j))^2/(2*Sigma(j)^2))/(sqrt(2*pi)*Sigma(j));
        end
        for j=1:3
            posterior(j,z)=(Weight(j)*exp(-((z-1)-Mu(j))^2/(2*Sigma(j)^2))/((2*pi)^(1/2)*Sigma(j)))/Pz;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Allocate spaces for the parameters estimated.
	NewWeight = zeros(3,1);
	NewMu = zeros(3,1);
	NewSigma = zeros(3,1);
    
    % TODO_2: Estimate the parameters.
    NewMu_dn=posterior*Hist';
    
    NewMu_up=zeros(3,1);
    NewSigma_up=zeros(3,1);
    for i=1:256
        NewMu_up=NewMu_up+(i-1)*posterior(:,i)*Hist(i);
    end
    NewMu=NewMu_up./NewMu_dn;
    for i=1:256
        NewSigma_up=NewSigma_up+(i-1-NewMu).^2.*posterior(:,i)*Hist(i);
    end
    NewSigma=sqrt(NewSigma_up./NewMu_dn);
    NewWeight=NewMu_dn/sum(Hist);
%     
%     Im=double(Im);
%     [m,n]=size(Im);
%     NewMu_up=zeros(3,1);
%     NewMu_dn=zeros(3,1);
%     NewSigma_up=zeros(3,1);
%     for i=1:m
%         for j=1:n
%             NewMu_dn=NewMu_dn+posterior(:,Im(m,n));
%             NewMu_up=NewMu_up+Im(m,n)*posterior(:,Im(m,n));
%         end
%     end
%     NewMu=NewMu_up./NewMu_dn;
%     for i=1:m
%         for j=1:n
%             NewSigma_up=NewSigma_up+(Im(m,n)-NewMu).^2.*posterior(:,Im(m,n));
%         end
%     end
%     NewSigma=(NewSigma_up./NewMu_dn).^(1/2);
%     NewWeight=NewMu_dn/(m*n);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Check if convergence is reached.
	DiffWeight = abs(NewWeight-Weight)./Weight;
	DiffMu = abs(NewMu-Mu)./Mu;
	DiffSigma = abs(NewSigma-Sigma)./Sigma;
	
	if (max(DiffWeight) < threshold) & (max(DiffMu) < threshold) & (max(DiffSigma) < threshold)
        break;
	end
	
	% Update the parameters.
	Weight = NewWeight;
	Mu = NewMu;
	Sigma = NewSigma;
    
    disp(['Iteration #' num2str(itn)]);
    disp([' Weight: ' num2str(Weight(1)) ' ' num2str(Weight(2)) ' ' num2str(Weight(3))]);
    disp([' Mu: ' num2str(Mu(1)) ' ' num2str(Mu(2)) ' ' num2str(Mu(3))]);
    disp([' Sigma: ' num2str(Sigma(1)) ' ' num2str(Sigma(2)) ' ' num2str(Sigma(3))]);
    itn = itn + 1;
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO_3(a): Compute minimum error threshold between the first and the second
% Gaussian distributions.
%
% FirstThreshold = ?
syms x;
%eqn1=log(Weight(1)/(sqrt(2*pi)*Sigma(1)))*(-(x-Mu(1))^2/(2*Sigma(1)^2))==log(Weight(2)/(sqrt(2*pi)*Sigma(2)))*(-(x-Mu(2))^2/(2*Sigma(2)^2));
eqn1=Weight(1)*exp(-(x-Mu(1))^2/(2*Sigma(1)^2))/(sqrt(2*pi)*Sigma(1))==Weight(2)*exp(-(x-Mu(2))^2/(2*Sigma(2)^2))/(sqrt(2*pi)*Sigma(2));
X=solve(eqn1,x);
for i=1:2
    if X(i)>Mu(1)&&X(i)<Mu(2)
        FirstThreshold=X(i)
    end
end
FirstThreshold=(double(FirstThreshold))

 
% TODO_3(b): Compute minimum error threshold between the second and the third
% Gaussian distributions.
%
% SecondThreshold = ?
syms y;
%eqn2=log(Weight(3)/(sqrt(2*pi)*Sigma(3)))*(-(y-Mu(3))^2/(2*Sigma(3)^2))==log(Weight(2)/(sqrt(2*pi)*Sigma(2)))*(-(y-Mu(2))^2/(2*Sigma(2)^2));
eqn2=Weight(2)*exp(-(y-Mu(2))^2/(2*Sigma(2)^2))/(sqrt(2*pi)*Sigma(2))==Weight(3)*exp(-(y-Mu(3))^2/(2*Sigma(3)^2))/(sqrt(2*pi)*Sigma(3));
Y=solve(eqn2,y);
for i=1:2
    if Y(i)>Mu(2)&&Y(i)<Mu(3)
         SecondThreshold=Y(i)
    end
end
SecondThreshold=(double(SecondThreshold))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Show the segmentation results.
figure;
subplot(2,3,1);imshow(Im);title('Sunset')
subplot(2,3,3);imshow(Im<=FirstThreshold);title('First Intensity Class');
subplot(2,3,4);imshow(Im>FirstThreshold & Im<SecondThreshold);title('Second Intensity Class');
subplot(2,3,5);imshow(Im>=SecondThreshold);title('Third Intensity Class');
Params = zeros(9,1);
Params(1) = Weight(1);
Params(2) = Mu(1);
Params(3) = Sigma(1);
Params(4) = Weight(2);
Params(5) = Mu(2);
Params(6) = Sigma(2);
Params(7) = Weight(3);
Params(8) = Mu(3);
Params(9) = Sigma(3);
subplot(2,3,2);ggg(Params,Hist);