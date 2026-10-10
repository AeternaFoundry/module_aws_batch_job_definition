output "batch_job_definitions_id" {
  description = "Map of id values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.id if v.id != null && length(v.id) > 0 }
}
output "batch_job_definitions_arn" {
  description = "Map of arn values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.arn if v.arn != null && length(v.arn) > 0 }
}
output "batch_job_definitions_arn_prefix" {
  description = "Map of arn_prefix values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.arn_prefix if v.arn_prefix != null && length(v.arn_prefix) > 0 }
}
output "batch_job_definitions_container_properties" {
  description = "Map of container_properties values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.container_properties if v.container_properties != null && length(v.container_properties) > 0 }
}
output "batch_job_definitions_deregister_on_new_revision" {
  description = "Map of deregister_on_new_revision values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.deregister_on_new_revision if v.deregister_on_new_revision != null }
}
output "batch_job_definitions_ecs_properties" {
  description = "Map of ecs_properties values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.ecs_properties if v.ecs_properties != null && length(v.ecs_properties) > 0 }
}
output "batch_job_definitions_eks_properties" {
  description = "Map of eks_properties values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => one(v.eks_properties) if v.eks_properties != null && length(v.eks_properties) > 0 }
}
output "batch_job_definitions_name" {
  description = "Map of name values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.name if v.name != null && length(v.name) > 0 }
}
output "batch_job_definitions_node_properties" {
  description = "Map of node_properties values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.node_properties if v.node_properties != null && length(v.node_properties) > 0 }
}
output "batch_job_definitions_parameters" {
  description = "Map of parameters values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.parameters if v.parameters != null && length(v.parameters) > 0 }
}
output "batch_job_definitions_platform_capabilities" {
  description = "Map of platform_capabilities values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.platform_capabilities if v.platform_capabilities != null && length(v.platform_capabilities) > 0 }
}
output "batch_job_definitions_propagate_tags" {
  description = "Map of propagate_tags values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.propagate_tags if v.propagate_tags != null }
}
output "batch_job_definitions_region" {
  description = "Map of region values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.region if v.region != null && length(v.region) > 0 }
}
output "batch_job_definitions_retry_strategy" {
  description = "Map of retry_strategy values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => one(v.retry_strategy) if v.retry_strategy != null && length(v.retry_strategy) > 0 }
}
output "batch_job_definitions_revision" {
  description = "Map of revision values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.revision if v.revision != null }
}
output "batch_job_definitions_scheduling_priority" {
  description = "Map of scheduling_priority values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.scheduling_priority if v.scheduling_priority != null }
}
output "batch_job_definitions_tags" {
  description = "Map of tags values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.tags if v.tags != null && length(v.tags) > 0 }
}
output "batch_job_definitions_tags_all" {
  description = "Map of tags_all values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.tags_all if v.tags_all != null && length(v.tags_all) > 0 }
}
output "batch_job_definitions_timeout" {
  description = "Map of timeout values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => one(v.timeout) if v.timeout != null && length(v.timeout) > 0 }
}
output "batch_job_definitions_type" {
  description = "Map of type values across all batch_job_definitions, keyed the same as var.batch_job_definitions"
  value       = { for k, v in aws_batch_job_definition.batch_job_definitions : k => v.type if v.type != null && length(v.type) > 0 }
}

