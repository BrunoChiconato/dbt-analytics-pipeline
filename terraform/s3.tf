resource "aws_s3_bucket" "dbt_artifacts" {
  bucket = "${var.project_name}-dbt-artifacts-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name = "${var.project_name}-dbt-artifacts"
  }
}

resource "aws_s3_bucket_versioning" "dbt_artifacts" {
  bucket = aws_s3_bucket.dbt_artifacts.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket" "dbt_docs" {
  bucket = "${var.project_name}-dbt-docs-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name = "${var.project_name}-dbt-docs"
  }
}

resource "aws_s3_bucket_website_configuration" "dbt_docs" {
  bucket = aws_s3_bucket.dbt_docs.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_public_access_block" "dbt_docs" {
  bucket = aws_s3_bucket.dbt_docs.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "dbt_docs" {
  bucket = aws_s3_bucket.dbt_docs.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.dbt_docs.arn}/*"
      }
    ]
  })
}

data "aws_caller_identity" "current" {}