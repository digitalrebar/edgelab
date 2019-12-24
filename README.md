# edgelab
Materials to build and deploy a simple Edge Lab for demonstration, training and development


Linode Cloud Test
-----------------

1. you need to install Terraform
1. `cp terraform.tfvars.reference terraform.tfvars`
1. add your Linode API Token and update prefix as needed
1. `terraform apply`
1. wait for cluster
1. in cluster, you need to create and apply a specialized workflow
   1. add `network/firewalld` param in global profile with `["22/tcp","443/tcp","6433/tcp"]` as values
   1. create `discovery-linode` workflow adding `network/firewalld` and `runner-service` stages before end
   1. run `discoery-linode` on all machines
1. play with cluster (import the `edgelab` content and build k3s)
1. `terraform destroy`