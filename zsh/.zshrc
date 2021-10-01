# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/nockty/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="oh-my-via/via"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kubectl zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

export PATH=$PATH:/usr/local/go/bin
export GOPATH="${HOME?}/go"

# open ~/.zshrc in using the default editor specified in $EDITOR
alias ec="vim $HOME/.zshrc"

# source ~/.zshrc
alias sc="source $HOME/.zshrc"

alias c=clear
alias kd='k describe'

# Move to a specific repository
repo(){cd $HOME/dev/$1}

# Show last n commits
lc(){git log --pretty=format:"%H%x09%an%x09%ad%x09%s" --date=short | head -n $1}

# Fixup latest commit and rebase autosquash
gfix() {
  git add "$@"
  git commit --fixup $(git rev-parse HEAD) --no-verify
  STASH="true"
  if git stash | grep -q "No local changes to save"; then
    STASH="false"
  fi
  GIT_SEQUENCE_EDITOR=: git rebase -i --autosquash HEAD~2
  if [[ "${STASH}" == "true" ]]; then
    git stash pop
  fi
}

# Merge latest updates to the current branch (e.g. rb master)
rb() {g checkout $1 && gl && g checkout - && g merge $1}

# print the header (the first line of input)
# and then run the specified command on the body (the rest of the input)
# use it in a pipeline, e.g. ps | body grep somepattern
# e.g.
#     ps -o pid,comm | body sort -k2
#     ps -o pid,comm | body grep less
body() {
    IFS= read -r header
    printf '%s\n' "$header"
    "$@"
}

# autocompletion for kubectl
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

lastdl () { echo "~/Downloads/$(ls -tr ~/Downloads/|tail -1)" }

# # Uncomment this for prompting the Kubernetes context in the shell with the kprompt command
# source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
# export PS1nokube=$PS1
# export kubeinps1=false
# kprompt() {
#   if [ "$kubeinps1" = true ]
#   then
#     PS1=$PS1nokube
#     export kubeinps1=false
#   else
#     PS1='$(kube_ps1)'$PS1nokube
#     export kubeinps1=true
#   fi
# }
