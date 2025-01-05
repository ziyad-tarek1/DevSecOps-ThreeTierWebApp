resource "aws_vpc" "main" { 
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = { 
    Name = "${var.project_name}-VPC" 
    "kubernetes.io/cluster/${var.eks_name}" = "shared"

  } 
}