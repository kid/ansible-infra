pattern ?= all
inventories ?= inventories/

requirements:
	ansible-galaxy install --force-with-deps -r requirements.yml

ping:
	ansible -i "$(inventories)" -m ping "$(pattern)"

facts:
	ansible -i "$(inventories)" -m setup "$(pattern)"

site:
	ansible-playbook -i "$(inventories)" site.yml --diff

mikrotik:
	ansible-playbook -i "$(inventories)" mikrotik.yml --diff

delete-containers:
	ansible-playbook -i "$(inventories)" delete-containers.yml --diff

lint:
	ansible-lint
