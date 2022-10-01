using MAT
#using Plots
using Random
using LinearAlgebra
using Statistics
using PyPlot
#using Distributions
#using Printf


function random_assign(data,n_clusters)
    n = size(data,2)
    assignments = rand(1:n_clusters,n)
    return assignments
end

function update_centroids(data,assignments,n_clusters)
    n = size(data,2)
    d = size(data,1)
    centroids = zeros(n_clusters,d)
    #println(size(centroids))
    for i = 1:n_clusters
	centroids[i,:] = transpose(mean(data[:,assignments .== i],dims=2))
    end
    # print(centroids[10,:],"\n")
    return centroids
end

function assign(data,centroids)
    n = size(data,2)
    #println("n=",n)
    n_clusters = size(centroids,1)
    #make an array
    assignments = zeros(Int64,n)
    for i = 1:n
	    #println(size(data[:,i]))
	    #println(size(centroids))
	    #println(size(transpose(centroids).-data[:,i]))
	    dists = mean((transpose(centroids).-data[:,i]).^2,dims=1)
	    #println(size(dists))
	    assignments[i]=argmin(dists)[2]
    end
    # println(unique!(assignments))
    #println(size(assignments))
    return assignments
end

function calculate_J(data,assignments,centroids)
    n = size(data,2)
    J = 0
    # println(size(assignments))
    for i = 1:n
        J += sum((data[:,i] .- centroids[assignments[i],:]).^2)
    end
    J=J/n
    return J
end

function main()
    file = matopen("mnist_train.mat")
    digits = read(file, "digits")[:,1:10000]
    #print(size(digits))
    close(file)
    println("loaded digits, running K-means")
    d = size(digits,1)
    n_clusters = 20
    assignments = random_assign(digits,n_clusters)
    centroids = zeros(n_clusters,d)
    J_change_threshold = 10^-5
    #print(J_change_threshold)
    J_old=Inf
    Js=Vector{Float64}()
    i=0
    while true
        #print("updating centroids\n")
        centroids = update_centroids(digits,assignments,n_clusters)
        #print("assigning\n")
        assignments = assign(digits,centroids)
        #print("calculating J\n")
        J=calculate_J(digits,assignments,centroids)
	#print("J=",J,"\n")
	#print("-----------------------\n")
        append!(Js,J)
        if abs(J-J_old)<=J*J_change_threshold
            break
        end
        J_old=J
	i+=1
    end
    println("achived a J of ", round(Js[length(Js)],digits=2), " after ", i, " iterations")
    #plot out Js
    plot(Js)
    savefig("Js.png")

    #plot out an image
    #println(size(reshape(centroids[1,:,:],(28,28))))
    fig=figure("testfig",figsize=(10,10))
    for i=1:n_clusters
	    subplot(5,4,i)
	    imshow(reshape(centroids[i,:,:],(28,28)))
    end
savefig("digits.png")
close(fig)
end

main()
