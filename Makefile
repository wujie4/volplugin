CEPH_ANSIBLE_DIR=${PWD}/vendor/ceph-ansible

start: install-ansible
	vagrant up

stop:
	vagrant destroy -f

restart: stop start

provision:
	vagrant provision

ssh:
	vagrant ssh mon0

build:
	godep go install -v ./

install-ansible:
	[[ -n `which ansible` ]] || sudo pip install ansible

test: 
	vagrant ssh mon0 -c 'sudo -i sh -c "cd /opt/golang/src/github.com/contiv/volplugin; godep go test -v ./..."'

volplugin:
	vagrant ssh mon0 -c 'sudo -i sh -c "cd /opt/golang/src/github.com/contiv/volplugin; make volplugin-start"'

volplugin-start:
	pkill volplugin || exit 0
	godep go install -v .
	volplugin rbd 10