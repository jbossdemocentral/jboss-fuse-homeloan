JBoss Fuse Home Loan Demo
===========================================================
For people that are getting started to know Fuse, and wants to get their hands dirty and develop a JBoss Fuse project for the first time.

The story behind the home loan demo is we have a system, that takes in XML files from different vendor's home loan application into a folder, and we will need to process the data give house an appraised value and then provide the information back to the vendors. 

System requirements
-----------------------
Before building and running this quick start you need:

Maven 3.1.1 - 3.2.4 included
JDK 1.6 or 1.7
JBoss Fuse 6.2

Install on your machine
-----------------------
1. Download this project and unzip OR git clone this onto your desktop.

2. Add products to installs directory.

3. Run 'init.sh'

4. Although our shell script has already started the FUSE server, if you need to manually start the server in the future, just run `./target/jboss-fuse-6.2.0.redhat-133/bin/start`

5. Login to Fuse management console at:  http://localhost:8181    (u:admin/p:admin).

6. Under Containers tab, you will see 5 containers, select and start them all.  

7. Enjoy the demo!

Demo Scenario
-----------------------
1. The demo should have been already started by executing 'init.sh'
2. Login to Fuse management console at http://localhost:8181 (u:admin/p:admin)
3. Start home loan application, place the /support/data file to target/jboss-fuse-6.2.0.redhat-133/instances/datarecievercon/datafile
  1. homeloancust.xml
  2. homeloancust-2.xml
  3. homeloanhouse.xml
  4. homeloanhouse-2.xml
4. Take a look at through the Fuse Console
  1. Camel routes in all containers
  2. Message Queue stats
  3. Web Registry
5. See the result of House Appraisal by accessing following URL
  1. http://localhost:8185/homeloan/summaryservice/nationalID/A234567
  2. http://localhost:8185/homeloan/summaryservice/nationalID/B56789
6. once you are done, to stop and clean everything run './clean.sh'

Shutdown the demo
-----------------------
1. To stop the JBoss FUSE Server and all the containers, run
  1. `./target/jboss-fuse-6.2.0.redhat-133/bin/admin stop homeloan`
  2. `./target/jboss-fuse-6.2.0.redhat-133/bin/admin stop summarycon`
  3. `./target/jboss-fuse-6.2.0.redhat-133/bin/admin stop custcon`
  4. `./target/jboss-fuse-6.2.0.redhat-133/bin/admin stop datarecievercon`
  5. `./target/jboss-fuse-6.2.0.redhat-133/bin/admin stop housecon`
  6. `./target/jboss-fuse-6.2.0.redhat-133/bin/admin stop root`
