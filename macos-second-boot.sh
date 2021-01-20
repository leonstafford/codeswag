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
wget https://addons.mozilla.org/firefox/downloads/file/3701081/ublock_origin-1.32.4-an+fx.xpi
wget https://addons.mozilla.org/firefox/downloads/file/3688243/bitwarden_free_password_manager-1.47.1-an+fx.xpi
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
