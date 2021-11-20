Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA24579F1
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhKTAGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:5724 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236249AbhKTAGM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542421"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542421"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:03:01 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088415"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:03:00 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 22/23] cxl/mem: Introduce cxl_mem driver
Date:   Fri, 19 Nov 2021 16:02:49 -0800
Message-Id: <20211120000250.1663391-23-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a driver that is capable of determining whether a device is in a
CXL.mem routed part of the topology.

This driver allows a higher level driver - such as one controlling CXL
regions, which is itself a set of CXL devices - to easily determine if
the CXL devices are CXL.mem capable by checking if the driver has bound.
CXL memory device services may also be provided by this driver though
none are needed as of yet. cxl_mem also plays the part of registering
itself as an endpoint port, which is a required step to enumerate the
device's HDM decoder resources.

Even though cxl_mem driver is the only consumer of the new
cxl_scan_ports() introduced in cxl_core, because that functionality has
PCIe specificity it is kept out of this driver.

As part of this patch, find_dport_by_dev() is promoted to the cxl_core's
set of APIs for use by the new driver.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
Changes since RFCv2:
- Squashed this in with previous patch
- Reworked parent port finding
- Added DVSEC check
- Added wait for active
---
 .../driver-api/cxl/memory-devices.rst         |   9 +
 drivers/cxl/Kconfig                           |  15 ++
 drivers/cxl/Makefile                          |   2 +
 drivers/cxl/acpi.c                            |  22 +-
 drivers/cxl/core/Makefile                     |   1 +
 drivers/cxl/core/bus.c                        | 135 +++++++++++-
 drivers/cxl/core/core.h                       |   3 +
 drivers/cxl/core/memdev.c                     |   2 +-
 drivers/cxl/core/pci.c                        | 119 +++++++++++
 drivers/cxl/cxl.h                             |   8 +-
 drivers/cxl/cxlmem.h                          |   3 +
 drivers/cxl/mem.c                             | 192 ++++++++++++++++++
 drivers/cxl/pci.h                             |   4 +
 drivers/cxl/port.c                            |  12 +-
 tools/testing/cxl/Kbuild                      |   1 +
 15 files changed, 503 insertions(+), 25 deletions(-)
 create mode 100644 drivers/cxl/core/pci.c
 create mode 100644 drivers/cxl/mem.c

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index fbf0393cdddc..b4ff5f209c34 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -28,6 +28,9 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/pci.c
    :internal:
 
+.. kernel-doc:: drivers/cxl/mem.c
+   :doc: cxl mem
+
 CXL Port
 --------
 .. kernel-doc:: drivers/cxl/port.c
@@ -47,6 +50,12 @@ CXL Core
 .. kernel-doc:: drivers/cxl/core/bus.c
    :identifiers:
 
+.. kernel-doc:: drivers/cxl/core/pci.c
+   :doc: cxl core pci
+
+.. kernel-doc:: drivers/cxl/core/pci.c
+   :identifiers:
+
 .. kernel-doc:: drivers/cxl/core/pmem.c
    :doc: cxl pmem
 
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 3aeb33bba5a3..f5553443ba2a 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -30,6 +30,21 @@ config CXL_PCI
 
 	  If unsure say 'm'.
 
+config CXL_MEM
+	tristate "CXL.mem: Memory Devices"
+	default CXL_BUS
+        help
+          The CXL.mem protocol allows a device to act as a provider of
+	  "System RAM" and/or "Persistent Memory" that is fully coherent
+	  as if the memory was attached to the typical CPU memory controller.
+	  This is known as HDM "Host-managed Device Memory".
+
+	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
+	  memory expansion and control of HDM. See Chapter 9.13 in the CXL 2.0
+	  specification for a detailed description of HDM.
+
+	  If unsure say 'm'.
+
 config CXL_MEM_RAW_COMMANDS
 	bool "RAW Command Interface for Memory Devices"
 	depends on CXL_PCI
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 56fcac2323cb..ce267ef11d93 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += core/
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
+obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_PORT) += cxl_port.o
 
+cxl_mem-y := mem.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index c85a04ecbf7f..d17aa7d8b1c9 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -171,21 +171,6 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
 	return 0;
 }
 
