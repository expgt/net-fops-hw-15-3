output "all_vms_info" {
  description = "List of all created VMs with their parameters"
  value = concat(
    [
      for vm in yandex_compute_instance.web : {
        fqdn = vm.fqdn
        id   = vm.id
        name = vm.name
      }
    ],
    [
      for vm in values(yandex_compute_instance.db) : {
        name = vm.name
        id   = vm.id
        fqdn = vm.fqdn
      }
    ]
  )
}
