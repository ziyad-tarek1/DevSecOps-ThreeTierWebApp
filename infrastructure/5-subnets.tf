
///////////////////// Private subnets ///////////////////////////////////
resource "aws_subnet" "private_zone1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.1.0/24"
    availability_zone = var.zone1

    tags = {

        Name = "${var.project_name}-sub1-private" 
        "kubernetes.io/cluster/${var.eks_name}" = "shared"
        "kubernetes.io/role/internal-elb"           = "1"
     // "kubernetes.io/role/elb"                    = "1"
    }  
}

resource "aws_subnet" "private_zone2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = var.zone2

    tags = {

        Name = "${var.project_name}-sub2-private" 
        "kubernetes.io/cluster/${var.eks_name}" = "shared"
        "kubernetes.io/role/internal-elb"           = "1"
     // "kubernetes.io/role/elb"                    = "1"
    }  
}



///////////////////// Public subnets ///////////////////////////////////
resource "aws_subnet" "public_zone1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.3.0/24"
    availability_zone = var.zone1
    map_public_ip_on_launch = true

    tags = {

        Name = "${var.project_name}-sub1-public" 
        "kubernetes.io/cluster/${var.eks_name}" = "shared"
        //"kubernetes.io/role/internal-elb"           = "1"
        "kubernetes.io/role/elb"                    = "1"
    }  
}

resource "aws_subnet" "public_zone2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.4.0/24"
    availability_zone = var.zone2
    map_public_ip_on_launch = true

    tags = {

        Name = "${var.project_name}-sub1-public" 
        "kubernetes.io/cluster/${var.eks_name}" = "shared"
       // "kubernetes.io/role/internal-elb"           = "1"
        "kubernetes.io/role/elb"                    = "1"
    }  
}


