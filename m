Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790E327F78A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 03:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbgJABm7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 21:42:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:48414 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbgJABm7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 21:42:59 -0400
IronPort-SDR: rei45rgVNxx5mzLnR4YrshtHyUJPbDc0ArX1sPlm4wnrWjL6E1xtZJqsS9VQCk/L4msMC1oKQI
 isaFULm3/4BA==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="180750566"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="180750566"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 18:42:57 -0700
IronPort-SDR: q8mjuYQENXxIQ1RqQeeYDZHUMqe+lJQHEOqLsEoin4CQ7lQexbdAcQZoSpulQRTsgX/1+j2dvq
 KJvTlp2FHqFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="294226096"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 30 Sep 2020 18:42:57 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 1AD6C58094E;
        Wed, 30 Sep 2020 18:42:57 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, david.e.box@linux.intel.com,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com, hdegoede@redhat.com,
        alexey.budankov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V7 5/5] platform/x86: Intel PMT Crashlog capability driver
Date:   Wed, 30 Sep 2020 18:42:50 -0700
Message-Id: <20201001014250.26987-6-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201001014250.26987-1-david.e.box@linux.intel.com>
References: <20201001014250.26987-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Add support for the Intel Platform Monitoring Technology crashlog
interface. This interface provides a few sysfs values to allow for
controlling the crashlog telemetry interface as well as a character driver
to allow for mapping the crashlog memory region so that it can be accessed
after a crashlog has been recorded.

This driver is meant to only support the server version of the crashlog
which is identified as crash_type 1 with a version of zero. Currently no
other types are supported.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 .../ABI/testing/sysfs-class-intel_pmt         |  65 ++++
 drivers/platform/x86/Kconfig                  |   8 +
 drivers/platform/x86/Makefile                 |   1 +
 drivers/platform/x86/intel_pmt_crashlog.c     | 339 ++++++++++++++++++
 4 files changed, 413 insertions(+)
 create mode 100644 drivers/platform/x86/intel_pmt_crashlog.c

diff --git a/Documentation/ABI/testing/sysfs-class-intel_pmt b/Documentation/ABI/testing/sysfs-class-intel_pmt
index 926b5cf95fd1..67ca47123cbf 100644
--- a/Documentation/ABI/testing/sysfs-class-intel_pmt
+++ b/Documentation/ABI/testing/sysfs-class-intel_pmt
@@ -52,3 +52,68 @@ Contact:	David Box <david.e.box@linux.intel.com>
 Description:
 		(RO) The offset of telemetry region in bytes that corresponds to
 		the mapping for the telem file.
+
+What:		/sys/class/intel_pmt/crashlog<x>
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	Alexander Duyck <alexander.h.duyck@linux.intel.com>
+Description:
+		The crashlog<x> directory contains files for configuring an
+		instance of a PMT crashlog device that can perform crash data
+		recoring. Each crashlog<x> device has an associated crashlog
+		file. This file can be opened and mapped or read to access the
+		resulting crashlog buffer. The register layout for the buffer
+		can be determined from an XML file of specified guid for the
+		parent device.
+
+What:		/sys/class/intel_pmt/crashlog<x>/crashlog
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	David Box <david.e.box@linux.intel.com>
+Description:
+		(RO) The crashlog buffer for this crashlog device. This file
+		may be mapped or read to obtain the data.
+
+What:		/sys/class/intel_pmt/crashlog<x>/guid
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	Alexander Duyck <alexander.h.duyck@linux.intel.com>
+Description:
+		(RO) The guid for this crashlog device. The guid identifies the
+		version of the XML file for the parent device that should be
+		used to determine the register layout.
+
+What:		/sys/class/intel_pmt/crashlog<x>/size
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	Alexander Duyck <alexander.h.duyck@linux.intel.com>
+Description:
+		(RO) The length of the result buffer in bytes that corresponds
+		to the size for the crashlog buffer.
+
+What:		/sys/class/intel_pmt/crashlog<x>/offset
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	Alexander Duyck <alexander.h.duyck@linux.intel.com>
+Description:
+		(RO) The offset of the buffer in bytes that corresponds
+		to the mapping for the crashlog device.
+
+What:		/sys/class/intel_pmt/crashlog<x>/enable
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	Alexander Duyck <alexander.h.duyck@linux.intel.com>
+Description:
+		(RW) Boolean value controlling if the crashlog functionality
+		is enabled for the crashlog device.
+
+What:		/sys/class/intel_pmt/crashlog<x>/trigger
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	Alexander Duyck <alexander.h.duyck@linux.intel.com>
+Description:
+		(RW) Boolean value controlling the triggering of the crashlog
+		device node. When read it provides data on if the crashlog has
+		been triggered. When written to it can be used to either clear
+		the current trigger by writing false, or to trigger a new
+		event if the trigger is not currently set.
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 8eae17a57a5b..529c5ee2eabf 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1377,6 +1377,14 @@ config INTEL_PMT_TELEMETRY
 	  access to hardware telemetry metrics on devices that support the
 	  feature.
 
