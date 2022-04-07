resource "aws_eip" "main" {
  vpc = true

  tags = {
    "Name" = join("-", ["eip", local.name])
  }

}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = join("-", ["ngw", local.name])
  }

}

