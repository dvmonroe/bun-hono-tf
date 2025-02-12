resource "null_resource" "docker_build_push" {
  triggers = {
    task_definition_hash = sha256(jsonencode(aws_ecs_task_definition.app.container_definitions))
    force_rebuild       = timestamp()
  }

  provisioner "local-exec" {
    working_dir = var.dockerfile_path
    command = <<EOF
      aws ecr get-login-password --region ${var.aws_region} --profile ${var.aws_profile} | docker login --username AWS --password-stdin ${aws_ecr_repository.app.repository_url}
      docker build -t ${aws_ecr_repository.app.repository_url}:latest .
      docker push ${aws_ecr_repository.app.repository_url}:latest
    EOF
  }

  depends_on = [
    aws_ecr_repository.app
  ]
}

resource "null_resource" "ecs_service_dependency" {
  depends_on = [
    null_resource.docker_build_push
  ]
} 
