# vim:ft=zsh ts=2 sw=2 sts=2 et fenc=utf-8
################################################################
# Utility functions
# This file holds some utility-functions for
# the powerlevel9k-ZSH-theme
# https://github.com/bhilburn/powerlevel9k
################################################################

# Exits with 0 if a variable has been previously defined (even if empty)
# Takes the name of a variable that should be checked.
function defined() {
  local varname="$1"

  typeset -p "$varname" > /dev/null 2>&1
}

# Given the name of a variable and a default value, sets the variable
# value to the default only if it has not been defined.
#
# Typeset cannot set the value for an array, so this will only work
# for scalar values.
function set_default() {
  local varname="$1"
  local default_value="$2"

  defined "$varname" || typeset -g "$varname"="$default_value"
}

# Converts large memory values into a human-readable unit (e.g., bytes --> GB)
printSizeHumanReadable() {
  typeset -F 2 size
  size="$1"+0.00001
  local extension
  extension=('B' 'K' 'M' 'G' 'T' 'P' 'E' 'Z' 'Y')
  local index=1

  # if the base is not Bytes
  if [[ -n $2 ]]; then
    for idx in "${extension[@]}"; do
      if [[ "$2" == "$idx" ]]; then
        break
      fi
      index=$(( index + 1 ))
    done
  fi

  while (( (size / 1024) > 0.1 )); do
    size=$(( size / 1024 ))
    index=$(( index + 1 ))
  done

  echo "$size${extension[$index]}"
}

# Gets the first value out of a list of items that is not empty.
# The items are examined by a callback-function.
# Takes two arguments:
#   * $list - A list of items
#   * $callback - A callback function to examine if the item is
#                 worthy. The callback function has access to
#                 the inner variable $item.
function getRelevantItem() {
  setopt shwordsplit # We need to split the words in $interfaces

  local list callback
  list=$1
  callback=$2

  for item in $list; do
    # The first non-empty item wins
    try=$(eval "$callback")
    if [[ -n "$try" ]]; then
      echo "$try"
      break;
    fi
  done
}

# OS detection for the `os_icon` segment
case $(uname) in
    Darwin)
      OS='OSX'
      OS_ICON=$(print_icon 'APPLE_ICON')
      ;;
    FreeBSD)
      OS='BSD'
      OS_ICON=$(print_icon 'FREEBSD_ICON')
      ;;
    OpenBSD)
      OS='BSD'
      OS_ICON=$(print_icon 'FREEBSD_ICON')
      ;;
    DragonFly)
      OS='BSD'
      OS_ICON=$(print_icon 'FREEBSD_ICON')
      ;;
    Linux)
      OS='Linux'
      OS_ICON=$(print_icon 'LINUX_ICON')
      ;;
    SunOS)
      OS='Solaris'
      OS_ICON=$(print_icon 'SUNOS_ICON')
      ;;
    *)
      OS=''
      OS_ICON=''
      ;;
esac

# Determine the correct sed parameter.
#
# `sed` is unfortunately not consistent across OSes when it comes to flags.
SED_EXTENDED_REGEX_PARAMETER="-r"
if [[ "$OS" == 'OSX' ]]; then
  local IS_BSD_SED="$(sed --version &>> /dev/null || echo "BSD sed")"
  if [[ -n "$IS_BSD_SED" ]]; then
    SED_EXTENDED_REGEX_PARAMETER="-E"
  fi
fi

# Print a deprecation warning if an old segment is in use.
# Takes the name of an associative array that contains the
# deprecated segments as keys, the values contain the new
# segment names.
print_deprecation_warning() {
  typeset -AH raw_deprecated_segments
  raw_deprecated_segments=(${(kvP@)1})

  for key in ${(@k)raw_deprecated_segments}; do
    if [[ -n "${POWERLEVEL9K_LEFT_PROMPT_ELEMENTS[(r)$key]}" ]] || [[ -n "${POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[(r)$key]}" ]]; then
      # segment is deprecated
      print -P "%F{yellow}Warning!%f The '$key' segment is deprecated. Use '%F{blue}${raw_deprecated_segments[$key]}%f' instead. For more informations, have a look at the CHANGELOG.md."
    fi
  done
}

