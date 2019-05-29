# Garicshv_infra
Garicshv Infra repository

Задача: Исследовать способ подключения к someinternalhost в одну команду из вашего рабочего устройства, проверить работоспособность найденного решения и внести его в README.md в вашем репозитории
Решение: 
bastion_ip=35.189.214.30
someinternalhost_ip=10.132.0.5
ssh -J root@$bastion_ip root@$someinternalhost_ip

Задача: Предложить вариант решения для подключения из консоли при помощи команды вида ssh someinternalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу someinternalhost и внести его в README.md в вашем репозитории
Решение: 

1. Если соединение нужно выполнить командой вида
> ssh someinternalhost
то решение такое:
> bastion_ip=35.189.214.30
> someinternalhost_ip=10.132.0.5
> someinternalhost="-J root@$bastion_ip root@$someinternalhost_ip"
> ssh $someinternalhost 

2. если соединение нужно выполнить командой вида
> someinternalhost
то решение такое:
> echo "alias someinternalhost=\"ssh -J root@35.189.214.30 root@10.132.0.5\"" >> ~/.bashrc 
> source ~/.bashrc
> someinternalhost

