#!/bin/bash

echo "Checking for existence of CloudFormation Stack '${1}'..."

aws cloudformation describe-stacks \
	--stack-name $1 >/dev/null 2>&1

if [[ $? -eq 255 ]]
then
	echo "Stack '${1}' not found. Creating stack..."
	aws cloudformation create-stack \
	        --stack-name $1 \
	        --template-body file://$2 \
	        --parameters file://$3 \
	        --region=us-west-2
else
	echo "Stack '${1}' is online. Updating stack..."
	aws cloudformation update-stack \
	        --stack-name $1 \
	        --template-body file://$2 \
	        --parameters file://$3 \
	        --region=us-west-2
fi
