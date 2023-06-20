# compute instances of aws provider

resource "aws_instance" "instance_1" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  tags = {
    Name        = "${var.app_name}-${var.environment_name}"
    "Terraform" = "Yes"
  }

  security_groups = [aws_security_group.instances_sg.name]
  user_data       = <<-EOF
            #!bin/bash
            echo "Hello from instance ONE" > index.html
            python3 -m http.server 8080 &
            EOF
}

resource "aws_instance" "instance_2" {
  ami           = var.instance_ami
  instance_type = var.instance_type
  tags = {
    Name        = "${var.app_name}-${var.environment_name}"
    "Terraform" = "Yes"
  }

  security_groups = [aws_security_group.instances_sg.name]
  user_data       = <<-EOF
            #!bin/bash
            echo "Hello from instance TWO" > index.html
            python3 -m http.server 8080 &
            EOF
}
