Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DA84A5523
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 03:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiBACKH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 21:10:07 -0500
Received: from mga04.intel.com ([192.55.52.120]:57055 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232077AbiBACKF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 21:10:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643681405; x=1675217405;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NM5ZX9JSAVbAJidzM9R0Bh3b2RyIqsuMYD5+izYUus4=;
  b=Y0BwMxzpMk+jfVN9/I4I0tOEo/1+LGPb/JVFXz0pEjKpyLyF3CdWXXgx
   7EvX7NspjILdjkTzari50ol1b2cfRyovl5ylmX8G5JSgJscOO8XHZVO8d
   8RSG8yittfG2FhkFdXWzMI0S1dZozCgg0Gv/F4WnREPDyUEBy6XiiPRmo
   VWWVMcKG5af8xaxxxpj2dPXUV4H+iRbi7+2VtKPM8nU/C80RSMHs9YokB
   uOibUSNZLT4ekgtYTnS6AuN5A5bU1dSDGfWDpwvjLo8quGUWRPbpY/j7Z
   2BGaCvyfN041kJKPHVT4ut3P7MDg5GhDOD4AyR8YmnErfnVEvk+zzQKHA
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="246440448"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="246440448"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 18:10:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="534382338"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 18:10:04 -0800
Subject: [PATCH v4 21/40] cxl/core: Generalize dport enumeration in the core
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Mon, 31 Jan 2022 18:10:04 -0800
Message-ID: <164368114191.354031.5270501846455462665.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298423047.3018233.6769866347542494809.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298423047.3018233.6769866347542494809.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The core houses infrastructure for decoder resources. A CXL port's
dports are more closely related to decoder infrastructure than topology
enumeration. Implement generic PCI based dport enumeration in the core,
i.e. arrange for existing root port enumeration from cxl_acpi to share
code with switch port enumeration which just amounts to a small
difference in a pci_walk_bus() invocation once the appropriate 'struct
pci_bus' has been retrieved.

Set the convention that decoder objects are registered after all dports
are enumerated. This enables userspace to know when the CXL core is
finished establishing 'dportX' links underneath the 'portX' object.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v3:
- Rebase on cxl_device_lock() changes from patch 19
- Clarify changelog (Jonathan)
- Drop some local variables in match_add_dports() (Jonathan)
- Cleanup pci_read_config_dword() error handling (Jonathan)
- Switch a list_del_init() to list_del() (Jonathan)
- Reorder cxl_dport_remove() (Jonathan)

 drivers/cxl/acpi.c            |   67 +++------------------------
 drivers/cxl/core/Makefile     |    1 
 drivers/cxl/core/pci.c        |  101 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c       |   91 +++++++++++++++++++++----------------
 drivers/cxl/cxl.h             |   16 ++----
 drivers/cxl/cxlpci.h          |    1 
 tools/testing/cxl/Kbuild      |    3 +
 tools/testing/cxl/mock_acpi.c |   78 --------------------------------
 tools/testing/cxl/test/cxl.c  |   67 +++++++++++++++++++--------
 tools/testing/cxl/test/mock.c |   45 ++++++++----------
 tools/testing/cxl/test/mock.h |    6 ++
 11 files changed, 238 insertions(+), 238 deletions(-)
 create mode 100644 drivers/cxl/core/pci.c

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 8d4fd7534e1e..259441245687 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -130,48 +130,6 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	return 0;
 }
 
