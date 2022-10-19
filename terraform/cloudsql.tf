/**
 * Copyright 2022 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "instance" {
  name                = "${var.application_name}-instance-${random_id.db_name_suffix.hex}"
  region              = var.region
  database_version    = "POSTGRES_14"
  deletion_protection = false # not recommended for PROD

  settings {
    tier        = "db-g1-small"
    user_labels = var.resource_labels

    ip_configuration {
      ipv4_enabled    = false
      private_network = module.vpc.network_self_link
    }
  }

  depends_on = [google_service_networking_connection.private_service_connection]
}

resource "google_sql_database" "database" {
  instance = google_sql_database_instance.instance.id
  name     = "${var.application_name}-db"
}

resource "google_sql_user" "user" {
  instance = google_sql_database_instance.instance.id
  name     = var.application_name
  password = var.application_name
}
