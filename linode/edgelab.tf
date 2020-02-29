# Configure the Linode provider
variable "linode_token" {
  type      = string
}

variable "edgelab_label" {
  type      = string
}

# Regions ca-central, us-central, us-west, us-southeast, us-east
variable "edgelab_region" {
  type      = string
}

variable "edgelab_image" {
  type      = string
}

variable "edgelab_type" {
  type      = string
}

variable "edgelab_count" {
  type      = string
}

variable "edgelab_password" {
  type      = string
}

variable "cluster_prefix" {
  type      = string
}

variable "cluster_tag" {
  type      = string
}

provider "linode" {
  token     = var.linode_token
}

resource "linode_instance" "edgelab_controller" {
  image     = var.edgelab_image
  label     = "${var.cluster_prefix}-${var.edgelab_label}"
  region    = var.edgelab_region
  type      = var.edgelab_type
  root_pass = var.edgelab_password
  tags      = [ "${var.cluster_tag}" ]

  stackscript_id = "626699"
  stackscript_data = {
    "drp_version" = "tip"
    "drp_password" = var.edgelab_password
    "drp_id" = var.edgelab_label
    "initial_workflow" = "edge-lab-bootstrap"
    "initial_contents" = "drp-community-content, task-library, edge-lab"
  }
}

resource "linode_instance" "edgelab_worker" {
  image     = var.edgelab_image
  label     = "${var.cluster_prefix}-${var.edgelab_label}-worker-${count.index+10}"
  region    = var.edgelab_region
  type      = var.edgelab_type
  root_pass = var.edgelab_password
  tags      = [ "${var.cluster_tag}" ]
  count     = var.edgelab_count

  stackscript_id = "548252"
  stackscript_data = {
      "drp_ip" = linode_instance.edgelab_controller.ip_address
      "drp_port" = "8091"
      "open_ports" = "22 80 443 8080 8092 8091 2379 2380 6443 10250"
  }
}

output "drp_ip" {
  value       = linode_instance.edgelab_controller.ip_address
  description = "The IP of DRP"
}

output "edgelab_controller" {
  value       = "https://${linode_instance.edgelab_controller.ip_address}:8092"
  description = "The URL of DRP"
}
