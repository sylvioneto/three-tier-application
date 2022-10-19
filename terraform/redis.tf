resource "google_redis_instance" "cache" {
  name           = "${var.application_name}-instance"
  region         = var.region

  redis_version  = "REDIS_4_0"
  tier           = "BASIC"
  memory_size_gb = 1
  labels         = local.resource_labels

  authorized_network = module.vpc.network_id
  connect_mode       = "PRIVATE_SERVICE_ACCESS"

  depends_on = [google_service_networking_connection.private_service_connection]
}
