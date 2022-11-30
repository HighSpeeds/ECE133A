using LinearAlgebra
using PyPlot

include("logistic_gn.jl")

function g(alpha,beta,t,y)
    # g= sum (y_i-e^(alpha*t_i+beta))/(1+e^(alpha*t_i+beta))^2

    g =zeros(length(t))
    for i in 1:length(t)
        g[i]= ((exp(alpha*t[i]+beta))/(1+exp(alpha*t[i]+beta)))-y[i]
    end
    return g
end

function Jacobian_g(alpha,beta,t,y)
    #dg/dalpha=-(2*t*((e^beta*y_i-e^beta)*e^(t*alpha)+y_i)*e^(t*alpha+beta))/(e^(t*alpha+beta)+1)^3
    #dg/dbeta=-(2*((e^(alpha*t)*y_i-e^(alpha*t))*e^beta+y_i)*e^(beta+alpha*t))/(e^(beta+alpha*t)+1)^3

    J = zeros(length(t),2)
    for i in 1:length(t)
        t_i=t[i]
        y_i=y[i]
        J[i,1] += (t_i*exp(t_i*alpha+beta))/(exp(t_i*alpha+beta)+1)^2
        J[i,2] += exp(beta+alpha*t_i)/(exp(beta+alpha*t_i)+1)^2
    end
    return J
end

function main()

    params=[0,0]

    for i=1:10
        #using newton's method to optimize g 
        alpha=params[1]
        beta=params[2]
        g_= g(alpha,beta,t,y)
        J= Jacobian_g(alpha,beta,t,y)
        # println(sum(J.*(g_\J)))
        params=params.-inv(J'*J)*(J'*g_)
        delta_g=2*(transpose(J)*g_)

        if norm(delta_g)<=1e-6
            break
        end
    end
    println("alpha=",params[1])
    println("beta=",params[2])
    plot(t,y,"o")
    plot(t,exp.(params[1]*t.+params[2])./(ones(length(t))+exp.(params[1]*t.+params[2])))
    savefig("test.png")
    close()
end

main()
