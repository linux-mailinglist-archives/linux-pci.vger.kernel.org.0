Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49DCC2F23B9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 01:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404104AbhALAZ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 19:25:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:11219 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390807AbhAKWwo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jan 2021 17:52:44 -0500
IronPort-SDR: odXNIWqpMg/f93HnaGveDgjvaOHEeW9S1DHRclXVPefeFY15S+SONS3olHYupvbSNLK/+cwh09
 VtxSp24ky0hg==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157726539"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157726539"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:36 -0800
IronPort-SDR: /XnJbypgTtA/OHwTvcIzfDy9OI6Sz8SJBgfra2OjG39V8QmYP7mCrfC8tL1T6HTbcDCTyXc7/n
 srXuqTI3BKmw==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352778000"
Received: from yyang31-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.142.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:35 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Subject: [RFC PATCH v3 08/16] cxl/mem: Register CXL memX devices
Date:   Mon, 11 Jan 2021 14:51:12 -0800
Message-Id: <20210111225121.820014-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111225121.820014-1-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
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
 drivers/base/core.c                     |  14 ++
 drivers/cxl/Makefile                    |   2 +
 drivers/cxl/bus.c                       |  54 +++++
 drivers/cxl/bus.h                       |   8 +
 drivers/cxl/cxl.h                       |   3 +
 drivers/cxl/mem.c                       | 282 +++++++++++++++++++++++-
 include/linux/device.h                  |   1 +
 9 files changed, 392 insertions(+), 1 deletion(-)
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
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 25e08e5f40bd..33432a4cbe23 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3179,6 +3179,20 @@ struct device *get_device(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(get_device);
 
+/**
+ * get_live_device() - increment reference count for device iff !dead
+ * @dev: device.
+ *
+ * Forward the call to get_device() if the device is still alive. If
+ * this is called with the device_lock() held then the device is
+ * guaranteed to not die until the device_lock() is dropped.
+ */
+struct device *get_live_device(struct device *dev)
+{
+	return dev && !dev->p->dead ? get_device(dev) : NULL;
+}
+EXPORT_SYMBOL_GPL(get_live_device);
+
 /**
  * put_device - decrement reference count.
  * @dev: device in question.
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
index ca3fa496e21c..537ac4d8e6bd 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -3,6 +3,7 @@
 
 #ifndef __CXL_H__
 #define __CXL_H__
+#include <linux/range.h>
 
 #include <linux/bitfield.h>
 #include <linux/bitops.h>
@@ -67,6 +68,7 @@
 #define   CXLMDEV_RESET_NEEDED(status) \
 		(CXL_GET_FIELD(status, CXLMDEV_RESET_NEEDED) != CXLMDEV_RESET_NEEDED_NOT)
 
+struct cxl_memdev;
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
@@ -75,6 +77,7 @@
 struct cxl_mem {
 	struct pci_dev *pdev;
 	void __iomem *regs;
+	struct cxl_memdev *cxlmd;
 
 	struct {
 		struct range range;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index e9ba97bbd7b9..da2bf941fe92 100644
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
@@ -44,6 +70,18 @@ struct mbox_cmd {
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
 	const int timeout = msecs_to_jiffies(CXL_MAILBOX_TIMEOUT_US);
@@ -250,6 +288,55 @@ static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
 	mutex_unlock(&cxlm->mbox.mutex);
 }
 
+static int cxl_mem_open(struct inode *inode, struct file *file)
+{
+	long minor = iminor(inode);
+	struct cxl_memdev *cxlmd;
+	struct device *dev;
+	int rc = -ENXIO;
+
+	mutex_lock(&cxl_memdev_lock);
+	cxlmd = idr_find(&cxl_mem_idr, minor);
+	if (!cxlmd)
+		goto out;
+
+	dev = get_live_device(&cxlmd->dev);
+	if (!dev)
+		goto out;
+
+	rc = 0;
+	dev_dbg(dev, "Opened %pD\n", file);
+
+	file->private_data = cxlmd;
+
+out:
+	mutex_unlock(&cxl_memdev_lock);
+	return rc;
+}
+
+static int cxl_mem_release(struct inode *inode, struct file *file)
+{
+	struct cxl_memdev *cxlmd = file->private_data;
+
+	put_device(&cxlmd->dev);
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
+	.release = cxl_mem_release,
+	.unlocked_ioctl = cxl_mem_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
+	.llseek = noop_llseek,
+};
+
 /**
  * cxl_mem_setup_regs() - Setup necessary MMIO.
  * @cxlm: The CXL memory device to communicate with.
@@ -412,6 +499,157 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
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
+static ssize_t payload_max_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+
+	return sprintf(buf, "%zu\n", cxlm->mbox.payload_size);
+}
+static DEVICE_ATTR_RO(payload_max);
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
+	&dev_attr_payload_max.attr,
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
+	/* sync with racing open */
+	mutex_lock(&cxl_memdev_lock);
+	device_initialize(dev);
+	dev->parent = &pdev->dev;
+	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
+	dev->type = &cxl_memdev_type;
+	dev_set_name(dev, "mem%d", cxlmd->id);
+
+	rc = cxl_register(dev);
+	mutex_unlock(&cxl_memdev_lock);
+
+	return rc;
+}
+
 /**
  * cxl_mem_identify() - Send the IDENTIFY command to the device.
  * @cxlm: The device to identify.
@@ -534,6 +772,10 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		goto err;
 
+	rc = cxl_mem_add_memdev(cxlm);
+	if (rc)
+		goto err;
+
 	pci_set_drvdata(pdev, cxlm);
 	return 0;
 
@@ -571,6 +813,44 @@ static struct pci_driver cxl_mem_driver = {
 	.remove			= cxl_mem_remove,
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
diff --git a/include/linux/device.h b/include/linux/device.h
index 89bb8b84173e..8659deee8ae6 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -895,6 +895,7 @@ extern int (*platform_notify_remove)(struct device *dev);
  *
  */
 struct device *get_device(struct device *dev);
+struct device *get_live_device(struct device *dev);
 void put_device(struct device *dev);
 bool kill_device(struct device *dev);
 
-- 
2.30.0

