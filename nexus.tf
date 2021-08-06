resource "aws_instance" "nexus4" {
  ami             = "ami-04db49c0fb2215364"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.example1.id
  security_groups = ["${aws_security_group.nexus4-security-group.id}"]
  key_name        = "${aws_key_pair.petclin.id}"
  user_data       = file("nexus.instlall.sh")
  tags = {
    Name = "nexus4"
  }
}
output "nexus4_endpoint" {
  value = formatlist("/var/lib/nexus4/secrets/initialAdminPassword")
}
resource "aws_security_group" "nexus4-security-group" {
  name        = "nexus4-security-group"
  description = "Allow SSH inbound traffic"
  vpc_id      = "${data.aws_vpc.selected.id}"

  ingress {
    # SSH Port 22 allowed from any IP
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
      # SSH Port 80 allowed from any IP
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





resource "aws_key_pair" "petclin" {
  key_name   = "petclin-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0fnXQU/Kc+QE7OrAOVIx6/RXju86pki8lPBhR8NEHlckkHvmjsIUR2t4Wxjjui2VBFS3tL8iZ+T+SWVVLrLo29Sd1lZjxE3G8div1jEmJ3PYjusWIQ0yIoPxOHsZkBrazT/TIFXhMuiwE9T83Us+z4z2x6HrORUoCH0y1Oiu5wi530vI1Roy3bbCeA0IHjSeLGSA1qZYHBv5aRfqSNoyjjKxzec9qzyvFwvtFgWMxCt++QlHkPjuA+62lln8tZkCoFUQ49wNFN6OcgxYq/TH0/smEkLhQUi7Zb59mJK+sKzeHpbHLHWOyGaiJ51yTHiDCp3sWp/E3EUepnzNnKNd3+jHj5198QadQJTHSsWNlGaymz0jcH4ejIxBNo+TbTIUCK44SpxA+2EgJssddc5XuNv6VVTSMtQe16AVbcBs7ev0RIqGUWbgYou/92GcIlAtS1hir6usAdCGcKgaHdDBs+k/ubI15niem35a6Cb9ZCIh69xkeuwtIBRdbmHac1+8= pjagannadhagowda@LAPTOP-I2JQUQ1P"
}
