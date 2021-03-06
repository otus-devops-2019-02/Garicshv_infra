# Garicshv_infra
Garicshv Infra repository

**ВЫПОЛНЕНО ДЗ №3**  

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

**ВЫПОЛНЕНО ДЗ №4**  
```bash
testapp_IP = 35.193.66.7
testapp_port = 9292
```
**Задача:**
1. Устанавливаем Google Cloud SDK
2. Создаем новый инстанс  
Решение:  
- Создается скриптом installGoogleSDK.sh
- Создается скриптом setupVM.sh

**Задача:**
Команды по настройке системы и деплоя приложения нужно завернуть в баш скрипты, чтобы не вбивать эти команды вручную:
- Скрипт install_ruby.sh должен содержать команды по установке Ruby;
- Скрипт install_mongodb.sh должен содержать команды по установке MongoDB;
- Скрипт deploy.sh должен содержать команды скачивания кода, установки зависимостей через bundler и запуск приложения.  
Решение:  
- создал скрипт install_ruby.sh
- создал скрипт install_mongodb.sh
- создал скрипт deploy.sh
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
- удалил
- создал в скрипте apply_firewall_rule.sh:   
```bash
sudo gcloud compute firewall-rules create new-rule --allow tcp:22,tcp:9292
```
Проверить можно по адресу: http://35.192.140.152:9292/

**ВЫПОЛНЕНО ДЗ №5**  
Созданы скрипты install_mongodb.sh и install_ruby.sh для установки mongodb и ruby соответственно.  
Создан packer скрипт ubuntu16.json для создания базового образа VM. Из него вручную создан инстанс VM с именем reddit-app2 и развернуто приложение puma. Проверить работоспособность инстанса можно по адресу http://35.193.66.7:9292/  
**Задача:**    
1. Необходимо параметризировать созданный шаблон, используя
пользовательские переменные (см. лекцию и документацию).
Должны быть параметризированы:  
• ID проекта (обязательно)  
• source_image_family (обязательно)  
• machine_type     
Решение:  
Выполнено в файле ubuntu16.json за счет блока кода
```bash
"variables": {
            "project_id": "",
            "source_image_family": "",
            "machine_type": "f1-micro"
    },
```
**Задача:**  
2. Пользовательские переменные определяются в самом шаблоне, в файле variables.json задаются обязательные переменные, либо переопределяются  
Решение:  
Создан файл variables.json  
**Задача:**  
3. Исследовать другие опции builder для GCP (ссылка). Какие опции точно хотелось бы увидеть:
• Описание образа
• Размер и тип диска
• Название сети
• Теги  
Файл с переменными variables.json, нужно внести в .gitignore, а в репозиторий добавить файл variables.json.example с примером заполнения, используя вымышленные значения, т.к. ваш репозиторий публичный.  
Решение:    
Сделано в файле ubuntu16.json за счет блока кода
```bash
"builders": [
	{
		"image_description": "image for the otus exercises",
		"network": "default",
		"tags": "http-server,https-server",
		"disk_type": "pd-standard",
		"disk_size": "10",
        }
    ],

```
Создан файл с переменными variables.json и внесен в .gitignore, а файл variables.json.example добавлен в коммит  
**Задача: задание со звездочкой**  
попробуйте “запечь” (bake) в образ VM все зависимости приложения и сам код приложения. Результат должен быть таким: запускаем инстанс из созданного образа и на нем сразу же имеем запущенное приложение. Созданный шаблон должен называться immutable.json и содержаться в директории packer, image_family у получившегося образа должен быть reddit-full. Дополнительные файлы можно положить в директорию packer/files. Для запуска приложения при старте инстанса необходимо использовать systemd unit. P.S. Этот образ можно строить "поверх" базового.  
Решение:  
Создан packer скрипт immutable.json, который создает образ семейства reddit-full. Приложение скачивается и устанавливается в сам образ скриптом packer/files/deploy_reddit.sh. Так же приложение добавляется в сервис для auto startup. Сам сервис лежит в packer/files/puma.service.  
**Задача: задание со звездочкой**  
Создайте shell-скрипт с названием create-redditvm.sh в директории config-scripts. Запишите в него команду которая запустит виртуальную машину из образа подготовленного вами в рамках этого ДЗ, из семейства reddit-full  
Решение:  
Создан скрипт config-scripts/create-reddit-vm.sh, который выполняет создание инстанса VM на основе необходимого образа
  
