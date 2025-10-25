# Docker Service Management

Manage Docker services, containers, and compose projects with comprehensive operations.

**Usage:** `/sysadmin:docker [action] [service]`

Where:
- `[action]`: "status", "restart", "update", "logs", "deploy", or "cleanup"
- `[service]`: Optional service name

**Arguments provided:** $ARGUMENTS

## Actions

### 1. Status Check (action: status)

```bash
# List all running containers
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.RunningFor}}"

# List all compose projects
docker compose ls

# Show resource usage
docker stats --no-stream

# Show disk usage
docker system df
```

For specific service:
```bash
cd /home/tlarcombe/docker/<service> || cd /opt/<service> || cd /home/tlarcombe/<service>
docker compose ps
docker compose logs --tail 50
```

### 2. Restart Service (action: restart)

```bash
# Find service location
service_dir=$(find /home/tlarcombe/docker /home/tlarcombe /opt -name "<service>" -type d 2>/dev/null | head -1)

if [ -z "$service_dir" ]; then
    echo "❌ Service directory not found"
    exit 1
fi

cd "$service_dir"

# Check if docker-compose.yml exists
if [ ! -f "docker-compose.yml" ]; then
    echo "❌ docker-compose.yml not found"
    exit 1
fi

# Restart the service
docker compose restart

# Wait and check status
sleep 5
docker compose ps

# Check logs for errors
docker compose logs --tail 20
```

### 3. Update Service (action: update)

```bash
# Find service location
service_dir=$(find /home/tlarcombe/docker /home/tlarcombe /opt -name "<service>" -type d 2>/dev/null | head -1)

cd "$service_dir"

# Backup current compose file
cp docker-compose.yml docker-compose.yml.backup.$(date +%Y%m%d_%H%M%S)

# Pull latest images
docker compose pull

# Recreate containers with new images
docker compose up -d

# Wait for services to start
sleep 10

# Check status
docker compose ps

# Show recent logs
docker compose logs --tail 30

# Clean up old images
docker image prune -f
```

### 4. View Logs (action: logs)

```bash
# Find service location
service_dir=$(find /home/tlarcombe/docker /home/tlarcombe /opt -name "<service>" -type d 2>/dev/null | head -1)

cd "$service_dir"

# Show logs with timestamps
docker compose logs --timestamps --tail 100

# For specific container in multi-container service
docker compose logs <container-name> --timestamps --tail 100
```

### 5. Deploy New Service (action: deploy)

**Steps:**
1. Create service directory
2. Create docker-compose.yml
3. Create necessary config files
4. Pull images
5. Start service
6. Verify health
7. Setup nginx proxy (if needed)
8. Update documentation

```bash
# Create directory
mkdir -p /home/tlarcombe/docker/<service>
cd /home/tlarcombe/docker/<service>

# Create docker-compose.yml (template)
cat > docker-compose.yml <<'EOF'
version: '3.8'

services:
  <service>:
    image: <image-name>:<tag>
    container_name: <service>
    restart: unless-stopped
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/New_York
    volumes:
      - ./config:/config
      - ./data:/data
    ports:
      - "<port>:<port>"
    # networks:
    #   - <network>

# networks:
#   <network>:
#     external: true
EOF

# Start service
docker compose up -d

# Check logs
docker compose logs -f
```

### 6. Cleanup (action: cleanup)

```bash
# Show current disk usage
echo "Current Docker disk usage:"
docker system df

# Remove stopped containers
echo "Removing stopped containers..."
docker container prune -f

# Remove unused images
echo "Removing unused images..."
docker image prune -a -f

# Remove unused volumes (CAREFUL!)
echo "Listing unused volumes (not removing automatically):"
docker volume ls -qf dangling=true

# Remove unused networks
echo "Removing unused networks..."
docker network prune -f

# Show new disk usage
echo "New Docker disk usage:"
docker system df
```

## Service Catalog Management

After any operation, update `.claude/memory/service-catalog.md`:

