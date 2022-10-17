t=[1,2,3,4,5]
y=[-1,12,10,1,-3]

A=zeros(5,5)

for i=1:5
    A[i,:]=[1,t[i],t[i]^2,-y[i]*t[i],-y[i]*t[i]^2]
end
print("theta= ")
println(round.(A\y,digits=3))