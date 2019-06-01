# Garicshv_infra
Garicshv Infra repository

Задача: Исследовать способ подключения к someinternalhost в одну команду из вашего рабочего устройства, проверить работоспособность найденного решения и внести его в README.md в вашем репозитории
Решение: 
bastion_IP=35.189.214.30
someinternalhost_IP=10.132.0.5
ssh -J root@$bastion_IP root@$someinternalhost_IP

Задача: Предложить вариант решения для подключения из консоли при помощи команды вида ssh someinternalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу someinternalhost и внести его в README.md в вашем репозитории
Решение: 

1. Если соединение нужно выполнить командой вида
> ssh someinternalhost
то решение такое:
bastion_IP=35.189.214.30
someinternalhost_IP=10.132.0.5
someinternalhost="-J root@$bastion_IP root@$someinternalhost_IP"
ssh $someinternalhost 

2. если соединение нужно выполнить командой вида
someinternalhost
то решение такое через .bashrc:
echo "alias someinternalhost=\"ssh -J root@35.189.214.30 root@10.132.0.5\"" >> ~/.bashrc 
source ~/.bashrc
someinternalhost

3. Если соединение нужно установить командой вида
ssh someinternalhost
то решение следующее:
в файл ~/.ssh/config добавляем следующие блоки

Host someinternalhost
HostName 10.132.0.5
User root
ProxyCommand ssh -A root@bastion nc %h %p

Host bastion
HostName 35.189.214.30
User root

