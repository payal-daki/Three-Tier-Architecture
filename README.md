
# 🚀 Three-Tier App Deployment on AWS Using Terraform

Welcome! This guide will walk you through deploying a simple application with a three-tier architecture on AWS using Terraform. 🌐🛠️

## 📑 Table of Contents
- [Overview](#-overview)
- [Prerequisites](#-prerequisites)
- [Getting Started](#-getting-started)
  - [Configure Your Provider](#1-configure-your-provider)
  - [Define Resources](#2-define-resources)
  - [Configure Your Variables](#3-configure-your-variables)
  - [Initialize Terraform](#4-initialize-terraform)
  - [Plan Your Deployment](#5-plan-your-deployment)
  - [Apply the Configuration](#6-apply-the-configuration)
  - [Verify the Deployment](#7-verify-the-deployment)
- [Files](#-files)
- [Challenges Faced](#-challenges-faced)
- [Additional Resources](#-additional-resources)
- [Troubleshooting Tips](#-troubleshooting-tips)

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

### 1. **Configure Your Provider**

Specify the AWS provider and region where your resources will be created in the `provider.tf` file.

### 2. **Define Resources**

Define the AWS resources for your VPC, subnets, security groups, EC2 instances, RDS database, and Application Load Balancer in the `main.tf` file.

### 3. **Configure Your Variables**

Update `variables.tf` with your desired values. This file defines the variables for your deployment, such as AWS region, VPC CIDR, subnet configurations, EC2 instance types, security group settings, and database credentials.

### 4. **Initialize Terraform**

Run the command to initialize your Terraform configuration.

### 5. **Plan Your Deployment**

Review the changes Terraform will make by running the appropriate command.

### 6. **Apply the Configuration**

Deploy your resources to AWS by running the apply command and confirming the deployment.

### 7. **Verify the Deployment**

After applying, Terraform will output the DNS name of the Application Load Balancer and the endpoint of the RDS database. Use these to access your application and database.

## 🔧 Files

- **`provider.tf`**: Configures the AWS provider.
- **`main.tf`**: Contains the resource definitions for:
  - VPC, subnets, and security groups
  - EC2 instances for web and application tiers
  - RDS database
  - Application Load Balancer
- **`variables.tf`**: Defines variables used in the configuration.
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

## 🛠️ Troubleshooting Tips

- **Initialization Errors**: Ensure your AWS CLI is configured correctly and that you have the necessary permissions.
- **Resource Limits**: Be aware of AWS resource limits in your account. You may need to request increases for certain resources.
- **Network Issues**: Verify your VPC and subnet configurations to ensure proper routing and security group settings.

---

Happy deploying! 🚀 If you have any questions, feel free to ask. 😊
