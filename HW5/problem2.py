import networkx as nx
import matplotlib.pyplot as plt
import numpy as np

# Create a graph
G = nx.DiGraph()
#add edges
start_end=[(1, 3), (1, 4), (1, 7), (2, 3), (2, 5), (2, 8), (2, 9),
(3, 4), (3, 5), (4, 6), (5, 6), (6, 9), (6, 10)]
G.add_edges_from(start_end)

#get transistion matrix
A = nx.to_numpy_matrix(G)
