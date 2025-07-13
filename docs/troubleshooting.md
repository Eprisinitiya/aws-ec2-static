# AWS EC2 Website: Troubleshooting

---

## 🛑 Common Issues & Fixes

### 🔧 **Can't SSH into EC2 (Permission Denied / Timeout)**

* Ensure `.pem` file has correct permissions:

```bash
chmod 400 your-key.pem
```

* Verify correct public IP and security group allows **Port 22 (SSH)**.

---

### 🔧 **Website Not Loading (403, 404, or Timeout)**

* Confirm security group allows **Port 80 (HTTP)**.
* Ensure website files are copied to `/var/www/html/`.
* Restart Apache:

```bash
sudo systemctl restart apache2
```

---

### 🔧 **Apache Not Running**

Check status:

```bash
sudo systemctl status apache2
```

Start if inactive:

```bash
sudo systemctl start apache2
```

---

### 🔧 **Files Not Updating / Cache Issue**

* Clear browser cache / hard refresh `Ctrl + F5`.
* Ensure you copied latest files to `/var/www/html/`.

---

### 🔧 **Permission Issues on Web Files**

```bash
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
```

---

## 💡 Additional Tips

* Public IP may change if instance is stopped → assign Elastic IP for stability.
* Use `curl` within EC2 to verify Apache locally:

```bash
curl localhost
```

---