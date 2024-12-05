#!/bin/sh

# usage
# 
# sh -c "$(curl -sSl https://raw.githubusercontent.com/leonstafford/codeswag/master/setupcamp.sh)"

# notes on USB audio:
#
# on X1C - use USB A -> C cable, not working via USB-C only
# doas rcctl set sndiod flags -f rsnd/0 -F rsnd/1
# doas rcctl restart sndiod                       
# x1c$ sndioctl output.level=0.7   
# then need to restart browser tab if playing

DEPENDENCIES="git
vim
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

LEONSTAFFORD_REPOS="ljsdotdev
notfiles
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

    echo "cloning $DIRECTORY"
    # git clone "git@github.com:leonstafford/$REPO.git"

  fi
done

# grab my few notfiles lines and append/create in appropriate files for system
cd "$HOME/notfiles" || exit 1

cat <<'EOVIM' > "$HOME/.vimrc"
set ts=2 sw=2 expandtab ruler nu noswapfile colorcolumn=80                      
syntax on                                                                       
colorscheme default
                                                                                
autocmd Filetype php setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4       
autocmd Filetype js setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
EOVIM

cat <<'EOTMUX' > "$HOME/.tmux.conf"
# moving between panes
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# large history limit
set -g history-limit 999999999
EOTMUX

# set up global `~/.gitignore`
cat <<'EOIGNORE' > "$HOME/.gitignore"
*.swp
*.swo
.DS_Store
*.cache
venv/
EOIGNORE

# new terminals open fullscreen
cat <<'EOCWMRC' > "$HOME/.cwmrc"
bind-key CM-Return "xterm -maximized"
borderwidth 0
EOCWMRC


# global ignore
git config --global core.excludesFile "$HOME/.gitignore"

# setup git user config
git config --global user.email "me@ljs.dev"
git config --global user.name "Leon Stafford"


