# Input variables for Flask Application Module
# These variables are passed from the main configuration

# Name of the Docker network to join
variable "network_name" {
  type = string                        # Text/string value expected
  # This connects the Flask container to the same network as MySQL
  # so the Flask app can communicate with the database by container name
}
