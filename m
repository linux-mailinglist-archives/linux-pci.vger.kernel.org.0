Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1048A4976B0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbiAXAbj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:31:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:53077 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240624AbiAXAbi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:31:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984298; x=1674520298;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A6+onwOeHcIJdPBdClzrRZBmP2s98nCZv0qSyAMEjNo=;
  b=d31VDuHZOszwto0t4T7hAiVTMRRYOptplOALVRV1MjkKKxz/xORsMi5H
   GHstBwjxkUiDTB7l/h5CgI2xU4u0kkbSjmQtKG7kTi8EEgav+g2uKEOkD
   AC7MkaLb2M4wlM7AP8RMPL71B0sLLA+KcIDfgpM/OvLNNdfvQmmY3M1w4
   fwc/CUgPY1c1L7sdrhqwdPBoSUyAPN2vzVOFSMmeLFKB+Ugsd478mx7tV
   UG1uvjZjqVRIa4hb6wXtdZZD0mWxJ6q0OZBC03K3KDkQR+wX/D9zITpVS
   QX0BRa13NOvJ10Tq+PUnc8OP/Gi3nAv1hrbEcRB1kdmyHGVIa5PlDRMDr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="309256049"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="309256049"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="534000214"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:35 -0800
Subject: [PATCH v3 33/40] cxl/mem: Add the cxl_mem driver
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:31:34 -0800
Message-ID: <164298429450.3018233.13269591903486669825.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

At this point the subsystem can enumerate all CXL ports (CXL.mem decode
resources in upstream switch ports and host bridges) in a system. The
last mile is connecting those ports to endpoints.

The cxl_mem driver connects an endpoint device to the platform CXL.mem
protoctol decode-topology. At ->probe() time it walks its
device-topology-ancestry and adds a CXL Port object at every Upstream
Port hop until it gets to CXL root. The CXL root object is only present
after a platform firmware driver registers platform CXL resources. For
ACPI based platform this is managed by the ACPI0017 device and the
cxl_acpi driver.

The ports are registered such that disabling a given port automatically
unregisters all descendant ports, and the chain can only be registered
after the root is established.

Given ACPI device scanning may run asynchronously compared to PCI device
scanning the root driver is tasked with rescanning the bus after the
root successfully probes.

Conversely if any ports in a chain between the root and an endpoint
becomes disconnected it subsequently triggers the endpoint to
unregister. Given lock depenedencies the endpoint unregistration happens
in a workqueue asynchronously. If userspace cares about synchronizing
delayed work after port events the /sys/bus/cxl/flush attribute is
available for that purpose.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
[djbw: clarify changelog, rework hotplug support]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl         |    9 +
 Documentation/driver-api/cxl/memory-devices.rst |    9 +
 drivers/cxl/Kconfig                             |   16 ++
 drivers/cxl/Makefile                            |    2 
 drivers/cxl/acpi.c                              |    4 
 drivers/cxl/core/core.h                         |    1 
 drivers/cxl/core/memdev.c                       |   18 ++
 drivers/cxl/core/port.c                         |   91 +++++++++
 drivers/cxl/cxl.h                               |    5 +
 drivers/cxl/cxlmem.h                            |    9 +
 drivers/cxl/mem.c                               |  221 +++++++++++++++++++++++
 drivers/cxl/port.c                              |   13 +
 tools/testing/cxl/Kbuild                        |    5 +
 tools/testing/cxl/mock_mem.c                    |   10 +
 14 files changed, 406 insertions(+), 7 deletions(-)
 create mode 100644 drivers/cxl/mem.c
 create mode 100644 tools/testing/cxl/mock_mem.c

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 0b51cfec0c66..7c2b846521f3 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -1,3 +1,12 @@
+What:		/sys/bus/cxl/flush
+Date:		Januarry, 2022
+KernelVersion:	v5.18
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(WO) If userspace manually unbinds a port the kernel schedules
+		all descendant memdevs for unbind. Writing '1' to this attribute
+		flushes that work.
+
 What:		/sys/bus/cxl/devices/memX/firmware_version
 Date:		December, 2020
 KernelVersion:	v5.12
diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 3498d38d7cbd..db476bb170b6 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -325,6 +325,9 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/pci.c
    :internal:
 
+.. kernel-doc:: drivers/cxl/mem.c
+   :doc: cxl mem
+
 CXL Port
 --------
 .. kernel-doc:: drivers/cxl/port.c
@@ -344,6 +347,12 @@ CXL Core
 .. kernel-doc:: drivers/cxl/core/port.c
    :identifiers:
 
+.. kernel-doc:: drivers/cxl/core/pci.c
+   :doc: cxl core pci
+
+.. kernel-doc:: drivers/cxl/core/pci.c
+   :identifiers:
+
 .. kernel-doc:: drivers/cxl/core/pmem.c
    :doc: cxl pmem
 
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 4f4f7587f6ca..b88ab956bb7c 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -78,6 +78,22 @@ config CXL_PMEM
 
 	  If unsure say 'm'.
 
+config CXL_MEM
+	tristate "CXL: Memory Expansion"
+	depends on CXL_PCI
+	default CXL_BUS
+	help
+	  The CXL.mem protocol allows a device to act as a provider of "System
+	  RAM" and/or "Persistent Memory" that is fully coherent as if the
+	  memory were attached to the typical CPU memory controller. This is
+	  known as HDM "Host-managed Device Memory".
+
+	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
+	  memory expansion and control of HDM. See Chapter 9.13 in the CXL 2.0
+	  specification for a detailed description of HDM.
+
+	  If unsure say 'm'.
+
 config CXL_PORT
 	default CXL_BUS
 	tristate
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 56fcac2323cb..ce267ef11d93 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,10 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += core/
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
+obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 obj-$(CONFIG_CXL_PORT) += cxl_port.o
 
+cxl_mem-y := mem.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 7bd53dc691ec..df6691d0a6d0 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -314,7 +314,8 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return rc;
 
-	return 0;
+	/* In case PCI is scanned before ACPI re-trigger memdev attach */
+	return cxl_bus_rescan();
 }
 
 static const struct acpi_device_id cxl_acpi_ids[] = {
@@ -335,3 +336,4 @@ module_platform_driver(cxl_acpi_driver);
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CXL);
 MODULE_IMPORT_NS(ACPI);
+MODULE_SOFTDEP("pre: cxl_port");
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1a50c0fc399c..efbaa851929d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -6,6 +6,7 @@
 
 extern const struct device_type cxl_nvdimm_bridge_type;
 extern const struct device_type cxl_nvdimm_type;
+extern const struct device_type cxl_memdev_type;
 
 extern struct attribute_group cxl_base_attribute_group;
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b2773664e407..ee0156419d06 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -155,13 +155,19 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	NULL,
 };
 
