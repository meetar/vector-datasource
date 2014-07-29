vector-datasource-vm
========================

This is a virtual machine (VM) for setting up an example vector-tile renderer (Tangram - https://github.com/bcamper/tangram) using one of Mapzen's Metro Extracts (https://mapzen.com/metro-extracts/).

See info about the hosted version of this service here:

[Mapzen Vector Tile Service](https://github.com/mapzen/vector-datasource/wiki/Mapzen-Vector-Tile-Service)


###vm setup

After cloning this repository and starting a terminal window inside the directory, the steps below will provision the VM. (You may need to confirm a ssh-authentication step.)

    # start the VM
    vagrant up
    vagrant ssh

    # navigate to the shared directory and run the first install script
    cd /vagrant
    bash install1.sh

    # open a new terminal window, ssh back into the vm, and run the second script
    vagrant ssh
    cd /vagrant
    bash install2.sh

Test the setup in a browser: <http://localhost:9000/#mapzen>

Note for Windows users: you may need to start the ssh-agent for each new bash session in order for git authentication to work. From outside the vm, run:

    eval `ssh-agent -s` 
    ssh-add ~/.ssh/*_rsa

See http://stackoverflow.com/a/19792331/738675

===

The instllation procedure installs these notable dependencies:

* [TileStache](http://tilestache.org)
* [PostGIS](http://postgis.net)
* An OpenStreetMap database created by [osm2pgsql](http://wiki.openstreetmap.org/wiki/Osm2pgsql)

And additionally, if desired:

* [Natural Earth](http://www.naturalearthdata.com) tables from contents of filelist.txt.
