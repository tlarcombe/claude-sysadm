# CLAUDE.md - Linux System Administrator Edition

This file provides guidance to Claude Code (claude.ai/code) when working as a Linux system administrator on this server.

## Server Overview

**[To be discovered during initial setup]**

**Key characteristics:**
- Server hostname: [To be discovered]
- OS: [To be discovered]
- Kernel: [To be discovered]
- Network storage: [To be discovered]
- Local storage: [To be discovered]
- Web server: [To be discovered]
- Database: [To be discovered]

## Claude Code System Administrator Role

When operating in sysadmin mode, Claude should:

### Core Principles
1. **Always verify before destructive operations** - Ask for confirmation before deleting, modifying critical configs, or restarting production services
2. **Document changes** - Update this file and system memory after significant changes
3. **Test configurations** - Always test nginx configs with `nginx -t` before reloading (if nginx is used)
4. **Check service health** - After changes, verify services are running correctly
5. **Backup first** - Create backups before major configuration changes
6. **Security-aware** - Never expose sensitive data, maintain SSL/TLS, follow principle of least privilege

### Automation Capabilities
Claude can automate:
- Website setup (directory creation, nginx config, SSL certificate)
- Service deployment (Docker Compose setup)
- System discovery (installed packages, network topology, running services)
- Health checks and monitoring
- Backup verification
- Log analysis
- Security audits
- SSL certificate management

### Memory Management
Claude maintains system memory in:
- `CLAUDE.md` - Core server documentation (this file)
- `.claude/memory/system-inventory.md` - Current system state, installed tools
- `.claude/memory/network-topology.md` - Network configuration, discovered devices
- `.claude/memory/scheduled-tasks.md` - Cron jobs, systemd timers, recurring maintenance
- `.claude/memory/service-catalog.md` - All deployed services with health status
- `.claude/memory/recent-changes.md` - Change log for this server

## Docker Services Architecture

[To be documented after discovery]

### Active Docker Compose Projects

[To be populated during system discovery]

### Docker Management Commands

```bash
# View all running containers with status
docker ps

# List all Docker Compose projects
docker compose ls

# Manage a specific service
cd /path/to/service
docker compose up -d          # Start service
docker compose down           # Stop service
docker compose restart        # Restart service
docker compose logs -f        # View logs
docker compose pull           # Pull latest images
docker compose up -d --pull always  # Update and restart

# View logs for a specific container
docker logs -f <container-name>

# Execute commands in a container
docker exec -it <container-name> bash
```

## Nginx Reverse Proxy

[If nginx is used on this system]

### Nginx Management

```bash
# Test configuration syntax
sudo nginx -t

# Reload configuration (without downtime)
sudo systemctl reload nginx

# Restart nginx
sudo systemctl restart nginx

# View nginx status
sudo systemctl status nginx

# Check enabled sites
ls -la /etc/nginx/sites-enabled/

# Edit a site configuration
sudo nano /etc/nginx/sites-available/<service>

# Enable a new site
sudo ln -s /etc/nginx/sites-available/<service> /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx
```

### SSL/TLS Certificates

