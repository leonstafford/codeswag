#!/bin/sh

# install and configure apps OS 
# this script is for first run, before logging out and running macos-second-boot.sh

# set terminal profile to Homebrew (green on black)
sudo -u "$USER" defaults write com.apple.Terminal.plist "Default Window Settings" "Homebrew"
sudo -u "$USER" defaults write com.apple.Terminal.plist "Startup Window Settings" "Homebrew"
# needs Terminal restart to take effect
# killall Terminal

# install GUI apps (free and purchased)
brew install --cask \
 audio-hijack \
 authy \
 bitwarden \
 cyberduck \
 docker \
 farrago \
 fission \
 firefox \
 firefox-nightly \
 google-chrome \
 lens \
 little-snitch \
 loopback \
 mamp \
 mas \
 postman \
 sequel-ace \
 slack \
 soundsource \
 telegram \
 thunderbird \
 transmission \
 tunnelblick \
 vlc

# install App Store apps via mas CLI tool
# if encountering issues, check note about running within tmux
mas install 1079647046  # Profiling Viewer
mas install 1295203466  # Microsoft Remote Desktop
mas install 1352778147  # Bitwarden
mas install 1496833156  # Swift Playgrounds
mas install 424389933   # Final Cut Pro
mas install 497799835   # Xcode
mas install 634148309   # Logic Pro  
mas install 682658836   # GarageBand

# install paid GUI apps
echo "Manually install Logic Pro, Profiling Viewer, etc from App Store"

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
 shellcheck \
 kcov \
 hugo \
 awscli \
 qcachegrind \
 php 

# install ShellSpec
brew tap shellspec/shellspec && brew install shellspec

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

