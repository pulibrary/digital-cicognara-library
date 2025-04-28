variable "branch_or_sha" {
  type = string
  default = "main"
}
job "cicognara-production" {
  region = "global"
  datacenters = ["dc1"]
  node_pool = "staging"
  type = "service"
  group "web" {
    count = 2
    network {
      port "http" { to = 80 }
    }
    service {
      port = "http"
    }
    task "webserver" {
      driver = "podman"
      config {
        image = "ghcr.io/pulibrary/digital-cicognara-library:${ var.branch_or_sha }"
        ports = ["http"]
        force_pull = true
      }
    }
  }
}

