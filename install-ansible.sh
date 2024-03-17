#!/bin/bash

# Проверяем наличие Python3
if ! command -v python3 >/dev/null 2>&1; then
    echo "Python3 is not installed. Please install Python3."
    exit 1
fi

# Проверяем доступность команды sudo без запроса пароля
if ! sudo -n true >/dev/null 2>&1; then
    echo "sudo requires password input. Please configure sudo without password prompt."
    exit 1
fi

# Проверяем, установлен ли Ansible
if ! command -v ansible &> /dev/null; then
    echo "Ansible is not installed. Installing..."

    # Обновляем список пакетов и добавляем PPA для Ansible
    apt update
    apt-get install -y software-properties-common
    apt-add-repository --yes --update ppa:ansible/ansible

    # Устанавливаем Ansible и дополнительные пакеты
    apt install -y ansible python3-argcomplete ansible-lint whois

    # Активируем глобальное дополнение аргументов для python3
    activate-global-python-argcomplete3

    # Проверяем успешность установки Ansible
    if [ $? -eq 0 ]; then
        echo "Ansible installed successfully."
    else
        echo "Failed to install Ansible."
        exit 1
    fi
else
    echo "Ansible is already installed."
fi

# Все проверки пройдены успешно
echo "All checks passed successfully"
exit 0
