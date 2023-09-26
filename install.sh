#!/bin/sh

# Define ANSI color escape codes
GREEN='\033[0;32m'   # Green color
RED='\033[0;31m'     # Red color 
YELLOW='\033[0;33m'  # Yellow color
NC='\033[0m'          # No color (reset)

log_error() {
    echo "${RED}$1${NC}"
}

log_warning() {
    echo "${YELLOW}$1${NC}"
}

log_success() {
    echo "${GREEN}$1${NC}"
}

# Define the directory where custom Git commands are located
CUSTOM_COMMANDS_DIR="$(pwd)/aliases"

# Define the folder name you want to create
folder_name="helpful_git_alias"

# Define the directory to install custom Git commands globally
GLOBAL_BIN_DIR="/usr/local/bin/$folder_name"

# Remove existing 'helpful_git_alias' directory
rm -rf helpful_git_alias

# Check if the script is running with superuser privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "${RED}Error: This script requires superuser/sudo privileges to run. Re-run installation with sudo.${NC}"
    exit 1
else 
    echo "${YELLOW}Hi, Thanks for installing :), Hope it helps your work${NC}"
fi

# Check if the folder already exists
if [ -f "/usr/local/bin/git-createdeployement" ]; then
    log_warning "Looks like you have earlier installed the git scripts. Updating..."
fi

echo "${GREEN}Installing...${NC}"
git clone https://github.com/akashvarde/helpful_git_alias.git --depth=1 || {
    echo >&2 "${RED}Clone failed with $?${NC}"
    exit 1
}

# Create the folder
cd helpful_git_alias || {
    echo >&2 "Unable to create installer $?"
    exit 1
}

# Install
make install || {
    echo >&2 "${RED}Installation failed ! $?${NC}"
    exit 1
}

# Delete installer
cd ..
rm -rf helpful_git_alias

echo "Added aliases to PATH Variable ...."
echo "Custom Git commands installed successfully!"
log_success "You can now use the command 'git createdeployement <target_branch>'"
exit 0  # Exiting with 0 indicates a successful script execution
