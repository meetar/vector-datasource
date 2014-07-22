#!bin/bash

#
# vector-datastore-vm
# Step 1
#

git clone git@github.com:meetar/vector-map.git
cd vector-map
echo -e "\n Starting web server -- test it at http://localhost:9000/#mapzen-local"
python -m SimpleHTTPServer 9000
