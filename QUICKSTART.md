# Quick Start Guide - Claude Code Sysadmin

Get Claude Code running as your system administrator in 5 minutes.

## Step 1: Install (2 minutes)

```bash
# Copy files to your server (use scp, rsync, or git clone)
cd /path/to/claude-code-sysadmin

# Run installation script
./install.sh

# Follow prompts (backs up existing files, installs to ~/)
```

## Step 2: Customize (1 minute)

Edit `~/CLAUDE.md` and update:

```bash
nano ~/CLAUDE.md
```

**Consider entering this information:**
- Sudo password 
- Server hostname
- Domain name
- Subnet

**Save and exit:** Ctrl+X, Y, Enter

## Step 3: Start Claude Code (30 seconds)

```bash
cd ~
claude
```

## Step 4: Discover Your System (1 minute)

In Claude Code, type:

```
/sysadmin:discover
```

This will:
- Scan your system
- Identify installed tools
- Map network topology
- Document services
- Create system inventory

## Step 5: Try It Out (30 seconds)

Ask Claude Code natural language questions:

```
How is the server doing?
```

```
Show me all running services
```

```
Check SSL certificates
```

```
What's using the most disk space?
```

## Common Tasks

### Create a New Website

```
Create a website for myapp running on port 3000
```

Claude will:
1. Create nginx configuration
2. Enable the site
3. Obtain SSL certificate
4. Verify it's working
5. Give you the URL: https://myapp.larcombe.tech

### Check System Health

```
Run a full health check
```

Claude will check:
- Service status
- Resource usage
- Docker containers
- SSL certificates
- Recent errors
- Give overall health score

### Manage Docker Services

```
Update Jellyfin to the latest version
```

```
Restart the Immich service
```

```
Show me logs for Frigate
```

### SSL Certificate Management

```
Check SSL certificate expiration dates
```

```
Renew certificate for dashboard
```

```
Test the certificate renewal process
```

## Using Slash Commands

Instead of natural language, you can use commands directly:

```
/sysadmin:health quick          # Quick health check
/sysadmin:docker status         # Show all containers
/sysadmin:ssl check             # Check certificates
/sysadmin:website myapp 3000    # Create website
```

## Tips for Best Results

### 1. Be Specific
❌ "Fix the thing"
✅ "Restart the Jellyfin service"

### 2. Ask for Verification
❌ Assume it worked
✅ "Did that restart successfully?"

### 3. Use Natural Language
You don't need to memorize commands:
- "How much disk space is left?"
- "When does the SSL certificate expire?"
- "Is everything running okay?"

### 4. Let Claude Plan
For complex tasks, let Claude make a plan:
- "I want to deploy a new service called 'dashboard'"
- Claude will ask what you need and plan the deployment

### 5. Regular Checks
Weekly: `How is the server doing?`
Monthly: `Check SSL certificates`
After changes: `Verify everything is running`

## Understanding the Memory System

Claude remembers your system configuration in `~/.claude/memory/`:

- **system-inventory.md** - What's installed, system specs
- **network-topology.md** - IP addresses, network config
- **scheduled-tasks.md** - Cron jobs, maintenance schedule
- **service-catalog.md** - All your services and their status
- **recent-changes.md** - Everything that was changed

You can read these files anytime:
```bash
cat ~/.claude/memory/service-catalog.md
```

## Troubleshooting

### "Command not found"
Check that files are in the right place:
```bash
ls ~/.claude/commands/
```
Should show: sysadmin-discover.md, sysadmin-website.md, etc.

### "Permission denied"
Claude needs sudo for most operations. Check:
```bash
sudo -l  # Verify you have sudo access
```

### "Service not found"
Run discovery again:
```
/sysadmin:discover
```

### Claude asks too many questions
Use skip permissions mode:
```bash
claude --dangerously-skip-permissions
```
⚠️ Only use in trusted environments!

## What's Next?

### Explore Memory Files
```bash
cd ~/.claude/memory
ls -la
cat service-catalog.md  # See all your services
```

### Read Full Documentation
```bash
cd /path/to/claude-code-sysadmin
cat README.md  # Complete guide
```

### Customize Commands
Create your own commands:
```bash
nano ~/.claude/commands/my-command.md
```

### Review Recent Changes
See what Claude has done:
```bash
cat ~/.claude/memory/recent-changes.md
```

## Example Session

Here's a typical session:

```
You: How is the server?
Claude: [Runs health check]
        ✅ All services running
        ⚠️  Disk usage at 78%
        ⚠️  SSL cert for dashboard.larcombe.tech expires in 25 days
        Overall Health: 85/100 (Good)

You: Clean up some disk space
Claude: [Runs Docker cleanup]
        Removed 15GB of unused Docker images
        Disk usage now at 65%

You: Renew that SSL certificate
Claude: [Renews certificate]
        ✅ Certificate renewed for dashboard.larcombe.tech
        New expiry: March 15, 2026

You: Perfect, thanks!
```

## Pro Tips

### 1. Chain Commands
```
Check the health, then if there are issues, fix them
```

### 2. Ask for Reports
```
Give me a weekly system health report
```

### 3. Schedule Reminders
```
Remind me to check backups every Monday
```
(Claude will add to scheduled-tasks.md)

### 4. Learn from History
```
What changes were made last week?
```

### 5. Use It for Learning
```
Explain how nginx reverse proxy works on this server
```

## Need Help?

1. **Ask Claude**: "How do I [task]?"
2. **Check CLAUDE.md**: `cat ~/CLAUDE.md`
3. **Read README**: Full documentation in setup directory
4. **Review Memory**: `ls ~/.claude/memory/`

## Safety Features

Claude Code is designed to be safe:

✅ Tests configurations before applying (nginx -t)
✅ Backs up before modifications
✅ Verifies after changes
✅ Logs all operations
✅ Provides rollback procedures
✅ Asks for confirmation on destructive operations

## Success Checklist

After setup, you should be able to:

- [ ] Ask "How is the server?" and get a health report
- [ ] Run `/sysadmin:discover` successfully
- [ ] View all services with "Show me all services"
- [ ] Check SSL certificates
- [ ] Create a test website (if you want to test)
- [ ] See your system specs in ~/.claude/memory/system-inventory.md

## You're Ready!

Claude Code is now your system administrator. Just ask what you need in plain English and Claude will handle the technical details.

**Start with:**
```
Give me a system overview
```

Then explore from there!

---

**Installation time**: 5 minutes
**Learning curve**: 10 minutes
**Time saved per week**: 5-10 hours

Happy administrating! 🚀
