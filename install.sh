#!/bin/bash
#
# Claude Code Sysadmin Setup - Installation Script
# 
# This script installs the Claude Code sysadmin configuration
# on your Linux server (grathsrv05 or any Ubuntu/Debian server)
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_header() {
    echo -e "\n${BLUE}===================================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}===================================================${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

# Check if script is run from the correct directory
if [ ! -f "CLAUDE.md" ]; then
    print_error "CLAUDE.md not found in current directory"
    print_info "Please run this script from the directory containing the Claude Code setup files"
    exit 1
fi

print_header "Claude Code System Administrator Setup"

echo "This script will install Claude Code sysadmin configuration to your home directory."
echo ""
print_warning "This will create/overwrite the following:"
echo "  - ~/CLAUDE.md"
echo "  - ~/.claude/commands/"
echo "  - ~/.claude/memory/"
echo ""

# Ask for confirmation
read -p "Continue with installation? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_info "Installation cancelled"
    exit 0
fi

# Backup existing files if they exist
print_header "Backing Up Existing Files"

backup_dir="$HOME/.claude_backup_$(date +%Y%m%d_%H%M%S)"

if [ -f "$HOME/CLAUDE.md" ] || [ -d "$HOME/.claude" ]; then
    mkdir -p "$backup_dir"
    print_info "Creating backup in: $backup_dir"
    
    if [ -f "$HOME/CLAUDE.md" ]; then
        cp "$HOME/CLAUDE.md" "$backup_dir/" 2>/dev/null || true
        print_success "Backed up existing CLAUDE.md"
    fi
    
    if [ -d "$HOME/.claude" ]; then
        cp -r "$HOME/.claude" "$backup_dir/" 2>/dev/null || true
        print_success "Backed up existing .claude directory"
    fi
else
    print_info "No existing files to backup"
fi

# Install CLAUDE.md
print_header "Installing CLAUDE.md"

cp CLAUDE.md "$HOME/CLAUDE.md"
chmod 600 "$HOME/CLAUDE.md"
print_success "Installed ~/CLAUDE.md"

# Install .claude directory
print_header "Installing Claude Commands and Memory Files"

mkdir -p "$HOME/.claude/commands"
mkdir -p "$HOME/.claude/memory"

# Copy commands
cp .claude/commands/*.md "$HOME/.claude/commands/" 2>/dev/null || true
chmod -R 700 "$HOME/.claude"
print_success "Installed slash commands to ~/.claude/commands/"

# Copy memory files
cp .claude/memory/*.md "$HOME/.claude/memory/" 2>/dev/null || true
print_success "Installed memory templates to ~/.claude/memory/"

# Verify installation
print_header "Verifying Installation"

errors=0

if [ ! -f "$HOME/CLAUDE.md" ]; then
    print_error "CLAUDE.md not found"
    ((errors++))
else
    print_success "CLAUDE.md installed"
fi

if [ ! -d "$HOME/.claude/commands" ]; then
    print_error ".claude/commands directory not found"
    ((errors++))
else
    cmd_count=$(ls -1 "$HOME/.claude/commands"/*.md 2>/dev/null | wc -l)
    print_success "$cmd_count slash commands installed"
fi

if [ ! -d "$HOME/.claude/memory" ]; then
    print_error ".claude/memory directory not found"
    ((errors++))
else
    mem_count=$(ls -1 "$HOME/.claude/memory"/*.md 2>/dev/null | wc -l)
    print_success "$mem_count memory files installed"
fi

if [ $errors -gt 0 ]; then
    print_error "Installation completed with $errors error(s)"
    exit 1
fi

# Check for required tools
print_header "Checking System Requirements"

check_command() {
    if command -v $1 &> /dev/null; then
        print_success "$1 is installed"
        return 0
    else
        print_warning "$1 is not installed"
        return 1
    fi
}

check_command "docker"
check_command "docker-compose" || check_command "docker compose"
check_command "nginx"
check_command "certbot"
check_command "mysql"

# Customization prompt
print_header "Customization"

echo "The installation is complete, but you should customize CLAUDE.md for your environment:"
echo ""
print_info "Edit ~/CLAUDE.md and update:"
echo "  • Server hostname (currently: grathsrv05)"
echo "  • Sudo password (or remove for manual entry)"
echo "  • Domain name (currently: larcombe.tech)"
echo "  • NFS server IP (currently: 192.168.1.8)"
echo "  • Service locations and ports"
echo ""

read -p "Would you like to edit CLAUDE.md now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ${EDITOR:-nano} "$HOME/CLAUDE.md"
fi

# Success message
print_header "Installation Complete!"

echo ""
print_success "Claude Code sysadmin setup installed successfully!"
echo ""
print_info "Next steps:"
echo ""
echo "  1. Review and customize ~/CLAUDE.md:"
echo "     \$ nano ~/CLAUDE.md"
echo ""
echo "  2. Start Claude Code:"
echo "     \$ cd ~"
echo "     \$ claude"
echo ""
echo "  3. Run system discovery:"
echo "     > /sysadmin:discover"
echo ""
echo "  4. Try a natural language request:"
echo "     > Check the system health"
echo "     > Show me all running services"
echo "     > What SSL certificates do we have?"
echo ""
print_info "Available commands:"
echo "  • /sysadmin:discover - System discovery and inventory"
echo "  • /sysadmin:website - Automated website setup"
echo "  • /sysadmin:ssl - SSL certificate management"
echo "  • /sysadmin:health - System health monitoring"
echo "  • /sysadmin:docker - Docker service management"
echo ""
print_info "Documentation:"
echo "  • README.md in this directory"
echo "  • ~/CLAUDE.md on your server"
echo ""

if [ -d "$backup_dir" ]; then
    print_info "Previous files backed up to: $backup_dir"
fi

echo ""
print_success "Ready to use Claude Code as your system administrator!"
echo ""
