#!/bin/bash

clear
echo " "
echo -n "Type the number of VMs you want to delete, followed by [ENTER]: "
read VMNUMBER

PT=1
while [ $PT -le $VMNUMBER ]
do
gbp policy-target-delete $PT 
openstack server delete VM$PT
PT=$(( $PT + 1 ))
done

gbp ptg-delete web
gbp external-policy-delete internet

gbp policy-rule-set-delete PRS

gbp policy-rule-delete ALL

gbp policy-classifier-delete ALL

gbp policy-action-delete redirect 

gbp network-service-policy-delete vip

gbp servicechain-spec-delete SCS

gbp servicechain-node-delete VPN
gbp servicechain-node-delete FW 
gbp servicechain-node-delete LB 

gbp l3p-delete remote-vpn-client-pool-cidr-l3policy
