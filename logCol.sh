#! /bin/bash

#####################################################################################################################################################
###### this simple script is used for automatically collecting log files when issue show up, hope could help you during the bug reporting 
#  History:
## original ver: v1.0
## author: xjin (xjin@suse.com)
## from: 2014-12-18
#####################################################################################################################################################


#####################################################################################################################################################
##### variables and options declaration
#####################################################################################################################################################
export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
VDATE=`date +%y%m%d-%H.%M.%S`

function printOption(){
echo -e "
usage: logcol -[options] (components)  
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
\t boot: this wil collect log files for debugging issue happens during boot\n"
}

#####################################################################################################################################################
##### input check:
#####################################################################################################################################################
if [ "$1" == "" ]; then
	echo -e "Input should not be empty, refer to the usage below:  \n"
	printOption && exit 0
elif [ "$1" == "-h" ]; then
	printOption && exit 0
else
	if [ "$1" == "installer" ]||[ "$1" == "firefox" ]||[ "$1" == "yast2" ]||[ "$1" == "printer" ]||[ "$1" == "network" ]||[ "$1" == "boot" ]||[ "$1" == "x11" ]; then
		echo -e "Begin to collect log files, pls wait..."
	else
		echo -e "Pls check your input, now the supported components or scenarios pls find below: \n"
		printOption && exit 0
	fi
fi

#####################################################################################################################################################
##### general system and hardware info collectiong
#####################################################################################################################################################
### make directory to store log files
if [ -d logFileD ]; then
	rm -rf logFileD
	echo "Removed the exist folder for log files!"
fi
mkdir logFileD; cd logFileD

### cpuInfo
echo -e "CPU info: \n" > generalInfo.txt
cat /proc/cpuinfo |grep 'model name'|uniq -c >> generalInfo.txt
echo -n "cpuInfo, "
### partitionInfo
echo -e "\nPartition Table info:\n" >> generalInfo.txt
fdisk -l /dev/sda >> generalInfo.txt
echo -n "partitionInfo, "
### osInfo
echo -e "\nOS info:\n" >> generalInfo.txt
cat /etc/YaST2/build >> generalInfo.txt
echo -n "osInfo, "
### mountInfo
echo -e "\nMount point info:\n" >> generalInfo.txt
mount >> generalInfo.txt
echo -n "mountInfo, "
### network
echo -e "\nNetcard info:\n" >> generalInfo.txt
lspci -nnk |egrep 'Network|Ethernet' -n -A3 --color=auto >> generalInfo.txt
hwinfo --netcard >> generalInfo.txt
echo -n "netcardInfo, "
### VGA
echo -e "\nVGA info: \n" >> generalInfo.txt
lspci -nnk |grep -n -A3 "VGA" >> generalInfo.txt
echo -n "and VGAinfo has been collected. 
Pls refer generalInfo.txt file for details. 

"
#####################################################################################################################################################
##### dealing with the specific components log file
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

### components case
case $1	in 
"installer")
	cp /var/log/pbl.log .
	journalctl -b > journal.txt
	echo `tar -zcvf log-${VDATE}.tar.gz *` has been collected.
	;;

"firefox")
	echo -e "\n \t firefox related logs will be collected, you could refer to [http://fedoraproject.org/wiki/How_to_debug_Firefox_problems] for a little deep debugging to make sure issue you met was a real problem:)"
	# about:support will be helpful for issue debuging
	# cp /var/log/
	echo `tar -zcvf log-${VDATE}.tar.gz *` has been collected.
	;;

"yast2")
	gety2log
	getzypplog
	journal -b > journal.txt
	echo `tar -zcvf log-${VDATE}.tar.gz *` has been collected.
	;;

"printer")
	if [ -d /var/log/cups ]; then
		cp -a /var/log/cups cups
	fi
	journalctl -b > journal.txt
	gety2log
	echo `tar -zcvf log-${VDATE}.tar.gz *` has been collected.
	;;

"network")
	ifconfig >ifconfigInfo.txt
	journalctl -u NetworkManager-dispatcher.service -u NetworkManager.service > network.txt
	echo `tar -zcvf log-${VDATE}.tar.gz *` has been collected.
	;;
"x11")
	# configuration info should be provided???
	echo `tar -zcvf log-${VDATE}.tar.gz *` has been collected	
	;;
esac

#####################################################################################################################################################
##### remove created log files and send tar log to remote server
#####################################################################################################################################################
### rm all log files
if [ -f log-${VDATE}.tar.gz ]; then
	mv log-${VDATE}.tar.gz ../.
	cd ..
	rm -rf logFileD
	echo "Temporary log files has been deleted"
else
	echo "Seems there is issue to create the log tar file"
fi
### send tar log file to remote/ nfs server