-__mock int match_add_root_ports(struct pci_dev *pdev, void *data)
-{
-	resource_size_t creg = CXL_RESOURCE_NONE;
-	struct cxl_walk_context *ctx = data;
-	struct pci_bus *root_bus = ctx->root;
-	struct cxl_port *port = ctx->port;
-	int type = pci_pcie_type(pdev);
-	struct device *dev = ctx->dev;
-	struct cxl_register_map map;
-	u32 lnkcap, port_num;
-	int rc;
-
-	if (pdev->bus != root_bus)
-		return 0;
-	if (!pci_is_pcie(pdev))
-		return 0;
-	if (type != PCI_EXP_TYPE_ROOT_PORT)
-		return 0;
-	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
-				  &lnkcap) != PCIBIOS_SUCCESSFUL)
-		return 0;
-
-	/* The driver doesn't rely on component registers for Root Ports yet. */
-	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
-	if (!rc)
-		dev_info(&pdev->dev, "No component register block found\n");
-
-	creg = cxl_regmap_to_base(pdev, &map);
-
-	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
-	if (rc) {
-		ctx->error = rc;
-		return rc;
-	}
-	ctx->count++;
-
-	dev_dbg(dev, "add dport%d: %s\n", port_num, dev_name(&pdev->dev));
-
-	return 0;
-}
-
 static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, struct device *dev)
 {
 	struct cxl_dport *dport;
@@ -210,7 +168,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	struct device *host = root_port->dev.parent;
 	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
 	struct acpi_pci_root *pci_root;
-	struct cxl_walk_context ctx;
 	int single_port_map[1], rc;
 	struct cxl_decoder *cxld;
 	struct cxl_dport *dport;
@@ -240,18 +197,10 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 		return PTR_ERR(port);
 	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
 
-	ctx = (struct cxl_walk_context){
-		.dev = host,
-		.root = pci_root->bus,
-		.port = port,
-	};
-	pci_walk_bus(pci_root->bus, match_add_root_ports, &ctx);
-
-	if (ctx.count == 0)
-		return -ENODEV;
-	if (ctx.error)
-		return ctx.error;
-	if (ctx.count > 1)
+	rc = devm_cxl_port_enumerate_dports(host, port);
+	if (rc < 0)
+		return rc;
+	if (rc > 1)
 		return 0;
 
 	/* TODO: Scan CHBCR for HDM Decoder resources */
@@ -311,9 +260,9 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
 
 static int add_host_bridge_dport(struct device *match, void *arg)
 {
-	int rc;
 	acpi_status status;
 	unsigned long long uid;
+	struct cxl_dport *dport;
 	struct cxl_chbs_context ctx;
 	struct cxl_port *root_port = arg;
 	struct device *host = root_port->dev.parent;
@@ -343,12 +292,12 @@ static int add_host_bridge_dport(struct device *match, void *arg)
 	}
 
 	cxl_device_lock(&root_port->dev);
-	rc = cxl_add_dport(root_port, match, uid, ctx.chbcr);
+	dport = devm_cxl_add_dport(host, root_port, match, uid, ctx.chbcr);
 	cxl_device_unlock(&root_port->dev);
-	if (rc) {
+	if (IS_ERR(dport)) {
 		dev_err(host, "failed to add downstream port: %s\n",
 			dev_name(match));
-		return rc;
+		return PTR_ERR(dport);
 	}
 	dev_dbg(host, "add dport%llu: %s\n", uid, dev_name(match));
 	return 0;
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index a90202ac88d2..91057f0ec763 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -7,3 +7,4 @@ cxl_core-y += pmem.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
+cxl_core-y += pci.o
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
new file mode 100644
index 000000000000..c5a9e03ed477
--- /dev/null
+++ b/drivers/cxl/core/pci.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <cxlpci.h>
+#include <cxl.h>
+#include "core.h"
+
+/**
+ * DOC: cxl core pci
+ *
+ * Compute Express Link protocols are layered on top of PCIe. CXL core provides
+ * a set of helpers for CXL interactions which occur via PCIe.
+ */
+
+struct cxl_walk_context {
+	struct pci_bus *bus;
+	struct device *host;
+	struct cxl_port *port;
+	int type;
+	int error;
+	int count;
+};
+
+static int match_add_dports(struct pci_dev *pdev, void *data)
+{
+	struct cxl_walk_context *ctx = data;
+	struct cxl_port *port = ctx->port;
+	int type = pci_pcie_type(pdev);
+	struct cxl_register_map map;
+	struct cxl_dport *dport;
+	u32 lnkcap, port_num;
+	int rc;
+
+	if (pdev->bus != ctx->bus)
+		return 0;
+	if (!pci_is_pcie(pdev))
+		return 0;
+	if (type != ctx->type)
+		return 0;
+	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
+				  &lnkcap))
+		return 0;
+
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (rc)
+		dev_dbg(&port->dev, "failed to find component registers\n");
+
+	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
+	cxl_device_lock(&port->dev);
+	dport = devm_cxl_add_dport(ctx->host, port, &pdev->dev, port_num,
+				   cxl_regmap_to_base(pdev, &map));
+	cxl_device_unlock(&port->dev);
+	if (IS_ERR(dport)) {
+		ctx->error = PTR_ERR(dport);
+		return PTR_ERR(dport);
+	}
+	ctx->count++;
+
+	dev_dbg(&port->dev, "add dport%d: %s\n", port_num, dev_name(&pdev->dev));
+
+	return 0;
+}
+
+/**
+ * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
+ * @host: devm context
+ * @port: cxl_port whose ->uport is the upstream of dports to be enumerated
+ *
+ * Returns a positive number of dports enumerated or a negative error
+ * code.
+ */
+int devm_cxl_port_enumerate_dports(struct device *host, struct cxl_port *port)
+{
+	struct pci_bus *bus = cxl_port_to_pci_bus(port);
+	struct cxl_walk_context ctx;
+	int type;
+
+	if (!bus)
+		return -ENXIO;
+
+	if (pci_is_root_bus(bus))
+		type = PCI_EXP_TYPE_ROOT_PORT;
+	else
+		type = PCI_EXP_TYPE_DOWNSTREAM;
+
+	ctx = (struct cxl_walk_context) {
+		.host = host,
+		.port = port,
+		.bus = bus,
+		.type = type,
+	};
+	pci_walk_bus(bus, match_add_dports, &ctx);
+
+	if (ctx.count == 0)
+		return -ENODEV;
+	if (ctx.error)
+		return ctx.error;
+	return ctx.count;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, CXL);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 369cc52e0837..fee9c7affef4 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -243,22 +243,10 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_decoder, CXL);
 
