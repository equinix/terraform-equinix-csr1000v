# Equinix Network Edge example: Cisco CSR 1000V Router

This example shows how to create redundant Cisco CSR1000V routers on Platform Equinix
using Equinix CSR1000V Terraform module and Equinix Terraform provider.

In addition to pair of CSR1000V devices, following resources are being created
in this example:

* SSH user that is assigned to both devices
* two ACL templates, one for each of the device

The devices are created in Equinix managed mode with license subscription.
Remaining parameters include:

* 1 Gbps of license throughput
* medium hardware platform (4CPU cores, 4GB of memory)
* IPBASE software package
* 50 Mbps of additional internet bandwidth on each device
