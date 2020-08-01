# Set up
Requirements
- Deno
- Docker
- Terraform (to set up infra)

Steps:
1. Create deno backend
2. Create dockerfile and run deno in docker container locally
3. Use terraform to create infra 
4. Use github actions

# Terraform
1. Ensure you have `secrets.tfvars`

```
// secrets.tfvar
do_token = ""
github_token = ""
ssh_key = ""
```
2. `terraform apply -var-file=secrets.tfvars`

# Deployment
## Deploy 

Run Deno in docker container
