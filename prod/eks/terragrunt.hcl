terraform {
    source = "../../modules/eks"
}

include "root" {
  path = find_in_parent_folders()
}

inputs = {
  eks_version = "1.29"
  eks_name = "kubernetes"
  subnet_ids  = dependency.network.outputs.private_subnet_ids
  env = "prod"

  node_groups = {
    general = {
      capacity_type  = "ON_DEMAND"
      instance_types = ["t2.micro"]
      scaling_config = {
        desired_size = 2
        max_size     = 10
        min_size     = 2
      }
    }
  }
  enable_irsa   = true
}

dependency "network" {
  config_path = "../network"

  mock_outputs = {
    private_subnet_ids = ["subnet-1234", "subnet-5678"]
  }
}