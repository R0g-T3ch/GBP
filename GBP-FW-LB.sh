#!/bin/bash

#gbp  servicechain-node-create VPN --template-file VPN.yaml --service-profile smc_vpn
gbp  servicechain-node-create FW --template-file FW.yaml --service-profile smc_fw
gbp  servicechain-node-create LB --template-file LB.yaml --service-profile smc_lb

gbp servicechain-spec-create SCS --description spec --nodes "FW LB"

gbp network-service-policy-create --network-service-params type=ip_single,name=vip_ip,value=self_subnet vip

gbp policy-action-create redirect --action-type redirect --action-value SCS

gbp policy-classifier-create ALL --direction bi

gbp policy-rule-create ALL --classifier ALL --actions redirect

gbp policy-rule-set-create PRS --policy-rules ALL

gbp external-policy-create internet --consumed-policy-rule-sets PRS --external-segments internet-l3out
gbp ptg-create web
sleep 5

#gbp ptg-update web --provided-policy-rule-sets PRS
gbp ptg-update web --provided-policy-rule-sets PRS --network-service-policy vip

#Set up Floating IP address for Load Balancer
NetworkID=$(openstack network list | awk "/apic_owned_internet/ {print \$2}")
	LB_PORT_ID=$(gbp pt-list | awk "/vip/ {print \$9}")
		openstack floating ip create --port $LB_PORT_ID $NetworkID
