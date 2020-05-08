Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744B41CA0AA
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 04:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgEHCTF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 22:19:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:35078 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbgEHCTF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 May 2020 22:19:05 -0400
IronPort-SDR: AYVpa/xHAi+IwIz1lRnU+J2OSrrRG38SXVFX3GhNeo2StIphe9sCkwGhCdB755Pzs/lC6vMs9r
 KOKHjq5X8baQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2020 19:18:49 -0700
IronPort-SDR: kKw2Qw88uaXe5UV/32MMooEeefYwyesVqDp3xcuVJ7iO/MlR5uZD1kefoj6kZEG8UVertUB30V
 657Kt1YIPXOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,366,1583222400"; 
   d="scan'208";a="285225891"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 07 May 2020 19:18:49 -0700
Received: from debox1-hc.jf.intel.com (debox1-hc.jf.intel.com [10.54.75.159])
        by linux.intel.com (Postfix) with ESMTP id 32A84580709;
        Thu,  7 May 2020 19:18:49 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     bhelgaas@google.com, andy@infradead.org, lee.jones@linaro.org,
        alexander.h.duyck@linux.intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 3/3] platform/x86: Intel PMT Telemetry capability driver
Date:   Thu,  7 May 2020 19:18:44 -0700
Message-Id: <20200508021844.6911-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200505013206.11223-1-david.e.box@linux.intel.com>
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
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
regardless of the device exporting them. It creates a pmt_telemetry class
to manage the list. For each endpoint, sysfs files provide GUID and size
information as well as a pointer to the parent device the telemetry comes
from. Software may discover the association between endpoints and devices
by iterating through the list in sysfs, or by looking for the existence of
the class folder under the device of interest.  A device node of the same
name allows software to then map the telemetry space for direct access.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 MAINTAINERS                            |   1 +
 drivers/platform/x86/Kconfig           |  10 +
 drivers/platform/x86/Makefile          |   1 +
 drivers/platform/x86/intel_pmt_telem.c | 362 +++++++++++++++++++++++++
 4 files changed, 374 insertions(+)
 create mode 100644 drivers/platform/x86/intel_pmt_telem.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 367e49d27960..a2a12c1196c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8737,6 +8737,7 @@ INTEL PMT DRIVER
 M:	"David E. Box" <david.e.box@linux.intel.com>
 S:	Maintained
 F:	drivers/mfd/intel_pmt.c
+F:	drivers/platform/x86/intel_pmt_*
 
 INTEL PRO/WIRELESS 2100, 2200BG, 2915ABG NETWORK CONNECTION SUPPORT
 M:	Stanislav Yakovlev <stas.yakovlev@gmail.com>
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0ad7ad8cf8e1..41f66da0e3f9 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1368,6 +1368,16 @@ config INTEL_TELEMETRY
 	  directly via debugfs files. Various tools may use
 	  this interface for SoC state monitoring.
 
+config INTEL_PMT_TELEM
+	tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
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
index 53408d965874..e5cd49e54745 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -139,6 +139,7 @@ obj-$(CONFIG_INTEL_MID_POWER_BUTTON)	+= intel_mid_powerbtn.o
 obj-$(CONFIG_INTEL_MRFLD_PWRBTN)	+= intel_mrfld_pwrbtn.o
 obj-$(CONFIG_INTEL_PMC_CORE)		+= intel_pmc_core.o intel_pmc_core_pltdrv.o
 obj-$(CONFIG_INTEL_PMC_IPC)		+= intel_pmc_ipc.o
+obj-$(CONFIG_INTEL_PMT_TELEM)		+= intel_pmt_telem.o
 obj-$(CONFIG_INTEL_PUNIT_IPC)		+= intel_punit_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC)		+= intel_scu_ipc.o
 obj-$(CONFIG_INTEL_SCU_IPC_UTIL)	+= intel_scu_ipcutil.o
