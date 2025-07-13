# 🚀 AWS EC2 Static Website Deployment

A hands-on project demonstrating how to deploy a **website on AWS EC2** using a Linux (Ubuntu) server and Apache. This project strengthens foundational cloud computing skills through Amazon Web Services (AWS).

---

## 📂 Project Structure

```
aws-ec2-static-website/
├── docs/                      # Guides & Best Practices
├── website/                   # Static Website Files
├── scripts/                   # Bash Scripts for Automation
├── screenshots/               # Project Screenshots
├── .gitignore                 # Git Ignore Rules
└── README.md                  # Project Documentation
```

---

## 📑 Project Overview

### **Goal**

To gain practical experience in launching cloud infrastructure and deploying static websites via AWS EC2.

### **Key Objectives**

✅ Set up AWS account and management console
✅ Launch and configure Ubuntu EC2 instance
✅ Install Apache web server
✅ Deploy website
✅ Configure security groups for HTTP & SSH
✅ Access website via public IP


---

## 🚦 Setup Guide

> **Detailed step-by-step guide** is available under `/docs/`.
> [📄 setup-guide.md](./docs/setup-guide.md)

**Basic Steps:**

1. Create AWS account
2. Launch EC2 Ubuntu Server (t2.micro)
3. Configure security group (Ports 22, 80)
4. SSH into server
5. Install Apache
6. Deploy static files to `/var/www/html`
7. Access via public IP in browser

---


## 🚩 Stretch Goals (Optional)

✔️ Custom Domain via Amazon Route 53
✔️ HTTPS (Let's Encrypt SSL)
✔️ CI/CD with AWS CodePipeline

---

## 🧠 Learning Outcomes

🎯 Cloud Basics (EC2, VPC, Security Groups)
🎯 Linux Server Administration
🎯 Web Server Setup (Apache)
🎯 Website Hosting on Cloud
🎯 SSH Key Management
🎯 Deployment & Networking Concepts

---

## 🔒 Security Best Practices

Read the [security-best-practices.md](./docs/security-best-practices.md) for guidance on securing your AWS infrastructure.

---

## 🛠️ Scripts

| Script               | Purpose                      |
| -------------------- | ---------------------------- |
| `server-setup.sh`    | Automates EC2 server setup   |
| `apache-config.conf` | Apache virtual host config   |
| `deployment.sh`      | Automates website deployment |

---

## 🚀 How to Run This Project (Summary)

```bash
# Connect to EC2
ssh -i your-key.pem ubuntu@your-ec2-public-ip

# Run setup script
./scripts/server-setup.sh

# Deploy static files
./scripts/deployment.sh
```

---

## 📢 Why This Project Matters?

✅ Cloud skills are in demand
✅ AWS is the #1 cloud platform
✅ This project demonstrates real-world deployment skills
✅ Shows your understanding of infrastructure, security, and networking

---

## 🌐 Live Demo (Optional)

> *Provide your EC2 public IP or domain here if live*

**[http://YOUR-EC2-PUBLIC-IP](http://YOUR-EC2-PUBLIC-IP)**

---

## 🤝 Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

---