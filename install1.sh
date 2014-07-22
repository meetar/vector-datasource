#!bin/bash

#
# vector-datastore-vm
# Step 1
#

# test github ssh permissions
ssh -vT git@github.com
if [ $? != 1 ]; then
  echo "* ERROR: Github authentication failed!"
  echo "Please make sure your permissions are in order:"
  echo "https://help.github.com/articles/error-permission-denied-publickey"
  echo "Windows users: please make sure your ssh-agent is running:"
  echo "http://stackoverflow.com/a/19792331/738675"
  exit
fi


# install curl and pip
sudo apt-get update
sudo apt-get -y install curl
curl -O -L https://raw.github.com/pypa/pip/master/contrib/get-pip.py
sudo python get-pip.py


# install postgresql and postgis
sudo apt-get -y install python-software-properties
sudo add-apt-repository -y ppa:ubuntugis/ubuntugis-unstable

# add apt-get source to ensure latest postgres is installed, then install
echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" | sudo tee /etc/apt/sources.list.d/postgis.list
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update && sudo apt-get -y install libgdal1 postgresql-9.3 postgresql-9.3-postgis-2.1 postgresql-client-9.3

# add various requirements
sudo apt-get -y install protobuf-compiler libprotobuf-c0-dev protobuf-c-compiler
sudo aptitude -y install build-essential python-dev libprotobuf-dev libtokyocabinet-dev python-psycopg2 libgeos-c1

# install mapnik
sudo apt-get -y install python-software-properties
echo 'yes' | sudo add-apt-repository ppa:mapnik/v2.1.0
sudo apt-get update
# install core mapnik
sudo apt-get install -y libmapnik mapnik-utils python-mapnik
# install the python binding
sudo apt-get install -y python-mapnik


# create the db and user
sudo su -p - postgres -c "createuser osm -s -d"
sudo su -p - postgres -c "createdb -O osm osm"

# change permissions in postgres config file to allow local connections
sudo sed -i '/local   all             all                                     peer/c\local   all             all                                     trust' /etc/postgresql/9.3/main/pg_hba.conf
sudo sed -i '/host    all             all             127.0.0.1\/32            md5/c\host    all             all             127.0.0.1\/32            trust' /etc/postgresql/9.3/main/pg_hba.conf

sudo service postgresql restart


# install postgresql extensions
sudo apt-get -y install postgresql-contrib

sudo su -p - postgres -c 'psql -d osm -c "CREATE EXTENSION hstore;"'
sudo su -p - postgres -c 'psql -d osm -c "CREATE EXTENSION adminpack;"'
sudo su -p - postgres -c 'psql -d osm -c "CREATE EXTENSION postgis;"'


# install git and get the datasource
sudo apt-get -y install git-core


# If you are on Windows, you may need to start the ssh-agent service
# to enable ssh forwarding every time you start a new bash session,
# so the git ssh authentication will work
# http://stackoverflow.com/questions/3669001/getting-ssh-agent-to-work-with-git-run-from-windows-command-shell/15870387#15870387

# get the datasource
#git clone git@github.com:meetar/vector-datasource.git

# get and make osm2pgsql from source
git clone git://github.com/openstreetmap/osm2pgsql.git
cd osm2pgsql
sudo apt-get -y install -y dh-autoreconf libxml2-dev libbz2-dev libgeos-dev libproj-dev libpq-dev libgeos++-dev
./autogen.sh && ./configure && make
export PATH=$PATH:`pwd`

cd ~/vector-datasource


# get and load the new york extract into the db
curl -O https://s3.amazonaws.com/metro-extracts.mapzen.com/new-york.osm.pbf

osm2pgsql -d osm -U osm --slim --style osm2pgsql.style --hstore new-york.osm.pbf --cache-strategy sparse

# install more requirements
sudo pip install --allow-external PIL --allow-unverified PIL PIL modestmaps simplejson werkzeug
sudo pip install Shapely
sudo apt-get install -y unzip


# download the files in fileslist.txt and load them into the db
bash download.sh
bash shp2pgsql.sh | psql -U osm -d osm


# get, install, and start the TileStache server
cd ~
git clone git@github.com:TileStache/TileStache.git
cd TileStache
sudo python setup.py install
echo -e "\nStarting TileStache server -- next, open a new window in the vector-map-vm directory,\n 'vagrant ssh', 'cd /vagrant', and 'bash install2.sh'"
./scripts/tilestache-server.py -c tilestache.cfg -i 0.0.0.0

# End of step 1!
