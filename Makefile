ANSIBLE_VAULT_PASSWORD_FILE := ./.vault_pass
export ANSIBLE_VAULT_PASSWORD_FILE

ping:
	ansible-playbook -i hosts ping.yml --diff
site:
	ansible-playbook -i hosts site.yml --diff
