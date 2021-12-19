resource "google_compute_address" "static" {
    name = "ipv4-address"
}

resource "google_compute_firewall" "default" {
    name    = "gameserver-firewall"
    network = "default"
    allow {
        protocol = "icmp"
    }
    allow {
        protocol = "tcp"
        ports    = ["22", "139", "445", "25565"]
    }
    
        source_ranges = ["0.0.0.0/0"]
    target_tags = ["gameserver"]
}

resource "google_compute_instance" "gameserver" {
    name = "gameserver"
    machine_type = "e2-standard-4"
    zone = "europe-west2-c"

    tags = ["gameserver"]
    # Boot disk
    boot_disk {
        initialize_params {
            image = "minecraft-image"
        }
    }
    network_interface {
        network = "default"
        access_config {
            nat_ip = google_compute_address.static.address
        }
    }

    # Make preemptible
    scheduling {
        preemptible = true
        automatic_restart = false
    }
}