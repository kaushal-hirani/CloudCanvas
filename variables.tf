variable "ports" {
  description = "Give the port numbers to use in security group"
  type        = list(number)
}

variable "cidr" {
  description = "provide the cidr range to use in security group"
  type        = string
}