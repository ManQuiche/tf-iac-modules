variable "project_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version_prefix" {
  type    = string
  default = "1.28"
}

variable "cluster_version" {
  type    = string
  default = null
}

variable "region" {
  type = string
}

variable "zone" {
  type    = string
  default = null
}

////////////////
// Networking
////////////////

variable "vpc_main_subnet" {
  type    = string
  default = "10.123.0.0/24"
}

////////////////
// Cluster
////////////////

variable "autoscaling_enabled" {
  type    = bool
  default = false
}

variable "dataplane_v2_enabled" {
  type    = bool
  default = false
}

variable "deletion_protection" {
  type    = bool
  default = true
}

////////////////
// Nodes
////////////////

variable "node_pool_name" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "e2-standard-2"
}

variable "disk_type" {
  type    = string
  default = "pd-standard"
}

variable "node_count" {
  type    = number
  default = 3
}


variable "autoscaling_min_node_count" {
  type = number
}


variable "autoscaling_max_node_count" {
  type = number
}

