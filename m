Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6248427B913
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 02:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgI2Axc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 20:53:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:54736 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbgI2Axb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 20:53:31 -0400
IronPort-SDR: 6wAoDTmPwf68NxLG56BTilZLSQWMHj46ypVkjPQZX0I/AHaozaDYyvgoB2NeeKzb+F1X9kyERZ
 HJPeycUlZYXw==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="162149351"
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; 
   d="scan'208";a="162149351"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 17:53:29 -0700
IronPort-SDR: tc1RJEznO6wFJUHEbuO30tiDR3G/FZV+mcHsbM06rWGYFbMHKTWd8OOOTxX+j70dVQe8eloJmW
 hR+HRN4O3Yog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; 
   d="scan'208";a="513651143"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2020 17:53:29 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 21B2B580266;
        Mon, 28 Sep 2020 17:53:29 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, david.e.box@linux.intel.com,
        dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com, hdegoede@redhat.com,
        alexey.budankov@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V6 3/5] platform/x86: Intel PMT class driver
Date:   Mon, 28 Sep 2020 17:53:18 -0700
Message-Id: <20200929005320.14739-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200929005320.14739-1-david.e.box@linux.intel.com>
References: <20200929005320.14739-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Intel Platform Monitoring Technology is meant to provide a common way to
access telemetry and system metrics.

Register mappings are not provided by the driver. Instead, a GUID is read
from a header for each endpoint. The GUID identifies the device and is to
be used with an XML, provided by the vendor, to discover the available set
of metrics and their register mapping.  This allows firmware updates to
modify the register space without needing to update the driver every time
with new mappings. Firmware writes a new GUID in this case to specify the
new mapping.  Software tools with access to the associated XML file can
then interpret the changes.

The module manages access to all Intel PMT endpoints on a system,
independent of the device exporting them. It creates an intel_pmt class
to manage the devices. For each telemetry endpoint, sysfs files provide
GUID and size information as well as a pointer to the parent device the
telemetry came from. Software may discover the association between
endpoints and devices by iterating through the list in sysfs, or by looking
for the existence of the class folder under the device of interest.  A
binary sysfs attribute of the same name allows software to then read or map
the telemetry space for direct access.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 .../ABI/testing/sysfs-class-intel_pmt         |  54 ++++
 MAINTAINERS                                   |   1 +
 drivers/platform/x86/Kconfig                  |   9 +
 drivers/platform/x86/Makefile                 |   1 +
 drivers/platform/x86/intel_pmt_class.c        | 295 ++++++++++++++++++
 drivers/platform/x86/intel_pmt_class.h        |  58 ++++
 6 files changed, 418 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-intel_pmt
 create mode 100644 drivers/platform/x86/intel_pmt_class.c
 create mode 100644 drivers/platform/x86/intel_pmt_class.h

diff --git a/Documentation/ABI/testing/sysfs-class-intel_pmt b/Documentation/ABI/testing/sysfs-class-intel_pmt
new file mode 100644
index 000000000000..926b5cf95fd1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-intel_pmt
@@ -0,0 +1,54 @@
+What:		/sys/class/intel_pmt/
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	David Box <david.e.box@linux.intel.com>
+Description:
+		The intel_pmt/ class directory contains information for
+		devices that expose hardware telemetry using Intel Platform
+		Monitoring Technology (PMT)
+
+What:		/sys/class/intel_pmt/telem<x>
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	David Box <david.e.box@linux.intel.com>
+Description:
+		The telem<x> directory contains files describing an instance of
+		a PMT telemetry device that exposes hardware telemetry. Each
+		telem<x> directory has an associated telem file. This file
+		may be opened and mapped or read to access the telemetry space
+		of the device. The register layout of the telemetry space is
+		determined from an XML file that matches the PCI device id and
+		GUID for the device.
+
+What:		/sys/class/intel_pmt/telem<x>/telem
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	David Box <david.e.box@linux.intel.com>
+Description:
+		(RO) The telemetry data for this telemetry device. This file
+		may be mapped or read to obtain the data.
+
+What:		/sys/class/intel_pmt/telem<x>/guid
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	David Box <david.e.box@linux.intel.com>
+Description:
+		(RO) The GUID for this telemetry device. The GUID identifies
+		the version of the XML file for the parent device that is to
+		be used to get the register layout.
+
+What:		/sys/class/intel_pmt/telem<x>/size
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	David Box <david.e.box@linux.intel.com>
+Description:
+		(RO) The size of telemetry region in bytes that corresponds to
+		the mapping size for the telem file.
+
+What:		/sys/class/intel_pmt/telem<x>/offset
+Date:		October 2020
+KernelVersion:	5.10
+Contact:	David Box <david.e.box@linux.intel.com>
+Description:
+		(RO) The offset of telemetry region in bytes that corresponds to
+		the mapping for the telem file.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0f2663b1d376..47fdb8a6e151 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8950,6 +8950,7 @@ INTEL PMT DRIVER
 M:	"David E. Box" <david.e.box@linux.intel.com>
 S:	Maintained
 F:	drivers/mfd/intel_pmt.c
