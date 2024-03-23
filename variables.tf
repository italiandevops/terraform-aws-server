
# INSTANCE
variable "ami" {
    type = string
    default = "ami-023adaba598e661ac" # Ubuntu 22.04 (Francoforte)
}
variable "type" {
    type = string
    default = "t2.micro"
}

variable "key" {
    type = string
    default = "aws"
}
variable "name" {
    type = string
    default = "server"
}

# PROVIDERS
variable "region" {
    type = string
    default = "eu-central-1"
}

