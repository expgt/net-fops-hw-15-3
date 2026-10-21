resource "local_file" "ansible_inventory" {
  filename = "${path.module}/hosts.ini"

  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = yandex_compute_instance.web
    databases  = values(yandex_compute_instance.db)
    storage    = [yandex_compute_instance.storage] 
  })
}

# resource "null_resource" "web_hosts_provision" {
#   depends_on = [local_file.ansible_inventory]

#   triggers = {
#     policy_id = "${join(",", yandex_compute_instance.web[*].id)},${join(",", values(yandex_compute_instance.db)[*].id)},${yandex_compute_instance.storage.id}"
#   }

#   provisioner "local-exec" {
#     command = "sleep 30 && ansible-playbook -i ${local_file.ansible_inventory.filename} test.yml"
#     environment = {
#       ANSIBLE_HOST_KEY_CHECKING = "False"
#     }
#   }
# }
