resource "aws_cloudwatch_log_group" "ecs" {
  name              = "/ecs/${var.project_name}-app"
  retention_in_days = 30

  tags = {
    Name        = "${var.project_name}-logs"
    Environment = var.environment
  }
} 
