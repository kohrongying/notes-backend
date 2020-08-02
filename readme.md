![Deploy to prod](https://github.com/kohrongying/notes-backend/workflows/Deploy%20to%20prod/badge.svg) ![Deploy to staging](https://github.com/kohrongying/notes-backend/workflows/Deploy%20to%20staging/badge.svg) ![Create release](https://github.com/kohrongying/notes-backend/workflows/Create%20release/badge.svg)

# Set up
Requirements
- Deno
- Docker
- Terraform (to set up infra)

Steps:
1. Create deno backend (simple api)
2. Create dockerfile and test if you can run deno in docker container locally: 
```
docker build . -t web
docker run -p 8000:8000 web:latest

// go to your localhost:8000/todos
```
3. Use terraform to create infrastructure 
4. Use github actions

# Terraform
1. Ensure you have `secrets.tfvars`

```
// secrets.tfvar
do_token = ""       // Get from DO 
github_token = ""   // Get from Github personal access token
ssh_key_id = ""     // Get from Github API
public_key = ""     // Generate a pair yourself
```

2. Run terraform commands:
```
terraform init
terraform apply -var-file=secrets.tfvars`
```

3. Output:
A server with some pre-configured configurations
- Logging into the docker registry with the github token
- Adding the public key into `authorized_keys`. This key is the one where github actions will use to remote access

# Deployment
## CI/CD with Docker and Github Actions
In layman terms of the github workflow

#### Triggered by: On commit / PR
1. Job #1: push_to_registry
- Checkout the repository
- Build the app using the `Dockerfile`
- Tag and push it to github packages

2. Job #2: update_server_image 
- Remote ssh into server
- Pull latest image 
- Stop current container and restart it in background

Go to Settings > Secrets and add the following secrets: 
1. `PRIVATE_KEY`
2. `PROD_HOST`
3. `STAGING_HOST`

Where the host follows `<username@<ip-address>`