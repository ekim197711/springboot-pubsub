resource "google_pubsub_topic" "spaceship" {
  name = "spaceship"
  labels = {
    purpose = "development"
  }
  message_retention_duration = "86600s"
  lifecycle {
    prevent_destroy = false
  }
}

resource "google_pubsub_subscription" "spaceship" {
  name  = "spaceship"
  topic = google_pubsub_topic.spaceship.name
  labels = {
    purpose = "development"
  }
  # 20 minutes
  message_retention_duration = "1200s"
  retain_acked_messages      = true
  ack_deadline_seconds = 20
  expiration_policy {
    ttl = "300000.5s"
  }
  retry_policy {
    minimum_backoff = "10s"
  }
  lifecycle {
    prevent_destroy = false
  }
  enable_message_ordering    = false
}