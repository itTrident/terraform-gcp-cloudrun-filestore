variable name {
  type        = string
  description = "(Required) Name must be unique within a namespace, within a Cloud Run region. Is required when creating resources. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated."
}

variable location {
  type        = string
  description = "(Required) The location of the cloud run instance. eg us-central1."
  default     = ""
}

variable project_id {
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
  type        = string
  default     = null
}

variable "execution_environment" {
  type = string
  default = "EXECUTION_ENVIRONMENT_GEN2"
  description = "(Optional) The sandbox environment to host this Revision. Possible values are: EXECUTION_ENVIRONMENT_GEN1, EXECUTION_ENVIRONMENT_GEN2." 

}

variable ingress {
  type        = string
  default = "INGRESS_TRAFFIC_ALL"
  description = "(Optional) Provides the ingress settings for this Service. On output, returns the currently observed ingress settings, or INGRESS_TRAFFIC_UNSPECIFIED if no revision is active. Possible values are: INGRESS_TRAFFIC_ALL, INGRESS_TRAFFIC_INTERNAL_ONLY, INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER."
}

variable scaling_config {
  type        = list
  description = "(Optional) Scaling settings for this Revision"
  default = []
}

variable service_account {
  type        = string
  description = "(Optional) Email address of the IAM service account associated with the revision of the service. The service account represents the identity of the running revision, and determines what permissions the revision has. If not provided, the revision will use the project's default service account."
  default = null
}

variable "labels" {
  type = map(any)
  description = "Optional) Unstructured key value map that can be used to organize and categorize objects. User-provided labels are shared with Google's billing system, so they can be used to filter, or break down billing charges by team, component, environment, state, etc. For more information, visit https://cloud.google.com/resource-manager/docs/creating-managing-labels or https://cloud.google.com/run/docs/configuring/labels. Cloud Run API v2 does not support labels with run.googleapis.com, cloud.googleapis.com, serving.knative.dev, or autoscaling.knative.dev namespaces, and they will be rejected. All system labels in v1 now have a corresponding field in v2 RevisionTemplate."
  default = null
}

variable "annotations" {
  type = map(any)
  default = null
  description = "(Optional) Unstructured key value map that may be set by external tools to store and arbitrary metadata. They are not queryable and should be preserved when modifying objects. Cloud Run API v2 does not support annotations with run.googleapis.com, cloud.googleapis.com, serving.knative.dev, or autoscaling.knative.dev namespaces, and they will be rejected. All system annotations in v1 now have a corresponding field in v2 RevisionTemplate. This field follows Kubernetes annotations' namespacing, limits, and rules."
}

variable containers_temp {
  type        = list(any)
  description = "(Optional) Holds the containers that define the unit of execution for this Service."
  default = [ ]
}

variable vpc_access {
  type        = any
  description = "(Optional) VPC Access configuration to use for this Task. For more information, visit https://cloud.google.com/run/docs/configuring/connecting-vpc."
  default = []
}

variable volumes {
  type        = any
  description = "(Optional) A list of Volumes to make available to containers."
  default = []
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
