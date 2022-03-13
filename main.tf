# -------------------------------------------------------
# TECHNOGIX
# -------------------------------------------------------
# Copyright (c) [2021] Technogix.io
# All rights reserved
# -------------------------------------------------------
# Module to deploy the resource group structure
# -------------------------------------------------------
# Nadège LEMPERIERE, @21 november 2021
# Latest revision: 21 november 2021
# -------------------------------------------------------

# -------------------------------------------------------
# Create the resource group to link infrastructure resources
# -------------------------------------------------------
resource "aws_resourcegroups_group" "topic_env_network" {

	name 		= "${var.project}-${var.environment}-${var.module}"
	description = "All ${var.project} resources for the module ${var.module} in the ${var.environment} environment"
	resource_query {
    	query = <<JSON
		{
			"ResourceTypeFilters": [
    			"AWS::AllSupported"
  			],
  			"TagFilters": [
    			{
      				"Key": "Environment",
      				"Values": ["${var.environment}"]
    			},
				{
      				"Key": "Project",
      				"Values": ["${var.project}"]
    			},
				{
      				"Key": "Module",
      				"Values": ["${var.module}"]
    			}
  			]
		}
		JSON
 	}
    tags = {
		Name           	= "${var.project}.${var.environment}.${var.module}.group"
		Environment     = var.environment
		Owner   		= var.email
		Project   		= var.project
		Version 		= var.git_version
	}
}
