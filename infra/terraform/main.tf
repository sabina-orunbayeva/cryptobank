resource "hcloud_network" "network" {
  name     = "test-net"
  ip_range = "10.0.1.0/24"
}

resource "hcloud_network_subnet" "subnet" {
  type         = "cloud"
  network_id   = hcloud_network.network.id
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}

resource "hcloud_server" "app_server" {
  name        = "test-app-server"
  server_type = "cx11"
  image       = "ubuntu-20.04"
  location    = "nbg1"
  
  network {
    network_id = hcloud_network.network.id
    ip         = "10.0.1.5"
    alias_ips  = [
        "10.0.1.6",
        "10.0.1.7"
      ]
    }

  labels = {
    purpose = "app"
  }
}