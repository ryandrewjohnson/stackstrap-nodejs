#
# Your StackStrap project specific states
#

include:
  - avahi
  - nvmnode
  - nginx

#mongodb:
#  pkg:
#    - installed

/etc/nginx/conf.d/node.conf:
  file:
    - managed
    - user: root
    - group: root
    - mode: 444
    - source: salt://nginx-node.conf
    - watch_in:
      - service: nginx

run_forever:
  cmd:
    - run
    - name: "/vagrant/node_modules/.bin/forever -l /tmp/forever.log -o /tmp/forever.out -e /tmp/forever.err -a -w --watchDirectory /vagrant/ start /vagrant/app.js"
    - user: vagrant
    - cwd: /vagrant
    - unless: "/vagrant/node_modules/.bin/forever list | grep /vagrant/app.js"
    - require:
      - cmd: install_node

## DISABLED AS FOREVER CANNOT BE STARTED UNTIL THE SHARED FOLDERS ARE MOUNTED
## INSTEAD RUN: vagrant up --provision
##
##run_forever_at_boot:
##file:
##- append
##- name: /etc/rc.local
##- text: 'sudo -u vagrant /bin/bash -c "source ~/.nvm/nvm.sh; cd /vagrant; /vagrant/node_modules/.bin/forever -l /tmp/forever.log -o /tmp/forever.out -e /tmp/forever.err -a -w --watchDirectory /vagrant/ start /vagrant/app.js"'

# vim: set ft=yaml et sw=2 ts=2 sts=2 :
