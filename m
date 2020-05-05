Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870AE1C4C2F
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 04:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgEECcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 22:32:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:57048 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgEECcG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 22:32:06 -0400
IronPort-SDR: S/eUHMmZdrb3/rxTBFyoDfKKVZKqBehczdx/3XEh8ZtgsL5lnC3cCoiombAEMCMAeGTr7oNT7b
 TDDepbVOPwMA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 19:32:05 -0700
IronPort-SDR: IfdmrP2wfQf8Lx5BTI5+eXhZ4uw5o1DT6e/G6FaqZxw159+6/n4OgW+v59p8v38chH3331c+6W
 gALjvXY1X9Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="277726366"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 04 May 2020 19:32:04 -0700
Received: from debox1-hc.jf.intel.com (debox1-hc.jf.intel.com [10.54.75.159])
        by linux.intel.com (Postfix) with ESMTP id 36C35580609;
        Mon,  4 May 2020 19:32:05 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     bhelgaas@google.com, andy@infradead.org,
        alexander.h.duyck@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH 2/3] mfd: Intel Platform Monitoring Technology support
Date:   Mon,  4 May 2020 19:31:48 -0700
Message-Id: <20200505023149.11630-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200505013206.11223-1-david.e.box@linux.intel.com>
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel Platform Monitoring Technology (PMT) is an architecture for
enumerating and accessing hardware monitoring facilities. PMT supports
multiple types of monitoring capabilities. Capabilities are discovered
using PCIe DVSEC with the Intel VID. Each capability is discovered as a
separate DVSEC instance in a device's config space. This driver uses MFD to
manage the creation of platform devices for each type so that they may be
controlled by their own drivers (to be introduced).  Support is included
for the 3 current capability types, Telemetry, Watcher, and Crashlog. The
features are available on new Intel platforms starting from Tiger Lake for
which support is added. Tiger Lake however will not support Watcher and
Crashlog even though the capabilities appear on the device. So add a quirk
facility and use it to disable them.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 MAINTAINERS                 |   5 ++
 drivers/mfd/Kconfig         |  10 +++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/intel_pmt.c     | 174 ++++++++++++++++++++++++++++++++++++
 include/linux/intel-dvsec.h |  44 +++++++++
 5 files changed, 234 insertions(+)
 create mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 include/linux/intel-dvsec.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e64e5db31497..bacf7ecd4d21 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8783,6 +8783,11 @@ S:	Maintained
 F:	arch/x86/include/asm/intel_telemetry.h
 F:	drivers/platform/x86/intel_telemetry*
 
+INTEL PMT DRIVER
+M:	"David E. Box" <david.e.box@linux.intel.com>
+S:	Maintained
+F:	drivers/mfd/intel_pmt.c
+
 INTEL UNCORE FREQUENCY CONTROL
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 0a59249198d3..c673031acdf1 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -632,6 +632,16 @@ config MFD_INTEL_MSIC
 	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
 	  devices used in Intel Medfield platforms.
 
+config MFD_INTEL_PMT
+	tristate "Intel Platform Monitoring Technology support"
+	depends on PCI
+	select MFD_CORE
+	help
+	  The Intel Platform Monitoring Technology (PMT) is an interface that
+	  provides access to hardware monitor registers. This driver supports
+	  Telemetry, Watcher, and Crashlog PTM capabilities/devices for
+	  platforms starting from Tiger Lake.
+
 config MFD_IPAQ_MICRO
 	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
 	depends on SA1100_H3100 || SA1100_H3600
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index f935d10cbf0f..0041f673faa1 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -212,6 +212,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
 obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
 obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
 obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
+obj-$(CONFIG_MFD_INTEL_PMT)	+= intel_pmt.o
 obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
 obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
