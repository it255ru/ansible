# Сборка домашнего кластера k8s c помощью kubespray в VmWare PRO 16
===================================================================

# Описание стенда на windows
1. Windwos: 8vCPU (+ht) + 32 gb ram + ssd 500 GB 
2. Windwos: VmWare Workstation PRO 16
3. Windwos: Termius ssh client + ssh key
4. С Windows раскидываются ключи на все VM стенда гипервизора и добавляются в termius
5. termius синхронизируется с другими устройствами
6. VScode
7. OpenLens

# Описание стенда гипервизора
1. VM скачивается тут: https://www.linuxvmimages.com/images/ubuntuserver-2204/
2. VMs (ubuntu22/2vcpu/2ram/50hdd): 1 infra + 3 masters + 2 workers
3. Сначало подготавливается эталонная VM, затем клонируется 5 раз для master b worker

# Подготовка эталонной VM 
1. Создаем новую VM в VmWare и подкладываем .vmdk и .vmx из скаченного 7z архива на 500 gb ssd стенда Windows
2. Учетная запись `ubuntu:ubuntu` 
3. В `/etc/ssh/sshd_config` заменить на `yes` параметр `PasswordAuthentication`
4. `ip a` запоминаем ip
5. `sudo reboot` и можно подключится теперь с Termius ssh client стенда на windows

## Подготовка эталонной VM c стенда на windows
1. В `c:\windows\system32\drivers\etc\hosts` добавить информацию из `windows-etc-hosts/hosts`
2. `ssh-copy-id ubuntu@k8sinfra01`
3. `ssh ubuntu@k8sinfra01` Пароль: `ubuntu`
4. `sudo -i` & `apt update -y` & `apt upgrade -y`
5. `mv /etc/machine-id /etc/machine-id.bak ` & `dbus-uuidgen --ensure=/etc/machine-id` & `reboot`
6. `apt install git` & `git clone %THIS_REPOSITORY%` & `cd %THIS_REPOSITORY%`
7. `sudo sh install-ansible.sh`
8. `ansible-playbook -i localhost getinfo.yml`
   

   
6. Редактируем `./inventory/all-hosts`.
7. 
8.  `ansible-playbook -i inventory/all-hosts getinfo.yml`

Reset machine_id

# Настройка VM Infra с стенда на windows
1. На vm infra создается ssh-key и раскидывается новый ключ на 3 master + 2 worker
2. На vm infra ставится ansible, kubespray, kubectl

# Описание ролей
1. sshd_config
2. super_admin (seadmin:12345!!aa)
3. ansible_user
4. displayvars
5. install_utils


# Настройки предустановленные

1. Тестировалось на ОС Ubuntu 22 server
2. Учетная запись `ubuntu:ubuntu` предустановлена в vm
3. SSHD_CONFIG: порт 22, разрешена авторизая по паролю и ключам для root и ubuntu
4. IP {192.168.2.41-192.168.2.45} GW {192.168.2.1}
5. 

# Настройки которые требуется отредактировать
1. inventory/k8s-hosts.yml
2. inventory/all-hosts
3. playbook.yml

