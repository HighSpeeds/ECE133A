using PyPlot

A=[[1. 1. 1. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.]
[0. 0. 0. 1. 1. 1. 1. 0. 0. 0. 0. 0. 0.]
[1. 0. 0. 1. 0. 0. 0. 1. 1. 0. 0. 0. 0.]
[0. 1. 0. 0. 0. 0. 0. 1. 0. 1. 0. 0. 0.]
[0. 0. 0. 0. 1. 0. 0. 0. 1. 0. 1. 0. 0.]
[0. 0. 0. 0. 0. 0. 0. 0. 0. 1. 1. 1. 1.]]
B=[[0. 0. 1. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0.]
[0. 0. 0. 0. 0. 1. 0. 0. 0. 0. 0. 0. 0.]
[0. 0. 0. 0. 0. 0. 1. 0. 0. 0. 0. 1. 0.]
[0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 0. 1.]]

#println(A)
#println(B)

A=vcat(hcat(transpose(A),zeros(size(A)[2],size(A)[1])),
hcat(zeros(size(A)[2],size(A)[1]),transpose(A)))

#println(size(A))

u2=transpose([[0] [0] [1] [1]])
v2=transpose([[0] [1] [1] [0]])
#println(size(u2))
b=vcat(transpose(B)*u2,transpose(B)*v2)
#println(size(transpose(B)*u2))
#println(size(b))

x=A\b
#println(x)
u=reshape(vcat(x[1:6],u2),(10))
v=reshape(vcat(x[7:12],v2),(10))

plot(u,v,"o")
axis("equal")
edges=[[ 1  3]
[ 1  4]
[ 1  7]
[ 2  3]
[ 2  5]
[ 2  8]
[ 2  9]
[ 3  4]
[ 3  5]
[ 4  6]
[ 5  6]
[ 6  9]
[ 6 10]]

for i=1:size(edges)[1]
    plot(u[edges[i,:]],v[edges[i,:]],"--",color="black")
end

savefig("fig1.png")
close()