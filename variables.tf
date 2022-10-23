variable "AWS_REGION" {
  default = "us-east-2"
}

variable "AMIS" {
  type = map
  default = {
    us-east-2="ami-0d5bf08bc8017c83b"
    ap-south-1="ami-024c319d5d14b463e"
  }
}

variable "PRIV_KEY_PATH" {
  default = "terraformkey"
}

variable "PUB_KEY_PATH" {
  default = "terraformkey.pub"
}

variable "USERNAME" {
  default = "ubuntu"
}

variable "MYIP" {
  default = "183.83.39.124/32"
}

variable "rmquser" {
  default = "rabbit"
}

variable "rmqpass" {
  default = "Rabbit1234567890@"
}

variable "dbuser" {
  default = "admin"
}

variable "dbpass" {
  default = "admin123"
}

variable "dbname" {
  default = "accounts"
}

variable "instance_count" {
  default = "1"
}

variable "VPC_NAME" {
  default = "terraform-VPC"
}

variable "Zone1" {
  default = "us-east-2a"
}

variable "Zone2" {
  default = "us-east-2b"
}

variable "Zone3" {
  default = "us-east-2c"
}

variable "VPC_CIDR" {
  default = "172.21.0.0/16"
}

variable "PubSub1cidr" {
  default = "172.21.1.0/24"
}

variable "PubSub2cidr" {
  default = "172.21.2.0/24"
}

variable "PubSub3cidr" {
  default = "172.21.3.0/24"
}

variable "PrivSub1cidr" {
  default = "172.21.4.0/24"
}

variable "PrivSub2cidr" {
  default = "172.21.5.0/24"
}

variable "PrivSub3cidr" {
  default = "172.21.6.0/24"
}