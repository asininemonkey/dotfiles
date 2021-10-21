#!/usr/bin/env bash

#
# Console Colours
#
export OUTPUT_COLOUR_CLEAR=$(echo -en '\e[m')

export OUTPUT_COLOUR_BOLD_BLACK=$(echo -en '\e[1;30m')
export OUTPUT_COLOUR_BOLD_RED=$(echo -en '\e[1;31m')
export OUTPUT_COLOUR_BOLD_GREEN=$(echo -en '\e[1;32m')
export OUTPUT_COLOUR_BOLD_YELLOW=$(echo -en '\e[1;33m')
export OUTPUT_COLOUR_BOLD_BLUE=$(echo -en '\e[1;34m')
export OUTPUT_COLOUR_BOLD_MAGENTA=$(echo -en '\e[1;35m')
export OUTPUT_COLOUR_BOLD_CYAN=$(echo -en '\e[1;36m')
export OUTPUT_COLOUR_BOLD_WHITE=$(echo -en '\e[1;37m')

#
# Change macOS Screenshot Settings
#

if [ ! -d "${HOME}/Pictures/Screenshots/macOS" ]
then
    mkdir -p "${HOME}/Pictures/Screenshots/macOS"

    defaults write com.apple.screencapture disable-shadow -bool true
    defaults write com.apple.screencapture location "${HOME}/Pictures/Screenshots/macOS"
fi

#
# Install Xcode Command Line Tools
#

if [ ! -f "/Library/Developer/CommandLineTools/usr/bin/swift-frontend" ]
then
    xcode-select --install
fi

#
# Install Homebrew
#

if [ ! -f "/usr/local/Homebrew/bin/brew" ]
then
    /bin/bash -c "$(curl --fail --location --show-error --silent 'https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh')"
fi

#
# Install Homebrew Packages
#

brew tap homebrew/cask-fonts

brew install --cask \
    font-fantasque-sans-mono-nerd-font \
    font-fira-code-nerd-font

brew install \
    aws-iam-authenticator \
    aws-shell \
    awscli \
    bash \
    cfssl \
    diff-so-fancy \
    docker-credential-helper-ecr \
    envchain \
    fzf \
    get_iplayer \
    git \
    gnu-sed \
    googler \
    helm \
    helmsman \
    hey \
    htop \
    imagemagick \
    jq \
    k9s \
    kops \
    kubernetes-cli \
    ngrok \
    nmap \
    p7zip \
    prettyping \
    sops \
    speedtest-cli \
    starship \
    stern \
    terraform \
    terragrunt \
    tmux \
    tree \
    watch \
    wget \
    youtube-dl

brew upgrade

brew cleanup

#
# Install macOS App Store Applications
#

echo

# Apple Applications
mas install 409183694			# Keynote
mas install 409201541			# Pages
mas install 409203825			# Numbers
# mas install 497799835			# Xcode

# General Applications
mas install 403504866			# PCalc
mas install 405399194			# Kindle
mas install 406056744			# Evernote
mas install 406825478			# Telephone
mas install 411643860			# DaisyDisk
mas install 413857545			# Divvy
mas install 417375580			# BetterSnapTool
mas install 425424353			# The Unarchiver
mas install 430798174			# HazeOver
mas install 457622435			# Yoink
mas install 488764545			# The Clock
mas install 803453959			# Slack
mas install 824171161			# Affinity Designer
mas install 824183456			# Affinity Photo
mas install 1153157709			# Speedtest
mas install 1191449274			# ToothFairy
mas install 1289583905			# Pixelmator Pro
mas install 1333542190  		# 1Password 7
mas install 1438838068			# KubeContext
mas install 1529448980			# Reeder 5

# Microsoft Applications
# mas install 462054704			# Microsoft Word
# mas install 462058435			# Microsoft Excel
# mas install 462062816			# Microsoft PowerPoint
# mas install 784801555			# Microsoft OneNote
# mas install 985367838			# Microsoft Outlook

#
# Check For Manually Installed Applications
#

echo

function checkApplications () {
    for APPLICATION in "${!APPLICATION_MAP[@]}";
    do
        if [ ! -d "/Applications/${APPLICATION_MAP[${APPLICATION}]}.app" ]
        then
            echo "${OUTPUT_COLOUR_BOLD_YELLOW}${APPLICATION}${OUTPUT_COLOUR_CLEAR} has ${OUTPUT_COLOUR_BOLD_RED}not${OUTPUT_COLOUR_CLEAR} been installed!"
        fi
    done
}

declare -A APPLICATION_MAP

# Personal Applications
APPLICATION_MAP['Audio Hijack']="Audio Hijack"
APPLICATION_MAP['Bartender']="Bartender 4"
APPLICATION_MAP['Discord']="Discord"
APPLICATION_MAP['Docker']="Docker"
APPLICATION_MAP['Firefox']="Firefox"
APPLICATION_MAP['Fission']="Fission"
APPLICATION_MAP['GitHub Desktop']="GitHub Desktop"
APPLICATION_MAP['Kaleidoscope']="Kaleidoscope"
APPLICATION_MAP['Lens']="Lens"
APPLICATION_MAP['Loopback']="Loopback"
APPLICATION_MAP['Postbox']="Postbox"
APPLICATION_MAP['Mozilla VPN']="Mozilla VPN"
APPLICATION_MAP['RemotePlay']="RemotePlay"
APPLICATION_MAP['Ring']="Ring"
APPLICATION_MAP['Signal']="Signal"
APPLICATION_MAP['SoundSource']="SoundSource"
APPLICATION_MAP['Steam']="Steam"
APPLICATION_MAP['Swish']="Swish"
APPLICATION_MAP['ToothFairy']="ToothFairy"
APPLICATION_MAP['Visual Studio Code']="Visual Studio Code"
APPLICATION_MAP['VLC']="VLC"
APPLICATION_MAP['VMware Fusion']="VMware Fusion"

# Work Applications
APPLICATION_MAP['krisp']="krisp"
APPLICATION_MAP['Postman']="Postman"
APPLICATION_MAP['Zoom']="zoom.us"

checkApplications

unset APPLICATION_MAP

#
# Install Python 3 Modules
#

echo

pip3 install --upgrade \
    boto3 \
    pip \
    pyaml \
    yq

pip3 cache purge

#
# Install Oh My Zsh
#

if [ ! -f "${HOME}/.oh-my-zsh/oh-my-zsh.sh" ]
then
    /bin/bash -c "$(curl --fail --location --show-error --silent 'https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh')"
fi

#
# Configure Starship & Z Shell
#

chmod 0600 "${HOME}/.starship"
chmod 0600 "${HOME}/.zshrc"
chmod 0600 "${HOME}/.zsh_aliases"
chmod 0600 "${HOME}/.zsh_functions"

chmod 0755 "/usr/local/share/zsh"
chmod 0755 "/usr/local/share/zsh/site-functions"
