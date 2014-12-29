#! /bin/bash
#####################################################################################################################################################
##### this simple script is used for automatically collecting log files when issue show up, hope could help you for the bug rephrting 
# History:
## original ver: v1.0
## author: xjin (xjin@suse.com)
## from: 2014-12-18
#####################################################################################################################################################


#####################################################################################################################################################
##### variables and options declaration
#####################################################################################################################################################
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
VDATE=`date +%y%m%d-%H.%M.%S`
VHOST=`hostname`
ACOMPO=["installer","firefox","yast2","printer","network","x11","thunderbird","pidgin","samba","nfs","evolution","libreoffice","gnome"]
ASCENA=["boot","update","upgrade","migration"]
nfsServer="147.2.207.135"

function printOption(){
echo -e "
usage: logcol -[options] (components|scenarios)  
options: 
\t -h: will print this options manual  

components: 
\t instaler: this will collect log when you would like to report bugs related with installer
\t firefox: this will collect log files related with firefox component 
\t yast2: this will collect both yast2 and zypper related log files 
\t printer: this will collect log files for printer issue 
\t network: this will collect log files for network issue
\t x11: this will collect log files related with graphical issue

scenaros: 
\t boot: this wil collect log files for debugging issue happens during boot

This script support to upload the collected log.tar.gz file to NFS server, during script running, will ask you select as YES or NO
"
}

#####################################################################################################################################################
##### specific components log file collection
##################################################################################################################################################### 
### functions declaration:
function gety2log(){
	if [ -f /var/log/YaST2/y2log ]; then
		cp /var/log/YaST2/y2log .
	elif [ -f /var/log/YaST2/y2log-1.gz ]; then
		cp /var/log/YaST2/y2log-1.gz .
	else
		echo "No valid y2log file exist."
	fi
}

function getzypplog(){
	if [ -f /var/log/zypper.log ]; then
		cp /var/log/zypper.log .
	else
		echo "No valid zypper.log file exist."
	fi

	if [ -d /var/log/zypp ]; then
		cp -a /var/log/zypp zypp
	fi
}

function tarLandFb(){
	echo `tar -zcvf ${VHOST}-log-${VDATE}.tar.gz *` has been collected.
	echo "Pls find in ${VHOST}-log-${VDATE}.tar.gz"
}

### components case
case $1	in 
"")
	echo -e "Input should not be empty, refer to the usage below:  \n"
	printOption && exit 0
	;;
"-h")
	printOption && exit 0
	;;
*)
	### make directory to store log files
	if [ -d logFileD ]; then
		rm -rf logFileD
		echo "Removed the old folder used for store log files!"
	fi
	mkdir logFileD; cd logFileD

	### function declaration
	function printInfo(){
		echo -e "$1: \n" > generalInfo.txt
		echo -n "$1, "
	}

	### general system and hardware info collection
	## cpuInfo
	printInfo CPUinfo
	cat /proc/cpuinfo |grep 'model name'|uniq -c >> generalInfo.txt
	## partitionInfo
	printInfo PartitionInfo
	fdisk -l /dev/sda >> generalInfo.txt
	## osInfo
	printInfo OSinfo
	cat /etc/YaST2/build >> generalInfo.txt
	## mountInfo
	printInfo MOUNTinfo
	mount >> generalInfo.txt
	## network
	printInfo NetCardinfo
	lspci -nnk |egrep 'Network|Ethernet' -n -A3 --color=auto >> generalInfo.txt
	hwinfo --netcard >> generalInfo.txt
	## VGA
	printInfo VGAinfo
	lspci -nnk |grep -n -A3 "VGA" >> generalInfo.txt
	##...
	##adding your session here
	##...

	echo -n " has been collected. 
	Pls refer generalInfo.txt under logFileD folder for details. 

	"
	case $1 in
	"installer" | "boot")
			cp /var/log/pbl.log .
		journalctl -b > journal.txt
		tarLandFb
		;;

	"firefox")
		echo -e "\n \t firefox related logs will be collected, you could refer to [http://fedoraproject.org/wiki/How_to_debug_Firefox_problems] \
		for a little deep debugging to make sure issue you met was a real problem:)"
		# about:support will be helpful for issue debuging
		# cp /var/log/
		tarLandFb
		;;

	"yast2")
		gety2log
		getzypplog
		journal -b > journal.txt
		tarLandFb
		;;

	"printer")
		if [ -d /var/log/cups ]; then
			cp -a /var/log/cups cups
		fi
		journalctl -b > journal.txt
		gety2log
		tarLandFb
		;;

	"network")
		ifconfig >ifconfigInfo.txt
		journalctl -u NetworkManager-dispatcher.service -u NetworkManager.service > network.txt
		tarLandFb
		;;
	"x11")
		# configuration info should be provided???
		tarLandFb
		;;
	*)
		echo "specific log file colletion for component $1 is not implementted, you could ask xjin for it"
		;;

	esac
esac

### remove temporary created log files directory
if [ -f ${VHOST}-log-${VDATE}.tar.gz ]; then
	mv ${VHOST}-log-${VDATE}.tar.gz ../.
	cd ..
	rm -rf logFileD
else
	exit 0
fi

#####################################################################################################################################################
##### send tar log file to remote server (nfs is using)
#####################################################################################################################################################
### check for the remote nfs server and upload log file
echo -e "\n"
read -p "Do you like to upload this log file to nfs server? [Y/N]" VUPLOAD
if [ "${VUPLOAD}" == "N" -o "${VUPLOAD}" == "n" ]; then
	exit 0
elif [ "${VUPLOAD}" == "Y" -o "${VUPLOAD}" == "y" ]; then
	echo "Pls wait, uploading..."
	mkdir ${VDATE}temp4log
	if [ `which showmount` ];then 
		mount ${nfsServer}:`showmount -e ${nfsServer}|grep Dir4log|cut -d ' ' -f1` ${VDATE}temp4log
		sleep 3
		cp ${VHOST}-log-${VDATE}.tar.gz ${VDATE}temp4log/.
		umount ${VDATE}temp4log
		echo "${VHOST}-log-${VDATE}.tar.gz has been upload to NFS server: ${nfsServer}:/share/nfs/Dir4log"
	else
		echo "Not sure if we have NFS server"
	fi
	
	rm -rf ${VDATE}temp4log
else
	echo "I don't know your input, will not upload log file to nfs server..."
fi