-static void cxl_dport_release(struct cxl_dport *dport)
-{
-	list_del(&dport->list);
-	put_device(dport->dport);
-	kfree(dport);
-}
-
 static void cxl_port_release(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
-	struct cxl_dport *dport, *_d;
 
-	cxl_device_lock(dev);
-	list_for_each_entry_safe(dport, _d, &port->dports, list)
-		cxl_dport_release(dport);
-	cxl_device_unlock(dev);
 	ida_free(&cxl_port_ida, port->id);
 	kfree(port);
 }
@@ -292,18 +280,7 @@ EXPORT_SYMBOL_NS_GPL(to_cxl_port, CXL);
 static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
-	struct cxl_dport *dport;
 
-	cxl_device_lock(&port->dev);
-	list_for_each_entry(dport, &port->dports, list) {
-		char link_name[CXL_TARGET_STRLEN];
-
-		if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d",
-			     dport->port_id) >= CXL_TARGET_STRLEN)
-			continue;
-		sysfs_remove_link(&port->dev.kobj, link_name);
-	}
-	cxl_device_unlock(&port->dev);
 	device_unregister(&port->dev);
 }
 
@@ -532,51 +509,87 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
 	return dup ? -EEXIST : 0;
 }
 
+static void cxl_dport_remove(void *data)
+{
+	struct cxl_dport *dport = data;
+	struct cxl_port *port = dport->port;
+
+	put_device(dport->dport);
+	cxl_device_lock(&port->dev);
+	list_del(&dport->list);
+	cxl_device_unlock(&port->dev);
+}
+
+static void cxl_dport_unlink(void *data)
+{
+	struct cxl_dport *dport = data;
+	struct cxl_port *port = dport->port;
+	char link_name[CXL_TARGET_STRLEN];
+
+	sprintf(link_name, "dport%d", dport->port_id);
+	sysfs_remove_link(&port->dev.kobj, link_name);
+}
+
 /**
- * cxl_add_dport - append downstream port data to a cxl_port
+ * devm_cxl_add_dport - append downstream port data to a cxl_port
+ * @host: devm context for allocations
  * @port: the cxl_port that references this dport
  * @dport_dev: firmware or PCI device representing the dport
  * @port_id: identifier for this dport in a decoder's target list
  * @component_reg_phys: optional location of CXL component registers
  *
- * Note that all allocations and links are undone by cxl_port deletion
- * and release.
+ * Note that dports are appended to the devm release action's of the
+ * either the port's host (for root ports), or the port itself (for
+ * switch ports)
  */
-int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
-		  resource_size_t component_reg_phys)
+struct cxl_dport *devm_cxl_add_dport(struct device *host, struct cxl_port *port,
+				     struct device *dport_dev, int port_id,
+				     resource_size_t component_reg_phys)
 {
 	char link_name[CXL_TARGET_STRLEN];
 	struct cxl_dport *dport;
 	int rc;
 
+	if (!host->driver) {
+		dev_WARN_ONCE(&port->dev, 1, "dport:%s bad devm context\n",
+			      dev_name(dport_dev));
+		return ERR_PTR(-ENXIO);
+	}
+
 	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
 	    CXL_TARGET_STRLEN)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
