data "aws_security_groups" "lb" {
  tags = {
    Role = "load_balancer"
  }
}

data "aws_security_groups" "app" {
  tags = {
    Role = "application"
  }
}
