variable name {
  type        = string
  description = "(Required) The name of the resource (Max 25 characters)."
}

variable subnet {
  type        = any
  default     = []
  description = "(Optional) The subnet in which to house the connector"
}

variable ip_cidr_range {
  type        = string
  default     = null
  description = "(Optional) The range of internal addresses that follows RFC 4632 notation. Example: 10.132.0.0/28."
}

variable project_id {
  type        = string
  default     = ""
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
}

variable network_vpc {
  type        = string
  default     = null
  description = "(Optional) Name or self_link of the VPC network. Required if ip_cidr_range is set."
}

variable region {
  type        = string
  default    = ""
  description = "(Optional) Region where the VPC Access connector resides. If it is not provided, the provider region is used"
}

variable machine_type {
  type        = string
  default     = "e2-micro"
  description = "(Optional) Machine type of VM Instance underlying connector. Default is e2-micro"
}

variable min_throughput {
  type        = number
  default     = null
  description = "(Optional) Minimum throughput of the connector in Mbps. Default and min is 200."
}

variable max_throughput {
  type        = number
  default     = null
  description = "Optional) Maximum throughput of the connector in Mbps, must be greater than min_throughput. Default is 300."
}

variable min_instances {
  type        = number
  default     = null
  description = "(Optional) Minimum value of instances in autoscaling group underlying the connector."
}

variable max_instances {
  type        = number
  default     = null
  description = "(Optional) Maximum value of instances in autoscaling group underlying the connector."
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