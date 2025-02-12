resource "cloudflare_record" "api" {
  zone_id = var.cloudflare_zone_id
  name    = "api"
  value    = aws_lb.main.dns_name
  type    = "CNAME"
  proxied = true

  depends_on = [aws_lb.main]
}

resource "cloudflare_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.api.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = var.cloudflare_zone_id
  name    = each.value.name
  value   = each.value.record
  type    = each.value.type
  proxied = false
}

resource "cloudflare_zone_settings_override" "settings" {
  zone_id = var.cloudflare_zone_id
  
  settings {
    ssl                      = "strict"              
    tls_1_3                  = "on"
    automatic_https_rewrites = "on"
    always_use_https         = "on"
  }
}

resource "cloudflare_ruleset" "transform_rules" {
  zone_id     = var.cloudflare_zone_id
  name        = "Transform Rules"
  description = "Add security headers"
  kind        = "zone"
  phase       = "http_response_headers_transform"

  rules {
    action = "rewrite"
    action_parameters {
      headers {
        name      = "Strict-Transport-Security"
        value     = "max-age=31536000; includeSubDomains; preload"
        operation = "set"
      }
    }
    expression  = "true"
    description = "Add HSTS header"
    enabled     = true
  }
} 
