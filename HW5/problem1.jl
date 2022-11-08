using MAT
using LinearAlgebra
using PyPlot
# using Statistics

include("mooreslaw.m")
# println(T)
Years,Transistors=T[:,1],T[:,2]
# println(Years)
# println(Transistors)
A=transpose([reshape(ones(size(Years)),1,:);reshape(Years.-1970,1,:)])
# println(A)
log_Transistors=log10.(Transistors)
theta=A\log_Transistors
println("theta_1=",theta[1])
println("theta_2=",theta[2])
#plot out
plot(Years,log_Transistors,"o")
plot(Years,A*theta)
xlabel("Years")
ylabel("Transistors (log10)")
title("Moore's Law")
legend(["Data","Fit"])
savefig("Moore's Law.png")
close()

