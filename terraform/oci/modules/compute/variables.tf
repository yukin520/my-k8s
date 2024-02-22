
variable "compartment_ocid" {
  description = "Your tenant compartment id."
  type        = string
}

variable "oci_region" {
  description = "Your tenant reagion."
  type        = string
}

variable "mng_subnet_id" {
  type        = string
  description = "Subnet id for mangement instances."
}

variable "k8s_cluster_subnet_id" {
  type        = string
  description = "Subnet id for kubernetes cluster instances."
}

variable "ssh_public_key_path" {
  type        = string
  description = "SSH public key for remote access to deployed instances."
}

variable "ubuntu_amd_image_ocid" {
  type        = string
  description = "The ocid for instance image(Default is Canonical-Ubuntu-22.04-2024.01.05-0 at Osaka region). Refer to https://docs.oracle.com/en-us/iaas/images/"
  default     = "ocid1.image.oc1.ap-osaka-1.aaaaaaaa5xfjajkkqhgjirgv3wzira5afg5wpo2rcyuoklxtwjftaennvjia"
}

variable "ubuntu_arm_image_ocid" {
  type        = string
  description = "The ocid for instance image(Default is Canonical-Ubuntu-22.04-aarch64-2024.01.12-0 at Osaka region). Refer to https://docs.oracle.com/en-us/iaas/images/"
  default     = "ocid1.image.oc1.ap-osaka-1.aaaaaaaa4u7o3hvb2oupr3zus5cw2olbak3cppz3253zhx5rrakzglrtw6lq"
}