```markdown
## <service>
- **Status**: Running/Stopped/Updated
- **Location**: /home/tlarcombe/docker/<service>
- **Image**: <image>:<tag>
- **Ports**: <ports>
- **Last Updated**: <timestamp>
- **Last Checked**: <timestamp>
- **Health**: Healthy/Degraded/Unknown
- **Notes**: <any relevant notes>
```

## Common Docker Operations

### Check Container Health
```bash
docker inspect --format='{{.State.Health.Status}}' <container-name>
```

### Execute Command in Container
```bash
docker exec -it <container-name> bash
docker exec -it <container-name> sh
```

### Copy Files to/from Container
```bash
docker cp <local-file> <container>:/path/to/destination
docker cp <container>:/path/to/file <local-destination>
```

### View Container Resource Usage
```bash
docker stats <container-name>
```

### Inspect Container Configuration
```bash
docker inspect <container-name>
```

## Troubleshooting Common Issues

### Container Won't Start
```bash
# Check logs
docker compose logs <service>

# Check image pull status
docker images | grep <service>

# Check port conflicts
echo 'Nhad368pass' | sudo -S netstat -tlnp | grep <port>

# Check resource constraints
docker info | grep -A 5 "Memory"
```

### Container Keeps Restarting
```bash
# View restart count
docker ps -a --format "{{.Names}}: {{.Status}}"

# Check logs for errors
docker logs --tail 100 <container>

# Inspect restart policy
docker inspect --format='{{.HostConfig.RestartPolicy.Name}}' <container>
```

### Networking Issues
```bash
# List networks
docker network ls

# Inspect network
docker network inspect <network-name>

# Check container connectivity
docker exec <container> ping <other-container>
```

### Storage Issues
```bash
# Check volume mounts
docker inspect --format='{{range .Mounts}}{{.Source}}:{{.Destination}} {{end}}' <container>

# Check volume permissions
docker exec <container> ls -la /path/to/volume
```

## Service-Specific Notes

### Multi-Container Services
For services with multiple containers (LibreChat, Immich, Paperless-ngx):
```bash
# Restart specific container
docker compose restart <container-name>

# View logs for specific container
docker compose logs <container-name>

# Check inter-container connectivity
docker compose exec <container> ping <other-container>
```

### Host Network Services
For services using host network (Home Assistant):
```bash
# These don't have port mappings
# Access directly on host's IP and port
# Cannot use standard Docker networking
```

## Health Check Report

Generate service health report:

```markdown
# Docker Services Health Report
Generated: <timestamp>

## Summary
- Total Services: X
- Running: X
- Stopped: X
- Unhealthy: X
- Total Containers: X

## Service Details

### ✅ Healthy Services
| Service | Location | Status | Uptime | Image Version |
|---------|----------|--------|--------|---------------|
| service1 | /path | Running | 5d | image:tag |

### ⚠️ Services Needing Attention
| Service | Location | Issue | Action Required |
|---------|----------|-------|-----------------|
| service2 | /path | High Restarts | Check logs |

### ❌ Stopped Services
| Service | Location | Last Seen | Action Required |
|---------|----------|-----------|-----------------|
| service3 | /path | 2d ago | Investigate and restart |

## Resource Usage
- Total Disk Used: X GB
- Images: X GB
- Containers: X GB
- Volumes: X GB

## Recommendations
1. [Action items based on health check]
2. [Services to update]
3. [Cleanup opportunities]
```

## Update Documentation

After operations, update:
1. `.claude/memory/service-catalog.md` - Service states and versions
2. `.claude/memory/recent-changes.md` - Operations performed
3. `CLAUDE.md` - Any architectural changes

## Example Usage

```
User: "Check Docker services"
Claude: Calls /sysadmin:docker status

User: "Restart Immich"
Claude: Calls /sysadmin:docker restart immich

User: "Update Jellyfin to latest version"
Claude: Calls /sysadmin:docker update jellyfin

User: "Clean up Docker disk space"
Claude: Calls /sysadmin:docker cleanup
```