+config INTEL_PMT_CRASHLOG
+	tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
+	select INTEL_PMT_CLASS
+	help
+	  The Intel Platform Monitoring Technology (PMT) crashlog driver provides
+	  access to hardware crashlog capabilities on devices that support the
+	  feature.
+
 config INTEL_PUNIT_IPC
 	tristate "Intel P-Unit IPC Driver"
 	help
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 6a7b61f59ea8..ca82c1344977 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -142,6 +142,7 @@ obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
 obj-$(CONFIG_INTEL_PMT_CLASS)		+= intel_pmt_class.o
 obj-$(CONFIG_INTEL_PMT_TELEMETRY)	+= intel_pmt_telemetry.o
+obj-$(CONFIG_INTEL_PMT_CRASHLOG)	+= intel_pmt_crashlog.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
diff --git a/drivers/platform/x86/intel_pmt_crashlog.c b/drivers/platform/x86/intel_pmt_crashlog.c
new file mode 100644
index 000000000000..9c77be39ac16
--- /dev/null
+++ b/drivers/platform/x86/intel_pmt_crashlog.c
@@ -0,0 +1,339 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Platform Monitoring Technology Crashlog driver
+ *
+ * Copyright (c) 2020, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Author: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
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
+#define DRV_NAME		"pmt_crashlog"
+
+/* Crashlog discovery header types */
+#define CRASH_TYPE_OOBMSM	1
+
+/* Control Flags */
+#define CRASHLOG_FLAG_DISABLE	BIT(27)
+#define CRASHLOG_FLAG_CLEAR	BIT(28)
+#define CRASHLOG_FLAG_EXECUTE	BIT(29)
+#define CRASHLOG_FLAG_COMPLETE	BIT(31)
+#define CRASHLOG_FLAG_MASK	GENMASK(31, 28)
+
+/* Crashlog Discovery Header */
+#define CONTROL_OFFSET		0x0
+#define GUID_OFFSET		0x4
+#define BASE_OFFSET		0x8
+#define SIZE_OFFSET		0xC
+#define GET_ACCESS(v)		((v) & GENMASK(3, 0))
+#define GET_TYPE(v)		(((v) & GENMASK(7, 4)) >> 4)
+#define GET_VERSION(v)		(((v) & GENMASK(19, 16)) >> 16)
+/* size is in bytes */
+#define GET_SIZE(v)		((v) * sizeof(u32))
+
+struct crashlog_entry {
+	/* entry must be first member of struct */
+	struct intel_pmt_entry		entry;
+	struct mutex			control_mutex;
+};
+
+struct pmt_crashlog_priv {
+	int			num_entries;
+	struct crashlog_entry	entry[];
+};
+
+/*
+ * I/O
+ */
+static bool pmt_crashlog_complete(struct intel_pmt_entry *entry)
+{
+	u32 control = readl(entry->disc_table + CONTROL_OFFSET);
+
+	/* return current value of the crashlog complete flag */
+	return !!(control & CRASHLOG_FLAG_COMPLETE);
+}
+
+static bool pmt_crashlog_disabled(struct intel_pmt_entry *entry)
+{
+	u32 control = readl(entry->disc_table + CONTROL_OFFSET);
+
+	/* return current value of the crashlog disabled flag */
+	return !!(control & CRASHLOG_FLAG_DISABLE);
+}
+
+static bool pmt_crashlog_supported(struct intel_pmt_entry *entry)
+{
+	u32 discovery_header = readl(entry->disc_table + CONTROL_OFFSET);
+	u32 crash_type, version;
+
+	crash_type = GET_TYPE(discovery_header);
+	version = GET_VERSION(discovery_header);
+
+	/*
+	 * Currenty we only recognize OOBMSM version 0 devices.
+	 * We can ignore all other crashlog devices in the system.
+	 */
+	return crash_type == CRASH_TYPE_OOBMSM && version == 0;
+}
+
+static void pmt_crashlog_set_disable(struct intel_pmt_entry *entry,
+				     bool disable)
+{
+	u32 control = readl(entry->disc_table + CONTROL_OFFSET);
+
+	/* clear control bits */
+	control &= ~(CRASHLOG_FLAG_MASK | CRASHLOG_FLAG_DISABLE);
+	if (disable)
+		control |= CRASHLOG_FLAG_DISABLE;
+
+	writel(control, entry->disc_table + CONTROL_OFFSET);
+}
+
+static void pmt_crashlog_set_clear(struct intel_pmt_entry *entry)
+{
+	u32 control = readl(entry->disc_table + CONTROL_OFFSET);
+
+	/* clear control bits */
+	control &= ~CRASHLOG_FLAG_MASK;
+	control |= CRASHLOG_FLAG_CLEAR;
+
+	writel(control, entry->disc_table + CONTROL_OFFSET);
+}
+
+static void pmt_crashlog_set_execute(struct intel_pmt_entry *entry)
+{
+	u32 control = readl(entry->disc_table + CONTROL_OFFSET);
+
+	/* clear control bits */
+	control &= ~CRASHLOG_FLAG_MASK;
+	control |= CRASHLOG_FLAG_EXECUTE;
+
+	writel(control, entry->disc_table + CONTROL_OFFSET);
+}
+
+/*
+ * sysfs
+ */
+static ssize_t
+enable_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct intel_pmt_entry *entry;
+	int enabled;
+
+	entry = dev_get_drvdata(dev);
+	enabled = !pmt_crashlog_disabled(entry);
+
+	return sprintf(buf, "%d\n", enabled);
+}
+
+static ssize_t
+enable_store(struct device *dev, struct device_attribute *attr,
+	    const char *buf, size_t count)
+{
+	struct crashlog_entry *entry;
+	bool enabled;
+	int result;
+
+	entry = dev_get_drvdata(dev);
+
+	result = kstrtobool(buf, &enabled);
+	if (result)
+		return result;
+
+	mutex_lock(&entry->control_mutex);
+	pmt_crashlog_set_disable(&entry->entry, !enabled);
+	mutex_unlock(&entry->control_mutex);
+
+	return strnlen(buf, count);
+}
+static DEVICE_ATTR_RW(enable);
+
+static ssize_t
+trigger_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct intel_pmt_entry *entry;
+	int trigger;
+
+	entry = dev_get_drvdata(dev);
+	trigger = pmt_crashlog_complete(entry);
+
+	return sprintf(buf, "%d\n", trigger);
+}
+
+static ssize_t
+trigger_store(struct device *dev, struct device_attribute *attr,
+	    const char *buf, size_t count)
+{
+	struct crashlog_entry *entry;
+	bool trigger;
+	int result;
+
+	entry = dev_get_drvdata(dev);
+
+	result = kstrtobool(buf, &trigger);
+	if (result)
+		return result;
+
+	mutex_lock(&entry->control_mutex);
+
+	if (!trigger) {
+		pmt_crashlog_set_clear(&entry->entry);
+	} else if (pmt_crashlog_complete(&entry->entry)) {
+		/* we cannot trigger a new crash if one is still pending */
+		result = -EEXIST;
+		goto err;
+	} else if (pmt_crashlog_disabled(&entry->entry)) {
+		/* if device is currently disabled, return busy */
+		result = -EBUSY;
+		goto err;
+	} else {
+		pmt_crashlog_set_execute(&entry->entry);
+	}
+
+	result = strnlen(buf, count);
+err:
+	mutex_unlock(&entry->control_mutex);
+	return result;
+}
+static DEVICE_ATTR_RW(trigger);
+
+static struct attribute *pmt_crashlog_attrs[] = {
+	&dev_attr_enable.attr,
+	&dev_attr_trigger.attr,
+	NULL
+};
+
+static struct attribute_group pmt_crashlog_group = {
+	.attrs	= pmt_crashlog_attrs,
+};
+
+static DEFINE_XARRAY_ALLOC(crashlog_array);
+static struct intel_pmt_namespace pmt_crashlog_ns = {
+	.name = "crashlog",
+	.xa = &crashlog_array,
+	.attr_grp = &pmt_crashlog_group
+};
+
+/*
+ * initialization
+ */
+static int pmt_crashlog_add_entry(struct intel_pmt_entry *entry,
+				  struct device *parent,
+				  struct resource *disc_res)
+{
+	void __iomem *disc_table = entry->disc_table;
+	struct intel_pmt_header header;
+	int ret;
+
+	header.access_type = GET_ACCESS(readl(disc_table));
+	header.guid = readl(disc_table + GUID_OFFSET);
+	header.base_offset = readl(disc_table + BASE_OFFSET);
+
+	/* Size is measured in DWORDS, but accessor returns bytes */
+	header.size = GET_SIZE(readl(disc_table + SIZE_OFFSET));
+
+	ret = intel_pmt_populate_entry(entry, &header, parent, disc_res);
+	if (ret)
+		return ret;
+
+	ret = intel_pmt_dev_create(entry, &pmt_crashlog_ns, parent);
+	if (!ret)
+		return 0;
+
+	dev_err(parent, "Failed to add crashlog controls\n");
+	intel_pmt_dev_destroy(entry, &pmt_crashlog_ns);
+
+	return ret;
+}
+
+static int pmt_crashlog_remove(struct platform_device *pdev)
+{
+	struct pmt_crashlog_priv *priv = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < priv->num_entries; i++)
+		intel_pmt_dev_destroy(&priv->entry[i].entry, &pmt_crashlog_ns);
+
+	return 0;
+}
+
+static int pmt_crashlog_probe(struct platform_device *pdev)
+{
+	struct pmt_crashlog_priv *priv;
+	size_t size;
+	int i, ret;
+
+	size = offsetof(struct pmt_crashlog_priv, entry[pdev->num_resources]);
+	priv = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+
+	for (i = 0; i < pdev->num_resources; i++) {
+		struct intel_pmt_entry *entry = &priv->entry[i].entry;
+		struct resource	*disc_res;
+
+		ret = -ENODEV;
+
+		/* initialize control mutex */
+		mutex_init(&priv->entry[i].control_mutex);
+
+		disc_res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!disc_res)
+			goto abort_probe;
+
+		ret = intel_pmt_ioremap_discovery_table(entry, pdev, i);
+		if (ret)
+			goto abort_probe;
+
+		if (!pmt_crashlog_supported(entry))
+			continue;
+
+		ret = pmt_crashlog_add_entry(entry, &pdev->dev, disc_res);
+		if (ret)
+			goto abort_probe;
+
+		priv->num_entries++;
+	}
+
+	return 0;
+abort_probe:
+	pmt_crashlog_remove(pdev);
+	return ret;
+}
+
+static struct platform_driver pmt_crashlog_driver = {
+	.driver = {
+		.name   = DRV_NAME,
+	},
+	.remove = pmt_crashlog_remove,
+	.probe  = pmt_crashlog_probe,
+};
+
+static int __init pmt_crashlog_init(void)
+{
+	return platform_driver_register(&pmt_crashlog_driver);
+}
+
+static void __exit pmt_crashlog_exit(void)
+{
+	platform_driver_unregister(&pmt_crashlog_driver);
+	xa_destroy(&crashlog_array);
+}
+
+module_init(pmt_crashlog_init);
+module_exit(pmt_crashlog_exit);
+
+MODULE_AUTHOR("Alexander Duyck <alexander.h.duyck@linux.intel.com>");
+MODULE_DESCRIPTION("Intel PMT Crashlog driver");
+MODULE_ALIAS("platform:" DRV_NAME);
+MODULE_LICENSE("GPL v2");
-- 
2.20.1

