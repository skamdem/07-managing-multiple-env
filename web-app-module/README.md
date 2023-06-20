# Web app child module 

> This project, a basic web app behind a load balancer, originates from [here](https://github.com/sidpalas/devops-directive-terraform-course "devops directive terraform course").

> The child module "web-app-module" herein is called out from the root module "web-app"


> It involves the following elements:
> - Remote backend & provider config
> - Route 53 hosted zone
> - Load balancer
> - EC2 instances
> - RDS DB instances
 

## List of commands:

```
$ terraform init
$ terraform validate
$ terraform fmt
$ terraform plan
$ terraform apply
$ terraform init -upgrade // after updating "required_providers"
$ terraform destroy // cleanup on project completion
```
***
## Files configuration : 

| Fine name | Contents |
| ------------ | ------------- |
| aws_resources.tf | resources |
| config.tf | terraform setup |
| outputs.tf | outputs |
| providers_and_modules.tf | list of providers and modules |
| terraform.tfvars | actual values of variable |
| variables.tf | variables definition |
