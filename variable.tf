variable "aws_ami_id" {
  type    = string
  default = "ami-0aa2b7722dc1b5612" # Ubuntu ami id
}

variable "aws_instance_type" {
  type    = string
  default = "t2.micro"
}

variable "my_ip" {
  type        = string
  description = "My Public IP Address"
  default     = "<YOUR_PUBLIC_IP_ADDRESS>/32"
}