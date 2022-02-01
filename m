Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FCD4A66CD
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 22:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242706AbiBAVIL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 16:08:11 -0500
Received: from mga05.intel.com ([192.55.52.43]:19350 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241045AbiBAVIK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 16:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643749690; x=1675285690;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jtHQ4SIcn8oY3gqOjqMJniTa+0qnruX2W8h2wyaHaD8=;
  b=S/8hzM9sfx29zsTdpC2IjS62CY3ZZHIF7OKbaUl8yGAsBOYJdRWEHE6A
   X9tWuH+MvgHzsqV9djuZO7JLGSnnk0r+YNJ+bGx6lHnOi0fpwWzGGJ8Qp
   rMMkcYCW2aMbup5sW3OZE4d8ThYZ008kdum4Vepn6PfuR9C79wYEhAsxX
   OLC51uQ2xLgqNKnyhjfydxUnDxPtZemop1QUg09fX7bNpH6FGH3rEjNjj
   hqAq9SWNAHeOy+L58X5t011CSHD6Oe+ZutaUHbm8DhycLOwbIi5zDcOKt
   L9AoiN7P3d+FnxkP4UAe1FM3vT8zLW0C3Hr+qak5LeY1laftm1MA5YEX1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="334152234"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="334152234"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 13:07:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="482536037"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 13:07:51 -0800
Subject: [PATCH v5 24/40] cxl/port: Add a driver for 'struct cxl_port'
 objects
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Tue, 01 Feb 2022 13:07:51 -0800
Message-ID: <164374948116.464348.1772618057599155408.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164322817812.3708001.17146719098062400994.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164322817812.3708001.17146719098062400994.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

The need for a CXL port driver and a dedicated cxl_bus_type is driven by
a need to simultaneously support 2 independent physical memory decode
domains (cache coherent CXL.mem and uncached PCI.mmio) that also
intersect at a single PCIe device node. A CXL Port is a device that
advertises a  CXL Component Register block with an "HDM Decoder
Capability Structure".

>From Documentation/driver-api/cxl/memory-devices.rst:

    Similar to how a RAID driver takes disk objects and assembles them into
    a new logical device, the CXL subsystem is tasked to take PCIe and ACPI
    objects and assemble them into a CXL.mem decode topology. The need for
    runtime configuration of the CXL.mem topology is also similar to RAID in
    that different environments with the same hardware configuration may
    decide to assemble the topology in contrasting ways. One may choose
    performance (RAID0) striping memory across multiple Host Bridges and
    endpoints while another may opt for fault tolerance and disable any
    striping in the CXL.mem topology.

The port driver identifies whether an endpoint Memory Expander is
connected to a CXL topology. If an active (bound to the 'cxl_port'
driver) CXL Port is not found at every PCIe Switch Upstream port and an
active "root" CXL Port then the device is just a plain PCIe endpoint
only capable of participating in PCI.mmio and DMA cycles, not CXL.mem
coherent interleave sets.

The 'cxl_port' driver lets the CXL subsystem leverage driver-core
infrastructure for setup and teardown of register resources and
communicating device activation status to userspace. The cxl_bus_type
can rendezvous the async arrival of platform level CXL resources (via
the 'cxl_acpi' driver) with the asynchronous enumeration of Memory
Expander endpoints, while also implementing a hierarchical locking model
independent of the associated 'struct pci_dev' locking model. The
locking for dport and decoder enumeration is now handled in the core
rather than callers.

For now the port driver only enumerates and registers CXL resources
(downstream port metadata and decoder resources) later it will be used
to take action on its decoders in response to CXL.mem region
provisioning requests.

Note1: cxlpci.h has long depended on pci.h, but port.c was the first to
not include pci.h. Carry that dependency in cxlpci.h.

Note2: cxl port enumeration and probing complicates CXL subsystem init
to the point that it helps to have centralized debug logging of probe
events in cxl_bus_probe().

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v4:
- Rebase on cxl_dport_remove() fixups
- s/cond_port_lock/cond_cxl_root_lock/ (Jonathan)
- Note why the new pci.h include (Jonathan)
- Note why new dev_dbg() in cxl_bus_probe() (Jonathan)
- Whitespace fixup (Jonathan)

 Documentation/driver-api/cxl/memory-devices.rst |  302 +++++++++++++++++++++++
 drivers/cxl/Kconfig                             |    5 
 drivers/cxl/Makefile                            |    2 
 drivers/cxl/acpi.c                              |   26 --
 drivers/cxl/core/pci.c                          |    2 
 drivers/cxl/core/port.c                         |   34 ++-
 drivers/cxl/cxl.h                               |    4 
 drivers/cxl/cxlpci.h                            |    1 
 drivers/cxl/port.c                              |   63 +++++
 tools/testing/cxl/Kbuild                        |    5 
 tools/testing/cxl/test/cxl.c                    |    2 
 11 files changed, 415 insertions(+), 31 deletions(-)
 create mode 100644 drivers/cxl/port.c

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index c8f7a16cd0e3..3498d38d7cbd 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -14,6 +14,303 @@ that optionally define a device's contribution to an interleaved address
 range across multiple devices underneath a host-bridge or interleaved
 across host-bridges.
 
+CXL Bus: Theory of Operation
+============================
+Similar to how a RAID driver takes disk objects and assembles them into a new
+logical device, the CXL subsystem is tasked to take PCIe and ACPI objects and
+assemble them into a CXL.mem decode topology. The need for runtime configuration
+of the CXL.mem topology is also similar to RAID in that different environments
+with the same hardware configuration may decide to assemble the topology in
+contrasting ways. One may choose performance (RAID0) striping memory across
+multiple Host Bridges and endpoints while another may opt for fault tolerance
+and disable any striping in the CXL.mem topology.
+
+Platform firmware enumerates a menu of interleave options at the "CXL root port"
+(Linux term for the top of the CXL decode topology). From there, PCIe topology
+dictates which endpoints can participate in which Host Bridge decode regimes.
+Each PCIe Switch in the path between the root and an endpoint introduces a point
+at which the interleave can be split. For example platform firmware may say at a
+given range only decodes to 1 one Host Bridge, but that Host Bridge may in turn
+interleave cycles across multiple Root Ports. An intervening Switch between a
+port and an endpoint may interleave cycles across multiple Downstream Switch
+Ports, etc.
+
+Here is a sample listing of a CXL topology defined by 'cxl_test'. The 'cxl_test'
+module generates an emulated CXL topology of 2 Host Bridges each with 2 Root
+Ports. Each of those Root Ports are connected to 2-way switches with endpoints
+connected to those downstream ports for a total of 8 endpoints::
+
+    # cxl list -BEMPu -b cxl_test
+    {
+      "bus":"root3",
+      "provider":"cxl_test",
+      "ports:root3":[
+        {
+          "port":"port5",
+          "host":"cxl_host_bridge.1",
+          "ports:port5":[
+            {
+              "port":"port8",
+              "host":"cxl_switch_uport.1",
+              "endpoints:port8":[
+                {
+                  "endpoint":"endpoint9",
+                  "host":"mem2",
+                  "memdev":{
+                    "memdev":"mem2",
+                    "pmem_size":"256.00 MiB (268.44 MB)",
+                    "ram_size":"256.00 MiB (268.44 MB)",
+                    "serial":"0x1",
+                    "numa_node":1,
+                    "host":"cxl_mem.1"
+                  }
+                },
+                {
+                  "endpoint":"endpoint15",
+                  "host":"mem6",
+                  "memdev":{
+                    "memdev":"mem6",
+                    "pmem_size":"256.00 MiB (268.44 MB)",
+                    "ram_size":"256.00 MiB (268.44 MB)",
+                    "serial":"0x5",
+                    "numa_node":1,
+                    "host":"cxl_mem.5"
+                  }
+                }
+              ]
+            },
+            {
+              "port":"port12",
+              "host":"cxl_switch_uport.3",
+              "endpoints:port12":[
+                {
+                  "endpoint":"endpoint17",
+                  "host":"mem8",
+                  "memdev":{
+                    "memdev":"mem8",
+                    "pmem_size":"256.00 MiB (268.44 MB)",
+                    "ram_size":"256.00 MiB (268.44 MB)",
+                    "serial":"0x7",
+                    "numa_node":1,
+                    "host":"cxl_mem.7"
+                  }
+                },
+                {
+                  "endpoint":"endpoint13",
+                  "host":"mem4",
+                  "memdev":{
+                    "memdev":"mem4",
+                    "pmem_size":"256.00 MiB (268.44 MB)",
+                    "ram_size":"256.00 MiB (268.44 MB)",
+                    "serial":"0x3",
+                    "numa_node":1,
+                    "host":"cxl_mem.3"
+                  }
+                }
+              ]
+            }
+          ]
+        },
+        {
+          "port":"port4",
+          "host":"cxl_host_bridge.0",
+          "ports:port4":[
+            {
+              "port":"port6",
+              "host":"cxl_switch_uport.0",
+              "endpoints:port6":[
+                {
+                  "endpoint":"endpoint7",
+                  "host":"mem1",
+                  "memdev":{
+                    "memdev":"mem1",
+                    "pmem_size":"256.00 MiB (268.44 MB)",
+                    "ram_size":"256.00 MiB (268.44 MB)",
+                    "serial":"0",
+                    "numa_node":0,
+                    "host":"cxl_mem.0"
+                  }
+                },
+                {
+                  "endpoint":"endpoint14",
+                  "host":"mem5",
+                  "memdev":{
+                    "memdev":"mem5",
+                    "pmem_size":"256.00 MiB (268.44 MB)",
+                    "ram_size":"256.00 MiB (268.44 MB)",
+                    "serial":"0x4",
+                    "numa_node":0,
+                    "host":"cxl_mem.4"
+                  }
+                }
+              ]
+            },
+            {
+              "port":"port10",
+              "host":"cxl_switch_uport.2",
+              "endpoints:port10":[
+                {
+                  "endpoint":"endpoint16",
+                  "host":"mem7",
+                  "memdev":{
+                    "memdev":"mem7",
+                    "pmem_size":"256.00 MiB (268.44 MB)",
+                    "ram_size":"256.00 MiB (268.44 MB)",
+                    "serial":"0x6",
+                    "numa_node":0,
+                    "host":"cxl_mem.6"
+                  }
+                },
+                {
+                  "endpoint":"endpoint11",
+                  "host":"mem3",
+                  "memdev":{
+                    "memdev":"mem3",
+                    "pmem_size":"256.00 MiB (268.44 MB)",
+                    "ram_size":"256.00 MiB (268.44 MB)",
+                    "serial":"0x2",
+                    "numa_node":0,
+                    "host":"cxl_mem.2"
+                  }
+                }
+              ]
+            }
+          ]
+        }
+      ]
+    }
+
+In that listing each "root", "port", and "endpoint" object correspond a kernel
+'struct cxl_port' object. A 'cxl_port' is a device that can decode CXL.mem to
+its descendants. So "root" claims non-PCIe enumerable platform decode ranges and
+decodes them to "ports", "ports" decode to "endpoints", and "endpoints"
+represent the decode from SPA (System Physical Address) to DPA (Device Physical
+Address).
+
+Continuing the RAID analogy, disks have both topology metadata and on device
+metadata that determine RAID set assembly. CXL Port topology and CXL Port link
+status is metadata for CXL.mem set assembly. The CXL Port topology is enumerated
+by the arrival of a CXL.mem device. I.e. unless and until the PCIe core attaches
+the cxl_pci driver to a CXL Memory Expander there is no role for CXL Port
+objects. Conversely for hot-unplug / removal scenarios, there is no need for
+the Linux PCI core to tear down switch-level CXL resources because the endpoint
+->remove() event cleans up the port data that was established to support that
+Memory Expander.
+
+The port metadata and potential decode schemes that a give memory device may
+participate can be determined via a command like::
+
+    # cxl list -BDMu -d root -m mem3
+    {
+      "bus":"root3",
+      "provider":"cxl_test",
+      "decoders:root3":[
+        {
+          "decoder":"decoder3.1",
+          "resource":"0x8030000000",
+          "size":"512.00 MiB (536.87 MB)",
+          "volatile_capable":true,
+          "nr_targets":2
+        },
+        {
+          "decoder":"decoder3.3",
+          "resource":"0x8060000000",
+          "size":"512.00 MiB (536.87 MB)",
+          "pmem_capable":true,
+          "nr_targets":2
+        },
+        {
+          "decoder":"decoder3.0",
+          "resource":"0x8020000000",
+          "size":"256.00 MiB (268.44 MB)",
+          "volatile_capable":true,
+          "nr_targets":1
+        },
+        {
+          "decoder":"decoder3.2",
+          "resource":"0x8050000000",
+          "size":"256.00 MiB (268.44 MB)",
+          "pmem_capable":true,
+          "nr_targets":1
+        }
+      ],
+      "memdevs:root3":[
+        {
+          "memdev":"mem3",
+          "pmem_size":"256.00 MiB (268.44 MB)",
+          "ram_size":"256.00 MiB (268.44 MB)",
+          "serial":"0x2",
+          "numa_node":0,
+          "host":"cxl_mem.2"
+        }
+      ]
+    }
+
+...which queries the CXL topology to ask "given CXL Memory Expander with a kernel
+device name of 'mem3' which platform level decode ranges may this device
+participate". A given expander can participate in multiple CXL.mem interleave
+sets simultaneously depending on how many decoder resource it has. In this
+example mem3 can participate in one or more of a PMEM interleave that spans to
+Host Bridges, a PMEM interleave that targets a single Host Bridge, a Volatile
+memory interleave that spans 2 Host Bridges, and a Volatile memory interleave
+that only targets a single Host Bridge.
+
+Conversely the memory devices that can participate in a given platform level
+decode scheme can be determined via a command like the following::
+
+    # cxl list -MDu -d 3.2
+    [
+      {
+        "memdevs":[
+          {
+            "memdev":"mem1",
+            "pmem_size":"256.00 MiB (268.44 MB)",
+            "ram_size":"256.00 MiB (268.44 MB)",
+            "serial":"0",
+            "numa_node":0,
+            "host":"cxl_mem.0"
+          },
+          {
+            "memdev":"mem5",
+            "pmem_size":"256.00 MiB (268.44 MB)",
+            "ram_size":"256.00 MiB (268.44 MB)",
+            "serial":"0x4",
+            "numa_node":0,
+            "host":"cxl_mem.4"
+          },
+          {
+            "memdev":"mem7",
+            "pmem_size":"256.00 MiB (268.44 MB)",
+            "ram_size":"256.00 MiB (268.44 MB)",
+            "serial":"0x6",
+            "numa_node":0,
+            "host":"cxl_mem.6"
+          },
+          {
+            "memdev":"mem3",
+            "pmem_size":"256.00 MiB (268.44 MB)",
+            "ram_size":"256.00 MiB (268.44 MB)",
+            "serial":"0x2",
+            "numa_node":0,
+            "host":"cxl_mem.2"
+          }
+        ]
+      },
+      {
+        "root decoders":[
+          {
+            "decoder":"decoder3.2",
+            "resource":"0x8050000000",
+            "size":"256.00 MiB (268.44 MB)",
+            "pmem_capable":true,
+            "nr_targets":1
+          }
+        ]
+      }
+    ]
+
+...where the naming scheme for decoders is "decoder<port_id>.<instance_id>".
+
 Driver Infrastructure
 =====================
 
@@ -28,6 +325,11 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/pci.c
    :internal:
 
+CXL Port
+--------
+.. kernel-doc:: drivers/cxl/port.c
+   :doc: cxl port
+
 CXL Core
 --------
 .. kernel-doc:: drivers/cxl/cxl.h
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index ef05e96f8f97..4f4f7587f6ca 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -77,4 +77,9 @@ config CXL_PMEM
 	  provisioning the persistent memory capacity of CXL memory expanders.
 
 	  If unsure say 'm'.
+
+config CXL_PORT
+	default CXL_BUS
+	tristate
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index cf07ae6cea17..56fcac2323cb 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -3,7 +3,9 @@ obj-$(CONFIG_CXL_BUS) += core/
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
+obj-$(CONFIG_CXL_PORT) += cxl_port.o
 
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
+cxl_port-y := port.o
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 8c2ced91518b..82591642ea90 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -169,7 +169,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
 	struct acpi_pci_root *pci_root;
 	struct cxl_dport *dport;
-	struct cxl_hdm *cxlhdm;
 	struct cxl_port *port;
 	int rc;
 
@@ -197,28 +196,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return PTR_ERR(port);
 	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
 
-	rc = devm_cxl_port_enumerate_dports(host, port);
-	if (rc < 0)
-		return rc;
-	cxl_device_lock(&port->dev);
-	if (rc == 1) {
-		rc = devm_cxl_add_passthrough_decoder(host, port);
-		goto out;
-	}
-
-	cxlhdm = devm_cxl_setup_hdm(host, port);
-	if (IS_ERR(cxlhdm)) {
-		rc = PTR_ERR(cxlhdm);
-		goto out;
-	}
-
-	rc = devm_cxl_enumerate_decoders(host, cxlhdm);
-	if (rc)
-		dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
-
-out:
-	cxl_device_unlock(&port->dev);
-	return rc;
+	return 0;
 }
 
 struct cxl_chbs_context {
@@ -278,9 +256,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 		return 0;
 	}
 
