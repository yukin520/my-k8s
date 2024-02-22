
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_ocid
}

resource "oci_core_vcn" "mng_vcn" {
  compartment_id = var.compartment_ocid
  cidr_blocks    = ["10.0.0.0/16"]
  display_name   = "mng-vcn"
}

resource "oci_core_internet_gateway" "main_internet_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.mng_vcn.id
  display_name   = "main-internet-gateway"
  enabled        = true
}

resource "oci_core_route_table" "main_route_table" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.mng_vcn.id
  display_name   = "main-route-table"
  route_rules {
    network_entity_id = oci_core_internet_gateway.main_internet_gateway.id
    description       = "All component can access to internet."
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
  }

}

resource "oci_core_security_list" "main_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.mng_vcn.id
  display_name   = "main-security-list"

  ingress_security_rules {
    protocol    = "6" # TCP
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "allow http."

    tcp_options {
      min = "80"
      max = "80"
    }
  }

  ingress_security_rules {
    protocol    = "6" # TCP
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "allow https."

    tcp_options {
      min = "443"
      max = "443"
    }
  }

  ingress_security_rules {
    protocol    = "6" # TCP
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "allow ssh."

    tcp_options {
      min = "22"
      max = "22"
    }
  }

  ingress_security_rules {
    protocol    = "all"
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "allow mng vcn tragfic."
  }

  egress_security_rules {
    destination      = "0.0.0.0/0"
    protocol         = "all"
    description      = "All trafic allow access."
    destination_type = "CIDR_BLOCK"
    stateless        = false
  }
}

resource "oci_core_subnet" "mng_subnet" {
  cidr_block        = "10.0.1.0/24"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.mng_vcn.id
  display_name      = "mng-subnet"
  route_table_id    = oci_core_route_table.main_route_table.id
  security_list_ids = [oci_core_security_list.main_security_list.id]
}


resource "oci_core_security_list" "k8s_cluster_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.mng_vcn.id
  display_name   = "k8s-cluster-security-list"

  ingress_security_rules {
    protocol    = "6" # TCP
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "allow http."

    tcp_options {
      min = "80"
      max = "80"
    }
  }

  ingress_security_rules {
    protocol    = "6" # TCP
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "allow https."

    tcp_options {
      min = "443"
      max = "443"
    }
  }

  ingress_security_rules {
    protocol    = "6" # TCP
    source      = "0.0.0.0/0"
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "allow all trafic to node port service."

    tcp_options {
      min = "30000"
      max = "32767"
    }
  }

  ingress_security_rules {
    protocol    = "all"
    source      = "10.0.0.0/16"
    source_type = "CIDR_BLOCK"
    stateless   = false
    description = "allow mng vcn tragfic."
  }

  egress_security_rules {
    destination      = "0.0.0.0/0"
    protocol         = "all"
    description      = "All trafic allow access."
    destination_type = "CIDR_BLOCK"
    stateless        = false
  }
}

resource "oci_core_subnet" "k8s_cluster_node_subnet" {
  cidr_block        = "10.0.2.0/24"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.mng_vcn.id
  display_name      = "k8s-cluster-node-subnet"
  route_table_id    = oci_core_route_table.main_route_table.id
  security_list_ids = [oci_core_security_list.k8s_cluster_security_list.id]
}
