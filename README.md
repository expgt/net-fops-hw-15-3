# Домашнее задание к занятию «Управляющие конструкции в коде Terraform» - Розаев А.Ю.

### Цели задания

1. Отработать основные принципы и методы работы с управляющими конструкциями Terraform.
2. Освоить работу с шаблонизатором Terraform (Interpolation Syntax).

------

### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Использован код для выполнения задания из директории [**03/src**](https://github.com/netology-code/ter-homeworks/tree/main/03/src).
4. Любые ВМ, использованные при выполнении задания - прерываемые, для экономии средств.

------

### Задание 1

1. Изучен проект.
2. Инициализирован проект, выполните код. 
Скриншот входящих правил «Группы безопасности» в ЛК Yandex Cloud:

![1](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_1.png)

---

### Задание 2

1. Создан файл count-vm.tf. В нём описано создание двух **одинаковых** ВМ  web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент **count loop**. Для данных ВМ назначена группа безопасности, созданная в первом задании.
2. Создан файл for_each-vm.tf. В нём описано создание двух ВМ для баз данных с именами "main" и "replica" **разных** по cpu/ram/disk_volume (условие выполнено частично из-за ограничений по квотам в связи с инцидентом в ЦОДах Яндекса) , используя мета-аргумент **for_each loop**. Для обеих ВМ использована одна общая переменная типа:
```
variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
}
```
В переменную внесены необходимые параметры.

3. ВМ, описанные в файле count-vm.tf, создаются после ВМ, описанных в файле for_each-vm.tf.
```
depends_on  = [yandex_compute_instance.db]
```
4. Использована функция file в local-переменной для считывания ключа ~/.ssh/id_ed25519.pub и его последующего использования в блоке metadata, взятого из ДЗ 2.
```
locals {
  ssh_public_key = file("~/.ssh/id_ed25519.pub")
}
```
5. Инициализирован проект, выполнен код.

![2_1](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_2_1.png)

![2_2](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_2_2.png)

![2_3](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_2_3.png)

![2_4](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_2_4.png)

---

### Задание 3

1. Созданы 3 одинаковых виртуальных диска размером 1 Гб с помощью ресурса yandex_compute_disk и мета-аргумента count в файле **disk_vm.tf**.
2. В том же файле создана **одиночная** ВМ c именем "storage". Использован блок **dynamic secondary_disk{..}** и мета-аргумент for_each для подключения созданных дополнительных дисков.

![3_1](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_3_1.png)

![3_2](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_3_2.png)

![3_3](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_3_3.png)

---

### Задание 4

