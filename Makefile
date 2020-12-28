ANSIBLE_VAULT_PASSWORD_FILE := ./.vault_pass
export ANSIBLE_VAULT_PASSWORD_FILE

site:
	ansible-playbook -i hosts site.yml --diff