-	dport = kzalloc(sizeof(*dport), GFP_KERNEL);
+	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
 	if (!dport)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&dport->list);
-	dport->dport = get_device(dport_dev);
+	dport->dport = dport_dev;
 	dport->port_id = port_id;
 	dport->component_reg_phys = component_reg_phys;
 	dport->port = port;
 
 	rc = add_dport(port, dport);
 	if (rc)
-		goto err;
+		return ERR_PTR(rc);
+
+	get_device(dport_dev);
+	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
+	if (rc)
+		return ERR_PTR(rc);
 
 	rc = sysfs_create_link(&port->dev.kobj, &dport_dev->kobj, link_name);
 	if (rc)
-		goto err;
+		return ERR_PTR(rc);
 
-	return 0;
-err:
-	cxl_dport_release(dport);
-	return rc;
+	rc = devm_add_action_or_reset(host, cxl_dport_unlink, dport);
+	if (rc)
+		return ERR_PTR(rc);
+
+	return dport;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_add_dport, CXL);
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
 
 static int decoder_populate_targets(struct cxl_decoder *cxld,
 				    struct cxl_port *port, int *target_map)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 61b0db526fa2..0754c68ccd33 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -236,14 +236,6 @@ struct cxl_nvdimm {
 	struct nvdimm *nvdimm;
 };
 
-struct cxl_walk_context {
-	struct device *dev;
-	struct pci_bus *root;
-	struct cxl_port *port;
-	int error;
-	int count;
-};
-
 /**
  * struct cxl_port - logical collection of upstream port devices and
  *		     downstream port devices to construct a CXL memory
@@ -295,17 +287,17 @@ static inline bool is_cxl_root(struct cxl_port *port)
 
 bool is_cxl_port(struct device *dev);
 struct cxl_port *to_cxl_port(struct device *dev);
+struct pci_bus;
 int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
 			      struct pci_bus *bus);
 struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
 struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
 				   struct cxl_port *parent_port);
-
-int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
-		  resource_size_t component_reg_phys);
 struct cxl_port *find_cxl_root(struct device *dev);
-
+struct cxl_dport *devm_cxl_add_dport(struct device *host, struct cxl_port *port,
+				     struct device *dport, int port_id,
+				     resource_size_t component_reg_phys);
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index eb00f597a157..103636fda198 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -57,4 +57,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
 	return pci_resource_start(pdev, map->barno) + map->block_offset;
 }
 
+int devm_cxl_port_enumerate_dports(struct device *host, struct cxl_port *port);
 #endif /* __CXL_PCI_H__ */
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index ddaee8a2c418..61123544aa49 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -3,8 +3,8 @@ ldflags-y += --wrap=acpi_table_parse_cedt
 ldflags-y += --wrap=is_acpi_device_node
 ldflags-y += --wrap=acpi_evaluate_integer
 ldflags-y += --wrap=acpi_pci_find_root
-ldflags-y += --wrap=pci_walk_bus
 ldflags-y += --wrap=nvdimm_bus_register
+ldflags-y += --wrap=devm_cxl_port_enumerate_dports
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
@@ -30,6 +30,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pmem.o
 cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
+cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += config_check.o
 
 obj-m += test/
diff --git a/tools/testing/cxl/mock_acpi.c b/tools/testing/cxl/mock_acpi.c
index c953e3ab6494..55813de26d46 100644
--- a/tools/testing/cxl/mock_acpi.c
+++ b/tools/testing/cxl/mock_acpi.c
@@ -4,7 +4,6 @@
 #include <linux/platform_device.h>
 #include <linux/device.h>
 #include <linux/acpi.h>
-#include <linux/pci.h>
 #include <cxl.h>
 #include "test/mock.h"
 
@@ -34,80 +33,3 @@ struct acpi_device *to_cxl_host_bridge(struct device *host, struct device *dev)
 	put_cxl_mock_ops(index);
 	return found;
 }
