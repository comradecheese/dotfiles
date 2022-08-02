#! /usr/bin/bash
echo "Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo "Installing i3-gaps dependencies..."
sudo apt install meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev xorg xinit xsettingsd build-essential suckless-tools i3status i3lock fonts-mplus rxvt-unicode xsel lxappearance arc-theme -y

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
wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg
sudo cat librewolfsource >> /etc/apt/sources.list.d/librewolf.sources
sudo apt update -y && sudo apt upgrade -y
sudo apt install librewolf -y

echo "Setting up dotfiles..."
cd ..
cp -rv .config/ ~
cp -v .Xauthority ~
cp -v .Xresources ~
cp -v .bash_profile ~
cp -v .wallpaper.jpg ~
cp -v .xinitrc ~
cp -v .xsettingsd ~

echo "Finished!"
read -p "Press any key to reboot... " -n1 -s
sudo reboot now
