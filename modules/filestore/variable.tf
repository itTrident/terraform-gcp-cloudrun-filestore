variable name {
  type        = string
  description = "(Required) The resource name of the instance."
}

variable project_id {
  type        = string
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  default = ""
}

variable location {
  type        = string
  description = "Optional) The name of the location of the instance. This can be a region for ENTERPRISE tier instances."
  default = ""
}

variable labels {
  type        = map
  description = "(Optional) Resource labels to represent user-provided metadata."
  default = {}
}

variable kms_key_name {
  type        = string
  description = "(Optional) KMS key name used for data encryption."
  default = null
}


variable description {
  type        = string
  description = "(Optional) A description of the instance."
  default = null
}

variable tier {
  type        = string
  description = "(Required) The service tier of the instance. Possible values include: STANDARD, PREMIUM, BASIC_HDD, BASIC_SSD, HIGH_SCALE_SSD, ZONAL and ENTERPRISE"
  default = "BASIC_HDD"
}

variable file_shares {
  type        = any
  description = "(Required) File system shares on the instance. For this version, only a single file share is supported"
}

variable network {
  type        = any
  description = "(Required) VPC networks to which the instance is connected. For this version, only a single network is supported"
}

variable "module_enabled" {
  type        = bool
  description = "(Optional) Whether to create resources within the module or not. Default is 'true'."
  default     = true
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on. Default is '[]'."
  default     = []
}

variable "module_timeouts" {
  description = "(Optional) An Object that specifies how long certain operations (per resource type) are allowed to take before being considered to have failed."
  type        = any
  default     = {}
}