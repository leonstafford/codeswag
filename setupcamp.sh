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
  echo ""
  if ! command -v DEPENDENCY
  then
      echo "$DEPENDENCY could not be found"
      exit
  fi
done


# home is where the home is (symlink WP plugins into site)
cd "$HOME" || exit 1

# shallow clone all my WordPress plugin and commonly worked on repos, such as
# Hugo sites

WP2STATIC_REPOS="leonstafford/wp2static
leonstafford/notfiles
leonstafford/wp2static-addon-s3
leonstafford/wp2static-addon-zip
leonstafford/wp2static-addon-advanced-crawling
leonstafford/wp2static-addon-netlify
leonstafford/wp2static-addon-cloudflare-workers
"

# skip any already existing, allowing to update script and pull new ones safely
# iterate each repo
for REPO in $WP2STATIC_REPOS
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
    git clone --quiet --depth=1 "git@github.com:$REPO.git"

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
