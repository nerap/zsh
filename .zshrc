source ~/zsh-defer/zsh-defer.plugin.zsh
# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Disable untracked files dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Enable completion waiting dots
COMPLETION_WAITING_DOTS="true"

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Custom profile
zsh-defer source $HOME/.zsh_profile

# Defer plugin loading
zstyle ':omz:plugins:nvm' lazy yes

plugins=(
  git
  nvm
)

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Export scripts
export PATH=$PATH:$HOME/bin/.local/scripts

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Vim key bindings
bindkey -v

# Load nvim
export NVM_DIR="$HOME/.nvm"
zsh-defer sh -c "source $NVM_DIR/nvm.sh"
zsh-defer sh -c "source $NVM_DIR/bash_completion"

export GPG_TTY=$(tty)

# Lua Roack molten dependency
export MAGICK_HOME=/opt/homebrew/opt/imagemagick
export PATH=$MAGICK_HOME/bin:$PATH

# Manage custom themes
() {
  local PR_USER PR_USER_OP PR_PROMPT PR_HOST

  # Check the UID
  if [[ $UID -ne 0 ]]; then # normal user
    PR_USER='%F{#7dcfff}%n%f'
    PR_USER_OP='%F{#7dcfff}%#%f'
    PR_PROMPT='%f➤ %f'
  else # root
    PR_USER='%F{#c53b53}%n%f'
    PR_USER_OP='%F{#c53b53}%#%f'
    PR_PROMPT='%F{#c53b53}➤ %f'
  fi

  # Check if we are on SSH or not
  if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
    PR_HOST='%F{#c53b53}%M%f' # SSH
  else
    PR_HOST='%F{#7dcfff}%m%f' # no SSH
  fi

  local return_code="%()"

  local user_host="${PR_USER}%F{#7dcfff}@${PR_HOST}"
  local current_dir="%B%F{#bb9af7}%~%f%b"
  local git_branch='$(git_prompt_info)'

  PROMPT="╭─${user_host} ${current_dir} \$(ruby_prompt_info) ${git_branch}
  ╰─$PR_PROMPT "
  RPROMPT="${return_code}"

  ZSH_THEME_GIT_PROMPT_PREFIX="%F{#ff757f}‹"
  ZSH_THEME_GIT_PROMPT_SUFFIX="› %f"
  ZSH_THEME_RUBY_PROMPT_PREFIX="%F{#ff757f}‹"
  ZSH_THEME_RUBY_PROMPT_SUFFIX="›%f"
}

setopt prompt_subst

#echo "Loading conda"
## >>> conda initialize >>>
## !! Contents within this block are managed by 'conda init' !!
#__conda_setup="$('/Users/rapahel/personal/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#
#git_folder=$(basename `git rev-parse --show-toplevel 2> /dev/null` 2> /dev/null)
#if [ -z $git_folder ]; then
#  is_conda_env=0
#else
#  is_conda_env=$(conda info --envs | grep $git_folder | wc -l | tr -d ' ' 2> /dev/null)
#fi
#
#if [ $? -eq 0 ]; then
#    eval "$__conda_setup"
#    if [ $((is_conda_env)) -eq 1 ]; then
#        echo "Activating conda environment $git_folder"
#        conda activate $git_folder
#    else
#        conda deactivate
#    fi
#else
#    if [ -f "/Users/rapahel/personal/miniconda3/etc/profile.d/conda.sh" ]; then
#        . "/Users/rapahel/personal/miniconda3/etc/profile.d/conda.sh"
#    else
#        export PATH="/Users/rapahel/personal/miniconda3/bin:$PATH"
#    fi
#fi
#unset __conda_setup
#echo "Loading unconda"
# <<< conda initialize <<<
