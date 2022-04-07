resource "aws_subnet" "public" {
  count  = local.availability_zones_count
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(
    signum(length(var.cidr_block)) == 1 ? var.cidr_block : join("", aws_vpc.vpc.*.cidr_block),
    ceil(log(local.public_subnet_count * var.new_bit, 2)),
    local.public_subnet_count + count.index
  )

  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name                     = join("-", [var.environment, "public", "subnet", var.name, substr(element(var.availability_zones, count.index), 8, 10)])
      "kubernetes.io/role/elb" = "1"
    },
  )

}

