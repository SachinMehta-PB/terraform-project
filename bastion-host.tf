resource "aws_instance" "terraform-bastion" {
  ami = lookup(var.AMIS, var.AWS_REGION )
  instance_type = "t2.micro"
  key_name = aws_key_pair.terraformkey.key_name
  subnet_id = module.vpc.public_subnets[0]
  count = var.instance_count
  vpc_security_group_ids = [aws_security_group.terraform-bastion-sg.id]

  tags = {
    Name = "Terraform-bastion"
    PROJECT  = "Terraform"
  }

  provisioner "file" {
    content = templatefile("db-deploy.tmpl", {rds-endpoint = aws_db_instance.terraform-rds.address, dbuser = var.dbuser, dbpass = var.dbpass})
    destination = "/tmp/vprofile-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vprofile-dbdeploy.sh",
      "sudo /tmp/vprofile-dbdeploy.sh"
    ]
  }

  connection {
    user = var.USERNAME
    private_key =  file(var.PRIV_KEY_PATH)
    host = self.public_ip
  }
  depends_on = [aws_db_instance.terraform-rds]
}