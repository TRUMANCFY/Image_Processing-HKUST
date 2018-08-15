function atrim=atrimmed_mean_filter(NoisyIm,d)

%the mask size is set to be 3x3
masksize=1;

NoisyIm = double(NoisyIm);
[sizeX, sizeY] = size(NoisyIm);

 % create a zero matrix with the same size of the input image
reformedimage(sizeX,sizeY)=zeros;

for i=1:sizeX;
    for j=1:sizeY;
        window=[];
        for m=-masksize:masksize;
            for n=-masksize:masksize;

% TODO:
% complete this for loop to apply the alpha trimmed mean filter
% pay attention to the range of the index
%
            if i+m>sizeX || i+m<1 || j+n>sizeY ||j+n<1
                window=[0 window];
            else window=[window NoisyIm(i+m,j+n)];
            end
            end
        end
        
        window_sort=sort(window);
        if mod(d,2) 
            d=d+1;
        end
        window_left=window_sort(1+d/2:9-d/2);
        reformedimage(i,j)=sum(window_left)/(9-d);

       
      
% TODO:
% complete this for loop to apply the alpha trimmed mean filter
%
%
% reformedimage(i,j)= ?
           
        
    end
end

atrim=uint8(reformedimage);