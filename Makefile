pattern ?= all
inventories ?= inventories
extra_args ?=

requirements:
	ansible-galaxy install --force-with-deps -r requirements.yml

ping:
	ansible -i "$(inventories)" -m ping "$(pattern)"

facts:
	ansible -i "$(inventories)" -m setup "$(pattern)"

delete-containers:
	ansible-playbook -i "$(inventories)" --limit="$(pattern)" delete-containers.yml --diff

lint:
	ansible-lint

prepare-for-ansible: playbook=prepare-for-ansible.yml
prepare-for-ansible: playbook


mikrotik: playbook=mikrotik.yml
mikrotik: playbook

proxmox: playbook=proxmox.yml
proxmox: playbook

site: playbook=site.yml
site: playbook

playbook:
	ansible-playbook -i "$(inventories)" --limit="$(pattern)" "$(playbook)" --diff $(extra_args)
