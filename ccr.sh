#!/bin/bash

aws cloudformation describe-stacks \
	--stack-name $1

if [[ $? -eq 255 ]]
then
	aws cloudformation create-stack \
	        --stack-name $1 \
	        --template-body file://$2 \
	        --parameters file://$3 \
	        --region=us-west-2
else
	aws cloudformation update-stack \
	        --stack-name $1 \
	        --template-body file://$2 \
	        --parameters file://$3 \
	        --region=us-west-2
fi
