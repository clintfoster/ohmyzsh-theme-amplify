# ohmyzsh theme that shows Amplify env, git branch and current folder
# Adapted from sporty_256.zsh-theme
#
# Prereqs:
# - zsh shell (now the default in macOS)
# - https://ohmyz.sh
# - https://stedolan.github.io/jq
#
# Instructions:
# - Copy to: ~/.oh-my-zsh/themes
# - In ~/.zshrc set ZSH_THEME="amplify"
#
# Suggestions?
# - clint@computer.org

# From https://www.xiegerts.com/post/show-current-aws-amplify-environment/
amplify_prompt () {
    AMP_PROJ_DIR=$(git rev-parse --show-toplevel 2>/dev/null)  # find root via git
    if [ -z "$AMP_PROJ_DIR" ]  # if not in git proj, works only in root
    then
        AMP_PROJ_DIR='.'
    fi   
    AMP_ENV_FILE=$AMP_PROJ_DIR/amplify/.config/local-env-info.json
    if [ -f "$AMP_ENV_FILE" ]; then
        local env_info=$(cat $AMP_ENV_FILE | jq -r ".envName") 
        echo "🚀 %{$fg_bold[cyan]%}$env_info  "
    fi
}

git_prompt () {
    echo "%{$fg_bold[blue]%}$(git_prompt_info)"
}

FOLDER_PROMPT='📁 %F{208}%c%f'
PROMPT='$(amplify_prompt)$(git_prompt)$FOLDER_PROMPT  %{$fg_bold[yellow]%}%# %{$reset_color%}'

# Uncomment if you want terminal user on right like sporty_256 theme
#RPROMPT='%B%F{208}%n%f%{$fg_bold[white]%}@%F{039}%m%f%{$reset_color%}'
RPROMPT=

ZSH_THEME_GIT_PROMPT_PREFIX="🐶%F{154} %f%F{124}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}  "

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}%B✘%b%F{154}%f%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔%F{154}"