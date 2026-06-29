data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"

  # This script installs Tomcat for you upon startup
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y tomcat
              systemctl start tomcat
              systemctl enable tomcat
              EOF

  tags = {
    Name = "Learning-Tomcat-Server"
  }
}
