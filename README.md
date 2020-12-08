# CodeSwag

My minimal required tools and code to keep working as I wander from laptop to 
 container to VM.

[![CircleCI](https://circleci.com/gh/leonstafford/codeswag.svg?style=svg)](https://circleci.com/gh/leonstafford/codeswag)

## Why Swag?

*Swag* is a term used in Australia/New Zealand, generally meaning some bedding
 and sleeping materials, rolled up around your other posessions to carry while
 hiking.

Of late, all my posessions have lived in a 70 litre backpack and covered some
 decent walking distances with me.

My coding setup has always been minimal, which also gives it the benefit of
 portability. It's been just Vim, tmux and git, with just a few lies of
 [notfiles](https://github.com/leonstafford/notfiles). That covers me for all
 the PHP, JavaScript and shell scripting I do, with dependency managers pulling
 in most code/libraries from each project's git repos.

## Need for automating my setup

I'm now working mostly on some WordPress plugins and a local hosting
  environment, which uses Docker. For this, I need to work in all of these
 environments, where compiling and deploying to test in them becomes painful
 and discourages me from rapid development, vs just coding in that environment:

 - native host (macOS at the moment, else OpenBSD, Linux, Windows)
 - local Docker containers
 - Alpine image within iOS (iSSH)
 - remote VMs, for support/dev work on StaticWeb.io or debugging envs

Being able to SSH into the target, load my RSA key and run CodeSwag's 1-liner
 to set everything up for me, will help me to not avoid work that otherwise
 requires taking my focus away from the task.

### What it should setup

 - grab my few notfiles lines and append/create in appropriate files for system
 - set up global `~/.gitignore`
 - shallow clone all my WordPress plugin and commonly worked on repos, such as
 Hugo sites

That should be about all that's required. For [Lokl](https://lokl.dev), I should
 have vim, git, tmux already there, same with the EC2 VMs, else can bake into
 the AMI. May be missing binaries on some environments, like `hugo`, but easily
 added.

## Usage

 - install RSA key
 - `sh -c "$(curl -sSl https://raw.githubusercontent.com/leonstafford/codeswag/master/setupcamp.sh)"`



