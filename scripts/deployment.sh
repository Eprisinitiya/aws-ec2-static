Automates copying website files to the Apache server directory and restarting the service.

```bash
#!/bin/bash
# deployment.sh - Deploy static website on AWS EC2 (Ubuntu + Apache)

# Exit immediately if a command exits with a non-zero status.
set -e

echo "Starting deployment..."

# Copy website files to Apache's root directory
sudo cp -r ../website/* /var/www/html/

# Set proper permissions
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/

# Restart Apache to ensure changes are live
sudo systemctl restart apache2

echo "Deployment completed successfully!"
echo "Visit your site via http://<your-ec2-public-ip>"
```

> **Make executable**

```bash
chmod +x deployment.sh
```

---