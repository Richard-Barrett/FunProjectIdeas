
resource "kubernetes_service" "teleport" {
    metadata {
        name = var.appname
        namespace = var.namespace
    }

    spec {
        selector = {
            app = var.appname
        }
        port {
            protocol = "TCP"
            target_port = 8080
            port = 80
        }
    }