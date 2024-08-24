# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
export ZSH_THEME="robbyrussell"


plugins=(git)

source $ZSH/oh-my-zsh.sh



COMPLETION_WAITING_DOTS="true"


# You may need to manually set your language environment

# Preferred editor for local and remote sessions
export EDITOR='nvim'


export PATH=$PATH:$HOME/bin/.local/scripts

source $HOME/.zsh_profile

# Compilation flags
export ARCHFLAGS="-arch x86_64"

bindkey -v

alias vi="nvim"
alias vim="nvim"
alias view="nvim -R"
alias vimdiff="nvim -d"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GPG_TTY=$(tty)

export MAGICK_HOME=/opt/homebrew/opt/imagemagick
export PATH=$MAGICK_HOME/bin:$PATH

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/rapahel/personal/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"

git_folder=$(basename `git rev-parse --show-toplevel 2> /dev/null` 2> /dev/null)
if [ -z $git_folder ]; then
  is_conda_env=0
else
  is_conda_env=$(conda info --envs | grep $git_folder | wc -l | tr -d ' ' 2> /dev/null)
fi

if [ $? -eq 0 ]; then
    eval "$__conda_setup"
    if [ $((is_conda_env)) -eq 1 ]; then
        echo "Activating conda environment $git_folder"
        conda activate $git_folder
    else
        conda deactivate
    fi
else
    if [ -f "/Users/rapahel/personal/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/rapahel/personal/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/rapahel/personal/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

