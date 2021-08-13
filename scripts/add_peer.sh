while :
do
  read -p "Input your enode for admin.addPeer(): " ENODE
  VAL="admin.addPeer(\"$ENODE\")"
  echo -e "VAL : $VAL\n"
  geth attach --exec $VAL geth.ipc
done
