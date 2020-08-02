# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

## DECLARE VARIABLES
variable "do_token" {}
variable "github_token" {}
variable "ssh_key_id" {}
variable "public_key" {}

## Web server
resource "digitalocean_droplet" "backend_staging" {
  image  = "docker-18-04" // docker with ubuntu 18.04
  name   = "notes-backend-staging"
  region = "sgp1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [var.ssh_key_id] // based on twlaptop
  user_data = <<-EOF
              #!/bin/bash
              echo ${var.public_key} >> ~/.ssh/authorized_keys
              docker login https://docker.pkg.github.com -u kohrongying -p ${var.github_token}
              sudo docker pull docker.pkg.github.com/kohrongying/notes-backend/notes-backend:staging
              docker run -d -p 80:8000 docker.pkg.github.com/kohrongying/notes-backend/notes-backend:staging
              EOF
}

resource "digitalocean_droplet" "backend_prod" {
  image  = "docker-18-04" // docker with ubuntu 18.04
  name   = "notes-backend-prod"
  region = "sgp1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [var.ssh_key_id] // based on twlaptop
  user_data = <<-EOF
              #!/bin/bash
              echo ${var.public_key} >> ~/.ssh/authorized_keys
              docker login https://docker.pkg.github.com -u kohrongying -p ${var.github_token}
              sudo docker pull docker.pkg.github.com/kohrongying/notes-backend/notes-backend:v0.2
              docker run -d -p 80:8000 docker.pkg.github.com/kohrongying/notes-backend/notes-backend:v0.2 
              EOF
}

output "staging_ip" {
  value = digitalocean_droplet.backend_staging.ipv4_address
}

output "prod_ip" {
  value = digitalocean_droplet.backend_prod.ipv4_address
}