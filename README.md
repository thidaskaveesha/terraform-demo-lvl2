# Flask + MySQL Application with Terraform

## What This Project Does
This project creates a web application where users can add, view, and delete items from a list. The data is stored in a MySQL database, and everything runs in Docker containers managed by Terraform.

## Project Structure Explained

```
terraformAssignment/
├── main.tf              # Main configuration - orchestrates everything
├── variables.tf         # Input variables - configurable settings  
├── outputs.tf          # Output values - shows important info after deployment
├── terraform.tfstate   # Current state - Terraform's memory of what exists
├── app/                # Our Flask web application code
│   ├── app.py         # Main Python web application
│   ├── Dockerfile     # Instructions to build Flask container
│   ├── requirements.txt # Python packages needed
│   ├── config/        # Configuration files
│   └── templates/     # HTML templates for web pages
└── modules/           # Reusable Terraform modules
    ├── docker_network/  # Creates network for containers to communicate
    ├── mysql_db/       # Creates and configures MySQL database
    └── flask_app/      # Builds and runs Flask web application
```

## How The Architecture Works

1. **Docker Network Module** (`modules/docker_network/`)
   - Creates an isolated network called "flask_net"
   - Allows containers to talk to each other by name
   - Like creating a private network for our application

2. **MySQL Database Module** (`modules/mysql_db/`)
   - Downloads MySQL 8.0 image from Docker Hub
   - Creates database container named "mysql-db"
   - Sets up database, user accounts, and passwords
   - Connects to the shared network

3. **Flask Application Module** (`modules/flask_app/`)
   - Builds custom image from our Python code
   - Creates web server container named "flask-app"  
   - Connects to same network as database
   - Exposes port 5000 for web access

## What Each File Does

### Root Configuration Files

- **`main.tf`** - The orchestrator
  - Tells Terraform we need Docker provider
  - Calls all three modules in correct order
  - Passes variables between modules

- **`variables.tf`** - Configuration settings
  - Database passwords and names
  - User accounts and credentials
  - Default values that can be overridden

- **`outputs.tf`** - Information display
  - Shows web URL after deployment
  - Lists container names and network info
  - Provides database connection details

### Module Files

Each module has the same structure:
- **`main.tf`** - Resources to create (networks, containers, images)
- **`variables.tf`** - Input parameters the module accepts
- **`outputs.tf`** - Information the module provides to others

## Key Terraform Concepts Explained

### Resources
- `docker_network` - Creates Docker networks
- `docker_image` - Downloads or builds container images  
- `docker_container` - Creates and runs containers

### Variables
- Allow customization without changing code
- Have types (string, number, bool) and default values
- Passed from main config to modules

### Outputs  
- Share information between modules
- Display important details to users
- Enable module communication

### Modules
- Reusable collections of resources
- Take inputs via variables
- Provide outputs for other modules
- Promote code organization and reuse

## How Containers Communicate

1. All containers join the "flask_net" network
2. Docker provides automatic DNS resolution
3. Flask app connects to database using hostname "mysql-db"
4. MySQL container listens on port 3306
5. Flask container serves web pages on port 5000

## Database Configuration

MySQL container is configured with:
- **Root password**: "rootpass" (admin access)
- **Database name**: "mylistdb" (where data is stored)
- **App user**: "admin" (Flask app uses this)
- **App password**: "password" (for app user)

## Web Application Features

The Flask app provides:
- **`/`** - Welcome page
- **`/add`** - Form to add new items
- **`/show`** - List all items with delete links
- **`/delete/<id>`** - Remove specific items

## Deployment Commands

```bash
# Initialize Terraform (download providers)
terraform init

# See what will be created
terraform plan

# Create the infrastructure  
terraform apply

# Access the web app
# Open browser to: http://localhost:5000

# Destroy everything when done
terraform destroy
```

## Why This Architecture?

1. **Separation of Concerns** - Each module has one responsibility
2. **Reusability** - Modules can be used in other projects
3. **Maintainability** - Easy to modify individual components
4. **Scalability** - Easy to add more app instances or databases
5. **Infrastructure as Code** - Everything is versioned and reproducible

This project demonstrates modern DevOps practices with containerization, infrastructure automation, and modular design!