1. В файле ansible.tf создан inventory-файл для ansible.
Использована функция tepmplatefile и файл-шаблон для создания ansible inventory-файла из лекции.
В него переданы в качестве переменных группы виртуальных машин из задания 2.1, 2.2 и 3.2, т.е. 5 ВМ.
2. Инвентарь содержит 3 группы и является динамическим, т.е. обработывет, как группу из 2-х ВМ, так и 999 ВМ.
3. В инвентарь добавлена переменная [**fqdn**](https://cloud.yandex.ru/docs/compute/concepts/network#hostname).
4. Выполнен код. Скриншот получившегося файла:

![4_1](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_4_1.png)

![4_1](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_4_2.png)

![4_1](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_4_3.png)

------

## Дополнительные задания (со звездочкой*)

------

### Задание 5* (необязательное)
1. Написан [output](https://github.com/expgt/net-fops-hw-15-3/blob/main/outputs.tf), который отображает ВМ из созданных ресурсов count и for_each в виде списка словарей.
Скриншот вывода команды ```terrafrom output```:

![5_1](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_5_1.png)

![5_2](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_5_2.png)

---

### Задание 6* (необязательное)

1. Используя null_resource и local-exec, применен ansible-playbook (test.yml) к ВМ из ansible inventory-файла.

![6_1](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_6_1.png)

3. Модифицирован файл-шаблон [hosts.tftpl](https://github.com/expgt/net-fops-hw-15-3/blob/main/hosts.tftpl). Отредактирована переменная ```ansible_host="<внешний IP-address или внутренний IP-address если у ВМ отсутвует внешний адрес>```.
Для проверки работы у ВМ отключены внешние адреса (nat=false).

![6_2_1](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_6_2_1.png)

![6_2_2](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_6_2_2.png)

---

### Задание 7* (необязательное)

Объявлен конфиг со следующим набором данных:
```
> local.vpc
{
  "network_id" = "enp7i560tb28nageq0cc"
  "subnet_ids" = [
    "e9b0le401619ngf4h68n",
    "e2lbar6u8b2ftd7f5hia",
    "b0ca48coorjjq93u36pl",
    "fl8ner8rjsio6rcpcf0h",
  ]
  "subnet_zones" = [
    "ru-central1-a",
    "ru-central1-b",
    "ru-central1-c",
    "ru-central1-d",
  ]
}
```
Для удаления из данной переменной 3 элемент из: subnet_ids и subnet_zones, необходимо в terraform console использовать выражение: 
```
{ network_id = local.vpc.network_id, subnet_ids = [for idx, id in local.vpc.subnet_ids : id if idx != 2], subnet_zones = [for idx, zone in local.vpc.subnet_zones : zone if idx != 2] }
```
Результат:

![7](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_7.png)

---

### Задание 8* (необязательное)

Выполнена проверка кода с данной конфигурацией [hosts_8.tftpl](https://github.com/expgt/net-fops-hw-15-3/blob/main/hosts_8.tftpl).
```
[webservers]
%{~ for i in webservers ~}
${i["name"]} ansible_host=${i["network_interface"][0]["nat_ip_address"] platform_id=${i["platform_id "]}}
%{~ endfor ~}
```

При проверке появляется следующая ошибка:
```
│ Error: Error in function call
│ 
│   on ansible.tf line 4, in resource "local_file" "ansible_inventory":
│    4:   content = templatefile("${path.module}/hosts_8.tftpl", {
│    5:     webservers = yandex_compute_instance.web
│    6:     databases  = values(yandex_compute_instance.db)
│    7:     storage    = [yandex_compute_instance.storage] 
│    8:   })
│     ├────────────────
│     │ while calling templatefile(path, vars)
│     │ path.module is "."
│     │ yandex_compute_instance.storage is object with 31 attributes
│ 
│ Call to function "templatefile" failed: ./hosts_8.tftpl:3,85-86: Invalid character; This character is not used within the language., and 1 other diagnostic(s).
```
Данная ошибка вызвана тем, что не закрыта интерполяция первого аргумента (ansible_host) скобкой ```}```, которая оказалась в конце строки.

После исправления и повторной проверки, получаем другую ошибку:
```
│ Error: Error in function call
│ 
│   on ansible.tf line 4, in resource "local_file" "ansible_inventory":
│    4:   content = templatefile("${path.module}/hosts_8.tftpl", {
│    5:     webservers = yandex_compute_instance.web
│    6:     databases  = values(yandex_compute_instance.db)
│    7:     storage    = [yandex_compute_instance.storage] 
│    8:   })
│     ├────────────────
│     │ while calling templatefile(path, vars)
│     │ path.module is "."
│     │ yandex_compute_instance.db is object with 2 attributes
│     │ yandex_compute_instance.storage is object with 31 attributes
│     │ yandex_compute_instance.web is tuple with 2 elements
│ 
│ Call to function "templatefile" failed: ./hosts_8.tftpl:3,89-105: Invalid index; The given key does not identify an element in this collection value., and 1 other diagnostic(s).
```
Которая сообщает, что в выражении ```${i["platform_id "]}``` после параметра platform_id указан лишний пробел.
После его удаления, конфиг успешно прошел проверку:

![8](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_8.png)

---

### Задание 9* (необязательное)

1. Для формирования списка:
["rc01","rc02","rc03","rc04",rc05","rc06",rc07","rc08","rc09","rc10....."rc99"], т.е. список от "rc01" до "rc99",
необходимо использовать terraform-выражение:
```
[for i in range(1, 100) : format("rc%02d", i)]
```
![9_1](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_9_1.png)

2. Для формирования списка:
["rc01","rc02","rc03","rc04",rc05","rc06","rc11","rc12","rc13","rc14",rc15","rc16","rc19"....."rc96"], т.е. список от "rc01" до "rc96", пропуская все номера, заканчивающиеся на "0","7", "8", "9", за исключением "rc19",
необходимо использовать terraform-выражение:
```
[for i in range(1, 97) : format("rc%02d", i) if (i % 10 != 0 && i % 10 != 7 && i % 10 != 8 && i % 10 != 9) || i == 19]
```
![9_2](https://github.com/expgt/net-fops-hw-15-3/blob/main/15_3_9_2.png)

