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

    z=(fft_b.*ifft_y)./(fft_b.^2+lambda*(fft_e.^2+fft_f.^2));
    x=reshape( ifft2( reshape( z, n, n ) ), n^2, 1)*n^2;
end

lambda=0.01;
x=deblur(Y,B,lambda);
imshow(reshape(x,size(B)[1],size(B)[2]),[])
print -dpng deblur.png

