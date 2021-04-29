resource "aws_eip" "nat" {
  vpc = true

  tags = merge({
    Name = "nat"
  }, var.tags)

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = element(aws_subnet.public.*.id, 0)

  tags = merge({
    Name = "main"
  }, var.tags)

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_internet_gateway.main]
}
