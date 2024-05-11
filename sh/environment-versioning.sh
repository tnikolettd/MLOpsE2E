#!/bin/bash

# This script creates an Azure ML environment with version control

# Check if two arguments are provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <environment_name> <environment_config_file_path>"
  exit 1
fi

# Assign the arguments to respective variables
ENV_NAME=$1
ENV_FILE=$2

# Fetch the latest version of the environment and increment or start new
echo "Fetching the latest environment version..."
env_version_quotes=$(az ml environment list --name $ENV_NAME --query "max_by([], &version).version")
env_version=$(echo "$env_version_quotes" | tr -d '"')
if [[ "$env_version" =~ ^[0-9]+$ ]]; then
  echo "Latest environment version: $env_version"
  env_version=$((env_version + 1)) # Increment environment version
else
  echo "No existing environment versions found or version is not an integer. Starting with version 1."
  env_version=1
fi
echo "Environment version to be created: $env_version"

# Create the environment with the new or incremented version
echo "Creating new environment version..."
az ml environment create --file $ENV_FILE --name $ENV_NAME --version $env_version