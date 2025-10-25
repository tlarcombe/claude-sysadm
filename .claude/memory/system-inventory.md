# System Inventory

Last Updated: [To be filled by /sysadmin:discover]

## System Specifications

### Hardware
- **Hostname**: [To be discovered]
- **CPU**: [To be discovered]
- **Memory**: [To be discovered]
- **Boot Drive**: [To be discovered]
- **Network Storage**: [To be discovered]

### Operating System
- **Distribution**: [To be discovered]
- **Kernel**: [To be discovered]
- **Architecture**: [To be discovered]

## Installed Tools

### Network Tools
- [ ] nmap - [version]
- [ ] iperf3 - [version]
- [ ] netstat - [version]
- [ ] ss - [version]
- [ ] traceroute - [version]
- [ ] mtr - [version]
- [ ] tcpdump - [version]

### Monitoring Tools
- [ ] htop - [version]
- [ ] iotop - [version]
- [ ] iftop - [version]
- [ ] nethogs - [version]
- [ ] glances - [version]

### Container Tools
- [ ] docker - [version]
- [ ] docker compose - [version]

### Web Server Tools
- [ ] nginx - [version]
- [ ] apache - [version]
- [ ] certbot - [version]

### Database Tools
- [ ] mysql/mariadb - [version]
- [ ] postgresql - [version]

### Security Tools
- [ ] ufw - [version]
- [ ] fail2ban - [version]
- [ ] aide - [version]

### System Tools
- [ ] systemctl
- [ ] journalctl
- [ ] cron

## Missing Tools to Install

[To be filled by /sysadmin:discover]

## Current Resource Usage

[To be filled by /sysadmin:discover]

### CPU
- Load Average: [current]
- Usage: [current %]

### Memory
- Total: [size]
- Used: [size / %]
- Available: [size / %]

### Disk
- Root (/): [used / total] ([%])
- Additional mounts: [To be discovered]

## Alert Thresholds

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
  container_restart_threshold: 5
```

## System Capabilities

### Verified Capabilities
[To be filled during discovery]

### To Be Verified
[To be filled during discovery]

## Notes

[System-specific notes to be added during discovery]
