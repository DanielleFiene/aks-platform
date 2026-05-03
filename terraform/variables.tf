variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "client_id" {
  description = "Service principal client ID"
  type        = string
}

variable "client_secret" {
  description = "Service principal client secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "prefix" {
  description = "Prefix voor alle resources"
  type        = string
  default     = "aksplatform"
}

variable "db_password" {
  description = "PostgreSQL administrator password"
  type        = string
  sensitive   = true
}

variable "db_location" {
  description = "Azure region voor PostgreSQL"
  type        = string
  default     = "northeurope"
}

variable "db_prefix" {
  description = "Prefix specifiek voor PostgreSQL"
  type        = string
  default     = "akspf2"
}
