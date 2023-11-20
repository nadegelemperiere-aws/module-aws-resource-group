# -------------------------------------------------------
# Copyright (c) [2021] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Simple deployment for module testing
# -------------------------------------------------------
# Nadège LEMPERIERE, @12 november 2021
# Latest revision: 12 november 2021
# -------------------------------------------------------


resource "aws_vpc" "vpc" {
	cidr_block  = "10.2.0.0/16"
   	tags 		= {
		   Project = "test", Environment = "test", module = "test"
	}
}

resource "aws_subnet" "in" {
	count = 4

	vpc_id = aws_vpc.vpc.id
	cidr_block  = "10.2.${count.index}.0/24"
   	tags 		= {
		   Project = "test", Environment = "test", Module = "test"
	}
}

resource "aws_subnet" "out1" {
	vpc_id = aws_vpc.vpc.id
	cidr_block  = "10.2.10.0/24"
   	tags 		= { Project = "test", Environment = "test", Module = "test1" }
}

resource "aws_subnet" "out2" {
	vpc_id = aws_vpc.vpc.id
	cidr_block  = "10.2.11.0/24"
   	tags 		= { Project = "test", Environment = "test1", Module = "test" }
}

resource "aws_subnet" "out3" {
	vpc_id = aws_vpc.vpc.id
	cidr_block  = "10.2.12.0/24"
   	tags 		= { Project = "test1", Environment = "test", Module = "test" }
}

resource "aws_subnet" "out4" {
	vpc_id = aws_vpc.vpc.id
	cidr_block  = "10.2.13.0/24"
   	tags 		= { Project = "test1", Environment = "test1", Module = "test1" }
}

# -------------------------------------------------------
# Create subnets using the current module
# -------------------------------------------------------
module "resourcegroup" {

	source 			= "../../../"
	email 			= "moi.moi@moi.fr"
	project 		= "test"
	environment 	= "test"
	module 			= "test"
	git_version 	= "test"
}

# -------------------------------------------------------
# Terraform configuration
# -------------------------------------------------------
provider "aws" {
	region		= var.region
	access_key 	= var.access_key
	secret_key	= var.secret_key
}

terraform {
	required_version = ">=1.0.8"
	backend "local"	{
		path="terraform.tfstate"
	}
}

# -------------------------------------------------------
# Region for this deployment
# -------------------------------------------------------
variable "region" {
	type    = string
}

# -------------------------------------------------------
# AWS credentials
# -------------------------------------------------------
variable "access_key" {
	type    	= string
	sensitive 	= true
}
variable "secret_key" {
	type    	= string
	sensitive 	= true
}

# -------------------------------------------------------
# Test outputs
# -------------------------------------------------------
output "resourcegroup" {
	value = module.resourcegroup.group
}

output "inside" {
	value = aws_subnet.in.*.arn
}

output "outside" {
	value = [
		aws_subnet.out1.arn,
		aws_subnet.out2.arn,
		aws_subnet.out3.arn,
		aws_subnet.out4.arn
	]
}