+F:	drivers/platform/x86/intel_pmt_*
 
 INTEL PRO/WIRELESS 2100, 2200BG, 2915ABG NETWORK CONNECTION SUPPORT
 M:	Stanislav Yakovlev <stas.yakovlev@gmail.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 40219bba6801..093c43b63f48 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1360,6 +1360,15 @@ config INTEL_PMC_CORE
 		- LTR Ignore
 		- MPHY/PLL gating status (Sunrisepoint PCH only)
 
+config INTEL_PMT_CLASS
+	tristate "Intel Platform Monitoring Technology (PMT) Class driver"
+	help
+	  The Intel Platform Monitoring Technology (PMT) class driver provides
+	  the basic sysfs interface and file heirarchy uses by PMT devices.
+
+	  For more information, see
+	  <file:Documentation/ABI/testing/sysfs-class-intel_pmt>
+
 config INTEL_PUNIT_IPC
 	tristate "Intel P-Unit IPC Driver"
 	help
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 5f823f7eff45..f4b1f87f2401 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -140,6 +140,7 @@ obj-$(CONFIG_INTEL_MFLD_THERMAL)	+= intel_mid_thermal.o
 obj-$(CONFIG_INTEL_MID_POWER_BUTTON)	+= intel_mid_powerbtn.o
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
+obj-$(CONFIG_INTEL_PMT_CLASS)		+= intel_pmt_class.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_PCI)		+= intel_scu_pcidrv.o
diff --git a/drivers/platform/x86/intel_pmt_class.c b/drivers/platform/x86/intel_pmt_class.c
new file mode 100644
index 000000000000..b28660962ae7
--- /dev/null
+++ b/drivers/platform/x86/intel_pmt_class.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Platform Monitory Technology Telemetry driver
+ *
+ * Copyright (c) 2020, Intel Corporation.
+ * All Rights Reserved.
+ *
+ * Author: "Alexander Duyck" <alexander.h.duyck@linux.intel.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/pci.h>
+
+#include "intel_pmt_class.h"
+
+#define PMT_XA_START		0
+#define PMT_XA_MAX		INT_MAX
+#define PMT_XA_LIMIT		XA_LIMIT(PMT_XA_START, PMT_XA_MAX)
+
+static const struct pci_device_id pmt_telem_early_client_pci_ids[] = {
+	{ PCI_VDEVICE(INTEL, 0x9a0d) }, /* TGL */
+	{ }
+};
+
+bool intel_pmt_is_early_client_hw(struct device *dev)
+{
+	struct pci_dev *parent = to_pci_dev(dev->parent);
+
+	return !!pci_match_id(pmt_telem_early_client_pci_ids, parent);
+}
+EXPORT_SYMBOL_GPL(intel_pmt_is_early_client_hw);
+
+/*
+ * sysfs
+ */
+static ssize_t
+intel_pmt_read(struct file *filp, struct kobject *kobj,
+	       struct bin_attribute *attr, char *buf, loff_t off,
+	       size_t count)
+{
+	struct intel_pmt_entry *entry = container_of(attr,
+						     struct intel_pmt_entry,
+						     pmt_bin_attr);
+
+	if (off < 0)
+		return -EINVAL;
+
+	if (off >= entry->size)
+		return 0;
+
+	if (count > entry->size - off)
+		count = entry->size - off;
+
+	if (count)
+		memcpy_fromio(buf, entry->base + off, count);
+
+	return count;
+}
+
+static int
+intel_pmt_mmap(struct file *filp, struct kobject *kobj,
+		struct bin_attribute *attr, struct vm_area_struct *vma)
+{
+	struct intel_pmt_entry *entry = container_of(attr,
+						     struct intel_pmt_entry,
+						     pmt_bin_attr);
+	unsigned long vsize = vma->vm_end - vma->vm_start;
+	struct device *dev = kobj_to_dev(kobj);
+	unsigned long phys = entry->base_addr;
+	unsigned long pfn = PFN_DOWN(phys);
+	unsigned long psize;
+
+	if (vma->vm_flags & (VM_WRITE | VM_MAYWRITE))
+		return -EROFS;
+
+	psize = (PFN_UP(entry->base_addr + entry->size) - pfn) * PAGE_SIZE;
+	if (vsize > psize) {
+		dev_err(dev, "Requested mmap size is too large\n");
+		return -EINVAL;
+	}
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	if (io_remap_pfn_range(vma, vma->vm_start, pfn,
+		vsize, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static ssize_t
+guid_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct intel_pmt_entry *entry = dev_get_drvdata(dev);
+
+	return sprintf(buf, "0x%x\n", entry->guid);
+}
+static DEVICE_ATTR_RO(guid);
+
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct intel_pmt_entry *entry = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%zu\n", entry->size);
+}
+static DEVICE_ATTR_RO(size);
+
+static ssize_t
+offset_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct intel_pmt_entry *entry = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%lu\n", offset_in_page(entry->base_addr));
+}
+static DEVICE_ATTR_RO(offset);
+
+static struct attribute *intel_pmt_attrs[] = {
+	&dev_attr_guid.attr,
+	&dev_attr_size.attr,
+	&dev_attr_offset.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(intel_pmt);
+
+static struct class intel_pmt_class = {
+	.name = "intel_pmt",
+	.owner = THIS_MODULE,
+	.dev_groups = intel_pmt_groups,
+};
+
+int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
+			     struct intel_pmt_header *header,
+			     struct device *dev, struct resource *disc_res)
+{
+	struct pci_dev *pci_dev = to_pci_dev(dev->parent);
+	u8 bir;
+
+	/*
+	 * The base offset should always be 8 byte aligned.
+	 *
+	 * For non-local access types the lower 3 bits of base offset
+	 * contains the index of the base address register where the
+	 * telemetry can be found.
+	 */
+	bir = GET_BIR(header->base_offset);
+
+	/* Local access and BARID only for now */
+	switch (header->access_type) {
+	case ACCESS_LOCAL:
+		if (bir) {
+			dev_err(dev,
+				"Unsupported BAR index %d for access type %d\n",
+				bir, header->access_type);
+			return -EINVAL;
+		}
+		/*
+		 * For access_type LOCAL, the base address is as follows:
+		 * base address = end of discovery region + base offset
+		 */
+		entry->base_addr = disc_res->end + 1 + header->base_offset;
+		break;
+	case ACCESS_BARID:
+		/*
+		 * If another BAR was specified then the base offset
+		 * represents the offset within that BAR. SO retrieve the
+		 * address from the parent PCI device and add offset.
+		 */
+		entry->base_addr = pci_resource_start(pci_dev, bir) +
+				   GET_ADDRESS(header->base_offset);
+		break;
+	default:
+		dev_err(dev, "Unsupported access type %d\n",
+			header->access_type);
+		return -EINVAL;
+	}
+
+	entry->guid = header->guid;
+	entry->size = header->size;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(intel_pmt_populate_entry);
+
+int intel_pmt_dev_create(struct intel_pmt_entry *entry,
+			 struct intel_pmt_namespace *ns, struct device *parent)
+{
+	struct resource res;
+	struct device *dev;
+	dev_t devt;
+	int ret;
+
+	ret = xa_alloc(ns->xa, &entry->devid, entry, PMT_XA_LIMIT, GFP_KERNEL);
+	if (ret)
+		return ret;
+
+	ret = alloc_chrdev_region(&devt, 0, 1, "intel_pmt");
+	if (ret) {
+		dev_err(parent, "alloc_chrdev_region err: %d\n", ret);
+		goto fail_chrdev_region;
+	}
+
+	dev = device_create(&intel_pmt_class, parent, devt, entry, "%s%d",
+			    ns->name, entry->devid);
+
+	if (IS_ERR(dev)) {
+		dev_err(parent, "Could not create %s%d device node\n",
+			ns->name, entry->devid);
+		ret = PTR_ERR(dev);
+		goto fail_dev_create;
+	}
+
+	entry->devt = devt;
+	entry->kobj = &dev->kobj;
+
+	if (ns->attr_grp) {
+		ret = sysfs_create_group(entry->kobj, ns->attr_grp);
+		if (ret)
+			goto fail_sysfs;
+	}
+
+	/* if size is 0 assume no data buffer, so no file needed */
+	if (!entry->size)
+		return 0;
+
+	res.start = entry->base_addr;
+	res.end = res.start + entry->size - 1;
+	res.flags = IORESOURCE_MEM;
+
+	entry->base = devm_ioremap_resource(dev, &res);
+	if (IS_ERR(entry->base)) {
+		dev_err(dev, "Failed to ioremap device region\n");
+		ret = -EIO;
+		goto fail_ioremap;
+	}
+
+	sysfs_bin_attr_init(&entry->pmt_bin_attr);
+	entry->pmt_bin_attr.attr.name = ns->name;
+	entry->pmt_bin_attr.attr.mode = 0440;
+	entry->pmt_bin_attr.mmap = intel_pmt_mmap;
+	entry->pmt_bin_attr.read = intel_pmt_read;
+	entry->pmt_bin_attr.size = entry->size;
+
+	ret = sysfs_create_bin_file(&dev->kobj, &entry->pmt_bin_attr);
+	if (!ret)
+		return 0;
+
+	iounmap(entry->base);
+fail_ioremap:
+	sysfs_remove_group(entry->kobj, ns->attr_grp);
+fail_sysfs:
+	device_destroy(&intel_pmt_class, devt);
+fail_dev_create:
+	unregister_chrdev_region(devt, 1);
+fail_chrdev_region:
+	xa_erase(ns->xa, entry->devid);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(intel_pmt_dev_create);
+
+void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
+			   struct intel_pmt_namespace *ns)
+{
+	if (entry->size)
+		sysfs_remove_bin_file(entry->kobj, &entry->pmt_bin_attr);
+
+	if (ns->attr_grp)
+		sysfs_remove_group(entry->kobj, ns->attr_grp);
+
+	device_destroy(&intel_pmt_class, entry->devt);
+	unregister_chrdev_region(entry->devt, 1);
+	xa_erase(ns->xa, entry->devid);
+}
+EXPORT_SYMBOL_GPL(intel_pmt_dev_destroy);
+
+static int __init pmt_class_init(void)
+{
+	return class_register(&intel_pmt_class);
+}
+
+static void __exit pmt_class_exit(void)
+{
+	class_unregister(&intel_pmt_class);
+}
+
+module_init(pmt_class_init);
+module_exit(pmt_class_exit);
+
+MODULE_AUTHOR("Alexander Duyck <alexander.h.duyck@linux.intel.com>");
+MODULE_DESCRIPTION("Intel PMT Class driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/intel_pmt_class.h b/drivers/platform/x86/intel_pmt_class.h
new file mode 100644
index 000000000000..efef4352064c
--- /dev/null
+++ b/drivers/platform/x86/intel_pmt_class.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _INTEL_PMT_CLASS_H
+#define _INTEL_PMT_CLASS_H
+
+#include <linux/platform_device.h>
+#include <linux/xarray.h>
+
+/* PMT access types */
+#define ACCESS_BARID		2
+#define ACCESS_LOCAL		3
+
+/* PMT discovery base address/offset register layout */
+#define GET_BIR(v)		((v) & GENMASK(2, 0))
+#define GET_ADDRESS(v)		((v) & GENMASK(31, 3))
+
+struct intel_pmt_entry {
+	struct bin_attribute	pmt_bin_attr;
+	struct kobject		*kobj;
+	void __iomem		*disc_table;
+	void __iomem		*base;
+	unsigned long		base_addr;
+	size_t			size;
+	u32			guid;
+	dev_t			devt;
+	int			devid;
+};
+
+struct intel_pmt_header {
+	u32	base_offset;
+	u32	size;
+	u32	guid;
+	u8	access_type;
+};
+
+struct intel_pmt_namespace {
+	const char *name;
+	struct xarray *xa;
+	const struct attribute_group *attr_grp;
+};
+
+bool intel_pmt_is_early_client_hw(struct device *dev);
+int intel_pmt_populate_entry(struct intel_pmt_entry *entry,
+			     struct intel_pmt_header *header,
+			     struct device *dev, struct resource *disc_res);
+int intel_pmt_dev_create(struct intel_pmt_entry *entry,
+			 struct intel_pmt_namespace *ns, struct device *parent);
+void intel_pmt_dev_destroy(struct intel_pmt_entry *entry,
+			   struct intel_pmt_namespace *ns);
+
+static inline int
+intel_pmt_ioremap_discovery_table(struct intel_pmt_entry *entry,
+				  struct platform_device *pdev,  int i)
+{
+	entry->disc_table = devm_platform_ioremap_resource(pdev, i);
+
+	return PTR_ERR_OR_ZERO(entry->disc_table);
+}
+#endif
-- 
2.20.1

