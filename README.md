# Ansible playbook to install software packages
==============================================


This project contains [ansible](http://docs.ansible.com/ansible) playbook to download and install:
- One
- Two

### How to use

 - Install ansible on your computer                                                                       
 - Clone this project
 - Edit the [`envs/hosts`](envs/hosts) file and enter the FQDN or IP address of the server you are deploying to.
 - Edit the [`roles/r/defaults/main.yml`](roles/r/defaults/main.yml) file and change the site-library and packages. Check [README.md](roles/r/README.md) for details.
 - Run the playbook :

      ```
      cd ansible
      ansible-playbook -i envs/ playbook.yml --user=$USER --ask-become-pass

      ```

### Note: all the servers in `envs/hosts` should allow ssh auth using keypair
