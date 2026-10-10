variable "batch_job_definitions" {
  description = <<EOT
Map of batch_job_definitions, attributes below
Required:
    - name
    - type
Optional:
    - container_properties
    - deregister_on_new_revision
    - ecs_properties
    - node_properties
    - parameters
    - platform_capabilities
    - propagate_tags
    - region
    - scheduling_priority
    - tags
    - tags_all
    - eks_properties (block):
        - pod_properties (required, block):
            - containers (required, block):
                - args (optional)
                - command (optional)
                - env (optional, block):
                    - name (required)
                    - value (required)
                - image (required)
                - image_pull_policy (optional)
                - name (optional)
                - resources (optional, block):
                    - limits (optional)
                    - requests (optional)
                - security_context (optional, block):
                    - allow_privilege_escalation (optional)
                    - privileged (optional)
                    - read_only_root_file_system (optional)
                    - run_as_group (optional)
                    - run_as_non_root (optional)
                    - run_as_user (optional)
                - volume_mounts (optional, block):
                    - mount_path (required)
                    - name (required)
                    - read_only (optional)
            - dns_policy (optional)
            - host_network (optional)
            - image_pull_secret (optional, block):
                - name (required)
            - init_containers (optional, block):
                - args (optional)
                - command (optional)
                - env (optional, block):
                    - name (required)
                    - value (required)
                - image (required)
                - image_pull_policy (optional)
                - name (optional)
                - resources (optional, block):
                    - limits (optional)
                    - requests (optional)
                - security_context (optional, block):
                    - allow_privilege_escalation (optional)
                    - privileged (optional)
                    - read_only_root_file_system (optional)
                    - run_as_group (optional)
                    - run_as_non_root (optional)
                    - run_as_user (optional)
                - volume_mounts (optional, block):
                    - mount_path (required)
                    - name (required)
                    - read_only (optional)
            - metadata (optional, block):
                - labels (optional)
            - service_account_name (optional)
            - share_process_namespace (optional)
            - volumes (optional, block):
                - empty_dir (optional, block):
                    - medium (optional)
                    - size_limit (required)
                - host_path (optional, block):
                    - path (required)
                - name (optional)
                - secret (optional, block):
                    - optional (optional)
                    - secret_name (required)
    - retry_strategy (block):
        - attempts (optional)
        - evaluate_on_exit (optional, block):
            - action (required)
            - on_exit_code (optional)
            - on_reason (optional)
            - on_status_reason (optional)
    - timeout (block):
        - attempt_duration_seconds (optional)
EOT

  type = map(object({
    name                       = string
    type                       = string
    container_properties       = optional(string)
    deregister_on_new_revision = optional(bool)
    ecs_properties             = optional(string)
    node_properties            = optional(string)
    parameters                 = optional(map(string))
    platform_capabilities      = optional(set(string))
    propagate_tags             = optional(bool)
    region                     = optional(string)
    scheduling_priority        = optional(number)
    tags                       = optional(map(string))
    tags_all                   = optional(map(string))
    eks_properties = optional(object({
      pod_properties = object({
        containers = list(object({
          args    = optional(list(string))
          command = optional(list(string))
          env = optional(list(object({
            name  = string
            value = string
          })))
          image             = string
          image_pull_policy = optional(string)
          name              = optional(string)
          resources = optional(object({
            limits   = optional(map(string))
            requests = optional(map(string))
          }))
          security_context = optional(object({
            allow_privilege_escalation = optional(bool)
            privileged                 = optional(bool)
            read_only_root_file_system = optional(bool)
            run_as_group               = optional(number)
            run_as_non_root            = optional(bool)
            run_as_user                = optional(number)
          }))
          volume_mounts = optional(list(object({
            mount_path = string
            name       = string
            read_only  = optional(bool)
          })))
        }))
        dns_policy   = optional(string)
        host_network = optional(bool)
        image_pull_secret = optional(list(object({
          name = string
        })))
        init_containers = optional(list(object({
          args    = optional(list(string))
          command = optional(list(string))
          env = optional(list(object({
            name  = string
            value = string
          })))
          image             = string
          image_pull_policy = optional(string)
          name              = optional(string)
          resources = optional(object({
            limits   = optional(map(string))
            requests = optional(map(string))
          }))
          security_context = optional(object({
            allow_privilege_escalation = optional(bool)
            privileged                 = optional(bool)
            read_only_root_file_system = optional(bool)
            run_as_group               = optional(number)
            run_as_non_root            = optional(bool)
            run_as_user                = optional(number)
          }))
          volume_mounts = optional(list(object({
            mount_path = string
            name       = string
            read_only  = optional(bool)
          })))
        })))
        metadata = optional(object({
          labels = optional(map(string))
        }))
        service_account_name    = optional(string)
        share_process_namespace = optional(bool)
        volumes = optional(list(object({
          empty_dir = optional(object({
            medium     = optional(string)
            size_limit = string
          }))
          host_path = optional(object({
            path = string
          }))
          name = optional(string)
          secret = optional(object({
            optional    = optional(bool)
            secret_name = string
          }))
        })))
      })
    }))
    retry_strategy = optional(object({
      attempts = optional(number)
      evaluate_on_exit = optional(list(object({
        action           = string
        on_exit_code     = optional(string)
        on_reason        = optional(string)
        on_status_reason = optional(string)
      })))
    }))
    timeout = optional(object({
      attempt_duration_seconds = optional(number)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.batch_job_definitions : (
        v.eks_properties == null || (length(v.eks_properties.pod_properties.containers) >= 1 && length(v.eks_properties.pod_properties.containers) <= 10)
      )
    ])
    error_message = "Each containers list must contain between 1 and 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.batch_job_definitions : (
        v.eks_properties == null || (v.eks_properties.pod_properties.init_containers == null || (length(v.eks_properties.pod_properties.init_containers) <= 10))
      )
    ])
    error_message = "Each init_containers list must contain at most 10 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.batch_job_definitions : (
        v.retry_strategy == null || (v.retry_strategy.evaluate_on_exit == null || (length(v.retry_strategy.evaluate_on_exit) <= 5))
      )
    ])
    error_message = "Each evaluate_on_exit list must contain at most 5 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.batch_job_definitions : (
        v.eks_properties == null || (v.eks_properties.pod_properties.volumes == null || alltrue([for item in v.eks_properties.pod_properties.volumes : (item.empty_dir == null || (item.empty_dir.medium == null || (contains([for v in ["", "Memory"] : lower(v)], lower(item.empty_dir.medium)))))]))
      )
    ])
    error_message = "must be one of: , Memory"
  }
  validation {
    condition = alltrue([
      for k, v in var.batch_job_definitions : (
        v.retry_strategy == null || (v.retry_strategy.attempts == null || (v.retry_strategy.attempts >= 1 && v.retry_strategy.attempts <= 10))
      )
    ])
    error_message = "must be between 1 and 10"
  }
  validation {
    condition = alltrue([
      for k, v in var.batch_job_definitions : (
        v.retry_strategy == null || (v.retry_strategy.evaluate_on_exit == null || alltrue([for item in v.retry_strategy.evaluate_on_exit : (item.on_exit_code == null || ((length(item.on_exit_code) >= 1 && length(item.on_exit_code) <= 512) && (can(regex("^[0-9]*\\*?$", item.on_exit_code)))))]))
      )
    ])
    error_message = "all of: must be between 1 and 512 characters; must contain only numbers, and can optionally end with an asterisk"
  }
  validation {
    condition = alltrue([
      for k, v in var.batch_job_definitions : (
        v.retry_strategy == null || (v.retry_strategy.evaluate_on_exit == null || alltrue([for item in v.retry_strategy.evaluate_on_exit : (item.on_reason == null || ((length(item.on_reason) >= 1 && length(item.on_reason) <= 512) && (can(regex("^[0-9A-Za-z.:\\s]*\\*?$", item.on_reason)))))]))
      )
    ])
    error_message = "all of: must be between 1 and 512 characters; must contain letters, numbers, periods, colons, and white space, and can optionally end with an asterisk"
  }
  validation {
    condition = alltrue([
      for k, v in var.batch_job_definitions : (
        v.retry_strategy == null || (v.retry_strategy.evaluate_on_exit == null || alltrue([for item in v.retry_strategy.evaluate_on_exit : (item.on_status_reason == null || ((length(item.on_status_reason) >= 1 && length(item.on_status_reason) <= 512) && (can(regex("^[0-9A-Za-z.:\\s]*\\*?$", item.on_status_reason)))))]))
      )
    ])
    error_message = "all of: must be between 1 and 512 characters; must contain letters, numbers, periods, colons, and white space, and can optionally end with an asterisk"
  }
  # Note: 11 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

