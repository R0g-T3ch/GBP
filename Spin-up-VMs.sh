clear
echo " "
echo -n "Type the number of VMs you want to spin up, followed by [ENTER]: "
read VMNUMBER

PT=1
while [ $PT -le $VMNUMBER ]
	do
		WEB_PORT=$(gbp policy-target-create $PT --policy-target-group web | awk "/port_id/ {print \$4}")
			openstack server create --flavor 2c.4m --key-name US-West_KP --image "Ubuntu-Xenial" --nic port-id=$WEB_PORT --user-data UD.sh VM$PT
	PT=$(( $PT + 1 ))
done

#Set up Floating IP address for VM1
NetworkID=$(openstack network list | awk "/apic_owned_internet/ {print \$2}")
	DEMOLin1IP=$(openstack floating ip create $NetworkID | awk "/floating_ip_address/ {print \$4}")
		openstack server add floating ip VM1 $DEMOLin1IP
		