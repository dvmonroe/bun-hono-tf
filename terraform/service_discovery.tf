resource "aws_service_discovery_private_dns_namespace" "this" {
  name        = "internal"
  vpc         = aws_vpc.main.id
  description = "Private DNS namespace for ECS services"
}

resource "aws_service_discovery_service" "app" {
  name = "${var.project_name}-app"

  dns_config {
    namespace_id = aws_service_discovery_private_dns_namespace.this.id

    dns_records {
      ttl  = 10
      type = "A"
    }

    routing_policy = "MULTIVALUE"
  }

  health_check_custom_config {
    failure_threshold = 1
  }
} 
