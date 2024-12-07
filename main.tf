# --- This is how we connect ---
terraform {
  required_providers {
    koyeb = {
      source = "koyeb/koyeb"
      version = "0.1.2"
    }
  }
}

# --- App Details ---

resource "koyeb_app" "sample-app" {
  name = var.app_name
}


resource "koyeb_service" "sample-service" {
  app_name = var.app_name
  definition {
    name = var.service_name
    instance_types {
      type = "free"
    }
    ports {
      port     = 8080
      protocol = "http"
    }
    scalings {
      min = 1
      max = 1
    }
    env {
      key   = "PORT"
      value = "8080"
    }
    routes {
      path = "/"
      port = 8080
    }
    regions = ["was"]
    docker {
      image = "zauberzeug/nicegui"
    }
  }
  depends_on = [
    koyeb_app.sample-app
  ]
}