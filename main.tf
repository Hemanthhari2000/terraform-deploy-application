resource "aws_instance" "web" {
  ami                    = var.aws_ami_id
  instance_type          = var.aws_instance_type
  user_data              = file("user-data.sh")
  vpc_security_group_ids = [aws_security_group.tween_sg.id]
  key_name               = "tween_key"
  tags = {
    Name = "tween-agency-web"
  }
}

resource "aws_security_group" "tween_sg" {
  ingress = [
    {
      cidr_blocks      = ["${var.my_ip}"]
      description      = "SSH from my IP only"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false

      }, {
      cidr_blocks      = ["${var.my_ip}"]
      description      = "HTTP"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
      }, {
      cidr_blocks      = ["${var.my_ip}"]
      description      = "HTTPS"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}

resource "aws_key_pair" "tween_key_pair" {
  key_name   = "tween_key"
  public_key = "<YOUR_PUBLIC_KEY>"
}

output "Info_From_AWS" {
  value = format("%s%s", "ssh -i tween_key_pair ubuntu@", aws_instance.web.public_dns)
}

output "AWS_Instance_URL" {
  value = format("%s%s", "URL: http://", aws_instance.web.public_dns)
}