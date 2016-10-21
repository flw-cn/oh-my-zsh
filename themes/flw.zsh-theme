export LSCOLORS=gxfxcxdxbxegedabagacad

function collapse_pwd {
    echo $(pwd | sed -e "s,^$HOME,~,")
}

function battery_charge {
    echo `$BAT_CHARGE` 2>/dev/null
}

PROMPT='
$(text_with_color %n $(ansi256color_fg 226)) \
at $(text_with_color %m $(ansi16color_fg_bold 6)) \
in $(text_with_color $(collapse_pwd) $(ansi16color_fg_bold 2))\
$(git_prompt_info)\
%{$reset_color%}
$ '

# RPROMPT='$(battery_charge)'

ZSH_THEME_GIT_PROMPT_PREFIX=" on $(ansi256color_bg 236)$(ansi256color_fg 226)"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"

ZSH_PROMPT_BASE_COLOR=$(ansi256color_bg 235)
ZSH_THEME_BRANCH_NAME_COLOR=$(ansi16color_fg_bold 2)
ZSH_THEME_SVN_PROMPT_PREFIX=" on "
ZSH_THEME_SVN_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_SVN_PROMPT_ADDITIONS="$(ansi16color_fg_bold 1)+"
ZSH_THEME_SVN_PROMPT_DELETIONS="$(ansi16color_fg_bold 1)✖"
ZSH_THEME_SVN_PROMPT_MODIFICATIONS="$(ansi16color_fg_bold 1)✎"
ZSH_THEME_SVN_PROMPT_REPLACEMENTS="$(ansi16color_fg_bold 1)∿"
ZSH_THEME_SVN_PROMPT_UNTRACKED="$(ansi16color_fg_bold 1)?"
ZSH_THEME_SVN_PROMPT_DIRTY="$(ansi16color_fg_bold 1)!"
ZSH_THEME_SVN_PROMPT_CLEAN=""

function svn_prompt_info() {
  local info
  info=$(svn info 2>&1) || return 1; # capture stdout and stderr
  local repo_need_upgrade=$(svn_repo_need_upgrade $info)
  local update_date="$(grep '^Last Changed Date:' <<< "$info" | egrep -o '\d\d\d\d-\d\d-\d\d \d\d:\d\d:\d\d')"

  if [[ -n $repo_need_upgrade ]]; then
    printf '%s%s%s%s%s%s\n' \
      $ZSH_THEME_SVN_PROMPT_PREFIX \
      $ZSH_PROMPT_BASE_COLOR \
      $repo_need_upgrade \
      $ZSH_PROMPT_BASE_COLOR \
      $ZSH_THEME_SVN_PROMPT_SUFFIX \
      $ZSH_PROMPT_BASE_COLOR
  else
    printf '%s%s%s%s %s%s: %s%s%s%s%s %s' \
      $ZSH_PROMPT_BASE_COLOR \
      $ZSH_THEME_SVN_PROMPT_PREFIX \
      $ZSH_THEME_BRANCH_NAME_COLOR \
      $(svn_current_branch_name $info) \
      \
      $ZSH_PROMPT_BASE_COLOR \
      $(svn_current_revision $info) \
      \
      $ZSH_PROMPT_BASE_COLOR \
      "$(svn_status_info $info)" \
      \
      $ZSH_PROMPT_BASE_COLOR \
      $ZSH_THEME_SVN_PROMPT_SUFFIX \
      \
      $ZSH_PROMPT_BASE_COLOR \
      "last changed at $update_date"
  fi
}
