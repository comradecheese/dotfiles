#! /usr/bin/bash
echo "Updating system..."
sudo apt update -y && sudo apt upgrade -y

echo "Installing i3-gaps dependencies..."
sudo apt install meson dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev xorg xinit xsettingsd build-essentials git -y

echo "Cloning i3-gaps repo..."
git clone https://github.com/Airblader/i3 i3-gaps

echo "Building i3-gaps..."
cd i3-gaps
mkdir -p build && cd build
meson --prefix /usr/local
ninja
sudo ninja install

touch .xinitrc
echo "exec i3" > .xinitrc
