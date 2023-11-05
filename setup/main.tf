# Define a s3 bucket to store terraform state file.
resource "aws_s3_bucket" "terraform_state" {
  //NOTE: make sure the bucket name is global unique, otherwise the creation fails.
  bucket_prefix = format("%s-tf-state-", var.bucket_prefix)
  force_destroy = false
  lifecycle {
    ignore_changes = [bucket]
  }
  tags = {
    "Region" : local.region
    "Environment" : "DEV"
    "Project" : "Terraform Project 1"
  }
}

resource "aws_s3_bucket_acl" "terraform_state" {
  bucket     = aws_s3_bucket.terraform_state.id
  acl        = var.acl
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    object_ownership = "ObjectWriter"
  }
  depends_on = [aws_s3_bucket_public_access_block.terraform_state]
}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket                  = aws_s3_bucket.terraform_state.id
  block_public_acls       = true
  block_public_policy     = true
  restrict_public_buckets = true
  ignore_public_acls      = true
}

resource "aws_s3_bucket_ownership_controls" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

