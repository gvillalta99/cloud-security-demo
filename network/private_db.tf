resource "aws_subnet" "private_db" {
  count             = length(local.private_db_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_db_subnets[count.index]
  availability_zone = var.availability_zones[count.index % local.azs_count]

  tags = merge({
    Name = "private_db_${count.index}"
    Tier = "Private"
  }, var.tags)
}
resource "aws_route_table" "private_db" {
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name = "private_db"
  }, var.tags)
}
resource "aws_route" "nat" {
  route_table_id         = aws_route_table.private_db.id
  nat_gateway_id         = aws_nat_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"

  depends_on = [aws_route_table.private_db]

  timeouts {
    create = var.aws_route_create_timeout
    delete = var.aws_route_delete_timeout
  }
}
resource "aws_route_table_association" "private_db_subnets" {
  count          = length(local.private_db_subnets)
  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = aws_route_table.private_db.id
}
resource "aws_network_acl" "private_db" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private_db.*.id

  egress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  ingress {
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
  }

  tags = var.tags
}
