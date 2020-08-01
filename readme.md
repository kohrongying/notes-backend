# Set up
Requirements
- Deno
- Docker
- Terraform (to set up infra)

Steps:
1. Create deno backend (simple api)
2. Create dockerfile and run deno in docker container locally: 
```
docker build . -t web
docker run -p 8000:8000 web:latest

// go to your localhost:8000/todos
```
3. Use terraform to create infra 
4. Use github actions

# Terraform
1. Ensure you have `secrets.tfvars`

```
// secrets.tfvar
do_token = ""
github_token = ""
ssh_key_id = ""
public_key = ""
```
2. `terraform apply -var-file=secrets.tfvars`

# Deployment
## Deploy 

Run Deno in docker container
