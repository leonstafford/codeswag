#!/bin/sh

# usage
# 
# sh -c "$(curl -sSl https://raw.githubusercontent.com/leonstafford/codeswag/master/setupcamp.sh)"

DEPENDENCIES="git
vim
composer
tmux
"

for DEPENDENCY in $DEPENDENCIES
do
  echo "Checking $DEPENDENCY dependency"
  if ! command -v "$DEPENDENCY"
  then
      echo "$DEPENDENCY could not be found"
      exit
  fi
done

# add GitHub RSA sig to known hosts
echo "github.com ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ==" >> "$HOME/.ssh/known_hosts"

# home is where the home is (symlink WP plugins into site)
cd "$HOME" || exit 1

# shallow clone all my WordPress plugin and commonly worked on repos, such as
# Hugo sites

LEONSTAFFORD_REPOS="notfiles
wp2static
wp2static-addon-advanced-crawling
wp2static-addon-advanced-detection
wp2static-addon-advanced-html-processor
wp2static-addon-algolia
wp2static-addon-azure
wp2static-addon-bitbucket
wp2static-addon-boilerplate
wp2static-addon-bunnycdn
wp2static-addon-cloudflare-workers
wp2static-addon-ftp
wp2static-addon-gcs
wp2static-addon-github
wp2static-addon-gitlab
wp2static-addon-netlify
wp2static-addon-s3
wp2static-addon-sftp
wp2static-addon-static-form-converter
wp2static-addon-vercel
wp2static-addon-woocommerce-snipcart
wp2static-addon-zip
static-html-output
simplerstatic
lokl
lokl-cli
ljsdotdev
check-for-dirty-local-repos
lokl-www
wp2static-www
wp2staticpsr7
wp2staticpromises
wp2staticguzzle
AriseByAnyOtherName
statichtmloutput-www
accessible-minimalism-hugo-theme
"

# skip any already existing, allowing to update script and pull new ones safely
# iterate each repo
for REPO in $LEONSTAFFORD_REPOS
do
  DIRNAME="$(echo "$REPO" | cut -d'/' -f2)"
  echo ""
  echo "##############################################"
  echo ""
  echo "Processing $DIRNAME..."
  echo ""
  echo "##############################################"
  echo ""

  if [ -d "$DIRECTORY" ]
  then
      echo "$DIRECTORY already exists, not doing anything."
  else
    cd "$HOME" || exit 1

    # shallow clone
    git clone --quiet --depth=1 "git@github.com:leonstafford/$REPO.git"

    # cd into repo
    cd "$DIRNAME" || exit 1

    # if [[ -f <file> ]]
    # then
    #     echo "Composer file detected, installing dependencies."
    #     composer i -q || exit 1
    # fi
  fi
done


# grab my few notfiles lines and append/create in appropriate files for system
cd "$HOME/notfiles" || exit 1

cat <<'EOVIM' >> "$HOME/.vimrc"
set ts=2 sw=2 expandtab ruler nu noswapfile colorcolumn=80                      
syntax on                                                                       
colorscheme delek                                                               
                                                                                
autocmd Filetype php setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4       
autocmd Filetype js setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
EOVIM

cat <<'EOTMUX' >> "$HOME/.tmux.conf"
# moving between panes
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# large history limit
set -g history-limit 999999999
EOTMUX

# set up global `~/.gitignore`
cat <<'EOIGNORE' >> "$HOME/.gitignore"
*.swp
*.swo
.DS_Store
*.cache
venv/
EOIGNORE

# global ignore
git config --global core.excludesFile "$HOME/.gitignore"

# setup git user config
git config --global user.email "me@ljs.dev"
git config --global user.name "Leon Stafford"

