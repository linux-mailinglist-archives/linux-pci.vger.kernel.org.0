Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D88B3ABE6C
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jun 2021 23:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhFQV5t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Jun 2021 17:57:49 -0400
Received: from mga14.intel.com ([192.55.52.115]:38628 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhFQV5t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Jun 2021 17:57:49 -0400
IronPort-SDR: GXjSGpVCDJg5eUClwXJiLInMVQhv6m9xWEbAkJj8Auyf19HWi8ml6gGN1NHtCz17azApEV7Tz4
 /kaAUJTg2O2w==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="206274746"
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="206274746"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 14:55:41 -0700
IronPort-SDR: FhDUH2VPtACVp5kLaKcEbjCxAE5SmOAfV+wCHuCiQBsButqXH/HTyKt7V9nWgY9R+rbjBGWIq9
 6pW9Tr6Zsqbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,281,1616482800"; 
   d="scan'208";a="451160377"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 17 Jun 2021 14:55:40 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id C2232580224;
        Thu, 17 Jun 2021 14:55:40 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, david.e.box@linux.intel.com,
        hdegoede@redhat.com, mgross@linux.intel.com, bhelgaas@google.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/4] MFD: intel_pmt: Remove OOBMSM device
Date:   Thu, 17 Jun 2021 14:54:06 -0700
Message-Id: <20210617215408.1412409-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210617215408.1412409-1-david.e.box@linux.intel.com>
References: <20210617215408.1412409-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unlike the other devices in intel_pmt, the Out of Band Management Services
Module (OOBMSM) is actually not a PMT dedicated device. It can also be used
to describe non-PMT capabilities. Like PMT, these capabilities are also
enumerated using PCIe Vendor Specific registers in config space. In order
to better support these devices without the confusion of a dependency on
MFD_INTEL_PMT, remove the OOBMSM device from intel_pmt so that it can be
later placed in its own driver. Since much of the same code will be used by
intel_pmt and the new driver, create a new file with symbols to be used by
both.

While performing this split we need to also handle the creation of platform
devices for the non-PMT capabilities. Currently PMT devices are named by
their capability (e.g. pmt_telemetry). Instead, generically name them by
their capability ID (e.g. intel_extnd_cap_2). This allows the IDs to be
created automatically.  However, to ensure that unsupported devices aren't
created, use an allow list to specify supported capabilities.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 MAINTAINERS                                |   1 +
 drivers/mfd/Kconfig                        |   4 +
 drivers/mfd/Makefile                       |   1 +
 drivers/mfd/intel_extended_caps.c          | 208 +++++++++++++++++++++
 drivers/mfd/intel_extended_caps.h          |  40 ++++
 drivers/mfd/intel_pmt.c                    | 198 ++------------------
 drivers/platform/x86/intel_pmt_crashlog.c  |   2 +-
 drivers/platform/x86/intel_pmt_telemetry.c |   2 +-
 8 files changed, 270 insertions(+), 186 deletions(-)
 create mode 100644 drivers/mfd/intel_extended_caps.c
 create mode 100644 drivers/mfd/intel_extended_caps.h

diff --git a/MAINTAINERS b/MAINTAINERS
index bc0ceef87b73..ebdc2a0f794b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9355,6 +9355,7 @@ F:	include/linux/mfd/intel_soc_pmic*
 INTEL PMT DRIVER
 M:	"David E. Box" <david.e.box@linux.intel.com>
 S:	Maintained
+F:	drivers/mfd/intel_extended_cap.c
 F:	drivers/mfd/intel_pmt.c
 F:	drivers/platform/x86/intel_pmt_*
 
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 5c7f2b100191..4dde8e223a9e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -673,10 +673,14 @@ config MFD_INTEL_PMC_BXT
 	  Register and P-unit access. In addition this creates devices
 	  for iTCO watchdog and telemetry that are part of the PMC.
 
