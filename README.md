# Hono + Bun + Terraform AWS Infrastructure

This project demonstrates a production-ready setup for deploying a Hono application using Bun runtime on AWS ECS Fargate, with infrastructure managed by Terraform.

## 🚀 Features

- **Hono Web Framework**: Fast, lightweight, and TypeScript-first web framework
- **Bun Runtime**: High-performance JavaScript/TypeScript runtime
- **Infrastructure as Code**: Complete AWS infrastructure using Terraform
- **Production Ready**: Includes load balancing, auto-scaling, and HTTPS
- **CloudFlare Integration**: DNS management and additional security features

## 🛠 Prerequisites

- [Bun](https://bun.sh) installed locally
- [Docker](https://www.docker.com/get-started) installed
- [Terraform](https://www.terraform.io/downloads.html) installed
- AWS CLI configured with appropriate credentials
- Cloudflare account and API token (for DNS management)

## 📦 Local Development

1. Install dependencies:
```sh
bun install
```

2. Start the development server:
```sh
bun run dev
```

3. Open http://localhost:3000 in your browser

## 🏗 Infrastructure Setup

1. Copy the example Terraform variables file:
```sh
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
```

2. Update `terraform.tfvars` with your values:
```hcl
cloudflare_api_token = "your-token"
cloudflare_zone_id   = "your-zone-id"
domain_name          = "your-domain.com"
aws_region           = "your-preferred-region"
project_name         = "your-project-name"
environment          = "production"
```

3. Initialize Terraform:
```sh
cd terraform
terraform init
```

4. Deploy the infrastructure:
```sh
terraform plan    # Review the changes
terraform apply   # Apply the changes
```

## 🚢 Deployment

The deployment process is fully automated through Terraform. After applying the Terraform configuration, the application will be automatically deployed to ECS Fargate. Any subsequent updates can be deployed by:

1. Making your code changes
2. Running `terraform apply` in the terraform directory

Terraform will handle:
- Building and pushing the Docker image to ECR
- Updating the ECS service with the new image
- Managing the deployment rollout

> **Note**: While this demo uses Terraform to build and push Docker images for simplicity, in a production environment it's recommended to handle image building and pushing through a proper CI/CD pipeline (like GitHub Actions, GitLab CI, or AWS CodePipeline). This separation of concerns allows for better versioning, testing, and deployment strategies.

## 🏛 Architecture

- **VPC**: Isolated network with public and private subnets
- **ECS Fargate**: Serverless container orchestration
- **Application Load Balancer**: HTTP/HTTPS traffic handling
- **CloudFlare**: DNS management, SSL/TLS, and security features
- **ECR**: Docker image repository
- **CloudWatch**: Logging and monitoring
- **S3**: Load balancer access logs storage

## 🔒 Security Features

- HTTPS-only traffic
- CloudFlare security headers
- Private subnets for containers
- Security groups for fine-grained access control
- SSL/TLS certificate management
- Load balancer access logging

## 📝 Environment Variables

The following environment variables are available to the application:

- `NODE_ENV`: Set automatically based on environment
- `DEPLOYMENT_TIMESTAMP`: Set automatically during deployment

## 🧪 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
