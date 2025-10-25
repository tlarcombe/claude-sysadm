# System Discovery and Inventory

Perform a comprehensive system discovery to understand the current server configuration and available tools.

## Tasks to Complete

1. **Identify System Information**
   ```bash
   # OS and kernel version
   cat /etc/os-release
   uname -a
   hostnamectl
   
   # CPU and memory
   lscpu | grep -E 'Model name|CPU\(s\)|Thread|Core'
   free -h
   ```

2. **Check Network Configuration**
   ```bash
   # Network interfaces
   ip addr show
   ip route show
   
   # DNS configuration
   cat /etc/resolv.conf
   
   # Active connections
   ss -tulnp
   ```

3. **Scan for Essential Tools**
   Check if these tools are installed and note their versions:
   - Network: `nmap`, `iperf3`, `netstat`, `ss`, `traceroute`, `mtr`
   - Monitoring: `htop`, `iotop`, `iftop`, `nethogs`, `glances`
   - Docker: `docker`, `docker compose`
   - Web: `nginx`, `certbot`, `apache2`
   - Database: `mysql`, `mariadb`, `psql`
   - Security: `ufw`, `fail2ban`
   
   ```bash
   for tool in nmap iperf3 netstat ss traceroute mtr htop iotop iftop nethogs glances docker nginx certbot mysql ufw fail2ban; do
       if command -v $tool &> /dev/null; then
           echo "$tool: installed ($(which $tool))"
       else
           echo "$tool: NOT INSTALLED"
       fi
   done
   ```

4. **Storage Analysis**
   ```bash
   # Disk usage
   df -h
   
   # Mount points
   mount | grep -E 'nfs|ext4|xfs'
   
   # Check NFS mounts specifically
   showmount -e 192.168.1.8 2>/dev/null || echo "NFS query failed"
   ```

5. **Running Services**
   ```bash
   # Systemd services
   systemctl list-units --type=service --state=running
   
   # Docker containers
   docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
   
   # Docker compose projects
   docker compose ls 2>/dev/null || echo "No compose projects found"
   ```

6. **Web Server Status**
   ```bash
   # Nginx status
   systemctl status nginx --no-pager
   
   # List enabled sites
   ls -la /etc/nginx/sites-enabled/
   
   # SSL certificates
   certbot certificates 2>/dev/null || echo "Certbot not configured"
   ```

7. **Scheduled Tasks**
   ```bash
   # Cron jobs for current user
   crontab -l 2>/dev/null || echo "No user crontab"
   
   # System cron jobs
   ls -la /etc/cron.* 2>/dev/null
   
   # Systemd timers
   systemctl list-timers --all
   ```

## Output

After gathering all information:

1. Create or update `.claude/memory/system-inventory.md` with:
   - System specifications (CPU, RAM, disk, kernel)
   - Installed tools and their versions
   - Missing tools that should be installed
   - Current resource usage

2. Create or update `.claude/memory/network-topology.md` with:
   - Network interfaces and IP addresses
   - Routing table
   - DNS servers
   - NFS mounts and remote storage
   - Open ports and listening services

3. Create or update `.claude/memory/scheduled-tasks.md` with:
   - All cron jobs
   - All systemd timers
   - Backup schedules
   - Maintenance windows

4. Provide a summary report highlighting:
   - System health status
   - Any missing critical tools
   - Services that need attention
   - Upcoming scheduled maintenance

## Security Note

When discovering network topology, be mindful of scanning other hosts. Only scan localhost and explicitly configured servers (like the NFS server at 192.168.1.8).