**ВЫПОЛНЕНО ДЗ №6**  
Создана ветка terraform-1. В файле terraform.tfvars.example используются ключи пользователя appuser.  
  
Выставлен PR с labels terraform и terraform-1.
**Задача с одной звездочкой:**  
Опишите в коде терраформа добавление ssh ключа пользователя appuser1 в метаданные проекта. Выполните terraform apply и проверьте результат (публичный ключ можно брать пользователя appuser). Опишите в коде терраформа добавление ssh ключей нескольких пользователей в метаданные проекта (можно просто один и тот же публичный ключ, но с разными именами пользователей, например appuser1, appuser2 и т.д.). Выполните terraform apply и проверьте результат  
Решение:  
В файл main.tf добавлен ресурс для ключей пользователей appuser1 и appuser2:
```bash
resource "google_compute_project_metadata" "ssh_keys" {
  metadata {
    ssh-keys = "appuser1:${file(var.public_key_path)}\nappuser2:${file(var.public_key_path)}"
  }
}
```
Это позволяет коннектиться к серверу двумя различными логинами.  
**Задача:**  
* Определите input переменную для приватного ключа, использующегося в определении подключения для провижинеров (connection);
* Определите input переменную для задания зоны в ресурсе "google_compute_instance" "app". У нее должно быть значение по умолчанию;
* Отформатируйте все конфигурационные файлы используя команду terraform fmt;
* Так как в репозиторий не попадет ваш terraform.tfvars, то нужно сделать рядом файл terraform.tfvars.example, в котором будут указаны переменные для образца
  
Решение:    
* определена переменная private_key_path
* определена переменная zone со значением по умолчанию "europe-west1-b"
* выполнено форматирование посредством terraform fmt
* создан файл terraform.tfvars.example и указаны переменные
  
**Задача с одной звездочкой:**  
Добавьте в веб интерфейсе ssh ключ пользователю appuser_web в метаданные проекта. Выполните terraform apply и проверьте результат Какие проблемы вы обнаружили?   
Решение:  
При выполнении terraform apply добавленные в web интерфейсы ключи слетают.
  
**Задача с двумя звездочками:**  
В данный момент у нас с помощью terraform создается один инстанс с запущенным приложением и правило для firewall.  
Задания:  
Создайте файл lb.tf и опишите в нем в коде terraform создание HTTP балансировщика, направляющего трафик на наше развернутое приложение на инстансе reddit-app. Проверьте доступность приложения по адресу балансировщика. Добавьте в output переменные адрес балансировщика.
  
Решение:    
Создан файд lb.tf, в котором заданы ресурсы:
```bash
resource "google_compute_forwarding_rule" "loadbalancer" 
resource "google_compute_target_pool" "loadbalancer" 
resource "google_compute_http_health_check" "default" 
```
отвечающие за работу балансировщика.    
При вызове команды terraform refresh будет дополнительно выводиться адрес балансировщика в виде:
```bash
Outputs:

lb_external_ip = 34.77.232.88
```
в таком случае можно выполнить проверку доступности через балансировщик командой:
```bash
curl http://34.77.232.88:9292
```

**Задача с двумя звездочками:**  
Добавьте в код еще один terraform ресурс для нового инстанса приложения, например reddit-app2, добавьте его в балансировщик и проверьте, что при остановке на одном из инстансов приложения (например systemctl stop puma), приложение продолжает быть доступным по адресу балансировщика; Добавьте в output переменные адрес второго инстанса; Какие проблемы вы видите в такой конфигурации приложения? Добавьте описание в README.md.  
Решение:   
В файле main.tf добавлен копипастом кусок кода вида:
```bash
resource "google_compute_instance" "app2" {
  name         = "reddit-app2"
  machine_type = "g1-small"
```
Основаная проблема ткого подхода в том, что приходится делать избыточное копирование кусков кода, что загромождает код и логику и может приводить к ошибкам из-за сложной поддержки
  
