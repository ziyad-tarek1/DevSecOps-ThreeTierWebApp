resource "aws_eip" "nat" {
    domain = "vpc"
    tags = {
        Name = "${var.project_name}-nat"
    }
}


resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.nat.id 
    subnet_id = aws_subnet.public_zone1.id
    tags = {

      Name = "${var.project_name}-nat" 

    }
    depends_on = [ aws_internet_gateway.gw ]
  
}