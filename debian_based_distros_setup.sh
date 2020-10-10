#!/bin/bash
# chmod 700 debian_based_distros_setup.sh
# must run as root
mainmenu () {
	clear
 	tput setaf 6
	tput bold
	echo "============================================="
	echo " ---- Debian Based Distros Setup Script ----"
	echo "============================================="
	tput sgr0 
	tput setaf 3
	echo "You can open this script in a text editor to see packages to be installed in detail."
	tput setaf 1
	echo "System will automatically reboot after the script is run!!!"
	echo "Make sure you have a stable and fast internet connection before proceeding!!!"
	tput setaf 2
	echo "Do you want to continue? [Y/n]"
	read answer
	case "$answer" in
		y) installApps;;
		Y) installApps;;
		n) quitScript;;
		N) quitScript;;
	esac
	badoption
}
quitscript () {
	tput sgr0
	clear
	exit
}
badoption () {
	tput setaf 9
	echo "Invalid Option!"
	sleep 2
	quitscript
}
finish () {
	tput setaf 10
	tput bold
	echo "Done..."
	tput setaf 9
	echo "Rebooting..."
	tput sgr0
	sleep 3
	clear
	sudo reboot
}
installFlatpak () {
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak remotes
	flatpak install -y flathub com.spotify.Client
	flatpak install -y flathub org.kde.kdenlive
	flatpak install -y flathub org.onlyoffice.desktopeditors
	flatpak install -y flathub com.visualstudio.code
	flatpak install -y flathub org.kde.okular
}
removeApps(){
	sudo apt-get purge -y thunderbird*
	sudo apt-get remove --purge -y libreoffice*
	sudo apt-get purge -y geary deja-dup
	sudo apt-get remove --purge -y evince rhythmbox
	sudo apt purge -y snapd
}
installApps () {
	clear
	tput setaf 3
	echo "Installing and removing extra applications..."
	tput sgr0
	sleep 3
	clear
	tput setab 2
	tput setaf 5
	sudo apt update -y
	removeApps
	sudo apt update -y
	sudo apt upgrade -y
	sudo apt install -y synaptic gnome-boxes gparted vlc gnome-tweaks neofetch kazam kolourpaint4 gufw android-tools-adb adb android-tools-fastboot gimp htop transmission handbrake gnome-shell-extensions obs-studio default-jre flatpak wget curl
	sudo apt update -y
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo apt-get install -y google-chrome-stable_current_amd64.deb
	wget http://media.steampowered.com/client/installer/steam.deb
	yes | dpkg -i steam.deb
	sudo apt update -y
	sudo apt upgrade -y
	installFlatpak
	sudo apt-get update -y
	sudo apt-get upgrade -y
	sudo apt autoremove -y
	sudo apt autoclean -y
	tput sgr0
	finish
}
# driver code
while true
do
	mainmenu
done

