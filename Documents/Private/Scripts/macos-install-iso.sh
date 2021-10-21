#!/usr/bin/env bash

set -e

echo -e "macOS Releases:"
echo -e "  H - High Sierra 10.13"
echo -e "  M - Mojave 10.14"
echo -e "  C - Catalina 10.15"
echo -e "  B - Big Sur 11"

read -n 1 -p "Which Release? (H/M/C/B) " -t 30 RELEASE

case "$RELEASE"
in
  H )
    IMAGE_SIZE="9216m"
    SOURCE="macOS High Sierra"
    ;;
  M )
    IMAGE_SIZE="9216m"
    SOURCE="macOS Mojave"
    ;;
  C )
    IMAGE_SIZE="9216m"
    SOURCE="macOS Catalina"
    ;;
  B )
    IMAGE_SIZE="13312m"
    SOURCE="macOS Big Sur"
    ;;
  * )
    echo -e "\nExiting!"
    exit 1
    ;;
esac

echo -e "\n${SOURCE} Selected!"

if [ ! -d "/Applications/Install ${SOURCE}.app" ]
then
 echo "Missing ${SOURCE} Installer!"
 exit 1
fi

IMAGE_NAME="macos-install-media"

hdiutil create -fs "HFS+" -layout "SPUD" -o "/tmp/${IMAGE_NAME}" -size "${IMAGE_SIZE}"

hdiutil attach -mountpoint "/tmp/${IMAGE_NAME}" "/tmp/${IMAGE_NAME}.dmg"

sudo "/Applications/Install ${SOURCE}.app/Contents/Resources/createinstallmedia" --nointeraction --volume "/tmp/${IMAGE_NAME}"

rm -f -r "/Volumes/Install ${SOURCE}/.fseventsd"

hdiutil detach -force "/Volumes/Install ${SOURCE}"

hdiutil convert -format "UDTO" -o "/tmp/${IMAGE_NAME}" "/tmp/${IMAGE_NAME}.dmg"

mv "/tmp/${IMAGE_NAME}.cdr" "$HOME/Desktop/${IMAGE_NAME}.iso"

rm -f -r "/tmp/${IMAGE_NAME}.dmg"
