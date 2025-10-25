# Claude Code - Linux System Administrator Configuration

**Replace your human system administrator with Claude Code** - a fully-capable, intelligent Linux system administrator that can install, configure, manage, and troubleshoot any software or system with the flexibility and expertise of a seasoned Linux professional.

## What is Claude-Sysadm?

Claude-Sysadm is **not just a tool** - it's a complete replacement for a human Linux system administrator. While traditional automation tools are limited to pre-programmed tasks, Claude-Sysadm brings the full reasoning capability and adaptability of Claude Code to server management.

**Unlike rigid automation scripts, Claude-Sysadm can:**
- Understand and execute complex, multi-step operations from natural language descriptions
- Adapt to unique server configurations and edge cases
- Learn from your server's specific setup and history
- Troubleshoot issues by analyzing logs, testing hypotheses, and applying fixes
- Install and configure any software - not just what's pre-scripted
- Make intelligent decisions based on context and best practices
- Respond to unexpected situations with human-like problem-solving

This repository provides a **starting framework** with ready-to-use commands that make Claude-Sysadm productive from the moment of installation. However, these are merely examples of what Claude can do - **not limitations**. Claude-Sysadm has the full capability to perform any Linux system administration task a human administrator could perform.

### Core Philosophy

**Think of Claude-Sysadm as hiring a senior Linux system administrator who:**
- Never forgets system details (persistent memory)
- Works 24/7 without fatigue
- Documents every change automatically
- Follows best practices consistently
- Can learn new technologies on-demand
- Communicates in natural language
- Never makes careless mistakes (always tests before applying changes)

The included slash commands and automation scripts are **convenience features** - helpful shortcuts for common tasks. The real power is Claude's ability to handle **any** system administration task you can describe.

## What Claude-Sysadm Can Actually Do

**Everything a human system administrator can do**, including but not limited to:

### Software Management (Beyond the Included Scripts)
- Install, configure, and manage **any** software package or application
- Build software from source with custom compilation flags
- Manage package repositories and dependencies
- Configure complex software stacks (LAMP, LEMP, Kubernetes, etc.)
- Migrate applications between servers
- Troubleshoot software conflicts and dependency issues

### System Administration (Full Scope)
- User and permission management
- Kernel tuning and system optimization
- Storage management (LVM, RAID, partitioning)
- Backup and disaster recovery planning
- System hardening and security audits
- Performance analysis and optimization
- Resource monitoring and capacity planning

### Network Administration (Complete Capability)
- Firewall configuration (iptables, nftables, ufw)
- VPN setup and management (OpenVPN, WireGuard, IPSec)
- DNS server configuration (BIND, dnsmasq)
- Load balancer setup (HAProxy, nginx)
- Network troubleshooting and diagnostics
- VLAN and routing configuration

### Service & Application Deployment (Unlimited)
- Web servers (nginx, Apache, Caddy, Lighttpd)
- Databases (PostgreSQL, MySQL/MariaDB, MongoDB, Redis)
- Container orchestration (Docker, Kubernetes, Podman)
- CI/CD pipelines (Jenkins, GitLab CI, GitHub Actions)
- Monitoring stacks (Prometheus, Grafana, ELK)
- **Any other service you can name**

### The Included Scripts Are Just a Head Start

This repository includes **5 pre-built slash commands** for common tasks:
- `/sysadmin:discover` - System discovery and inventory
- `/sysadmin:website` - Automated website deployment with nginx and SSL
- `/sysadmin:ssl` - SSL certificate lifecycle management
- `/sysadmin:health` - Comprehensive system health monitoring
- `/sysadmin:docker` - Docker service lifecycle management

**But you don't need these commands to use Claude-Sysadm.** They're convenience features that save time on frequent operations. For anything else, just describe what you need in natural language:

- "Install PostgreSQL 15 with optimized settings for a 16GB RAM server"
- "Set up a Kubernetes cluster with 3 worker nodes"
- "Migrate this Apache configuration to nginx"
- "Find out why the server is running slow and fix it"
- "Set up automated offsite backups to S3"
- "Configure fail2ban to protect SSH and ban aggressive scanners"

Claude-Sysadm will understand, plan, and execute - just like a human sysadmin would.

## Installation

