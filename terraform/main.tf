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
              echo "deb [trusted=yes] https://apt.fury.io/caddy/ /" | sudo tee -a /etc/apt/sources.list.d/caddy-fury.list
              sudo apt update
              sudo apt install caddy
              docker login https://docker.pkg.github.com -u kohrongying -p ${var.github_token}
              sudo docker pull docker.pkg.github.com/kohrongying/notes-backend/notes-backend:latest
              docker run -d -p 8000:80 docker.pkg.github.com/kohrongying/notes-backend/notes-backend:latest 
              EOF
}

output "public_ipv4" {
  value = digitalocean_droplet.backend_staging.ipv4_address
}