variable "aws_region" {
  description = "Região AWS para deploy dos recursos"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Nome do ambiente"
  type        = string
  default     = "prod"
}

variable "project_name" {
  description = "Nome do projeto"
  type        = string
  default     = "northwind"
}

variable "db_password" {
  description = "Senha do banco de dados RDS"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Usuário do banco de dados"
  type        = string
  default     = "dbt_user"
}