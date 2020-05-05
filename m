Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005671C4C36
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 04:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgEECgX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 22:36:23 -0400
Received: from mga05.intel.com ([192.55.52.43]:57061 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbgEECgX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 22:36:23 -0400
IronPort-SDR: K9TW3/G2ZrbDM+9PDYtUuaa2aa7S2+xa7I61X885iuKNEEYMNbFYlhgKR1wwL6mnGQXgG3nIdb
 o1Tn4czDBEmQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 19:32:20 -0700
IronPort-SDR: cGPGTXz+VMzCymcKKcU81JqxJs1gSetG7Opnn9T3ng87kjg5efahsVXcB9VnO4PkRZhAjAXLPJ
 OUkwRbXTEwuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="249329206"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 04 May 2020 19:32:20 -0700
Received: from debox1-hc.jf.intel.com (debox1-hc.jf.intel.com [10.54.75.159])
        by linux.intel.com (Postfix) with ESMTP id 7DC1458048A;
        Mon,  4 May 2020 19:32:20 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     bhelgaas@google.com, andy@infradead.org,
        alexander.h.duyck@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH 3/3] platform/x86: Intel PMT Telemetry capability driver
Date:   Mon,  4 May 2020 19:31:49 -0700
Message-Id: <20200505023149.11630-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200505023149.11630-1-david.e.box@linux.intel.com>
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
 <20200505023149.11630-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PMT Telemetry is a capability of the Intel Platform Monitoring Technology.
The Telemetry capability provides access to device telemetry metrics that
provide hardware performance data to users from continuous, memory mapped,
read-only register spaces.

Register mappings are not provided by the driver. Instead, a GUID is read
from a header for each endpoint. The GUID identifies the device and is to
be used with an XML, provided by the vendor, to discover the available set
of metrics and their register mapping.  This allows firmware updates to
modify the register space without needing to update the driver every time
with new mappings. Firmware writes a new GUID in this case to specify the
new mapping.  Software tools with access to the associated XML file can
then interpret the changes.

This module manages access to all PMT Telemetry endpoints on a system,
regardless of the device exporting them. It creates an intel_pmt_telem
class to manage the list. For each endpoint, sysfs files provide GUID and
size information as well as a pointer to the parent device the telemetry
comes from. Software may discover the association between endpoints and
devices by iterating through the list in sysfs, or by looking for the
existence of the class folder under the device of interest.  A device node
of the same name allows software to then map the telemetry space for direct
access.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 .../ABI/testing/sysfs-class-intel_pmt_telem   |  46 +++
 MAINTAINERS                                   |   1 +
 drivers/platform/x86/Kconfig                  |  10 +
 drivers/platform/x86/Makefile                 |   1 +
 drivers/platform/x86/intel_pmt_telem.c        | 356 ++++++++++++++++++
 drivers/platform/x86/intel_pmt_telem.h        |  20 +
 6 files changed, 434 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-intel_pmt_telem
 create mode 100644 drivers/platform/x86/intel_pmt_telem.c
 create mode 100644 drivers/platform/x86/intel_pmt_telem.h

diff --git a/Documentation/ABI/testing/sysfs-class-intel_pmt_telem b/Documentation/ABI/testing/sysfs-class-intel_pmt_telem
new file mode 100644
index 000000000000..cdd9a16b31f3
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-intel_pmt_telem
@@ -0,0 +1,46 @@
+What:		/sys/class/intel_pmt_telem/
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	David Box <david.e.box@linux.intel.com>
+Description:
+		The intel_pmt_telem/ class directory contains information for
+		devices that expose hardware telemetry using Intel Platform
+		Monitoring Technology (PMT)
+
+What:		/sys/class/intel_pmt_telem/telemX
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	David Box <david.e.box@linux.intel.com>
+Description:
+		The telemX directory contains files describing an instance of a
+		PMT telemetry device that exposes hardware telemetry. Each
+		telemX device has an associated /dev/telemX node. This node can
+		be opened and mapped to access the telemetry space of the
+		device. The register layout of the telemetry space is
+		determined from an XML file of specific guid for the corresponding
+		parent device.
+
+What:		/sys/class/intel_pmt_telem/telemX/guid
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	David Box <david.e.box@linux.intel.com>
+Description:
+		(RO) The guid for this telemetry device. The guid identifies
+		the version of the XML file for the parent device that should
+		be used to determine the register layout.
+
+What:		/sys/class/intel_pmt_telem/telemX/size
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	David Box <david.e.box@linux.intel.com>
+Description:
+		(RO) The size of telemetry region in bytes that corresponds to
+		the mapping size for the /dev/telemX device node.
+
+What:		/sys/class/intel_pmt_telem/telemX/offset
+Date:		April 2020
+KernelVersion:	5.8
+Contact:	David Box <david.e.box@linux.intel.com>
+Description:
+		(RO) The offset of telemetry region in bytes that corresponds to
+		the mapping for the /dev/telemX device node.
diff --git a/MAINTAINERS b/MAINTAINERS
index bacf7ecd4d21..c49a9d3a28d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8787,6 +8787,7 @@ INTEL PMT DRIVER
 M:	"David E. Box" <david.e.box@linux.intel.com>
 S:	Maintained
 F:	drivers/mfd/intel_pmt.c
