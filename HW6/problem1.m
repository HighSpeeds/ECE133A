load HW6/deblur.mat

function x=deblur(Y,B,lambda)
    %convert Y to column major order
    y = Y(:);
    %convert B to column major order
    b = B(:);
    %make the E matrix where all values are 0 except for 
    %the top left bottom left values
    %which are 1 and -1 respectively
    E=zeros(size(B));
    E(1,1)=1;
    E(end,1)=-1;
    %convert E to column major order
    e = E(:);
    %convert the transpose of E to column major order
    f = E'(:);
    
    n=size(B,1);

    fft_b=reshape( fft2( reshape( b, n, n ) ), n^2, 1);
    fft_e=reshape( fft2( reshape( e, n, n ) ), n^2, 1);
    fft_f=reshape( fft2( reshape( f, n, n ) ), n^2, 1);
    ifft_y=reshape( ifft2( reshape( y, n, n ) ), n^2, 1);

    z=(fft_b.*ifft_y)./(fft_b.*conj(fft_b)+lambda*(fft_e.*conj(fft_e)+fft_f.*conj(fft_f)));
    x=reshape( fft2( reshape( z, n, n ) ), n^2, 1);
end

gcf=figure;
Lambdas=10.^(-6:-2);
x0=10;
y0=10;
width=500*2;
height=500*(length(Lambdas)+1)/2;
set(gcf,'position',[x0,y0,width,height])
subplot((length(Lambdas)+1)/2,2,1)
imshow(Y,[])
title('Original Image');
hold on
for i=1:length(Lambdas)
    i
    subplot((length(Lambdas)+1)/2,2,i+1);
    lambda=Lambdas(i)
    x=deblur(Y,B,lambda);
    imshow(reshape(x,1024,1024),[]);
    title(sprintf('lambda=%f',lambda));
end
print -dpng problem1.png
hold off

