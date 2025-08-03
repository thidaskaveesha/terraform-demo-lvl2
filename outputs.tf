# Output values - these are displayed after terraform apply completes
# Outputs show important information about the created infrastructure

# URL where users can access the Flask web application
output "flask_url" {
  value = "http://localhost:5000"    # The web app will be available at this address
}

# Name of the MySQL container that was created
output "mysql_container" {
  value = module.mysql_db.container_name    # Gets container name from mysql module
}

# Name of the Flask application container that was created
output "flask_container" {
  value = module.flask_app.container_name   # Gets container name from flask module
}

# Name of the Docker network that connects our containers
output "network_name" {
  value = module.docker_network.name        # Gets network name from network module
}

# Database connection information grouped together for easy reference
output "database_info" {
  value = {
    name = module.mysql_db.database_name    # Database name inside MySQL
    user = module.mysql_db.database_user    # Username for app to connect to DB
    port = module.mysql_db.mysql_port       # Port number MySQL is listening on
  }
}
