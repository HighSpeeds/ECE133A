using LinearAlgebra

function n(T)
    n=zeros(length(T))
    for i in 1:length(T)
        t=T[i]
        n[i]=10*t*exp(-2*t)+exp(-t)-2
    end
    return n
end

function dn(T)
    dn=zeros(length(T))
    for i in 1:length(T)
        t=T[i]
        dn[i]=10*exp(-2*t)*(1-2*t)-exp(-t)
    end
    return dn
end

t_1=0
t_2=1

let T=[t_1,t_2]
    #newton's method 
    thresh=0.00001
    while norm(n(T))>thresh
        T=T.-n(T)./dn(T)
    end
    println(T)
    println(n(T).+[2,2])
end

function d2n(T)
    d2n=zeros(length(T))
    for i in 1:length(T)
        t=T[i]
        d2n[i]=exp(-2*t)*(exp(t)+40*t-40)
    end
    return d2n
end

let t_max=[0]
    thresh=0.00001
    while norm(dn(t_max))>thresh
        t_max=t_max.-dn(t_max)./d2n(t_max)
    end
    println("t_max=",t_max[1])
    println("n(t_max)=",n(t_max)[1]+2)
end