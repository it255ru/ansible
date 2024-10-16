# Ansible playbook to install software packages

This project contains [ansible](http://docs.ansible.com/ansible) playbook to install and some check:
- net-tools
- display all variables/facts known for a host

### How to use

 - Install ansible on your computer `pip install ansible`, by default it installs in `/home/$USER/.local`.                                          
 - Clone this project
 - Edit the [`envs/hosts`](envs/hosts) file and enter the FQDN or IP address of the server you are deploying to.
      
 - Run the playbook for group vm :

      ```
      cd ansible
      ansible-playbook -i envs/ playbook.yaml --extra-vars "target=group_k8smaster" -K -v
      ```   

### Note: all the servers in `envs/hosts` should allow ssh auth using keypair
