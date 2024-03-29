# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

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
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(git ssh-agent ubuntu docker nmap pep8 autopep8 pip python sudo rsync systemd tmux vim-interaction virtualenv colored-man-pages battery colorize cp github jsontools mosh repo tig vagrant kubectl gcloud aws)

# plugins=(git ssh-agent ubuntu docker nmap pep8 autopep8 pip python sudo rsync systemd tmux vagrant vim-interaction virtualenv colored-man-pages zsh-syntax-highlighting terraform terragrunt kubectl kube-ps1 aws battery colorize cp github helm jsontools lol mosh repo salt tig)

zstyle :omz:plugins:ssh-agent identities id_rsa

source $ZSH/oh-my-zsh.sh

function kubecon () {
  if [[ $KUBECON -eq 1 ]]; then
    KUBECON=0
  else
    KUBECON=1
  fi

  if [[ $KUBECON -eq 1 ]] ; then
    RPROMPT='%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'
  else
    RPROMPT=''
  fi
}


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

alias ping="grc ping"
alias mtr="grc mtr"
alias dig="grc dig"
alias mount="grc mount"
alias tail="grc tail"
alias ps="grc ps"
alias ip="ip -c"
alias cat="/usr/bin/batcat -pp"
alias pcat="fzf --preview 'batcat --color=always --style=numbers --line-range=:500 {}'"
alias myip="curl -s https://www.onyphe.io/api/myip | jq .myip"

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias meteo='curl wttr.in'

### Copy my ssh key to clipboard
function myssh () {
    if pbcopy < ~/.ssh/id_rsa.pub ; then
        echo 'SSH key copied to clipboard!'
        echo
        cat ~/.ssh/id_rsa.pub
        echo
    else
        echo 'something went wrong!'
    fi
}

function kube-monit () {
  tmux new-session -d 'kubectl --namespace ingress-nginx logs -f -l app.kubernetes.io/name=ingress-nginx'
  tmux split-window -v 'watch kubectl top pod'
  tmux split-window -h 'watch kubectl top node'
  tmux split-window -h 'watch kubectl get hpa'
  tmux -2 attach-session -d

}

function mfa () {

  MFA_FILE=$HOME/.mfa

  len=($(yq -r ".mfa | keys[]" $MFA_FILE | xargs))

  for item in $len
  do
    secret=$(yq -r ".mfa[$item]" .mfa)
    
    echo $secret | jq -r .name
    oathtool --totp --base32 $(echo $secret | jq -r .secret)
    echo 
    
  done
}


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin:$HOME/Repo/go/bin"
#export GOPATH=$HOME/Repo/go
#source /usr/local/lib/python2.7/dist-packages/powerline/bindings/zsh/powerline.zsh

export HEDGEDOC_SERVER="https://docs.prevo.st/"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/bin:$PATH"
