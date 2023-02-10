variable "env_names" {
  type = list(string)
  default = [
    "dev", "staging", "prod"
  ]
}

variable "list_of_hybrid_items" {
  type = list(any)
  default = [10,"hello", "world", true]
}

