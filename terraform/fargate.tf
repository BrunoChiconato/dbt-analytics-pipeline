resource "aws_ecs_cluster" "main" {
  name = "${var.project_name}-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }

  tags = {
    Name = "${var.project_name}-cluster"
  }
}

resource "aws_ecr_repository" "dbt" {
  name                 = "${var.project_name}/dbt"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "${var.project_name}-dbt-ecr"
  }
}

resource "aws_ecs_task_definition" "dbt_run" {
  family                   = "${var.project_name}-dbt-run"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution.arn
  task_role_arn           = aws_iam_role.ecs_task.arn

  container_definitions = jsonencode([
    {
      name  = "dbt"
      image = "${aws_ecr_repository.dbt.repository_url}:latest"

      environment = [
        {
          name  = "DBT_PROFILES_DIR"
          value = "/dbt"
        }
      ]

      secrets = [
        {
          name      = "DBT_HOST"
          valueFrom = aws_ssm_parameter.db_host.arn
        },
        {
          name      = "DBT_USER"
          valueFrom = aws_ssm_parameter.db_username.arn
        },
        {
          name      = "DBT_PASSWORD"
          valueFrom = aws_ssm_parameter.db_password.arn
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.dbt.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "dbt"
        }
      }
    }
  ])

  tags = {
    Name = "${var.project_name}-dbt-task"
  }
}

resource "aws_cloudwatch_log_group" "dbt" {
  name              = "/ecs/${var.project_name}/dbt"
  retention_in_days = 7

  tags = {
    Name = "${var.project_name}-dbt-logs"
  }
}

resource "aws_ssm_parameter" "db_host" {
  name  = "/${var.project_name}/db/host"
  type  = "SecureString"
  value = aws_db_instance.postgres.address
}

resource "aws_ssm_parameter" "db_username" {
  name  = "/${var.project_name}/db/username"
  type  = "SecureString"
  value = var.db_username
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/${var.project_name}/db/password"
  type  = "SecureString"
  value = var.db_password
}