variable "metro_code" {
  description = "Device location metro code"
  type        = string
  validation {
    condition     = can(regex("^[A-Z]{2}$", var.metro_code))
    error_message = "Valid metro code consits of two capital leters, i.e. SV, DC."
  }
}

variable "account_number" {
  description = "Billing account number for a device"
  type        = string
  default     = 0
}

variable "platform" {
  description = "Device platform flavor that determines number of CPU cores and memory"
  type        = string
  validation {
    condition     = can(regex("^(small|medium|large)$", var.platform))
    error_message = "One of following platform flavors are supported: small, medium, large."
  }
}

variable "software_package" {
  description = "Device software package"
  type        = string
  validation {
    condition     = can(regex("^(APPX|AX|IPBASE|SEC)$", var.software_package))
    error_message = "One of following software packages are supported: APPX, AX, IPBASE, SEC."
  }
}

variable "self_managed" {
  description = "Determines device management mode: self-managed or Equinix managed (default)"
  type        = bool
  default     = false
}

variable "byol" {
  description = "Determines device licensing mode: bring your own license or subscription (default)"
  type        = bool
  default     = false
}

variable "license_token" {
  description = "License token applicable for Equinix managed device in BYOL licensing mode"
  type        = string
  default     = ""
}

variable "throughput" {
  description = "Device license throughput"
  type        = number
  validation {
    condition     = var.throughput > 0
    error_message = "Device license throughput has to be positive number."
  }
}

variable "throughput_unit" {
  description = "License throughput unit (Mbps or Gbps)"
  type        = string
  validation {
    condition     = can(regex("^(Mbps|Gbps)$", var.throughput_unit))
    error_message = "One of following throughput units are available: Mbps or Gbps."
  }
}

variable "name" {
  description = "Device name"
  type        = string
  validation {
    condition     = length(var.name) >= 2 && length(var.name) <= 50
    error_message = "Device name should consist of 2 to 50 characters."
  }
}

variable "hostname" {
  description = "Device hostname prefix"
  type        = string
  validation {
    condition     = length(var.hostname) >= 2 && length(var.hostname) <= 10
    error_message = "Device hostname should consist of 2 to 10 characters."
  }
}

variable "term_length" {
  description = "Term length in months"
  type        = number
  validation {
    condition     = can(regex("^(1|12|24|36)$", var.term_length))
    error_message = "One of following term lengths are available: 1, 12, 24, 36 months."
  }
}

variable "notifications" {
  description = "List of email addresses that will receive device status notifications"
  type        = list(string)
  validation {
    condition     = length(var.notifications) > 0
    error_message = "Notification list cannot be empty."
  }
}

variable "acl_template_id" {
  description = "Identifier of an ACL template that will be applied on a device"
  type        = string
  default     = ""
}

variable "additional_bandwidth" {
  description = "Additional internet bandwidth for a device"
  type        = number
  default     = 0
  validation {
    condition     = var.additional_bandwidth == 0 || (var.additional_bandwidth >= 25 && var.additional_bandwidth <= 2001)
    error_message = "Additional internet bandwidth should be between 25 and 2001 Mbps."
  }
}

variable "ssh_key" {
  description = "Additional internet bandwidth for a device"
  type = object({
    username = string
    key_name = string
  })
  default = {
    username = ""
    key_name = ""
  }
}

variable "secondary" {
  description = "Secondary device attributes"
  type        = map(any)
  default     = { enabled = false }
  validation {
    condition     = can(var.secondary.enabled)
    error_message = "Key 'enabled' has to be defined for secondary device."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(length(var.secondary.hostname) >= 2 && length(var.secondary.hostname) <= 10, false)
    error_message = "Key 'hostname' has to be between 2 and 10 characters long."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || can(regex("^[A-Z]{2}$", var.secondary.metro_code))
    error_message = "Key 'metro_code' has to be defined for secondary device. Valid metro code consits of two capital leters, i.e. SV, DC."
  }
  validation {
    condition     = !try(var.secondary.enabled, false) || try(var.secondary.additional_bandwidth >= 25 && var.secondary.additional_bandwidth <= 2001, true)
    error_message = "Key 'additional_bandwidth' has to be between 25 and 2001 Mbps."
  }
}