new file mode 100644
index 000000000000..c48a2b82ca99
--- /dev/null
+++ b/drivers/mfd/intel_pmt.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Platform Monitoring Technology MFD driver
+ *
+ * Copyright (c) 2020, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Authors: David E. Box <david.e.box@linux.intel.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/mfd/core.h>
+#include <linux/intel-dvsec.h>
+
+#define TELEM_DEV_NAME		"pmt_telemetry"
+#define WATCHER_DEV_NAME	"pmt_watcher"
+#define CRASHLOG_DEV_NAME	"pmt_crashlog"
+
+static const struct pmt_platform_info tgl_info = {
+	.quirks = PMT_QUIRK_NO_WATCHER | PMT_QUIRK_NO_CRASHLOG,
+};
+
+static int
+pmt_add_dev(struct pci_dev *pdev, struct intel_dvsec_header *header,
+	    struct pmt_platform_info *info)
+{
+	struct mfd_cell *cell, *tmp;
+	const char *name;
+	int i;
+
+	switch (header->id) {
+	case DVSEC_INTEL_ID_TELEM:
+		name = TELEM_DEV_NAME;
+		break;
+	case DVSEC_INTEL_ID_WATCHER:
+		if (info->quirks && PMT_QUIRK_NO_WATCHER) {
+			dev_info(&pdev->dev, "Watcher not supported\n");
+			return 0;
+		}
+		name = WATCHER_DEV_NAME;
+		break;
+	case DVSEC_INTEL_ID_CRASHLOG:
+		if (info->quirks && PMT_QUIRK_NO_WATCHER) {
+			dev_info(&pdev->dev, "Crashlog not supported\n");
+			return 0;
+		}
+		name = CRASHLOG_DEV_NAME;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cell = devm_kcalloc(&pdev->dev, header->num_entries,
+			    sizeof(*cell), GFP_KERNEL);
+	if (!cell)
+		return -ENOMEM;
+
+	/* Create a platform device for each entry. */
+	for (i = 0, tmp = cell; i < header->num_entries; i++, tmp++) {
+		struct resource *res;
+
+		res = devm_kzalloc(&pdev->dev, sizeof(*res), GFP_KERNEL);
+		if (!res)
+			return -ENOMEM;
+
+		tmp->name = name;
+
+		res->start = pdev->resource[header->tbir].start +
+			     header->offset +
+			     (i * (INTEL_DVSEC_ENTRY_SIZE << 2));
+		res->end = res->start + (header->entry_size << 2) - 1;
+		res->flags = IORESOURCE_MEM;
+
+		tmp->resources = res;
+		tmp->num_resources = 1;
+		tmp->platform_data = header;
+		tmp->pdata_size = sizeof(*header);
+
+	}
+
+	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO, cell,
+				    header->num_entries, NULL, 0, NULL);
+}
+
+static int
+pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	u16 vid;
+	u32 table;
+	int ret, pos = 0, last_pos = 0;
+	struct pmt_platform_info *info;
+	struct intel_dvsec_header header;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	info = devm_kmemdup(&pdev->dev, (void *)id->driver_data, sizeof(*info),
+			    GFP_KERNEL);
+
+	if (!info)
+		return -ENOMEM;
+
+	while ((pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC))) {
+		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vid);
+		if (vid != PCI_VENDOR_ID_INTEL)
+			continue;
+
+		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2,
+				     &header.id);
+
+		pci_read_config_byte(pdev, pos + INTEL_DVSEC_ENTRIES,
+				     &header.num_entries);
+
+		pci_read_config_byte(pdev, pos + INTEL_DVSEC_SIZE,
+				     &header.entry_size);
+
+		if (!header.num_entries || !header.entry_size)
+			return -EINVAL;
+
+		pci_read_config_dword(pdev, pos + INTEL_DVSEC_TABLE,
+				      &table);
+
+		header.tbir = INTEL_DVSEC_TABLE_BAR(table);
+		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
+		ret = pmt_add_dev(pdev, &header, info);
+		if (ret)
+			dev_warn(&pdev->dev,
+				 "Failed to add devices for DVSEC id %d\n",
+				 header.id);
+		last_pos = pos;
+	}
+
+	if (!last_pos) {
+		dev_err(&pdev->dev, "No supported PMT capabilities found.\n");
+		return -ENODEV;
+	}
+
+	pm_runtime_put(&pdev->dev);
+	pm_runtime_allow(&pdev->dev);
+
+	return 0;
+}
+
+static void pmt_pci_remove(struct pci_dev *pdev)
+{
+	pm_runtime_forbid(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+}
+
+static const struct pci_device_id pmt_pci_ids[] = {
+	/* TGL */
+	{ PCI_VDEVICE(INTEL, 0x9a0d), (kernel_ulong_t)&tgl_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, pmt_pci_ids);
+
+static struct pci_driver pmt_pci_driver = {
+	.name = "intel-pmt",
+	.id_table = pmt_pci_ids,
+	.probe = pmt_pci_probe,
+	.remove = pmt_pci_remove,
+};
+
+module_pci_driver(pmt_pci_driver);
+
+MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
+MODULE_DESCRIPTION("Intel Platform Monitoring Technology MFD driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/intel-dvsec.h b/include/linux/intel-dvsec.h
new file mode 100644
index 000000000000..94f606bf8eae
--- /dev/null
+++ b/include/linux/intel-dvsec.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef INTEL_DVSEC_H
+#define INTEL_DVSEC_H
+
+#include <linux/types.h>
+
+#define DVSEC_INTEL_ID_TELEM	2
+#define DVSEC_INTEL_ID_WATCHER	3
+#define DVSEC_INTEL_ID_CRASHLOG	4
+
+/* Intel DVSEC capability vendor space offsets */
+#define INTEL_DVSEC_ENTRIES		0xA
+#define INTEL_DVSEC_SIZE		0xB
+#define INTEL_DVSEC_TABLE		0xC
+#define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
+#define INTEL_DVSEC_TABLE_OFFSET(x)	((x) >> 3)
+
+#define INTEL_DVSEC_ENTRY_SIZE		4
+
+/* DVSEC header */
+struct intel_dvsec_header {
+	u16	length;
+	u16	id;
+	u8	num_entries;
+	u8	entry_size;
+	u8	entry_max;
+	u8	tbir;
+	u32	offset;
+};
+
+enum pmt_quirks {
+	/* Watcher capability not supported */
+	PMT_QUIRK_NO_WATCHER	= (1 << 0),
+
+	/* Crashlog capability not supported */
+	PMT_QUIRK_NO_CRASHLOG	= (1 << 1),
+};
+
+struct pmt_platform_info {
+	unsigned long quirks;
+	struct intel_dvsec_header **capabilities;
+};
+
+#endif
-- 
2.20.1

