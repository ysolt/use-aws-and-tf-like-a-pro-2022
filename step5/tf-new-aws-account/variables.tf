variable "parent_id" {
  type = string
}

variable "accounts" {
  type        = list(map(string))
  description = "The list of accounts being created"
}