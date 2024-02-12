# Internet VPC

resource "aws_vpc" "main" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "default"
    enable_dns_support = "${var.enable_dns_support}"
    enable_dns_hostnames = "${var.enable_dns_hostname}"
    tags = {
      Name = "main-${var.VPCTag}"
      CreatedWith = "terraform"
    }
  
}

resource "aws_subnet" "main-public-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "${var.cidr_public_1}"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.region}a"
    tags = {
        Name = "tagal-jfrog-public-1"
        CreatedWith = "terraform"
        "kubernetes.io/role/internal-elb" = "1"
        "kubernetes.io/cluster/tagal-eks" = "${var.EKSPrivacy}"
    }
  
}

resource "aws_subnet" "main-public-2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "${var.cidr_public_2}"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.region}b"
    tags = {
        Name = "tagal-jfrog-public-2"
        CreatedWith = "terraform"
        "kubernetes.io/role/internal-elb" = "1"
        "kubernetes.io/cluster/tagal-eks" = "${var.EKSPrivacy}"
    }
  
}

resource "aws_subnet" "main-public-3" {
    vpc_id = aws_vpc.main.id
    cidr_block = "${var.cidr_public_3}"
    map_public_ip_on_launch = "true"
    availability_zone = "${var.region}c"
    tags = {
        Name = "tagal-jfrog-public-3"
        CreatedWith = "terraform"
        "kubernetes.io/role/internal-elb" = "1"
        "kubernetes.io/cluster/tagal-eks" = "${var.EKSPrivacy}"
    }
  
}

resource "aws_subnet" "main-private-1" {
    vpc_id = aws_vpc.main.id
    cidr_block = "${var.cidr_private_1}"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.region}a"
    tags = {
        Name = "tagal-jfrog-private-1"
        CreatedWith = "terraform"
        "kubernetes.io/role/internal-elb" = "1"
        "kubernetes.io/cluster/tagal-eks" = "${var.EKSPrivacy}"
    }
  
}

resource "aws_subnet" "main-private-2" {
    vpc_id = aws_vpc.main.id
    cidr_block = "${var.cidr_private_2}"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.region}b"
    tags = {
        Name = "tagal-jfrog-private-2"
        CreatedWith = "terraform"
        "kubernetes.io/role/internal-elb" = "1"
        "kubernetes.io/cluster/tagal-eks" = "${var.EKSPrivacy}"
    }
  
}

resource "aws_subnet" "main-private-3" {
    vpc_id = aws_vpc.main.id
    cidr_block = "${var.cidr_private_3}"
    map_public_ip_on_launch = "false"
    availability_zone = "${var.region}c"
    tags = {
        Name = "tagal-jfrog-private-3"
        CreatedWith = "terraform"
        "kubernetes.io/role/internal-elb" = "1"
        "kubernetes.io/cluster/tagal-eks" = "${var.EKSPrivacy}"
    }
  
}


# internet GW
resource "aws_internet_gateway" "main-gw" {
    vpc_id = aws_vpc.main.id
    tags = {
        Name = "${var.GWTag}"
        CreatedWith = "terraform"
    }
  
}

# public route table

resource "aws_route_table" "main-public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.main-gw.id
    }
    tags = {
        Name = "${var.PublicRouteTag}"
        CreatedWith = "terraform"
    }

}

resource "aws_route_table_association" "main-public-1a" {
    subnet_id = aws_subnet.main-public-1.id
    route_table_id = aws_route_table.main-public.id
  
}

resource "aws_route_table_association" "main-public-2a" {
    subnet_id = aws_subnet.main-public-2.id
    route_table_id = aws_route_table.main-public.id
  
}

resource "aws_route_table_association" "main-public-3a" {
    subnet_id = aws_subnet.main-public-3.id
    route_table_id = aws_route_table.main-public.id
  
}