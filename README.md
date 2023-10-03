# This is the Terraform module for setup the cloudRun with Filestore

## Discription:
   * A Terraform module for creating and managing Google Cloud Run with optional Filestore
   * This module use to connect the Filestore with Cloud Run

## Modules:
   This module implements the following Terraform resources
   
   * google_cloud_run_v2_service
   * google_project_service
   * google_filestore_instance
   * google_vpc_access_connector

## Get Started:
  We can give the following varibales and values in [main.tf](./main.tf) file with respective modules.

### API-Enable Module:
|`Varibales`|`Description`|`Default`|`Values` |
|-----------| -----------| ---------|---------|
|`api`|`(Required) The list of the name of the Google Platform project service.`||`list`|
|`disable_on_destroy`| `(Optional) If true, services that are enabled and which depend on this service should also be disabled when this service is destroyed`|`false`|`bool`|
|`project`|`(Optional) The project in which the resource belongs. If it is not provided, the provider project is used.`||`string`|
|`module_depends_on`|`(Optional) A list of external resources the module depends_on. Default is '[]'`||`list`|
|`module_timeouts`|`(Optional) An Object that specifies how long certain operations (per resource type) are allowed to take before being considered to have failed.`||`map`|

### Cloud Run V2:

   * [**`name`**](#var-name): *(**Required**`sting`)*<a name="var-name"></a>
    
      Name must be unique within a namespace, within a Cloud Run region. Is **required** when creating resources. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated.
   * [**`location`**](#var-location): *(**Required** `string`)*<a name="var-location"></a>

      The location of the cloud run instance. eg us-central1.
   * [**`project_id`**](#var-project_id): *(**Optional** `string`)*<a name="var-project_id"></a>

      The ID of the project in which the resource belongs. If it is not provided, the provider project is used.
   * [**`execution_environment`**](#var-execution_environment): *(**Optional** `string`)*<a name="var-execution_environment"></a>

      The sandbox environment to host this Revision. Possible values are: EXECUTION_ENVIRONMENT_GEN1, EXECUTION_ENVIRONMENT_GEN2.
   * [**`ingress`**](#var-ingress): *(**Optional** `string`)*<a name="var-ingress"></a>

      Provides the ingress settings for this Service. On output, returns the currently observed ingress settings, or INGRESS_TRAFFIC_UNSPECIFIED if no revision is active. Possible values are: INGRESS_TRAFFIC_ALL, INGRESS_TRAFFIC_INTERNAL_ONLY, INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER.
   * [**`scaling_config`**](#var-scaling_config): *(**Optional** `list`)*<a name="scaling_config"></a>

      Scaling settings for this Revision.
      
      Default is {}.

      The `scaling_config` object accepts the following attributes:
      * [**`min_instance_count`**](#var-min_instance_count): *(**Optional** `nubmer`)*<a name="var-min_instance_count"></a>

         Minimum number of serving instances that this resource should have.
         
         Default is 0.
         
      * [**`max_instance_count`**](#var-max_instance_count): *(**Optional** `nubmer`)*<a name="var-max_instance_count"></a>

         Maximum number of serving instances that this resource should have.
         
         Default is 100.

   * [**`service_account`**](#var-service_account): *(**Optional** `string`)*<a name="var-service_account"></a>

      Email address of the IAM service account associated with the revision of the service. The service account represents the identity of the running revision, and determines what permissions the revision has. If not provided, the revision will use the project's default service account.

   * [**labels**](#var-labels): *(**Optional** `map(string)`)*<a name="var-labels"></a>

      Unstructured key value map that can be used to organize and categorize objects. User-provided labels are shared with Google's billing system, so they can be used to filter, or break down billing charges by team, component, environment, state, etc. For more information, visit https://cloud.google.com/resource-manager/docs/creating-managing-labels or https://cloud.google.com/run/docs/configuring/labels. Cloud Run API v2 does not support labels with run.googleapis.com, cloud.googleapis.com, serving.knative.dev, or autoscaling.knative.dev namespaces, and they will be rejected. All system labels in v1 now have a corresponding field in v2 RevisionTemplate.
   
   * [**annotations**](#var-annotations): *(**Optional** `map(string)`)*<a name="var-annotations"></a>

      Unstructured key value map that may be set by external tools to store and arbitrary metadata. They are not queryable and should be preserved when modifying objects. Cloud Run API v2 does not support annotations with run.googleapis.com, cloud.googleapis.com, serving.knative.dev, or autoscaling.knative.dev namespaces, and they will be rejected. All system annotations in v1 now have a corresponding field in v2 RevisionTemplate. This field follows Kubernetes annotations' namespacing, limits, and rules.
   
   * [**containers_temp**](#var-containers_temp): *(**Optional** `list`)*<a name="var-containers_temp"></a>

      Holds the containers that define the unit of execution for this Service.

       The `containers_temp` object accepts the following attributes:

      * [**image**](#var-image): *(**Optional** `string`)*<a name="var-image"></a>

         URL of the Container image in Google Container Registry or Google Artifact Registry. More info: https://kubernetes.io/docs/concepts/containers/images
      
      * [**name**](#var-name): *(**Optional** `string`)*<a name="var-name"></a>

         Name of the container specified as a DNS_LABEL.
      
      * [**command**](#var-command): *(**Optional** `list`)*<a name="var-command"></a>

         Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell

      * [**args**](#var-args): *(**Optional** `list`)*<a name="var-args"></a>

         Arguments to the entrypoint. The docker image's CMD is used if this is not provided. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell

      * [**env**](#var-env): *(**Optional** `list(object)`)*<a name="var-env"></a>

         List of environment variables to set in the container.
         The `env` object accepts the following attributes:

         * [**name**](#var-name): *(**Required** `string`)*<a name="var-name"></a>

            Name of the environment variable. Must be a C_IDENTIFIER, and mnay not exceed 32768 characters
         
         * [**value**](#var-value): *(**Optional** `string`)*<a name="var-value"></a>

            Variable references `$(VAR_NAME)` are expanded using the previous defined environment variables in the container and any route environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. The `$(VAR_NAME)` syntax can be escaped with a double `$$`, ie: `$$(VAR_NAME)`. Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to "", and the maximum length is 32768 bytes

      * [**value_source**](#var-value_source): *(**Optional** `list(object)`)*<a name="var-value_source"></a>

         Source for the environment variable's value.

         The `value_source` object accepts the following attributes:

         * [**secret**](#var-secret): *(**Required** `string`)*<a name="var-secret"></a>

            The name of the secret in Cloud Secret Manager. Format: {secretName} if the secret is in the same project. projects/{project}/secrets/{secretName} if the secret is in a different project.
         * [**version**](#var-version): *(**Optional** `string`)*<a name="var-version"></a>

            The Cloud Secret Manager secret version. Can be 'latest' for the latest value or an integer for a specific version.

      * [**resources**](#var-resources): *(**Optional** `list`)*<a name="var-resources"></a>

         Compute Resource requirements by this container.

         The `resources` object accepts the following attributes:

         * [**limits**](#var-limits): *(**Optional** `string`)*<a name=var-limits></a>

            Only memory and CPU are supported. Note: The only supported values for CPU are '1', '2', '4', and '8'. Setting 4 CPU requires at least 2Gi of memory. The values of the map is string form of the 'quantity' k8s type: https://github.com/kubernetes/kubernetes/blob/master/staging/src/k8s.io/apimachinery/pkg/api/resource/quantity.go

         * [**cpu_idle**](#var-cpu_idle): *(**Optional** `string`)*<a name=var-cpu_idle></a>

            Determines whether CPU should be throttled or not outside of requests.

         * [**startup_cpu_boost**](#var-startup_cpu_boost): *(**Optional** `string`)*<a name=var-startup_cpu_boost></a>
            Determines whether CPU should be boosted on startup of a new container instance above the requested CPU threshold, this can help reduce cold-start latency.
         

      * [**ports**](#var-ports): *(**Optional** `list`)*<a name="var-ports"></a>

         List of ports to expose from the container. Only a single port can be specified. The specified ports must be listening on all interfaces (0.0.0.0) within the container to be accessible. If omitted, a port number will be chosen and passed to the container through the PORT environment variable for the container to listen on

         The `ports` object accepts the following attributes:

         * [**name**](#var-name): *(**Optional** `string`)*<a name="var-name"></a>

            If specified, used to specify which protocol to use. Allowed values are "http1" and "h2c".

         * [**container_port**](#var-container_port): *(**Optional** `list`)*<a name="var-container_port"></a>

            Port number the container listens on. This must be a valid TCP port number, 0 < containerPort < 65536


      
      * [**volume_mounts**](#var-volume_mounts): *(**Optional** `list`)*<a name="var-volume_mounts"></a>

         Volume to mount into the container's filesystem

         The `volume_mounts` object accepts the following attributes:

         * [**name**](#var-name): *(**Required** `string`)*<a name="var-name"></a>

            This must match the Name of a Volume.

         * [**mount_path**](#var-mount_path): *(**Required** `list`)*<a name="var-mount_path"></a>
          
            Path within the container at which the volume should be mounted. Must not contain ':'. For Cloud SQL volumes, it can be left empty, or must otherwise be /cloudsql. All instances defined in the Volume will be available as /cloudsql/[instance]. For more information on Cloud SQL volumes, visit https://cloud.google.com/sql/docs/mysql/connect-run

      * [**working_dir**](#var-working_dir): *(**Optional** `string`)*<a name="var-working_dir"></a>

         Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image.


### Filestore:

   * [**name**](#var-name): *(**Required** `string`)*<a name="var-name"></a>

       The resource name of the instance.
   
   * [**tier**](#var-tier): *(**Required** `string`)*<a name="var-tier"></a>

      The service tier of the instance. Possible values include: STANDARD, PREMIUM, BASIC_HDD, BASIC_SSD, HIGH_SCALE_SSD, ZONAL and ENTERPRISE
   
   * [**file_shares**](#var-file_shares): *(**Required** `string`)*<a name="var-file_shares"></a>

      File system shares on the instance. For this version, only a single file share is supported

      The `file_shares` object accepts the following attributes:

      * [**name**](#var-name): *(**Required** `string`)*<a name="var-name"></a>

         The name of the fileshare (16 characters or less)

      * [**capacity_gb**](#var-capacity_gb): *(**Required** `string`)*<a name="var-capacity_gb"></a>

         File share capacity in GiB. This must be at least 1024 GiB for the standard tier, or 2560 GiB for the premium tier. 

      * [**source_backup**](#var-source_backup): *(**Optional** `string`)*<a name="var-source_backup"></a>

         The resource name of the backup, in the format projects/{projectId}/locations/{locationId}/backups/{backupId}, that this file share has been restored from.

      * [**nfs_export_options**](#var-nfs_export_options): *(**Optional** `list(object)`)*<a name="var-nfs_export_options"></a>

         Nfs Export Options. There is a limit of 10 export options per file share

         The  `nfs_export_options` object accepts the following attributes:

         * [**ip_ranges**](#var-ip_ranges): *(**Optional** `list`)*<a name="var-ip_ranges"></a>

            List of either IPv4 addresses, or ranges in CIDR notation which may mount the file share. Overlapping IP ranges are not allowed, both within and across NfsExportOptions. An error will be returned. The limit is 64 IP ranges/addresses for each FileShareConfig among all NfsExportOptions.

         * [**access_mode**](#var-access_mode): *(**Optional** `string`)*<a name="var-access_mode"></a>

            Either READ_ONLY, for allowing only read requests on the exported directory, or READ_WRITE, for allowing both read and write requests. The default is READ_WRITE. Default value is READ_WRITE. Possible values are: READ_ONLY, READ_WRITE.

         * [**squash_mode**](#var-squash_mode): *(**Optional** `string`)*<a name="var-squash_mode"></a>

            Either NO_ROOT_SQUASH, for allowing root access on the exported directory, or ROOT_SQUASH, for not allowing root access. The default is NO_ROOT_SQUASH. Default value is NO_ROOT_SQUASH. Possible values are: NO_ROOT_SQUASH, ROOT_SQUASH.

         * [**anon_uid**](#var-anon_uid): *(**Optional** `Number`)*<a name="var-anon_uid"></a>

            An integer representing the anonymous user id with a default value of 65534. Anon_uid may only be set with squashMode of ROOT_SQUASH. An error will be returned if this field is specified for other squashMode settings.

         * [**anon_gid**](#var-anon_gid): *(**Optional** `Number`)*<a name="var-anon_gid"></a>

            An integer representing the anonymous group id with a default value of 65534. Anon_gid may only be set with squashMode of ROOT_SQUASH. An error will be returned if this field is specified for other squashMode settings.

   * [**network**](#var-network): *(**Optional** `string`)*<a name="var-network"></a>

      VPC networks to which the instance is connected. For this version, only a single network is supported.
      
      The `network` object accepts the following attributes:

      * [**network**](#var-network): *(**Required** `String`)*<a name="var-network"></a>

         The name of the GCE VPC network to which the instance is connected.

      * [**modes**](#var-modes): *(Requried `String`)*<a name="var-modes"></a>

         IP versions for which the instance has IP addresses assigned. Each value may be one of: ADDRESS_MODE_UNSPECIFIED, MODE_IPV4, MODE_IPV6.

      * [**reserved_ip_range**](#var-reserved_ip_range): *(**Optional** `String`)*<a name="var-reserved_ip_range"></a>
         
         A /29 CIDR block that identifies the range of IP addresses reserved for this instance.

      * [**ip_addresses**](#var-ip_addresses): *(**Optional** `String`)*<a name="var-ip_addresses"></a>

         A list of IPv4 or IPv6 addresses.

      * [**connect_mode**](#var-connect_mode): *(**Optional** `String`)*<a name="var-connect_mode"></a>

         The network connect mode of the Filestore instance. If not provided, the connect mode defaults to DIRECT_PEERING. Default value is DIRECT_PEERING. Possible values are: DIRECT_PEERING, PRIVATE_SERVICE_ACCESS
      


   * [**project_id**](#var-project_id): *(**Optional** `string`)*<a name="var-project_id"></a>

      The ID of the project in which the resource belongs. If it is not provided, the provider project is used.

   * [**location**](#var-location): *(**Optional** `string`)*<a name="var-location"></a>

      The name of the location of the instance. This can be a region for ENTERPRISE tier instances.

   * [**labels**](#var-labels): *(**Optional** `map(string)`)*<a name="var-labels"></a>

      Resource labels to represent user-provided metadata.

      Note: This field is non-authoritative, and will only manage the labels present in your configuration. Please refer to the field effective_labels for all of the labels present on the resource.

   * [**kms_key_name**](#var-kms_key_name): *(**Optional** `string`)*<a name="var-kms_key_name"></a>

      KMS key name used for data encryption.

   * [**description**](#var-description): *(**Optional** `string`)*<a name="var-description"></a>

      A description of the instance


### Serverless VPC access connector:

   * [**name**](#var-name): *(**Required** `string`)*<a name="var-name"></a>

      The name of the resource (Max 25 characters).

   * [**ip_cidr_range**](#var-ip_cidr_range): *(**Optional** `string`)*<a name="var-ip_cidr_range"></a>

      The range of internal addresses that follows RFC 4632 notation. Example: 10.132.0.0/28.

   * [**project_id**](#var-project_id): *(**Optional** `string`)*<a name="var-project_id"></a>

      The ID of the project in which the resource belongs. If it is not provided, the provider project is used
   
   * [**network_vpc**](#var-network_vpc): *(**Optional** `string`)*<a name="var-network_vpc"></a>

      Name or self_link of the VPC network. Required if ip_cidr_range is set.

   * [**region**](#var-region): *(**Optional** `string`)*<a name="var-region"></a>

      Region where the VPC Access connector resides. If it is not provided, the provider region is used.

   * [**machine_type**](#var-machine_type): *(**Optional** `string`)*<a name="var-machine_type"></a>

      Machine type of VM Instance underlying connector. Default is e2-micro
   
   * [**min_throughput**](#var-min_throughput): *(**Optional** `string`)*<a name="var-min_throughput"></a>

      Minimum throughput of the connector in Mbps. Default and min is 200.
   
   * [**max_throughput**](#var-max_throughput): *(**Optional** `string`)*<a name="var-max_throughput"></a>

      Maximum throughput of the connector in Mbps, must be greater than min_throughput. Default is 300.

   * [**min_instances**](#var-min_instances): *(**Optional** `string`)*<a name="var-min_instances"></a>

      Minimum value of instances in autoscaling group underlying the connector.

   * [**max_instances**](#var-max_instances): *(**Optional** `string`)*<a name="var-max_instances"></a>

      Maximum value of instances in autoscaling group underlying the connector.
   
   * [**subnet**](#var-subnet): *(**Optional** `string`)*<a name="var-subnet"></a>
      
      The subnet in which to house the connector

      The `subnet` object accepts the following attributes:

      * [**name**](#var-name): *(**Optional** `string`)*<a name="var-name"></a>

         Subnet name (relative, not fully qualified). E.g. if the full subnet selfLink is https://compute.googleapis.com/compute/v1/projects/{project}/regions/{region}/subnetworks/{subnetName} the correct input for this field would be {subnetName}"

      * [**project_id**](#var-project_id): *(**Optional** `string`)*<a name="var-project_id"></a>

         Project in which the subnet exists. If not set, this project is assumed to be the project for which the connector create request was issued.
      
      *Note: if you have provided the `ip_cidr_range` value, then don't provide the `subnet` configuration, it both get conflict when we give the both configuration*


### Module Configuration

- [**`module_enabled`**](#var-module_enabled): *(**Optional** `bool`)*<a name="var-module_enabled"></a>

  Specifies whether resources in the module will be created. *note: this variable not for google_project_service*

  Default is `true`.

- [**`module_timeouts`**](#var-module_timeouts): *(**Optional** `object(module_timeouts)`)*<a name="var-module_timeouts"></a>

  A map of timeout objects that is keyed by Terraform resource name
  defining timeouts for `create`, `update` and `delete` Terraform operations.

  Supported resources are: `google_cloud_run_v2_service`, `google_filestore_instance`, `google_vpc_access_connector`,  `google_project_service`

  Default is `{}`.

  Example:

  ```hcl
  module_timeouts = {
    null_resource = {
      create = "4m"
      update = "4m"
      delete = "4m"
    }
  }
  ```

  The `module_timeouts` object accepts the following attributes:

  - [**`create`**](#attr-module_timeouts-create): *(**Optional** `string`)*<a name="attr-module_timeouts-create"></a>

    Timeout for create operations.

    Default is `"6m"`.

  - [**`update`**](#attr-module_timeouts-update): *(**Optional** `string`)*<a name="attr-module_timeouts-update"></a>

    Timeout for update operations.

    Default is `"15m"`.

  - [**`delete`**](#attr-module_timeouts-delete): *(**Optional** `string`)*<a name="attr-module_timeouts-delete"></a>

    Timeout for delete operations.

    Default is `"4m"`.

- [**`module_depends_on`**](#var-module_depends_on): *(**Optional** `list(dependency)`)*<a name="var-module_depends_on"></a>

  A list of dependencies.
  Any object can be _assigned_ to this list to define a hidden external dependency.

  Default is `[]`.

  Example:

  ```hcl
  module_depends_on = [
    null_resource.name
  ]
  ```

