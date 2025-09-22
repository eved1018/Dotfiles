alias word='open -a "Microsoft Word.app"'
alias nvim="/Users/evanedelstein/nvim-macos-arm64/bin/nvim"
alias c="clear"
alias l="ls -alG"
alias ll="ls -alG"
alias h="htop" 
alias r="ranger"
alias m="cmatrix"
alias raji="cd Desktop/Research_Evan/Raji_Summer2019_atom"
# alias g++="/opt/homebrew/Cellar/gcc/11.2.0/bin/g++-11"
alias nconf="nvim $HOME/.config/nvim/init.lua"
alias zconf="nvim $HOME/.zshrc"
alias uconf="bash /Users/evanedelstein/Documents/CodingProjects/dotfiles/update.sh"


# command prompt colors
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
autoload -U colors && colors

# PS1="%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[cyan]%}%1~%{$reset_color%} %% "
PS1="%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[cyan]%}%~%{$reset_color%} %% "


#autocomplete
autoload -Uz compinit && compinit
RPROMPT="[%D{%f/%m/%y} | %D{%L:%M:%S}]"
setopt PROMPT_SUBST
# alias rpi="ssh f24s04@ssh.chuckkann2.hostedpi.com -p 5422"

# autoload -Uz compinit
# compinit
# zstyle ':completion:*' menu select

#export PATH="usr/local/bin"

PATH="$HOME/.pyenv/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"
# eval "$(direnv hook zsh)"
# eval "$(pyenv virtualenv-init -)"
# eval "$(pyenv init -)"
# setopt PROMPT_SUBST


JUNIT_HOME="$HOME/java"
PATH="$PATH:$JUNIT_HOME"
CLASSPATH="$CLASSPATH:$JUNIT_HOME/junit-4.13.2.jar:$JUNIT_HOME/hamcrest-core-1.3.jar"

# show_virtual_env() {
#   if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
#     echo "($(basename $VIRTUAL_ENV))"
#   fi
# }
# PS1='$(show_virtual_env)'$PS1

PATH="/Users/evanedelstein/perl7/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/evanedelstein/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/evanedelstein/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/evanedelstein/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/evanedelstein/perl5"; export PERL_MM_OPT;
PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"
PATH="/usr/local/opt/tcl-tk/bin:$PATH"
PATH="/opt/homebrew/opt/llvm/bin:$PATH"
PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"


 #>>> conda initialize >>>
#!! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/evanedelstein/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/evanedelstein/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/evanedelstein/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/evanedelstein/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
# conda deactivate

