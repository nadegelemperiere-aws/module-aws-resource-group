# -------------------------------------------------------
# TECHNOGIX
# -------------------------------------------------------
# Copyright (c) [2021] Technogix.io
# All rights reserved
# -------------------------------------------------------
# Robotframework test suite for module
# -------------------------------------------------------
# Nadège LEMPERIERE, @12 november 2021
# Latest revision: 12 november 2021
# -------------------------------------------------------


*** Settings ***
Documentation   A test case to check resource group creation
Library         technogix_iac_keywords.terraform
Library         technogix_iac_keywords.keepass
Library         technogix_iac_keywords.resourcegroup
Library         ../keywords/data.py

*** Variables ***
${KEEPASS_DATABASE}                 ${vault_database}
${KEEPASS_KEY}                      ${vault_key}
${KEEPASS_GOD_KEY_ENTRY}            /engineering-environment/aws/aws-god-access-key
${KEEPASS_ID_ENTRY}                 /engineering-environment/aws/aws-sso-sysadmin-group-id
${REGION}                           eu-west-1

*** Test Cases ***
Prepare environment
    [Documentation]         Retrieve god credential from database and initialize python tests keywords
    ${god_access}               Load Keepass Database Secret            ${KEEPASS_DATABASE}     ${KEEPASS_KEY}  ${KEEPASS_GOD_KEY_ENTRY}            username
    ${god_secret}               Load Keepass Database Secret            ${KEEPASS_DATABASE}     ${KEEPASS_KEY}  ${KEEPASS_GOD_KEY_ENTRY}            password
    Initialize Terraform        ${REGION}   ${god_access}   ${god_secret}
    Initialize Resource Group   None        ${god_access}   ${god_secret}    ${REGION}

Create Standard Permissions
    [Documentation]         Create Standard Resource Group
    Launch Terraform Deployment                 ${CURDIR}/../data/standard
    ${states}   Load Terraform States           ${CURDIR}/../data/standard
    ${specs}    Load Standard Test Data         ${states['test']['outputs']['resourcegroup']['value']}  ${states['test']['outputs']['inside']['value']}     ${states['test']['outputs']['outside']['value']}
    Resource Group Shall Exist And Match        ${specs['group']}
    Resource Group Shall Not Exist And Match    ${specs['not-group']}
    [Teardown]  Destroy Terraform Deployment    ${CURDIR}/../data/standard
