# Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2

/*
    DESCRIPTION:
    VMware vSphere variables used for all builds.
    - Variables are use by the source blocks.
*/

// vSphere Credentials
vsphere_endpoint            = "vcenter02-gs.intnet"
vsphere_username            = "Administrator@vsphere.local"
vsphere_password            = "D3ll_VxRa1l"
vsphere_insecure_connection = true

// vSphere Settings
vsphere_datacenter                     = "Interxion Brussels"
vsphere_cluster                        = "GS-vxrail01"
//vsphere_host                           = ""
vsphere_datastore                      = "GS-VSAN01"
vsphere_network                        = "intern routed"
vsphere_folder                         = ""
//vsphere_resource_pool                  = ""
vsphere_set_host_for_datastore_uploads = false
