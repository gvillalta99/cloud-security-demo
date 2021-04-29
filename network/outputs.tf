output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}
output "public_subnet_cidrs" {
  value = aws_subnet.public.*.cidr_block
}
output "private_app_subnet_cidrs" {
  value = aws_subnet.private_app.*.cidr_block
}
output "private_db_subnet_cidrs" {
  value = aws_subnet.private_db.*.cidr_block
}
