#!/bin/bash
#
# Discord Downloader/Updater
# by hh02
#
#
DISCORD_INSTALL_DIR="/usr/share/discord"
if [[ $EUID -eq 0 ]]; then
	echo "Welcome to the Discord Downloader/Updater the script starts now!"

	if [ -f $DISCORD_INSTALL_DIR/Discord ]; then
		echo "Discord it's installed! Updating!"
	else
		echo "Discord not installed!"
	fi
	echo "If Discord it's running ... the updater closes Discord...."
	killall Discord

	cd /tmp
	
	curl -O https://dl.discordapp.net/apps/linux/0.0.26/discord-0.0.26.tar.gz
	if [ ! -d $DISCORD_INSTALL_DIR ]; then
		echo "Discord directory not found! Creating one..."
		mkdir -p $DISCORD_INSTALL_DIR
	fi
	echo "Extracting Discord...."
	tar xvf discord-* -C $DISCORD_INSTALL_DIR
	echo "Copying desktop file to /usr/share/applications..."
	cp -v $DISCORD_INSTALL_DIR/Discord/discord.desktop /usr/share/applications
	
	# Make a symlink to /usr/bin for user can run Discord in the terminal
	# Because in discord.desktop the path it's different.
	
	ln -s $DISCORD_INSTALL_DIR/Discord/Discord /usr/bin/discord

	echo "Assign permissions to desktop file..."
	chmod +x /usr/share/applications/discord.desktop
	echo "Done!"
else
	echo "Please run this script as root!"
fi
