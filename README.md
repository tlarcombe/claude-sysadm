# Claude Code - Linux System Administrator Configuration

Transform Claude Code into an intelligent Linux system administrator with this comprehensive configuration package. Automate server management, deployment, monitoring, and maintenance tasks using natural language.

## What is Claude-Sysadm?

Claude-Sysadm is a configuration framework that enables Claude Code to function as a knowledgeable Linux system administrator. It provides:

- **Automated System Discovery** - Automatically inventory hardware, software, services, and network configuration
- **Website Deployment** - One-command deployment of websites with nginx reverse proxy and SSL certificates
- **Health Monitoring** - Comprehensive system health checks with automated reporting
- **Docker Management** - Full lifecycle management of Docker services
- **SSL Certificate Management** - Automated SSL certificate deployment, monitoring, and renewal
- **Persistent Memory** - Maintains system knowledge across sessions
- **Natural Language Interface** - Describe what you want in plain English, no command memorization needed

## Features

### Automation Capabilities
- ✅ Website setup (directory creation, nginx config, SSL certificate)
- ✅ Service deployment (Docker Compose setup and management)
- ✅ System discovery (installed packages, network topology, running services)
- ✅ Health checks and monitoring
- ✅ Backup verification
- ✅ Log analysis
- ✅ Security audits
- ✅ SSL certificate lifecycle management

### Intelligent Memory System
Claude-Sysadm maintains persistent knowledge about your server:
- System inventory (hardware, OS, installed tools)
- Network topology (IPs, routing, open ports, DNS)
- Service catalog (all services, health status, access URLs)
- Scheduled tasks (cron jobs, systemd timers, maintenance windows)
- Change history (complete audit trail of all operations)

## Installation

