#!/bin/sh 
DEMO="JBoss Fuse Getting Started Home Loan Demo"
VERSION=6.2.0
AUTHORS="Christina Lin"
PROJECT="https://github.com/jbossdemocentral/jboss-fuse-homeloan.git"
FUSE=jboss-fuse-6.2.0.redhat-133
FUSE_BIN=jboss-fuse-full-6.2.0.redhat-133.zip
DEMO_HOME=./target
FUSE_HOME=$DEMO_HOME/$FUSE
FUSE_PROJECT=./project/homeloan
FUSE_SERVER_CONF=$FUSE_HOME/etc
FUSE_SERVER_BIN=$FUSE_HOME/bin
SRC_DIR=./installs
PRJ_DIR=./projects/homeloan
SUPPORT_DIR=./support


# wipe screen.
clear 

# add executeable in installs
chmod +x installs/*.zip


ASCII_WIDTH=57

printf "##  %-${ASCII_WIDTH}s  ##\n" | sed -e 's/ /#/g'
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n" "Setting up the ${DEMO}"
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n" "                #####  #   #  #####  #####"
printf "##  %-${ASCII_WIDTH}s  ##\n" "                #      #   #  #      #"
printf "##  %-${ASCII_WIDTH}s  ##\n" "                #####  #   #  #####  ####"
printf "##  %-${ASCII_WIDTH}s  ##\n" "                #      #   #      #  #"
printf "##  %-${ASCII_WIDTH}s  ##\n" "                #      #####  #####  #####"  
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n" "brought to you by,"
printf "##  %-${ASCII_WIDTH}s  ##\n" "${AUTHORS}"
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n"
printf "##  %-${ASCII_WIDTH}s  ##\n" | sed -e 's/ /#/g'


# double check for maven.
command -v mvn -q >/dev/null 2>&1 || { echo >&2 "Maven is required but not installed yet... aborting."; exit 1; }

# Check mvn version must be in 3.1.1 to 3.2.4	
verone=$(mvn -version | awk '/Apache Maven/{print $3}' | awk -F[=.] '{print $1}')
vertwo=$(mvn -version | awk '/Apache Maven/{print $3}' | awk -F[=.] '{print $2}')
verthree=$(mvn -version | awk '/Apache Maven/{print $3}' | awk -F[=.] '{print $3}')     
     
if [[ $verone -eq 3 ]] && [[ $vertwo -eq 1 ]] && [[ $verthree -ge 1 ]]; then
		echo  Correct Maven version $verone.$vertwo.$verthree
		echo
elif [[ $verone -eq 3 ]] && [[ $vertwo -eq 2 ]] && [[ $verthree -le 4 ]]; then
		echo  Correct Maven version $verone.$vertwo.$verthree
		echo
else
		echo Please make sure you have Maven 3.1.1 - 3.2.4 installed in order to use fabric maven plugin.
		echo
		echo We are unable to run with current installed maven version: $verone.$vertwo.$verthree
		echo	
		exit
fi


# make some checks first before proceeding.	
if [[ -r $SRC_DIR/$FUSE_BIN || -L $SRC_DIR/$FUSE_BIN ]]; then
		echo $DEMO FUSE is present...
		echo
else
		echo Need to download $FUSE_BIN package from the Customer Support Portal 
		echo and place it in the $SRC_DIR directory to proceed...
		echo
		exit
fi


# Create the target directory if it does not already exist.
if [ ! -x $DEMO_HOME ]; then
		echo "  - creating the demo home directory..."
		echo
		mkdir $DEMO_HOME
else
		echo "  - detected demo home directory, moving on..."
		echo
fi


# Move the old JBoss instance, if it exists, to the OLD position.
if [ -x $FUSE_HOME ]; then
		echo "  - existing JBoss FUSE detected..."
		echo
		echo "  - moving existing JBoss FUSE aside..."
		echo
		rm -rf $FUSE_HOME.OLD
		mv $FUSE_HOME $FUSE_HOME.OLD

		# Unzip the JBoss instance.
		echo Unpacking JBoss FUSE $VERSION
		echo
		unzip -q -d $DEMO_HOME $SRC_DIR/$FUSE_BIN
else
		# Unzip the JBoss instance.
		echo Unpacking new JBoss FUSE...
		echo
		unzip -q -d $DEMO_HOME $SRC_DIR/$FUSE_BIN
fi




#SETUP and INSTALL FUSE services
echo "  - enabling demo accounts logins in users.properties file..."
echo
cp $SUPPORT_DIR/fuse/users.properties $FUSE_SERVER_CONF

echo "  - enable camel counter in console in jmx.acl.whitelist.cfg  ..."
echo
cp $SUPPORT_DIR/fuse/jmx.acl.whitelist.cfg $FUSE_SERVER_CONF/auth/

echo "  - enable camel counter in console in jmx.acl.whitelist.properties  ..."
echo
cp $SUPPORT_DIR/fuse/jmx.acl.whitelist.properties $FUSE_HOME/fabric/import/fabric/profiles/default.profile/

 


echo "  - making sure 'FUSE' for server is executable..."
echo
chmod u+x $FUSE_HOME/bin/start


echo "  - Start up Fuse in the background"
echo
sh $FUSE_SERVER_BIN/start


echo "  - Create Fabric in Fuse"
echo
sh $FUSE_SERVER_BIN/client -r 3 -d 15 -u admin -p admin 'fabric:create'

sleep 15

COUNTER=10
#===Test if the fabric is ready=====================================
echo "  - Testing fabric,retry when not ready"
while true; do
    if [ $(sh $FUSE_SERVER_BIN/client 'fabric:status'| grep "100%" | wc -l ) -ge 3 ]; then
        break
    fi
    
    if [  $COUNTER -le 0 ]; then
    	echo ERROR, while creating Fabric, please check your Network settings.
    	break
    fi
    let COUNTER=COUNTER-1
    sleep 2
done
#===================================================================

echo "Go to Project directory"
echo      
cd $FUSE_PROJECT 

echo "Start compile and deploy failover camel example project to fuse"
echo         
mvn fabric8:deploy

#Going back to Fuse Project
cd ../..


echo "Add profile to container"
echo         
sh $FUSE_SERVER_BIN/client -r 2 -d 15 'container-create-child --profile homeloan-datareciever root datarecievercon'

echo "Add profile to container"
echo         
sh $FUSE_SERVER_BIN/client -r 2 -d 15 'container-create-child --profile homeloan-customerevaluation root custcon'

echo "Add profile to container"
echo         
sh $FUSE_SERVER_BIN/client -r 2 -d 15 'container-create-child --profile homeloan-houseappraisal root housecon'

echo "Add profile to container"
echo         
sh $FUSE_SERVER_BIN/client -r 2 -d 15 'container-create-child --profile homeloan-summarywebapi root summarycon'

echo "To stop the backgroud Fuse process, please go to bin and execute stop"
echo


ASCII_WIDTH=105

printf "=  %-${ASCII_WIDTH}s  =\n" | sed -e 's/ /#/g'
printf "=  %-${ASCII_WIDTH}s  =\n"
printf "=  %-${ASCII_WIDTH}s  =\n" " Starting the camel route in JBoss Fuse as follows:"
printf "=  %-${ASCII_WIDTH}s  =\n"
printf "=  %-${ASCII_WIDTH}s  =\n"
printf "=  %-${ASCII_WIDTH}s  =\n" "    - login to Fuse management console at:"
printf "=  %-${ASCII_WIDTH}s  =\n" 
printf "=  %-${ASCII_WIDTH}s  =\n" "        http://localhost:8181    (u:admin/p:admin)"
printf "=  %-${ASCII_WIDTH}s  =\n"
printf "=  %-${ASCII_WIDTH}s  =\n" "    - start home loan application, place the /support/data file to "
printf "=  %-${ASCII_WIDTH}s  =\n" "        target/jboss-fuse-6.2.0.redhat-133/instances/datarecievercon/datafile"
printf "=  %-${ASCII_WIDTH}s  =\n" "        - homeloancust.xml"
printf "=  %-${ASCII_WIDTH}s  =\n" "        - homeloancust-2.xml"
printf "=  %-${ASCII_WIDTH}s  =\n" "        - homeloanhouse.xml"
printf "=  %-${ASCII_WIDTH}s  =\n" "        - homeloanhouse-2.xml"
printf "=  %-${ASCII_WIDTH}s  =\n"
printf "=  %-${ASCII_WIDTH}s  =\n" "    - Take a look at through the Fuse Console"
printf "=  %-${ASCII_WIDTH}s  =\n" "        -Camel routes in all containers"
printf "=  %-${ASCII_WIDTH}s  =\n" "        -Message Queue stats"
printf "=  %-${ASCII_WIDTH}s  =\n" "        -Web Registry"
printf "=  %-${ASCII_WIDTH}s  =\n"
printf "=  %-${ASCII_WIDTH}s  =\n" "    - See the result of House Appraisal by accessing following URL"
printf "=  %-${ASCII_WIDTH}s  =\n"
printf "=  %-${ASCII_WIDTH}s  =\n"  "       http://localhost:8185/homeloan/summaryservice/nationalID/A234567"
printf "=  %-${ASCII_WIDTH}s  =\n"  "       http://localhost:8185/homeloan/summaryservice/nationalID/B56789"
printf "=  %-${ASCII_WIDTH}s  =\n"
printf "=  %-${ASCII_WIDTH}s  =\n" "    - once you are done, to stop and clean everything run"
printf "=  %-${ASCII_WIDTH}s  =\n" "        ./clean.sh"
printf "=  %-${ASCII_WIDTH}s  =\n"
printf "=  %-${ASCII_WIDTH}s  =\n" | sed -e 's/ /#/g'