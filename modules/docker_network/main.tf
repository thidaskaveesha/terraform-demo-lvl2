# Docker Network Module - Creates an isolated network for container communication
# This module is responsible for setting up networking infrastructure

# Terraform configuration block for this module
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"    # Specify Docker provider
      version = "3.6.2"                # Lock to specific version for consistency
    }
  }
}

# Create a custom Docker network
# This network allows containers to communicate with each other by name
resource "docker_network" "this" {
  name = "flask_net"                   # Name of the network (containers will join this)
  # Docker will automatically:
  # - Assign IP range (e.g., 172.18.0.0/16)
  # - Create a bridge network
  # - Enable DNS resolution between containers
}
