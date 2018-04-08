function rails() {
  if [ "$1" = "start" ]; then
     if [ "$2" = "" ]; then
        RENV="development"
     else
        RENV="$2"
     fi
	 if [ "$3" = "" ]; then
		PORT="3000"
	 else
		PORT="$3"
	 fi
     rails server -d -b 0.0.0.0 -e "$RENV" -p "$PORT"
     return 0
  elif [ "$1" = "stop" ]; then
     if [ -f tmp/pids/server.pid ]; then
        kill $2 $(cat tmp/pids/server.pid)
        return 0
     else
        echo "It seems there is no server running or you are not in a rails project root directory"
        return 1
     fi
  elif [ "$1" = "restart" ]; then
     rails stop && rails start $2
  else
     command rails $@
  fi;
}
rails $@
