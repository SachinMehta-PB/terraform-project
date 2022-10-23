resource "aws_key_pair" "terraformkey" {
  key_name = "terraformkey"
  public_key = file(var.PUB_KEY_PATH)
}