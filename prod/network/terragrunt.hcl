terraform {
  source = "../../modules/network"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  env             = "prod"
  azs             = ["eu-central-1a", "eu-central-1b"]
  private_subnets = ["10.0.0.0/19", "10.0.32.0/19"]
  public_subnets  = ["10.0.64.0/19", "10.0.96.0/19"]

  private_subnets_tags = {
    "kubernetes.io/role/internal-elb" = 1
    "kubernetes.io/cluster/prod"      = "owned"
  }

  public_subnets_tags = {
    "kubernetes.io/role/elb"     = 1
    "kubernetes.io/cluster/prod" = "owned"
  }

  security_group_inbound_rules  = ["22", "443"]
  security_group_outbound_rules = ["0"]
}