-
-static int match_add_root_port(struct pci_dev *pdev, void *data)
-{
-	struct cxl_walk_context *ctx = data;
-	struct pci_bus *root_bus = ctx->root;
-	struct cxl_port *port = ctx->port;
-	int type = pci_pcie_type(pdev);
-	struct device *dev = ctx->dev;
-	u32 lnkcap, port_num;
-	int rc;
-
-	if (pdev->bus != root_bus)
-		return 0;
-	if (!pci_is_pcie(pdev))
-		return 0;
-	if (type != PCI_EXP_TYPE_ROOT_PORT)
-		return 0;
-	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
-				  &lnkcap) != PCIBIOS_SUCCESSFUL)
-		return 0;
-
-	/* TODO walk DVSEC to find component register base */
-	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	cxl_device_lock(&port->dev);
-	rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
-	cxl_device_unlock(&port->dev);
-	if (rc) {
-		dev_err(dev, "failed to add dport: %s (%d)\n",
-			dev_name(&pdev->dev), rc);
-		ctx->error = rc;
-		return rc;
-	}
-	ctx->count++;
-
-	dev_dbg(dev, "add dport%d: %s\n", port_num, dev_name(&pdev->dev));
-
-	return 0;
-}
-
-static int mock_add_root_port(struct platform_device *pdev, void *data)
-{
-	struct cxl_walk_context *ctx = data;
-	struct cxl_port *port = ctx->port;
-	struct device *dev = ctx->dev;
-	int rc;
-
-	cxl_device_lock(&port->dev);
-	rc = cxl_add_dport(port, &pdev->dev, pdev->id, CXL_RESOURCE_NONE);
-	cxl_device_unlock(&port->dev);
-	if (rc) {
-		dev_err(dev, "failed to add dport: %s (%d)\n",
-			dev_name(&pdev->dev), rc);
-		ctx->error = rc;
-		return rc;
-	}
-	ctx->count++;
-
-	dev_dbg(dev, "add dport%d: %s\n", pdev->id, dev_name(&pdev->dev));
-
-	return 0;
-}
-
-int match_add_root_ports(struct pci_dev *dev, void *data)
-{
-	int index, rc;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-	struct platform_device *pdev = (struct platform_device *) dev;
-
-	if (ops && ops->is_mock_port(pdev))
-		rc = mock_add_root_port(pdev, data);
-	else
-		rc = match_add_root_port(dev, data);
-
-	put_cxl_mock_ops(index);
-
-	return rc;
-}
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 736d99006fb7..ef002e909d38 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -317,6 +317,19 @@ static bool is_mock_bridge(struct device *dev)
 	for (i = 0; i < ARRAY_SIZE(cxl_host_bridge); i++)
 		if (dev == &cxl_host_bridge[i]->dev)
 			return true;
+	return false;
+}
+
+static bool is_mock_port(struct device *dev)
+{
+	int i;
+
+	if (is_mock_bridge(dev))
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_root_port); i++)
+		if (dev == &cxl_root_port[i]->dev)
+			return true;
 
 	return false;
 }
@@ -366,26 +379,6 @@ static struct acpi_pci_root mock_pci_root[NR_CXL_HOST_BRIDGES] = {
 	},
 };
 
-static struct platform_device *mock_cxl_root_port(struct pci_bus *bus, int index)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mock_pci_bus); i++)
-		if (bus == &mock_pci_bus[i])
-			return cxl_root_port[index + i * NR_CXL_ROOT_PORTS];
-	return NULL;
-}
-
-static bool is_mock_port(struct platform_device *pdev)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(cxl_root_port); i++)
-		if (pdev == cxl_root_port[i])
-			return true;
-	return false;
-}
-
 static bool is_mock_bus(struct pci_bus *bus)
 {
 	int i;
@@ -405,16 +398,47 @@ static struct acpi_pci_root *mock_acpi_pci_find_root(acpi_handle handle)
 	return &mock_pci_root[host_bridge_index(adev)];
 }
 
