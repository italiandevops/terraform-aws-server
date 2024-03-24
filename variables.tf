###################################################
# VPC
###################################################

variable "vpc_cidr" {
    default       = "10.0.0.0/16"
    description   = "VPC CIDR Block"
    type          = string
}
variable "public_subnet_az1_cidr" {
    default       = "10.0.0.0/24"
    description   = "Public Subnet 1 CIDR Block"
    type          = string
}

###################################################
# INSTANCE
###################################################

variable "ami" {
    type = string
    default = "ami-023adaba598e661ac" # Ubuntu 22.04 (Datacenter Francoforte)
}
variable "type" {
    type = string
    default = "t2.micro" # Free tier
}

variable "key" {
    type = string
    default = "aws"
}
variable "name" {
    type = string
    default = "server"
}

###################################################
# PROVIDERS
###################################################

variable "region" {
    type = string
    description   = "AWS Region"
    default = "eu-central-1"
}

