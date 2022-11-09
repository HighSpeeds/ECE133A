using PyPlot
include("logistic_fit.jl")

t,y=logistic_fit()

A=ones(length(t),2)
A[:,1]=t
b=log.(y./(ones(length(t)).-y))

x=A\b
println(x)
println(x[1].*t)
println(x[2])
t1=LinRange(0,5,50)
y1=exp.(x[2].+(x[1].*t))./(1+exp.(x[2].+(x[1]*t)))

plot(t,y,"o",label="data")
plot(t,y1,label="fit")
xlabel("t")
ylabel("y")
title("Logistic Fit")
legend()
savefig("fig2.png")
close()


