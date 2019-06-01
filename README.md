# Garicshv_infra
Garicshv Infra repository

**Задача: Исследовать способ подключения к someinternalhost в одну команду из вашего рабочего устройства, проверить работоспособность найденного решения и внести его в README.md в вашем репозитории**
Решение: 
```bash
bastion_IP=35.189.214.30
someinternalhost_IP=10.132.0.5
ssh -J root@$bastion_IP root@$someinternalhost_IP
```
**Задача: Предложить вариант решения для подключения из консоли при помощи команды вида ssh someinternalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу someinternalhost и внести его в README.md в вашем репозитории**
Решение: 

1. Если соединение нужно выполнить командой вида
```bash
ssh someinternalhost
```
то решение такое:
```bash
bastion_IP=35.189.214.30
someinternalhost_IP=10.132.0.5
someinternalhost="-J root@$bastion_IP root@$someinternalhost_IP"
ssh $someinternalhost 
```
2. если соединение нужно выполнить командой вида
```bash
someinternalhost
```
то решение такое через .bashrc:
```bash
echo "alias someinternalhost=\"ssh -J root@35.189.214.30 root@10.132.0.5\"" >> ~/.bashrc 
source ~/.bashrc
someinternalhost
```
3. Если соединение нужно установить командой вида
```bash
ssh someinternalhost
```
то решение следующее:
в файл ~/.ssh/config добавляем следующие блоки
```bash
Host someinternalhost
HostName 10.132.0.5
User root
ProxyCommand ssh -A root@bastion nc %h %p

Host bastion
HostName 35.189.214.30
User root
```

** ДЗ №4**
testapp_IP = 35.193.66.7
testapp_port = 9292
**Задача:**
1. Устанавливаем Google Cloud SDK
2. Создаем новый инстанс
Решение:
1. Создается скриптом installGoogleSDK.sh
2. Создается скриптом setupVM.sh

**Задача:**
Команды по настройке системы и деплоя приложения нужно завернуть в баш скрипты, чтобы не вбивать эти команды вручную:
1. Скрипт install_ruby.sh должен содержать команды по установке Ruby;
2. Скрипт install_mongodb.sh должен содержать команды по установке MongoDB;
3. Скрипт deploy.sh должен содержать команды скачивания кода, установки зависимостей через bundler и запуск приложения.
Решение:
1. создал скрипт install_ruby.sh
2. создал скрипт install_mongodb.sh
3. создал скрипт deploy.sh
Проверить можно: http://35.193.66.7:9292/

**Задача:**
В качестве доп. задания используйте созданные ранее скрипты для создания , который будет запускаться при создании инстанса. Передавать startup скрипт необходимо как дополнительную опцию уже использованной ранее команде gcloud
Решение:
Создал скрипт startup_script.sh, который запускается автоматически после запуска инстанса. В скрипт setupVMwithStartupScript.sh создания инстанса была добавлена команда: 
```bash
--metadata-from-file=startup-script=/home/kvaga/otus/devops/Garicshv_infra/startup_script.sh
```

**Задача:**
1. Удалите созданное через веб интерфейс правило для работы приложения default-puma-server.
2. Создайте аналогичное правило из консоли с помощью gcloud.
Решение:
1. удалил
2. создал в скрипте apply_firewall_rule.sh:
```bash
sudo gcloud compute firewall-rules create new-rule --allow tcp:22,tcp:9292
```
Проверить можно по адресу: http://35.192.140.152:9292/
