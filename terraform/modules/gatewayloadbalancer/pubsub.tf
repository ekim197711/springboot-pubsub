resource "google_pubsub_topic" "topic_demo_inbox" {
  name = "demo_inbox"
  labels = {
    purpose = "development"
  }
  message_retention_duration = "86600s"
  lifecycle {
    prevent_destroy = true
  }
}

resource "google_pubsub_subscription" "subscription_demo_inbox" {
  name  = "demo_inbox"
  topic = google_pubsub_topic.topic_demo_inbox.name
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
    prevent_destroy = true
  }
  enable_message_ordering    = false
}