output "api_gateway_url" {
  value = "https://api.${var.domain_name}"
}

output "ecr_repository_url" {
  value = aws_ecr_repository.app.repository_url
}

output "docker_login_command" {
  value = "aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.app.repository_url}"
}

output "docker_build_command" {
  value = "docker build -t ${aws_ecr_repository.app.repository_url}:latest ."
}

output "docker_push_command" {
  value = "docker push ${aws_ecr_repository.app.repository_url}:latest"
}

output "all_docker_commands" {
  value = <<EOF
# Login to ECR:
aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${aws_ecr_repository.app.repository_url}

# Build the image:
docker build -t ${aws_ecr_repository.app.repository_url}:latest .

# Push the image:
docker push ${aws_ecr_repository.app.repository_url}:latest
EOF
} 
