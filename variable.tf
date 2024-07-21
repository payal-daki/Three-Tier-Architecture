# AWS Region
variable "region" {
  description = "The AWS region where resources will be created"
  default     = "us-east-1"
}

# VPC Configuration
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/24"
}

# Subnet Configuration
variable "web_subnet_cidr" {
  description = "CIDR block for the Web Subnet"
  default     = "10.0.1.0/24"
}

variable "app_subnet_cidr" {
  description = "CIDR block for the Application Subnet"
  default     = "10.0.2.0/24"
}

# EC2 Instance Configuration
variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  default     = "ami-04a81a99f5ec58529" # Replace with your desired AMI ID
}

variable "instance_type" {
  description = "The type of EC2 instance"
  default     = "t2.micro"
}

# Security Groups Configuration
variable "web_sg_ingress_ports" {
  description = "List of ports to allow inbound traffic on the Web Security Group"
  default     = [80, 22] # HTTP and SSH
}

variable "app_sg_ingress_ports" {
  description = "List of ports to allow inbound traffic on the Application Security Group"
  default     = [80]
}

# Database Configuration
variable "db_instance_class" {
  description = "The instance class for the database"
  default     = "db.t2.micro"
}

variable "db_engine" {
  description = "The database engine"
  default     = "mysql"
}

variable "db_username" {
  description = "The master username for the database"
  default     = "admin"
}

variable "db_password" {
  description = "The master password for the database"
  default     = "yourpassword" # Change this to a secure password
}

# S3 Bucket Configuration
variable "s3_bucket_name" {
  description = "The name of the S3 bucket"
  default     = "devpayanshaldp2703"
}
