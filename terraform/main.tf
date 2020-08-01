# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

## DECLARE VARIABLES
variable "do_token" {}
variable "github_token" {}
variable "ssh_key" {}

## Web server
resource "digitalocean_droplet" "backend_staging" {
  image  = "docker-18-04" // docker with ubuntu 18.04
  name   = "notes-backend-staging"
  region = "sgp1"
  size   = "s-1vcpu-1gb"
  ssh_keys = [var.ssh_key] // based on twlaptop
  user_data = <<-EOF
              #!/bin/bash
              docker login https://docker.pkg.github.com -u kohrongying -p ${var.github_token}
              sudo docker pull docker.pkg.github.com/kohrongying/notes-backend/notes-backend:latest
              EOF
}

output "public_ipv4" {
  value = digitalocean_droplet.backend_staging.ipv4_address
}