### Prerequisites
- Ubuntu/Debian-based Linux server (tested on Ubuntu 25.04)
- Claude Code CLI installed ([Get it here](https://claude.ai/code))
- sudo access on the target server
- (Optional) Docker for container management
- (Optional) nginx for web service management

### Quick Install

Use the automated installer:

```bash
# Clone the repository
git clone https://github.com/yourusername/claude-sysadm.git
cd claude-sysadm

# Run the installer
./install.sh
```

The installer will:
1. Create `~/.claude/` directory structure
2. Copy all configuration files
3. Set proper permissions
4. Initialize memory files
5. Create CLAUDE.md in your home directory

### Manual Install

If you prefer manual installation:

```bash
# Create directory structure
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/memory

# Copy configuration files
cp CLAUDE.md ~/CLAUDE.md
cp -r .claude/commands/* ~/.claude/commands/
cp -r .claude/memory/* ~/.claude/memory/

# Set permissions
chmod 600 ~/CLAUDE.md
chmod -R 700 ~/.claude/
```

### Post-Installation Setup

1. **Review CLAUDE.md**: Edit `~/CLAUDE.md` and customize for your environment:
   - Update domain names if using a web server
   - Configure sudo password (or leave blank for manual entry)
   - Adjust paths to match your server layout

2. **Run Initial Discovery**: Start Claude Code and run system discovery:
   ```bash
   cd ~
   claude
   ```
   Then in Claude Code:
   ```
   /sysadmin:discover
   ```

3. **Verify Setup**: Check that memory files were populated:
   ```bash
   ls -la ~/.claude/memory/
   cat ~/.claude/memory/system-inventory.md
   ```

## Usage

### Available Slash Commands

#### `/sysadmin:discover`
Performs comprehensive system discovery and populates all memory files.

```
/sysadmin:discover
```

**What it does:**
- Identifies hardware specifications
- Catalogs installed software and versions
- Maps network topology and configuration
- Documents running services and containers
- Inventories scheduled tasks and timers
- Creates baseline system inventory

#### `/sysadmin:website <name> [port] [type]`
Automated website deployment with nginx and SSL.

```
/sysadmin:website myapp 3000 proxy
/sysadmin:website landing 80 static
```

**Parameters:**
- `name` - Subdomain name (required)
- `port` - Backend service port (default: 8080)
- `type` - "proxy" for reverse proxy or "static" for static files (default: proxy)

**What it does:**
1. Creates web directory structure
2. Generates nginx configuration
3. Tests configuration syntax
4. Enables the site
5. Obtains SSL certificate via Let's Encrypt
6. Verifies deployment
7. Updates service catalog

#### `/sysadmin:ssl [action] [domain]`
SSL certificate lifecycle management.

```
/sysadmin:ssl check              # Check all certificates
/sysadmin:ssl list               # List certificates with expiry dates
/sysadmin:ssl renew myapp        # Renew specific certificate
/sysadmin:ssl test               # Test renewal process (dry run)
```

**What it does:**
- Lists all SSL certificates
- Checks expiry dates
- Identifies certificates expiring soon
- Tests renewal process
- Renews certificates manually or automatically
- Creates maintenance reminders

#### `/sysadmin:health [scope]`
Comprehensive system health monitoring.

```
/sysadmin:health quick           # Quick check (< 30 seconds)
/sysadmin:health full            # Full check (< 2 minutes)
/sysadmin:health deep            # Deep analysis (< 5 minutes)
```

**What it checks:**
- CPU usage and load average
- Memory utilization
- Disk space (all mounts)
- Service status (nginx, docker, databases)
- Docker container health
- Network connectivity
- Recent errors in logs
- Backup status
- SSL certificate expiry
- Overall health score with recommendations

#### `/sysadmin:docker [action] [service]`
Full Docker service lifecycle management.

```
/sysadmin:docker status          # Show all services
/sysadmin:docker restart myapp   # Restart specific service
/sysadmin:docker update myapp    # Update to latest image
/sysadmin:docker logs myapp      # View service logs
/sysadmin:docker cleanup         # Clean up unused resources
```

**What it does:**
- Lists all Docker Compose projects
- Shows service status and health
- Manages service lifecycle (start/stop/restart)
- Updates images and recreates containers
- Views logs in real-time
- Cleans up unused images, containers, volumes
- Updates service catalog automatically

### Natural Language Interface

You don't need to memorize slash commands. Just describe what you want:

**Website Deployment:**
- "Create a website for my dashboard app on port 3000"
- "Set up a new static site for my blog"
- "Deploy a reverse proxy for my API service"

**Health Monitoring:**
- "How is the server doing?"
- "Check if everything is running OK"
- "Are there any problems I should know about?"

**Service Management:**
- "Restart the database service"
- "Update all Docker containers"
- "Show me the logs for the web application"

**SSL Certificates:**
- "Check when SSL certificates expire"
- "Renew the certificate for my website"
- "Are any certificates expiring soon?"

**System Information:**
- "What version of nginx is installed?"
- "How much disk space is available?"
- "Show me the network configuration"

## Memory System

Claude-Sysadm maintains persistent knowledge in `~/.claude/memory/`:

### system-inventory.md
- Hardware specifications (CPU, memory, storage)
- Operating system details
- Installed tools and versions
- Resource usage baselines
- System capabilities
- Missing tools that could be installed

### network-topology.md
- Network interfaces and IP addresses
- Routing table
- DNS configuration
- NFS mounts and network storage
- Open ports and listening services
- Firewall rules
- Network security configuration

### scheduled-tasks.md
- Cron jobs (user and system)
- Systemd timers
- Backup schedules
- Maintenance windows
- SSL certificate renewal schedule
- Upcoming maintenance reminders

### service-catalog.md
- All deployed services (Docker and system)
- Service locations and configurations
- Current status and health
- Access URLs and ports
- Update history
- Service dependencies

### recent-changes.md
- Complete change log
- Configuration modifications
- Service deployments and updates
- Issue resolutions
- Rollback instructions
- Monthly summaries

## Examples

### Example 1: Deploy a New Web Service

**User:** "I want to deploy a new web dashboard running on port 3000"

**Claude Code automatically:**
1. Creates nginx reverse proxy configuration
2. Tests the configuration
3. Enables the site
4. Obtains SSL certificate from Let's Encrypt
5. Verifies the deployment
6. Updates service-catalog.md
7. Logs the change in recent-changes.md
8. Provides the HTTPS URL

**Result:** Your dashboard is live at `https://dashboard.yourdomain.com` with automatic HTTPS.

### Example 2: System Health Check

**User:** "Is the server healthy?"

**Claude Code automatically:**
1. Checks CPU, memory, and disk usage
2. Verifies all critical services are running
3. Checks Docker container health
4. Reviews recent error logs
5. Verifies backup status
6. Checks SSL certificate expiry
7. Calculates overall health score
8. Provides detailed report with recommendations

**Result:** Comprehensive health report with actionable recommendations.

### Example 3: Update a Service

**User:** "Update the Jellyfin media server to the latest version"

**Claude Code automatically:**
1. Backs up the current docker-compose.yml
2. Pulls the latest Jellyfin image
3. Recreates the container with new image
4. Verifies service is running properly
5. Checks logs for errors
6. Updates service-catalog.md with new version
7. Logs the change in recent-changes.md

**Result:** Service updated with full audit trail and verification.

## Directory Structure

```
claude-sysadm/
├── .claude/
│   ├── commands/                 # Slash commands
│   │   ├── sysadmin-discover.md  # System discovery
│   │   ├── sysadmin-website.md   # Website deployment
│   │   ├── sysadmin-ssl.md       # SSL management
│   │   ├── sysadmin-health.md    # Health monitoring
│   │   └── sysadmin-docker.md    # Docker management
│   │
│   └── memory/                   # Persistent knowledge
│       ├── system-inventory.md   # Hardware, OS, tools
│       ├── network-topology.md   # Network configuration
│       ├── scheduled-tasks.md    # Cron, timers, schedules
│       ├── service-catalog.md    # All services and status
│       └── recent-changes.md     # Complete change log
│
├── CLAUDE.md                     # Main configuration file
├── install.sh                    # Automated installer
├── QUICKSTART.md                 # Quick start guide
├── PROJECT_STRUCTURE.md          # Detailed structure documentation
└── README.md                     # This file
```

## Best Practices

### 1. Run Discovery First
After installation, always run `/sysadmin:discover` to populate memory files with your actual system configuration.

### 2. Regular Health Checks
Schedule regular health checks to catch issues early:
```
/sysadmin:health full
```

### 3. Review Change Log
Periodically review `recent-changes.md` to maintain awareness of all system modifications.

### 4. Keep Memory Files Updated
Memory files are automatically updated by commands, but verify accuracy periodically.

### 5. Use Natural Language
Don't memorize commands - describe what you want in plain English. Claude Code will figure out the right approach.

### 6. Test Before Production
Test new procedures in a development environment before applying to production servers.

### 7. Maintain Backups
Ensure regular backups are configured and verified. Use Claude Code to check backup status.

## Security Considerations

### Sudo Password
The configuration can include sudo password for full automation. This is appropriate for:
- Test/lab environments
- Trusted single-user servers
- Development environments

For production environments:
- Remove password from CLAUDE.md (Claude will prompt)
- Use `NOPASSWD` in sudoers for specific commands
- Use a dedicated automation account with limited privileges

### File Permissions
Ensure proper permissions:
```bash
chmod 600 ~/CLAUDE.md          # Protect main config
chmod -R 700 ~/.claude/        # Protect all Claude files
```

### Secrets Management
- Never store API keys or passwords in CLAUDE.md
- Use environment variables for sensitive data
- Protect .env files with appropriate permissions
- Rotate credentials regularly

### Audit Trail
All changes are logged in `recent-changes.md` for security auditing.

## Troubleshooting

### Commands Not Found
If slash commands don't work:
1. Verify `~/.claude/commands/` exists and contains .md files
2. Check file permissions are readable
3. Restart Claude Code

### Memory Not Persisting
If memory files aren't being updated:
1. Check `~/.claude/memory/` directory exists and is writable
2. Verify disk space is available
3. Check for permission issues

### Sudo Operations Fail
If sudo operations fail:
1. Verify user has sudo privileges: `sudo -l`
2. Check password in CLAUDE.md is correct (if using)
3. Consider NOPASSWD for specific commands

### Discovery Doesn't Find Services
If `/sysadmin:discover` misses services:
1. Ensure services are actually running
2. Check paths in CLAUDE.md match actual locations
3. Verify permissions to read service files

## Customization

### Adding Custom Commands
Create new commands in `~/.claude/commands/`:

```bash
cat > ~/.claude/commands/mycommand.md <<'EOF'
# My Custom Command

Your command description and instructions here.

Arguments: $ARGUMENTS

## Steps
1. First step
2. Second step
3. Third step
EOF
```

### Extending Memory
Add custom memory files for specific tracking needs:

```bash
cat > ~/.claude/memory/custom-tracking.md <<'EOF'
# Custom Tracking

Your custom data structure here.
EOF
```

### Modifying CLAUDE.md
Edit `~/CLAUDE.md` to add:
- Custom workflows
- Application-specific procedures
- Team processes
- Environment-specific configurations

## Multiple Servers

To use Claude-Sysadm on multiple servers:

1. Install on each server
2. Run `/sysadmin:discover` on each
3. Each server maintains its own memory files
4. Update CLAUDE.md with server-specific details

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch
3. Test your changes thoroughly
4. Submit a pull request with detailed description

Areas for contribution:
- New slash commands
- Additional monitoring capabilities
- Support for more Linux distributions
- Integration with other tools
- Documentation improvements

## Support

### Getting Help
- Check `CLAUDE.md` for server-specific documentation
- Review memory files for current system state
- Ask Claude Code directly: "How do I...?"
- Check the issue tracker on GitHub

### Reporting Issues
When reporting issues, include:
- Your Linux distribution and version
- Output of `/sysadmin:discover`
- Contents of relevant memory files
- Steps to reproduce the issue
- Error messages or logs

## Roadmap

Planned features:
- [ ] Support for RedHat/CentOS/Fedora
- [ ] Apache web server support
- [ ] PostgreSQL database management
- [ ] Kubernetes cluster management
- [ ] Automated security scanning
- [ ] Performance optimization suggestions
- [ ] Cloud provider integration (AWS, GCP, Azure)
- [ ] Multi-server orchestration

## License

MIT License - See LICENSE file for details

## Acknowledgments

- Built for [Claude Code](https://claude.ai/code) by Anthropic
- Inspired by modern DevOps practices
- Designed for system administrators who value automation

## Version History

- **v1.0.0** (2025-10-25): Initial public release
  - Core sysadmin commands
  - Memory system
  - Automated website deployment
  - SSL management
  - Health monitoring
  - Docker management

---

**Ready to transform Claude Code into your system administrator?**

[Install Now](#installation) | [Quick Start Guide](QUICKSTART.md) | [Report Issue](https://github.com/yourusername/claude-sysadm/issues)