-static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, struct device *dev)
-{
-	struct cxl_dport *dport;
-
-	device_lock(&port->dev);
-	list_for_each_entry(dport, &port->dports, list)
-		if (dport->dport == dev) {
-			device_unlock(&port->dev);
-			return dport;
-		}
-
-	device_unlock(&port->dev);
-	return NULL;
-}
-
 __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
 					      struct device *dev)
 {
@@ -216,13 +201,14 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (!bridge)
 		return 0;
 
-	dport = find_dport_by_dev(root_port, match);
+	dport = cxl_find_dport_by_dev(root_port, match);
 	if (!dport) {
 		dev_dbg(host, "host bridge expected and not found\n");
 		return 0;
 	}
 
-	port = devm_cxl_add_port(match, dport->component_reg_phys, root_port);
+	port = devm_cxl_add_port(match, dport->component_reg_phys, root_port,
+				 NULL);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
@@ -360,7 +346,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	root_port = devm_cxl_add_port(host, CXL_RESOURCE_NONE, root_port);
+	root_port = devm_cxl_add_port(host, CXL_RESOURCE_NONE, root_port, NULL);
 	if (IS_ERR(root_port))
 		return PTR_ERR(root_port);
 	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 40ab50318daf..5b8ec478fb0b 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -7,3 +7,4 @@ cxl_core-y += pmem.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
+cxl_core-y += pci.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index acfa212eea21..cab3aabd5abc 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -8,6 +8,7 @@
 #include <linux/idr.h>
 #include <cxlmem.h>
 #include <cxl.h>
+#include <pci.h>
 #include "core.h"
 
 /**
@@ -436,7 +437,7 @@ static int devm_cxl_link_uport(struct device *host, struct cxl_port *port)
 
 static struct cxl_port *cxl_port_alloc(struct device *uport,
 				       resource_size_t component_reg_phys,
-				       struct cxl_port *parent_port)
+				       struct cxl_port *parent_port, void *data)
 {
 	struct cxl_port *port;
 	struct device *dev;
@@ -465,6 +466,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 
 	port->uport = uport;
 	port->component_reg_phys = component_reg_phys;
+	port->data = data;
 	ida_init(&port->decoder_ida);
 	INIT_LIST_HEAD(&port->dports);
 
@@ -485,16 +487,17 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
  * @uport: "physical" device implementing this upstream port
  * @component_reg_phys: (optional) for configurable cxl_port instances
  * @parent_port: next hop up in the CXL memory decode hierarchy
+ * @data: opaque data to be used by the port driver
  */
 struct cxl_port *devm_cxl_add_port(struct device *uport,
 				   resource_size_t component_reg_phys,
-				   struct cxl_port *parent_port)
+				   struct cxl_port *parent_port, void *data)
 {
 	struct device *dev, *host;
 	struct cxl_port *port;
 	int rc;
 
-	port = cxl_port_alloc(uport, component_reg_phys, parent_port);
+	port = cxl_port_alloc(uport, component_reg_phys, parent_port, data);
 	if (IS_ERR(port))
 		return port;
 
@@ -531,6 +534,113 @@ struct cxl_port *devm_cxl_add_port(struct device *uport,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, CXL);
 
+static int add_upstream_port(struct device *host, struct pci_dev *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cxl_port *parent_port;
+	struct cxl_register_map map;
+	struct cxl_port *port;
+	int rc;
+
+	/* A port is useless if there are no component registers */
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		return rc;
+
+	parent_port = find_parent_cxl_port(pdev);
+	if (!parent_port)
+		return -ENODEV;
+
+	if (!parent_port->dev.driver) {
+		dev_dbg(dev, "Upstream port has no driver\n");
+		put_device(&parent_port->dev);
+		return -ENODEV;
+	}
+
+	port = devm_cxl_add_port(dev, cxl_reg_block(pdev, &map), parent_port,
+				 NULL);
+	put_device(&parent_port->dev);
+	if (IS_ERR(port))
+		dev_err(dev, "Failed to add upstream port %ld\n",
+			PTR_ERR(port));
+	else
+		dev_dbg(dev, "Added CXL port\n");
+
+	return rc;
+}
+
+static int add_downstream_port(struct pci_dev *pdev)
+{
+	resource_size_t creg = CXL_RESOURCE_NONE;
+	struct device *dev = &pdev->dev;
+	struct cxl_port *parent_port;
+	struct cxl_register_map map;
+	u32 lnkcap, port_num;
+	int rc;
+
+	/*
+	 * Ports are to be scanned from top down. Therefore, the upstream port
+	 * must already exist.
+	 */
+	parent_port = find_parent_cxl_port(pdev);
+	if (!parent_port)
+		return -ENODEV;
+
+	if (!parent_port->dev.driver) {
+		dev_dbg(dev, "Host port to dport has no driver\n");
+		put_device(&parent_port->dev);
+		return -ENODEV;
+	}
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		creg = CXL_RESOURCE_NONE;
+	else
+		creg = cxl_reg_block(pdev, &map);
+
+	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
+				  &lnkcap) != PCIBIOS_SUCCESSFUL)
+		return 1;
+	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+
+	rc = cxl_add_dport(parent_port, dev, port_num, creg, false);
+	put_device(&parent_port->dev);
+	if (rc)
+		dev_err(dev, "Failed to add downstream port to %s\n",
+			dev_name(&parent_port->dev));
+	else
+		dev_dbg(dev, "Added downstream port to %s\n",
+			dev_name(&parent_port->dev));
+
+	return rc;
+}
+
+static int match_add_ports(struct pci_dev *pdev, void *data)
+{
+	struct device *dev = &pdev->dev;
+	struct device *host = data;
+
+	if (is_cxl_switch_usp((dev)))
+		return add_upstream_port(host, pdev);
+	else if (is_cxl_switch_dsp((dev)))
+		return add_downstream_port(pdev);
+	else
+		return 0;
+}
+
+/**
+ * cxl_scan_ports() - Adds all ports for the subtree beginning with @dport
+ * @dport: Beginning node of the CXL topology
+ */
+void cxl_scan_ports(struct cxl_dport *dport)
+{
+	struct device *d = dport->dport;
+	struct pci_dev *pdev = to_pci_dev(d);
+
+	pci_walk_bus(pdev->bus, match_add_ports, &dport->port->dev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_scan_ports, CXL);
+
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
@@ -614,6 +724,23 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_add_dport, CXL);
 
+struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
+					struct device *dev)
+{
+	struct cxl_dport *dport;
+
+	device_lock(&port->dev);
+	list_for_each_entry(dport, &port->dports, list)
+		if (dport->dport == dev) {
+			device_unlock(&port->dev);
+			return dport;
+		}
+
+	device_unlock(&port->dev);
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_find_dport_by_dev, CXL);
+
 static int decoder_populate_targets(struct cxl_decoder *cxld,
 				    struct cxl_port *port, int *target_map)
 {
@@ -858,6 +985,8 @@ static int cxl_device_id(struct device *dev)
 		return CXL_DEVICE_NVDIMM;
 	if (dev->type == &cxl_port_type)
 		return CXL_DEVICE_PORT;
+	if (dev->type == &cxl_memdev_type)
+		return CXL_DEVICE_MEMORY_EXPANDER;
 	return 0;
 }
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e0c9aacc4e9c..c5836f071eaa 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
+extern const struct device_type cxl_memdev_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
@@ -20,4 +21,6 @@ void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
 void cxl_mbox_exit(void);
 
+struct cxl_port *find_parent_cxl_port(struct pci_dev *pdev);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 61029cb7ac62..149665fd2d3f 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -127,7 +127,7 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	NULL,
 };
 
-static const struct device_type cxl_memdev_type = {
+const struct device_type cxl_memdev_type = {
 	.name = "cxl_memdev",
 	.release = cxl_memdev_release,
 	.devnode = cxl_memdev_devnode,
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
new file mode 100644
index 000000000000..818e30571e4d
--- /dev/null
+++ b/drivers/cxl/core/pci.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <cxl.h>
+#include <pci.h>
+#include "core.h"
+
+/**
+ * DOC: cxl core pci
+ *
+ * Compute Express Link protocols are layered on top of PCIe. CXL core provides
+ * a set of helpers for CXL interactions which occur via PCIe.
+ */
+
+/**
+ * find_parent_cxl_port() - Finds parent port through PCIe mechanisms
+ * @pdev: PCIe USP or DSP to find an upstream port for
+ *
+ * Once all CXL ports are enumerated, there is no need to reference the PCIe
+ * parallel universe as all downstream ports are contained in a linked list, and
+ * all upstream ports are accessible via pointer. During the enumeration, it is
+ * very convenient to be able to peak up one level in the hierarchy without
+ * needing the established relationship between data structures so that the
+ * parenting can be done as the ports/dports are created.
+ *
+ * A reference is kept to the found port.
+ */
+struct cxl_port *find_parent_cxl_port(struct pci_dev *pdev)
+{
+	struct device *parent_dev, *gparent_dev;
+
+	/* Parent is either a downstream port, or root port */
+	parent_dev = get_device(pdev->dev.parent);
+
+	if (is_cxl_switch_usp(&pdev->dev)) {
+		if (dev_WARN_ONCE(&pdev->dev,
+				  pci_pcie_type(pdev) !=
+						  PCI_EXP_TYPE_DOWNSTREAM &&
+					  pci_pcie_type(pdev) !=
+						  PCI_EXP_TYPE_ROOT_PORT,
+				  "Parent not downstream\n"))
+			goto err;
+
+		/*
+		 * Grandparent is either an upstream port or a platform device that has
+		 * been added as a cxl_port already.
+		 */
+		gparent_dev = get_device(parent_dev->parent);
+		put_device(parent_dev);
+
+		return to_cxl_port(gparent_dev);
+	} else if (is_cxl_switch_dsp(&pdev->dev)) {
+		if (dev_WARN_ONCE(&pdev->dev,
+				  pci_pcie_type(pdev) != PCI_EXP_TYPE_UPSTREAM,
+				  "Parent not upstream"))
+			goto err;
+		return to_cxl_port(parent_dev);
+	}
+
+err:
+	dev_WARN(&pdev->dev, "Invalid topology\n");
+	put_device(parent_dev);
+	return NULL;
+}
+
+/*
+ * Unlike endpoints, switches don't discern CXL.mem capability. Simply finding
+ * the DVSEC is sufficient.
+ */
+static bool is_cxl_switch(struct pci_dev *pdev)
+{
+	return pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+					 CXL_DVSEC_PORT_EXTENSIONS);
+}
+
+/**
+ * is_cxl_switch_usp() - Is the device a CXL.mem enabled switch
+ * @dev: Device to query for switch type
+ *
+ * If the device is a CXL.mem capable upstream switch port return true;
+ * otherwise return false.
+ */
+bool is_cxl_switch_usp(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return false;
+
+	pdev = to_pci_dev(dev);
+
+	return pci_is_pcie(pdev) &&
+	       pci_pcie_type(pdev) == PCI_EXP_TYPE_UPSTREAM &&
+	       is_cxl_switch(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_switch_usp, CXL);
+
+/**
+ * is_cxl_switch_dsp() - Is the device a CXL.mem enabled switch
+ * @dev: Device to query for switch type
+ *
+ * If the device is a CXL.mem capable downstream switch port return true;
+ * otherwise return false.
+ */
+bool is_cxl_switch_dsp(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return false;
+
+	pdev = to_pci_dev(dev);
+
+	return pci_is_pcie(pdev) &&
+	       pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM &&
+	       is_cxl_switch(pdev);
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_switch_dsp, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f8354241c5a3..3bda806f4244 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -296,6 +296,7 @@ struct cxl_port {
  * @port: reference to cxl_port that contains this downstream port
  * @list: node for a cxl_port's list of cxl_dport instances
  * @root_port_link: node for global list of root ports
+ * @data: Opaque data passed by other drivers, used by port driver
  */
 struct cxl_dport {
 	struct device *dport;
@@ -304,16 +305,20 @@ struct cxl_dport {
 	struct cxl_port *port;
 	struct list_head list;
 	struct list_head root_port_link;
+	void *data;
 };
 
 struct cxl_port *to_cxl_port(struct device *dev);
 struct cxl_port *devm_cxl_add_port(struct device *uport,
 				   resource_size_t component_reg_phys,
-				   struct cxl_port *parent_port);
+				   struct cxl_port *parent_port, void *data);
+void cxl_scan_ports(struct cxl_dport *root_port);
 
 int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 		  resource_size_t component_reg_phys, bool root_port);
 struct cxl_dport *cxl_get_root_dport(struct device *dev);
+struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
+					struct device *dev);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
@@ -349,6 +354,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_NVDIMM_BRIDGE	1
 #define CXL_DEVICE_NVDIMM		2
 #define CXL_DEVICE_PORT			3
+#define CXL_DEVICE_MEMORY_EXPANDER	4
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index b1d753541f4e..de8f6fce74b5 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -35,12 +35,15 @@
  * @cdev: char dev core object for ioctl operations
  * @cxlds: The device state backing this device
  * @id: id number of this memdev instance.
+ * @component_reg_phys: register base of component registers
+ * @root_port: Hostbridge's root port connected to this endpoint
  */
 struct cxl_memdev {
 	struct device dev;
 	struct cdev cdev;
 	struct cxl_dev_state *cxlds;
 	int id;
+	struct cxl_dport *root_port;
 };
 
 static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
new file mode 100644
index 000000000000..e954144af4b8
--- /dev/null
+++ b/drivers/cxl/mem.c
@@ -0,0 +1,192 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "cxlmem.h"
+#include "pci.h"
+
+/**
+ * DOC: cxl mem
+ *
+ * CXL memory endpoint devices and switches are CXL capable devices that are
+ * participating in CXL.mem protocol. Their functionality builds on top of the
+ * CXL.io protocol that allows enumerating and configuring components via
+ * standard PCI mechanisms.
+ *
+ * The cxl_mem driver owns kicking off the enumeration of this CXL.mem
+ * capability. With the detection of a CXL capable endpoint, the driver will
+ * walk up to find the platform specific port it is connected to, and determine
+ * if there are intervening switches in the path. If there are switches, a
+ * secondary action to enumerate those (implemented in cxl_core). Finally the
+ * cxl_mem driver will add the device it is bound to as a CXL port for use in
+ * higher level operations.
+ */
+
+struct walk_ctx {
+	struct cxl_dport *root_port;
+	bool has_switch;
+};
+
+/**
+ * walk_to_root_port() - Walk up to root port
+ * @dev: Device to walk up from
+ * @ctx: Information to populate while walking
+ *
+ * A platform specific driver such as cxl_acpi is responsible for scanning CXL
+ * topologies in a top-down fashion. If the CXL memory device is directly
+ * connected to the top level hostbridge, nothing else needs to be done. If
+ * however there are CXL components (ie. a CXL switch) in between an endpoint
+ * and a hostbridge the platform specific driver must be notified after all the
+ * components are enumerated.
+ */
+static void walk_to_root_port(struct device *dev, struct walk_ctx *ctx)
+{
+	struct cxl_dport *root_port;
+
+	if (!dev->parent)
+		return;
+
+	root_port = cxl_get_root_dport(dev);
+	if (root_port)
+		ctx->root_port = root_port;
+
+	if (is_cxl_switch_usp(dev))
+		ctx->has_switch = true;
+
+	walk_to_root_port(dev->parent, ctx);
+}
+
+static void remove_endpoint(void *_cxlmd)
+{
+	struct cxl_memdev *cxlmd = _cxlmd;
+
+	if (cxlmd->root_port)
+		sysfs_remove_link(&cxlmd->dev.kobj, "root_port");
+}
+
+static int wait_for_media(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_endpoint_dvsec_info *info = cxlds->info;
+	int rc;
+
+	if (!info)
+		return -ENXIO;
+
+	if (!info->mem_enabled)
+		return -EBUSY;
+
+	rc = cxlds->wait_media_ready(cxlds);
+	if (rc)
+		return rc;
+
+	/*
+	 * We know the device is active, and enabled, if any ranges are non-zero
+	 * we'll need to check later before adding the port since that owns the
+	 * HDM decoder registers.
+	 */
+	return 0;
+}
+
+static int create_endpoint(struct device *dev, struct cxl_port *parent,
+			   struct cxl_dport *dport)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_endpoint_dvsec_info *info = cxlds->info;
+	struct cxl_port *endpoint;
+	int rc;
+
+	endpoint =
+		devm_cxl_add_port(dev, cxlds->component_reg_phys, parent, info);
+	if (IS_ERR(endpoint))
+		return PTR_ERR(endpoint);
+
+	rc = sysfs_create_link(&cxlmd->dev.kobj, &dport->dport->kobj,
+			       "root_port");
+	if (rc) {
+		device_del(&endpoint->dev);
+		return rc;
+	}
+	dev_dbg(dev, "add: %s\n", dev_name(&endpoint->dev));
+
+	return devm_add_action_or_reset(dev, remove_endpoint, cxlmd);
+}
+
+static int cxl_mem_probe(struct device *dev)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_port *hostbridge, *parent_port;
+	struct walk_ctx ctx = { NULL, false };
+	struct cxl_dport *dport;
+	int rc;
+
+	rc = wait_for_media(cxlmd);
+	if (rc) {
+		dev_err(dev, "Media not active (%d)\n", rc);
+		return rc;
+	}
+
+	walk_to_root_port(dev, &ctx);
+
+	/*
+	 * Couldn't find a CXL capable root port. This may happen even with a
+	 * CXL capable topology if cxl_acpi hasn't completed yet. A rescan will
+	 * occur.
+	 */
+	if (!ctx.root_port)
+		return -ENODEV;
+
+	hostbridge = ctx.root_port->port;
+	device_lock(&hostbridge->dev);
+
+	/* hostbridge has no port driver, the topology isn't enabled yet */
+	if (!hostbridge->dev.driver) {
+		device_unlock(&hostbridge->dev);
+		return -ENODEV;
+	}
+
+	/* No switch + found root port means we're done */
+	if (!ctx.has_switch) {
+		parent_port = to_cxl_port(&hostbridge->dev);
+		dport = ctx.root_port;
+		goto out;
+	}
+
+	/* Walk down from the root port and add all switches */
+	cxl_scan_ports(ctx.root_port);
+
+	/* If parent is a dport the endpoint is good to go. */
+	parent_port = to_cxl_port(dev->parent->parent);
+	dport = cxl_find_dport_by_dev(parent_port, dev->parent);
+	if (!dport) {
+		rc = -ENODEV;
+		goto err_out;
+	}
+
+out:
+	rc = create_endpoint(dev, parent_port, dport);
+	if (rc)
+		goto err_out;
+
+	cxlmd->root_port = ctx.root_port;
+
+err_out:
+	device_unlock(&hostbridge->dev);
+	return rc;
+}
+
+static struct cxl_driver cxl_mem_driver = {
+	.name = "cxl_mem",
+	.probe = cxl_mem_probe,
+	.id = CXL_DEVICE_MEMORY_EXPANDER,
+};
+
+module_cxl_driver(cxl_mem_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
+MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
+MODULE_SOFTDEP("pre: cxl_port");
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 2a48cd65bf59..3fd0909522f2 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -15,6 +15,7 @@
 
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
+
 #define   CXL_DVSEC_PCIE_DEVICE_CAP_OFFSET			0xA
 #define     CXL_DVSEC_PCIE_DEVICE_MEM_CAPABLE			BIT(2)
 #define     CXL_DVSEC_PCIE_DEVICE_HDM_COUNT_MASK		GENMASK(5, 4)
@@ -64,4 +65,7 @@ enum cxl_regloc_type {
 	((resource_size_t)(pci_resource_start(pdev, (map)->barno) +            \
 			   (map)->block_offset))
 
+bool is_cxl_switch_usp(struct device *dev);
+bool is_cxl_switch_dsp(struct device *dev);
+
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 7a1fc726fe9f..02b1c8cf7567 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -108,8 +108,16 @@ static u64 get_decoder_size(void __iomem *hdm_decoder, int n)
 
 static bool is_endpoint_port(struct cxl_port *port)
 {
-	/* Endpoints can't be ports... yet! */
-	return false;
+	/*
+	 * It's tempting to just check list_empty(port->dports) here, but this
+	 * might get called before dports are setup for a port.
+	 */
+
+	if (!port->uport->driver)
+		return false;
+
+	return to_cxl_drv(port->uport->driver)->id ==
+	       CXL_DEVICE_MEMORY_EXPANDER;
 }
 
 static void rescan_ports(struct work_struct *work)
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 1acdf2fc31c5..4c2359772f3c 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -30,6 +30,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pmem.o
 cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
+cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += config_check.o
 
 cxl_core-y += mock_pmem.o
-- 
2.34.0

