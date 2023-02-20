variable "env_names" {
  type = list(string)
  default = [
    "dev", "staging", "prod"
  ]
}

variable "list_of_hybrid_items" {
  type    = list(any)
  default = [10, "hello", "world", true]
}

variable "image_id" {
  type = string
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["us-west-1a"]
}

variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8300
      external = 8300
      protocol = "tcp"
    }
  ]
}
