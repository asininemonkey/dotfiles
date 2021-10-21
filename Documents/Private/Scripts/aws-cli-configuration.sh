#!/usr/bin/env bash

unset AWS_ACCESS_KEY_ID
unset AWS_PROFILE
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN

chmod 0600 "${HOME}/.aws/config"
chmod 0600 "${HOME}/.aws/credentials"

cat /dev/null > "${HOME}/.aws/config"
cat /dev/null > "${HOME}/.aws/credentials"

read -p "AWS User Name: " -s AWS_USER_NAME
echo

read -p "AWS Access Key ID (20 Characters): " -n 20 -s AWS_ACCESS_KEY_ID
echo

read -p "AWS Secret Access Key (40 Characters): " -n 40 -s AWS_SECRET_ACCESS_KEY
echo

aws configure set "profile.default.aws_access_key_id" "${AWS_ACCESS_KEY_ID}"
aws configure set "profile.default.aws_secret_access_key" "${AWS_SECRET_ACCESS_KEY}"
aws configure set "profile.default.output" "json"
aws configure set "profile.default.region" "eu-west-1"
aws configure set "profile.default.s3.signature_version" "s3v4"

aws configure set "profile.production.output" "json"
aws configure set "profile.production.region" "eu-west-1"
aws configure set "profile.production.role_arn" "arn:aws:iam::xxxxxxxxxxxx:role/people/${AWS_USER_NAME}"
aws configure set "profile.production.s3.signature_version" "s3v4"
aws configure set "profile.production.source_profile" "default"

aws configure set "profile.qa.output" "json"
aws configure set "profile.qa.region" "eu-west-1"
aws configure set "profile.qa.role_arn" "arn:aws:iam::xxxxxxxxxxxx:role/people/${AWS_USER_NAME}"
aws configure set "profile.qa.s3.signature_version" "s3v4"
aws configure set "profile.qa.source_profile" "default"

aws configure set "profile.staging.output" "json"
aws configure set "profile.staging.region" "eu-west-1"
aws configure set "profile.staging.role_arn" "arn:aws:iam::xxxxxxxxxxxx:role/people/${AWS_USER_NAME}"
aws configure set "profile.staging.s3.signature_version" "s3v4"
aws configure set "profile.staging.source_profile" "default"

unset AWS_ACCESS_KEY_ID
unset AWS_PROFILE
unset AWS_SECRET_ACCESS_KEY
unset AWS_SESSION_TOKEN