### Prerequisites
- **Any Linux-based server** (Ubuntu, Debian, RedHat, CentOS, Fedora, Arch, etc.)
- Claude Code CLI installed ([Get it here](https://claude.ai/code))
- sudo access on the target server
- **That's it** - Claude can help you install anything else you need

### Quick Install

Use the automated installer:

```bash
# Clone the repository
git clone https://github.com/tlarcombe/claude-sysadm.git
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
6. Install `claude-sysadm` command for automatic permission approval

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

2. **Run Initial Discovery**: Start Claude-Sysadm and run system discovery:
   ```bash
   cd ~
   claude-sysadm
   ```
   Then in Claude Code:
   ```
   /sysadmin:discover
   ```

3. **Start using natural language**: Claude-Sysadm is now ready to handle any system administration task you throw at it.

### Running Claude-Sysadm

The installer creates two ways to run Claude Code:

**`claude-sysadm` (Recommended for System Administration)**
```bash
claude-sysadm
```
- Runs with `--dangerously-skip-permissions` flag
- Automatically approves all actions without prompting
- Perfect for trusted system administration tasks
- Claude can work autonomously without interruption
- Full automation - just describe what you want done

**`claude` (Standard Mode)**
```bash
claude
```
- Prompts for approval before each action
- Safer for testing or when you want to review each step
- Good for learning what Claude will do
- Can interrupt or modify actions before they execute

**Which should you use?**
- Use `claude-sysadm` when you trust Claude to manage your server (most system administration tasks)
- Use `claude` when testing new procedures or learning what Claude does
- Both commands access the same configuration and memory files

## Usage - The Power of Natural Language

**You don't need to memorize commands or scripts.** Just tell Claude what you want in plain English (or any language Claude supports).

### Beyond Pre-Scripted Commands

While the included slash commands are useful shortcuts, Claude-Sysadm's real power is its ability to handle **any** system administration task through natural language.

**Real-world examples:**

"I need to set up a high-availability PostgreSQL cluster with automatic failover"
- Claude will research the current best practices
- Install and configure PostgreSQL with streaming replication
- Set up Patroni or similar HA solution
- Configure automatic failover
- Test the setup
- Document everything in memory files

"Our website is loading slowly, figure out what's wrong and fix it"
- Claude will check server resources (CPU, RAM, disk I/O)
- Analyze web server logs and configuration
- Check database query performance
- Identify bottlenecks (e.g., missing indexes, inefficient queries)
- Implement optimizations
- Verify improvements
- Document the issue and resolution

"Install and configure a mail server with spam filtering and DKIM"
- Claude will install Postfix/Dovecot
- Configure SPF, DKIM, and DMARC
- Set up SpamAssassin or rspamd
- Configure SSL/TLS
- Test email delivery
- Document the configuration

"Migrate our Docker setup to Kubernetes"
- Claude will analyze your current Docker Compose files
- Design an appropriate Kubernetes architecture
- Write Kubernetes manifests (Deployments, Services, Ingress)
- Set up persistent storage
- Migrate data
- Test the migration
- Document the new architecture

"The server got compromised last night, help me lock it down"
- Claude will assess the damage
- Review logs to understand the intrusion
- Remove malicious files/backdoors
- Patch vulnerabilities
- Harden the system
- Set up monitoring to prevent recurrence
- Document the incident

### The Included Slash Commands (Convenience Features)

For frequently-performed tasks, we've included ready-to-use automation scripts:

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
- Service status
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

### More Natural Language Examples

**Software Installation:**
- "Install the latest stable version of Node.js with npm"
- "Set up Python 3.11 with virtualenv and pip"
- "Install Docker and Docker Compose"
- "I need Redis with persistence enabled"

**Configuration Management:**
- "Increase PHP memory limit to 512MB"
- "Configure MySQL for optimal performance on this hardware"
- "Set up automatic security updates"
- "Enable HTTP/2 in nginx"

**Security & Access:**
- "Create a new user called 'deploy' with sudo access"
- "Set up SSH key authentication and disable password login"
- "Configure the firewall to only allow ports 22, 80, and 443"
- "Show me all listening ports and what's using them"

**Troubleshooting:**
- "Why is disk usage at 95%? Clean up what's safe to remove"
- "The database is using too much memory, investigate and fix"
- "Check if we're under DDoS attack"
- "Apache won't start, figure out why and fix it"

**Monitoring & Maintenance:**
- "Set up automated daily backups to /mnt/backup"
- "Install and configure Prometheus and Grafana"
- "Create a cron job to restart this service daily at 3 AM"
- "Show me a summary of all logged errors from the past 24 hours"

## Memory System - Claude's Permanent Knowledge

Unlike traditional tools that start fresh each time, Claude-Sysadm maintains **persistent memory** of your server in `~/.claude/memory/`. This allows Claude to build institutional knowledge about your infrastructure over time.

### system-inventory.md
- Hardware specifications (CPU, memory, storage)
- Operating system details
- Installed tools and versions
- Resource usage baselines
- System capabilities
- Custom software and configurations

### network-topology.md
- Network interfaces and IP addresses
- Routing table
- DNS configuration
- Network mounts and storage
- Open ports and listening services
- Firewall rules
- VPN configurations
- Network security setup

### scheduled-tasks.md
- Cron jobs (user and system)
- Systemd timers
- Backup schedules
- Maintenance windows
- SSL certificate renewal schedule
- Recurring maintenance tasks
- Update schedules

### service-catalog.md
- All deployed services (Docker, systemd, and custom)
- Service locations and configurations
- Current status and health
- Access URLs and ports
- Dependencies
- Update history
- Performance baselines

### recent-changes.md
- Complete change log with timestamps
- Configuration modifications
- Service deployments and updates
- Issue resolutions
- Rollback instructions
- Performance impacts
- Monthly summaries

**The memory system means:** Claude remembers your server's quirks, your preferences, past issues, and solutions. It learns from every interaction, becoming more valuable over time - just like a human sysadmin who's been managing your infrastructure for years.

## Real-World Examples

### Example 1: Complete Application Stack Deployment

**User:** "Set up a production-ready WordPress site with nginx, PHP-FPM, MariaDB, Redis caching, automatic backups, and SSL"

**Claude-Sysadm automatically:**
1. Installs and configures nginx with optimal settings
2. Installs PHP-FPM with required extensions
3. Sets up MariaDB with secure configuration
4. Installs and configures Redis for object caching
5. Downloads and configures WordPress
6. Generates nginx configuration with caching rules
7. Obtains SSL certificate from Let's Encrypt
8. Configures automated daily backups
9. Sets up log rotation
10. Implements security hardening
11. Tests the entire stack
12. Documents everything in memory files
13. Provides access credentials and URLs

**Result:** Production-ready WordPress site in minutes, not hours.

### Example 2: Security Incident Response

**User:** "I'm seeing weird traffic patterns and high CPU usage. Investigate whether we're compromised and secure the server"

**Claude-Sysadm automatically:**
1. Checks currently running processes for anomalies
2. Analyzes network connections for suspicious activity
3. Reviews auth logs for unauthorized access attempts
4. Scans for rootkits and malware
5. Checks crontabs for malicious scheduled tasks
6. Reviews file modifications in critical directories
7. If compromise found: isolates the system, removes threats
8. Hardens security (firewall rules, fail2ban, SSH hardening)
9. Implements monitoring for similar threats
10. Documents the incident and response
11. Provides detailed report and recommendations

**Result:** Comprehensive security audit and remediation by an expert.

### Example 3: Performance Optimization

**User:** "Our application is slow. Do a full performance analysis and optimize everything you can"

**Claude-Sysadm automatically:**
1. Profiles CPU, memory, disk, and network usage
2. Analyzes application logs for slow queries/requests
3. Checks database for missing indexes
4. Reviews web server configuration
5. Tests network latency and bandwidth
6. Identifies bottlenecks (e.g., slow disk I/O)
7. Implements optimizations:
   - Tunes database configuration
   - Optimizes web server settings
   - Adds caching layers
   - Fixes slow queries
   - Adjusts system parameters
8. Measures improvements
9. Documents changes and performance gains

**Result:** Measurably faster application with documented improvements.

### Example 4: Infrastructure Migration

**User:** "Migrate all our services from this server to the new server at 192.168.1.50, keeping everything running during the migration"

**Claude-Sysadm automatically:**
1. Inventories all services on source server
2. Plans migration strategy for zero downtime
3. Prepares target server (installs required software)
4. Backs up all data and configurations
5. Migrates databases with replication
6. Transfers application files
7. Replicates configurations
8. Tests services on target server
9. Performs cutover (updates DNS, changes load balancer)
10. Monitors for issues
11. Verifies migration success
12. Documents new infrastructure layout

**Result:** Seamless migration managed by an experienced professional.

## Why Claude-Sysadm is Different

### Traditional Automation vs. Claude-Sysadm

| Traditional Tools | Claude-Sysadm |
|-------------------|---------------|
| Limited to pre-written scripts | Can handle any task you describe |
| Rigid, can't adapt to edge cases | Adapts to unique situations |
| Requires programming skills | Natural language interface |
| No understanding of context | Understands your environment and history |
| Can't troubleshoot unexpected issues | Debugs and solves problems like a human |
| Fixed capabilities | Learns and grows with your needs |
| No memory between runs | Maintains persistent knowledge |
| One-size-fits-all approach | Customizes to your specific setup |

### The Human Element

Claude-Sysadm brings **human-like reasoning** to server management:

- **Contextual awareness**: Understands your server's history and configuration
- **Problem-solving**: Can troubleshoot issues by testing hypotheses
- **Learning**: Improves its understanding of your infrastructure over time
- **Communication**: Explains what it's doing and why
- **Judgment**: Makes decisions based on best practices and your specific situation
- **Adaptability**: Handles unexpected situations gracefully
- **Documentation**: Automatically documents all work

## Directory Structure

```
claude-sysadm/
├── .claude/
│   ├── commands/                 # Optional convenience commands
│   │   ├── sysadmin-discover.md  # System discovery
│   │   ├── sysadmin-website.md   # Website deployment
│   │   ├── sysadmin-ssl.md       # SSL management
│   │   ├── sysadmin-health.md    # Health monitoring
│   │   └── sysadmin-docker.md    # Docker management
│   │
│   └── memory/                   # Persistent knowledge base
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
After installation, run `/sysadmin:discover` to populate Claude's memory with your server's current state.

### 2. Be Specific When Needed, General When Appropriate
- Specific: "Install PostgreSQL 14 with these custom settings: max_connections=200, shared_buffers=4GB"
- General: "Set up a secure mail server" (Claude will choose appropriate software and configuration)

### 3. Review Change Log Regularly
Check `recent-changes.md` to see what Claude has been doing on your server.

### 4. Leverage Persistent Memory
Claude remembers previous conversations and work. Reference past tasks: "Use the same configuration we used for the staging server"

### 5. Ask Claude to Explain
If you're unsure about something: "Explain what you're going to do before you do it"

### 6. Test in Development First
For critical infrastructure, test changes in a dev environment: "Show me what you would do, but don't apply it yet"

### 7. Use Claude for Learning
"Explain how to set up X" or "What's the best practice for Y?" - Claude is also an excellent teacher.

## Security Considerations

### The `claude-sysadm` Command

The installer creates a `claude-sysadm` command that runs Claude Code with automatic permission approval (`--dangerously-skip-permissions`). This means Claude can execute commands without asking for confirmation.

**When to use `claude-sysadm`:**
- Trusted environments (your own servers)
- Routine system administration tasks
- When you want full automation
- After you're comfortable with how Claude works

**When to use standard `claude`:**
- First time using Claude-Sysadm
- Testing new procedures
- Production servers where you want oversight
- When learning what Claude will do

**Security note:** The `claude-sysadm` command is designed for administrators who trust Claude to manage their infrastructure. Claude has built-in safety features (tests before applying, follows best practices, documents all changes), but automatic approval means you won't review each action. Use standard `claude` mode if you prefer manual approval.

### Sudo Access
Claude-Sysadm needs sudo access to perform system administration tasks - just like a human sysadmin would.

**Configuration options:**
- **Include password in CLAUDE.md**: Full automation (appropriate for test/lab/single-user environments)
- **Prompt for password**: Claude will ask when needed (good for production)
- **NOPASSWD sudo**: Configure sudoers for passwordless sudo (balance of convenience and security)

### File Permissions
Protect configuration files:
```bash
chmod 600 ~/CLAUDE.md          # Only you can read it
chmod -R 700 ~/.claude/        # Only you can access Claude's files
```

### Audit Trail
Every action is logged in `recent-changes.md` - you have a complete audit trail of all system modifications.

### Claude's Safety Features
- Always tests configurations before applying (e.g., `nginx -t`)
- Asks for confirmation on destructive operations by default
- Documents rollback procedures for changes
- Follows security best practices
- Never exposes sensitive data unnecessarily

## Troubleshooting

### Commands Not Found
If slash commands don't work:
1. Verify `~/.claude/commands/` exists and contains .md files
2. Restart Claude Code
3. **Remember**: You don't need slash commands - just use natural language

### Memory Not Persisting
If memory files aren't being updated:
1. Check `~/.claude/memory/` directory exists and is writable
2. Verify disk space is available
3. Check file permissions

### Sudo Operations Fail
1. Verify user has sudo privileges: `sudo -l`
2. Check password in CLAUDE.md if using
3. Try manual sudo to confirm it works

### Claude Seems Limited
If Claude seems unable to do something:
- Be more specific about what you want
- Ask "Can you help me with X?" before assuming it can't
- Remember: Claude can do anything a human sysadmin can do

## Extending Claude-Sysadm

### Adding Your Own Convenience Commands

Create custom slash commands for tasks you do frequently:

```bash
cat > ~/.claude/commands/deploy-myapp.md <<'EOF'
# Deploy MyApp

Deploy the MyApp application with all dependencies.

## Steps
1. Pull latest code from Git
2. Install dependencies
3. Run database migrations
4. Restart services
5. Verify deployment
EOF
```

### Customizing CLAUDE.md

Edit `~/CLAUDE.md` to add:
- Your organization's standards and procedures
- Specific server configurations
- Custom workflows
- Team conventions
- Application-specific knowledge

This makes Claude even more tailored to your environment.

## Multiple Servers

Deploy Claude-Sysadm to all your servers:

```bash
# On each server
git clone https://github.com/tlarcombe/claude-sysadm.git
cd claude-sysadm
./install.sh
```

Each server maintains its own memory, but Claude can help you manage multiple servers: "Check the disk space on all application servers" or "Deploy this configuration to prod-web-01, prod-web-02, and prod-web-03"

## Contributing

We welcome contributions! This project demonstrates what's possible when AI meets system administration.

**Areas for contribution:**
- Additional convenience commands for common tasks
- Integration with monitoring/alerting platforms
- Support for specific Linux distributions
- Documentation improvements
- Real-world usage examples

**To contribute:**
1. Fork the repository
2. Create a feature branch
3. Test thoroughly
4. Submit a pull request with detailed description

## Support

### Getting Help

- **Ask Claude directly**: "How do I...?" - Claude can help you use Claude-Sysadm
- Check `CLAUDE.md` for system-specific documentation
- Review memory files for current system state
- Check the [issue tracker](https://github.com/tlarcombe/claude-sysadm/issues)

### Reporting Issues

When reporting issues, include:
- Linux distribution and version
- Output of `/sysadmin:discover`
- What you tried and what happened
- Any error messages

## Frequently Asked Questions

**Q: Can Claude-Sysadm really do anything a human sysadmin can do?**
A: Yes. Claude has the same problem-solving capabilities, can read documentation, follow tutorials, and adapt to situations just like a human. The included scripts are just conveniences - not limitations.

**Q: What if I need to do something not covered by the slash commands?**
A: Just describe it in natural language. The slash commands are optional shortcuts, not requirements.

**Q: Can Claude-Sysadm learn our company's specific procedures?**
A: Absolutely. Add your procedures to CLAUDE.md, and Claude will follow them. Claude also learns from the work it does via persistent memory.

**Q: Is it safe to give Claude sudo access?**
A: Claude has safety features (testing before applying, asking for confirmation, documenting changes). Many users trust Claude with root access. Use the authentication method that matches your risk tolerance.

**Q: Can Claude work with software it hasn't seen before?**
A: Yes. Claude can read documentation, analyze configurations, and figure out how to work with new software - just like a human sysadmin learning a new tool.

**Q: How is this different from Ansible/Puppet/Chef?**
A: Those are excellent tools for codified, repeatable automation. Claude-Sysadm is for the flexible, adaptive, problem-solving work that humans do. Use both together.

**Q: What's the difference between `claude-sysadm` and `claude`?**
A: `claude-sysadm` runs with automatic permission approval (--dangerously-skip-permissions), so Claude can work without asking for confirmation on each action. Standard `claude` prompts you to approve each operation. Use `claude-sysadm` for trusted system administration, use `claude` when you want oversight.

**Q: Is it safe to use `claude-sysadm` with auto-approval?**
A: Claude has built-in safety features (tests before applying, follows best practices, documents everything). Use `claude-sysadm` in environments where you trust Claude to manage the server. For production or when learning, start with standard `claude` mode.

## Roadmap

**Potential future enhancements:**
- Pre-built commands for more specific scenarios
- Integration with popular monitoring platforms
- Multi-server orchestration scripts
- Disaster recovery playbooks
- Security compliance automation
- Cloud provider integrations

**But remember**: Claude-Sysadm can already do all of these things through natural language. The roadmap is about adding convenience features, not capabilities.

## License

MIT License - See LICENSE file for details

## Acknowledgments

- Built for [Claude Code](https://claude.ai/code) by Anthropic
- Inspired by the reality that senior system administrators are expensive and hard to find
- Designed to democratize expert system administration

## The Bottom Line

**Claude-Sysadm is not a limited automation tool. It's a full-capability system administrator that happens to be AI.**

The included commands are training wheels - helpful when you're getting started, but not necessary once you understand what Claude can do.

Ask Claude to do system administration work the same way you'd ask a human sysadmin. Claude will understand, plan, execute, and document - just like a senior Linux professional.

---

**Ready to replace your human system administrator?**

[Install Now](#installation) | [Quick Start Guide](QUICKSTART.md) | [Report Issue](https://github.com/tlarcombe/claude-sysadm/issues) | [View on GitHub](https://github.com/tlarcombe/claude-sysadm)
