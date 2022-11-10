
for k = [6,7,8]

    A=transpose([[1,1] [10.0^-k,0] [0,10.0^-k]])
    b=[-(10.0^-k),1+10.0^-k, 1-10.0^-k]
    println("k=",k)
    println("x=",A\b)
    println("---------------------")
end

println("other way")

#try the other way with x = (A’*A) \ (A’*b)
for k = [6,7,8]

    A=transpose([[1,1] [10.0^-k,0] [0,10.0^-k]])
    b=[-(10.0^-k),1+10.0^-k, 1-10.0^-k]
    println("k=",k)
    println("x=",(A'*A) \ (A'*b))
    println("---------------------")
end