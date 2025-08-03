# This file defines input variables that can be used throughout the Terraform configuration
# Variables allow us to make our configuration flexible and reusable
# Users can override these default values when running terraform commands

# Database root password - this is the main admin password for MySQL
variable "db_root_password" {
  type    = string                # This variable accepts text/string values
  default = "rootpass"           # Default value if user doesn't provide one
}

# Name of the database to create inside MySQL container
variable "db_name" {
  type    = string                # String type for database name
  default = "mylistdb"           # Our application will use this database
}

# Username for the application to connect to MySQL (not root user)
variable "db_user" {
  type    = string                # String type for username
  default = "admin"              # This user will have access to our database
}

# Password for the application user (db_user) to connect to MySQL
variable "db_password" {
  type    = string                # String type for password
  default = "password"           # Password for the 'admin' user
}
