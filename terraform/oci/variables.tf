
variable "compartment_ocid" {
  description = "Your tenant compartment id."
  type        = string
}

variable "oci_region" {
  description = "Your tenant reagion."
  type        = string
  default     = "ap-osaka-1"
}

variable "ssh_public_key_path" {
  type        = string
  description = "SSH public key for remote access to deployed instances."
}

