#!/bin/bash
geth attach --exec clique.proposals geth.ipc > temp.list
cat temp.list
read
for i in $(cat temp.list | grep : | awk '{print $1}')
do
   newi=${i::-1}
#   echo -e "$i >> $newi"
   VAR="clique.discard(\"$newi\")"
   geth attach --exec "$VAR" geth.ipc
   sleep 1
done
rm temp.list
