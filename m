Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A52841E5CC
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 03:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351358AbhJABaE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 21:30:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:46919 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351272AbhJABaC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 21:30:02 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="310871787"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="310871787"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 18:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="scan'208";a="520698089"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 30 Sep 2021 18:28:16 -0700
Received: from debox1-server.jf.intel.com (debox1-server.jf.intel.com [10.54.39.121])
        by linux.intel.com (Postfix) with ESMTP id 741A65808E0;
        Thu, 30 Sep 2021 18:28:16 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/5] platform/x86/intel: Move intel_pmt from MFD to Auxiliary Bus
Date:   Thu, 30 Sep 2021 18:28:12 -0700
Message-Id: <20211001012815.1999501-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211001012815.1999501-1-david.e.box@linux.intel.com>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel Platform Monitoring Technology (PMT) support is indicated by presence
of an Intel defined PCIe DVSEC structure with a PMT ID. However DVSEC
structures may also be used by Intel to indicate support for other
capabilities unrelated to PMT.  The Out Of Band Management Services Module
(OOBMSM) is an example of a device that can have both PMT and non-PMT
capabilities. In order to support these capabilities it is necessary to
modify the intel_pmt driver to handle the creation of platform devices more
generically. To that end the following changes are made.

Convert the driver and child drivers from MFD to the Auxiliary Bus. This
architecture is more suitable anyway since the driver partitions a
multifunctional PCIe device. This also moves the driver out of the MFD
subsystem and into platform/x86/intel.

Before, devices were named by their capability (e.g. pmt_telemetry).
Instead, generically name them by their capability ID (e.g.
intel_extended_cap.2). This allows the IDs to be created automatically,
minimizing the code needed to support future capabilities. However, to
ensure that unsupported devices aren't created, use an allow list to
specify supported capabilities. Along these lines, rename the driver from
intel_pmt to intel_extended_caps to better reflect the purpose.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V1:	New patch. However incorporates some elements of [1] which was
	dropped. Namely enumerating features generically and creating an
	allow list. Also cleans up probe by moving some code to functions
	and using a bool instead of an int to track whether a device was
	added.

[1] https://lore.kernel.org/all/20210922213007.2738388-3-david.e.box@linux.intel.com/

 MAINTAINERS                                |  10 +-
 drivers/mfd/Kconfig                        |  10 -
 drivers/mfd/Makefile                       |   1 -
 drivers/mfd/intel_pmt.c                    | 261 ---------------
 drivers/platform/x86/intel/Kconfig         |  11 +
 drivers/platform/x86/intel/Makefile        |   2 +
 drivers/platform/x86/intel/extended_caps.c | 350 +++++++++++++++++++++
 drivers/platform/x86/intel/extended_caps.h |  42 +++
 drivers/platform/x86/intel/pmt/Kconfig     |   4 +-
 drivers/platform/x86/intel/pmt/class.c     |  18 +-
 drivers/platform/x86/intel/pmt/class.h     |   5 +-
 drivers/platform/x86/intel/pmt/crashlog.c  |  43 +--
 drivers/platform/x86/intel/pmt/telemetry.c |  47 +--
 13 files changed, 475 insertions(+), 329 deletions(-)
 delete mode 100644 drivers/mfd/intel_pmt.c
 create mode 100644 drivers/platform/x86/intel/extended_caps.c
 create mode 100644 drivers/platform/x86/intel/extended_caps.h

diff --git a/MAINTAINERS b/MAINTAINERS
index ca6d6fde85cf..4e55a9f33fa3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9369,6 +9369,11 @@ S:	Supported
 F:	drivers/infiniband/hw/irdma/
 F:	include/uapi/rdma/irdma-abi.h
 
+INTEL EXTENDED CAPABILITIES DRIVER
+M:	"David E. Box" <david.e.box@linux.intel.com>
+S:	Supported
+F:	drivers/platform/x86/intel/extended_caps.*
+
 INTEL FRAMEBUFFER DRIVER (excluding 810 and 815)
 M:	Maik Broemme <mbroemme@libmpq.org>
 L:	linux-fbdev@vger.kernel.org
@@ -9578,10 +9583,9 @@ S:	Maintained
 F:	drivers/mfd/intel_soc_pmic*
 F:	include/linux/mfd/intel_soc_pmic*
 
-INTEL PMT DRIVER
+INTEL PMT DRIVERS
 M:	"David E. Box" <david.e.box@linux.intel.com>
