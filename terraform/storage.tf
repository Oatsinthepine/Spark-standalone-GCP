resource "google_service_account" "spark_cluster" {
  account_id   = "spark-cluster-sa"
  display_name = "Spark Standalone Cluster Service Account"
}


resource "google_storage_bucket" "spark_data" {
  name     = "${var.project_id}-spark-standalone-lab"
  location = var.region
  # uniform_bucket_level_access = true表示只使用bucket-level IAM，不再混用对象ACL，权限模型会更清晰
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"
  # 允许Terraform在bucket中仍有对象时强制删除bucket
  force_destroy = true

  labels = {
    project     = "spark-standalone-lab"
    environment = "learning"
  }
}

resource "google_storage_bucket_iam_member" "spark_object_admin" {
  bucket = google_storage_bucket.spark_data.name
  role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.spark_cluster.email}"
}
