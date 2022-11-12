# Infrastructure

## AWS Zones
Identify your zones here

zone1
. us-east-2
. us-west-1

zone2
. us-west-1

## Servers and Clusters

### Table 1.1 Summary


| Asset      | Purpose           | Size                                                                   | Qty                                                             | DR                                                                                                           |
|------------|-------------------|------------------------------------------------------------------------|-----------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|
| Asset name | Brief description | AWS size eg. t3.micro (if applicable, not all assets will have a size) | Number of nodes/replicas or just how many of a particular asset | Identify if this asset is deployed to DR, replicated, created in multiple locations or just stored elsewhere |
|  EC2| HA Application | t3.medium | 3 for each region | three ec2 on three azs |
|  EKS nodegroup | HA of workers/nodes | t3.medium | 2 for each region per cluster| should have A DR |
| VPC 1 | vpc 1 for main network on three AZ or atleast 2  | two az us-east-2a","us-east-2b  | 1 | another vpc on another region
| VPC 2 | vpc 2 for DR on three AZ or atleast 2 | two az "us-west-1b","us-west-1c" | 1 | this is the DR
| ALB 1 | ALB 1 on the first region | 1 on three AZs or two | 1 | needs DR on the other region
| ALB 2 | ALB 2 on the 2nd region | 1 on three AZs or two | 1 | This is ALB DR
| RDS 1 | RDS 1 on the first region (Main) | 2 nodes on cluster | 1 | will be replicated to another cluster on the other region
| RDS 2 | RDS 2 on the 2nd region (replication of the main cluster on the first region) | 2 nodes on cluster on diff az | 1 | the replication of main RDS

### Descriptions
More detailed descriptions of each asset identified above.

1. EC2 as per the requirments its needs three VMs thats mean we need to have HA cluster of the applicaiton and we need to have 3 or atleast 2 nodes on DR site for DR plan.
2. EKS cluster on the main vpc/network should be atleast two nodes as per the requirments (control plane) 2 per region, so we need to have DR EKS cluster on another region and to make sure the 2nd cluster is high available should have atleast two AZs.
3. Two have DR site to host all eks, EC2s and RDS should have two VPCs one on the first main region and the 2nd on DR region thats spans on three zones atleast but on our case regarding to ec2 should have 3 nodes so we need to have them on diff az for more HA.
4. ALB spans on diff AZs for the first region and another one on the 2nd region to have more HA ALB.
5. RDS on the first region shoud have two nodes under the cluster and we need to have another RDS cluster running on the 2nd region this is will be the DR side for the replication of the first site.

## DR Plan
### Pre-Steps:
List steps you would perform to setup the infrastructure in the other region. It doesn't have to be super detailed, but high-level should suffice.

I will use IaC to setup the other region it will starts setuping an new vpc and new subnets with tagging for the EKS and ALBs, it will create EKS cluster have 2 nodes, and 3 ec2 one on each region. RDS cluster with two nodes for the replication of the source cluster with the targeted retintion for backups.
FOR ALB its will create target group and add the resources that i want to create ALB for then add target group to ALB.

## Steps:
You won't actually perform these steps, but write out what you would do to "fail-over" your application and database cluster to the other region. Think about all the pieces that were setup and how you would use those in the other region

1. change dns for the another ALB of the app.
2. To preform application failover this will happened from ALB which if the health check not good or something going wrong then will fail over to the another region alb.
3. for RDS we need to go to console then RDS to click on RDS failover for.