+F:	drivers/platform/x86/intel_pmt_*
 
 INTEL UNCORE FREQUENCY CONTROL
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0ad7ad8cf8e1..dd734eb66e74 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1368,6 +1368,16 @@ config INTEL_TELEMETRY
 	  directly via debugfs files. Various tools may use
 	  this interface for SoC state monitoring.
 
+config INTEL_PMT_TELEM
+	tristate "Intel PMT telemetry driver"
+	help
+	 The Intel Platform Monitory Technology (PMT) Telemetry driver provides
+	 access to hardware telemetry metrics on devices that support the
+	 feature.
+
+	 For more information, see
+	 <file:Documentation/ABI/testing/sysfs-class-intel_pmt_telem>
+
 endif # X86_PLATFORM_DEVICES
 
 config PMC_ATOM
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 53408d965874..f37e000ef8cb 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -146,3 +146,4 @@ obj-$(CONFIG_INTEL_TELEMETRY)		+= intel_telemetry_core.o \
 					   intel_telemetry_pltdrv.o \
 					   intel_telemetry_debugfs.o
 obj-$(CONFIG_PMC_ATOM)			+= pmc_atom.o
+obj-$(CONFIG_INTEL_PMT_TELEM)		+= intel_pmt_telem.o
diff --git a/drivers/platform/x86/intel_pmt_telem.c b/drivers/platform/x86/intel_pmt_telem.c
new file mode 100644
index 000000000000..ae6f867f53fa
--- /dev/null
+++ b/drivers/platform/x86/intel_pmt_telem.c
@@ -0,0 +1,356 @@
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
+#include <linux/cdev.h>
+#include <linux/intel-dvsec.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/xarray.h>
+
+#include "intel_pmt_telem.h"
+
+/* platform device name to bind to driver */
+#define TELEM_DRV_NAME		"pmt_telemetry"
+
+/* Telemetry access types */
+#define TELEM_ACCESS_FUTURE	1
+#define TELEM_ACCESS_BARID	2
+#define TELEM_ACCESS_LOCAL	3
+
+#define TELEM_GUID_OFFSET	0x4
+#define TELEM_BASE_OFFSET	0x8
+#define TELEM_TBIR_MASK		0x7
+#define TELEM_ACCESS(v)		((v) & GENMASK(3, 0))
+#define TELEM_TYPE(v)		(((v) & GENMASK(7, 4)) >> 4)
+/* size is in bytes */
+#define TELEM_SIZE(v)		(((v) & GENMASK(27, 12)) >> 10)
+
+#define TELEM_XA_START		1
+#define TELEM_XA_MAX		INT_MAX
+#define TELEM_XA_LIMIT		XA_LIMIT(TELEM_XA_START, TELEM_XA_MAX)
+
+static DEFINE_XARRAY_ALLOC(telem_array);
+
+struct pmt_telem_priv {
+	struct device			*dev;
+	struct intel_dvsec_header	*dvsec;
+	struct telem_header		header;
+	unsigned long			base_addr;
+	void __iomem			*disc_table;
+	struct cdev			cdev;
+	dev_t				devt;
+	int				devid;
+};
+
+/*
+ * devfs
+ */
+static int pmt_telem_open(struct inode *inode, struct file *filp)
+{
+	struct pmt_telem_priv *priv;
+	struct pci_driver *pci_drv;
+	struct pci_dev *pci_dev;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	priv = container_of(inode->i_cdev, struct pmt_telem_priv, cdev);
+	pci_dev = to_pci_dev(priv->dev->parent);
+
+	pci_drv = pci_dev_driver(pci_dev);
+	if (!pci_drv)
+		return -ENODEV;
+
+	filp->private_data = priv;
+	get_device(&pci_dev->dev);
+
+	if (!try_module_get(pci_drv->driver.owner)) {
+		put_device(&pci_dev->dev);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int pmt_telem_release(struct inode *inode, struct file *filp)
+{
+	struct pmt_telem_priv *priv = filp->private_data;
+	struct pci_dev *pci_dev = to_pci_dev(priv->dev->parent);
+	struct pci_driver *pci_drv = pci_dev_driver(pci_dev);
+
+	put_device(&pci_dev->dev);
+	module_put(pci_drv->driver.owner);
+
+	return 0;
+}
+
+static int pmt_telem_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct pmt_telem_priv *priv = filp->private_data;
+	unsigned long vsize = vma->vm_end - vma->vm_start;
+	unsigned long phys = priv->base_addr;
+	unsigned long pfn = PFN_DOWN(phys);
+	unsigned long psize;
+
+	psize = (PFN_UP(priv->base_addr + priv->header.size) - pfn) * PAGE_SIZE;
+	if (vsize > psize) {
+		dev_err(priv->dev, "Requested mmap size is too large\n");
+		return -EINVAL;
+	}
+
+	if ((vma->vm_flags & VM_WRITE) || (vma->vm_flags & VM_MAYWRITE))
+		return -EPERM;
+
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+
+	if (io_remap_pfn_range(vma, vma->vm_start, pfn, vsize,
+			       vma->vm_page_prot))
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct file_operations pmt_telem_fops = {
+	.owner =	THIS_MODULE,
+	.open =		pmt_telem_open,
+	.mmap =		pmt_telem_mmap,
+	.release =	pmt_telem_release,
+};
+
+/*
+ * sysfs
+ */
+static ssize_t guid_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct pmt_telem_priv *priv = dev_get_drvdata(dev);
+
+	return sprintf(buf, "0x%x\n", priv->header.guid);
+}
+static DEVICE_ATTR_RO(guid);
+
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct pmt_telem_priv *priv = dev_get_drvdata(dev);
+
+	/* Display buffer size in bytes */
+	return sprintf(buf, "%u\n", priv->header.size);
+}
+static DEVICE_ATTR_RO(size);
+
+static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct pmt_telem_priv *priv = dev_get_drvdata(dev);
+
+	/* Display buffer offset in bytes */
+	return sprintf(buf, "%lu\n", offset_in_page(priv->base_addr));
+}
+static DEVICE_ATTR_RO(offset);
+
+static struct attribute *pmt_telem_attrs[] = {
+	&dev_attr_guid.attr,
+	&dev_attr_size.attr,
+	&dev_attr_offset.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(pmt_telem);
+
+struct class pmt_telem_class = {
+	.owner	= THIS_MODULE,
+	.name	= "intel_pmt_telem",
+	.dev_groups = pmt_telem_groups,
+};
+
+/*
+ * driver initialization
+ */
+static int pmt_telem_create_dev(struct pmt_telem_priv *priv)
+{
+	struct device *dev;
+	int ret;
+
+	cdev_init(&priv->cdev, &pmt_telem_fops);
+	ret = cdev_add(&priv->cdev, priv->devt, 1);
+	if (ret) {
+		dev_err(priv->dev, "Could not add char dev\n");
+		return ret;
+	}
+
+	dev = device_create(&pmt_telem_class, priv->dev, priv->devt,
+			    priv, "telem%d", priv->devid);
+	if (IS_ERR(dev)) {
+		dev_err(priv->dev, "Could not create device node\n");
+		cdev_del(&priv->cdev);
+	}
+
+	return PTR_ERR_OR_ZERO(dev);
+}
+
+static void pmt_telem_populate_header(void __iomem *disc_offset,
+				      struct telem_header *header)
+{
+	header->access_type = TELEM_ACCESS(readb(disc_offset));
+	header->telem_type = TELEM_TYPE(readb(disc_offset));
+	header->size = TELEM_SIZE(readl(disc_offset));
+	header->guid = readl(disc_offset + TELEM_GUID_OFFSET);
+	header->base_offset = readl(disc_offset + TELEM_BASE_OFFSET);
+
+	/*
+	 * For non-local access types the lower 3 bits of base offset
+	 * contains the index of the base address register where the
+	 * telemetry can be found.
+	 */
+	header->tbir = header->base_offset & TELEM_TBIR_MASK;
+	header->base_offset ^= header->tbir;
+}
+
+static int pmt_telem_probe(struct platform_device *pdev)
+{
+	struct pmt_telem_priv *priv;
+	struct pci_dev *parent;
+	int err;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->dev = &pdev->dev;
+	parent = to_pci_dev(priv->dev->parent);
+
+	/* TODO: replace with device properties??? */
+	priv->dvsec = dev_get_platdata(&pdev->dev);
+	if (!priv->dvsec) {
+		dev_err(&pdev->dev, "Platform data not found\n");
+		return -ENODEV;
+	}
+
+	/* Remap and access the discovery table header */
+	priv->disc_table = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->disc_table))
+		return PTR_ERR(priv->disc_table);
+
+	pmt_telem_populate_header(priv->disc_table, &priv->header);
+
+	/* Local access and BARID only for now */
+	switch (priv->header.access_type) {
+	case TELEM_ACCESS_LOCAL:
+		if (priv->header.tbir) {
+			dev_err(&pdev->dev,
+				"Unsupported BAR index %d for access type %d\n",
+				priv->header.tbir, priv->header.access_type);
+			return -EINVAL;
+		}
+
+		fallthrough;
+
+	case TELEM_ACCESS_BARID:
+		break;
+	default:
+		dev_err(&pdev->dev, "Unsupported access type %d\n",
+			priv->header.access_type);
+		return -EINVAL;
+	}
+
+	priv->base_addr = pci_resource_start(parent, priv->header.tbir) +
+			  priv->header.base_offset;
+
+	err = alloc_chrdev_region(&priv->devt, 0, 1, TELEM_DRV_NAME);
+	if (err < 0) {
+		dev_err(&pdev->dev,
+			"PMT telemetry chrdev_region err: %d\n", err);
+		return err;
+	}
+
+	err = xa_alloc(&telem_array, &priv->devid, priv, TELEM_XA_LIMIT,
+		       GFP_KERNEL);
+	if (err < 0)
+		goto fail_xa_alloc;
+
+	err = pmt_telem_create_dev(priv);
+	if (err < 0)
+		goto fail_create_dev;
+
+	return 0;
+
+fail_create_dev:
+	xa_erase(&telem_array, priv->devid);
+fail_xa_alloc:
+	unregister_chrdev_region(priv->devt, 1);
+
+	return err;
+}
+
+static int pmt_telem_remove(struct platform_device *pdev)
+{
+	struct pmt_telem_priv *priv = platform_get_drvdata(pdev);
+
+	device_destroy(&pmt_telem_class, priv->devt);
+	cdev_del(&priv->cdev);
+
+	xa_erase(&telem_array, priv->devid);
+	unregister_chrdev_region(priv->devt, 1);
+
+	return 0;
+}
+
+static const struct platform_device_id pmt_telem_table[] = {
+	{
+		.name = "pmt_telemetry",
+	}, {
+		/* sentinel */
+	}
+};
+MODULE_DEVICE_TABLE(platform, pmt_telem_table);
+
+static struct platform_driver pmt_telem_driver = {
+	.driver = {
+		.name   = TELEM_DRV_NAME,
+	},
+	.probe  = pmt_telem_probe,
+	.remove = pmt_telem_remove,
+	.id_table = pmt_telem_table,
+};
+
+static int __init pmt_telem_init(void)
+{
+	int ret = class_register(&pmt_telem_class);
+
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&pmt_telem_driver);
+	if (ret)
+		class_unregister(&pmt_telem_class);
+
+	return ret;
+}
+
+static void __exit pmt_telem_exit(void)
+{
+	platform_driver_unregister(&pmt_telem_driver);
+	class_unregister(&pmt_telem_class);
+	xa_destroy(&telem_array);
+}
+
+module_init(pmt_telem_init);
+module_exit(pmt_telem_exit);
+
+MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
+MODULE_DESCRIPTION("Intel PMT Telemetry driver");
+MODULE_ALIAS("platform:" TELEM_DRV_NAME);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/platform/x86/intel_pmt_telem.h b/drivers/platform/x86/intel_pmt_telem.h
new file mode 100644
index 000000000000..3c6d1da3dc48
--- /dev/null
+++ b/drivers/platform/x86/intel_pmt_telem.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _INTEL_PMT_TELEM_H
+#define _INTEL_PMT_TELEM_H
+
+#include <linux/intel-dvsec.h>
+
+/* Telemetry types */
+#define PMT_TELEM_TELEMETRY	0
+#define PMT_TELEM_CRASHLOG	1
+
+struct telem_header {
+	u8	access_type;
+	u8	telem_type;
+	u16	size;
+	u32	guid;
+	u32	base_offset;
+	u8	tbir;
+};
+
+#endif
-- 
2.20.1

