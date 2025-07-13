#!/bin/bash

# AWS EC2 Server Setup Script
# This script automates the server setup process for deploying a static website
# 
# Usage: ./server-setup.sh
# Make sure to run this script on your EC2 instance after SSH connection

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if running as root
check_root() {
    if [[ $EUID -eq 0 ]]; then
        print_error "This script should not be run as root"
        exit 1
    fi
}

# Function to update system packages
update_system() {
    print_status "Updating system packages..."
    sudo apt update && sudo apt upgrade -y
    print_status "System packages updated successfully"
}

# Function to install Apache
install_apache() {
    print_status "Installing Apache web server..."
    sudo apt install apache2 -y
    
    # Start and enable Apache
    sudo systemctl start apache2
    sudo systemctl enable apache2
    
    # Check if Apache is running
    if sudo systemctl is-active --quiet apache2; then
        print_status "Apache installed and started successfully"
    else
        print_error "Failed to start Apache"
        exit 1
    fi
}

# Function to configure firewall (if ufw is available)
configure_firewall() {
    if command -v ufw &> /dev/null; then
        print_status "Configuring UFW firewall..."
        sudo ufw allow 'Apache Full'
        sudo ufw allow OpenSSH
        print_status "Firewall configured successfully"
    else
        print_warning "UFW not available, skipping firewall configuration"
    fi
}

# Function to create backup of default Apache page
backup_default_page() {
    print_status "Creating backup of default Apache page..."
    if [[ -f /var/www/html/index.html ]]; then
        sudo cp /var/www/html/index.html /var/www/html/index.html.backup
        print_status "Backup created successfully"
    else
        print_warning "Default Apache page not found"
    fi
}

# Function to set proper permissions for web directory
set_web_permissions() {
    print_status "Setting proper permissions for web directory..."
    sudo chown -R www-data:www-data /var/www/html
    sudo chmod -R 755 /var/www/html
    print_status "Permissions set successfully"
}

# Function to create a sample HTML file
create_sample_page() {
    print_status "Creating sample HTML page..."
    
    cat << 'EOF' | sudo tee /var/www/html/index.html > /dev/null
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AWS EC2 Static Website</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .info {
            background-color: #d1ecf1;
            color: #0c5460;
            padding: 15px;
            border-radius: 5px;
            margin: 20px 0;
        }
        .tech-stack {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }
        .tech-item {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            text-align: center;
        }
        footer {
            text-align: center;
            margin-top: 30px;
            color: #666;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 AWS EC2 Static Website Deployment</h1>
        
        <div class="success">
            <strong>✅ Success!</strong> Your static website is now live on AWS EC2!
        </div>
        
        <div class="info">
            <strong>📋 Project Overview:</strong> This is a demonstration of deploying a static website on Amazon Web Services EC2 using Ubuntu Server and Nginx web server.
        </div>
        
        <h2>🛠️ Technology Stack</h2>
        <div class="tech-stack">
            <div class="tech-item">
                <strong>☁️ Cloud Platform</strong><br>
                Amazon Web Services (AWS)
            </div>
            <div class="tech-item">
                <strong>💻 Compute Service</strong><br>
                EC2 (Elastic Compute Cloud)
            </div>
            <div class="tech-item">
                <strong>🐧 Operating System</strong><br>
                Ubuntu Server LTS
            </div>
            <div class="tech-item">
                <strong>🌐 Web Server</strong><br>
                Apache HTTP Server
            </div>
        </div>
        
        <h2>📋 Project Features</h2>
        <ul>
            <li>EC2 instance configuration with Ubuntu Server</li>
            <li>Security group setup for HTTP and SSH access</li>
            <li>Apache web server installation and configuration</li>
            <li>Static website deployment</li>
            <li>Public IP access configuration</li>
        </ul>
        
        <h2>🔐 Security Measures</h2>
        <ul>
            <li>SSH key pair authentication</li>
            <li>Restricted security group rules</li>
            <li>Regular system updates</li>
            <li>Proper file permissions</li>
        </ul>
        
        <footer>
            <p>🎯 AWS EC2 Static Website Deployment Project</p>
            <p>Server Status: <span id="status">Online</span> | Last Updated: <span id="timestamp"></span></p>
        </footer>
    </div>
    
    <script>
        // Display current timestamp
        document.getElementById('timestamp').textContent = new Date().toLocaleString();
        
        // Simple status indicator
        setInterval(function() {
            document.getElementById('status').textContent = 'Online';
            document.getElementById('timestamp').textContent = new Date().toLocaleString();
        }, 30000); // Update every 30 seconds
    </script>
</body>
</html>
EOF

    print_status "Sample HTML page created successfully"
}

# Function to test Apache configuration
test_apache() {
    print_status "Testing Apache configuration..."
    sudo apache2ctl configtest
    if [[ $? -eq 0 ]]; then
        print_status "Apache configuration test passed"
        sudo systemctl reload apache2
        print_status "Apache reloaded successfully"
    else
        print_error "Apache configuration test failed"
        exit 1
    fi
}

# Function to display completion message
display_completion() {
    print_status "==============================================="
    print_status "🎉 Server setup completed successfully!"
    print_status "==============================================="
    print_status ""
    print_status "Your website is now accessible at:"
    print_status "http://YOUR-EC2-PUBLIC-IP"
    print_status ""
    print_status "To find your public IP address, run:"
    print_status "curl http://checkip.amazonaws.com"
    print_status ""
    print_status "Next steps:"
    print_status "1. Update the HTML content in /var/www/html/index.html"
    print_status "2. Add your CSS and JavaScript files"
    print_status "3. Configure a custom domain (optional)"
    print_status "4. Set up SSL/TLS certificate (recommended)"
    print_status ""
    print_status "For troubleshooting, check:"
    print_status "- Apache status: sudo systemctl status apache2"
    print_status "- Apache error logs: sudo tail -f /var/log/apache2/error.log"
    print_status "- Security group settings in AWS Console"
    print_status ""
}

# Main execution
main() {
    print_status "Starting AWS EC2 server setup..."
    print_status "==============================================="
    
    check_root
    update_system
    install_apache
    configure_firewall
    backup_default_page
    set_web_permissions
    create_sample_page
    test_apache
    display_completion
}

# Execute main function
main "$@"