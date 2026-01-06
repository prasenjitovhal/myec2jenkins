data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-kernel-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_instance" "jenkins_demo" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"  # Free tier eligible

  tags = {
    Name = "Terraform-Jenkins-GitHub-EC2"
  }
}

output "instance_public_ip" {
  value = aws_instance.jenkins_demo.public_ip
}