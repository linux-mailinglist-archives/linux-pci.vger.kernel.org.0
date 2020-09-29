Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B52C127B916
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 02:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgI2Axc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 20:53:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:31780 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727203AbgI2Axa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 20:53:30 -0400
IronPort-SDR: tfMdN/5oSkMyNEcfP5QjTj0vLopx9kaIed8zcPLwiT5me2uP+jt+4YCcjUr6DxnFLWeN0002ki
 WAtEB4jzCBdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="159468664"
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; 
   d="scan'208";a="159468664"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 17:53:29 -0700
IronPort-SDR: e3XUN6qxm+C9ewPigFKTwDz4gT20Iz3SaIKDDaYlYtJgUhZ6ciDiocUoNDsntx04TolXWyuXtC
 +goWPM/rsF8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; 
   d="scan'208";a="324482638"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 28 Sep 2020 17:53:29 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 8357D58088C;
        Mon, 28 Sep 2020 17:53:29 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, david.e.box@linux.intel.com,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com, hdegoede@redhat.com,
        alexey.budankov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V6 4/5] platform/x86: Intel PMT Telemetry capability driver
Date:   Mon, 28 Sep 2020 17:53:19 -0700
Message-Id: <20200929005320.14739-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200929005320.14739-1-david.e.box@linux.intel.com>
References: <20200929005320.14739-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

PMT Telemetry is a capability of the Intel Platform Monitoring Technology.
The Telemetry capability provides access to device telemetry metrics that
provide hardware performance data to users from read-only register spaces.

With this driver present the intel_pmt directory can be populated with
telem<x> devices. These devices will contain the standard intel_pmt sysfs
data and a "telem" binary sysfs attribute which can be used to access the
telemetry data.

Co-developed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/platform/x86/Kconfig               |   8 ++
 drivers/platform/x86/Makefile              |   1 +
 drivers/platform/x86/intel_pmt_telemetry.c | 158 +++++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 drivers/platform/x86/intel_pmt_telemetry.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 093c43b63f48..02cb2db11417 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1369,6 +1369,14 @@ config INTEL_PMT_CLASS
 	  For more information, see
 	  <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
 
+config INTEL_PMT_TELEMETRY
+	tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
+	select INTEL_PMT_CLASS
+	help
+	  The Intel Platform Monitory Technology (PMT) Telemetry driver provides
+	  access to hardware telemetry metrics on devices that support the
+	  feature.
+
 config INTEL_PUNIT_IPC
 	tristate "Intel P-Unit IPC Driver"
 	help
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index f4b1f87f2401..6a7b61f59ea8 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -141,6 +141,7 @@ obj-$(CONFIG_INTEL_MID_POWER_BUTTON)	+= intel_mid_powerbtn.o
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= intel_pmt_class.o
+obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= intel_pmt_telemetry.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
diff --git a/drivers/platform/x86/intel_pmt_telemetry.c b/drivers/platform/x86/intel_pmt_telemetry.c
new file mode 100644
index 000000000000..d4819aefdd65
--- /dev/null
+++ b/drivers/platform/x86/intel_pmt_telemetry.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Platform Monitory Technology Telemetry driver
+ *
+ * Copyright (c) 2020, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Author: "David E. Box" <david.e.box@linux.intel.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#include "intel_pmt_class.h"
+
+#define TELEM_DEV_NAME		"pmt_telemetry"
+
+#define TELEM_SIZE_OFFSET	0x0
+#define TELEM_GUID_OFFSET	0x4
+#define TELEM_BASE_OFFSET	0x8
+#define TELEM_ACCESS(v)		((v) & GENMASK(3, 0))
+/* size is in bytes */
+#define TELEM_SIZE(v)		(((v) & GENMASK(27, 12)) >> 10)
+
+/* Used by client hardware to identify a fixed telemetry entry*/
+#define TELEM_CLIENT_FIXED_BLOCK_GUID	0x10000000
+
+struct pmt_telem_priv {
+	int				num_entries;
+	struct intel_pmt_entry		entry[];
+};
+
+static DEFINE_XARRAY_ALLOC(telem_array);
+static struct intel_pmt_namespace pmt_telem_ns = {
+	.name = "telem",
+	.xa = &telem_array
+};
+
+/*
+ * driver initialization
+ */
+static int pmt_telem_add_entry(struct intel_pmt_entry *entry,
+			       struct device *parent,
+			       struct resource *disc_res)
+{
+	void __iomem *disc_table = entry->disc_table;
+	struct intel_pmt_header header;
+	int ret;
+
+	header.access_type = TELEM_ACCESS(readl(disc_table));
+	header.guid = readl(disc_table + TELEM_GUID_OFFSET);
+	header.base_offset = readl(disc_table + TELEM_BASE_OFFSET);
+
+	/* Size is measured in DWORDS, but accessor returns bytes */
+	header.size = TELEM_SIZE(readl(disc_table));
+
+	ret = intel_pmt_populate_entry(entry, &header, parent, disc_res);
+	if (ret)
+		return ret;
+
+	return intel_pmt_dev_create(entry, &pmt_telem_ns, parent);
+}
+
+static bool pmt_telem_region_overlaps(struct intel_pmt_entry *entry)
+{
+	u32 guid;
+
+	guid = readl(entry->disc_table + TELEM_GUID_OFFSET);
+
+	return guid == TELEM_CLIENT_FIXED_BLOCK_GUID;
+}
+
+static int pmt_telem_remove(struct platform_device *pdev)
+{
+	struct pmt_telem_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < priv->num_entries; i++)
+		intel_pmt_dev_destroy(&priv->entry[i], &pmt_telem_ns);
+
+	return 0;
+}
+
+static int pmt_telem_probe(struct platform_device *pdev)
+{
+	struct pmt_telem_priv *priv;
+	bool early_hw;
+	size_t size;
+	int i, ret;
+
+	size = offsetof(struct pmt_telem_priv, entry[pdev->num_resources]);
+	priv = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	if (intel_pmt_is_early_client_hw(&pdev->dev))
+		early_hw = true;
+
+	for (i = 0; i < pdev->num_resources; i++) {
+		struct intel_pmt_entry *entry = &priv->entry[i];
+		struct resource *disc_res;
+
+		ret = -ENODEV;
+
+		disc_res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!disc_res)
+			goto abort_probe;
+
+		ret = intel_pmt_ioremap_discovery_table(entry, pdev, i);
+		if (ret)
+			goto abort_probe;
+
+		if (pmt_telem_region_overlaps(entry) && early_hw)
+			continue;
+
+		ret = pmt_telem_add_entry(entry, &pdev->dev, disc_res);
+		if (ret)
+			goto abort_probe;
+
+		priv->num_entries++;
+	}
+
+	return 0;
+abort_probe:
+	pmt_telem_remove(pdev);
+	return ret;
+}
+
+static struct platform_driver pmt_telem_driver = {
+	.driver = {
+		.name   = TELEM_DEV_NAME,
+	},
+	.remove = pmt_telem_remove,
+	.probe  = pmt_telem_probe,
+};
+
+static int __init pmt_telem_init(void)
+{
+	return platform_driver_register(&pmt_telem_driver);
+}
+module_init(pmt_telem_init);
+
+static void __exit pmt_telem_exit(void)
+{
+	platform_driver_unregister(&pmt_telem_driver);
+	xa_destroy(&telem_array);
+}
+module_exit(pmt_telem_exit);
+
+MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
+MODULE_DESCRIPTION("Intel PMT Telemetry driver");
+MODULE_ALIAS("platform:" TELEM_DEV_NAME);
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

