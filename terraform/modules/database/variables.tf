variable "prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "db_prefix" {
  type = string
}
