variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "domain_name" {
  description = "Base domain name (e.g., yourdomain.com)"
  type        = string
}

variable "project_name" {
  description = "Project name used in resource naming"
  type        = string
  default     = "hono-terraform"
}

variable "container_port" {
  description = "Port the container exposes"
  type        = number
  default     = 3000
}

variable "ecs_task_cpu" {
  description = "CPU units for the ECS task"
  type        = number
  default     = 256
}

variable "ecs_task_memory" {
  description = "Memory (MB) for the ECS task"
  type        = number
  default     = 512
}

variable "ecs_service_desired_count" {
  description = "Desired number of ECS tasks"
  type        = number
  default     = 2
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "environment" {
  description = "Environment name (e.g., prod, staging)"
  type        = string
  default     = "prod"
}

variable "aws_profile" {
  description = "AWS credentials profile to use"
  type        = string
  default     = "default"
}

variable "dockerfile_path" {
  description = "Path to the directory containing Dockerfile"
  type        = string
  default     = "../"  # Assumes Dockerfile is in the parent directory
}

