packer {
  required_plugins {
    amazon = {
      version = " >= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "packer" {
  ami_name      = "golden-image {{timestamp}}"
  instance_type = "t2.micro"
  region        = "us-east-2"
  source_ami = "ami-037774efca2da0726"
  ssh_username = "ec2-user"
  ssh_private_key_file =  "~/.ssh/id_rsa"
  ssh_keypair_name = "packer-key"

  ami_users = [
      "976193233362",
      "976193233363"  ]

}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.packer"
  ]

  provisioner "shell" {
      script = "script.sh"
  }

}