variable "env_name" {
  description = "Environment name"
}

data "aws_ecr_repository" "sqs_consumer_ecr_repo" {
  name = "sqs_consumer"
}

resource "aws_lambda_function" "sqs_consumer_function" {
  function_name = "sqs_consumer-${var.env_name}"
  timeout       = 5 # seconds
  image_uri     = "${data.aws_ecr_repository.sqs_consumer_ecr_repo.repository_url}:latest"
  package_type  = "Image"

  role = aws_iam_role.sqs_consumer_function_role.arn

  environment {
    variables = {
      ENVIRONMENT = var.env_name
    }
  }
}

resource "aws_iam_role" "sqs_consumer_function_role" {
  name = "sqs_consumer-${var.env_name}"

  assume_role_policy = jsonencode({
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })
}