diff --git a/drivers/platform/x86/intel_pmt_telem.c b/drivers/platform/x86/intel_pmt_telem.c
new file mode 100644
index 000000000000..d5aac239bb35
--- /dev/null
+++ b/drivers/platform/x86/intel_pmt_telem.c
@@ -0,0 +1,362 @@
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
+#include <linux/bits.h>
+#include <linux/cdev.h>
+#include <linux/intel-dvsec.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/xarray.h>
+
+/* Telemetry access types */
+#define TELEM_ACCESS_FUTURE	1
+#define TELEM_ACCESS_BARID	2
+#define TELEM_ACCESS_LOCAL	3
+
+#define TELEM_GUID_OFFSET	0x4
+#define TELEM_BASE_OFFSET	0x8
+#define TELEM_TBIR_MASK		GENMASK(2, 0)
+#define TELEM_ACCESS(v)		((v) & GENMASK(3, 0))
+#define TELEM_TYPE(v)		(((v) & GENMASK(7, 4)) >> 4)
+/* size is in bytes */
+#define TELEM_SIZE(v)		(((v) & GENMASK(27, 12)) >> 10)
+
+#define TELEM_XA_START		0
+#define TELEM_XA_MAX		INT_MAX
+#define TELEM_XA_LIMIT		XA_LIMIT(TELEM_XA_START, TELEM_XA_MAX)
+
+static DEFINE_XARRAY_ALLOC(telem_array);
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
+	.name	= "pmt_telemetry",
+	.dev_groups = pmt_telem_groups,
+};
+
+/*
+ * driver initialization
+ */
+static int pmt_telem_create_dev(struct pmt_telem_priv *priv)
+{
+	struct pci_dev *pci_dev;
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
+	pci_dev = to_pci_dev(priv->dev->parent);
+	dev = device_create(&pmt_telem_class, &pci_dev->dev, priv->devt,
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
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, priv);
+	priv->dev = &pdev->dev;
+	parent = to_pci_dev(priv->dev->parent);
+
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
+		break;
+
+	case TELEM_ACCESS_BARID:
+		break;
+
+	default:
+		dev_err(&pdev->dev, "Unsupported access type %d\n",
+			priv->header.access_type);
+		return -EINVAL;
+	}
+
+	priv->base_addr = pci_resource_start(parent, priv->header.tbir) +
+			  priv->header.base_offset;
+
+	ret = alloc_chrdev_region(&priv->devt, 0, 1, TELEM_DEV_NAME);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"PMT telemetry chrdev_region error: %d\n", ret);
+		return ret;
+	}
+
+	ret = xa_alloc(&telem_array, &priv->devid, priv, TELEM_XA_LIMIT,
+		       GFP_KERNEL);
+	if (ret)
+		goto fail_xa_alloc;
+
+	ret = pmt_telem_create_dev(priv);
+	if (ret)
+		goto fail_create_dev;
+
+	return 0;
+
+fail_create_dev:
+	xa_erase(&telem_array, priv->devid);
+fail_xa_alloc:
+	unregister_chrdev_region(priv->devt, 1);
+
+	return ret;
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
+		.name = TELEM_DEV_NAME,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(platform, pmt_telem_table);
+
+static struct platform_driver pmt_telem_driver = {
+	.driver = {
+		.name   = TELEM_DEV_NAME,
+	},
+	.probe  = pmt_telem_probe,
+	.remove = pmt_telem_remove,
+	.id_table = pmt_telem_table,
+};
+
+static int __init pmt_telem_init(void)
+{
+	int ret;
+
+	ret = class_register(&pmt_telem_class);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&pmt_telem_driver);
+	if (ret)
+		class_unregister(&pmt_telem_class);
+
+	return ret;
+}
+module_init(pmt_telem_init);
+
+static void __exit pmt_telem_exit(void)
+{
+	platform_driver_unregister(&pmt_telem_driver);
+	class_unregister(&pmt_telem_class);
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

