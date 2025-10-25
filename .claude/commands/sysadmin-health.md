# System Health Check

Perform comprehensive system health monitoring and identify potential issues.

**Usage:** `/sysadmin:health [scope]`

Where:
- `[scope]`: Optional - "quick", "full", or "deep" (default: quick)

**Arguments provided:** $ARGUMENTS

## Health Check Scopes

### Quick Check (< 30 seconds)
- Service status (nginx, docker, mariadb)
- Disk space usage
- Memory usage
- Load average
- Failed systemd services
- Docker container status

### Full Check (< 2 minutes)
- All items from Quick Check
- CPU usage trends
- Network connectivity
- NFS mount status
- SSL certificate expiry
- Recent error logs
- Backup verification
- Port availability

### Deep Check (< 5 minutes)
- All items from Full Check
- Disk I/O statistics
- Process analysis (top consumers)
- Network performance
- Docker image updates available
- Security audit (open ports, firewall status)
- Log analysis (patterns, errors, warnings)
- Service response time tests

## Health Check Procedures

### 1. System Resources

```bash
# CPU load
uptime
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print "CPU Usage: " 100 - $1"%"}'

# Memory usage
free -h
ps aux --sort=-%mem | head -10

# Disk space (WARNING if > 80%, CRITICAL if > 90%)
df -h | awk 'NR>1 {gsub(/%/,"",$5); if($5>90) printf "CRITICAL: %s is %s%% full\n", $6, $5; else if($5>80) printf "WARNING: %s is %s%% full\n", $6, $5}'

# Load average
cat /proc/loadavg
```

### 2. Service Status

```bash
# Check critical services
for service in nginx docker mariadb; do
    if systemctl is-active --quiet $service; then
        echo "✅ $service is running"
    else
        echo "❌ $service is NOT running"
    fi
done

# Check for failed services
systemctl --failed

# Check nginx configuration
echo 'Nhad368pass' | sudo -S nginx -t

# Docker health
docker ps --filter "health=unhealthy"
docker ps --filter "status=exited"
```

### 3. Storage Health

```bash
# Check NFS mount
if mountpoint -q /mnt/raid0; then
    echo "✅ NFS mount /mnt/raid0 is active"
    df -h /mnt/raid0
else
    echo "❌ NFS mount /mnt/raid0 is NOT mounted"
fi

# Check for disk errors
echo 'Nhad368pass' | sudo -S dmesg | grep -i "error" | tail -20

# SMART status (if smartctl available)
if command -v smartctl &> /dev/null; then
    echo 'Nhad368pass' | sudo -S smartctl -H /dev/nvme0n1
fi
```

### 4. Network Health

```bash
# Test connectivity to critical hosts
ping -c 3 192.168.1.8 > /dev/null 2>&1 && echo "✅ NFS server reachable" || echo "❌ NFS server unreachable"
ping -c 3 8.8.8.8 > /dev/null 2>&1 && echo "✅ Internet connectivity OK" || echo "❌ No internet connectivity"

# DNS resolution
nslookup larcombe.tech > /dev/null 2>&1 && echo "✅ DNS resolution working" || echo "❌ DNS resolution failed"

# Check listening ports
echo 'Nhad368pass' | sudo -S ss -tulnp | grep LISTEN
```

### 5. Docker Health

```bash
# Container status
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.RunningFor}}"

# Check for containers with high restart counts
docker ps --format "{{.Names}}: {{.Status}}" | grep -i "restarting"

# Docker disk usage
docker system df

# Check compose project status
docker compose ls
```

### 6. Log Analysis

```bash
# Recent critical errors
echo 'Nhad368pass' | sudo -S journalctl -p err -n 50 --no-pager

# Nginx errors
echo 'Nhad368pass' | sudo -S journalctl -u nginx -p err -n 20 --no-pager

# Docker errors
echo 'Nhad368pass' | sudo -S journalctl -u docker -p warning -n 20 --no-pager
```

### 7. Security Status

```bash
# Check for running firewall
echo 'Nhad368pass' | sudo -S ufw status

# List open ports
echo 'Nhad368pass' | sudo -S ss -tulnp | grep LISTEN | awk '{print $5}' | cut -d: -f2 | sort -u

# Check for updates
apt list --upgradable 2>/dev/null | grep -v "^Listing"
```

### 8. Backup Status