-	cxl_device_lock(&root_port->dev);
 	dport = devm_cxl_add_dport(host, root_port, match, uid, ctx.chbcr);
-	cxl_device_unlock(&root_port->dev);
 	if (IS_ERR(dport)) {
 		dev_err(host, "failed to add downstream port: %s\n",
 			dev_name(match));
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c5a9e03ed477..8ec5f74da679 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -47,10 +47,8 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 		dev_dbg(&port->dev, "failed to find component registers\n");
 
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	cxl_device_lock(&port->dev);
 	dport = devm_cxl_add_dport(ctx->host, port, &pdev->dev, port_num,
 				   cxl_regmap_to_base(pdev, &map));
-	cxl_device_unlock(&port->dev);
 	if (IS_ERR(dport)) {
 		ctx->error = PTR_ERR(dport);
 		return PTR_ERR(dport);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0bbd8fb8f35d..a66284b7eb1b 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -40,6 +40,11 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM_BRIDGE;
 	if (dev->type == &cxl_nvdimm_type)
 		return CXL_DEVICE_NVDIMM;
+	if (is_cxl_port(dev)) {
+		if (is_cxl_root(to_cxl_port(dev)))
+			return CXL_DEVICE_ROOT;
+		return CXL_DEVICE_PORT;
+	}
 	return 0;
 }
 
@@ -298,6 +303,9 @@ static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
 
+	if (!is_cxl_root(port))
+		device_lock_assert(port->dev.parent);
+
 	device_unregister(&port->dev);
 }
 
