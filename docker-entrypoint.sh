#!/bin/bash
set -e
$JBOSS_HOME/bin/standalone.sh -c standalone-full.xml -Djboss.socket.binding.port-offset=101
