source ~/tools/zsh-defer/zsh-defer.plugin.zsh
# If you come from bash you might have to change your $PATH.
#export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $HOME/.zsh_profile

export LANG=en_US.UTF-8
# Create a cache folder if it isn't exists
if [ ! -d "$HOME/.cache/zsh" ]; then
    mkdir -p $HOME/.cache/zsh
fi

# Define a custom file for compdump
export ZSH_COMPDUMP="$HOME/.cache/zsh/zcompdump-$HOST-$ZSH_VERSION"

# Brew (macOS only)
[[ "$OSTYPE" == darwin* ]] && [ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# Disable untracked files dirty
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Enable completion waiting dots
COMPLETION_WAITING_DOTS="true"

# Load oh-my-zsh
zsh-defer source $ZSH/oh-my-zsh.sh

# Custom profile
zsh-defer source $HOME/.zsh_profile

# Defer plugin loading
zstyle ':omz:plugins:nvm' lazy yes

plugins=(
  nvm
  vi-mode
)

# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Export scripts
export PATH=$PATH:$HOME/bin/.local/scripts

# Export node 18
export PATH="/opt/homebrew/opt/node@18/bin:$PATH"

# Compilation flags
export ARCHFLAGS="-arch x86_64"

# Vim key bindings
bindkey -v


export GPG_TTY=$(tty)

# Lua Roack molten dependency
export MAGICK_HOME=/opt/homebrew/opt/imagemagick
export PATH=$MAGICK_HOME/bin:$PATH

# Add cargo
export PATH="$HOME/.cargo/env:$PATH"

# Add pytorch
#export LIBTORCH=/Users/nerap/personal/libtorch
export LIBTORCH_USE_PYTORCH=1

# Add pyenv to PATH
export PATH="$HOME/.pyenv/bin:$PATH"
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init --path)"

# Function to get the current Git branch, folder name, or root, with unstaged change indicator for regular repos
function get_git_branch_or_folder() {
    if ! git rev-parse --is-inside-git-dir &>/dev/null; then
        echo "nothing"
        return
    fi

    if $(git rev-parse --is-bare-repository) &>/dev/null; then
        echo "bare"
    else
        # We're in a regular Git repo
        local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
        local changes=""

        # Check for unstaged changes
        if ! git diff --quiet --exit-code; then
            changes="*"
        fi

        if [[ -n "$branch" ]]; then
            echo "${branch}${changes}"
        else
            # We're probably in a detached HEAD state, so get the SHA
            echo "$(git rev-parse --short HEAD 2>/dev/null)${changes}"
        fi
    fi
}

function git_branch_prompt() {
    local branch=$(get_git_branch_or_folder)
    if [[ "$branch" != "nothing" ]]; then
        echo "%F{#ff757f}‹${branch}›%f"
    fi
}

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

  local git_branch='$(git_branch_prompt)'

  PROMPT="╭─${user_host} ${current_dir} ${git_branch}
  ╰─$PR_PROMPT "
  RPROMPT="${return_code}"

  ZSH_THEME_GIT_PROMPT_PREFIX="%F{#ff757f}‹"
  ZSH_THEME_GIT_PROMPT_SUFFIX="› %f"
}

setopt prompt_subst

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
command -v pyenv >/dev/null 2>&1 && eval "$(pyenv init -)"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# Claude / local bin
export PATH="$HOME/.local/bin:$PATH"

# On a headless box, route browser-opening (claude login, MCP OAuth, gh auth…)
# to the Mac via open-url + the watcher `devbox up` starts.
[[ "$OSTYPE" != darwin* ]] && export BROWSER="$HOME/bin/.local/scripts/open-url"

# On a headless box, use the stable forwarded-agent socket (kept fresh by
# ~/.ssh/rc) so git@github keeps working in tmux panes across reconnects.
[[ "$OSTYPE" != darwin* ]] && [ -S "$HOME/.ssh/ssh_auth_sock" ] && export SSH_AUTH_SOCK="$HOME/.ssh/ssh_auth_sock"

# macOS-only extras
if [[ "$OSTYPE" == darwin* ]]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  export PATH="$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator"
  export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
fi

# Secrets (API keys, tokens) — kept OUT of this public repo in a gitignored local
# file. Create ~/.zsh_secrets with your `export FOO=...` lines. See dotfiles setup.
[ -f "$HOME/.zsh_secrets" ] && source "$HOME/.zsh_secrets"
