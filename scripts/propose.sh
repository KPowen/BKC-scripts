function clique_proposals {
  PROPOSALS=$(geth attach --exec clique.proposals geth.ipc)
  for PROPOSAL in "${PROPOSALS[@]}"
  do
    echo "$PROPOSAL"
  done
  read
}

function clique_purpose {
while :
 do
   echo "Current Proposals : "
   PROPOSALS=$(geth attach --exec clique.proposals geth.ipc)
   for PROPOSAL in "${PROPOSALS[@]}"
   do
     echo "$PROPOSAL"
   done
   read -p "Input your public address: " PADDR
   read -p "Add or remove?(true/false): " ARG
   VAL="clique.propose(\"$PADDR\",$ARG)"
   echo "VAL : $VAL"
   geth attach --exec $VAL geth.ipc
   read
 done
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

