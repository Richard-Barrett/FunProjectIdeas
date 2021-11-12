data "aws_acm_certificate" "cert" {
  domain = "*.${var.base_domain}"
  statuses = ["ISSUED"]
  most_recent = true
}

data "aws_route53_zone" "zone" {
  name = "${var.base_domain}"
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.zone.zone_id
  name = "${var.appname}.${var.base_domain}"
  type = "CNAME"
  ttl = "300"
  records = [kubernetes_ingress.teleport-ingress.status.0.load_balancer.0.ingress.0.hostname]
}

resource "kubernetes_ingress" "teleport-ingress" {
  wait_for_load_balancer = true

  metadata {
    name = var.appname
    namespace = var.namespace
    annotations = {
      "kubernetes.io/ingress.class" = "alb"
      "alb.ingress.kubernetes.io/scheme" = "internet-facing"
      "alb.ingress.kubernetes.io/target-type" = "ip"
      "alb.ingress.kubernetes.io/certificate-arn" = data.aws_acm_certificate.cert.arn
      "alb.ingress.kubernetes.io/listen-ports" = jsonencode([
        {
          HTTP = 80
        },
        {
          HTTPS = 443
        }
      ])
      "alb.ingress.kubernetes.io/actions.ssl-redirect" = jsonencode({
        Type = "redirect"
        RedirectConfig = {
          Protocol = "HTTPS"
          Port = "443"
          StatusCode = "HTTP_301"
        }
      })
    }
  }

  spec {
    rule {
      host = "${var.appname}.${var.base_domain}"
      http {
        path {
          backend {
            service_name = "ssl-redirect"
            service_port = "use-annotation"
          }
        }
        path {
          backend {
            service_name = kubernetes_service.teleport-service.metadata.0.name
            service_port = 80
          }
        }
      }
    }
  }
}