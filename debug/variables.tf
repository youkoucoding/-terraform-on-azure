variable "env_names" {
  type = list(string)
  default = [
    "dev", "staging", "prod"
  ]

}