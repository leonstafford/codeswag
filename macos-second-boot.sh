#!/bin/sh

# install and configure apps OS 
# this script is for second run, after running macos-first-boot.sh
# requires: RSA keypair configured for git access

# install PHP tools
brew install composer 
pecl install xdebug

# clone all projects and set some minimal defaults:
sh -c "$(curl -sSl https://raw.githubusercontent.com/leonstafford/codeswag/master/setupcamp.sh)"


# Install Firefox addons (on launch, allow in private sessions):
cd /tmp || exit 1
wget https://addons.mozilla.org/firefox/downloads/file/3961087/ublock_origin-1.43.0.xpi
wget https://addons.mozilla.org/firefox/downloads/file/3872283/privacy_badger17-2021.11.23.1.xpi
wget https://addons.mozilla.org/firefox/downloads/file/3960137/bitwarden_password_manager-2022.5.0.xpi
/Applications/Firefox.app/Contents/MacOS/firefox-bin ./*.xpi* &
rm ./*.xpi*


# manual (for now) FireFox changes

echo ""
echo "Manually make the following changes in Firefox: "
echo ""
echo " - New windows and tabs to blank page"
echo " - disable all home content boxes"
echo " - disallow saving passwords"
echo " - never remember history (but don’t use private browsing always)"
echo " - disable notifications"
echo " - don’t check default browser on start"

exit 0
