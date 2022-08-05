#! /usr/bin/bash
echo "Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo "Installing i3-gaps dependencies and other software..."
sudo apt install meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev xorg xinit xsettingsd build-essential suckless-tools i3status i3lock fonts-mplus rxvt-unicode xsel lxappearance arc-theme compton feh -y

echo "Cloning i3-gaps repo..."
git clone https://github.com/Airblader/i3 i3-gaps

echo "Building i3-gaps..."
cd i3-gaps
mkdir -p build && cd build
sudo meson --prefix /usr/local
sudo ninja
sudo ninja install

echo "Removing i3-gaps repo..."
cd ../..
rm -rfv i3-gaps

echo "Installing librewolf..."
# https://librewolf.net/installation/debian/
distro=$(if echo " bullseye focal impish jammy uma una " | grep -q " $(lsb_release -sc) "; then echo $(lsb_release -sc); else echo focal; fi)

wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg

sudo echo -e "Types: deb\nURIs: https://deb.librewolf.net\nSuites: $distro\nComponents: main\nArchitectures: amd64\nSigned-By: /usr/share/keyrings/librewolf.gpg" > /etc/apt/sources.list.d/librewolf.sources

sudo apt update -y

sudo apt install librewolf -y