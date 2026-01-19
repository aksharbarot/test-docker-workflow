#!/bin/bash

echo "Starting Test Application..."
exec java -javaagent:/app/dd-java-agent.jar \
  -Ddd.service=test-app \
  -Ddd.env=${DD_ENV:-dev} \
  -jar /app/testapp.jar
