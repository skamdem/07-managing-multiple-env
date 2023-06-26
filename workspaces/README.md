# Managing multiple environments through workspaces  

> This project, a basic web app behind a load balancer, originates from [here](https://github.com/sidpalas/devops-directive-terraform-course "devops directive terraform course").

> The project is organized around multiple active workspaces
> "dev", "staging" and "production" 

## List of commands:

```
$ terraform workspace new production
$ terraform workspace list
$ terraform workspace select staging
$ terraform init
$ terraform validate
$ terraform fmt
$ terraform plan
$ terraform apply
$ terraform init -upgrade // after updating "required_providers"
$ terraform destroy // cleanup on project completion
```