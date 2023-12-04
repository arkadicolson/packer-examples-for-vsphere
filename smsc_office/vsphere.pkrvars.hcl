# Copyright 2023 VMware, Inc. All rights reserved
# SPDX-License-Identifier: BSD-2

/*
    DESCRIPTION:
    VMware vSphere variables used for all builds.
    - Variables are use by the source blocks.
*/

// vSphere Credentials
vsphere_endpoint            = "vcenter.officemeeuwen.smartbit.be"
vsphere_username            = "Administrator@smartbit.local"
vsphere_password            = "Lzma=4)31!"
vsphere_insecure_connection = true

// vSphere Settings
vsphere_datacenter                     = "BNK Meeuwen"
vsphere_cluster                        = "BNK"
//vsphere_host                           = ""
vsphere_datastore                      = "DAS esxi01-bnk - data"
vsphere_network                        = "intern routed"
vsphere_folder                         = ""
//vsphere_resource_pool                  = ""
vsphere_set_host_for_datastore_uploads = false
