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

output "group" {
	value = aws_resourcegroups_group.topic_env_network.arn
} 