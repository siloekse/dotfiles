function vpn() {
  local usage="Usage: $0 <kill|revive>"
  case $# in
    0)
      echo "$usage"
      return 1
      ;;
    1)
      case $1 in
        kill)
          echo "Killing VPN client..."
          launchctl remove com.paloaltonetworks.gp.pangpa
          launchctl remove com.paloaltonetworks.gp.pangps
          echo "Done!"
          ;;
        revive)
          echo "Reviving VPN client..."
          launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangpa.plist
          launchctl load /Library/LaunchAgents/com.paloaltonetworks.gp.pangps.plist
          echo "Done!"
          ;;
        *)
          echo "'$1' is not a valid command."
          echo "$usage"
          return 1
          ;;
      esac
      ;;
    *)
      echo "Too many arguments provided ($#)."
      echo "$usage"
      return 1
      ;;
  esac
}
