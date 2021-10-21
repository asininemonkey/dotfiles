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
    MACOS="macOS High Sierra"
    ;;
  M )
    MACOS="macOS Mojave"
    ;;
  C )
    MACOS="macOS Catalina"
    ;;
  B )
    MACOS="macOS Big Sur"
    ;;
  * )
    echo -e "\nExiting!"
    exit 1
    ;;
esac

echo -e "\n$MACOS Selected!"

if [ ! -d "/Applications/Install $MACOS.app" ]
then
 echo "Missing $MACOS Installer!"
 exit 1
fi

diskutil list external

read -p "Select Disk: " -t 30 DISK

if [ ! -e "$DISK" ]
then
  echo -e "\nNonexistent Disk!"
  exit 1
fi

read -n 1 -p "Use '${DISK//disk/rdisk}'? (Y/N) " -t 30 PROCEED

case "$PROCEED"
in
  Y )
    echo -e "\nProceeding!"
    ;;
  * )
    echo -e "\nExiting!"
    exit 1
    ;;
esac

read -n 1 -p "Zero Disk? (Y/N) " -t 30 ZERO

case "$ZERO"
in
  Y )
    echo -e "\nZeroing!"
    diskutil unmountDisk "${DISK//disk/rdisk}"
    diskutil zeroDisk "${DISK//disk/rdisk}"
    ;;
esac

echo -e "\nErasing!"

diskutil unmountDisk "${DISK//disk/rdisk}"
diskutil eraseDisk "HFS+" "macOSUSB" "${DISK//disk/rdisk}"

sudo "/Applications/Install $MACOS.app/Contents/Resources/createinstallmedia" \
  --nointeraction \
  --volume "/Volumes/macOSUSB"

touch "/Volumes/Install $MACOS/.com.apple.timemachine.donotpresent"
touch "/Volumes/Install $MACOS/.metadata_never_index"

rm -f -r "/Volumes/Install $MACOS/.Spotlight-V100"
rm -f -r "/Volumes/Install $MACOS/.fseventsd"

diskutil unmountDisk "${DISK//disk/rdisk}"

diskutil eject "${DISK//disk/rdisk}"

echo -e "\nComplete!"
