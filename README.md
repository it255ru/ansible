# Сборка домашнего кластера k8s c помощью kubespray в Vmware PRO 16

План:
1. Установить гипервизор, скачать и настроить виртуальные машины, сбросить им hardware id и настроить при помощи ansible.
2. Установить kubespray и настроить его исходя из таблиц ниже.
3. Запустить kubespray и убедится, что нет failed job и кластер работает.
4. Потестировать клатсер разными ПО и способами раскати
5. Протестировать работу самописного оператора на кластере

|Role|FQDN|IP|OS|RAM|CPU|
|----|----|----|----|----|----|
|Infra|k8sinfra01.home.lab|192.168.2.51|Ubuntu 22|2G|2|
|Control plane nodes (Masters)|k8smaster01.home.lab|192.168.2.41|Ubuntu 22|2G|2|
|Control plane nodes (Masters)|k8smaster02.home.lab|192.168.2.42|Ubuntu 22|2G|2|
|Control plane nodes (Masters)|k8smaster03.home.lab|192.168.2.43|Ubuntu 22|2G|2|
|Worker node machines (Data plane)|k8sworker01.home.lab|192.168.2.44|Ubuntu 22|2G|2|
|Worker node machines (Data plane)|k8sworker02.home.lab|192.168.2.45|Ubuntu 22|2G|2|
|Ingress|k8singress01.home.lab|192.168.2.190|Ubuntu 20|2G|2|

|Username|Password|Description|
|----|----|----|
|root|root|Для доступа с повышенными правами|
|ubuntu|ubuntu|Для первой авторизации|
|ansible|ansible|Для запуска ansible|

### hardware specifications:

```bash
# Memory
free -h
               total        used        free      shared  buff/cache   available
Mem:           1.9Gi       281Mi       1.2Gi       1.0Mi       369Mi       1.5Gi
Swap:          2.0Gi          0B       2.0Gi

# Disk space
df -hT /
Filesystem                        Type  Size  Used Avail Use% Mounted on
/dev/mapper/ubuntu--vg-ubuntu--lv ext4   98G  8.3G   85G   9% /

# CPU Cores
$ egrep ^processor /proc/cpuinfo  | wc -l
2
```

### DNS Settings

A records for the hostnames in your DNS server and optionally on /etc/hosts file in each cluster node in case DNS resolution fails

```bash
; Create entries for the master nodes
k8smaster01		IN	A	192.168.2.41
k8smaster02		IN	A	192.168.2.42
k8smaster03		IN	A	192.168.2.43

; Create entries for the worker nodes
k8sworker01		IN	A	192.168.2.44
k8sworker02		IN	A	192.168.2.45

; Create entries for the Ingress nodes
k8singress01		IN	A	192.168.2.61

; Create entries for the Ingress nodes
k8sinfra01		IN	A	192.168.2.51

;
; The Kubernetes cluster ControlPlaneEndpoint point these to the IP of the masters
k8sendpoint	IN	A	192.168.2.41
k8sendpoint	IN	A	192.168.2.42
k8sendpoint	IN	A	192.168.2.43
```

### /etc/hosts

 > я придумал прикольный костыль: чтобы ping всегда находил ответ от k8sendpoint, надо както склеить keepalived.sh с узлами, которые обращаются к кластеру.

```
127.0.0.1 localhost
127.0.1.1 localhost

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

192.168.2.51 k8sinfra01

192.168.2.41 k8smaster01, k8sendpoint
192.168.2.42 k8smaster02, k8sendpoint
192.168.2.43 k8smaster03, k8sendpoint

192.168.2.44 k8sworker01
192.168.2.45 k8sworker02

192.168.2.61 k8singress01
```

---

## Описание стенда Windows + VmWare PRO 16
1. Windwos: 8vCPU (+ht) + 32 gb ram + ssd 500 GB 
2. Windwos: VmWare Workstation PRO 16
3. Windwos: Termius ssh client + ssh key
4. С Windows раскидываются ключи на все VM стенда гипервизора и добавляются в termius
5. termius синхронизируется с другими устройствами, VScode с подключением по ssh к хостам кластера, OpenLens для управления кластером
6. VM скачивается тут: https://www.linuxvmimages.com/images/ubuntuserver-2204/
7. В `c:\windows\system32\drivers\etc\hosts` добавить информацию из `windows-etc-hosts/hosts`

## Подготовка эталонной VM 
1. Создаем новую VM в VmWare и подкладываем .vmdk и .vmx из скаченного 7z архива на стенда Windows
2. Учетная запись `ubuntu:ubuntu` для первой авторизации
3. В `/etc/ssh/sshd_config` заменить на `yes` параметра `PasswordAuthentication`
4. `ip a` и запоминаем ip
5. `sudo reboot` и можно подключится теперь с Termius ssh client стенда на windows

### Продолжаем подготовку эталонной VM c стенда на windows
1. `ssh-copy-id ubuntu@k8sinfra01`
2. `ssh ubuntu@k8sinfra01` Пароль: `ubuntu`
3. `sudo -i` & `apt update -y` & `apt upgrade -y`
4. `mv /etc/machine-id /etc/machine-id.bak ` & `dbus-uuidgen --ensure=/etc/machine-id` & `reboot`
5. `apt install git` & `git clone %THIS_REPOSITORY%` & `cd %THIS_REPOSITORY%`
6. `sudo sh install-ansible.sh`
8. `ansible-playbook -i localhost getinfo.yml`
   
   
9. Редактируем `./inventory/all-hosts`.
10. 
11. `ansible-playbook -i inventory/all-hosts getinfo.yml`

Reset machine_id

## Настройка VM Infra с стенда на windows
1. На vm infra создается ssh-key и раскидывается новый ключ на 3 master + 2 worker
2. На vm infra ставится ansible, kubespray, kubectl

## Описание ролей
1. sshd_config
2. super_admin (seadmin:12345!!aa)
3. ansible_user
4. displayvars
5. install_utils

## Настройки предустановленные

1. Тестировалось на ОС Ubuntu 22 server
2. Учетная запись `ubuntu:ubuntu` предустановлена в vm
3. SSHD_CONFIG: порт 22, разрешена авторизая по паролю и ключам для root и ubuntu
4. IP {192.168.2.41-192.168.2.45} GW {192.168.2.1}
5. 

## Настройки которые требуется отредактировать
1. inventory/k8s-hosts.yml
2. inventory/all-hosts
3. playbook.yml

