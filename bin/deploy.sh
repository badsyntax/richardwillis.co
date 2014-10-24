#!/usr/bin/env bash
# deploy.sh - Deploy the application

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

echo -e "\nSuccessfully deployed the application.\n"