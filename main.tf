data "aws_vpc" "default" {
  default = true
}
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
data "aws_security_group" "name" {
  vpc_id = data.aws_vpc.default.id
  filter {
    name   = "tag-key"
    values = ["Name"]
  }
  filter {
    name   = "tag-value"
    values = ["chaitanya"]
  }
}
data "aws_ami_ids" "ubuntu_2204" {
  owners = ["099720109477"]
  filter {
    name   = "description"
    values = ["Canonical, Ubuntu, 22.04 LTS, amd64 jammy image build on 2023-02-08"]
  }
  filter {
    name   = "is-public"
    values = ["true"]
  }
}
resource "aws_instance" "web" {
  ami                         = data.aws_ami_ids.ubuntu_2204.ids[0]
  instance_type               = var.
  associate_public_ip_address = true
  key_name                    = var.ec2.key_name
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [data.aws_security_group.name.id]
  tags = {
    "Name" = "provisioner"
  }
}
resource "null_resource" "web" {
  triggers = {
    instance_ids = 0
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./home/ubuntu/.ssh/id_rsa")
    host        = aws_instance.web.public_ip
  }
  provisioner "file" {
    source      = "./ansible.sh"
    destination = "/tmp/ansible.sh"
  }
  # provisioner "file" {
  #   source      = "./onetoten.sh"
  #   destination = "/tmp/onetoten.sh"
  # }
  provisioner "remote-exec" {
    inline = [
      "sh /tmp/ansible.sh",
      "ansible --version"
    ]
  }
  depends_on = [
    aws_instance.web
  ]
}