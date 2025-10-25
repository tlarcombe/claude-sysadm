# Create Website with Nginx and SSL

Automate the complete setup of a new website with nginx reverse proxy and Let's Encrypt SSL certificate.

**Usage:** `/sysadmin:website <name> [port] [type]`

Where:
- `<name>`: Subdomain name (e.g., "myapp" for myapp.larcombe.tech)
- `[port]`: Optional - Port number of the backend service (default: 8080)
- `[type]`: Optional - "static" for static HTML site, "proxy" for reverse proxy (default: proxy)

**Arguments provided:** $ARGUMENTS

## Workflow

### 1. Parse Arguments and Validate

Extract the name, port, and type from $ARGUMENTS.

```bash
# Validate name format (alphanumeric and hyphens only)
# Validate port number (1024-65535)
# Check if domain already exists in nginx
```

### 2. Create Directory Structure

**For static sites:**
```bash
sudo mkdir -p /var/www/<name>
sudo chown -R www-data:www-data /var/www/<name>

# Create basic index.html
sudo tee /var/www/<name>/index.html > /dev/null <<'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><NAME></title>
</head>
<body>
    <h1>Welcome to <NAME></h1>
    <p>This site is running on grathsrv05</p>
</body>
</html>
EOF
```

**For proxy sites:**
```bash
# Verify the port is accessible
nc -zv localhost <port> || echo "WARNING: Port <port> not responding"
```

### 3. Create Nginx Configuration

Use echo with sudo password when needed:
```bash
echo 'Nhad368pass' | sudo -S tee /etc/nginx/sites-available/<name>.larcombe.tech > /dev/null <<'EOF'
# HTTP server - redirect to HTTPS
server {
    listen 80;
    listen [::]:80;
    server_name <name>.larcombe.tech;
    return 301 https://$server_name$request_uri;
}

# HTTPS server
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name <name>.larcombe.tech;

    # SSL certificates (will be added by certbot)
    ssl_certificate /etc/letsencrypt/live/<name>.larcombe.tech/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/<name>.larcombe.tech/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    # Security headers
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;

    # Proxy or static content
    location / {
        # FOR PROXY TYPE:
        proxy_pass http://localhost:<port>;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
        
        # FOR STATIC TYPE:
        # root /var/www/<name>;
        # index index.html index.htm;
        # try_files $uri $uri/ =404;
    }
}
EOF
```

### 4. Enable the Site

```bash
# Create symbolic link
echo 'Nhad368pass' | sudo -S ln -sf /etc/nginx/sites-available/<name>.larcombe.tech /etc/nginx/sites-enabled/

# Test nginx configuration
echo 'Nhad368pass' | sudo -S nginx -t

# If test passes, reload nginx
if [ $? -eq 0 ]; then
    echo 'Nhad368pass' | sudo -S systemctl reload nginx
else
    echo "ERROR: Nginx configuration test failed!"
    exit 1
fi
```

### 5. Obtain SSL Certificate

```bash
# Request certificate from Let's Encrypt
echo 'Nhad368pass' | sudo -S certbot certonly --nginx \
    -d <name>.larcombe.tech \
    --non-interactive \
    --agree-tos \
    --email admin@larcombe.tech
```

### 6. Final Reload and Verification

```bash
# Reload nginx with SSL configuration
echo 'Nhad368pass' | sudo -S systemctl reload nginx

# Verify certificate was obtained
echo 'Nhad368pass' | sudo -S certbot certificates | grep <name>.larcombe.tech

# Test HTTPS access
curl -I https://<name>.larcombe.tech

# Check if service is responding
curl https://<name>.larcombe.tech
```

### 7. Update Documentation

1. Update `.claude/memory/service-catalog.md` with:
   - Service name
   - URL: https://<name>.larcombe.tech
   - Type: static or proxy
   - Backend port (if proxy)
   - Date deployed
   - SSL certificate expiry date

2. Update `.claude/memory/recent-changes.md` with:
   - Timestamp
   - Action: "Created website <name>.larcombe.tech"
   - Configuration file location
   - SSL certificate obtained

### 8. Provide Summary

Create a summary report with:
- ✅ Website URL: https://<name>.larcombe.tech
- ✅ Nginx configuration: /etc/nginx/sites-available/<name>.larcombe.tech
- ✅ SSL certificate status and expiry date
- ✅ Backend service port (if proxy)
- 📋 Next steps:
  - For static sites: Upload content to /var/www/<name>/
  - For proxy sites: Ensure service is running on port <port>
  - Test the website in a browser
  - Configure any application-specific settings

## Error Handling

If any step fails:
1. Report the specific error
2. Provide troubleshooting steps
3. Offer to rollback changes (remove nginx config, disable site)
4. Check common issues:
   - Port already in use
   - Domain already configured
   - Certbot rate limits
   - DNS not resolving
   - Service not responding on port

## Security Considerations

- Validate all input parameters
- Use secure SSL/TLS configuration
- Enable security headers (HSTS, CSP)
- Set appropriate file permissions
- Test configuration before applying
- Document all changes

## Example Usage

```
User: "Create a basic website for dashboard"
Claude: Calls /sysadmin:website dashboard 3000 proxy

User: "Set up a static site for landing-page"
Claude: Calls /sysadmin:website landing-page 80 static
```
