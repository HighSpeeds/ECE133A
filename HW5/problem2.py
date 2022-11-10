import networkx as nx
import matplotlib.pyplot as plt
import numpy as np

# Create a graph
G = nx.Graph()
#add nodes
G.add_nodes_from([1,2,3,4,5,6,7,8,9,10])
#add edges
start_end=[(1, 3), (1, 4), (1, 7), (2, 3), (2, 5), (2, 8), (2, 9),
(3, 4), (3, 5), (4, 6), (5, 6), (6, 9), (6, 10)]
print(np.array(start_end))
for i in start_end:
    G.add_edge(i[0],i[1])

#get transistion matrix
C = nx.incidence_matrix(G).todense()
print(C)
u_2=np.array([0,0,1,1])
v_2=np.array([0,1,1,0])

B=C[-u_2.shape[0]:]
print(B)
print((B.T@u_2).shape)
b=np.concatenate((B.T@u_2,B.T@v_2)).reshape((-1,1))
print(b.shape)

A=C[:6]
print(A)
M=np.zeros((2*A.shape[1],2*A.shape[0]))
M[:A.shape[1],:A.shape[0]]=A.T
M[A.shape[1]:,A.shape[0]:]=A.T
print(M)
# print(M.shape)   
x=np.linalg.lstsq(M,-b)[0][:,0]
# print(x[:6])
# print(v_2.reshape((-1,1)).shape)
print(x.shape)
u=np.concatenate([x[:6],u_2])
v=np.concatenate([x[6:],v_2])
pos={}
for i in range(1,11):
    pos[i]=(u[i-1],v[i-1])
#plot graph
print(pos)
fig, ax = plt.subplots()
nx.draw(G,pos=pos, with_labels=True, ax=ax)
# plt.sca(ax)
# plt.xticks([-2,-1,0,1,2])
# plt.yticks([-2,-1,0,1,2])
# plt.grid()
plt.savefig("fig1.png")
plt.close()
