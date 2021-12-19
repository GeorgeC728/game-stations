resource "google_compute_firewall" "default" {
    name    = "gameserver-firewall"
    network = "default"
    allow {
        protocol = "icmp"
    }
    allow {
        protocol = "tcp"
        ports    = ["22", "139", "445"]
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
            image = "base-image"
        }
    }
    network_interface {
        network = "default"
        access_config {} // use ephemeral public IP
    }

    # Make preemptible
    scheduling {
        preemptible = true
        automatic_restart = false
    }
}