#!/bin/bash

cd `dirname $0`

exitcode=0

box stop pltests
box start directory="./tests" serverConfigFile="./tests/server.json"
box testbox run || exitcode=1
box stop pltests
exit $exitcode