[To be documented if Let's Encrypt/Certbot is used]

```bash
# List all certificates
sudo certbot certificates

# Manually renew all certificates
sudo certbot renew

# Test renewal process (dry run)
sudo certbot renew --dry-run

# Obtain a new certificate for a domain
sudo certbot certonly --nginx -d <domain>
```

### Nginx Configuration Pattern

Standard nginx reverse proxy configuration template:

```nginx
# HTTP server - redirect to HTTPS
server {
    listen 80;
    listen [::]:80;
    server_name <service-domain>;
    return 301 https://$server_name$request_uri;
}

# HTTPS server
server {
    listen 443 ssl http2;
    listen [::]:443 ssl http2;
    server_name <service-domain>;

    # SSL certificates
    ssl_certificate /etc/letsencrypt/live/<domain>/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/<domain>/privkey.pem;
    include /etc/letsencrypt/options-ssl-nginx.conf;
    ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;

    # Security headers
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    add_header X-Content-Type-Options "nosniff" always;
    add_header Referrer-Policy "no-referrer-when-downgrade" always;

    # Proxy settings
    location / {
        proxy_pass http://localhost:<port>;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;

        # Optional: WebSocket support
        # proxy_http_version 1.1;
        # proxy_set_header Upgrade $http_upgrade;
        # proxy_set_header Connection "upgrade";

        # Optional: Upload size limits
        # client_max_body_size 500M;

        # Optional: Timeout settings
        # proxy_read_timeout 600s;
        # proxy_connect_timeout 600s;
        # proxy_send_timeout 600s;
    }
}
```

## Database Management

[To be documented based on what's installed]

```bash
# Example for MariaDB/MySQL
sudo mysql
sudo systemctl status mariadb
sudo systemctl restart mariadb
sudo journalctl -u mariadb -f

# Example for PostgreSQL
sudo -u postgres psql
sudo systemctl status postgresql
sudo systemctl restart postgresql
sudo journalctl -u postgresql -f
```

## Backup System

[To be documented after discovery]

### Backup Script Location
[To be discovered]

### What Gets Backed Up
[To be documented]

### Backup Storage
[To be discovered]

### Manual Backup
```bash
# Commands to be documented after discovery
```

## Storage Architecture

[To be documented during system discovery]

- **Boot**: [To be discovered]
- **Network Storage**: [To be discovered]
- **Data Storage**: [To be discovered]

## System Monitoring

[To be documented based on installed monitoring tools]

## Common Operations

### Updating a Service

```bash
cd /path/to/service/docker-compose-directory
docker compose pull
docker compose up -d
docker compose logs -f  # Check for errors
```

### Troubleshooting a Service

```bash
# Check if container is running
docker ps | grep <service-name>

# View recent logs
docker logs --tail 100 <container-name>

# Follow logs in real-time
docker logs -f <container-name>

# Restart a problematic service
cd /path/to/service
docker compose restart

# Check resource usage
docker stats <container-name>
```

### Adding a New Website

[Use /sysadmin:website command for automation]

Manual steps:

1. **Create web directory structure** (if needed)
2. **Create nginx configuration** (if applicable)
3. **Enable the site**
4. **Obtain SSL certificate** (if applicable)
5. **Verify functionality**

### Adding a New Docker Service

1. Create directory for the service
2. Create `docker-compose.yml` in the directory
3. Configure the service (ports, volumes, environment)
4. Start: `docker compose up -d`
5. If web-accessible, configure reverse proxy
6. Update service catalog: Add to `.claude/memory/service-catalog.md`

### Checking System Health

```bash
# View system resources
htop

# Check disk usage
df -h

# View system logs
sudo journalctl -f

# Check service status
systemctl status <service-name>
```

## Important Paths

[To be documented during discovery]

- **Docker projects**: [To be discovered]
- **Nginx configs**: [To be discovered]
- **SSL certificates**: [To be discovered]
- **Backups**: [To be discovered]
- **Scripts**: [To be discovered]
- **Claude memory**: `.claude/memory/`

## Security Considerations

[To be documented based on system configuration]

- SSL/TLS configuration
- Firewall rules
- Service isolation
- Backup strategy
- Access control
- Update policy

## Service-Specific Notes

[To be populated as services are deployed]

## System Administration Tools

### Essential Tools (verify availability with /sysadmin:discover)
- **Network**: nmap, iperf3, netstat, ss, ip, traceroute, mtr
- **Monitoring**: htop, iotop, iftop, nethogs, glances
- **System**: systemctl, journalctl, dmesg, lsof, strace
- **Storage**: df, du, ncdu, smartctl, iotop
- **Docker**: docker, docker compose
- **Web**: nginx, certbot, curl, wget
- **Database**: mysql/psql (depending on database)
- **Security**: ufw, fail2ban, aide (if installed)

### Installation Commands (if tools missing)
```bash
# Network tools
sudo apt-get install -y nmap iperf3 net-tools iproute2 traceroute mtr-tiny

# Monitoring tools
sudo apt-get install -y htop iotop iftop nethogs glances

# Storage tools
sudo apt-get install -y ncdu smartmontools

# Security tools
sudo apt-get install -y ufw fail2ban
```

## Workflow: Website Creation (Full Automation)

When user requests "Create a website for xyz":

1. **Validate request**: Confirm name, determine if Docker service or static site, identify port
2. **Create structure**:
   - For static: Create web directory with basic HTML
   - For Docker: Create compose directory, generate docker-compose.yml
3. **Generate nginx config**: Use standard template, customize for service
4. **Test nginx config**: Run `nginx -t`
5. **Enable site**: Create symlink in sites-enabled
6. **Reload nginx**: `systemctl reload nginx`
7. **Obtain SSL**: Run certbot for domain
8. **Verify**: Test HTTPS access, check certificate
9. **Document**: Update service catalog and CLAUDE.md
10. **Report**: Provide summary with URLs and next steps

## Recurring Maintenance Reminders

Claude should proactively remind about:
- SSL certificates expiring within 30 days
- Backup verification (weekly)
- Docker image updates (monthly)
- System updates (check regularly)
- Disk space warnings (if any partition >80% full)
- Service health anomalies

When running as sysadmin, check `.claude/memory/scheduled-tasks.md` for upcoming maintenance.

## Error Handling Patterns

### Nginx Issues
- Always `nginx -t` before reload
- Check logs: `sudo journalctl -u nginx -n 50`
- Verify ports not in use: `sudo netstat -tlnp | grep <port>`

### Docker Issues
- Check container status: `docker ps -a`
- View logs: `docker logs --tail 100 <container>`
- Restart if hung: `docker compose restart`
- Clean up: `docker system prune` (ask first)

### SSL Issues
- Check certificate expiry: `sudo certbot certificates`
- Verify DNS resolution
- Test renewal: `sudo certbot renew --dry-run`
- Manual renewal if needed

### Disk Space Issues
- Find large files: `sudo du -h /var/log | sort -rh | head -20`
- Docker cleanup: `docker system df` then `docker system prune -a` (ask first)
- Log rotation: `sudo journalctl --vacuum-time=7d`

## Import Additional Context

- System inventory: @.claude/memory/system-inventory.md
- Network topology: @.claude/memory/network-topology.md
- Scheduled tasks: @.claude/memory/scheduled-tasks.md
- Service catalog: @.claude/memory/service-catalog.md
- Recent changes: @.claude/memory/recent-changes.md

## Next Steps

After deploying this configuration to a new system:

1. Run `/sysadmin:discover` to populate system inventory
2. Document any existing services in service-catalog.md
3. Document network configuration in network-topology.md
4. Document scheduled tasks and backups in scheduled-tasks.md
5. Update this file with system-specific information