+static int mock_cxl_port_enumerate_dports(struct device *host,
+					  struct cxl_port *port)
+{
+	struct device *dev = &port->dev;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_root_port); i++) {
+		struct platform_device *pdev = cxl_root_port[i];
+		struct cxl_dport *dport;
+
+		if (pdev->dev.parent != port->uport)
+			continue;
+
+		cxl_device_lock(&port->dev);
+		dport = devm_cxl_add_dport(host, port, &pdev->dev, pdev->id,
+					   CXL_RESOURCE_NONE);
+		cxl_device_unlock(&port->dev);
+
+		if (IS_ERR(dport)) {
+			dev_err(dev, "failed to add dport: %s (%ld)\n",
+				dev_name(&pdev->dev), PTR_ERR(dport));
+			return PTR_ERR(dport);
+		}
+
+		dev_dbg(dev, "add dport%d: %s\n", pdev->id,
+			dev_name(&pdev->dev));
+	}
+
+	return 0;
+}
+
 static struct cxl_mock_ops cxl_mock_ops = {
 	.is_mock_adev = is_mock_adev,
 	.is_mock_bridge = is_mock_bridge,
 	.is_mock_bus = is_mock_bus,
 	.is_mock_port = is_mock_port,
 	.is_mock_dev = is_mock_dev,
-	.mock_port = mock_cxl_root_port,
 	.acpi_table_parse_cedt = mock_acpi_table_parse_cedt,
 	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
 	.acpi_pci_find_root = mock_acpi_pci_find_root,
+	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
 	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
 };
 
@@ -598,3 +622,4 @@ module_init(cxl_test_init);
 module_exit(cxl_test_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);
+MODULE_IMPORT_NS(CXL);
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 17408f892df4..56b4b7d734bc 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -7,6 +7,8 @@
 #include <linux/export.h>
 #include <linux/acpi.h>
 #include <linux/pci.h>
+#include <cxlmem.h>
+#include <cxlpci.h>
 #include "mock.h"
 
 static LIST_HEAD(mock);
@@ -114,32 +116,6 @@ struct acpi_pci_root *__wrap_acpi_pci_find_root(acpi_handle handle)
 }
 EXPORT_SYMBOL_GPL(__wrap_acpi_pci_find_root);
 
-void __wrap_pci_walk_bus(struct pci_bus *bus,
-			 int (*cb)(struct pci_dev *, void *), void *userdata)
-{
-	int index;
-	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
-
-	if (ops && ops->is_mock_bus(bus)) {
-		int rc, i;
-
-		/*
-		 * Simulate 2 root ports per host-bridge and no
-		 * depth recursion.
-		 */
-		for (i = 0; i < 2; i++) {
-			rc = cb((struct pci_dev *) ops->mock_port(bus, i),
-				userdata);
-			if (rc)
-				break;
-		}
-	} else
-		pci_walk_bus(bus, cb, userdata);
-
-	put_cxl_mock_ops(index);
-}
-EXPORT_SYMBOL_GPL(__wrap_pci_walk_bus);
-
 struct nvdimm_bus *
 __wrap_nvdimm_bus_register(struct device *dev,
 			   struct nvdimm_bus_descriptor *nd_desc)
@@ -155,5 +131,22 @@ __wrap_nvdimm_bus_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
 
+int __wrap_devm_cxl_port_enumerate_dports(struct device *host,
+					  struct cxl_port *port)
+{
+	int rc, index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_port(port->uport))
+		rc = ops->devm_cxl_port_enumerate_dports(host, port);
+	else
+		rc = devm_cxl_port_enumerate_dports(host, port);
+	put_cxl_mock_ops(index);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_port_enumerate_dports, CXL);
+
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(ACPI);
+MODULE_IMPORT_NS(CXL);
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 15ed0fd877e4..99e7ff38090d 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -2,6 +2,7 @@
 
 #include <linux/list.h>
 #include <linux/acpi.h>
+#include <cxl.h>
 
 struct cxl_mock_ops {
 	struct list_head list;
@@ -15,10 +16,11 @@ struct cxl_mock_ops {
 					     struct acpi_object_list *arguments,
 					     unsigned long long *data);
 	struct acpi_pci_root *(*acpi_pci_find_root)(acpi_handle handle);
-	struct platform_device *(*mock_port)(struct pci_bus *bus, int index);
 	bool (*is_mock_bus)(struct pci_bus *bus);
-	bool (*is_mock_port)(struct platform_device *pdev);
+	bool (*is_mock_port)(struct device *dev);
 	bool (*is_mock_dev)(struct device *dev);
+	int (*devm_cxl_port_enumerate_dports)(struct device *host,
+					      struct cxl_port *port);
 };
 
 void register_cxl_mock_ops(struct cxl_mock_ops *ops);

