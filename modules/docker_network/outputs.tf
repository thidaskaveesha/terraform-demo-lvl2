# Output the network name so other modules can use it
# This allows other modules to connect their containers to this network
output "name" {
  value = docker_network.this.name     # Returns "flask_net" - the network name
  # Other modules will use this to join containers to the network
}
