#!/usr/bin/env bash
# deploy-and-build.sh - Deploy and build the application

readonly ENV="$1"

if [ "$ENV" != "staging" ] && [ "$ENV" != "production" ]; then
  echo $"Usage: $0 {staging|production}"
  exit 1
fi

# Ensure we're in the correct directory
while [ ! -f Capfile ]
do
  cd ..
done

cap "$ENV" deploy

if [ $? -ne 0 ]; then
  echo "There was an error deploying the application, exiting."
  exit 1
fi

echo -e "\nSuccessfully deployed application.\n"

cap "$ENV" deploy:build

if [ $? -ne 0 ]; then
  echo "There was an error building the deployed application, exiting."
  exit 1
fi

echo -e "\nSuccessfully built the deployed application.\n"

echo "All done."