**Задача с двумя звездочками:**  
Как мы видим, подход с созданием доп. инстанса копированием кода выглядит нерационально, т.к. копируется много кода. Удалите описание reddit-app2 и попробуйте подход с заданием количества инстансов через параметр ресурса count. Переменная count должна задаваться в параметрах и по умолчанию равна 1.  
Решение:   
не успел. чуть позже сделаю
  
**ВЫПОЛНЕНО ДЗ №7**  
Работа выполнена в ветке terraform-2. Файд lb.tf перенесен в terraform/files.   
Проверено определение ресурса правила файервола:  
```
resource "google_compute_firewall" "firewall_ssh" {
	name = "default-allow-ssh"
	network = "default"
	allow {
		protocol = "tcp"
		ports = ["22"]
	}
	source_ranges = ["0.0.0.0/0"]
}
```
Проверен импорт существующей конфигурации terraform
```
terraform import google_compute_firewall.firewall_ssh default-allow-ssh
```
Проверено задание ресурса ip address:
```
resource "google_compute_address" "app_ip" {
	name = "reddit-app-ip"
}
```
и ссылку на данный ресурс:
```
network_interface {
	network = "default"
	access_config = {
		nat_ip = "${google_compute_address.app_ip.address}"
	}
}
```
Проверена работа приложения и БД в разных инстансах VM (app.tf и db.tf).  
А так же создание переменных для объявления образов диска:
```
variable app_disk_image {
	description = "Disk image for reddit app"
	default = "reddit-app-base"
}
variable db_disk_image {
	description = "Disk image for reddit db"
	default = "reddit-db-base"
}
```
Создан vpc.tf с объявлением всех правил файервола, включая ssh.  

Проверена возможность и удобство использования модулей на примере modules/db и modules/app и их загрухку:  
```
terraform get
```
**Задача:**    
Аналогично предыдущим модулям создайте модуль vpc, в котором определите настройки файервола в рамках сети. Используйте созданный модуль в основной конфигурации terraform/main.tf    
Решение:   
Выполнено за счет определения ресурса файервола
```
resource "google_compute_firewall" "firewall_ssh" {
        name = "allow-ssh"
        network = "default"
        allow {
                protocol = "tcp"
                ports    = ["22"]
        }

        # правило применяется к ресурсам с задаваемым нами тегом
        target_tags = ["reddit-app","reddit-db"]
        source_ranges = "${var.source_ranges}"
}
```
и проверен доступ по ssh на оба хоста  

**Задача:**    
Проверьте работу параметризованного в прошлом слайде
модуля vpc.  
* Введите в source_ranges не ваш IP адрес, примените правило и проверьте отсутствие соединения к обоим хостам по ssh. Проконтролируйте, как изменилось правило файрвола в веб консоли.  
* Введите в source_ranges ваш IP адрес, примените правило и проверьте наличие соединения к обоим хостам по ssh.  
* Верните 0.0.0.0/0 в source_ranges.    
Решение:  
* проверено отсутствие доступа при указании диапазона адресов, в который не входит мой ip  
* проверено наличие доступа при указании диапазона адресов, в который входит мой ip адрес  
* оставлен диапазон 0.0.0.0/0 полного доступа
  
**Задача:**    
* Удалите из папки terraform файлы main.tf, outputs.tf, terraform.tfvars, variables.tf, так как они теперь перенесены в stage и prod  
* Параметризируйте конфигурацию модулей насколько считаете нужным  
* Отформатируйте конфигурационные файлы, используя команду terraform fmt    
Решение:  
* удалены main.tf, outputs.tf, terraform.tfvars, variables.tf  
* выполнена параметризация  
* выполнено форматирование  
  
   
Дополнительно создан storage-bucket.tf для определения бакета
```
provider "google" {
	version = "2.0.0"
	project = "${var.project}"
	region = "${var.region}"
}
module "storage-bucket" {
	source = "SweetOps/storage-bucket/google"
	version = "0.1.1"
	# Имена поменяйте на другие
	name = ["my-bucket-test", "my-bucket-test2"]
}
output storage-bucket_url {
	value = "${module.storage-bucket.url}"
}
```
и проверена работоспособность (создание бакета) через web console.  

**ВЫПОЛНЕНО ДЗ №8**  
Работа выполнена в ветке ansible-1.   

Реализованы три формата инвентори:
* inventory
* inventory.yml
* inventory.json
   
