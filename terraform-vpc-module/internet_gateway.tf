resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = format("%s-internet-gateway", local.name)
  }

}

