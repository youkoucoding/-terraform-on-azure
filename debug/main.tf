output "envs" {
  value = var.env_names
}


output "out" {
  value     = var.availability_zone_names
  sensitive = true
}


output "out_nonsensitive" {
  value     = var.docker_ports
  sensitive = false
}
