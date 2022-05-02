resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block                = route.value.cidr_block
      transit_gateway_id        = route.value.transit_gateway_id
      vpc_peering_connection_id = route.value.vpc_peering_connection_id
      network_interface_id      = route.value.network_interface_id
      nat_gateway_id            = route.value.nat_gateway_id
      gateway_id                = route.value.gateway_id
    }
  }


  tags = {
    Name = format("%s-public-rt", local.name)
  }

}


resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  dynamic "route" {
    for_each = var.routes
    content {
      cidr_block                = route.value.cidr_block
      transit_gateway_id        = route.value.transit_gateway_id
      vpc_peering_connection_id = route.value.vpc_peering_connection_id
      network_interface_id      = route.value.network_interface_id
      nat_gateway_id            = route.value.nat_gateway_id
      gateway_id                = route.value.gateway_id
    }
  }

  tags = {
    Name = format("%s-private-rt", local.name)
  }

}


resource "aws_route_table_association" "eks_private_rt_association" {
  count = local.availability_zones_count
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "eks_public_rt_association" {
  count = local.availability_zones_count
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}
