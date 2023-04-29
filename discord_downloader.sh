#!/bin/bash
#
# Discord Downloader/Updater
# by hhk02
#
#
DISCORD_INSTALL_DIR="/usr/share"
if [[ $EUID -eq 0 ]]; then
	echo "Welcome to the Discord Downloader/Updater the script starts now!"

	if [ -f $DISCORD_INSTALL_DIR/discord/Discord ]; then
		echo "Discord it's installed! Updating!"
	else
		echo "Discord not installed!"
	fi
	echo "If Discord it's running ... the updater closes Discord...."
	killall Discord

	cd /tmp || return
	
	if [ ! -f /tmp/discord-0.0.27.tar.gz ]; then
		echo "Discord has alredy downloaded before!"
	else
		curl -O https://dl.discordapp.net/apps/linux/0.0.27/discord-0.0.27.tar.gz
	fi
	if [ ! -d $DISCORD_INSTALL_DIR/discord ]; then
		echo "Discord directory not found! Creating one..."
		mkdir -p $DISCORD_INSTALL_DIR
	fi
	echo "Extracting Discord...."
	tar xvf discord-* -C $DISCORD_INSTALL_DIR
	echo "Copying desktop file to /usr/share/applications..."
	mv $DISCORD_INSTALL_DIR/Discord $DISCORD_INSTALL_DIR/discord
	cp -v $DISCORD_INSTALL_DIR/discord/discord.desktop /usr/share/applications
	
	# Make a symlink to /usr/bin for user can run Discord in the terminal
	# Because in discord.desktop the path it's different.
	
	ln -s $DISCORD_INSTALL_DIR/discord/Discord /usr/bin/discord

	echo "Assign permissions to desktop file..."
	chmod +x /usr/share/applications/discord.desktop
	echo "Done!"
else
	echo "Please run this script as root!"
fi
