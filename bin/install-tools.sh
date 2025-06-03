#!/bin/bash
set -e 

echo "installiere Terraform & AWS CLI..."

# Terraform Version
TERRAFORM_VERSION="1.7.5"

# --- Aktualisierung ---
sudo apt-get update -y
sudo apt-get install -y unzip curl gnupg software-properties-common

# --- AWS CLI ---
if ! command -v aws &>/dev/null; then
  echo "Installiere AWS CLI..."
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  rm -rf aws awsclidv2.zip
else
  echo "AWS CLI bereits installiert"
fi

# --- Terraform ---
if ! command -v terraform &>/dev/null; then
  echo "Installiere Terraform ${TERRAROM_VERSION}..."
  curl -fsSL "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" -o terraform.zip
  unzip terraform.zip
  sudo mv terraform /usr/local/bin
  rm terraform.zip
else
  echo "Terraform bereits installiert"
fi

# --- Ueberpruefen ---
echo "Installierte Versionen:"
terraform version
aws --version

echo "Tools erfolgreich installiert."
