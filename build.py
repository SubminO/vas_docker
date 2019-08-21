#!/usr/bin/env python3

import ruamel.yaml
import warnings
import re


warnings.simplefilter('ignore', ruamel.yaml.error.UnsafeLoaderWarning)
data = ruamel.yaml.load(open("common.yml", 'r'))

compose = """
services: {}
networks: {}
volumes: {}
"""
depends = []
env = []
# crithost = [""]
fakehosts = []
config = ruamel.yaml.load(compose)
base_srv = "vas"

with open('.env') as f:
    envfile = list(f)

for i in envfile:
    service = i.rstrip().split("=")
    if service[0].islower() and not re.match(r"^\#.*", service[0]):
        if service[1] == "1":
            if service[0] not in env:
                env.append(service[0])

for service in data["services"]:
    if service in env:
        config["services"][service] = data["services"][service]
        if "depends_on" in data["services"][service]:
            for depend in data["services"][service]["depends_on"]:
                if depend not in depends:
                    depends.append(depend)
                    config["services"][depend] = data["services"][depend]

config["volumes"] = data["volumes"]
config["networks"] = data["networks"]
config["version"] = data["version"]
allsvc = list(set(depends + env))
allsvc.remove(base_srv)
print(allsvc)
config["services"][base_srv]["depends_on"] = allsvc

with open('docker-compose.yml', 'w') as outfile:
    ruamel.yaml.dump(config, outfile, default_flow_style=False)
