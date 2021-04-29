resource "aws_subnet" "private_app" {
  count             = length(local.private_app_subnets)
  vpc_id            = aws_vpc.main.id
  cidr_block        = local.private_app_subnets[count.index]
  availability_zone = var.availability_zones[count.index % local.azs_count]

  tags = merge({
    Name = "private_app-${count.index}"
    Tier = "Private_App"
  }, var.tags)
}
resource "aws_route_table" "private_app" {
  vpc_id = aws_vpc.main.id

  tags = merge({
    Name = "private_app"
  }, var.tags)
}
resource "aws_route" "private_app_nat" {
  route_table_id         = aws_route_table.private_app.id
  nat_gateway_id         = aws_nat_gateway.main.id
  destination_cidr_block = "0.0.0.0/0"

  depends_on = [aws_route_table.private_app]

  timeouts {
    create = var.aws_route_create_timeout
    delete = var.aws_route_delete_timeout
  }
}
resource "aws_route_table_association" "private_app-subnets" {
  count          = length(local.private_app_subnets)
  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private_app.id
}
resource "aws_network_acl" "private_app" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = aws_subnet.private_app.*.id

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
