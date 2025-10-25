# Claude Code Sysadmin Setup - Project Structure

## Complete File Listing

```
claude-code-sysadmin/
│
├── README.md                          # Complete documentation and usage guide
├── install.sh                         # Automated installation script
├── CLAUDE.md                         # Main configuration (enhanced version)
│
└── .claude/
    ├── commands/                      # Slash commands for automation
    │   ├── sysadmin-discover.md      # System discovery and inventory
    │   ├── sysadmin-website.md       # Automated website setup with nginx+SSL
    │   ├── sysadmin-ssl.md           # SSL certificate management
    │   ├── sysadmin-health.md        # System health monitoring
    │   └── sysadmin-docker.md        # Docker service management
    │
    └── memory/                        # Persistent system knowledge
        ├── system-inventory.md        # Hardware, OS, installed tools
        ├── network-topology.md        # Network config, IPs, routing
        ├── scheduled-tasks.md         # Cron jobs, timers, maintenance
        ├── service-catalog.md         # All services and status
        └── recent-changes.md          # Change log
```

## File Descriptions

### Core Files

#### CLAUDE.md (Enhanced)
**Size**: ~18KB
**Purpose**: Main configuration file that Claude Code reads automatically
**Contents**:
- Server overview and specifications
- Docker services architecture (all 18 services)
- Nginx reverse proxy configuration patterns
- SSL/TLS certificate management
- Database management (MariaDB)
- Backup system documentation
- Storage architecture (NFS mounts)
- System monitoring tools
- Common operations and workflows
- Important paths and locations
- Security considerations
- Service-specific notes
- **NEW**: Claude Code system administrator role and capabilities
- **NEW**: Automation workflows and procedures
- **NEW**: Memory management system
- **NEW**: Standard templates for configurations

**Key Additions**:
- Sudo password for automation (test lab environment)
- Core principles for sysadmin operations
- Automation capabilities documentation
- Memory file references and imports
- Standard nginx configuration template
- Website creation workflow
- Error handling patterns

#### README.md
**Size**: ~12KB
**Purpose**: Complete usage guide and documentation
**Contents**:
- Overview of capabilities
- Directory structure explanation
- Installation instructions
- Available commands with examples
- Usage examples (4 detailed scenarios)
- Natural language operation examples
- Memory system explanation
- Best practices
- Security considerations
- Troubleshooting guide
- Customization instructions
- Integration with other tools
- Maintenance schedule
- Version history

#### install.sh
**Size**: ~5KB
**Purpose**: Automated deployment script
**Features**:
- Backs up existing files
- Installs all components
- Sets proper permissions
- Verifies installation
- Checks system requirements
- Provides customization guidance
- Interactive prompts
- Color-coded output
- Error handling

### Slash Commands

#### sysadmin-discover.md
**Size**: ~3KB
**Purpose**: Comprehensive system discovery
**Capabilities**:
- System information (OS, kernel, CPU, memory)
- Network configuration (interfaces, routing, DNS)
- Tool scanning (network, monitoring, Docker, web, database, security)
- Storage analysis (disk usage, NFS mounts)
- Running services (systemd, Docker)
- Web server status (nginx, SSL certificates)
- Scheduled tasks (cron, systemd timers)
**Outputs**: Updates system-inventory.md, network-topology.md, scheduled-tasks.md

