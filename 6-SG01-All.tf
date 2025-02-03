#Target Group for Port 80 app

#California Security Group
resource "aws_security_group" "ec2-cali-sg80" {
  provider = aws.california
  vpc_id = aws_vpc.CA_VPC.id 
  /*
  tags = {
    Name = "cali-sg"
  } 
  */

  # Allow HTTP access from anywhere for testing (consider restricting later)
  ingress {
    description = "MyHomePage"
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } 


  # Allow all outbound traffic for simplicity (consider restricting later)
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name    = "ec2-cali-sg80"
    # Name: "${var.env_prefix}-sg-80"
    Service = "web-application"
    Owner   = "Balactus"
    Planet  = "Taa"
  }
}


# CALIFORNIA Port 443 Security Group for Load Balancer 443 - add ingress for 443
resource "aws_security_group" "cali-LB01-sg443" {
  provider         = aws.california
  name        = "ca_LB01-SG01-443"
  description = "ec2-cali-sg443"
  vpc_id      = aws_vpc.CA_VPC.id

  ingress {
    description = "MyHomePage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Secure"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "ec2-cali-sg443"
    Service = "application1"
    Owner   = "Blackneto"
    Planet  = "Taa"
  }

}



# CALIFORNIA Port 443 Security Group for Syslog Server 443 - add ingress for 443
resource "aws_security_group" "ca_SL01-SG01-443" {
  provider         = aws.california
  name        = "ca_SL01-SG01-443"
  description = "ca_SL01-SG01-443"
  vpc_id      = aws_vpc.CA_VPC.id

  ingress {
    description = "MyHomePage"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Secure"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "ca_SL01-SG01-443"
    Service = "application1"
    Owner   = "Blackneto"
    Planet  = "Taa"
  }

}
