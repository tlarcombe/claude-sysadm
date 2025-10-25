# SSL Certificate Management

Check SSL certificate status, manage renewals, and handle certificate-related issues.

**Usage:** `/sysadmin:ssl [action] [domain]`

Where:
- `[action]`: Optional - "check", "renew", "test", or "list" (default: check)
- `[domain]`: Optional - Specific domain to check (default: all)

**Arguments provided:** $ARGUMENTS

## Actions

### 1. List All Certificates (action: list)

```bash
echo 'Nhad368pass' | sudo -S certbot certificates
```

Parse output to create a table with:
- Domain name
- Certificate expiry date
- Days until expiry
- Status (✅ Valid, ⚠️ Expiring soon <30 days, ❌ Expired)

### 2. Check Certificate Status (action: check)

For each domain (or specified domain):

```bash
# Get certificate details
echo 'Nhad368pass' | sudo -S certbot certificates | grep -A 10 "<domain>"

# Check certificate expiry
echo | openssl s_client -servername <domain>.larcombe.tech -connect <domain>.larcombe.tech:443 2>/dev/null | openssl x509 -noout -dates

# Check if certificate is valid
curl -I https://<domain>.larcombe.tech --max-time 5
```

Identify:
- Certificates expiring within 30 days (warning)
- Certificates expiring within 7 days (urgent)
- Any SSL errors or misconfigurations
- Domains without certificates

### 3. Test Renewal Process (action: test)

```bash
# Dry-run renewal
echo 'Nhad368pass' | sudo -S certbot renew --dry-run
```

Report:
- Which certificates would be renewed
- Any errors in the renewal process
- Configuration issues

### 4. Renew Certificates (action: renew)

**For all certificates:**
```bash
echo 'Nhad368pass' | sudo -S certbot renew
echo 'Nhad368pass' | sudo -S systemctl reload nginx
```

**For specific domain:**
```bash
echo 'Nhad368pass' | sudo -S certbot renew --cert-name <domain>.larcombe.tech
echo 'Nhad368pass' | sudo -S systemctl reload nginx
```

After renewal:
- Verify new expiry dates
- Test HTTPS access
- Update `.claude/memory/scheduled-tasks.md` with next renewal date

### 5. Proactive Monitoring

Check `.claude/memory/scheduled-tasks.md` for certificate renewal reminders.

If any certificates expire in less than 30 days, create a reminder entry:
```markdown
## SSL Certificate Renewals

- [ ] **URGENT**: <domain>.larcombe.tech expires in X days (on YYYY-MM-DD)
- [ ] **Warning**: <domain>.larcombe.tech expires in X days (on YYYY-MM-DD)

Run: `/sysadmin:ssl renew <domain>`
```

## Certificate Status Report

Generate a comprehensive report:

```markdown
# SSL Certificate Status Report
Generated: <timestamp>

## Summary
- Total certificates: X
- Valid: X
- Expiring soon (< 30 days): X
- Expired: X

## Certificates by Status

### ✅ Valid Certificates (> 30 days)
| Domain | Expiry Date | Days Remaining |
|--------|-------------|----------------|
| domain1.larcombe.tech | 2025-03-15 | 145 |

### ⚠️ Expiring Soon (< 30 days)
| Domain | Expiry Date | Days Remaining | Action Required |
|--------|-------------|----------------|-----------------|
| domain2.larcombe.tech | 2025-11-15 | 25 | Renew soon |

### ❌ Expired or Invalid
| Domain | Expiry Date | Status | Action Required |
|--------|-------------|--------|-----------------|
| domain3.larcombe.tech | 2025-10-01 | Expired | Renew immediately |

## Certbot Timer Status

Last run: <timestamp>
Next scheduled run: <timestamp>
Status: Active/Inactive

## Recommended Actions

1. [Priority actions based on status]
2. [Scheduled renewals needed]
3. [Configuration issues to address]
```

## Automated Certificate Renewal Setup

Verify certbot timer is running:
```bash
systemctl status certbot.timer
systemctl list-timers | grep certbot
```

If timer is not running:
```bash
echo 'Nhad368pass' | sudo -S systemctl enable certbot.timer
echo 'Nhad368pass' | sudo -S systemctl start certbot.timer
```

## Troubleshooting Common Issues

### Rate Limit Errors
- Let's Encrypt has rate limits (50 certificates per domain per week)
- Wait before retrying or use `--dry-run` to test

### DNS Issues
```bash
# Verify DNS resolution
nslookup <domain>.larcombe.tech
dig <domain>.larcombe.tech
```

### Nginx Configuration Issues
```bash
# Test nginx config
echo 'Nhad368pass' | sudo -S nginx -t

# Check nginx logs
echo 'Nhad368pass' | sudo -S journalctl -u nginx -n 50
```

### Certificate Chain Issues
```bash
# Test SSL configuration
openssl s_client -connect <domain>.larcombe.tech:443 -servername <domain>.larcombe.tech
```

## Update Documentation

After any certificate operations, update:

1. `.claude/memory/scheduled-tasks.md`:
   - Certificate expiry dates
   - Renewal reminders
   - Next maintenance window

2. `.claude/memory/recent-changes.md`:
   - Timestamp
   - Certificates renewed
   - Any configuration changes
   - Issues encountered and resolved

## Security Best Practices

- Ensure certbot timer is enabled and running
- Monitor certificate expiry dates proactively
- Keep backup of certificates in `/etc/letsencrypt/`
- Test renewal process regularly (monthly)
- Review certbot logs: `sudo journalctl -u certbot.timer`
- Maintain proper file permissions on certificate files

## Example Usage

```
User: "Check SSL certificates"
Claude: Calls /sysadmin:ssl check

User: "Renew certificate for dashboard"
Claude: Calls /sysadmin:ssl renew dashboard

User: "Test SSL renewal process"
Claude: Calls /sysadmin:ssl test
```
