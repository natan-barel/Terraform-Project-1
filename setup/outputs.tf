output "s3_bucket_terraform_state" {
  value = aws_s3_bucket.terraform_state.bucket
}

output "s3_bucket_terraform_state_region" {
  value = aws_s3_bucket.terraform_state.region
}
