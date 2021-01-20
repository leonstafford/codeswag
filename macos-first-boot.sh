#!/bin/sh

# install and configure apps OS 
# this script is for first run, before logging out and running macos-second-boot.sh

# set terminal profile to Homebrew (green on black)
sudo -u "$USER" defaults write com.apple.Terminal.plist "Default Window Settings" "Homebrew"
sudo -u "$USER" defaults write com.apple.Terminal.plist "Startup Window Settings" "Homebrew"
# needs Terminal restart to take effect
killall Terminal

# install GUI apps
brew install --cask \
 docker \
 firefox \
 telegram \
 thunderbird \
 bitwarden \
 slack \
 authy

# give permission to open these first time without prompt
xattr -d -r com.apple.quarantine /Applications/Slack.app
xattr -d -r com.apple.quarantine /Applications/Docker.app
xattr -d -r com.apple.quarantine /Applications/Thunderbird.app
xattr -d -r com.apple.quarantine /Applications/Firefox.app
xattr -d -r com.apple.quarantine /Applications/Telegram.app
xattr -d -r com.apple.quarantine /Applications/Bitwarden.app
xattr -d -r com.apple.quarantine /Applications/Authy\ Desktop.app

# install CLI apps
brew install \
 tmux \
 wget
 shellcheck
 php 


# Disable auto-correct:
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

# Set tap to click:
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Enable 2-finger right click:
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true

# set dock to auto-hide
osascript -e 'tell application "System Events" to set the autohide of the dock preferences to true'

# Homebrew's PHP requires logout/in to take effect over local php
# some of the OS setting changes also require logging out/in
echo ""
echo "Initial setup complete"
echo ""
echo "Logout/in and run macos-first-boot.sh"

exit 0

