S=[0,0,0,1,1,1,2,2,2]
T=[0,1,2,0,1,2,0,1,2]
Y=[4,0,5,7,4,9,0,3,4]
M=zeros(9,9)

for k in 1:9
    for i in 1:3
        for j in 1:3
            M[k,3*(i-1)+j]=S[k]^(i-1)*T[k]^(j-1)
        end
    end
end

println(M)
println(M\Y)