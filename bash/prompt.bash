#!/usr/bin/bash

#source ~/dotfiles/git/detailed-git-prompt.sh
#source ~/dotfiles/git/completion.bash

if [ -f `which powerline-daemon` ]; then
    powerline-daemon -q
      POWERLINE_BASH_CONTINUATION=1
        POWERLINE_BASH_SELECT=1
          . /usr/share/powerline/bash/powerline.sh
fi