-static const struct device_type cxl_memdev_type = {
+const struct device_type cxl_memdev_type = {
 	.name = "cxl_memdev",
 	.release = cxl_memdev_release,
 	.devnode = cxl_memdev_devnode,
 	.groups = cxl_memdev_attribute_groups,
 };
 
+bool is_cxl_memdev(struct device *dev)
+{
+	return dev->type == &cxl_memdev_type;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
+
 /**
  * set_exclusive_cxl_commands() - atomically disable user cxl commands
  * @cxlds: The device state to operate on
@@ -213,6 +219,15 @@ static void cxl_memdev_unregister(void *_cxlmd)
 	put_device(dev);
 }
 
+static void detach_memdev(struct work_struct *work)
+{
+	struct cxl_memdev *cxlmd;
+
+	cxlmd = container_of(work, typeof(*cxlmd), detach_work);
+	device_release_driver(&cxlmd->dev);
+	put_device(&cxlmd->dev);
+}
+
 static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 					   const struct file_operations *fops)
 {
@@ -237,6 +252,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
 	dev->type = &cxl_memdev_type;
 	device_set_pm_not_required(dev);
+	INIT_WORK(&cxlmd->detach_work, detach_memdev);
 
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, fops);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index cd95d9f8c624..13027fc2441d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/workqueue.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -46,6 +47,8 @@ static int cxl_device_id(struct device *dev)
 			return CXL_DEVICE_ROOT;
 		return CXL_DEVICE_PORT;
 	}
+	if (dev->type == &cxl_memdev_type)
+		return CXL_DEVICE_MEMORY_EXPANDER;
 	return 0;
 }
 
@@ -320,8 +323,10 @@ static void unregister_port(void *_port)
 {
 	struct cxl_port *port = _port;
 
-	if (!is_cxl_root(port))
+	if (!is_cxl_root(port)) {
 		device_lock_assert(port->dev.parent);
+		port->uport = NULL;
+	}
 
 	device_unregister(&port->dev);
 }
@@ -412,7 +417,9 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 	if (parent_port)
 		port->depth = parent_port->depth + 1;
 	dev = &port->dev;
-	if (parent_port)
+	if (is_cxl_memdev(uport))
+		rc = dev_set_name(dev, "endpoint%d", port->id);
+	else if (parent_port)
 		rc = dev_set_name(dev, "port%d", port->id);
 	else
 		rc = dev_set_name(dev, "root%d", port->id);
@@ -769,6 +776,38 @@ static struct device *grandparent(struct device *dev)
 	return NULL;
 }
 
+static void delete_endpoint(void *data)
+{
+	struct cxl_memdev *cxlmd = data;
+	struct cxl_port *endpoint = dev_get_drvdata(&cxlmd->dev);
+	struct cxl_port *parent_port;
+	struct device *parent;
+
+	parent_port = cxl_mem_find_port(cxlmd);
+	if (!parent_port)
+		return;
+	parent = &parent_port->dev;
+
+	cxl_device_lock(parent);
+	if (parent->driver && endpoint->uport) {
+		devm_release_action(parent, cxl_unlink_uport, endpoint);
+		devm_release_action(parent, unregister_port, endpoint);
+	}
+	cxl_device_unlock(parent);
+	put_device(parent);
+	put_device(&endpoint->dev);
+}
+
+int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
+{
+	struct device *dev = &cxlmd->dev;
+
+	get_device(&endpoint->dev);
+	dev_set_drvdata(dev, endpoint);
+	return devm_add_action_or_reset(dev, delete_endpoint, cxlmd);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, CXL);
+
 static void delete_switch_port(struct cxl_memdev *cxlmd, struct cxl_port *port,
 			       struct list_head *dports)
 {
@@ -1317,6 +1356,33 @@ struct bus_type cxl_bus_type = {
 };
 EXPORT_SYMBOL_NS_GPL(cxl_bus_type, CXL);
 
+static struct workqueue_struct *cxl_bus_wq;
+
+int cxl_bus_rescan(void)
+{
+	return bus_rescan_devices(&cxl_bus_type);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_bus_rescan, CXL);
+
+bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd)
+{
+	return queue_work(cxl_bus_wq, &cxlmd->detach_work);
+}
+EXPORT_SYMBOL_NS_GPL(schedule_cxl_memdev_detach, CXL);
+
+/* for user tooling to ensure port disable work has completed */
+static ssize_t flush_store(struct bus_type *bus, const char *buf, size_t count)
+{
+	if (sysfs_streq(buf, "1")) {
+		flush_workqueue(cxl_bus_wq);
+		return count;
+	}
+
+	return -EINVAL;
+}
+
+static BUS_ATTR_WO(flush);
+
 static __init int cxl_core_init(void)
 {
 	int rc;
@@ -1327,12 +1393,27 @@ static __init int cxl_core_init(void)
 	if (rc)
 		return rc;
 
+	cxl_bus_wq = alloc_ordered_workqueue("cxl_port", 0);
+	if (!cxl_bus_wq) {
+		rc = -ENOMEM;
+		goto err_wq;
+	}
+
 	rc = bus_register(&cxl_bus_type);
 	if (rc)
-		goto err;
+		goto err_bus;
+
+	rc = bus_create_file(&cxl_bus_type, &bus_attr_flush);
+	if (rc)
+		goto err_flush;
+
 	return 0;
 
-err:
+err_flush:
+	bus_unregister(&cxl_bus_type);
+err_bus:
+	destroy_workqueue(cxl_bus_wq);
+err_wq:
 	cxl_memdev_exit();
 	cxl_mbox_exit();
 	return rc;
@@ -1340,7 +1421,9 @@ static __init int cxl_core_init(void)
 
 static void cxl_core_exit(void)
 {
+	bus_remove_file(&cxl_bus_type, &bus_attr_flush);
 	bus_unregister(&cxl_bus_type);
+	destroy_workqueue(cxl_bus_wq);
 	cxl_memdev_exit();
 	cxl_mbox_exit();
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b71d40b68ccd..0bbe394f2f26 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -323,6 +323,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 struct cxl_port *find_cxl_root(struct device *dev);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 int cxl_bus_rescan(void);
+struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd);
+bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 				     struct device *dport, int port_id,
@@ -340,6 +342,8 @@ struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
+int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
+
 struct cxl_hdm;
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
 int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm);
@@ -372,6 +376,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_NVDIMM		2
 #define CXL_DEVICE_PORT			3
 #define CXL_DEVICE_ROOT			4
+#define CXL_DEVICE_MEMORY_EXPANDER	5
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 0ba0cf8dcdbc..7ba0edb4a1ab 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -35,11 +35,14 @@
  * @cdev: char dev core object for ioctl operations
  * @cxlds: The device state backing this device
  * @id: id number of this memdev instance.
+ * @detach_work: active memdev lost a port in its ancestry
+ * @component_reg_phys: register base of component registers
  */
 struct cxl_memdev {
 	struct device dev;
 	struct cdev cdev;
 	struct cxl_dev_state *cxlds;
+	struct work_struct detach_work;
 	int id;
 };
 
@@ -48,6 +51,12 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
 	return container_of(dev, struct cxl_memdev, dev);
 }
 
+bool is_cxl_memdev(struct device *dev);
+static inline bool is_cxl_endpoint(struct cxl_port *port)
+{
+	return is_cxl_memdev(port->uport);
+}
+
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds);
 
 /**
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
new file mode 100644
index 000000000000..056ef4a88468
--- /dev/null
+++ b/drivers/cxl/mem.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+#include "cxlmem.h"
+#include "cxlpci.h"
+
+/**
+ * DOC: cxl mem
+ *
+ * CXL memory endpoint devices and switches are CXL capable devices that are
+ * participating in CXL.mem protocol. Their functionality builds on top of the
+ * CXL.io protocol that allows enumerating and configuring components via
+ * standard PCI mechanisms.
+ *
+ * The cxl_mem driver owns kicking off the enumeration of this CXL.mem
+ * capability. With the detection of a CXL capable endpoint, the driver will
+ * walk up to find the platform specific port it is connected to, and determine
+ * if there are intervening switches in the path. If there are switches, a
+ * secondary action to enumerate those (implemented in cxl_core). Finally the
+ * cxl_mem driver will add the device it is bound to as a CXL port for use in
+ * higher level operations.
+ */
+
+static int wait_for_media(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
+	int rc;
+
+	if (!info->mem_enabled)
+		return -EBUSY;
+
+	rc = cxlds->wait_media_ready(cxlds);
+	if (rc)
+		return rc;
+
+	/*
+	 * We know the device is active, and enabled, if any ranges are non-zero
+	 * we'll need to check later before adding the port since that owns the
+	 * HDM decoder registers.
+	 */
+	return 0;
+}
+
+static int create_endpoint(struct cxl_memdev *cxlmd,
+			   struct cxl_port *parent_port)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_port *endpoint;
+
+	endpoint = devm_cxl_add_port(&parent_port->dev, &cxlmd->dev,
+				     cxlds->component_reg_phys, parent_port);
+	if (IS_ERR(endpoint))
+		return PTR_ERR(endpoint);
+
+	dev_dbg(&cxlmd->dev, "add: %s\n", dev_name(&endpoint->dev));
+
+	if (!endpoint->dev.driver) {
+		dev_err(&cxlmd->dev, "%s failed probe\n",
+			dev_name(&endpoint->dev));
+		return -ENXIO;
+	}
+
+	return cxl_endpoint_autoremove(cxlmd, endpoint);
+}
+
+/**
+ * cxl_dvsec_decode_init() - Setup HDM decoding for the endpoint
+ * @cxlds: Device state
+ *
+ * Additionally, enables global HDM decoding. Warning: don't call this outside
+ * of probe. Once probe is complete, the port driver owns all access to the HDM
+ * decoder registers.
+ *
+ * Returns: false if DVSEC Ranges are being used instead of HDM decoders;
+ *	    otherwise returns true.
+ */
+__mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
+{
+	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
+	struct cxl_register_map map;
+	struct cxl_component_reg_map *cmap = &map.component_map;
+	bool global_enable, do_hdm_init = false;
+	void __iomem *crb;
+	u32 global_ctrl;
+
+	/* map hdm decoder */
+	crb = ioremap(cxlds->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
+	if (!crb) {
+		dev_dbg(cxlds->dev, "Failed to map component registers\n");
+		return false;
+	}
+
+	cxl_probe_component_regs(cxlds->dev, crb, cmap);
+	if (!cmap->hdm_decoder.valid) {
+		dev_dbg(cxlds->dev, "Invalid HDM decoder registers\n");
+		goto out;
+	}
+
+	global_ctrl = readl(crb + cmap->hdm_decoder.offset +
+			    CXL_HDM_DECODER_CTRL_OFFSET);
+	global_enable = global_ctrl & CXL_HDM_DECODER_ENABLE;
+	if (!global_enable && info->ranges) {
+		dev_dbg(cxlds->dev, "DVSEC regions\n");
+		goto out;
+	}
+
+	/*
+	 * Turn on global enable now since DVSEC ranges aren't being used and
+	 * we'll eventually want the decoder enabled. This also prevents special
+	 * casing in the port driver since this only applies to endpoints.
+	 */
+	if (!global_enable) {
+		dev_dbg(cxlds->dev, "Enabling HDM decode\n");
+		writel(global_ctrl | CXL_HDM_DECODER_ENABLE,
+		       crb + cmap->hdm_decoder.offset +
+			       CXL_HDM_DECODER_CTRL_OFFSET);
+		do_hdm_init = true;
+	}
+
+out:
+	iounmap(crb);
+	return do_hdm_init;
+}
+
+static int cxl_mem_probe(struct device *dev)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_port *parent_port;
+	int rc;
+
+	/*
+	 * Someone is trying to reattach this device after it lost its port
+	 * connection (an endpoint port previously registered by this memdev was
+	 * disabled). This racy check is ok because if the port is still gone,
+	 * no harm done, and if the port hierarchy comes back it will re-trigger
+	 * this probe. Port rescan and memdev detach work share the same
+	 * single-threaded workqueue.
+	 */
+	if (work_pending(&cxlmd->detach_work))
+		return -EBUSY;
+
+	rc = wait_for_media(cxlmd);
+	if (rc) {
+		dev_err(dev, "Media not active (%d)\n", rc);
+		return rc;
+	}
+
+	/*
+	 * If DVSEC ranges are being used instead of HDM decoder registers there
+	 * is no use in trying to manage those.
+	 */
+	if (!cxl_dvsec_decode_init(cxlds)) {
+		struct cxl_endpoint_dvsec_info *info = &cxlds->info;
+		int i;
+
+		/* */
+		for (i = 0; i < 2; i++) {
+			u64 base, size;
+
+			/*
+			 * Give a nice warning to the user that BIOS has really
+			 * botched things for them if it didn't place DVSEC
+			 * ranges in the memory map.
+			 */
+			base = info->dvsec_range[i].start;
+			size = range_len(&info->dvsec_range[i]);
+			if (size && !region_intersects(base, size,
+						       IORESOURCE_SYSTEM_RAM,
+						       IORES_DESC_NONE)) {
+				dev_err(dev,
+					"DVSEC range %#llx-%#llx must be reserved by BIOS, but isn't\n",
+					base, base + size - 1);
+			}
+		}
+		dev_err(dev,
+			"Active DVSEC range registers in use. Will not bind.\n");
+		return -EBUSY;
+	}
+
+	rc = devm_cxl_enumerate_ports(cxlmd);
+	if (rc)
+		return rc;
+
+	parent_port = cxl_mem_find_port(cxlmd);
+	if (!parent_port) {
+		dev_err(dev, "CXL port topology not found\n");
+		return -ENXIO;
+	}
+
+	cxl_device_lock(&parent_port->dev);
+	if (!parent_port->dev.driver) {
+		dev_err(dev, "CXL port topology %s not enabled\n",
+			dev_name(&parent_port->dev));
+		rc = -ENXIO;
+		goto out;
+	}
+
+	rc = create_endpoint(cxlmd, parent_port);
+out:
+	cxl_device_unlock(&parent_port->dev);
+	put_device(&parent_port->dev);
+	return rc;
+}
+
+static struct cxl_driver cxl_mem_driver = {
+	.name = "cxl_mem",
+	.probe = cxl_mem_probe,
+	.id = CXL_DEVICE_MEMORY_EXPANDER,
+};
+
+module_cxl_driver(cxl_mem_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(CXL);
+MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
+MODULE_SOFTDEP("pre: cxl_port");
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index ae94a537eccc..27ab7f8d122e 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -25,16 +25,27 @@
  * PCIe topology.
  */
 
+static void schedule_detach(void *cxlmd)
+{
+	schedule_cxl_memdev_detach(cxlmd);
+}
+
 static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
 	struct cxl_hdm *cxlhdm;
 	int rc;
 
+	if (is_cxl_endpoint(port)) {
+		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
+
+		get_device(&cxlmd->dev);
+		return devm_add_action_or_reset(dev, schedule_detach, cxlmd);
+	}
+
 	rc = devm_cxl_port_enumerate_dports(port);
 	if (rc < 0)
 		return rc;
-
 	if (rc == 1)
 		return devm_cxl_add_passthrough_decoder(port);
 
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 3e2a529875ea..82e49ab0937d 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -31,6 +31,11 @@ obj-m += cxl_port.o
 cxl_port-y := $(CXL_SRC)/port.o
 cxl_port-y += config_check.o
 
+obj-m += cxl_mem.o
+
+cxl_mem-y := $(CXL_SRC)/mem.o
+cxl_mem-y += mock_mem.o
+cxl_mem-y += config_check.o
 
 obj-m += cxl_core.o
 
diff --git a/tools/testing/cxl/mock_mem.c b/tools/testing/cxl/mock_mem.c
new file mode 100644
index 000000000000..d1dec5845139
--- /dev/null
+++ b/tools/testing/cxl/mock_mem.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+
+#include <linux/types.h>
+
+struct cxl_dev_state;
+bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
+{
+	return true;
+}

