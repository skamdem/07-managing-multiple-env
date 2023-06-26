# Route53 resources of aws provider

# the hosted zone is assumed to exist already
data "aws_route53_zone" "my_zone" {
  name = var.domain
}

resource "aws_route53_record" "web_app_subdomain" {
  count   = var.create_dns_record ? 1 : 0 # create the subdomain record if necessary
  zone_id = data.aws_route53_zone.my_zone.id
  name    = "${var.subdomain}.${data.aws_route53_zone.my_zone.name}"
  type    = "A"

  alias {
    name                   = aws_lb.load_balancer.dns_name
    zone_id                = aws_lb.load_balancer.zone_id
    evaluate_target_health = true
  }
}
