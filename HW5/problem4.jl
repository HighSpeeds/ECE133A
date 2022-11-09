
for k = [6,7,8]

    A=transpose([[1,1] [10.0^-k,0] [0,10.0^-k]])
    println(size(A))
    b=[-(10.0^-k),1+10.0^-k, 1-10.0^-k]
    println("k=",k)
    println("x=",A\b)
end