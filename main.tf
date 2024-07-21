# VPC
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"  # Updated to a larger CIDR block to accommodate more subnets

  tags = {
    Name = "my-vpc"
  }
}

# Subnets
resource "aws_subnet" "web_subnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.0.0/24"  # Unique CIDR block for web subnet
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "web-subnet"
  }
}

resource "aws_subnet" "app_subnet" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = "10.0.1.0/24"  # Unique CIDR block for app subnet
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "app-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "my-igw"
  }
}

# Route Table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "my-route-table"
  }
}

resource "aws_route_table_association" "web_subnet_association" {
  subnet_id      = aws_subnet.web_subnet.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "app_subnet_association" {
  subnet_id      = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.rt.id
}

# Security Groups
resource "aws_security_group" "web_sg" {
  name   = "web_sg"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "Allow HTTP traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH traffic"
    from_port   = 22
    to_port     = 22
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
    Name = "web-sg"
  }
}

resource "aws_security_group" "app_sg" {
  name   = "app_sg"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    description = "Allow HTTP traffic"
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

  tags = {
    Name = "app-sg"
  }
}

# S3 Bucket (Optional)
resource "aws_s3_bucket" "example" {
  bucket = "devpayanshaldp1012"

  tags = {
    Name = "my-s3-bucket"
  }
}


# Database Subnet Group
resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "db-subnet-group"
  subnet_ids  = [aws_subnet.web_subnet.id, aws_subnet.app_subnet.id]
  description = "Database subnet group"

  tags = {
    Name = "db-subnet-group"
  }
}

# EC2 Instances (Web Tier)
resource "aws_instance" "web_instance1" {
  ami                    = "ami-04a81a99f5ec58529"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = aws_subnet.web_subnet.id
  user_data              = base64encode(file("web_userdata.sh"))

  tags = {
    Name = "web-instance-1"
  }
}

resource "aws_instance" "web_instance2" {
  ami                    = "ami-04a81a99f5ec58529"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  subnet_id              = aws_subnet.web_subnet.id
  user_data              = base64encode(file("web_userdata.sh"))

  tags = {
    Name = "web-instance-2"
  }
}

# EC2 Instances (Application Tier)
resource "aws_instance" "app_instance" {
  ami                    = "ami-04a81a99f5ec58529"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  subnet_id              = aws_subnet.app_subnet.id
  user_data              = base64encode(file("app_userdata.sh"))

  tags = {
    Name = "app-instance"
  }
}
resource "aws_db_instance" "mydb" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.44"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "yourpassword"
  parameter_group_name = "default.mysql5.7"
  backup_retention_period = 7
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.app_sg.id]
  db_subnet_group_name  = aws_db_subnet_group.db_subnet_group.name

  tags = {
    Name = "mydb"
  }
}


# Application Load Balancer
resource "aws_lb" "myalb" {
  name               = "myalb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.web_sg.id]
  subnets         = [aws_subnet.web_subnet.id, aws_subnet.app_subnet.id]

  tags = {
    Name = "my-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "myTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }

  tags = {
    Name = "my-tg"
  }
}

resource "aws_lb_target_group_attachment" "web_instance1_attachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.web_instance1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web_instance2_attachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.web_instance2.id
  port             = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"
  }
}

# Outputs
output "load_balancer_dns" {
  value = aws_lb.myalb.dns_name
}

output "database_endpoint" {
  value = aws_db_instance.mydb.endpoint
}
