# GKE cluster
data "google_container_engine_versions" "gke_version" {
  project        = var.project_id
  location       = try(var.zone, var.region)
  version_prefix = var.cluster_version_prefix
}

resource "google_container_cluster" "primary" {
  project  = var.project_id
  name     = var.cluster_name
  location = try(var.zone, var.region)

  deletion_protection = var.deletion_protection

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1

  network    = google_compute_network.vpc.name
  subnetwork = google_compute_subnetwork.subnet.name

  datapath_provider = var.dataplane_v2_enabled ? "ADVANCED_DATAPATH" : "LEGACY_DATAPATH"

  cluster_autoscaling {
    enabled = var.autoscaling_enabled
  }
}

resource "google_container_node_pool" "nodes" {
  project  = var.project_id
  name     = "${google_container_cluster.primary.name}-${var.node_pool_name}"
  location = try(var.zone, var.region)
  cluster  = google_container_cluster.primary.name

  version    = try(var.cluster_version, data.google_container_engine_versions.gke_version.release_channel_default_version["STABLE"])
  node_count = var.node_count


  autoscaling {
    min_node_count = try(var.autoscaling_min_node_count, null)
    max_node_count = try(var.autoscaling_max_node_count, null)
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels = {
      env = var.project_id
    }

    disk_type = var.disk_type

    machine_type = var.instance_type
    tags         = ["gke-node", "${var.project_id}-gke"]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
}
