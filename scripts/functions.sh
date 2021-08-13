function clique_proposals {
  PROPOSALS=$(geth attach --exec clique.proposals geth.ipc)
  for PROPOSAL in "${PROPOSALS[@]}"
  do
    echo "$PROPOSAL"
  done
  read
}

function clique_propose {
#while true; do
 echo "Current Proposals : "
 clique_proposals
 read -p "Input your public address: " PADDR
 read -p "Add or remove?(true/false): " ARG
 VAL="clique.propose(\"$PADDR\",$ARG)"
 echo "VAL : $VAL"
 geth attach --exec $VAL geth.ipc
 read
#done
}

function admin_addpeer {
 while :
 do
  read -p "Input your enode for admin.addPeer(): " ENODE
  VAL="admin.addPeer(\"$ENODE\")"
  echo -e "VAL : $VAL\n"
  geth attach --exec $VAL geth.ipc
 done
}

PS3="Select function: "
FUNCTIONS=("clique_proposals" "clique_propose" "admin_addpeer")
#MAIN
select i in "${FUNCTIONS[@]}"; do
	case $i in
	${FUNCTIONS[0]} )
		echo "These is ${FUNCTIONS[0]}"
		;;
	${FUNCTIONS[1]} )
		echo "This is ${FUNCTIONS[1]}"
		;;
	${FUNCTIONS[2]} )
		echo "This is ${FUNCTIONS[2]}"
		;;
        ${FUNCTIONS[3]} )
                echo "This is ${FUNCTIONS[3]}"
                ;;
	*)
		echo "Please select available functions."
		;;
	esac
done
#while :
#do
#  clear
#  "Current functions are : "
#  for i in "${FUNCTIONS[@]}"
#  do
#    echo "$i"
#  done
#  read -p "type in function: " FUNC
#  $FUNC
#done
