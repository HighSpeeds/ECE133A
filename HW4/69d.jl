using FFTW
using PyPlot

function naive_calculation(a,b,n)
    A=hcat( [circshift(a,k) for k=0:n-1]...)
    x=A\b
    return x
end

function fast_method(a,b,n)
    a_w=fft(a)
    b_w=fft(b)
    x_w=a_w./b_w
    x=ifft(x_w)
    return x
end

function main()
    n=100
    a=rand(n)
    b=rand(n)
    n_runs=20
    
    sizes=LinRange(10,2500,n_runs)
    times_naive=zeros(length(sizes))
    times_fast=zeros(length(sizes))
    for i in 1:n_runs
        n=sizes[i]
        println("n=$n")
        time_naive=0
        time_fast=0
        n=round(Int,n)
        for j in 1:100
            a=rand(n)
            b=rand(n)
            time_naive+=@elapsed naive_calculation(a,b,n)
            time_fast+=@elapsed fast_method(a,b,n)
        end
        times_naive[i]=time_naive/100
        times_fast[i]=time_fast/100
    end
    plot(sizes,times_naive,label="naive")
    plot(sizes,times_fast,label="fast")
    legend()
    xlabel("n")
    ylabel("time")
    title("Time to solve Ax=b")
    savefig("HW4/69d.png")
    close("all")
    
end
main()
