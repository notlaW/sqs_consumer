# sqs_consumer

Revolutionizing consuming json and passing it down as json.


## Terraform Deploy
From the TF folder run these commands
### Init Terraform

```
$ terraform init
```

### Create Repo

Create this first as a separate resouce so it doesn't get accidentally destroyed.

```
$ terraform apply -target="module.ecr_repo"
```

### Create Lambda Resources
```
$ terraform apply
```

## Docker
### Build Docker image and Push to ECR

```
$ make docker/push TAG=dev
```