@@ -526,15 +534,34 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
 	return dup ? -EEXIST : 0;
 }
 
+/*
+ * Since root-level CXL dports cannot be enumerated by PCI they are not
+ * enumerated by the common port driver that acquires the port lock over
+ * dport add/remove. Instead, root dports are manually added by a
+ * platform driver and cond_cxl_root_lock() is used to take the missing
+ * port lock in that case.
+ */
+static void cond_cxl_root_lock(struct cxl_port *port)
+{
+	if (is_cxl_root(port))
+		cxl_device_lock(&port->dev);
+}
+
+static void cond_cxl_root_unlock(struct cxl_port *port)
+{
+	if (is_cxl_root(port))
+		cxl_device_unlock(&port->dev);
+}
+
 static void cxl_dport_remove(void *data)
 {
 	struct cxl_dport *dport = data;
 	struct cxl_port *port = dport->port;
 
 	put_device(dport->dport);
-	cxl_device_lock(&port->dev);
+	cond_cxl_root_lock(port);
 	list_del(&dport->list);
-	cxl_device_unlock(&port->dev);
+	cond_cxl_root_unlock(port);
 }
 
 static void cxl_dport_unlink(void *data)
@@ -587,7 +614,9 @@ struct cxl_dport *devm_cxl_add_dport(struct device *host, struct cxl_port *port,
 	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
 
+	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
+	cond_cxl_root_unlock(port);
 	if (rc)
 		return ERR_PTR(rc);
 
@@ -895,6 +924,7 @@ static int cxl_bus_probe(struct device *dev)
 	rc = to_cxl_drv(dev->driver)->probe(dev);
 	cxl_nested_unlock(dev);
 
+	dev_dbg(dev, "probe: %d\n", rc);
 	return rc;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c127d5c0ac96..2b24eb56618f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -163,6 +163,8 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 enum cxl_regloc_type;
 int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		      struct cxl_register_map *map);
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
 
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
@@ -354,6 +356,8 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
+#define CXL_DEVICE_PORT			3
+#define CXL_DEVICE_ROOT			4
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 103636fda198..47640f19e899 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #ifndef __CXL_PCI_H__
 #define __CXL_PCI_H__
