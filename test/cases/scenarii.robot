# -------------------------------------------------------
# Copyright (c) [2021] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Robotframework test suite for module
# -------------------------------------------------------
# Nadège LEMPERIERE, @12 november 2021
# Latest revision: 20 november 2023
# -------------------------------------------------------


*** Settings ***
Documentation   A test case to check resource group creation
Library         aws_iac_keywords.terraform
Library         aws_iac_keywords.keepass
Library         aws_iac_keywords.resourcegroup
Library         ../keywords/data.py
Library         OperatingSystem

*** Variables ***
${KEEPASS_DATABASE}                 ${vault_database}
${KEEPASS_KEY_ENV}                  ${vault_key_env}
${KEEPASS_PRINCIPAL_KEY_ENTRY}      /aws/aws-principal-access-key
${KEEPASS_ID_ENTRY}                 /aws/aws-sso-sysadmin-group-id
${REGION}                           eu-west-1

*** Test Cases ***
Prepare environment
    [Documentation]         Retrieve principal credential from database and initialize python tests keywords
    ${keepass_key}              Get Environment Variable          ${KEEPASS_KEY_ENV}
    ${principal_access}         Load Keepass Database Secret      ${KEEPASS_DATABASE}     ${keepass_key}  ${KEEPASS_PRINCIPAL_KEY_ENTRY}            username
    ${principal_secret}         Load Keepass Database Secret      ${KEEPASS_DATABASE}     ${keepass_key}  ${KEEPASS_PRINCIPAL_KEY_ENTRY}            password
    Initialize Terraform        ${REGION}   ${principal_access}   ${principal_secret}
    Initialize Resource Group   None        ${principal_access}   ${principal_secret}    ${REGION}

Create Standard Permissions
    [Documentation]         Create Standard Resource Group
    Launch Terraform Deployment                 ${CURDIR}/../data/standard
    ${states}   Load Terraform States           ${CURDIR}/../data/standard
    ${specs}    Load Standard Test Data         ${states['test']['outputs']['resourcegroup']['value']}  ${states['test']['outputs']['inside']['value']}     ${states['test']['outputs']['outside']['value']}
    Resource Group Shall Exist And Match        ${specs['group']}
    Resource Group Shall Not Exist And Match    ${specs['not-group']}
    [Teardown]  Destroy Terraform Deployment    ${CURDIR}/../data/standard
