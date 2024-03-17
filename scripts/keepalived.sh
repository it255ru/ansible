#!/bin/bash

# Запускать на всех нодах желающих получить доступ к кластеру: # bash keepalived.sh

# Список IP адресов и соответствующих имён хостов
addresses=(192.168.2.41 192.168.2.42 192.168.2.43)
hostnames=(k8smaster01 k8smaster02 k8smaster03)

# Перебираем каждый адрес
for ((i=0; i<${#addresses[@]}; i++)); do
    address=${addresses[i]}
    hostname=${hostnames[i]}

    # Проверяем доступность узла
    ping -c 1 "$address" >/dev/null 2>&1
    ping_exit_code=$?

    # Если ping завершился успешно (exit code 0), обновляем /etc/hosts
    if [ $ping_exit_code -eq 0 ]; then
        sed -i "s/$address $hostname\(, k8sendpoint\)\?/$address $hostname, k8sendpoint/" /etc/hosts

    # Если ping завершился с ошибкой, удаляем ", k8sendpoint" из /etc/hosts (если оно там есть)
    else
        sed -i "s/$address $hostname, k8sendpoint/$address $hostname/" /etc/hosts
    fi
done
