using LinearAlgebra

A=transpose([[-10, 10, 10] [0, 10, 0] [-10, 10, 0] [-20, -10, -10]])
rho=[17.7518, 9.6417, 14.3198, 24.9654]

M=zeros(3,3)
b=zeros(3)
# println(size(A))
for i=1:3
	# println(b)
	b[i]=rho[i].^2-rho[4].^2
	for j=1:3
		M[i,j]=2*(A[4,j]-A[i,j])
		b[i]+=A[4,j].^2-A[i,j].^2
	end
end

x=M\b
println(b)
print("x= ")
println(round.(x,digits=3))

for i=1:4
	println(norm(x-A[i,:]))
end