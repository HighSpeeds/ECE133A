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
    println(size(centroids))
    for i = 1:n_clusters
	centroids[i,:] = transpose(mean(data[:,assignments .== i],dims=2))
    end
    # print(centroids[10,:],"\n")
    return centroids
end

function assign(data,centroids)
    n = size(data,2)
    println("n=",n)
    n_clusters = size(centroids,1)
    #make an empty vector
    assignments = zeros(Int64,n)
    for i = 1:n
        min_dist = Inf
        for j = 1:n_clusters
            dist = norm(data[:,i] - centroids[j,:])
            if dist < min_dist
                min_dist = dist
                #append to assignments
                assignments[i] = j
            end
        end
    end
    # println(unique!(assignments))
    println(size(assignments))
    return assignments
end

function calculate_J(data,assignments,centroids)
    n = size(data,2)
    J = 0
    println(size(assignments))
    for i = 1:n
        J += sum((data[:,i] .- centroids[assignments[i],:]).^2)
    end
    J=J/n
    return J
end

function main()
    file = matopen("mnist_train.mat")
    digits = read(file, "digits")[:,1:10000]
    print(size(digits))
    close(file)

    d = size(digits,1)
    n_clusters = 20
    assignments = random_assign(digits,n_clusters)
    centroids = zeros(n_clusters,d)
    J_change_threshold = 10^-5
    print(J_change_threshold)
    J_old=Inf
    Js=Vector{Float64}()
    while true
        print("updating centroids\n")
        centroids = update_centroids(digits,assignments,n_clusters)
        print("assigning\n")
        assignments = assign(digits,centroids)
        print("calculating J\n")
        J=calculate_J(digits,assignments,centroids)
	print("J=",J,"\n")
	print("-----------------------\n")
        append!(Js,J)
        if abs(J-J_old)<=J*J_change_threshold
            break
        end
        J_old=J

    end

    #plot out Js
    plot(Js)
    savefig("Js.png")

    #plot out an image
    println(size(reshape(centroids[1,:,:],(28,28))))
    for i=1:n_clusters
	    fig=figure()
	    imshow(reshape(centroids[i,:,:],(28,28)))
	    savefig(string(i)*".png")
	    close(fig)
    end
end

main()