+config MFD_INTEL_EXTENDED_CAPS
+	tristate
+
 config MFD_INTEL_PMT
 	tristate "Intel Platform Monitoring Technology (PMT) support"
 	depends on PCI
 	select MFD_CORE
+	select MFD_INTEL_EXTENDED_CAPS
 	help
 	  The Intel Platform Monitoring Technology (PMT) is an interface that
 	  provides access to hardware monitor registers. This driver supports
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 4f6d2b8a5f76..7fa35399ec76 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -209,6 +209,7 @@ obj-$(CONFIG_MFD_AT91_USART)	+= at91-usart.o
 obj-$(CONFIG_MFD_ATMEL_FLEXCOM)	+= atmel-flexcom.o
 obj-$(CONFIG_MFD_ATMEL_HLCDC)	+= atmel-hlcdc.o
 obj-$(CONFIG_MFD_ATMEL_SMC)	+= atmel-smc.o
+obj-$(CONFIG_MFD_INTEL_EXTENDED_CAPS)	+= intel_extended_caps.o
 obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
 obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
 obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
diff --git a/drivers/mfd/intel_extended_caps.c b/drivers/mfd/intel_extended_caps.c
new file mode 100644
index 000000000000..89cf1ae6f65b
--- /dev/null
+++ b/drivers/mfd/intel_extended_caps.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Extended Capabilities module
+ *
+ * Copyright (c) 2021, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Author: David E. Box <david.e.box@linux.intel.com>
+ */
+
+#include <linux/bits.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+#include "intel_extended_caps.h"
+
+/* Intel DVSEC capability vendor space offsets */
+#define INTEL_DVSEC_ENTRIES		0xA
+#define INTEL_DVSEC_SIZE		0xB
+#define INTEL_DVSEC_TABLE		0xC
+#define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
+#define INTEL_DVSEC_TABLE_OFFSET(x)	((x) & GENMASK(31, 3))
+
+/* Intel Extended Features */
+#define INTEL_EXT_CAP_ID_TELEMETRY	2
+#define INTEL_EXT_CAP_ID_WATCHER	3
+#define INTEL_EXT_CAP_ID_CRASHLOG	4
+
+#define INTEL_EXT_CAP_PREFIX		"intel_extnd_cap"
+#define FEATURE_ID_NAME_LENGTH		25
+
+static int intel_ext_cap_allow_list[] = {
+	INTEL_EXT_CAP_ID_TELEMETRY,
+	INTEL_EXT_CAP_ID_WATCHER,
+	INTEL_EXT_CAP_ID_CRASHLOG,
+};
+
+static bool intel_ext_cap_allowed(u16 id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(intel_ext_cap_allow_list); i++)
+		if (intel_ext_cap_allow_list[i] == id)
+			return true;
+
+	return false;
+}
+
+static bool intel_ext_cap_disabled(u16 id, unsigned long quirks)
+{
+	switch (id) {
+	case INTEL_EXT_CAP_ID_WATCHER:
+		return !!(quirks & EXT_CAP_QUIRK_NO_WATCHER);
+
+	case INTEL_EXT_CAP_ID_CRASHLOG:
+		return !!(quirks & EXT_CAP_QUIRK_NO_CRASHLOG);
+
+	default:
+		return false;
+	}
+}
+
+static int intel_ext_cap_add_dev(struct pci_dev *pdev, struct intel_ext_cap_header *header,
+				 unsigned long quirks)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res, *tmp;
+	struct mfd_cell *cell;
+	char feature_id_name[FEATURE_ID_NAME_LENGTH];
+	int count = header->num_entries;
+	int size = header->entry_size;
+	int id = header->id;
+	int i;
+
+	if (!intel_ext_cap_allowed(id))
+		return -EINVAL;
+
+	if (intel_ext_cap_disabled(id, quirks))
+		return -EINVAL;
+
+	snprintf(feature_id_name, sizeof(feature_id_name), "%s_%d", INTEL_EXT_CAP_PREFIX, id);
+
+	if (!header->num_entries) {
+		dev_err(dev, "Invalid 0 entry count for %s header\n", feature_id_name);
+		return -EINVAL;
+	}
+
+	if (!header->entry_size) {
+		dev_err(dev, "Invalid 0 entry size for %s header\n", feature_id_name);
+		return -EINVAL;
+	}
+
+	cell = devm_kzalloc(dev, sizeof(*cell), GFP_KERNEL);
+	if (!cell)
+		return -ENOMEM;
+
+	res = devm_kcalloc(dev, count, sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	if (quirks & EXT_CAP_QUIRK_TABLE_SHIFT)
+		header->offset >>= 3;
+
+	/*
+	 * The DVSEC contains the starting offset and count for a block of
+	 * discovery tables, each providing access to monitoring facilities for
+	 * a section of the device. Create a resource list of these tables to
+	 * provide to the driver.
+	 */
+	for (i = 0, tmp = res; i < count; i++, tmp++) {
+		tmp->start = pdev->resource[header->tbir].start +
+			     header->offset + i * (size * sizeof(u32));
+		tmp->end = tmp->start + (size * sizeof(u32)) - 1;
+		tmp->flags = IORESOURCE_MEM;
+	}
+
+	cell->resources = res;
+	cell->num_resources = count;
+	cell->name = feature_id_name;
+
+	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cell, 1, NULL, 0, NULL);
+}
+
+int intel_ext_cap_probe(struct pci_dev *pdev, struct intel_ext_cap_platform_info *info)
+{
+	unsigned long quirks = 0;
+	bool found_devices = false;
+	int ret, pos;
+
+	if (info)
+		quirks = info->quirks;
+
+	if (info && (info->quirks & EXT_CAP_QUIRK_NO_DVSEC)) {
+		struct intel_ext_cap_header **header;
+
+		header = info->capabilities;
+		while (*header) {
+			ret = intel_ext_cap_add_dev(pdev, *header, quirks);
+			if (ret)
+				dev_warn(&pdev->dev,
+					 "Failed to add device for DVSEC id %d\n",
+					 (*header)->id);
+			else
+				found_devices = true;
+
+			header++;
+		}
+	} else {
+		/* Find DVSEC features */
+		pos = 0;
+		do {
+			struct intel_ext_cap_header header;
+			u32 table, hdr;
+			u16 vid;
+
+			pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
+			if (!pos)
+				break;
+
+			pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER1, &hdr);
+			vid = PCI_DVSEC_HEADER1_VID(hdr);
+			if (vid != PCI_VENDOR_ID_INTEL)
+				continue;
+
+			/* Support only revision 1 */
+			header.rev = PCI_DVSEC_HEADER1_REV(hdr);
+			if (header.rev != 1) {
+				dev_warn(&pdev->dev, "Unsupported DVSEC revision %d\n",
+					 header.rev);
+				continue;
+			}
+
+			header.length = PCI_DVSEC_HEADER1_LEN(hdr);
+
+			pci_read_config_byte(pdev, pos + INTEL_DVSEC_ENTRIES,
+					     &header.num_entries);
+			pci_read_config_byte(pdev, pos + INTEL_DVSEC_SIZE,
+					     &header.entry_size);
+			pci_read_config_dword(pdev, pos + INTEL_DVSEC_TABLE,
+					      &table);
+
+			header.tbir = INTEL_DVSEC_TABLE_BAR(table);
+			header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
+
+			pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER2, &hdr);
+			header.id = PCI_DVSEC_HEADER2_ID(hdr);
+
+			ret = intel_ext_cap_add_dev(pdev, &header, quirks);
+			if (ret)
+				continue;
+
+			found_devices = true;
+		} while (true);
+	}
+
+	if (!found_devices)
+		return -ENODEV;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_ext_cap_probe);
+
+MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
+MODULE_DESCRIPTION("Intel Extended Capability Core driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/mfd/intel_extended_caps.h b/drivers/mfd/intel_extended_caps.h
new file mode 100644
index 000000000000..c6722d4cb5e3
--- /dev/null
+++ b/drivers/mfd/intel_extended_caps.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef INTEL_EXTENDED_CAPS_H
+#define INTEL_EXTENDED_CAPS_H
+
+/* Intel Extended Features */
+#define INTEL_EXT_CAP_ID_TELEMETRY	2
+#define INTEL_EXT_CAP_ID_WATCHER	3
+#define INTEL_EXT_CAP_ID_CRASHLOG	4
+
+struct intel_ext_cap_header {
+	u8	rev;
+	u16	length;
+	u16	id;
+	u8	num_entries;
+	u8	entry_size;
+	u8	tbir;
+	u32	offset;
+};
+
+enum intel_ext_cap_quirks {
+	/* Watcher capability not supported */
+	EXT_CAP_QUIRK_NO_WATCHER	= BIT(0),
+
+	/* Crashlog capability not supported */
+	EXT_CAP_QUIRK_NO_CRASHLOG	= BIT(1),
+
+	/* Use shift instead of mask to read discovery table offset */
+	EXT_CAP_QUIRK_TABLE_SHIFT	= BIT(2),
+
+	/* DVSEC not present (provided in driver data) */
+	EXT_CAP_QUIRK_NO_DVSEC	= BIT(3),
+};
+
+struct intel_ext_cap_platform_info {
+	unsigned long quirks;
+	struct intel_ext_cap_header **capabilities;
+};
+
+int intel_ext_cap_probe(struct pci_dev *pdev, struct intel_ext_cap_platform_info *info);
+#endif
diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
index dd7eb614c28e..f5205d6b5c47 100644
--- a/drivers/mfd/intel_pmt.c
+++ b/drivers/mfd/intel_pmt.c
@@ -8,64 +8,19 @@
  * Author: David E. Box <david.e.box@linux.intel.com>
  */
 
-#include <linux/bits.h>
-#include <linux/kernel.h>
-#include <linux/mfd/core.h>
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/platform_device.h>
-#include <linux/pm.h>
 #include <linux/pm_runtime.h>
-#include <linux/types.h>
 
-/* Intel DVSEC capability vendor space offsets */
-#define INTEL_DVSEC_ENTRIES		0xA
-#define INTEL_DVSEC_SIZE		0xB
-#define INTEL_DVSEC_TABLE		0xC
-#define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
-#define INTEL_DVSEC_TABLE_OFFSET(x)	((x) & GENMASK(31, 3))
-#define INTEL_DVSEC_ENTRY_SIZE		4
+#include "intel_extended_caps.h"
 
-/* PMT capabilities */
-#define DVSEC_INTEL_ID_TELEMETRY	2
-#define DVSEC_INTEL_ID_WATCHER		3
-#define DVSEC_INTEL_ID_CRASHLOG		4
-
-struct intel_dvsec_header {
-	u16	length;
-	u16	id;
-	u8	num_entries;
-	u8	entry_size;
-	u8	tbir;
-	u32	offset;
-};
-
-enum pmt_quirks {
-	/* Watcher capability not supported */
-	PMT_QUIRK_NO_WATCHER	= BIT(0),
-
-	/* Crashlog capability not supported */
-	PMT_QUIRK_NO_CRASHLOG	= BIT(1),
-
-	/* Use shift instead of mask to read discovery table offset */
-	PMT_QUIRK_TABLE_SHIFT	= BIT(2),
-
-	/* DVSEC not present (provided in driver data) */
-	PMT_QUIRK_NO_DVSEC	= BIT(3),
-};
-
-struct pmt_platform_info {
-	unsigned long quirks;
-	struct intel_dvsec_header **capabilities;
-};
-
-static const struct pmt_platform_info tgl_info = {
-	.quirks = PMT_QUIRK_NO_WATCHER | PMT_QUIRK_NO_CRASHLOG |
-		  PMT_QUIRK_TABLE_SHIFT,
+static const struct intel_ext_cap_platform_info tgl_info = {
+	.quirks = EXT_CAP_QUIRK_NO_WATCHER | EXT_CAP_QUIRK_NO_CRASHLOG |
+		  EXT_CAP_QUIRK_TABLE_SHIFT,
 };
 
 /* DG1 Platform with DVSEC quirk*/
-static struct intel_dvsec_header dg1_telemetry = {
+static struct intel_ext_cap_header dg1_telemetry = {
 	.length = 0x10,
 	.id = 2,
 	.num_entries = 1,
@@ -74,154 +29,31 @@ static struct intel_dvsec_header dg1_telemetry = {
 	.offset = 0x466000,
 };
 
-static struct intel_dvsec_header *dg1_capabilities[] = {
+static struct intel_ext_cap_header *dg1_capabilities[] = {
 	&dg1_telemetry,
 	NULL
 };
 
-static const struct pmt_platform_info dg1_info = {
-	.quirks = PMT_QUIRK_NO_DVSEC,
+static const struct intel_ext_cap_platform_info dg1_info = {
+	.quirks = EXT_CAP_QUIRK_NO_DVSEC,
 	.capabilities = dg1_capabilities,
 };
 
-static int pmt_add_dev(struct pci_dev *pdev, struct intel_dvsec_header *header,
-		       unsigned long quirks)
-{
-	struct device *dev = &pdev->dev;
-	struct resource *res, *tmp;
-	struct mfd_cell *cell;
-	const char *name;
-	int count = header->num_entries;
-	int size = header->entry_size;
-	int id = header->id;
-	int i;
-
-	switch (id) {
-	case DVSEC_INTEL_ID_TELEMETRY:
-		name = "pmt_telemetry";
-		break;
-	case DVSEC_INTEL_ID_WATCHER:
-		if (quirks & PMT_QUIRK_NO_WATCHER) {
-			dev_info(dev, "Watcher not supported\n");
-			return -EINVAL;
-		}
-		name = "pmt_watcher";
-		break;
-	case DVSEC_INTEL_ID_CRASHLOG:
-		if (quirks & PMT_QUIRK_NO_CRASHLOG) {
-			dev_info(dev, "Crashlog not supported\n");
-			return -EINVAL;
-		}
-		name = "pmt_crashlog";
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (!header->num_entries || !header->entry_size) {
-		dev_err(dev, "Invalid count or size for %s header\n", name);
-		return -EINVAL;
-	}
-
-	cell = devm_kzalloc(dev, sizeof(*cell), GFP_KERNEL);
-	if (!cell)
-		return -ENOMEM;
-
-	res = devm_kcalloc(dev, count, sizeof(*res), GFP_KERNEL);
-	if (!res)
-		return -ENOMEM;
-
-	if (quirks & PMT_QUIRK_TABLE_SHIFT)
-		header->offset >>= 3;
-
-	/*
-	 * The PMT DVSEC contains the starting offset and count for a block of
-	 * discovery tables, each providing access to monitoring facilities for
-	 * a section of the device. Create a resource list of these tables to
-	 * provide to the driver.
-	 */
-	for (i = 0, tmp = res; i < count; i++, tmp++) {
-		tmp->start = pdev->resource[header->tbir].start +
-			     header->offset + i * (size << 2);
-		tmp->end = tmp->start + (size << 2) - 1;
-		tmp->flags = IORESOURCE_MEM;
-	}
-
-	cell->resources = res;
-	cell->num_resources = count;
-	cell->name = name;
-
-	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cell, 1, NULL, 0,
-				    NULL);
-}
 
 static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	struct pmt_platform_info *info;
-	unsigned long quirks = 0;
-	bool found_devices = false;
-	int ret, pos = 0;
+	struct intel_ext_cap_platform_info *info;
+	int ret;
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
 		return ret;
 
-	info = (struct pmt_platform_info *)id->driver_data;
-
-	if (info)
-		quirks = info->quirks;
-
-	if (info && (info->quirks & PMT_QUIRK_NO_DVSEC)) {
-		struct intel_dvsec_header **header;
-
-		header = info->capabilities;
-		while (*header) {
-			ret = pmt_add_dev(pdev, *header, quirks);
-			if (ret)
-				dev_warn(&pdev->dev,
-					 "Failed to add device for DVSEC id %d\n",
-					 (*header)->id);
-			else
-				found_devices = true;
-
-			++header;
-		}
-	} else {
-		do {
-			struct intel_dvsec_header header;
-			u32 table;
-			u16 vid;
+	info = (struct intel_ext_cap_platform_info *)id->driver_data;
 
-			pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
-			if (!pos)
-				break;
-
-			pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vid);
-			if (vid != PCI_VENDOR_ID_INTEL)
-				continue;
-
-			pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2,
-					     &header.id);
-			pci_read_config_byte(pdev, pos + INTEL_DVSEC_ENTRIES,
-					     &header.num_entries);
-			pci_read_config_byte(pdev, pos + INTEL_DVSEC_SIZE,
-					     &header.entry_size);
-			pci_read_config_dword(pdev, pos + INTEL_DVSEC_TABLE,
-					      &table);
-
-			header.tbir = INTEL_DVSEC_TABLE_BAR(table);
-			header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
-
-			ret = pmt_add_dev(pdev, &header, quirks);
-			if (ret)
-				continue;
-
-			found_devices = true;
-		} while (true);
-	}
-
-	if (!found_devices)
-		return -ENODEV;
+	ret = intel_ext_cap_probe(pdev, info);
+	if (ret)
+		return ret;
 
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_allow(&pdev->dev);
@@ -237,12 +69,10 @@ static void pmt_pci_remove(struct pci_dev *pdev)
 
 #define PCI_DEVICE_ID_INTEL_PMT_ADL	0x467d
 #define PCI_DEVICE_ID_INTEL_PMT_DG1	0x490e
-#define PCI_DEVICE_ID_INTEL_PMT_OOBMSM	0x09a7
 #define PCI_DEVICE_ID_INTEL_PMT_TGL	0x9a0d
 static const struct pci_device_id pmt_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, PMT_ADL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, PMT_DG1, &dg1_info) },
-	{ PCI_DEVICE_DATA(INTEL, PMT_OOBMSM, NULL) },
 	{ PCI_DEVICE_DATA(INTEL, PMT_TGL, &tgl_info) },
 	{ }
 };
diff --git a/drivers/platform/x86/intel_pmt_crashlog.c b/drivers/platform/x86/intel_pmt_crashlog.c
index 92d315a16cfd..6662454af5bf 100644
--- a/drivers/platform/x86/intel_pmt_crashlog.c
+++ b/drivers/platform/x86/intel_pmt_crashlog.c
@@ -17,7 +17,7 @@
 
 #include "intel_pmt_class.h"
 
-#define DRV_NAME		"pmt_crashlog"
+#define DRV_NAME		"intel_extnd_cap_4"
 
 /* Crashlog discovery header types */
 #define CRASH_TYPE_OOBMSM	1
diff --git a/drivers/platform/x86/intel_pmt_telemetry.c b/drivers/platform/x86/intel_pmt_telemetry.c
index 9b95ef050457..f281d1d71058 100644
--- a/drivers/platform/x86/intel_pmt_telemetry.c
+++ b/drivers/platform/x86/intel_pmt_telemetry.c
@@ -17,7 +17,7 @@
 
 #include "intel_pmt_class.h"
 
-#define TELEM_DEV_NAME		"pmt_telemetry"
+#define TELEM_DEV_NAME		"intel_extnd_cap_2"
 
 #define TELEM_SIZE_OFFSET	0x0
 #define TELEM_GUID_OFFSET	0x4
-- 
2.25.1

