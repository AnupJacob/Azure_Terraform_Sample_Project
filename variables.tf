variable "host-os" {
  type = string
}

variable "user" {
  type = string
}

variable "ip-allocation" {
  type    = string
  default = "Dynamic"
}

variable "environment" {
  type        = string
  default     = "dev"
  description = "Environment used to test this azure application deployment"
}

variable "az-location" {
  type    = string
  default = "North-Europe"
}

variable "az-virtual-network-address-space" {
  type = set(string)
}