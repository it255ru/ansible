# Checklist

## INternal: DNS | DHCP | GATEWAY
- [x] DHCP 192.168.2.0/24
- [x] Gateway: 192.168.2.1
- [x] DNS(Nameservice): 192.168.2.1
- [x] DNS-resolv: home.lab

## Wndows | Vmware | Dev-tools
- [x] OS: Windows 10
- [x] Подготовил inventory.ini (all ip, hostname & roles for kubespray)
- [ ] Vmware workstation 16 pro
  - [x] Создал 1 Infra vm
  - [x] Создал 3 Master vm
  - [x] Создал 2 Worker vm
  - [x] Создал 1 Ingress vm
- [x] Изменен etc/hosts
- [x] Создал ssh-ключ
  - [x] Распостранил на Infra vm
  - [x] Распостранил на Master vm
  - [x] Распостранил на Worker vm
  - [x] Распостранил на Ingress vm
- [ ] Termius
  - [x] Подключил Infra vm
  - [x] Подключил Master vm
  - [x] Подключил Worker vm
  - [ ] Подключил Ingress vm
- [ ] VScode
  - [x] Подключил Github
  - [ ] Подключил Infra vm
- [x] Персональные настройки
  - [x] Notion (intener notepad)
  - [x] Firefox (sync accounts)
  - [x] Edge (Copilot) + ChatGPT + VLESS vpn

## Infra vm
- [ ] Стандартные настройки
  - [x] Изменил hostname
  - [x] Изменил настройки сети на статику
  - [x] Проверил доступ в интернет
  - [x] Обновил ОС
  - [x] Создал новый hardware id
  - [x] Изменил настройки sshd.service
  - [ ] Создал УЗ ansible
  - [ ] Отключил авторизацию root
  - [x] Установил admin tools (wget, curl, vim, net-tools)
  - [x] Установил ansible tools (python3 , pip3, git)
  - [x] Отключил selinux
  - [x] Отключил ufw
  - [x] Создал ssh-ключ
    - [x] Распостранил на Master vm
    - [x] Распостранил на Worker vm
    - [x] Распостранил на Ingress vm
- [ ] Персональные настройки
  - [x] .gitconfig для github
  - [ ] База KeePass для паролей, ключей и tls-сертефикатов
- [ ] DevOps настройки
  - [ ] Настроил .kube для k8s
  - [ ] Установил kubernetes tools (kubectl, helm)
  - [ ] Установил Docker, Docker-compose
- [ ] DevOps инструменты
  - [ ] Sonatype Nexus (java 11)
    - [ ] DEB репозиторий
    - [ ] Docker registry
  - [ ] Jenkins (java 11)
  - [ ] GitLab
  - [ ] Hashicorp Vault
  - [ ] Prometheus
  - [ ] Grafana
  - [ ] Alert Manager
  

## Master vm
- [ ] Стандартные настройки
  - [x] Изменил hostname
  - [x] Изменил настройки сети на статику
  - [x] Проверил доступ в интернет
  - [x] Обновил ОС
  - [x] Создал новый hardware id
  - [x] Изменил настройки sshd.service
  - [ ] Создал УЗ ansible
  - [ ] Отключил авторизацию root
  - [ ] Установил master-tools
  - [ ] Удалил swap
  - [ ] Отключил selinux
  - [ ] Отключил ufw
  - [ ] Внес изменения в сетевые настройки
  - [ ] Внес изменения в работу ядра
  - [ ] 

## Worker vm
- [ ] Стандартные настройки
  - [x] Изменил hostname
  - [x] Изменил настройки сети на статику
  - [x] Проверил доступ в интернет
  - [x] Обновил ОС
  - [x] Создал новый hardware id
  - [x] Изменил настройки sshd.service
  - [ ] Создал УЗ ansible
  - [ ] Отключил авторизацию root
  - [ ] Установил master-tools
  - [ ] Удалил swap
  - [ ] Отключил selinux
  - [ ] Отключил ufw
  - [ ] Внес изменения в сетевые настройки
  - [ ] Внес изменения в работу ядра
  - [ ] 

## Ingress vm
- [ ] Стандартные настройки
  - [x] Изменил hostname
  - [x] Изменил настройки сети на статику
  - [x] Проверил доступ в интернет
  - [x] Обновил ОС
  - [x] Создал новый hardware id
  - [x] Изменил настройки sshd.service
  - [ ] Создал УЗ ansible
  - [x] Отключил авторизацию root
  - [ ] Установил master-tools
  - [ ] Удалил swap
  - [ ] Отключил selinux
  - [ ] Отключил ufw
  - [ ] Внес изменения в сетевые настройки
  - [ ] Внес изменения в работу ядра
  - [ ] 
