# Flask Application Module - Builds and runs our web application container
# This module creates a container from our Flask application code

# Terraform configuration for this module
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"   # Docker provider to manage containers and images
      version = "3.6.2"                # Specific version for consistency
    }
  }
}

# Build a custom Docker image from our Flask application code
# This compiles our app code into a runnable container image
resource "docker_image" "flask_app" {
  name         = "flask-app-image"                   # Name for our custom image
  build {
    context    = "${path.module}/../../app"          # Directory containing our app code
    dockerfile = "${path.module}/../../app/Dockerfile" # Instructions for building the image
  }
  # This will:
  # 1. Read the Dockerfile in the app/ directory
  # 2. Copy our Python code into the image
  # 3. Install dependencies from requirements.txt
  # 4. Set up the image to run our Flask app
}

# Create and start the Flask application container
resource "docker_container" "flask_app" {
  name  = "flask-app"                  # Container name (for identification)
  image = docker_image.flask_app.image_id # Use the custom image we built above

  # Connect this container to our network so it can talk to MySQL
  networks_advanced {
    name = var.network_name            # Join the same network as the database
  }

  # Expose the Flask application port
  ports {
    internal = 5000                    # Port inside container (Flask default)
    external = 5000                    # Port on host machine (where users connect)
  }
  # Users will access the app at http://localhost:5000
}
