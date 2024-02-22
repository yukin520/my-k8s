
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

# Client instance
resource "oci_core_instance" "client_instance" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  shape               = "VM.Standard.E2.1.Micro"
  source_details {
    source_id               = var.ubuntu_amd_image_ocid
    source_type             = "image"
    boot_volume_size_in_gbs = 50
  }
  display_name = "ubuntu-client01"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = var.mng_subnet_id
  }
  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }
  preserve_boot_volume = false
}

# Cluster node instances.
resource "oci_core_instance" "cluster_controle_plane_01" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = 12
    ocpus         = 2
  }
  source_details {
    source_id               = var.ubuntu_arm_image_ocid
    source_type             = "image"
    boot_volume_size_in_gbs = 50
  }
  display_name = "ubuntu-cluster-controle-plane01"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = var.k8s_cluster_subnet_id
  }
  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }
  preserve_boot_volume = false
}


resource "oci_core_instance" "cluster_data_plane_01" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = 6
    ocpus         = 1
  }
  source_details {
    source_id               = var.ubuntu_arm_image_ocid
    source_type             = "image"
    boot_volume_size_in_gbs = 50
  }
  display_name = "ubuntu-cluster-data-plane01"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = var.k8s_cluster_subnet_id
  }
  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }
  preserve_boot_volume = false
}


resource "oci_core_instance" "cluster_data_plane_02" {
  availability_domain = data.oci_identity_availability_domains.ads.availability_domains[0].name
  compartment_id      = var.compartment_ocid
  shape               = "VM.Standard.A1.Flex"
  shape_config {
    memory_in_gbs = 6
    ocpus         = 1
  }
  source_details {
    source_id               = var.ubuntu_arm_image_ocid
    source_type             = "image"
    boot_volume_size_in_gbs = 50
  }
  display_name = "ubuntu-cluster-data-plane02"
  create_vnic_details {
    assign_public_ip = true
    subnet_id        = var.k8s_cluster_subnet_id
  }
  metadata = {
    ssh_authorized_keys = file(var.ssh_public_key_path)
  }
  preserve_boot_volume = false
}
