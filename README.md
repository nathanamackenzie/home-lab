# Home Lab

## Overview
Home lab is a terraform project for an enviorment in AWS for personal projects and learning new services.

## Hosted Projects
For detailed arcitectures of projects hosted on this infrastructure visit below.

[Personal Website](https://github.com/nathanamackenzie/personal-website)

## Account Structure
The home lab setup comprises an AWS organization housing two accounts, excluding the root management account: production and development. Within each account, there are two VPCs situated in separate regions, allowing the implementation of multi-region highly-available configurations.

<p align="center">
  <img src="https://github.com/nathanamackenzie/home-lab/raw/main/img/org-struct.PNG" alt="Organization Structure" width="600">
</p>

## File Structure
The directory structure of the home lab project is organized as shown below.


```text
.
infrastructure
└── enviorments
|   └── development
|   |   ├── config.tf
|   |   ├── main.tf
|   |   └── datasources.tf
|   └── production
│       ├── config.tf
|       ├── main.tf
|       └── datasources.tf
└── modules
    ├── apigateway
    ├── dynamodb
    └── vpc


```

## VPC Structure
Each VPC is holds 8 subnets, distributed across two availability zones. Within each availability zone, there are four subnets, comprising of one public web subnet and three private subnets: application, database, and reserved.

The diagrams below illustrate the subnet CIDR ranges for each VPC and subnet.

### prod-use1-vpc1
<p align="center">
  <img src="https://raw.githubusercontent.com/nathanamackenzie/home-lab/main/img/prod-use1-vpc1.PNG" alt="pro-use2-vpc1" width="600">
</p>

### prod-use2-vpc1
<p align="center">
  <img src="https://raw.githubusercontent.com/nathanamackenzie/home-lab/main/img/pro-use2-vpc1.PNG" alt="pro-use2-vpc1" width="600">
</p>

### dev-use1-vpc1
<p align="center">
  <img src="https://raw.githubusercontent.com/nathanamackenzie/home-lab/main/img/dev-use1-vpc1.PNG" alt="dev-use1-vpc1" width="600">
</p>

### dev-use2-vpc1
<p align="center">
  <img src="https://raw.githubusercontent.com/nathanamackenzie/home-lab/main/img/dev-use2-vpc1.PNG" alt="dev-use2-vpc1" width="600">
</p>

## Licence

Home-Lab is [MIT licenced](LICENSE)