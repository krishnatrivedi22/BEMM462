# Load the igraph package
library(igraph)

# Create a data frame for edges (replace with your actual data)
edges <- data.frame(from=c("1", "1", "2", "3", "4", "5", "6", "7", "8", "9"),  
                    to=c("2", "3", "4", "5", "6", "7", "8", "9", "12", "12"),  
                    weight=c(500, 300, 700, 200, 100, 400, 600, 100, 300, 400))  # Example costs (replace with actual)

# Create the directed graph object from the data (ensure character vertex names)
g <- graph_from_data_frame(edges, directed=TRUE)

# Ensure that all influencers are represented as vertices (nodes)
V(g)$name  # Check the nodes (influencers)

# Plot the graph to visualize it
plot(g, vertex.label=V(g)$name, edge.label=E(g)$weight)

# Find the shortest path from Influencer 1 to Influencer 12
shortest_path <- shortest_paths(g, from="1", to="12", weights=E(g)$weight)

# Display the shortest path
print(shortest_path)

# Calculate the total cost of the shortest path
total_cost <- 0

# Loop through the shortest path and sum the weights of the edges between consecutive vertices
for (i in 1:(length(shortest_path$vpath[[1]]) - 1)) {
  # Get the edge between consecutive vertices
  from_vertex <- shortest_path$vpath[[1]][i]
  to_vertex <- shortest_path$vpath[[1]][i + 1]
  
  # Get the edge using igraph's .from() and .to() for edge selection
  edge_index <- E(g)[.from(from_vertex) & .to(to_vertex)]
  
  # Sum the weights of the edges
  total_cost <- total_cost + edge_index$weight
}

# Print the total cost of the shortest path
print(paste("Total Cost: ", total_cost))
