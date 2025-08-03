# Main Terraform configuration file - this is where we define our infrastructure
# This file orchestrates all the components needed for our Flask + MySQL application

# Terraform block - specifies which providers (plugins) we need
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"  # Official Docker provider from Terraform Registry
      version = "3.6.2"              # Specific version to ensure compatibility
    }
  }
}

# Provider configuration - tells Terraform how to connect to Docker
# This enables Terraform to create and manage Docker resources
provider "docker" {}

# Module 1: Docker Network
# Creates an isolated network for our containers to communicate
module "docker_network" {
  source = "./modules/docker_network"  # Path to the network module code
}

# Module 2: MySQL Database
# Creates and configures the MySQL database container
module "mysql_db" {
  source           = "./modules/mysql_db"           # Path to MySQL module code
  db_root_password = var.db_root_password          # Pass root password from variables
  db_name          = var.db_name                   # Pass database name from variables
  db_user          = var.db_user                   # Pass application username from variables
  db_password      = var.db_password               # Pass application password from variables
  network_name     = module.docker_network.name    # Use network created by network module
}

# Module 3: Flask Application
# Creates and configures the Flask web application container
module "flask_app" {
  source       = "./modules/flask_app"              # Path to Flask module code
  network_name = module.docker_network.name        # Connect to same network as database
}
