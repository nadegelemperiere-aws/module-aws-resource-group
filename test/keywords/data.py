# -------------------------------------------------------
# Copyright (c) [2021] Nadege Lemperiere
# All rights reserved
# -------------------------------------------------------
# Keywords to create data for module test
# -------------------------------------------------------
# Nadège LEMPERIERE, @13 november 2021
# Latest revision: 13 november 2021
# -------------------------------------------------------

# System includes
from json import load, dumps

# Robotframework includes
from robot.libraries.BuiltIn import BuiltIn, _Misc
from robot.api import logger as logger
from robot.api.deco import keyword
ROBOT = False

# ip address manipulation
from ipaddress import IPv4Network

@keyword('Load Standard Test Data')
def load_standard_test_data(arn, inside, outside) :

    result = {}

    result['group'] = []
    result['group'].append({})
    result['group'][0]['name']              = 'standard'
    result['group'][0]['data']              = {}
    result['group'][0]['data']['GroupArn']  = arn
    result['group'][0]['data']['Name']      = 'test-test-test'
    result['group'][0]['data']['Resources'] = []
    for sub in inside :
        result['group'][0]['data']['Resources'].append({"Identifier": {"ResourceArn": sub, "ResourceType": "AWS::EC2::Subnet"}})

    result['not-group'] = []
    for sub in outside :
        temp = {}
        temp['name']              = 'none1'
        temp['data']              = {}
        temp['data']['Resources'] = []
        temp['data']['Resources'].append({"Identifier": {"ResourceArn": sub, "ResourceType": "AWS::EC2::Subnet"}})

        result['not-group'].append(temp)

    logger.debug(dumps(result))

    return result