-S:	Maintained
-F:	drivers/mfd/intel_pmt.c
+S:	Supported
 F:	drivers/platform/x86/intel/pmt/
 
 INTEL PRO/WIRELESS 2100, 2200BG, 2915ABG NETWORK CONNECTION SUPPORT
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index ca0edab91aeb..d7648473bbec 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -690,16 +690,6 @@ config MFD_INTEL_PMC_BXT
 	  Register and P-unit access. In addition this creates devices
 	  for iTCO watchdog and telemetry that are part of the PMC.
 
-config MFD_INTEL_PMT
-	tristate "Intel Platform Monitoring Technology (PMT) support"
-	depends on PCI
-	select MFD_CORE
-	help
-	  The Intel Platform Monitoring Technology (PMT) is an interface that
-	  provides access to hardware monitor registers. This driver supports
-	  Telemetry, Watcher, and Crashlog PMT capabilities/devices for
-	  platforms starting from Tiger Lake.
-
 config MFD_IPAQ_MICRO
 	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
 	depends on SA1100_H3100 || SA1100_H3600
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 2ba6646e874c..e0db12a24d1f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -212,7 +212,6 @@ obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
 obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
 obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
 obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
-obj-$(CONFIG_MFD_INTEL_PMT)	+= intel_pmt.o
 obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
 obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
 obj-$(CONFIG_MFD_NTXEC)		+= ntxec.o
diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
deleted file mode 100644
index dd7eb614c28e..000000000000
--- a/drivers/mfd/intel_pmt.c
+++ /dev/null
@@ -1,261 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Intel Platform Monitoring Technology PMT driver
- *
- * Copyright (c) 2020, Intel Corporation.
- * All Rights Reserved.
- *
- * Author: David E. Box <david.e.box@linux.intel.com>
- */
-
-#include <linux/bits.h>
-#include <linux/kernel.h>
-#include <linux/mfd/core.h>
-#include <linux/module.h>
-#include <linux/pci.h>
-#include <linux/platform_device.h>
-#include <linux/pm.h>
-#include <linux/pm_runtime.h>
-#include <linux/types.h>
-
-/* Intel DVSEC capability vendor space offsets */
-#define INTEL_DVSEC_ENTRIES		0xA
-#define INTEL_DVSEC_SIZE		0xB
-#define INTEL_DVSEC_TABLE		0xC
-#define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
-#define INTEL_DVSEC_TABLE_OFFSET(x)	((x) & GENMASK(31, 3))
-#define INTEL_DVSEC_ENTRY_SIZE		4
-
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
-};
-
-/* DG1 Platform with DVSEC quirk*/
-static struct intel_dvsec_header dg1_telemetry = {
-	.length = 0x10,
-	.id = 2,
-	.num_entries = 1,
-	.entry_size = 3,
-	.tbir = 0,
-	.offset = 0x466000,
-};
-
-static struct intel_dvsec_header *dg1_capabilities[] = {
-	&dg1_telemetry,
-	NULL
-};
-
-static const struct pmt_platform_info dg1_info = {
-	.quirks = PMT_QUIRK_NO_DVSEC,
-	.capabilities = dg1_capabilities,
-};
-
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
-
-static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-{
-	struct pmt_platform_info *info;
-	unsigned long quirks = 0;
-	bool found_devices = false;
-	int ret, pos = 0;
-
-	ret = pcim_enable_device(pdev);
-	if (ret)
-		return ret;
-
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
-
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
-
-	pm_runtime_put(&pdev->dev);
-	pm_runtime_allow(&pdev->dev);
-
-	return 0;
-}
-
-static void pmt_pci_remove(struct pci_dev *pdev)
-{
-	pm_runtime_forbid(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
-}
-
-#define PCI_DEVICE_ID_INTEL_PMT_ADL	0x467d
-#define PCI_DEVICE_ID_INTEL_PMT_DG1	0x490e
-#define PCI_DEVICE_ID_INTEL_PMT_OOBMSM	0x09a7
-#define PCI_DEVICE_ID_INTEL_PMT_TGL	0x9a0d
-static const struct pci_device_id pmt_pci_ids[] = {
-	{ PCI_DEVICE_DATA(INTEL, PMT_ADL, &tgl_info) },
-	{ PCI_DEVICE_DATA(INTEL, PMT_DG1, &dg1_info) },
-	{ PCI_DEVICE_DATA(INTEL, PMT_OOBMSM, NULL) },
-	{ PCI_DEVICE_DATA(INTEL, PMT_TGL, &tgl_info) },
-	{ }
-};
-MODULE_DEVICE_TABLE(pci, pmt_pci_ids);
-
-static struct pci_driver pmt_pci_driver = {
-	.name = "intel-pmt",
-	.id_table = pmt_pci_ids,
-	.probe = pmt_pci_probe,
-	.remove = pmt_pci_remove,
-};
-module_pci_driver(pmt_pci_driver);
-
-MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
-MODULE_DESCRIPTION("Intel Platform Monitoring Technology PMT driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/intel/Kconfig b/drivers/platform/x86/intel/Kconfig
index 0b21468e1bd0..d7492372efc3 100644
--- a/drivers/platform/x86/intel/Kconfig
+++ b/drivers/platform/x86/intel/Kconfig
@@ -26,6 +26,17 @@ source "drivers/platform/x86/intel/speed_select_if/Kconfig"
 source "drivers/platform/x86/intel/telemetry/Kconfig"
 source "drivers/platform/x86/intel/wmi/Kconfig"
 
+config INTEL_EXTENDED_CAPS
+	tristate "Intel Extended Capabilities support"
+	depends on PCI
+	select AUXILIARY_BUS
+	help
+	  Adds support for feature drivers exposed using Intel PCIe VSEC and
+	  DVSEC.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called intel_extended_caps.
+
 config INTEL_HID_EVENT
 	tristate "Intel HID Event"
 	depends on ACPI
diff --git a/drivers/platform/x86/intel/Makefile b/drivers/platform/x86/intel/Makefile
index 8b3a3f7bab49..6f5bee0e1f58 100644
--- a/drivers/platform/x86/intel/Makefile
+++ b/drivers/platform/x86/intel/Makefile
@@ -21,6 +21,8 @@ intel-vbtn-y				:= vbtn.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
 # Intel miscellaneous drivers
+intel_extended_caps-y			:= extended_caps.o
+obj-$(CONFIG_INTEL_EXTENDED_CAPS)	+= intel_extended_caps.o
 intel_int0002_vgpio-y			:= int0002_vgpio.o
 obj-$(CONFIG_INTEL_INT0002_VGPIO)	+= intel_int0002_vgpio.o
 intel_oaktrail-y			:= oaktrail.o
diff --git a/drivers/platform/x86/intel/extended_caps.c b/drivers/platform/x86/intel/extended_caps.c
new file mode 100644
index 000000000000..03acea20b675
--- /dev/null
+++ b/drivers/platform/x86/intel/extended_caps.c
@@ -0,0 +1,350 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Extended Capabilities auxiliary bus driver
+ *
+ * Copyright (c) 2021, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Author: David E. Box <david.e.box@linux.intel.com>
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bits.h>
+#include <linux/kernel.h>
+#include <linux/idr.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#include "extended_caps.h"
+
+/* Intel DVSEC capability vendor space offsets */
+#define INTEL_DVSEC_ENTRIES		0xA
+#define INTEL_DVSEC_SIZE		0xB
+#define INTEL_DVSEC_TABLE		0xC
+#define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
+#define INTEL_DVSEC_TABLE_OFFSET(x)	((x) & GENMASK(31, 3))
+#define INTEL_DVSEC_ENTRY_SIZE		4
+
+/* EXT_CAPS capabilities */
+#define EXTENDED_CAP_ID_TELEMETRY	2
+#define EXTENDED_CAP_ID_WATCHER		3
+#define EXTENDED_CAP_ID_CRASHLOG	4
+
+static DEFINE_IDA(extended_caps_ida);
+
+static int extended_caps_allow_list[] = {
+	EXTENDED_CAP_ID_TELEMETRY,
+	EXTENDED_CAP_ID_WATCHER,
+	EXTENDED_CAP_ID_CRASHLOG,
+};
+
+struct extended_caps_platform_info {
+	struct extended_caps_header **capabilities;
+	unsigned long quirks;
+};
+
+static const struct extended_caps_platform_info tgl_info = {
+	.quirks = EXT_CAPS_QUIRK_NO_WATCHER | EXT_CAPS_QUIRK_NO_CRASHLOG |
+		  EXT_CAPS_QUIRK_TABLE_SHIFT,
+};
+
+/* DG1 Platform with DVSEC quirk*/
+static struct extended_caps_header dg1_telemetry = {
+	.length = 0x10,
+	.id = 2,
+	.num_entries = 1,
+	.entry_size = 3,
+	.tbir = 0,
+	.offset = 0x466000,
+};
+
+static struct extended_caps_header *dg1_capabilities[] = {
+	&dg1_telemetry,
+	NULL
+};
+
+static const struct extended_caps_platform_info dg1_info = {
+	.capabilities = dg1_capabilities,
+	.quirks = EXT_CAPS_QUIRK_NO_DVSEC,
+};
+
+static bool extended_caps_allowed(u16 id)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(extended_caps_allow_list); i++)
+		if (extended_caps_allow_list[i] == id)
+			return true;
+
+	return false;
+}
+
+static bool extended_caps_disabled(u16 id, unsigned long quirks)
+{
+	switch (id) {
+	case EXTENDED_CAP_ID_WATCHER:
+		return !!(quirks & EXT_CAPS_QUIRK_NO_WATCHER);
+
+	case EXTENDED_CAP_ID_CRASHLOG:
+		return !!(quirks & EXT_CAPS_QUIRK_NO_CRASHLOG);
+
+	default:
+		return false;
+	}
+}
+
+struct resource *intel_ext_cap_get_resource(struct intel_extended_cap_device *intel_cap_dev,
+					    unsigned int num)
+{
+	u32 i;
+
+	for (i = 0; i < intel_cap_dev->num_resources; i++) {
+		struct resource *r = &intel_cap_dev->resource[i];
+
+		if (num-- == 0)
+			return r;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_NS(intel_ext_cap_get_resource, INTEL_EXT_CAPS);
+
+static void extended_caps_remove_aux(void *data)
+{
+	auxiliary_device_delete(data);
+	auxiliary_device_uninit(data);
+}
+
+static void extended_caps_dev_release(struct device *dev)
+{
+	struct intel_extended_cap_device *intel_cap_dev =
+			container_of(dev, struct intel_extended_cap_device, aux_dev.dev);
+
+	ida_free(&extended_caps_ida, intel_cap_dev->aux_dev.id);
+	kfree(intel_cap_dev->resource);
+	kfree(intel_cap_dev);
+}
+
+static int extended_caps_add_dev(struct pci_dev *pdev, struct extended_caps_header *header,
+				 unsigned long quirks)
+{
+	struct intel_extended_cap_device *intel_cap_dev;
+	struct auxiliary_device *aux_dev;
+	struct resource *res, *tmp;
+	int count = header->num_entries;
+	int size = header->entry_size;
+	int id = header->id;
+	char id_str[8];
+	int ret, i;
+
+	if (!extended_caps_allowed(id))
+		return -EINVAL;
+
+	if (extended_caps_disabled(id, quirks))
+		return -EINVAL;
+
+	if (!header->num_entries) {
+		dev_err(&pdev->dev, "Invalid 0 entry count for header id %d\n", id);
+		return -EINVAL;
+	}
+
+	if (!header->entry_size) {
+		dev_err(&pdev->dev, "Invalid 0 entry size for headerid %d\n", id);
+		return -EINVAL;
+	}
+
+	intel_cap_dev = kzalloc(sizeof(*intel_cap_dev), GFP_KERNEL);
+	if (!intel_cap_dev)
+		return -ENOMEM;
+
+	res = kcalloc(count, sizeof(*res), GFP_KERNEL);
+	if (!res) {
+		kfree(intel_cap_dev);
+		return -ENOMEM;
+	}
+
+	if (quirks & EXT_CAPS_QUIRK_TABLE_SHIFT)
+		header->offset >>= 3;
+
+	/*
+	 * The DVSEC/VSEC contains the starting offset and count for a block of
+	 * discovery tables. Create a resource list of these tables to the
+	 * auxiliary device driver.
+	 */
+	for (i = 0, tmp = res; i < count; i++, tmp++) {
+		tmp->start = pdev->resource[header->tbir].start +
+			     header->offset + i * (size * sizeof(u32));
+		tmp->end = tmp->start + (size * sizeof(u32)) - 1;
+		tmp->flags = IORESOURCE_MEM;
+	}
+
+	intel_cap_dev->header = header;
+	intel_cap_dev->pcidev = pdev;
+	intel_cap_dev->resource = res;
+	intel_cap_dev->num_resources = count;
+	intel_cap_dev->quirks = quirks;
+
+	snprintf(id_str, sizeof(id_str), "%d", id);
+
+	aux_dev = &intel_cap_dev->aux_dev;
+	aux_dev->name = id_str;
+	aux_dev->dev.parent = &pdev->dev;
+	aux_dev->dev.release = extended_caps_dev_release;
+
+	ret = ida_alloc(&extended_caps_ida, GFP_KERNEL);
+	if (ret < 0) {
+		kfree(res);
+		kfree(intel_cap_dev);
+		return ret;
+	}
+	aux_dev->id = ret;
+
+	ret = auxiliary_device_init(aux_dev);
+	if (ret < 0) {
+		ida_free(&extended_caps_ida, aux_dev->id);
+		kfree(res);
+		kfree(intel_cap_dev);
+		return ret;
+	}
+
+	ret = auxiliary_device_add(aux_dev);
+	if (ret) {
+		auxiliary_device_uninit(aux_dev);
+		ida_free(&extended_caps_ida, aux_dev->id);
+		kfree(res);
+		kfree(intel_cap_dev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(&pdev->dev, extended_caps_remove_aux, aux_dev);
+}
+
+static bool extended_caps_walk_header(struct pci_dev *pdev, unsigned long quirks,
+				      struct extended_caps_header **header)
+{
+	bool have_devices = false;
+	int ret;
+
+	while (*header) {
+		ret = extended_caps_add_dev(pdev, *header, quirks);
+		if (ret)
+			dev_warn(&pdev->dev,
+				 "Failed to add device for DVSEC id %d\n",
+				 (*header)->id);
+		else
+			have_devices = true;
+
+		++header;
+	}
+
+	return have_devices;
+}
+
+static bool extended_caps_walk_dvsec(struct pci_dev *pdev, unsigned long quirks)
+{
+	bool have_devices = false;
+	int pos = 0;
+
+	do {
+		struct extended_caps_header header;
+		u32 table, hdr;
+		u16 vid;
+		int ret;
+
+		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
+		if (!pos)
+			break;
+
+		pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER1, &hdr);
+		vid = PCI_DVSEC_HEADER1_VID(hdr);
+		if (vid != PCI_VENDOR_ID_INTEL)
+			continue;
+
+		/* Support only revision 1 */
+		header.rev = PCI_DVSEC_HEADER1_REV(hdr);
+		if (header.rev != 1) {
+			dev_warn(&pdev->dev, "Unsupported DVSEC revision %d\n",
+				 header.rev);
+			continue;
+		}
+
+		header.length = PCI_DVSEC_HEADER1_LEN(hdr);
+
+		pci_read_config_byte(pdev, pos + INTEL_DVSEC_ENTRIES,
+				     &header.num_entries);
+		pci_read_config_byte(pdev, pos + INTEL_DVSEC_SIZE,
+				     &header.entry_size);
+		pci_read_config_dword(pdev, pos + INTEL_DVSEC_TABLE,
+				      &table);
+
+		header.tbir = INTEL_DVSEC_TABLE_BAR(table);
+		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
+
+		pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER2, &hdr);
+		header.id = PCI_DVSEC_HEADER2_ID(hdr);
+
+		ret = extended_caps_add_dev(pdev, &header, quirks);
+		if (ret)
+			continue;
+
+		have_devices = true;
+	} while (true);
+
+	return have_devices;
+}
+
+static int extended_caps_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct extended_caps_platform_info *info;
+	bool have_devices = false;
+	unsigned long quirks = 0;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	info = (struct extended_caps_platform_info *)id->driver_data;
+	if (info)
+		quirks = info->quirks;
+
+	have_devices |= extended_caps_walk_dvsec(pdev, quirks);
+
+	if (info && (info->quirks & EXT_CAPS_QUIRK_NO_DVSEC))
+		have_devices |= extended_caps_walk_header(pdev, quirks, info->capabilities);
+
+	if (!have_devices)
+		return -ENODEV;
+
+	return 0;
+}
+
+static void extended_caps_pci_remove(struct pci_dev *pdev)
+{
+}
+
+#define PCI_DEVICE_ID_INTEL_EXT_CAPS_ADL	0x467d
+#define PCI_DEVICE_ID_INTEL_EXT_CAPS_DG1	0x490e
+#define PCI_DEVICE_ID_INTEL_EXT_CAPS_OOBMSM	0x09a7
+#define PCI_DEVICE_ID_INTEL_EXT_CAPS_TGL	0x9a0d
+static const struct pci_device_id extended_caps_pci_ids[] = {
+	{ PCI_DEVICE_DATA(INTEL, EXT_CAPS_ADL, &tgl_info) },
+	{ PCI_DEVICE_DATA(INTEL, EXT_CAPS_DG1, &dg1_info) },
+	{ PCI_DEVICE_DATA(INTEL, EXT_CAPS_OOBMSM, NULL) },
+	{ PCI_DEVICE_DATA(INTEL, EXT_CAPS_TGL, &tgl_info) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, extended_caps_pci_ids);
+
+static struct pci_driver extended_caps_pci_driver = {
+	.name = "intel_extended_caps",
+	.id_table = extended_caps_pci_ids,
+	.probe = extended_caps_pci_probe,
+	.remove = extended_caps_pci_remove,
+};
+module_pci_driver(extended_caps_pci_driver);
+
+MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
+MODULE_DESCRIPTION("Intel Extended Capabilities auxiliary bus driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/intel/extended_caps.h b/drivers/platform/x86/intel/extended_caps.h
new file mode 100644
index 000000000000..952e7150f308
--- /dev/null
+++ b/drivers/platform/x86/intel/extended_caps.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EXTENDED_CAPS_H
+#define _EXTENDED_CAPS_H
+
+#include <linux/auxiliary_bus.h>
+
+struct extended_caps_header {
+	u8	rev;
+	u16	length;
+	u16	id;
+	u8	num_entries;
+	u8	entry_size;
+	u8	tbir;
+	u32	offset;
+};
+
+enum extended_caps_quirks {
+	/* Watcher capability not supported */
+	EXT_CAPS_QUIRK_NO_WATCHER	= BIT(0),
+
+	/* Crashlog capability not supported */
+	EXT_CAPS_QUIRK_NO_CRASHLOG	= BIT(1),
+
+	/* Use shift instead of mask to read discovery table offset */
+	EXT_CAPS_QUIRK_TABLE_SHIFT	= BIT(2),
+
+	/* DVSEC not present (provided in driver data) */
+	EXT_CAPS_QUIRK_NO_DVSEC		= BIT(3),
+};
+
+struct intel_extended_cap_device {
+	struct auxiliary_device aux_dev;
+	struct extended_caps_header *header;
+	struct pci_dev *pcidev;
+	struct resource *resource;
+	unsigned long quirks;
+	int num_resources;
+};
+
+struct resource *intel_ext_cap_get_resource(struct intel_extended_cap_device *intel_cap_dev,
+					    unsigned int num);
+#endif
diff --git a/drivers/platform/x86/intel/pmt/Kconfig b/drivers/platform/x86/intel/pmt/Kconfig
index d630f883a717..8eaedd242dba 100644
--- a/drivers/platform/x86/intel/pmt/Kconfig
+++ b/drivers/platform/x86/intel/pmt/Kconfig
@@ -17,7 +17,7 @@ config INTEL_PMT_CLASS
 
 config INTEL_PMT_TELEMETRY
 	tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
-	depends on MFD_INTEL_PMT
+	depends on INTEL_EXTENDED_CAPS
 	select INTEL_PMT_CLASS
 	help
 	  The Intel Platform Monitory Technology (PMT) Telemetry driver provides
@@ -29,7 +29,7 @@ config INTEL_PMT_TELEMETRY
 
 config INTEL_PMT_CRASHLOG
 	tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
-	depends on MFD_INTEL_PMT
+	depends on INTEL_EXTENDED_CAPS
 	select INTEL_PMT_CLASS
 	help
 	  The Intel Platform Monitoring Technology (PMT) crashlog driver provides
diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index 659b1073033c..1414170b0aeb 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -14,6 +14,7 @@
 #include <linux/pci.h>
 
 #include "class.h"
+#include "../extended_caps.h"
 
 #define PMT_XA_START		0
 #define PMT_XA_MAX		INT_MAX
@@ -281,31 +282,31 @@ static int intel_pmt_dev_register(struct intel_pmt_entry *entry,
 	return ret;
 }
 
-int intel_pmt_dev_create(struct intel_pmt_entry *entry,
-			 struct intel_pmt_namespace *ns,
-			 struct platform_device *pdev, int idx)
+int intel_pmt_dev_create(struct intel_pmt_entry *entry, struct intel_pmt_namespace *ns,
+			 struct intel_extended_cap_device *intel_cap_dev, int idx)
 {
+	struct device *dev = &intel_cap_dev->aux_dev.dev;
 	struct intel_pmt_header header;
 	struct resource	*disc_res;
 	int ret = -ENODEV;
 
-	disc_res = platform_get_resource(pdev, IORESOURCE_MEM, idx);
+	disc_res = intel_ext_cap_get_resource(intel_cap_dev, idx);
 	if (!disc_res)
 		return ret;
 
-	entry->disc_table = devm_platform_ioremap_resource(pdev, idx);
+	entry->disc_table = devm_ioremap_resource(dev, disc_res);
 	if (IS_ERR(entry->disc_table))
 		return PTR_ERR(entry->disc_table);
 
-	ret = ns->pmt_header_decode(entry, &header, &pdev->dev);
+	ret = ns->pmt_header_decode(entry, &header, dev);
 	if (ret)
 		return ret;
 
-	ret = intel_pmt_populate_entry(entry, &header, &pdev->dev, disc_res);
+	ret = intel_pmt_populate_entry(entry, &header, dev, disc_res);
 	if (ret)
 		return ret;
 
-	return intel_pmt_dev_register(entry, ns, &pdev->dev);
+	return intel_pmt_dev_register(entry, ns, dev);
 
 }
 EXPORT_SYMBOL_GPL(intel_pmt_dev_create);
@@ -342,3 +343,4 @@ module_exit(pmt_class_exit);
 MODULE_AUTHOR("Alexander Duyck <alexander.h.duyck@linux.intel.com>");
 MODULE_DESCRIPTION("Intel PMT Class driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(INTEL_EXT_CAPS);
diff --git a/drivers/platform/x86/intel/pmt/class.h b/drivers/platform/x86/intel/pmt/class.h
index 1337019c2873..b2a5e459a7ed 100644
--- a/drivers/platform/x86/intel/pmt/class.h
+++ b/drivers/platform/x86/intel/pmt/class.h
@@ -2,13 +2,14 @@
 #ifndef _INTEL_PMT_CLASS_H
 #define _INTEL_PMT_CLASS_H
 
-#include <linux/platform_device.h>
 #include <linux/xarray.h>
 #include <linux/types.h>
 #include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include "../extended_caps.h"
+
 /* PMT access types */
 #define ACCESS_BARID		2
 #define ACCESS_LOCAL		3
@@ -47,7 +48,7 @@ struct intel_pmt_namespace {
 bool intel_pmt_is_early_client_hw(struct device *dev);
 int intel_pmt_dev_create(struct intel_pmt_entry *entry,
 			 struct intel_pmt_namespace *ns,
-			 struct platform_device *pdev, int idx);
+			 struct intel_extended_cap_device *dev, int idx);
 void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
 			   struct intel_pmt_namespace *ns);
 #endif
diff --git a/drivers/platform/x86/intel/pmt/crashlog.c b/drivers/platform/x86/intel/pmt/crashlog.c
index 1c1021f04d3c..1565f9e9f836 100644
--- a/drivers/platform/x86/intel/pmt/crashlog.c
+++ b/drivers/platform/x86/intel/pmt/crashlog.c
@@ -8,6 +8,7 @@
  * Author: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -15,10 +16,9 @@
 #include <linux/uaccess.h>
 #include <linux/overflow.h>
 
+#include "../extended_caps.h"
 #include "class.h"
 
-#define DRV_NAME		"pmt_crashlog"
-
 /* Crashlog discovery header types */
 #define CRASH_TYPE_OOBMSM	1
 
@@ -257,34 +257,35 @@ static struct intel_pmt_namespace pmt_crashlog_ns = {
 /*
  * initialization
  */
-static int pmt_crashlog_remove(struct platform_device *pdev)
+static void pmt_crashlog_remove(struct auxiliary_device *adev)
 {
-	struct pmt_crashlog_priv *priv = platform_get_drvdata(pdev);
+	struct pmt_crashlog_priv *priv = dev_get_drvdata(&adev->dev);
 	int i;
 
 	for (i = 0; i < priv->num_entries; i++)
 		intel_pmt_dev_destroy(&priv->entry[i].entry, &pmt_crashlog_ns);
-
-	return 0;
 }
 
-static int pmt_crashlog_probe(struct platform_device *pdev)
+static int pmt_crashlog_probe(struct auxiliary_device *adev,
+			      const struct auxiliary_device_id *id)
 {
+	struct intel_extended_cap_device *intel_cap_dev =
+			container_of(adev, struct intel_extended_cap_device, aux_dev);
 	struct pmt_crashlog_priv *priv;
 	size_t size;
 	int i, ret;
 
-	size = struct_size(priv, entry, pdev->num_resources);
-	priv = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	size = struct_size(priv, entry, intel_cap_dev->num_resources);
+	priv = devm_kzalloc(&adev->dev, size, GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, priv);
+	dev_set_drvdata(&adev->dev, priv);
 
-	for (i = 0; i < pdev->num_resources; i++) {
+	for (i = 0; i < intel_cap_dev->num_resources; i++) {
 		struct intel_pmt_entry *entry = &priv->entry[i].entry;
 
-		ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns, pdev, i);
+		ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns, intel_cap_dev, i);
 		if (ret < 0)
 			goto abort_probe;
 		if (ret)
@@ -295,26 +296,29 @@ static int pmt_crashlog_probe(struct platform_device *pdev)
 
 	return 0;
 abort_probe:
-	pmt_crashlog_remove(pdev);
+	pmt_crashlog_remove(adev);
 	return ret;
 }
 
-static struct platform_driver pmt_crashlog_driver = {
-	.driver = {
-		.name   = DRV_NAME,
-	},
+static const struct auxiliary_device_id pmt_crashlog_aux_id_table[] = {
+	{ .name = "intel_extended_caps.4", },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, pmt_crashlog_aux_id_table);
+
+static struct auxiliary_driver pmt_crashlog_aux_driver = {
 	.remove = pmt_crashlog_remove,
 	.probe  = pmt_crashlog_probe,
 };
 
 static int __init pmt_crashlog_init(void)
 {
-	return platform_driver_register(&pmt_crashlog_driver);
+	return auxiliary_driver_register(&pmt_crashlog_aux_driver);
 }
 
 static void __exit pmt_crashlog_exit(void)
 {
-	platform_driver_unregister(&pmt_crashlog_driver);
+	auxiliary_driver_unregister(&pmt_crashlog_aux_driver);
 	xa_destroy(&crashlog_array);
 }
 
@@ -323,5 +327,4 @@ module_exit(pmt_crashlog_exit);
 
 MODULE_AUTHOR("Alexander Duyck <alexander.h.duyck@linux.intel.com>");
 MODULE_DESCRIPTION("Intel PMT Crashlog driver");
-MODULE_ALIAS("platform:" DRV_NAME);
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
index 38d52651c572..2f6a10772cbe 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -8,6 +8,7 @@
  * Author: "David E. Box" <david.e.box@linux.intel.com>
  */
 
+#include <linux/auxiliary_bus.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -15,10 +16,9 @@
 #include <linux/uaccess.h>
 #include <linux/overflow.h>
 
+#include "../extended_caps.h"
 #include "class.h"
 
-#define TELEM_DEV_NAME		"pmt_telemetry"
-
 #define TELEM_SIZE_OFFSET	0x0
 #define TELEM_GUID_OFFSET	0x4
 #define TELEM_BASE_OFFSET	0x8
@@ -79,34 +79,34 @@ static struct intel_pmt_namespace pmt_telem_ns = {
 	.pmt_header_decode = pmt_telem_header_decode,
 };
 
-static int pmt_telem_remove(struct platform_device *pdev)
+static void pmt_telem_remove(struct auxiliary_device *adev)
 {
-	struct pmt_telem_priv *priv = platform_get_drvdata(pdev);
+	struct pmt_telem_priv *priv = dev_get_drvdata(&adev->dev);
 	int i;
 
 	for (i = 0; i < priv->num_entries; i++)
 		intel_pmt_dev_destroy(&priv->entry[i], &pmt_telem_ns);
-
-	return 0;
 }
 
-static int pmt_telem_probe(struct platform_device *pdev)
+static int pmt_telem_probe(struct auxiliary_device *adev, const struct auxiliary_device_id *id)
 {
+	struct intel_extended_cap_device *intel_cap_dev =
+			container_of(adev, struct intel_extended_cap_device, aux_dev);
 	struct pmt_telem_priv *priv;
 	size_t size;
 	int i, ret;
 
-	size = struct_size(priv, entry, pdev->num_resources);
-	priv = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	size = struct_size(priv, entry, intel_cap_dev->num_resources);
+	priv = devm_kzalloc(&adev->dev, size, GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, priv);
+	dev_set_drvdata(&adev->dev, priv);
 
-	for (i = 0; i < pdev->num_resources; i++) {
+	for (i = 0; i < intel_cap_dev->num_resources; i++) {
 		struct intel_pmt_entry *entry = &priv->entry[i];
 
-		ret = intel_pmt_dev_create(entry, &pmt_telem_ns, pdev, i);
+		ret = intel_pmt_dev_create(entry, &pmt_telem_ns, intel_cap_dev, i);
 		if (ret < 0)
 			goto abort_probe;
 		if (ret)
@@ -117,32 +117,35 @@ static int pmt_telem_probe(struct platform_device *pdev)
 
 	return 0;
 abort_probe:
-	pmt_telem_remove(pdev);
+	pmt_telem_remove(adev);
 	return ret;
 }
 
-static struct platform_driver pmt_telem_driver = {
-	.driver = {
-		.name   = TELEM_DEV_NAME,
-	},
-	.remove = pmt_telem_remove,
-	.probe  = pmt_telem_probe,
+static const struct auxiliary_device_id pmt_telem_aux_id_table[] = {
+	{ .name = "intel_extended_caps.2", },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, pmt_telem_aux_id_table);
+
+static struct auxiliary_driver pmt_telem_aux_driver = {
+	.id_table	= pmt_telem_aux_id_table,
+	.remove		= pmt_telem_remove,
+	.probe		= pmt_telem_probe,
 };
 
 static int __init pmt_telem_init(void)
 {
-	return platform_driver_register(&pmt_telem_driver);
+	return auxiliary_driver_register(&pmt_telem_aux_driver);
 }
 module_init(pmt_telem_init);
 
 static void __exit pmt_telem_exit(void)
 {
-	platform_driver_unregister(&pmt_telem_driver);
+	auxiliary_driver_unregister(&pmt_telem_aux_driver);
 	xa_destroy(&telem_array);
 }
 module_exit(pmt_telem_exit);
 
 MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
 MODULE_DESCRIPTION("Intel PMT Telemetry driver");
-MODULE_ALIAS("platform:" TELEM_DEV_NAME);
 MODULE_LICENSE("GPL v2");
-- 
2.25.1

