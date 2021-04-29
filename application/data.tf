data "aws_security_groups" "lb" {
  tags = {
    Role = "load_balancer"
  }
}
