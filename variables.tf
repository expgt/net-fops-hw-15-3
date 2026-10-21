###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-d"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "vm_image" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "image"
}

#---------------------

variable "vm_web_cores" {
  type        = number
  default     = "2"
  description = "cores VM"
}

variable "vm_web_memory" {
  type        = number
  default     = "1"
  description = "memory VM"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = "20"
  description = "core fraction VM"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "preemptible VM"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v3"
  description = "platform VM"
}

variable "vm_web_nat" {
  type        = bool
  default     = false
  description = "nat VM"
}

variable "vm_web_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "disk type VM"
}

variable "vm_web_disk_size" {
  type        = number
  default     = 8
  description = "disk size VM"
}

# variable "vm_web_serial_port" {
#   type        = number
#   default     = "1"
#   description = "serial port VM"
# }


###ssh vars

# variable "vms_ssh_root_key" {
#   type        = string
#   #default     = "<your_ssh_ed25519_key>"
#   description = "save in terraform.tfvars"
# }

#------------------------------

variable "storage_cores" {
  type        = number
  default     = "2"
  description = "cores VM"
}

variable "storage_memory" {
  type        = number
  default     = "1"
  description = "memory VM"
}

variable "storage_core_fraction" {
  type        = number
  default     = "20"
  description = "core fraction VM"
}

variable "storage_preemptible" {
  type        = bool
  default     = true
  description = "preemptible VM"
}

variable "storage_platform" {
  type        = string
  default     = "standard-v3"
  description = "platform VM"
}

variable "storage_nat" {
  type        = bool
  default     = false
  description = "nat VM"
}

variable "storage_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "disk type"
}

variable "storage_disk_size" {
  type        = number
  default     = 8
  description = "disk size VM"
}