#!/bin/bash
set -e

# Konfiguration
AWS_REGION=""
S3_BUCKET="my-terraform-state-bucket-$(date +%s)"
DDB_TABLE="terraform-locks"

echo "Erstelle S3 Bucket fuer Remote State..."
aws s3api create-bucket \
  --bucket "$S3_BUCKET" \
  --region "$AWS_REGION" \
  --create-bucket-configuration LocationConstraint="$AWS_REGION"

echo "S3 bucket: $S3_BUCKET erstellt."

echo "Aktiviere Versionierung..."
aws s3api put-bucket-versioning \
  --bucket "$S3_BUCKET" \
  --versioning-configuration Status=Enabled

echo "Erstelle DynamoDB Table Fuer Locking..."
aws dynamodb create-table \
  --table-name "$DDB_TABLE" \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region "$AWS_REGION"

echo "DynamoDB Tabelle: $DDB_TABLE erstellt."

echo  Backend ist eingerichtet."
echo " Notiere dir folgenden Bucket-Namen fuer terraform { backend }: $S3_BUCKET"
