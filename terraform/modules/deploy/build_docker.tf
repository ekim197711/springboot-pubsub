#resource "docker_image" "mikes-demo-pubsub" {
#  name = "europe-west2-docker.pkg.dev/${var.project_name}/${google_artifact_registry_repository.docker-registry.repository_id}/mikes-demo-pubsub"
#  build {
#    path = "../../../"
#    context = "."
#    tag     = ["latest"]
#    label = {
#      author : "Mike"
#    }
#  }
#}