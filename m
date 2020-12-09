Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6345D2D37AB
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbgLIAZu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:25:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:16961 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731904AbgLIAZp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:25:45 -0500
IronPort-SDR: nKsPyJrtzlMuGTrRLXwi0Wzd6YZlB5J/IUThH3K3pkIGekTo3gk9YnXWCGI/2zx7QhP18kaBRj
 vhWytIb43fzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174142086"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174142086"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:27 -0800
IronPort-SDR: IyagmM6YphAdnhiC/3dmwsf+MDtEyk230VaBiaCRDIUI2k9U7XiAmlB6kOO2UU+ggoTJPgtYVx
 yAv65dau3WJw==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407838503"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.137.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:26 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v2 08/14] cxl/mem: Register CXL memX devices
Date:   Tue,  8 Dec 2020 16:24:12 -0800
Message-Id: <20201209002418.1976362-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209002418.1976362-1-ben.widawsky@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Create the /sys/bus/cxl hierarchy to enumerate memory devices
(per-endpoint control devices), memory address space devices (platform
address ranges with interleaving, performance, and persistence
attributes), and memory regions (active provisioned memory from an
address space device that is in use as System RAM or delegated to
libnvdimm as Persistent Memory regions).

For now, only the per-endpoint control devices are registered on the
'cxl' bus.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  26 +++
 Documentation/cxl/memory-devices.rst    |   3 +
 drivers/cxl/Makefile                    |   2 +
 drivers/cxl/bus.c                       |  54 +++++
 drivers/cxl/bus.h                       |   8 +
 drivers/cxl/cxl.h                       |   3 +
 drivers/cxl/mem.c                       | 249 +++++++++++++++++++++++-
 7 files changed, 343 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-cxl
 create mode 100644 drivers/cxl/bus.c
 create mode 100644 drivers/cxl/bus.h

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
new file mode 100644
index 000000000000..fe7b87eba988
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -0,0 +1,26 @@
+What:		/sys/bus/cxl/devices/memX/firmware_version
+Date:		December, 2020
+KernelVersion:	v5.12
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) "FW Revision" string as reported by the Identify
+		Memory Device Output Payload in the CXL-2.0
+		specification.
+
+What:		/sys/bus/cxl/devices/memX/ram/size
+Date:		December, 2020
+KernelVersion:	v5.12
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) "Volatile Only Capacity" as reported by the
+		Identify Memory Device Output Payload in the CXL-2.0
+		specification.
+
+What:		/sys/bus/cxl/devices/memX/pmem/size
+Date:		December, 2020
+KernelVersion:	v5.12
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) "Persistent Only Capacity" as reported by the
+		Identify Memory Device Output Payload in the CXL-2.0
+		specification.
diff --git a/Documentation/cxl/memory-devices.rst b/Documentation/cxl/memory-devices.rst
index 134c9b6b4ff4..5f723c25382b 100644
--- a/Documentation/cxl/memory-devices.rst
+++ b/Documentation/cxl/memory-devices.rst
@@ -37,3 +37,6 @@ External Interfaces
 
 .. kernel-doc:: drivers/cxl/acpi.c
    :export:
+
+.. kernel-doc:: drivers/cxl/bus.c
+   :export:
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 97fdffb00f2d..f9baaeb94bda 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,7 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CXL_BUS_PROVIDER) += cxl_bus.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
+cxl_bus-y := bus.o
 cxl_acpi-y := acpi.o
 cxl_mem-y := mem.o
