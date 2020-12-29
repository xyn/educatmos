#!/bin/bash

set -x

function error {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

rm -rvf ${HOME}/box86
rm -rvf ${HOME}/zoom

mkdir ${HOME}/box86
mkdir ${HOME}/zoom

sudo apt install libxcb-xtest0 libxcb-xfixes0 cmake pulseaudio-utils pulseaudio -y

echo "Cloning box86..."
git clone https://github.com/ptitSeb/box86 || error 'Failed to clone repository!'
cd ${HOME}/box86 || error 'Failed to enter repository!'
mkdir build || error 'Failed to make build directory!'
cd build || error 'Failed to enter build directory!'
cmake .. -DRPI4=1 -DCMAKE_BUILD_TYPE=RelWithDebInfo || error 'Failed to run cmake!'

echo "Compiling box86..."
make -j24 || error 'Failed to compile!'

echo "Installing box86 on your system..."
sudo make install || error 'Failed to run sudo make install!'

echo "Restarting systemd-binfmt service..."
sudo systemctl restart systemd-binfmt

echo "Downloading zoom..."
cd ${HOME}/zoom
wget 'https://github.com/Botspot/zoom_686_mirror/raw/main/zoom_i686.tar.xz' || error 'Failed to download Zoom i686!'
tar -xvf zoom_i686.tar.xz || error 'Failed to extract Zoom i686!'

echo "Creating launcher file..."
echo '#!/bin/bash
cd ${HOME}/zoom/zoom/
echo -e "\e[102m\e[30mLaunching Zoom.\e[0m"
box86 zoom' > "${HOME}/zoom/runzoom.sh"
chmod +x "${HOME}/zoom/runzoom.sh"

echo "Creating Application Menu button..."
echo "[Desktop Entry]
Name=Zoom
Exec="\""$HOME/zoom/runzoom.sh"\""
Icon=${DIRECTORY}/apps/Zoom/icon-64.png
Path=${HOME}/zoom/
Type=Application
Comment=i386 version of software platform used for teleconferencing using Box86
Categories=Network;
StartupNotify=true" > ~/.local/share/applications/zoom.desktop
