data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
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
