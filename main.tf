provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }
  object_lock_configuration {
    object_lock_enabled = "Enabled"
  }
  replication_configuration {
    role = aws_iam_role.replication.arn

    rules {
      id     = "my-replication-rule"
      status = "Disabled"
    }
  }
}
