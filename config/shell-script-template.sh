#!/bin/sh -
#set -v # verbose: echos all commands before executing, useful for debugging
set -u # nounset: attempting to use undefined variable outputs error message and exit
set -e # errexit: Abort script at first command exit w non-zero status

# meta information
__ScriptVersion="yyyy.mm.dd"
__ScriptName="shell-script-template.sh"
__ScriptFullName="$0"
__ScriptArgs="$*"
__TRUE=1
__FALSE=0
__ECHO_DEBUG=$__TRUE
__CURRENT_TIME="`date +%Y_%m_%d-%H_%M_%S`";
__LOGFILE="/tmp/$( echo "$__ScriptName" | sed s/.sh/-$__CURRENT_TIME.log/g )"

#---  FUNCTION  --------------------------------------------------------------------------------------------------------
#          NAME:  __detect_color_support
#   DESCRIPTION:  Try to detect color support.
#-----------------------------------------------------------------------------------------------------------------------
_COLORS=${BS_COLORS:-$(tput colors 2>/dev/null || echo 0)}
__detect_color_support() {
  # shellcheck disable=SC2181
  if [ $? -eq 0 ] && [ "$_COLORS" -gt 2 ]; then
    RC='\033[1;31m'
    GC='\033[1;32m'
    BC='\033[1;34m'
    YC='\033[1;33m'
    EC='\033[0m'
  else
    RC=""
    GC=""
    BC=""
    YC=""
    EC=""
  fi
}
__detect_color_support

#---  FUNCTION  --------------------------------------------------------------------------------------------------------
#          NAME:  echoerr
#   DESCRIPTION:  Echo errors to stderr.
#-----------------------------------------------------------------------------------------------------------------------
echoerror() {
  printf "${RC} * ERROR${EC}: %s\\n" "$@" 1>&2
}

#---  FUNCTION  --------------------------------------------------------------------------------------------------------
#          NAME:  echoinfo
#   DESCRIPTION:  Echo information to stdout.
#-----------------------------------------------------------------------------------------------------------------------
echoinfo() {
  printf "${GC} *  INFO${EC}: %s\\n" "$@"
}

#---  FUNCTION  --------------------------------------------------------------------------------------------------------
#          NAME:  echowarn
#   DESCRIPTION:  Echo warning information to stdout.
#----------------------------------------------------------------------------------------------------------------------
echowarn() {
  printf "${YC} *  WARN${EC}: %s\\n" "$@"
}

#---  FUNCTION  --------------------------------------------------------------------------------------------------------
#          NAME:  echodebug
#   DESCRIPTION:  Echo debug information to stdout.
#-----------------------------------------------------------------------------------------------------------------------
echodebug() {
  if [ "$__ECHO_DEBUG" -eq "$__TRUE" ]; then
    printf "${BC} * DEBUG${EC}: %s\\n" "$@"
  fi
}

__usage() {
  cat <<EOT

  Usage :  ${__ScriptName} [options] [args]

  Examples:
    - ${__ScriptName} -h 
    - ${__ScriptName} -p hello
    - ${__ScriptName} -m multiple -m arguments

  Options:
    -h  Display this message

    --print Print message
EOT
} 

#-- LOGGING ------------------------------------------------------------------------------------------------------------
exec &> >(tee $__LOGFILE)

#--- PROCESSING COMMAND LINE ARGUMENTS ---------------------------------------------------------------------------------
while getopts ':p:hm:"' opt; do # necessary to prepend with : to handle invalid options and arguments
  case "${opt}" in

  h)
    echoinfo "-h prints help message, ignores arguments."
    __usage
    exit 0
    ;;
  p)
    echoinfo "-p flag was set with arguments $OPTARG"
    exit 0
    ;;

  m)
    multi+=("$OPTARG")
    ;;

  \?)
    echoerror "Option does not exist : $OPTARG"
    exit 1
    ;;

  :)
    echoerror "Option $OPTARG requires an argument"
    exit 1
    ;;

  esac # --- end of case ---
done
shift $((OPTIND - 1))

if [ -v multi[@] ] && [ ${#multi[@]} -gt $__FALSE ]; then
  echoinfo "The whole list of -m values is ${multi[*]}"
fi

