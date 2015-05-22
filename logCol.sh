#! /bin/bash
##### this simple script is used for automatically collecting log files when issue show up, hope could help you for the bug rephrting 
# History:
## original ver: v1.0
## author: xjin (xjin@suse.com)
## from: 2014-12-18


##### variables and options declaration
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
VDATE=`date +%y%m%d-%H.%M.%S`
VHOST=`hostname`
for x in `cat /etc/issue|egrep [[:digit:]]`
do
	echo -e "Current os version is ${x} \n" |egrep [[:digit:]] && VPRODUCT=${x} && break
done
VJOURNAL=`[ "${VPRODUCT}" == "12" -o "${VPRODUCT}" == "13.1" -o "${VPRODUCT}" == "13.2" ] && echo "1" || echo "0" `
nfsServer="147.2.207.135"

function printOption(){
echo -e "
usage: logcol -[options] (components|scenarios)  
options: 
\t -h: will print this options manual  

components: 
\t instaler: when you would like to report bugs related with installer
\t firefox: log files related with firefox component 
\t yast2:  both yast2 and zypper related log files 
\t printer: log files for printer issue 
\t network: log files for network issue
\t x11: log files related with graphical issue
\t sysInfo: collect system general information

scenaros: 
\t boot: this wil collect log files for debugging issue happens during boot

This script support to upload the collected log.tar.gz file to NFS server, during script running, will ask you select as YES or NO
"
}

##### specific components log file collection
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

function printInfo(){
	if [ -f generalInfo.txt ];then
		echo -e "\n $1: \n" >> generalInfo.txt
	else
		echo -e "\n $1: \n" > generalInfo.txt
	fi
	echo -n "$1, "
}

### components case
case $1	in 
"")
	echo -e "To gather log files, input should not be empty, refer to the usage below:  \n"
	printOption && exit 0
	;;
"-h")
	printOption && exit 0
	;;
*)
	### make directory to store log files
	if [ -d logFileD ]; then
		rm -rf logFileD
		echo -e "Removed the old folder used for store log files! \n"
	fi
	mkdir logFileD; cd logFileD

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
	## kernel version
	printInfo KernelVer
	uname -a >> generalInfo.txt
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
	## dmesg
	dmesg > dmesg.txt
	##...
	##adding your session here
	##...

	echo -n "could be found in generalInfo.txt." 
	echo -e "\n"

	case $1 in
	"installer" | "boot")
		cp /var/log/pbl.log .
		if [ $VJOURNAL == 1 ]; then
			journalctl -b > journal.txt
		fi
		tarLandFb
		;;

	"firefox")
		echo -e "\n \t firefox related logs will be collected, you could refer to [http://fedoraproject.org/wiki/How_to_debug_Firefox_problems] \
		for a little deep debugging to make sure issue you met was a real problem:)"
		# about:support will be helpful for issue debuging
		if [ -d ~/.mozilla ]; then
			cp -a ~/.mozilla/. .
		fi
		tarLandFb
		;;

	"yast2")
		gety2log
		getzypplog
		if [ $VJOURNAL == 1 ]; then
			journalctl -b > journal.txt
		fi
		tarLandFb
		;;

	"printer")
		if [ -d /var/log/cups ]; then
			cp -a /var/log/cups cups
		fi
		if [ $VJOURNAL == 1 ]; then
			journalctl -b > journal.txt
		fi
		gety2log
		tarLandFb
		;;

	"network")
		ifconfig >ifconfigInfo.txt
		if [ $VJOURNAL == 1 ]; then
			journalctl -u NetworkManager-dispatcher.service -u NetworkManager.service > network.txt
		fi
		tarLandFb
		;;
	"x11")
		if [ -f /etc/X11/xorg.conf ]; then
			cp /etc/X11/xorg.conf .
		else
#			echo -e "xorg.conf not existed, pls run 'Xorg -configure' in level 3 to create it."
#			echo -e "And move the created /root/xorg.conf.new to /etc/X11/xorg.conf. Then re-try."
#			exit 0
			Xorg :1 -configure > /dev/null 2>&1
			cp /root/xorg.conf.new xorg.conf
		fi
		tarLandFb
		;;
	"sysInfo")
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

##### send tar log file to remote server (nfs is using)
### check for the remote nfs server and upload log file
echo -e "\n"
read -p "Do you like to upload this log file to nfs server? [Y/N]" VUPLOAD
if [ "${VUPLOAD}" == "N" -o "${VUPLOAD}" == "n" ]; then
	exit 0
elif [ "${VUPLOAD}" == "Y" -o "${VUPLOAD}" == "y" ]; then
	echo "Pls wait, uploading..."
	mkdir ${VDATE}temp4log
	echo "temp dir is ${VDATE}temp4log"
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
