# -------------------------------------------------------
# TECHNOGIX
# -------------------------------------------------------
# Copyright (c) [2021] Technogix.io
# All rights reserved
# -------------------------------------------------------
# Module to deploy the resource group structure
# -------------------------------------------------------
# Nadège LEMPERIERE, @20 november 2021
# Latest revision: 20 november 2021
# -------------------------------------------------------

# -------------------------------------------------------
# Contact e-mail for this deployment
# -------------------------------------------------------
variable "email" {
	type 	= string
}

# -------------------------------------------------------
# Environment for this deployment (prod, preprod, ...)
# -------------------------------------------------------
variable "environment" {
	type 	= string
}

# -------------------------------------------------------
# Topic context for this deployment
# -------------------------------------------------------
variable "project" {
	type    = string
}
variable "module" {
	type 	= string
}

# -------------------------------------------------------
# Solution version
# -------------------------------------------------------
variable "git_version" {
	type    = string
	default = "unmanaged"
}