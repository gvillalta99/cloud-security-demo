resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  tags = merge({
    Name = "main"
  }, var.tags)
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge({
    Name = "main"
  }, var.tags)
}
