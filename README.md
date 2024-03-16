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
1. `ssh-copy-id ubuntu@111.111.11.111`
2. `ssh ubuntu@111.111.11.111`
3. `sudo -i` & `apt update -y` & `apt upgrade -y` & `reboot`
4. `apt install git` & `git clone %THIS_REPOSITORY%` & `cd %THIS_REPOSITORY%`
5. Редактируем под себя `./inventory/k8s-hosts.yml` и `./playbook.yml`
6. `ansible-playbook -l 111.111.11.111 k8sinfra.yml`

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
1. Отредактировать inventory/k8s-hosts.yml
2. Отредактировать playbook.yml

# Запустите ваш Playbook с помощью команды ansible-playbook:

```bash
ansible-playbook -i inventory/k8s-hosts.yml playbook.yml
```