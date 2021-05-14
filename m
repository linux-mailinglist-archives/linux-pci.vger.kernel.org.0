Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 964FD3813F7
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 00:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbhENW4C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 18:56:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:55449 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230371AbhENW4C (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 18:56:02 -0400
IronPort-SDR: 9egXFnNzGqiS4QZu9sC0vHLn0YfdvkwjzN4Msp5X/pqUOnxZEbq+F6EtqzaOtNkvfxOBPMZxbO
 xgSVGhOAMG4A==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="197160898"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="197160898"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 15:54:49 -0700
IronPort-SDR: YSeHCUhnXI2qHB2wtaxY9Ra2b0xR3vjecslyh5YIYnt8koRrtaIMzwjbk2//x/KAb+x72VJVHb
 209jlSWxUxIg==
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="393771592"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 15:54:49 -0700
Subject: [PATCH v5 7/8] cxl/port: Introduce cxl_port objects
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
Date:   Fri, 14 May 2021 15:54:49 -0700
Message-ID: <162103282600.1871742.13054562848745749829.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162096974181.1865304.15797095324295996480.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162096974181.1865304.15797095324295996480.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Once the cxl_root is established then other ports in the hierarchy can
be attached. The cxl_port object, unlike cxl_root that is associated
with host bridges, is associated with PCIe Root Ports or PCIe Switch
Ports. Add cxl_port instances for all PCIe Root Ports in an ACPI0016
host bridge. The cxl_port instances for PCIe Switch Ports are not
included here as those are to be modeled as another service device
registered on the pcie_port_bus_type.

A sample sysfs topology for a single-host-bridge with
single-PCIe/CXL-port follows:

/sys/bus/cxl/devices/root0
├── address_space0
│   ├── devtype
│   ├── end
│   ├── start
│   ├── supports_ram
│   ├── supports_type2
│   ├── supports_type3
│   └── uevent
├── address_space1
│   ├── devtype
│   ├── end
│   ├── start
│   ├── supports_pmem
│   ├── supports_type2
│   ├── supports_type3
│   └── uevent
├── devtype
├── port1
│   ├── devtype
│   ├── host -> ../../../../LNXSYSTM:00/LNXSYBUS:00/ACPI0016:00
│   ├── port2
│   │   ├── devtype
│   │   ├── host -> ../../../../../pci0000:34/0000:34:00.0
│   │   ├── subsystem -> ../../../../../../bus/cxl
│   │   ├── target_id
│   │   └── uevent
│   ├── subsystem -> ../../../../../bus/cxl
│   ├── target_id
│   └── uevent
├── subsystem -> ../../../../bus/cxl
├── target_id
└── uevent

In this listing the system-wide-singleton root0 has 2 address spaces, 1
PMEM and 1 RAM. Those address spaces are accessed through port1 which
represents the upstream port of an ACPI0016 host-bridge. A
multi-host-bridge system would have other ports as peers to port1 to
additionally decode root level address spaces. Port2 in this diagram
represents the single downstream port of the host-bridge. Were it to be
a multi-ported-host-bridge there would be peers / siblings of port2 with
port1 as their common ancestor.

The rationale for this port hierarchy is to be able to walk the HDM
decoder register sets that each port implements. Additionally it
provides a representation of host-bridge interleave which will be
necessary for follow-on work that adds CXL region devices.

The details in the /sys/bus/cxl hierarchy that are not suitable to be
represented in the /sys/bus/pci hierarchy are:
- memory address spaces that are interleaved across host bridges
- common sub-device functionality represented by CXL component + device
  registers (enumerated via DVSEC or platform firmware (ACPI CEDT)).

Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v4:
- Reflow the ABI documentation to 80 columns and fix tabs vs spaces
  (Jonathan)

 Documentation/ABI/testing/sysfs-bus-cxl |   11 +++
 drivers/cxl/acpi.c                      |   99 +++++++++++++++++++++++++
 drivers/cxl/core.c                      |  121 +++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h                       |    5 +
 4 files changed, 235 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 53a051ad7f32..a956cbad15f9 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -87,6 +87,17 @@ Description:
 		capability is supported, and is not present, or shows "0" is the
 		capability is not supported.
 
+What:		/sys/bus/cxl/devices/portX/host
+Date:		May, 2021
+KernelVersion:	v5.14
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		CXL port objects are enumerated from either a platform firmware
+		device (representing a host bridge), or a PCIe device
+		(representing a root port, or a switch port). The 'host' symlink
+		connects the CXL portX object to the device that published the
+		CXL port capability.
+
 What:		/sys/bus/cxl/devices/portX/target_id
 Date:		May, 2021
 KernelVersion:	v5.14
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index d54c2d5de730..c33641eef032 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -5,18 +5,117 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
 #include <linux/acpi.h>
+#include <linux/pci.h>
 #include "cxl.h"
 
+static int match_ACPI0016(struct device *dev, const void *host)
+{
+	struct acpi_device *adev = to_acpi_device(dev);
+	const char *hid = acpi_device_hid(adev);
+
+	return strcmp(hid, "ACPI0016") == 0;
+}
+
+struct cxl_walk_context {
+	struct device *dev;
+	struct pci_bus *root;
+	struct cxl_port *port;
+	int error;
+	int count;
+};
+
+static int match_add_root_ports(struct pci_dev *pdev, void *data)
+{
+	struct cxl_walk_context *ctx = data;
+	struct pci_bus *root_bus = ctx->root;
+	struct cxl_port *port = ctx->port;
+	int type = pci_pcie_type(pdev);
+	struct device *dev = ctx->dev;
+	resource_size_t cxl_regs_phys;
+	int target_id = ctx->count;
+
+	if (pdev->bus != root_bus)
+		return 0;
+	if (!pci_is_pcie(pdev))
+		return 0;
+	if (type != PCI_EXP_TYPE_ROOT_PORT)
+		return 0;
+
+	ctx->count++;
+
+	/* TODO walk DVSEC to find component register base */
+	cxl_regs_phys = -1;
+
+	port = devm_cxl_add_port(dev, port, &pdev->dev, target_id,
+				 cxl_regs_phys);
+	if (IS_ERR(port)) {
+		ctx->error = PTR_ERR(port);
+		return ctx->error;
+	}
+
+	dev_dbg(dev, "%s: register: %s\n", dev_name(&pdev->dev),
+		dev_name(&port->dev));
+
+	return 0;
+}
+
+/*
+ * A host bridge may contain one or more root ports.  Register each port
+ * as a child of the cxl_root.
+ */
+static int cxl_acpi_register_ports(struct device *dev, struct acpi_device *root,
+				   struct cxl_port *port, int idx)
+{
+	struct acpi_pci_root *pci_root = acpi_pci_find_root(root->handle);
+	struct cxl_walk_context ctx;
+
+	if (!pci_root)
+		return -ENXIO;
+
+	/* TODO: fold in CEDT.CHBS retrieval */
+	port = devm_cxl_add_port(dev, port, &root->dev, idx, ~0);
+	if (IS_ERR(port))
+		return PTR_ERR(port);
+	dev_dbg(dev, "%s: register: %s\n", dev_name(&root->dev),
+		dev_name(&port->dev));
+
+	ctx = (struct cxl_walk_context) {
+		.dev = dev,
+		.root = pci_root->bus,
+		.port = port,
+	};
+	pci_walk_bus(pci_root->bus, match_add_root_ports, &ctx);
+
+	if (ctx.count == 0)
+		return -ENODEV;
+	return ctx.error;
+}
+
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
+	struct device *bridge = NULL;
 	struct cxl_root *cxl_root;
+	int rc, i = 0;
 
 	cxl_root = devm_cxl_add_root(dev, NULL, 0);
 	if (IS_ERR(cxl_root))
 		return PTR_ERR(cxl_root);
 	dev_dbg(dev, "register: %s\n", dev_name(&cxl_root->port.dev));
 
+	while (true) {
+		bridge = bus_find_device(adev->dev.bus, bridge, dev,
+					 match_ACPI0016);
+		if (!bridge)
+			break;
+
+		rc = cxl_acpi_register_ports(dev, to_acpi_device(bridge),
+					     &cxl_root->port, i++);
+		if (rc)
+			return rc;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 27d6bbc29a38..456e675dc567 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -153,6 +153,15 @@ static void cxl_root_release(struct device *dev)
 	kfree(cxl_root);
 }
 
+static void cxl_port_release(struct device *dev)
+{
+	struct cxl_port *port = to_cxl_port(dev);
+
+	ida_free(&cxl_port_ida, port->id);
+	put_device(port->port_host);
+	kfree(port);
+}
+
 static ssize_t target_id_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
@@ -183,6 +192,12 @@ static const struct device_type cxl_root_type = {
 	.groups = cxl_port_attribute_groups,
 };
 
+static const struct device_type cxl_port_type = {
+	.name = "cxl_port",
+	.release = cxl_port_release,
+	.groups = cxl_port_attribute_groups,
+};
+
 struct cxl_root *to_cxl_root(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, dev->type != &cxl_root_type,
@@ -193,7 +208,9 @@ struct cxl_root *to_cxl_root(struct device *dev)
 
 struct cxl_port *to_cxl_port(struct device *dev)
 {
-	if (dev_WARN_ONCE(dev, dev->type != &cxl_root_type,
+	if (dev_WARN_ONCE(dev,
+			  dev->type != &cxl_root_type &&
+			  dev->type != &cxl_port_type,
 			  "not a cxl_port device\n"))
 		return NULL;
 	return container_of(dev, struct cxl_port, dev);
@@ -372,6 +389,108 @@ struct cxl_root *devm_cxl_add_root(struct device *host,
 }
 EXPORT_SYMBOL_GPL(devm_cxl_add_root);
 
+static void cxl_unlink_port(void *_port)
+{
+	struct cxl_port *port = _port;
+
+	sysfs_remove_link(&port->dev.kobj, "host");
+}
+
+static int devm_cxl_link_port(struct device *dev, struct cxl_port *port)
+{
+	int rc;
+
+	rc = sysfs_create_link(&port->dev.kobj, &port->port_host->kobj, "host");
+	if (rc)
+		return rc;
+	return devm_add_action_or_reset(dev, cxl_unlink_port, port);
+}
+
+static struct cxl_port *cxl_port_alloc(struct cxl_port *parent_port,
+				       struct device *port_dev, int target_id,
+				       resource_size_t component_regs_phys)
+{
+	struct cxl_port *port;
+	struct device *dev;
+	int rc;
+
+	if (!port_dev)
+		return ERR_PTR(-EINVAL);
+
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ida_alloc(&cxl_port_ida, GFP_KERNEL);
+	if (rc < 0)
+		goto err;
+
+	port->id = rc;
+	port->target_id = target_id;
+	port->port_host = get_device(port_dev);
+	port->component_regs_phys = component_regs_phys;
+
+	dev = &port->dev;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = &parent_port->dev;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_port_type;
+
+	return port;
+
+err:
+	kfree(port);
+	return ERR_PTR(rc);
+}
+
+/**
+ * devm_cxl_add_port() - add a cxl_port to the topology
+ * @host: devm context / discovery agent
+ * @parent_port: immediate ancestor towards cxl_root
+ * @port_host: PCI or platform-firmware device hosting this port
+ * @target_id: ordinal id relative to other siblings under @parent_port
+ * @component_regs_phys: CXL component register base address
+ */
+struct cxl_port *devm_cxl_add_port(struct device *host,
+				   struct cxl_port *parent_port,
+				   struct device *port_host, int target_id,
+				   resource_size_t component_regs_phys)
+{
+	struct cxl_port *port;
+	struct device *dev;
+	int rc;
+
+	port = cxl_port_alloc(parent_port, port_host, target_id,
+			      component_regs_phys);
+	if (IS_ERR(port))
+		return port;
+
+	dev = &port->dev;
+	rc = dev_set_name(dev, "port%d", port->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	rc = devm_add_action_or_reset(host, unregister_dev, dev);
+	if (rc)
+		return ERR_PTR(rc);
+
+	rc = devm_cxl_link_port(host, port);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return port;
+
+err:
+	put_device(dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_GPL(devm_cxl_add_port);
+
 /**
  * cxl_setup_device_regs() - Detect CXL Device register blocks
  * @dev: Host device of the @base mapping
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 5cd1173151e5..71a991bdacb7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -134,5 +134,10 @@ struct cxl_address_space_dev *to_cxl_address_space(struct device *dev);
 struct cxl_root *devm_cxl_add_root(struct device *parent,
 				   struct cxl_address_space *cxl_space,
 				   int nr_spaces);
+struct cxl_port *devm_cxl_add_port(struct device *host,
+				   struct cxl_port *parent_port,
+				   struct device *port_host, int target_id,
+				   resource_size_t component_regs_phys);
+
 extern struct bus_type cxl_bus_type;
 #endif /* __CXL_H__ */

