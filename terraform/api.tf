resource "google_project_service" "api" {
  count   = length(var.apis)
  
  project = var.project_id
  service = var.apis[count.index]

  timeouts {
    create = "30m"
    update = "40m"
  }
}
