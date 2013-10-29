FROM base

env   DEBIAN_FRONTEND noninteractive

# REPOS
run    apt-get install -y software-properties-common
run    add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
run    apt-get --yes update
run    apt-get --yes upgrade --force-yes

#SHIMS
run    dpkg-divert --local --rename --add /sbin/initctl
run    ln -s /bin/true /sbin/initctl

# TOOLS
run    apt-get install -y -q curl git wget

## County required
run    apt-get --yes install supervisor build-essential  --force-yes

## Setup Countly
run    mkdir -p /data/log
run    pip install buildbot
run    cd /data; buildbot create-master master
run    cd /data; mv master/master.cfg.sample master/master.cfg

run    pip install buildbot-slave
run    cd /data; buildslave create-slave slave localhost:9989 example-slave pass
run    cd /data; mv master/master.cfg.sample master/master.cfg

add    ./supervisor/supervisord.conf /etc/supervisor/supervisord.conf
add    ./supervisor/conf.d/buildbot.conf /etc/supervisor/conf.d/buildbot.conf

expose :8010
volume ["/data"]
ENTRYPOINT ["/usr/bin/supervisord"]