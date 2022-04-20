### Description

This github repository conists of terraform code used for deploying s3 bucket with jpeg file and serve it using cloudFront distribution.


### Usage


Install Terraform from following url:
https://www.terraform.io/downloads

# Terraform version used: v1.0.10

# first export the asccess key and secret key

`export AWS_ACCESS_KEY_ID=<aws access key>`
`export AWS_SECRET_ACCESS_KEY=<aws secret key>`
`export AWS_DEFAULT_REGION=us-east-1`

## To Run:

# Clone this repository:

`$ git clone https://github.com/charandesuri/suprhasvc_task.git`

# change directory: 

`$ cd cd suprhasvc_task`

# Initialize terraform

`$ terraform init`

# Terraform plan

`$ terraform plan`

# Terraform apply

`$ terraform apply`