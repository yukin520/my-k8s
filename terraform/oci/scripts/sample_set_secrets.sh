
## refer to -> https://docs.oracle.com/ja-jp/iaas/Content/API/SDKDocs/terraformproviderconfiguration.htm
export TF_VAR_tenancy_ocid=<tenancy_OCID>
export TF_VAR_compartment_ocid=<compartment_OCID>
export TF_VAR_user_ocid=<user_OCID>
export TF_VAR_fingerprint=<key_fingerprint>
export TF_VAR_private_key_path=<private_key_path>

# if use object storage to save tfstate
export AWS_SECRET_ACCESS_KEY=<s3 secret access key>
export AWS_ACCESS_KEY_ID=<s3 access key id>

# local ssh public key file path for instances.
export TF_VAR_ssh_public_key_path=<your local public ssh key path>