diff --git a/drivers/cxl/bus.c b/drivers/cxl/bus.c
new file mode 100644
index 000000000000..91fe765bea94
--- /dev/null
+++ b/drivers/cxl/bus.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+#include "bus.h"
+
+static struct bus_type cxl_bus_type = {
+	.name = "cxl",
+};
+
+static void cxl_unregister(void *dev)
+{
+	device_unregister(dev);
+}
+
+/**
+ * cxl_register() - Register a device on the CXL bus.
+ * @dev: The device to register onto the CXL bus.
+ *
+ * A CXL device driver must call this in order to have the device be a part of
+ * the CXL bus. All endpoint device drivers should utilize this function.
+ *
+ * Return: 0 on success.
+ */
+int cxl_register(struct device *dev)
+{
+	int rc;
+
+	if (!dev->parent || !dev->parent->driver)
+		return -EINVAL;
+
+	dev->bus = &cxl_bus_type;
+	rc = device_add(dev);
+	if (rc)
+		put_device(dev);
+	else
+		rc = devm_add_action_or_reset(dev->parent, cxl_unregister, dev);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(cxl_register);
+
+static __init int cxl_bus_init(void)
+{
+	return bus_register(&cxl_bus_type);
+}
+
+static void cxl_bus_exit(void)
+{
+	bus_unregister(&cxl_bus_type);
+}
+
+module_init(cxl_bus_init);
+module_exit(cxl_bus_exit);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/cxl/bus.h b/drivers/cxl/bus.h
new file mode 100644
index 000000000000..5fc75ebd3650
--- /dev/null
+++ b/drivers/cxl/bus.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#ifndef __CXL_BUS_H__
+#define __CXL_BUS_H__
+
+int cxl_register(struct device *dev);
+
+#endif /* __CXL_BUS_H__ */
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6d641309013d..77c2dee6843c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -3,6 +3,7 @@
 
 #ifndef __CXL_H__
 #define __CXL_H__
+#include <linux/range.h>
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
@@ -65,6 +66,7 @@
 #define   CXLMDEV_RESET_NEEDED(status) \
 		(CXL_GET_FIELD(status, CXLMDEV_RESET_NEEDED) != CXLMDEV_RESET_NEEDED_NOT)
 
+struct cxl_memdev;
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
@@ -73,6 +75,7 @@
 struct cxl_mem {
 	struct pci_dev *pdev;
 	void __iomem *regs;
+	struct cxl_memdev *cxlmd;
 
 	spinlock_t mbox_lock; /* Protects device mailbox and firmware */
 
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 82984bf58a8d..bb6ea58f6c7b 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -2,11 +2,37 @@
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/sched/clock.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/cdev.h>
+#include <linux/idr.h>
 #include <linux/pci.h>
 #include <linux/io.h>
 #include "acpi.h"
 #include "pci.h"
 #include "cxl.h"
+#include "bus.h"
+
+/**
+ * DOC: cxl mem
+ *
+ * This implements a CXL memory device ("type-3") as it is defined by the
+ * Compute Express Link specification.
+ *
+ * The driver has several responsibilities, mainly:
+ *  - Create the memX device and register on the CXL bus.
+ *  - Enumerate device's register interface and map them.
+ *  - Probe the device attributes to establish sysfs interface.
+ *  - Provide an IOCTL interface to userspace to communicate with the device for
+ *    things like firmware update.
+ *  - Support management of interleave sets.
+ *  - Handle and manage error conditions.
+ */
+
+/*
+ * An entire PCI topology full of devices should be enough for any
+ * config
+ */
+#define CXL_MEM_MAX_DEVS 65536
 
 #define cxl_doorbell_busy(cxlm)                                                \
 	(cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL_OFFSET) &                    \
@@ -35,6 +61,18 @@ struct mbox_cmd {
 	u16 return_code;
 };
 
+struct cxl_memdev {
+	struct device dev;
+	struct cxl_mem *cxlm;
+	int id;
+};
+
+static int cxl_mem_major;
+static struct cdev cxl_mem_cdev;
+static DEFINE_IDR(cxl_mem_idr);
+/* protect cxl_mem_idr allocations */
+static DEFINE_MUTEX(cxl_memdev_lock);
+
 static int cxl_mem_wait_for_doorbell(struct cxl_mem *cxlm)
 {
 	const int timeout = msecs_to_jiffies(2000);
@@ -213,6 +251,36 @@ static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
 	spin_unlock(&cxlm->mbox_lock);
 }
 
+static int cxl_mem_open(struct inode *inode, struct file *file)
+{
+	long minor = iminor(inode);
+	struct cxl_memdev *cxlmd;
+
+	rcu_read_lock();
+	cxlmd = idr_find(&cxl_mem_idr, minor);
+	rcu_read_unlock();
+
+	if (!cxlmd)
+		return -ENXIO;
+
+	file->private_data = cxlmd;
+
+	return 0;
+}
+
+static long cxl_mem_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	return -ENOTTY;
+}
+
+static const struct file_operations cxl_mem_fops = {
+	.owner = THIS_MODULE,
+	.open = cxl_mem_open,
+	.unlocked_ioctl = cxl_mem_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.llseek = noop_llseek,
+};
+
 /**
  * cxl_mem_setup_regs() - Setup necessary MMIO.
  * @cxlm: The CXL memory device to communicate with.
@@ -359,6 +427,141 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
+static struct cxl_memdev *to_cxl_memdev(struct device *dev)
+{
+	return container_of(dev, struct cxl_memdev, dev);
+}
+
+static void cxl_memdev_release(struct device *dev)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+
+	mutex_lock(&cxl_memdev_lock);
+	idr_remove(&cxl_mem_idr, cxlmd->id);
+	mutex_unlock(&cxl_memdev_lock);
+
+	kfree(cxlmd);
+}
+
+static char *cxl_memdev_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
+				kgid_t *gid)
+{
+	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
+}
+
+static ssize_t firmware_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+
+	return sprintf(buf, "%.16s\n", cxlm->firmware_version);
+}
+static DEVICE_ATTR_RO(firmware_version);
+
+static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	unsigned long long len = range_len(&cxlm->ram.range);
+
+	return sprintf(buf, "%#llx\n", len);
+}
+
+static struct device_attribute dev_attr_ram_size =
+	__ATTR(size, 0444, ram_size_show, NULL);
+
+static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	unsigned long long len = range_len(&cxlm->pmem.range);
+
+	return sprintf(buf, "%#llx\n", len);
+}
+
+static struct device_attribute dev_attr_pmem_size =
+	__ATTR(size, 0444, pmem_size_show, NULL);
+
+static struct attribute *cxl_memdev_attributes[] = {
+	&dev_attr_firmware_version.attr,
+	NULL,
+};
+
+static struct attribute *cxl_memdev_pmem_attributes[] = {
+	&dev_attr_pmem_size.attr,
+	NULL,
+};
+
+static struct attribute *cxl_memdev_ram_attributes[] = {
+	&dev_attr_ram_size.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_memdev_attribute_group = {
+	.attrs = cxl_memdev_attributes,
+};
+
+static struct attribute_group cxl_memdev_ram_attribute_group = {
+	.name = "ram",
+	.attrs = cxl_memdev_ram_attributes,
+};
+
+static struct attribute_group cxl_memdev_pmem_attribute_group = {
+	.name = "pmem",
+	.attrs = cxl_memdev_pmem_attributes,
+};
+
+static const struct attribute_group *cxl_memdev_attribute_groups[] = {
+	&cxl_memdev_attribute_group,
+	&cxl_memdev_ram_attribute_group,
+	&cxl_memdev_pmem_attribute_group,
+	NULL,
+};
+
+static const struct device_type cxl_memdev_type = {
+	.name = "cxl_memdev",
+	.release = cxl_memdev_release,
+	.devnode = cxl_memdev_devnode,
+	.groups = cxl_memdev_attribute_groups,
+};
+
+static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
+{
+	struct pci_dev *pdev = cxlm->pdev;
+	struct cxl_memdev *cxlmd;
+	struct device *dev;
+	int rc;
+
+	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
+	if (!cxlmd)
+		return -ENOMEM;
+
+	cxlmd->cxlm = cxlm;
+
+	mutex_lock(&cxl_memdev_lock);
+	rc = idr_alloc(&cxl_mem_idr, cxlmd, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
+	mutex_unlock(&cxl_memdev_lock);
+	if (rc < 0) {
+		kfree(cxlmd);
+		return rc;
+	}
+
+	cxlmd->id = rc;
+
+	dev = &cxlmd->dev;
+
+	device_initialize(dev);
+	dev->parent = &pdev->dev;
+	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
+	dev->type = &cxl_memdev_type;
+	dev_set_name(dev, "mem%d", cxlmd->id);
+
+	return cxl_register(dev);
+}
+
 /**
  * cxl_mem_identify() - Send the IDENTIFY command to the device.
  * @cxlm: The device to identify.
@@ -461,7 +664,11 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	return cxl_mem_identify(cxlm);
+	rc = cxl_mem_identify(cxlm);
+	if (rc)
+		return rc;
+
+	return cxl_mem_add_memdev(cxlm);
 }
 
 static const struct pci_device_id cxl_mem_pci_tbl[] = {
@@ -478,6 +685,44 @@ static struct pci_driver cxl_mem_driver = {
 	.probe			= cxl_mem_probe,
 };
 
+static __init int cxl_mem_init(void)
+{
+	int rc;
+	dev_t devt;
+
+	rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
+	if (rc)
+		return rc;
+
+	cxl_mem_major = MAJOR(devt);
+
+	cdev_init(&cxl_mem_cdev, &cxl_mem_fops);
+	rc = cdev_add(&cxl_mem_cdev, MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
+	if (rc)
+		goto err_cdev;
+
+	rc = pci_register_driver(&cxl_mem_driver);
+	if (rc)
+		goto err_driver;
+
+	return 0;
+
+err_driver:
+	cdev_del(&cxl_mem_cdev);
+err_cdev:
+	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
+
+	return rc;
+}
+
+static __exit void cxl_mem_exit(void)
+{
+	pci_unregister_driver(&cxl_mem_driver);
+	cdev_del(&cxl_mem_cdev);
+	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
+}
+
 MODULE_LICENSE("GPL v2");
-module_pci_driver(cxl_mem_driver);
+module_init(cxl_mem_init);
+module_exit(cxl_mem_exit);
 MODULE_IMPORT_NS(CXL);
-- 
2.29.2

