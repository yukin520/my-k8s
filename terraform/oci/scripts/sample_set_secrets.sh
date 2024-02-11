
## refer to -> https://docs.oracle.com/ja-jp/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm
export OCI_DEFAULT_CERTS_PATH=<certificates_path>
export TF_VAR_tenancy_ocid=<tenancy_OCID>
export TF_VAR_compartment_ocid=<compartment_OCID>
export TF_VAR_user_ocid=<user_OCID>
export TF_VAR_fingerprint=<key_fingerprint>
export TF_VAR_private_key_path=<private_key_path>
export TF_VAR_region=<region>
export USER_AGENT_PROVIDER_NAME=<custom_user_agent>
export OCI_SDK_APPEND_USER_AGENT=<custom_user_agent>
export TF_APPEND_USER_AGENT=<custom_user_agent>

# if use object storage to save tfstate
export AWS_SECRET_ACCESS_KEY=<s3 secret access key>
export AWS_ACCESS_KEY_ID=<s3 access key id>