using PyPlot

function create_C(N)
    C = zeros(2,N)

    #make the first row of C 
    for i=1:N-1
        for j=1:N-i
            C[1,i]+=0.1*(0.95^(j-1))
        end
    end
    # C[1,N-1]=0.1 

    #make the second row of C 
    for i=1:N
        C[2,i] = 0.1*(0.95^(N-i))
    end
    return C
end

# calculate u
N=30
C = create_C(N)
d=[10,0]
u = C\d
s1=zeros(N+1)
s2=zeros(N+1)
for i=1:N
    s1[i+1]=s1[i]+s2[i]
    s2[i+1]=0.95*s2[i]+0.1*u[i]
end

fig,axs=subplots(3,1,figsize=(10,12))
axs[1].plot(s1)
axs[1][:set_title]("s1")
axs[2][:plot](s2)
axs[2][:set_title]("s2")
axs[3][:plot](u)
axs[3][:set_title]("u")
axs[3][:set_xlabel]("time")

savefig("problem2a.png")
close()

N=2:29
println(N)
E=zeros(length(N))
for i=1:length(N)
    C = create_C(N[i])
    d=[10,0]
    u = C\d
    E[i]=sum(u.^2)
end
plot(N,E)
xlabel("N")
ylabel("E")
yscale("log")
savefig("problem2b.png")
close()
