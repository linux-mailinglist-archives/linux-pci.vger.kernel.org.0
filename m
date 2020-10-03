Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF8428202B
	for <lists+linux-pci@lfdr.de>; Sat,  3 Oct 2020 03:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725793AbgJCBbo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 21:31:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:2330 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgJCBba (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 2 Oct 2020 21:31:30 -0400
IronPort-SDR: hr0NpQRZl4VUuFPwxs+Pdq45XU7OcJBzay9NojL35kYhs/jxmm0Ft+7P7Wta2/NIGxXjPLj0zl
 xmNpUmhaFvmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="247866962"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="247866962"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:31:27 -0700
IronPort-SDR: fmXsK/th6NUQS/5oKAD865COdUKzK2xicPOOsRJpVVvuNvfnOEG+yTe7NjmHUA+PR3llKJMuL7
 c2mxVvruzOQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="352530720"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 02 Oct 2020 18:31:27 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 55734580AB2;
        Fri,  2 Oct 2020 18:31:27 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, david.e.box@linux.intel.com,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        hdegoede@redhat.com, alexey.budankov@linux.intel.com
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V8 4/5] platform/x86: Intel PMT Telemetry capability driver
Date:   Fri,  2 Oct 2020 18:31:22 -0700
Message-Id: <20201003013123.20269-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201003013123.20269-1-david.e.box@linux.intel.com>
References: <20201003013123.20269-1-david.e.box@linux.intel.com>
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

Also create a PCI device id list for early telemetry hardware that require
workarounds for known issues.

Co-developed-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 drivers/platform/x86/Kconfig               |  11 ++
 drivers/platform/x86/Makefile              |   1 +
 drivers/platform/x86/intel_pmt_telemetry.c | 160 +++++++++++++++++++++
 3 files changed, 172 insertions(+)
 create mode 100644 drivers/platform/x86/intel_pmt_telemetry.c

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 12431e0e974d..90b4c1bd9532 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1372,6 +1372,17 @@ config INTEL_PMT_CLASS
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel_pmt_class.
 
+config INTEL_PMT_TELEMETRY
+	tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
+	select INTEL_PMT_CLASS
+	help
+	  The Intel Platform Monitory Technology (PMT) Telemetry driver provides
+	  access to hardware telemetry metrics on devices that support the
+	  feature.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called intel_pmt_telemetry.
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
index 000000000000..f8a87614efa4
--- /dev/null
+++ b/drivers/platform/x86/intel_pmt_telemetry.c
@@ -0,0 +1,160 @@
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
+#include <linux/overflow.h>
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
+/*
+ * Early implementations of PMT on client platforms have some
+ * differences from the server platforms (which use the Out Of Band
+ * Management Services Module OOBMSM). This list tracks those
+ * platforms as needed to handle those differences. Newer client
+ * platforms are expected to be fully compatible with server.
+ */
+static const struct pci_device_id pmt_telem_early_client_pci_ids[] = {
+	{ PCI_VDEVICE(INTEL, 0x9a0d) }, /* TGL */
+	{ PCI_VDEVICE(INTEL, 0x467d) }, /* ADL */
+	{ }
+};
+
+static bool intel_pmt_is_early_client_hw(struct device *dev)
+{
+	struct pci_dev *parent = to_pci_dev(dev->parent);
+
+	return !!pci_match_id(pmt_telem_early_client_pci_ids, parent);
+}
+
+static bool pmt_telem_region_overlaps(struct intel_pmt_entry *entry,
+				      struct device *dev)
+{
+	u32 guid = readl(entry->disc_table + TELEM_GUID_OFFSET);
+
+	if (guid != TELEM_CLIENT_FIXED_BLOCK_GUID)
+		return false;
+
+	return intel_pmt_is_early_client_hw(dev);
+}
+
+static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
+				   struct intel_pmt_header *header,
+				   struct device *dev)
+{
+	void __iomem *disc_table = entry->disc_table;
+
+	if (pmt_telem_region_overlaps(entry, dev))
+		return 1;
+
+	header->access_type = TELEM_ACCESS(readl(disc_table));
+	header->guid = readl(disc_table + TELEM_GUID_OFFSET);
+	header->base_offset = readl(disc_table + TELEM_BASE_OFFSET);
+
+	/* Size is measured in DWORDS, but accessor returns bytes */
+	header->size = TELEM_SIZE(readl(disc_table));
+
+	return 0;
+}
+
+static DEFINE_XARRAY_ALLOC(telem_array);
+static struct intel_pmt_namespace pmt_telem_ns = {
+	.name = "telem",
+	.xa = &telem_array,
+	.pmt_header_decode = pmt_telem_header_decode,
+};
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
+	size_t size;
+	int i, ret;
+
+	size = struct_size(priv, entry, pdev->num_resources);
+	priv = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	for (i = 0; i < pdev->num_resources; i++) {
+		struct intel_pmt_entry *entry = &priv->entry[i];
+
+		ret = intel_pmt_dev_create(entry, &pmt_telem_ns, pdev, i);
+		if (ret < 0)
+			goto abort_probe;
+		if (ret)
+			continue;
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

