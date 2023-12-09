variable "project_id" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version_prefix" {
  type = string
  default = "1.28"
}

variable "cluster_version" {
  type = string
  default = null
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
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

variable "enable_dataplane_v2" {
  type = bool
  default = false
}

////////////////
// Nodes
////////////////

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
