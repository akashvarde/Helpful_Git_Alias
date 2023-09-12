#!/bin/sh

# Define ANSI color escape codes
GREEN='\033[0;32m'   # Green color
RED='\033[0;31m'     # Red color 
YELLOW='\033[0;33m'  # Yello color
NC='\033[0m'          # No color (reset)


# Define the directory where custom Git commands are located
CUSTOM_COMMANDS_DIR="$(pwd)/aliases"

# Define the folder name you want to create
folder_name="helpful_git_alias"

# Define the directory to install custom Git commands globally
GLOBAL_BIN_DIR="/usr/local/bin/$folder_name"





# Check if the script is running with superuser privileges
if [ "$(id -u)" -ne 0 ]; then
  echo "${RED}Error: This script requires superuser/sudo privileges to run. Re-run installation with sudo. ${NC}"
  exit 1
  else 
  echo "${YELLOW}Hi, Thanks for installing :), Hope it helps your work ${NC}"
fi


## Akash Varde :  Create folder for storing git commands 
# Check if the folder already exists
if [ -f "/usr/local/bin/git-createdeployement" ]; then
    echo "Looks like you have earlier installed our program. Do you want to proceed with the update/reinstall? (y/n)"
   
    #stty -echo   # Turn off echoing
    read choice
    #stty echo    # Turn echoing back on

 
    # Check the user's choice
    if [ "$choice" = "y" ] || [ "$choice" = "Y" ]; then
    echo "${GREEN}Updating...${NC}"
    # Add your update logic here
    elif [ "$choice" = "n" ] || [ "$choice" = "N" ]; then
    echo "${RED}Update cancelled.${NC}"
    exit 1
    else
    echo "${RED}Invalid choice. \nAborting...${NC}"
    exit 1
    fi
else
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
    #Install
    make install || {
    echo >&2 "${RED}Installation failed ! $?${NC}"
    exit 1
    }
    #delete installer
    cd ..
    rm -rf helpful_git_alias
fi

# Loop through each custom command file and install it
# for command_file in "$CUSTOM_COMMANDS_DIR"/*; do
#     if [ -f "$command_file" ]; then
#         # Get the command name (without the .sh extension)
#         command_name=$(basename "$command_file" .sh)

#         # Install the command globally
#         cp "$command_file" "$GLOBAL_BIN_DIR/$command_name"
#         chmod +x "$GLOBAL_BIN_DIR/$command_name"
#         echo "Installed $command_name"
#     fi
# done

cd Helpful_Git_Alias || exit

make install || {
  echo >&2 "Clone failed with $?"
  exit 1
}

cd ..

rm -rf Helpful_Git_Alias


echo "Added alises to PATH Variable ...."
echo "Custom Git commands installed successfully!"