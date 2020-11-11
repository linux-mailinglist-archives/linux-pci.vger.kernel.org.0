Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32772AE852
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 06:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgKKFop (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 00:44:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:54147 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgKKFoH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 00:44:07 -0500
IronPort-SDR: dZQXnPX+xjfL1fhktFf/tJOXklqPlhAHKJRtFiGnsmlcSw/G7NICG3ImksiXFXcN1scuWa1oaw
 oTWQrv7t3EoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="149372960"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="149372960"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:44:04 -0800
IronPort-SDR: c1yfbGvYRNgmO90XpmPA12ZWBwnjq6m1+Bkili3SSRDGWX+M/E3KT1G3oyVEHRHW5zDBY+xzcI
 +SL5JSBTHCZA==
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="360414747"
Received: from hccoutan-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.131.159])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:44:04 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [RFC PATCH 3/9] cxl/mem: Add a driver for the type-3 mailbox
Date:   Tue, 10 Nov 2020 21:43:50 -0800
Message-Id: <20201111054356.793390-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111054356.793390-1-ben.widawsky@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

The CXL.mem protocol allows a device to act as a provider of "System
RAM" and/or "Persistent Memory" that is fully coherent as if the memory
was attached to the typical CPU memory controller.

The memory range exported by the device may optionally be described by
the platform firmware memory map, or by infrastructure like LIBNVDIMM to
provision persistent memory capacity from one, or more, CXL.mem devices.

A pre-requisite for Linux-managed memory-capacity provisioning is this
cxl_mem driver that can speak the "type-3 mailbox" protocol.

For now just land the driver boiler-plate and fill it in with
functionality in subsequent commits.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/Kconfig  | 20 +++++++++++
 drivers/cxl/Makefile |  2 ++
 drivers/cxl/mem.c    | 82 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.h    | 15 ++++++++
 4 files changed, 119 insertions(+)
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 drivers/cxl/pci.h

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index dd724bd364df..15548f5c77ff 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -27,4 +27,24 @@ config CXL_ACPI
 	  resources described by the CEDT (CXL Early Discovery Table)
 
 	  Say 'y' to enable CXL (Compute Express Link) drivers.
+
+config CXL_MEM
+        tristate "CXL.mem Device Support"
+        depends on PCI && CXL_BUS_PROVIDER != n
+        default m if CXL_BUS_PROVIDER
+        help
+          The CXL.mem protocol allows a device to act as a provider of
+          "System RAM" and/or "Persistent Memory" that is fully coherent
+          as if the memory was attached to the typical CPU memory
+          controller.
+
+          Say 'y/m' to enable a driver named "cxl_mem.ko" that will attach
+          to CXL.mem devices for configuration, provisioning, and health
+          monitoring, the so called "type-3 mailbox". Note, this driver
+          is required for dynamic provisioning of CXL.mem attached
+          memory, a pre-requisite for persistent memory support, but
+          devices that provide volatile memory may be fully described by
+          existing platform firmware memory enumeration.
+
+          If unsure say 'n'.
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
index 000000000000..aa7d881fa47b
--- /dev/null
+++ b/drivers/cxl/mem.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2020 Intel Corporation. All rights reserved.
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/io.h>
+#include "acpi.h"
+#include "pci.h"
+
+struct cxl_mem {
+	void __iomem *regs;
+};
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
+		pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_OFFSET, &vendor);
+		pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
+		if (vendor == PCI_DVSEC_VENDOR_CXL && dvsec == id)
+			return pos;
+
+		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
+	}
+
+	return 0;
+}
+
+static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct device *dev = &pdev->dev;
+	struct cxl_mem *cxlm;
+	int rc, regloc;
+
+	rc = cxl_bus_prepared(pdev);
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
+	cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
+	if (!cxlm)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void cxl_mem_remove(struct pci_dev *pdev)
+{
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
+	.remove			= cxl_mem_remove,
+};
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Intel Corporation");
+module_pci_driver(cxl_mem_driver);
+MODULE_IMPORT_NS(CXL);
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
new file mode 100644
index 000000000000..beb03921e6da
--- /dev/null
+++ b/drivers/cxl/pci.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright(c) 2020 Intel Corporation. All rights reserved.
+#ifndef __CXL_PCI_H__
+#define __CXL_PCI_H__
+
+#define PCI_CLASS_MEMORY_CXL	0x050210
+
+#define PCI_EXT_CAP_ID_DVSEC	0x23
+#define PCI_DVSEC_VENDOR_CXL	0x1E98
+#define PCI_DVSEC_VENDOR_OFFSET	0x4
+#define PCI_DVSEC_ID_OFFSET	0x8
+#define PCI_DVSEC_ID_CXL	0x0
+#define PCI_DVSEC_ID_CXL_REGLOC	0x8
+
+#endif /* __CXL_PCI_H__ */
-- 
2.29.2

