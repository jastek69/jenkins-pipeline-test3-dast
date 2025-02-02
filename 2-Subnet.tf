# SUBNETS and ROUTE TABLES

#####################################################################################################
# CALIFORNIA SUBNETS and ROUTE TABLES

resource "aws_subnet" "CA_SUBNET" {
  vpc_id     = aws_vpc.CA_VPC.id
  cidr_block = "10.244.0.0/24"
  availability_zone = "us-west-1a"
  tags = {
    Name = "CA_SUBNET"
    Service = "application1"
    Owner   = "Balactus"
    Planet  = "Taa"
  }
}


resource "aws_subnet" "cali-public-us-west-1a" {     
  vpc_id                  = aws_vpc.CA_VPC.id
  cidr_block              = "10.244.1.0/24"
  availability_zone       = "us-west-1a"
  #map_public_ip_on_launch = true

  tags = {
    Name    = "cali-public-us-west-1a"
    Service = "application1"
    Owner   = "Balactus"
    Planet  = "Taa"
  }
}


resource "aws_subnet" "cali-public-us-west-1b" {    
  vpc_id                  = aws_vpc.CA_VPC.id
  cidr_block              = "10.244.2.0/24"
  availability_zone       = "us-west-1b"
  #map_public_ip_on_launch = true

  tags = {
    Name    = "cali-public-us-west-1b"
    Service = "application1"
    Owner   = "Balactus"
    Planet  = "Taa"
  }
}


#these are for private
resource "aws_subnet" "cali-private-us-west-1a" {  
  vpc_id            = aws_vpc.CA_VPC.id
  cidr_block        = "10.244.11.0/24"
  availability_zone = "us-west-1a"

  tags = {
    Name    = "cali-private-us-west-1a"
    Service = "application1"
    Owner   = "Balactus"
    Planet  = "Taa"
  }
}


resource "aws_subnet" "cali-private-us-west-1b" {  
  vpc_id            = aws_vpc.CA_VPC.id
  cidr_block        = "10.244.12.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name    = "cali-private-us-west-1b"
    Service = "application1"
    Owner   = "Balactus"
    Planet  = "Taa"
  }
}


resource "aws_internet_gateway" "CA_IGW" {     # Internet Gateway ID: aws_internet_gateway.CA_IGW.id
  vpc_id     = aws_vpc.CA_VPC.id

  tags = {
    Name = "CA_IGW"
  }
}


/*

# CALIFORNIA Route Table
resource "aws_route_table" "CA_route_table" {   # Route Table ID: aws_route_table.CA_route_table.
  vpc_id = aws_vpc.CA_VPC.id

  route {
    cidr_block = "10.240.1.0/24" # Route to TOKYO_VPC
    transit_gateway_id = aws_ec2_transit_gateway.ca-tgw.id
    }

  tags = {
    Name = "CA_ROUTE"
  }
}

*/