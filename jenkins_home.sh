#!/bin/bash
if [ -f $JENKINS_HOME/.jenkins_home_created ]; then
    echo "Jenkins home already created"
    exit 0
fi
 
#generate password
echo "========================================================================"

echo "=> Init home"

tar -xzf /usr/share/jenkins/jenkins_home.tar.gz --strip-components 1 -C $JENKINS_HOME

rm -rf /usr/share/jenkins/jenkins_home.tar.gz

touch $JENKINS_HOME/.jenkins_home_created

echo "=> Init home done!"

echo "========================================================================"


