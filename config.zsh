POWERLEVEL9K_MODE='awesome-patched'
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%{%F{249}%}\u250f"
POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="%{%F{249}%}\u2517%{%F{default}%} "
POSWERLEVEL9K_CUSTOM_SSH_CONNECTION="ssh_connection"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=0
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
POWERLEVEL9K_RAM_ELEMENTS=(ram_free)
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M:%S} \UE12E"
POWERLEVEL9K_SHOW_CHANGESET=false
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=('os_icon' 'custom_ssh_connection' 'root_indicator' 'context' 'aws' 'dir' 'vcs')
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=('status' 'rspec_stats' 'nvm' 'rvm_joined' 'load' 'ram' 'battery' 'time')
#POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=('status' 'rspec_stats' 'nvm' 'rvm_joined' 'go_version_joined' 'virtualenv_joined' 'node_version_joined' 'php_version_joined' 'history' 'ip')
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=('status' 'rspec_stats' 'history' 'ip')
ZSH_THEME="powerlevel9k/powerlevel9k"
