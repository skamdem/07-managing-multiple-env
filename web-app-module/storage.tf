# s3 bucket resources of aws provider

resource "aws_s3_bucket" "web_app_bucket" {
  bucket_prefix = var.bucket_prefix
  force_destroy = true
}

resource "aws_s3_bucket_versioning" "web_app_bucket_versionning" {
  bucket = aws_s3_bucket.web_app_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "web_app_bucket_server_side_crypto_conf" {
  bucket = aws_s3_bucket.web_app_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}