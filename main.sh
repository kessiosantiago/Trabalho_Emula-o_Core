#!/bin/bash

tcp=bbr
#core-gui --start .core/configs/machine_16.imn &
runtime(){
for i in `seq 2`
do
   machine=16
   bd=50000000
   for j in `seq 2`
   do
      count=1000
      newBd=`echo "$bd + 50000000" | bc`
      sed -i '/bandwidth/s/'$bd'/'$newBd'/g' .core/configs/machine_$machine.imn
      bd=`echo "$bd + 50000000" | bc`
      for i in `seq 2`
      do
         cenario=1
         for k in `seq 10`
         do
         mkdir -p ~/core/$tcp/machine_$machine/
         read -p "Executando o cenario $k "
            for l in  `seq $machine`
            do
               sed -n '/100% 0,00/p' /tmp/pycore.*/n$l.conf/n$l.txt | cut -d"=" -f2 >> ~/core/$tcp/machine_$machine/cenario$cenario.txt
               echo " " >> ~/core/$tcp/machine_$machine/cenario$cenario.txt
            done
         done
         cenario=`echo "$cenario + 1" | bc`
         newCount=`echo "$count + 1000" | bc`
         sed -i '/cmdup/s/count='$count'/count='$newCount'/g' .core/configs/machine_$machine.imn
         count=`echo "$count + 1000" | bc`
      done
   done
machine=`echo "$machine * 2" | bc`
done
}

runtime
#tcp=cubic
#sed -i '/net.ipv4.tcp_congestion_control/s/bbr/cubic/g' /etc/sysctl.conf
#sysctl --system
#runtime

#sed -i '/net.ipv4.tcp_congestion_control/s/cubic/reno/g' /etc/sysctl.conf
#sysctl --system
#runtime
