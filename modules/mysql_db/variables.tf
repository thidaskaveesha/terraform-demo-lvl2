# Input variables for MySQL Database Module
# These variables are passed from the main configuration

# Root password for MySQL (super admin password)
variable "db_root_password" {
  type = string                        # Text/string value expected
  # This is the master password for MySQL root user
}

# Name of the database to create inside MySQL
variable "db_name" {
  type = string                        # Text/string value expected  
  # Our Flask application will use this database to store data
}

# Username for application to connect to database (not root)
variable "db_user" {
  type = string                        # Text/string value expected
  # This user will have permissions to access the application database
}

# Password for the application database user
variable "db_password" {
  type = string                        # Text/string value expected
  # Flask app will use this password to connect as db_user
}

# Name of the Docker network to join
variable "network_name" {
  type = string                        # Text/string value expected
  # This connects the MySQL container to the same network as Flask app
}
