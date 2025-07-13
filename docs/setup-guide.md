# AWS EC2 Website: Setup Guide

### 📋 Prerequisites

* AWS account
* SSH key pair (.pem)/(.ppk)
* Basic Linux & AWS knowledge

---

## 🚀 Step-by-Step Setup

### 1️⃣ Launch EC2 Instance

* **AMI**: Ubuntu Server 20.04 LTS
* **Type**: `t2.micro` (Free Tier)
* **Network**: Default VPC
* **Subnet**: Auto-assign Public IP enabled
* **Security Group**:

  * Allow SSH (22)
  * Allow HTTP (80)

### 2️⃣ Connect to EC2 via SSH

```bash
ssh -i your-key.pem ubuntu@your-ec2-public-ip
```

---

### 3️⃣ Update & Install Apache

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
```

Verify:
Visit `http://your-ec2-public-ip`

---

### 4️⃣ Deploy Website

```bash
# Upload your website files
scp -i your-key.pem -r ../website ubuntu@your-ec2-public-ip:/home/ubuntu/

# SSH into instance and run:
cd /home/ubuntu/scripts
./deployment.sh
```

---

### 5️⃣ Access Your Website

Visit: `http://your-ec2-public-ip`

---

## 🛡️ Post-Setup Tips

* Update security groups cautiously
* Remove unused default Apache pages

---