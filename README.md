
# 🚀 Three-Tier Python App Deployment on AWS Using Terraform

Welcome! This guide will walk you through deploying a simple Python application with a three-tier architecture on AWS using Terraform. 🌐🛠️

## 📦 Overview

This deployment includes:
1. **VPC**: A Virtual Private Cloud to isolate your resources.
2. **Subnets**: Web and Application subnets.
3. **EC2 Instances**: Separate instances for Web and Application tiers.
4. **RDS Database**: A managed MySQL database.
5. **Application Load Balancer (ALB)**: Distributes incoming traffic.

## 🛠️ Prerequisites

Before you start, make sure you have:
- [Terraform](https://www.terraform.io/downloads.html) installed.
- AWS CLI configured with your credentials.
- An AWS account.
- **[GitHub Codespaces](https://github.com/features/codespaces)** set up for your project.

## 🚀 Getting Started

### 1. **Configure Your Variables**

Update `variables.tf` with your desired values. This file defines the variables for your deployment, such as AWS region, VPC CIDR, subnet configurations, EC2 instance types, security group settings, and database credentials.

### 2. **Setup the Provider**

In `provider.tf`, specify the AWS provider and region where your resources will be created.

### 3. **Define Resources**

In `main.tf`, define the AWS resources for:
- **VPC**: Sets up a Virtual Private Cloud.
- **Subnets**: Creates web and application subnets.
- **Security Groups**: Configures security groups for the web and application tiers.
- **EC2 Instances**: Launches web and application EC2 instances.
- **RDS Database**: Sets up a MySQL database instance.
- **Application Load Balancer**: Configures an ALB to distribute incoming traffic to your web instances.

### 4. **Initialize Terraform**

Run the following command to initialize your Terraform configuration:

```bash
terraform init
```

### 5. **Plan Your Deployment**

Review the changes Terraform will make with:

```bash
terraform plan
```

### 6. **Apply the Configuration**

Deploy your resources to AWS with:

```bash
terraform apply
```

Type `yes` when prompted to confirm the deployment.

### 7. **Verify the Deployment**

After applying, Terraform will output the DNS name of the Application Load Balancer and the endpoint of the RDS database. Use these to access your application and database.

## 🔧 Files

- **`variables.tf`**: Defines variables used in the configuration.
- **`provider.tf`**: Configures the AWS provider.
- **`main.tf`**: Contains the resource definitions for:
  - VPC, subnets, and security groups
  - EC2 instances for web and application tiers
  - RDS database
  - Application Load Balancer
- **`web_userdata.sh`**: User data script for initializing web instances.
- **`app_userdata.sh`**: User data script for initializing application instances.
- **`db_userdata.sh`**: User data script for initializing the database.

## 🔍 Challenges Faced

During the deployment, you might encounter the following challenges:

- **RDS Database Version Issue**: Finding a valid MySQL version for the RDS instance can be tricky. Make sure to use a compatible version with your setup.
- **EC2 Instance Type Issue**: Ensure the chosen EC2 instance type meets your application’s requirements and is available in your region.

## 📚 Additional Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/index.html)
- [AWS RDS Documentation](https://docs.aws.amazon.com/rds/index.html)

---

Happy deploying! 🚀 If you have any questions, feel free to ask. 😊
