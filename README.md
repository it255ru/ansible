# Ansible playbook to install software packages

This project contains [ansible](http://docs.ansible.com/ansible) playbook to download and install:
- One
- Two

### How to use

 - Install ansible on your computer `pip install ansible`, by default it installs in `/home/$USER/.local`.                                          
 - Clone this project
 - Edit the [`envs/hosts`](envs/hosts) file and enter the FQDN or IP address of the server you are deploying to.
 - Edit the [`roles/r/defaults/main.yml`](roles/r/defaults/main.yml) file and change the site-library and packages. Check [README.md](roles/r/README.md) for details.
 - Run the playbook for all vm :

      ```
      cd ansible
      ansible-playbook -i envs/ playbook.yaml -K -v
      ```
      
 - Run the playbook for group vm :

      ```
      d ansible
      ansible-playbook -i envs/ playbook.yaml --extra-vars "target=group_k8smaster" -K -v
      ```   

### Note: all the servers in `envs/hosts` should allow ssh auth using keypair
