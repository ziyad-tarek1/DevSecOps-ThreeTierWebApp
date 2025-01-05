variable "region" {
    default = "us-east-1"
}

variable "project_name" {
    default = "EKS"
}

variable "eks_name" {
    default = "my-eks"
}

variable "vpc_cidr_block" {
    default = "10.0.0.0/16"
}

variable "zone1" {
    default = "us-east-1a"
}

variable "zone2" {
    default = "us-east-1b"
}