+#include <linux/pci.h>
 #include "cxl.h"
 
 #define CXL_MEMORY_PROGIF	0x10
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
new file mode 100644
index 000000000000..daa4c3c33aed
--- /dev/null
+++ b/drivers/cxl/port.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "cxlmem.h"
+#include "cxlpci.h"
+
+/**
+ * DOC: cxl port
+ *
+ * The port driver enumerates dport via PCI and scans for HDM
+ * (Host-managed-Device-Memory) decoder resources via the
+ * @component_reg_phys value passed in by the agent that registered the
+ * port. All descendant ports of a CXL root port (described by platform
+ * firmware) are managed in this drivers context. Each driver instance
+ * is responsible for tearing down the driver context of immediate
+ * descendant ports. The locking for this is validated by
+ * CONFIG_PROVE_CXL_LOCKING.
+ *
+ * The primary service this driver provides is presenting APIs to other
+ * drivers to utilize the decoders, and indicating to userspace (via bind
+ * status) the connectivity of the CXL.mem protocol throughout the
+ * PCIe topology.
+ */
+
+static int cxl_port_probe(struct device *dev)
+{
+	struct cxl_port *port = to_cxl_port(dev);
+	struct cxl_hdm *cxlhdm;
+	int rc;
+
+	rc = devm_cxl_port_enumerate_dports(dev, port);
+	if (rc < 0)
+		return rc;
+
+	if (rc == 1)
+		return devm_cxl_add_passthrough_decoder(dev, port);
+
+	cxlhdm = devm_cxl_setup_hdm(dev, port);
+	if (IS_ERR(cxlhdm))
+		return PTR_ERR(cxlhdm);
+
+	rc = devm_cxl_enumerate_decoders(dev, cxlhdm);
+	if (rc) {
+		dev_err(dev, "Couldn't enumerate decoders (%d)\n", rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static struct cxl_driver cxl_port_driver = {
+	.name = "cxl_port",
+	.probe = cxl_port_probe,
+	.id = CXL_DEVICE_PORT,
+};
+
+module_cxl_driver(cxl_port_driver);
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
+MODULE_ALIAS_CXL(CXL_DEVICE_PORT);
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 3045d7cba0db..27ae13e23e79 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -26,6 +26,11 @@ obj-m += cxl_pmem.o
 cxl_pmem-y := $(CXL_SRC)/pmem.o
 cxl_pmem-y += config_check.o
 
+obj-m += cxl_port.o
+
+cxl_port-y := $(CXL_SRC)/port.o
+cxl_port-y += config_check.o
+
 obj-m += cxl_core.o
 
 cxl_core-y := $(CXL_CORE_SRC)/port.o
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 81c09380c537..ce6ace286fc7 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -437,10 +437,8 @@ static int mock_cxl_port_enumerate_dports(struct device *host,
 		if (pdev->dev.parent != port->uport)
 			continue;
 
-		cxl_device_lock(&port->dev);
 		dport = devm_cxl_add_dport(host, port, &pdev->dev, pdev->id,
 					   CXL_RESOURCE_NONE);
-		cxl_device_unlock(&port->dev);
 
 		if (IS_ERR(dport)) {
 			dev_err(dev, "failed to add dport: %s (%ld)\n",

