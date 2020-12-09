Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB992D37A0
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgLIAZa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:25:30 -0500
Received: from mga09.intel.com ([134.134.136.24]:16954 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731833AbgLIAZV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:25:21 -0500
IronPort-SDR: NqajYsXUrsg68k0UYnPzwnSxBC2T1yJHzJhkIj2V2jXebrZLz14QI7f6J2dO94LfzYXz+TnVnO
 W5bfnnotJGWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174142073"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174142073"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:24 -0800
IronPort-SDR: RcK2d8iPuWM9yk5e7fxDwULHi1WmNBJ01cG1TpYsxbdg9UJP0nnHcwCA+WFvvOOlskfw60fm0c
 dQPVCZ4dBJYw==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407838470"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.137.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:23 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v2 04/14] cxl/mem: Introduce a driver for CXL-2.0-Type-3 endpoints
Date:   Tue,  8 Dec 2020 16:24:08 -0800
Message-Id: <20201209002418.1976362-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209002418.1976362-1-ben.widawsky@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

The CXL.mem protocol allows a device to act as a provider of "System
RAM" and/or "Persistent Memory" that is fully coherent as if the memory
was attached to the typical CPU memory controller.

With the CXL-2.0 specification a PCI endpoint can implement a "Type-3"
device interface and give the operating system control over "Host
Managed Device Memory". See section 2.3 Type 3 CXL Device.

The memory range exported by the device may optionally be described by
the platform firmware memory map, or by infrastructure like LIBNVDIMM to
provision persistent memory capacity from one, or more, CXL.mem devices.

A pre-requisite for Linux-managed memory-capacity provisioning is this
cxl_mem driver that can speak the mailbox protocol defined in section
8.2.8.4 Mailbox Registers.

For now just land the driver boiler-plate and fill it in with
functionality in subsequent commits.

Link: https://www.computeexpresslink.org/download-the-specification
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/cxl/memory-devices.rst |  9 ++++
 drivers/cxl/Kconfig                  | 22 +++++++++
 drivers/cxl/Makefile                 |  2 +
 drivers/cxl/mem.c                    | 69 ++++++++++++++++++++++++++++
 drivers/cxl/pci.h                    | 20 ++++++++
 5 files changed, 122 insertions(+)
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 drivers/cxl/pci.h

diff --git a/Documentation/cxl/memory-devices.rst b/Documentation/cxl/memory-devices.rst
index 6ce88f9d5f4f..134c9b6b4ff4 100644
--- a/Documentation/cxl/memory-devices.rst
+++ b/Documentation/cxl/memory-devices.rst
@@ -23,6 +23,15 @@ ACPI CXL
 .. kernel-doc:: drivers/cxl/acpi.c
    :internal:
 
+CXL Memory Device
+-----------------
+
+.. kernel-doc:: drivers/cxl/mem.c
+   :doc: cxl mem
+
+.. kernel-doc:: drivers/cxl/mem.c
+   :internal:
+
 External Interfaces
 ===================
 
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 68da926ba5b1..0ac5080cd6e0 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -33,4 +33,26 @@ config CXL_ACPI
 	  specification.
 
 	  If unsure say 'm'
+
+config CXL_MEM
+        tristate "CXL.mem: Endpoint Support"
+        depends on PCI && CXL_BUS_PROVIDER
+        default CXL_BUS_PROVIDER
+        help
+          The CXL.mem protocol allows a device to act as a provider of
+          "System RAM" and/or "Persistent Memory" that is fully coherent
+          as if the memory was attached to the typical CPU memory
+          controller.
+
+	  Say 'y/m' to enable a driver (named "cxl_mem.ko" when built as
+	  a module) that will attach to CXL.mem devices for
+	  configuration, provisioning, and health monitoring. This
+	  driver is required for dynamic provisioning of CXL.mem
+	  attached memory which is a pre-requisite for persistent memory
+	  support. Typically volatile memory is mapped by platform
+	  firmware and included in the platform memory map, but in some
+	  cases the OS is responsible for mapping that memory. See
+	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
+
+          If unsure say 'm'.
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index d38cd34a2582..97fdffb00f2d 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,5 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
+obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
 cxl_acpi-y := acpi.o
+cxl_mem-y := mem.o
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
new file mode 100644
index 000000000000..005404888942
--- /dev/null
+++ b/drivers/cxl/mem.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include "acpi.h"
+#include "pci.h"
+
+static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
+{
+	int pos;
+
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
+	if (!pos)
+		return 0;
+
+	while (pos) {
+		u16 vendor, id;
+
+		pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_ID_OFFSET,
+				     &vendor);
+		pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
+		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
+			return pos;
+
+		pos = pci_find_next_ext_capability(pdev, pos,
+						   PCI_EXT_CAP_ID_DVSEC);
+	}
+
+	return 0;
+}
+
+static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	int rc, regloc;
+
+	rc = cxl_bus_acquire(pdev);
+	if (rc != 0) {
+		dev_err(dev, "failed to acquire interface\n");
+		return rc;
+	}
+
+	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
+	if (!regloc) {
+		dev_err(dev, "register location dvsec not found\n");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static const struct pci_device_id cxl_mem_pci_tbl[] = {
+	/* PCI class code for CXL.mem Type-3 Devices */
+	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_MEMORY_CXL, 0xffffff, 0 },
+	{ /* terminate list */ },
+};
+MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
+
+static struct pci_driver cxl_mem_driver = {
+	.name			= KBUILD_MODNAME,
+	.id_table		= cxl_mem_pci_tbl,
+	.probe			= cxl_mem_probe,
+};
+
+MODULE_LICENSE("GPL v2");
+module_pci_driver(cxl_mem_driver);
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
new file mode 100644
index 000000000000..a8a9935fa90b
--- /dev/null
+++ b/drivers/cxl/pci.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#ifndef __CXL_PCI_H__
+#define __CXL_PCI_H__
+
+#define PCI_CLASS_MEMORY_CXL	0x050210
+
+/*
+ * See section 8.1 Configuration Space Registers in the CXL 2.0
+ * Specification
+ */
+#define PCI_EXT_CAP_ID_DVSEC		0x23
+#define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
+#define PCI_DVSEC_VENDOR_ID_OFFSET	0x4
+#define PCI_DVSEC_ID_CXL		0x0
+#define PCI_DVSEC_ID_OFFSET		0x8
+
+#define PCI_DVSEC_ID_CXL_REGLOC		0x8
+
+#endif /* __CXL_PCI_H__ */
-- 
2.29.2

