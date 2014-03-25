#!/bin/sh

# Directory in which librarian-puppet should manage its modules directory
PUPPET_DIR='/vagrant/puppet'

if [ -n "$(type yum 2>/dev/null)" ];then
    echo "Installing puppet, git, and updating through yum"
    sudo yum clean all -q
    sudo yum -q -y update
    sudo yum -q -y install git-core puppet
elif [ -n "$(type apt-get 2>/dev/null)" ];then
    echo "Installing puppet, git, and updating through apt-get"
    sudo apt-get -q -y update
    sudo apt-get -q -y upgrade
    sudo apt-get -q -y install git-core puppet
    sudo apt-get -q -y clean all
else
    echo "No package installer available. You may need to install git manually."
fi

if [ `gem query --local | grep librarian-puppet | wc -l` -eq 0 ]; then
  gem install librarian-puppet
  cd $PUPPET_DIR && librarian-puppet install --clean
else
  cd $PUPPET_DIR && librarian-puppet update
fi

# now we run puppet
sudo puppet apply -vv  --modulepath=$PUPPET_DIR/modules/ $PUPPET_DIR/manifests/main.pp
