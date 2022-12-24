terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
  cloud {
    organization = "kavooce"
    token        = "$TF_TOKEN"

    workspaces {
      name = "jenkins-pipeline-02"
    }

  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "cluster" {
  name    = "cluster"
  region  = "nyc1"
  version = "1.24.8-do.0"

  node_pool {
    name       = "worker-pool"
    size       = "s-4vcpu-8gb"
    node_count = 2
  }

}


