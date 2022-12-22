# Terraform's major benifits

> Visibility
> Stability
> Scalability
> Security
> Audit

1. Terraform can be used to follow DevOps best practices such as version control, code reviews, continous integration, automated testing and continous deployment in a secure and safe manner.
2. Simple to use - Terraform is a very easy tool to pick up and learn.
3. Self Documenting.
4. Cloud agnostic - NOT true about this. The various Clouds APIs are different, thus you could not switch out an AWS resource for a Azure resource without having to rewrite the code.
5. Mudules - Terraform has the concept of modules meaning you can group multiple resources together to create a reusable module, which allows your code stay dry.
6. State - When a Terraform resource is created, it creates a state for that resource is then tracked and managed within the platform.
7. Workspaces

# Tools installation

> [Install Terraform | Terraform | HashiCorp Developer](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## macos

```
brew tap hashicorp/tap

brew install hashicorp/tap/terraform
```