Реализован плейбук clone.yml для копирования из git исходного кода на сервера приложений
  
При выполнении команды
```
ansible-playbook clone.yml
```
после удаления репозитория reddit командой
```
ansible app -m command -a 'rm -rf ~/reddit'
```
получаем состояние changed для appserver, т.к. ansible заметил отсутствие репозитория и выполнил успешно операцию из clone.yml. Повторное выполненние clone.yml changed не показывает, что значит фактические действия плейбука не выполняются   

**Задача со звездочкой**   
Создан файл inventory.json для статического инвентори. Команда
```
ansible all -m ping
```
выполняется успешно.   
Создан скрипт inventory.sh, который генерирует динамический инвентори
```
appuser@$ ./inventory.sh --list
{
    "servers": ["bastion", "someinternalhost", "reddit-app", "reddit-db", "instance-8", "reddit-app2", "reddit-app5", "reddit-app6", "ubuntu1604gitlab-ci-1", "reddit-app", "reddit-app-startup-script", ],
}

appuser@$ ./inventory.sh --host
{
    "foo1": "bar1",
    "foo2": "bar2",
    "foo3": "bar3",
}
```

**ВЫПОЛНЕНО ДЗ №9**
  
* Проверена работа ansible и параметризации на примере файлов reddit_app.yml и reddit_app2.yml. А так же работа в одном сценарии всех задач.
* Создан db.yml, в котором описано конфигурирование хоста БД
* Создан app.yml, в котором описано конфигурирование хоста приложения
* Создан deploy.yml, в котором описан деплой приложения
* Создан site.yml, в котором описано управление всей инфраструктурой
   
Созданы файлы ansible/packer_app.yml и ansible/packer_db.yml, в которых реализованы задачи:   
* Install ruby and rubygems and required packages
* Add APT key
* Add APT repository
* Install mongodb package
* Configure service supervisor
  
Выполнена интеграция ansible в packer за счет добавления ссылок на файлы packer/app.json и packer/db.json в provisioners:
```
"provisioners": [
	{
		"type": "ansible",
		"playbook_file": "ansible/packer_app.yml"
	}
]

...

"provisioners": [
	{
		"type": "ansible",
		"playbook_file": "ansible/packer_db.yml"
	}
]
```

**ВЫПОЛНЕНО ДЗ №10**
**Задача (Community роли)**
* Добавить параметры 

Решение:  
**Задача (Stage и Prod)**
* настроить окружение для stage и prod и playbook  
Решение:
Все окружение настроено в виде environments/stage и environments/prod и ansible/playbooks
  
**Задача (Проксирование портов)**  
* Установить роли ansible-galaxy install -r environments/stage/requirements.yml && ansible-galaxy install -r environments/prod/requirements.yml 
* Добавить параметры проксирования
```
nginx_sites:
	default:
		- listen 80
		- server_name "reddit"
		- location / {
			proxy_pass http://127.0.0.1:9292;
		}
``` 
* Добавьте в конфигурацию Terraform открытие 80 порта для
* инстанса приложения
* Добавьте вызов роли jdauphant.nginx в плейбук app.yml
* Примените плейбук site.yml для окружения stage и проверьте,что приложение теперь доступно на 80 порту  
Решение:  
Все задания по проксированию портов выполнено
  
**Задача (Vault)**
* Создать файл vault.key с паролем для шифрования секретов. Добавить его в .gitignore.
* Задать параметр vault_password_file в конфиге ansible.cfg
* Добавить поейбук для создания пользвателей ansible/playbooks/users.yml
* Создать файлы ansible/environments/prod/credentials.yml и ansible/environments/stage/credentials.yml с соответствующими пользователями
* Зашифровать файлы, используя vault.key
* Проверить, что файлы credentials.yml зашифрованы
* Выполнить ansible-playbook site.yml —check && ansible-playbook site.yml
* Проверить, что пользователи созданы  
Решеие: все пункты для Vault выполнены  

**ВЫПОЛНЕНО ДЗ №10**
* Настроена инфраструктура при помощи Vagrant
* Доработаны playbooks для использования в Vagrant
* Playbooks тестируются при помощи Molecule и Testinfra
* packer использует доработанные playbooks
* Конфигурация Vagrant доработана для использования nginx-прокси

