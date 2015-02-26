#!/usr/bin/env bash

# this is a chicken and egg script
# mostly to be used on a dev machine run via vagrant
# currently ubuntu flavored only

# this script requires that the build number be passed into the script
# at runtime as a parameter
# example:

# ./vagrant_bootstrap.sh 21

apt-get update
apt-get -y --quiet install git curl
git clone https://github.com/cloudsidekick/petclinic-chef.git /var/chef
mkdir -p /var/chef/tmp
chmod 755 -R /var/chef
curl https://www.opscode.com/chef/install.sh | /bin/bash
WAR="http://artifactory.cloudsidekick.com:8081/artifactory/ext-release-local/org/springframework/samples/spring-petclinic/$1/spring-petclinic-$1.war"

echo "{\"petclinic\": {\"war\": {\"url\": \"${WAR}\"}}, \"run_list\": [ \"recipe[petclinic::default]\" ]}" > /tmp/solo.json

chef-solo -j /tmp/solo.json -c /var/chef/solo.rb

# for some reason, the install doesn't complete until it is run again
# the second time around there should be no error

chef-solo -j /tmp/solo.json -c /var/chef/solo.rb
