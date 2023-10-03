variable api {
  type        = list
  description = "(Required) The name of the Google Platform project service."
  default = []
}

variable disable_on_destroy {
  type        = bool
  description = "(Optional) If true, services that are enabled and which depend on this service should also be disabled when this service is destroyed. If false or unset, an error will be generated if any enabled services depend on this service when destroying it."
  default = false
}

variable project {
  type        = string
  description = "(Optional) The project in which the resource belongs. If it is not provided, the provider project is used."
  default = ""
}

variable "module_depends_on" {
  type        = any
  description = "(Optional) A list of external resources the module depends_on. Default is '[]'."
  default     = []
}

variable "module_timeouts" {
  type = map(any)
  default = {}
  description = "(Optional) An Object that specifies how long certain operations (per resource type) are allowed to take before being considered to have failed."
}