```bash
# Check latest backup
latest_backup=$(ls -td /mnt/raid0/backups/grathsrv05/* 2>/dev/null | head -1)
if [ -n "$latest_backup" ]; then
    echo "✅ Latest backup: $(basename $latest_backup)"
    echo "   Size: $(du -sh $latest_backup | cut -f1)"
    echo "   Age: $(stat -c %y $latest_backup | cut -d' ' -f1)"
else
    echo "❌ No backups found"
fi
```

### 9. SSL Certificate Status

```bash
# Check certificates expiring soon
echo 'Nhad368pass' | sudo -S certbot certificates 2>/dev/null | grep -E "Certificate Name|Expiry Date"
```

## Health Score Calculation

Assign scores and calculate overall health:

- **Critical Issues** (-20 points each):
  - Service down (nginx, docker, mariadb)
  - Disk > 95% full
  - NFS mount failed
  - Multiple containers crashed

- **Major Issues** (-10 points each):
  - Disk 90-95% full
  - Memory > 90% used
  - SSL cert expires < 7 days
  - Service unhealthy
  - Failed systemd services

- **Minor Issues** (-5 points each):
  - Disk 80-90% full
  - Memory 80-90% used
  - SSL cert expires < 30 days
  - High CPU load (> 80%)
  - Container restart in last hour

- **Warnings** (-2 points each):
  - Disk 70-80% full
  - Outdated packages
  - High load average

**Health Score**: Start at 100, subtract points

- 90-100: Excellent ✅
- 70-89: Good ⚡
- 50-69: Fair ⚠️
- 30-49: Poor ❌
- < 30: Critical 🚨

## Health Report Format

```markdown
# System Health Report - grathsrv05
Generated: <timestamp>
Overall Health Score: X/100 (<status>)

## Summary
✅ Services Running: X/X
⚠️ Warnings: X
❌ Critical Issues: X

## Critical Issues
[List any critical problems that need immediate attention]

## Warnings
[List items that need attention soon]

## System Resources
- CPU Load: X%
- Memory Usage: X/Y GB (Z%)
- Disk Usage:
  - Root: X%
  - NFS: X%
- Load Average: X, Y, Z

## Service Status
| Service | Status | Notes |
|---------|--------|-------|
| nginx | ✅ Running | |
| docker | ✅ Running | |
| mariadb | ✅ Running | |

## Docker Containers
| Container | Status | Health | Restarts |
|-----------|--------|--------|----------|
| container1 | Up | healthy | 0 |

## Storage
| Mount | Size | Used | Available | Use% | Status |
|-------|------|------|-----------|------|--------|
| / | XGB | XGB | XGB | X% | OK |
| /mnt/raid0 | XTB | XTB | XTB | X% | OK |

## SSL Certificates
| Domain | Expiry | Days Left | Status |
|--------|--------|-----------|--------|
| domain.larcombe.tech | 2025-03-15 | 120 | ✅ |

## Recent Errors
[Summary of recent critical errors from logs]

## Recommendations
1. [Action items based on health check]
2. [Preventive maintenance suggestions]
3. [Optimization opportunities]

## Next Steps
- [ ] [Immediate actions required]
- [ ] [Scheduled maintenance needed]
- [ ] [Follow-up checks]
```

## Automated Monitoring

If issues are found, update `.claude/memory/scheduled-tasks.md` with:
- Follow-up check reminders
- Maintenance actions needed
- Escalation procedures

## Alert Thresholds

Configure monitoring thresholds in `.claude/memory/system-inventory.md`:
```yaml
alerts:
  disk_warning: 80
  disk_critical: 90
  memory_warning: 80
  memory_critical: 90
  ssl_expiry_warning: 30
  ssl_expiry_critical: 7
  backup_age_warning: 7
  backup_age_critical: 14
```

## Integration with Monitoring Tools

If available, query:
- **Beszel**: Server resource trends
- **Uptime Kuma**: Service availability history
- **Ntopng**: Network traffic anomalies

## Example Usage

```
User: "How is the server doing?"
Claude: Calls /sysadmin:health quick

User: "Run a full system health check"
Claude: Calls /sysadmin:health full

User: "Deep dive into system health"
Claude: Calls /sysadmin:health deep
```

## Follow-up Actions

Based on health check results:
- If critical issues: Alert immediately and provide remediation steps
- If warnings: Create task list in memory and schedule follow-up
- If all good: Update last health check timestamp in system inventory
- Always: Log health check results to `.claude/memory/recent-changes.md`
