# MySQL Database Module - Sets up the database container for our application
# This module creates a MySQL database that our Flask app will connect to

# Terraform configuration for this module
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"   # Docker provider to manage containers
      version = "3.6.2"                # Specific version for consistency
    }
  }
}

# Download the MySQL Docker image from Docker Hub
# This is like downloading the MySQL software before we can run it
resource "docker_image" "mysql" {
  name         = "mysql:8.0"           # Official MySQL version 8.0 image
  keep_locally = false                 # Delete image when Terraform destroys resources
}

# Create and start the MySQL database container
resource "docker_container" "mysql" {
  name  = "mysql-db"                   # Container name (other containers use this to connect)
  image = docker_image.mysql.image_id  # Use the image we downloaded above
  
  # Connect this container to our custom network
  networks_advanced {
    name = var.network_name            # Join the network created by network module
  }

  # Set environment variables to configure MySQL during startup
  env = [
    "MYSQL_ROOT_PASSWORD=${var.db_root_password}",  # Set root user password
    "MYSQL_DATABASE=${var.db_name}",                # Create this database automatically
    "MYSQL_USER=${var.db_user}",                    # Create this user automatically  
    "MYSQL_PASSWORD=${var.db_password}"             # Set password for the created user
  ]

  # Expose MySQL port so other containers can connect
  ports {
    internal = 3306                    # Port inside the container (MySQL default)
    external = 3306                    # Port on host machine (for external access)
  }
}