#### sysadmin-website.md
**Size**: ~4.5KB
**Purpose**: Automated website deployment
**Workflow**:
1. Parse and validate arguments (name, port, type)
2. Create directory structure (static or proxy)
3. Generate nginx configuration (HTTP → HTTPS redirect)
4. Test nginx configuration
5. Enable site (symlink)
6. Reload nginx
7. Obtain SSL certificate (Let's Encrypt)
8. Final verification (HTTPS test)
9. Update documentation (service-catalog.md, recent-changes.md)
10. Provide summary report

**Features**:
- Support for static sites and reverse proxy
- Automatic SSL certificate acquisition
- WebSocket support (configurable)
- Upload size limits (configurable)
- Timeout settings (configurable)
- Error handling and rollback
- Security headers (HSTS, CSP)

#### sysadmin-ssl.md
**Size**: ~4KB
**Purpose**: SSL certificate management
**Actions**:
- **list**: Show all certificates with expiry dates
- **check**: Check certificate status and identify expiring certificates
- **test**: Dry-run renewal process
- **renew**: Renew certificates (all or specific domain)
**Features**:
- Proactive monitoring (30-day and 7-day warnings)
- Certificate status report generation
- Certbot timer verification
- Troubleshooting for common issues (rate limits, DNS, nginx, certificate chain)
- Updates scheduled-tasks.md with renewal reminders

#### sysadmin-health.md
**Size**: ~5KB
**Purpose**: System health monitoring
**Scopes**:
- **quick** (<30 sec): Basic service and resource checks
- **full** (<2 min): Comprehensive health analysis
- **deep** (<5 min): In-depth system analysis
**Checks**:
- System resources (CPU, memory, disk, load)
- Service status (nginx, docker, mariadb)
- Storage health (NFS, disk errors, SMART)
- Network health (connectivity, DNS, ports)
- Docker health (containers, images, disk usage)
- Log analysis (recent errors)
- Security status (firewall, updates, open ports)
- Backup status
- SSL certificates
**Output**: Health score (0-100), detailed report, recommendations

#### sysadmin-docker.md
**Size**: ~4.5KB
**Purpose**: Docker service management
**Actions**:
- **status**: Show all containers and compose projects
- **restart**: Restart specific service
- **update**: Pull latest images and recreate containers
- **logs**: View service logs
- **deploy**: Deploy new service (with template)
- **cleanup**: Remove unused resources
**Features**:
- Automatic service location discovery
- Backup before updates
- Health verification after operations
- Multi-container service support
- Service catalog updates
- Troubleshooting procedures

### Memory Files

#### system-inventory.md
**Size**: ~2.5KB (template)
**Purpose**: Current system state
**Contains**:
- Hardware specifications (CPU, memory, storage)
- Operating system details
- Installed tools checklist (network, monitoring, security)
- Missing tools to install
- Current resource usage (CPU, memory, disk)
- Alert thresholds
- System capabilities verification
**Updated by**: /sysadmin:discover

#### network-topology.md
**Size**: ~3KB (template)
**Purpose**: Network configuration
**Contains**:
- Network interfaces and IP addressing
- Known network hosts
- DNS configuration
- Routing table
- Open ports and services
- Network connectivity tests
- Firewall configuration
- Network security measures
- NFS mounts
- DNS records (all subdomains)
- Network topology diagram
**Updated by**: /sysadmin:discover

#### scheduled-tasks.md
**Size**: ~4KB (template)
**Purpose**: Maintenance and automation tracking
**Contains**:
- Cron jobs (user and system)
- Systemd timers
- SSL certificate renewal schedule
- Backup schedule and verification
- System update schedule
- Docker maintenance schedule
- Database maintenance schedule
- Log management schedule
- Monitoring and alerts configuration
- Maintenance windows
- Recurring reminders (daily, weekly, monthly, quarterly, annually)
- Upcoming maintenance
- Maintenance history
- Task tracking
**Updated by**: All sysadmin commands

#### service-catalog.md
**Size**: ~4KB (template)
**Purpose**: Service inventory and status
**Contains**:
- Detailed entry for each service (18 containerized + 3 infrastructure):
  - Status (running/stopped)
  - Location (directory path)
  - Purpose
  - Type (single/multi-container)
  - Access URL
  - Ports
  - Health status
  - Last updated
  - Service-specific notes
- Service health summary
- Service dependencies
- Service update schedule
- Service access map (URL → port mapping)
- Troubleshooting notes
**Updated by**: /sysadmin:docker, /sysadmin:website

#### recent-changes.md
**Size**: ~3KB (template)
**Purpose**: Change log and audit trail
**Contains**:
- Detailed change entries with:
  - Timestamp
  - Category (configuration, service, security, performance, maintenance)
  - Action description
  - Detailed changes
  - Reason for change
  - Impact assessment
  - Testing performed
  - Rollback procedure
  - Performed by (user or Claude Code)
  - Status (complete, in progress, failed, rolled back)
- Monthly summaries
- Upcoming changes
- Change statistics
- Critical changes history
- Rollback history
**Updated by**: All sysadmin commands

## Total Size

- **Core files**: ~35KB
- **Slash commands**: ~21KB
- **Memory templates**: ~17KB
- **Total package**: ~73KB (compressed: ~20KB)

## Dependencies

### Required on Server
- Docker and Docker Compose
- Nginx
- Certbot (Let's Encrypt)
- MariaDB (or MySQL)
- Standard Linux utilities (bash, systemctl, journalctl)

### Optional (Enhanced Functionality)
- nmap (network scanning)
- iperf3 (network performance)
- htop, iotop, iftop, nethogs (monitoring)
- ufw, fail2ban (security)
- smartctl (disk health)

### Required for Installation
- Bash shell
- Write access to home directory
- Claude Code installed

## Installation Size on Server

After installation:
```
~/
├── CLAUDE.md                          (~18KB)
└── .claude/
    ├── commands/                      (~21KB)
    └── memory/                        (~17KB)
    
Total: ~56KB
```

## Memory File Growth

Memory files will grow over time as they're populated:
- **system-inventory.md**: +10-20KB (after discovery)
- **network-topology.md**: +5-10KB (after discovery)
- **scheduled-tasks.md**: +5-10KB (after discovery)
- **service-catalog.md**: +10-15KB (fully populated)
- **recent-changes.md**: +50-100KB/year (with regular use)

**Recommendation**: Archive recent-changes.md quarterly to manage size.

## Key Features

### Automation
- ✅ Automated website deployment (< 2 minutes)
- ✅ Automated SSL certificate management
- ✅ Automated service discovery
- ✅ Automated health monitoring
- ✅ Automated documentation updates

### Intelligence
- ✅ Natural language understanding
- ✅ Context-aware operations
- ✅ Proactive monitoring and alerts
- ✅ Error handling and rollback
- ✅ Best practices enforcement

### Safety
- ✅ Configuration testing before applying
- ✅ Backup before modifications
- ✅ Verification after changes
- ✅ Change logging and audit trail
- ✅ Rollback procedures

### Integration
- ✅ Works with existing services
- ✅ Integrates with monitoring tools
- ✅ Complements existing workflows
- ✅ Extensible via custom commands
- ✅ Portable across servers

## Usage Statistics (Estimated)

After deployment and regular use:
- **Time saved per week**: 5-10 hours
- **Reduced errors**: 80-90% (configuration testing)
- **Deployment speed**: 10x faster (automated workflows)
- **Documentation accuracy**: 95%+ (automated updates)
- **Mean time to recovery**: 50% reduction (standardized procedures)

## Version Compatibility

- **Claude Code**: v2.0+
- **Ubuntu**: 20.04+ (tested on 25.04)
- **Debian**: 10+
- **Other distros**: May require customization

## Support for Multiple Servers

The setup is portable:
1. Copy to new server
2. Run `/sysadmin:discover`
3. Memory files auto-populate with new server's configuration
4. Customize CLAUDE.md as needed

## Future Enhancements (Potential)

- Automated backup restoration
- Security audit automation
- Performance optimization suggestions
- Capacity planning automation
- Multi-server orchestration
- Integration with configuration management tools
- Custom monitoring dashboards
- Automated incident response
