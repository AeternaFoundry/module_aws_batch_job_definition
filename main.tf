resource "aws_batch_job_definition" "batch_job_definitions" {
  for_each = var.batch_job_definitions

  name                       = each.value.name
  type                       = each.value.type
  container_properties       = each.value.container_properties
  deregister_on_new_revision = each.value.deregister_on_new_revision
  ecs_properties             = each.value.ecs_properties
  node_properties            = each.value.node_properties
  parameters                 = each.value.parameters
  platform_capabilities      = each.value.platform_capabilities
  propagate_tags             = each.value.propagate_tags
  region                     = each.value.region
  scheduling_priority        = each.value.scheduling_priority
  tags                       = each.value.tags
  tags_all                   = each.value.tags_all

  dynamic "eks_properties" {
    for_each = each.value.eks_properties != null ? [each.value.eks_properties] : []
    content {
      pod_properties {
        dynamic "containers" {
          for_each = eks_properties.value.pod_properties.containers
          content {
            args    = containers.value.args
            command = containers.value.command
            dynamic "env" {
              for_each = containers.value.env != null ? containers.value.env : []
              content {
                name  = env.value.name
                value = env.value.value
              }
            }
            image             = containers.value.image
            image_pull_policy = containers.value.image_pull_policy
            name              = containers.value.name
            dynamic "resources" {
              for_each = containers.value.resources != null ? [containers.value.resources] : []
              content {
                limits   = resources.value.limits
                requests = resources.value.requests
              }
            }
            dynamic "security_context" {
              for_each = containers.value.security_context != null ? [containers.value.security_context] : []
              content {
                allow_privilege_escalation = security_context.value.allow_privilege_escalation
                privileged                 = security_context.value.privileged
                read_only_root_file_system = security_context.value.read_only_root_file_system
                run_as_group               = security_context.value.run_as_group
                run_as_non_root            = security_context.value.run_as_non_root
                run_as_user                = security_context.value.run_as_user
              }
            }
            dynamic "volume_mounts" {
              for_each = containers.value.volume_mounts != null ? containers.value.volume_mounts : []
              content {
                mount_path = volume_mounts.value.mount_path
                name       = volume_mounts.value.name
                read_only  = volume_mounts.value.read_only
              }
            }
          }
        }
        dns_policy   = eks_properties.value.pod_properties.dns_policy
        host_network = eks_properties.value.pod_properties.host_network
        dynamic "image_pull_secret" {
          for_each = eks_properties.value.pod_properties.image_pull_secret != null ? eks_properties.value.pod_properties.image_pull_secret : []
          content {
            name = image_pull_secret.value.name
          }
        }
        dynamic "init_containers" {
          for_each = eks_properties.value.pod_properties.init_containers != null ? eks_properties.value.pod_properties.init_containers : []
          content {
            args    = init_containers.value.args
            command = init_containers.value.command
            dynamic "env" {
              for_each = init_containers.value.env != null ? init_containers.value.env : []
              content {
                name  = env.value.name
                value = env.value.value
              }
            }
            image             = init_containers.value.image
            image_pull_policy = init_containers.value.image_pull_policy
            name              = init_containers.value.name
            dynamic "resources" {
              for_each = init_containers.value.resources != null ? [init_containers.value.resources] : []
              content {
                limits   = resources.value.limits
                requests = resources.value.requests
              }
            }
            dynamic "security_context" {
              for_each = init_containers.value.security_context != null ? [init_containers.value.security_context] : []
              content {
                allow_privilege_escalation = security_context.value.allow_privilege_escalation
                privileged                 = security_context.value.privileged
                read_only_root_file_system = security_context.value.read_only_root_file_system
                run_as_group               = security_context.value.run_as_group
                run_as_non_root            = security_context.value.run_as_non_root
                run_as_user                = security_context.value.run_as_user
              }
            }
            dynamic "volume_mounts" {
              for_each = init_containers.value.volume_mounts != null ? init_containers.value.volume_mounts : []
              content {
                mount_path = volume_mounts.value.mount_path
                name       = volume_mounts.value.name
                read_only  = volume_mounts.value.read_only
              }
            }
          }
        }
        dynamic "metadata" {
          for_each = eks_properties.value.pod_properties.metadata != null ? [eks_properties.value.pod_properties.metadata] : []
          content {
            labels = metadata.value.labels
          }
        }
        service_account_name    = eks_properties.value.pod_properties.service_account_name
        share_process_namespace = eks_properties.value.pod_properties.share_process_namespace
        dynamic "volumes" {
          for_each = eks_properties.value.pod_properties.volumes != null ? eks_properties.value.pod_properties.volumes : []
          content {
            dynamic "empty_dir" {
              for_each = volumes.value.empty_dir != null ? [volumes.value.empty_dir] : []
              content {
                medium     = empty_dir.value.medium
                size_limit = empty_dir.value.size_limit
              }
            }
            dynamic "host_path" {
              for_each = volumes.value.host_path != null ? [volumes.value.host_path] : []
              content {
                path = host_path.value.path
              }
            }
            name = volumes.value.name
            dynamic "secret" {
              for_each = volumes.value.secret != null ? [volumes.value.secret] : []
              content {
                optional    = secret.value.optional
                secret_name = secret.value.secret_name
              }
            }
          }
        }
      }
    }
  }

  dynamic "retry_strategy" {
    for_each = each.value.retry_strategy != null ? [each.value.retry_strategy] : []
    content {
      attempts = retry_strategy.value.attempts
      dynamic "evaluate_on_exit" {
        for_each = retry_strategy.value.evaluate_on_exit != null ? retry_strategy.value.evaluate_on_exit : []
        content {
          action           = evaluate_on_exit.value.action
          on_exit_code     = evaluate_on_exit.value.on_exit_code
          on_reason        = evaluate_on_exit.value.on_reason
          on_status_reason = evaluate_on_exit.value.on_status_reason
        }
      }
    }
  }

  dynamic "timeout" {
    for_each = each.value.timeout != null ? [each.value.timeout] : []
    content {
      attempt_duration_seconds = timeout.value.attempt_duration_seconds
    }
  }
}

