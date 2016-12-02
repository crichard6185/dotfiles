# enable color support of ls if it seems available
export GREP_COLOR=33
USE_COLOR_CMDS=""

if [ ! -z "$USE_COLOR_CMDS" ]; then
  # Highlight search term in grep
  alias grep='grep --color=auto --line-number'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
unset USE_COLOR_CMDS

alias vim="vimx"

export LS_CMD="ls"
alias ls="$LS_CMD"
alias ll="$LS_CMD -al"
alias la="$LS_CMD -A"
alias l="$LS_CMD -lahrtc"
alias gk="gitk 2> /dev/null"
alias ts="cd ~/workspace/townhall_server"
alias is="cd ~/workspace/ionic_api_server"

# Syntax highlighting for less (-R for RAW ^ colors)
alias less='less -R'

alias path='echo $PATH'

# Interactive delete
alias rm='rm -i'

# Verbosely show progress for move and copy
alias cp='cp -v'
alias mv='mv -v'

# Working with archives
alias ctar="tar -vzcf"
alias utar="tar -xvzf"
alias ltar="tar -vztf"

# Fully update operating system
if [ -f /etc/debian_version ]; then
  alias update_system="sudo bash -c 'apt-get -y update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y autoremove'"
elif [ -f /etc/redhat-release ]; then
  alias update_system="sudo bash -c 'yum -y update'"
elif [ $(uname -s) = "Darwin" ]; then
  alias update_system="brew update && brew upgrade"
fi

alias stop_elastic_search="launchctl unload -wF ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist"
alias start_elastic_search="launchctl load -wF ~/Library/LaunchAgents/homebrew.mxcl.elasticsearch.plist"

alias fix_nginx="sudo launchctl load -wF /Library/LaunchAgents/homebrew.mxcl.nginx.plist"

for FILE in ~/dotfiles/*/aliases.sh; do
  source $FILE
done

alias start_nginx="sudo launchctl start homebrew.mxcl.nginx"
alias stop_nginx="sudo launchctl stop homebrew.mxcl.nginx"
alias restart_nginx="stop_nginx && start_nginx"

alias nuke_dbs="bundle exec rake db:drop db:create db:migrate; RACK_ENV=test bundle exec rake db:drop db:create db:migrate"

alias register_ipad="(cd ~/im_workspace/im_server/; rake registrations:finish_pending)"
alias process_files="(cd ~/im_workspace/file_processor/; rake processor:handle_video_file; rake processor:handle_file; rake processor:fetch_pending_encryption_keys; rake processor:encrypt_key_per_user)"
alias add_local="(cd ~/im_workspace/im_server; rake servers:add[local,https://`hostname`] services:reset)"
alias ..="cd .."

function read_x509() {
  openssl x509 -noout -text -in $1
}
