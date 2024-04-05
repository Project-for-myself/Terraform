variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr_block" {
  description = "CIDR"
  type        = string
  default     = "10.0.0.0/16"
}

variable "region" {
  description = "Environment region"
  type        = string
  default     = "Frankfurt"
}

variable "azs" {
  description = "Availability zones for subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR range for private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "CIDR range for public subnets"
  type        = list(string)
}

variable "private_subnets_tags" {
  description = "Private subnets tags"
  type        = map(any)
}

variable "public_subnets_tags" {
  description = "Public subnets tags"
  type        = map(any)
}

variable "security_group_inbound_rules" {
  description = "Security group inbound rules"
  type        = list(string)
}

variable "security_group_outbound_rules" {
  description = "Security group outbound rules"
  type        = list(string)
}

variable "sg_cidr_block" {
  description = "CIDR"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
