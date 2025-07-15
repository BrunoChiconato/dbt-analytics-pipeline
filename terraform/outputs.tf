output "rds_endpoint" {
  description = "Endpoint do banco de dados RDS"
  value       = aws_db_instance.postgres.endpoint
  sensitive   = true
}

output "ecr_repository_url" {
  description = "URL do repositório ECR"
  value       = aws_ecr_repository.dbt.repository_url
}

output "dbt_docs_website_endpoint" {
  description = "URL da documentação dbt"
  value       = aws_s3_bucket_website_configuration.dbt_docs.website_endpoint
}

output "ecs_cluster_name" {
  description = "Nome do cluster ECS"
  value       = aws_ecs_cluster.main.name
}

output "ecs_task_definition_arn" {
  description = "ARN da task definition"
  value       = aws_ecs_task_definition.dbt_run.arn
}

output "vpc_id" {
  description = "ID da VPC"
  value       = aws_vpc.main.id
}