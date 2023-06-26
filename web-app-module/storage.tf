# s3 bucket resources of aws provider

resource "aws_s3_bucket" "web_app_bucket" {
  count         = var.create_db_and_s3 == true ? 1 : 0
  bucket_prefix = var.bucket_prefix
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "web_app_bucket_versionning" {
  count  = var.create_db_and_s3 == true ? 1 : 0
  bucket = aws_s3_bucket.web_app_bucket[0].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "web_app_bucket_server_side_crypto_conf" {
  count  = var.create_db_and_s3 == true ? 1 : 0
  bucket = aws_s3_bucket.web_app_bucket[0].id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}