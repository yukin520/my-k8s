terraform {
  backend "s3" {
    endpoints = {
      s3 = "https://axj80fnfazk4.compat.objectstorage.ap-osaka-1.oraclecloud.com"
    }
    region = "ap-osaka-1"
    bucket = "for-terraform-state-k8s"
    key    = "tf.tfstate"

    # refer to https://docs.oracle.com/ja-jp/iaas/Content/API/SDKDocs/terraformUsingObjectStore.htm#s3
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    use_path_style              = true
    insecure                    = true
    skip_metadata_api_check     = true

    # Terraform1.6以上ではこちらを追加しないと以下のようなエラーがApplyの際に発生する。
    # > Error saving state: failed to upload state: operation error S3: PutObject, 
    # > https response error StatusCode: 400, RequestID:
    # TerraformのGithubリポジトリ上のIssueでも議論がなされいている
    # https://github.com/hashicorp/terraform/issues/34053
    skip_s3_checksum            = true

  }
}
