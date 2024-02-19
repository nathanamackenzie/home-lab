# Home Lab

## Overview
Home lab is a terraform project that defines an enviorment in AWS for personal projects and learning new services. 

## Account Structure
The home laboratory setup comprises an AWS organization housing two accounts, excluding the root management account: production and development. Within each account, there are two VPCs situated in separate regions, facilitating the implementation of multi-region high availability configurations.

<p align="center">
  <img src="./img/org-struct.png" alt="Organization Structure" width="300">
</p>

![Employees-Burnout-Analysis-and-Prediction](img/org-struct.png)

## File Structure
The directory structure of the home lab project is organized as depicted below.


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
    └── vpc


```

## VPC Structure
Each VPC is equipped with 8 subnets, evenly distributed across two availability zones. Within each availability zone, there are four subnets, comprising of one public web subnet and three private subnets: application, database, and reserved.

The diagrams below illustrate the subnet CIDR ranges for each VPC and subnet.


### prod-use1-vpc1
<p align="center">
  <img src="/img/prod-use1-vpc1.png" alt="pro-use1-vpc1" width="300">
</p>

### prod-use2-vpc1
<p align="center">
  <img src="/img/prod-use2-vpc1.png" alt="pro-use2-vpc1" width="300">
</p>

### dev-use1-vpc1
<p align="center">
  <img src="/img/dev-use1-vpc1.png" alt="dev-use1-vpc1" width="300">
</p>

### dev-use2-vpc1
<p align="center">
  <img src="/img/dev-use2-vpc1.png" alt="dev-use2-vpc1" width="300">
</p>

## Licence

Home-Lab is [MIT licenced](LICENSE)