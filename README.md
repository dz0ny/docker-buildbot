# docker-buildbot

A nice and easy way to get a buildbot instance up and running using docker. For
help on getting started with docker see the [official getting started guide][0].
For more information on buildbot and check out it's [website][1].


## Building docker-buildbot

Running this will build you a docker image with the latest stable version of both
docker-buildbot and County itself.

    git clone https://github.com/dz0ny/docker-buildbot.git
    cd docker-buildbot
    sudo docker build -t dz0ny/buildbot .


## Running docker-buildbot

Running the first time will setup Mongodb to be in your data dir shared with your
host so that you can back it up if you want to. It will also set your port to
a static port of your choice so that you can easily map a proxy to it. If this
is the only thing running on your system you can map the port to 8010 and no
proxy is needed. i.e. `-p=80:8010` Also be sure your mounted directory on your
host machine is already created before running this `mkdir -p /mnt/buildbot`.

    sudo docker run  -d -p=10000:8010 -v=/mnt/buildbot:/data dz0ny/buildbot

From now on when you start/stop docker-buildbot you should use the container id
with the following commands. To get your container id, after you initial run
type `sudo docker ps` and it will show up on the left side followed by the image
name which is `dz0ny/buildbot:latest`.

    sudo docker start <container_id>
    sudo docker stop <container_id>

### Notes on the run command

 + `-v` is the volume you are mounting `-v=host_dir:docker_dir`
 + `dz0ny/buildbot` is simply what I called my docker build of this image
 + `-d=true` allows this to run cleanly as a daemon, remove for debugging
 + `-p` is the port it connects to, `-p=host_port:docker_port`

[0]: http://www.docker.io/gettingstarted/
[1]: http://docs.buildbot.net/current/tutorial/firstrun.html
