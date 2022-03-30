Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F0E4ED07F
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 01:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351928AbiCaABS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 20:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351925AbiCaABR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 20:01:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A606549B;
        Wed, 30 Mar 2022 16:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648684769; x=1680220769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cPSq0iDtQwmtyLgAN6W/DW+z6XSvSZ8kfTDt/ASPLkM=;
  b=eoTWfV5EsHG0MeoHgRs54uT0R848yH6tkHk8Zxdebx1XDLcZ3XhxumTl
   HaeLkUcQsPguJTPTHXX/xhIuAdM7rHG3nwrrA2gAO5vROhvcVPTCPBhHw
   FlOIwpeoO65agGsE99w6CRFlLt0AzHQJWm8ZOFMv3H5UCixIbfG7sTALB
   kAUkjcNqJ0RqB90yLRDGTPqnVauqO6vbBWLqFh8zU8q0yym9G/wF1pHym
   IqBh4+YEAPByI+z6iNm605SU10I4rxIsFq/KGDGF/JQw95tk2B9H+bqUO
   EbR/2dtzkZidptLKQtvd8L3SeaBv5wOBUbv8nYcarWPBA5twh5hydwRmf
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="322855245"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="322855245"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:59:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="618716481"
Received: from npeper-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.16.15])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:59:28 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V7 05/10] cxl/pci: Create DOE auxiliary driver
Date:   Wed, 30 Mar 2022 16:59:15 -0700
Message-Id: <20220330235920.2800929-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330235920.2800929-1-ira.weiny@intel.com>
References: <20220330235920.2800929-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

CXL kernel drivers optionally need to access DOE mailbox capabilities.
Access to mailboxes for things such as CDAT, SPDM, and IDE are needed by
the kernel while other access is designed towards user space usage.  An
example of this is for CXL Compliance Testing (see CXL 2.0 14.16.4
Compliance Mode DOE) which offers a mechanism to set different test
modes for a device.

There is no anticipated need for the kernel to share an individual
mailbox with user space.  Thus developing an interface to marshal access
between the kernel and user space for a single mailbox is unnecessary
overhead.  However, having the kernel relinquish some mailboxes to be
controlled by user space is a reasonable compromise to share access to
the device.

The auxiliary bus provides an elegant solution for this.  Each DOE
capability is given its own auxiliary device.  This device is controlled
by a kernel driver by default which restricts access to the mailbox.
Unbinding the driver from a single auxiliary device (DOE mailbox
capability) frees the mailbox for user space access.  This architecture
also allows a clear picture on which mailboxes are kernel controlled vs
not.

Create a driver for the DOE auxiliary devices.  The driver uses the PCI
DOE core to manage the mailbox.

User space must be prevented from unbinding the driver state when the
DOE auxiliary driver is being accessed by the kernel.  Add a read write
lock to the DOE auxiliary device to protect the driver data portion.

Finally, flag the driver module to be preloaded by device creation to
ensure the driver is attached when iterating the DOE capabilities.

User space access can be obtained by unbinding the driver from that
device.  For example:

$ ls -l /sys/bus/auxiliary/drivers
total 0
drwxr-xr-x 2 root root 0 Mar 24 10:45 cxl_doe.cxl_doe_drv

$ ls -l /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci*
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.0 -> ../../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.0
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.1 -> ../../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.1
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.2 -> ../../../../devices/pci0000:35/0000:35:00.0/0000:36:00.0/cxl_pci.doe.2
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.3 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.3
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.3 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.4
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.5 -> ../../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.5
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.6 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.6
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.7 -> ../../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.7

$ echo "cxl_pci.doe.4" > /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/unbind

$ ls -l /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci*
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.0 -> ../../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.0
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.1 -> ../../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.1
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.2 -> ../../../../devices/pci0000:35/0000:35:00.0/0000:36:00.0/cxl_pci.doe.2
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.3 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.3
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.5 -> ../../../../devices/pci0000:bf/0000:bf:00.0/0000:c0:00.0/cxl_pci.doe.5
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.6 -> ../../../../devices/pci0000:35/0000:35:01.0/0000:37:00.0/cxl_pci.doe.6
lrwxrwxrwx 1 root root 0 Mar 24 10:53 /sys/bus/auxiliary/drivers/cxl_doe.cxl_doe_drv/cxl_pci.doe.7 -> ../../../../devices/pci0000:bf/0000:bf:01.0/0000:c1:00.0/cxl_pci.doe.7

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V6:
	The CXL layer now contains the driver for these auxiliary
	devices.

Changes from V5:
	Split the CXL specific stuff off from the PCI DOE create
	auxiliary device code.
---
 drivers/cxl/Kconfig           | 12 +++++
 drivers/cxl/Makefile          |  2 +
 drivers/cxl/cxlpci.h          | 13 +++++
 drivers/cxl/doe.c             | 90 +++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c             | 20 ++++++++
 include/uapi/linux/pci_regs.h |  1 +
 6 files changed, 138 insertions(+)
 create mode 100644 drivers/cxl/doe.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 77fff6f6b0fb..1272288b50ed 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -104,4 +104,16 @@ config CXL_REGION
 	default CXL_BUS
 	tristate
 
+config CXL_PCI_DOE
+      tristate "CXL PCI Data Object Exchange (DOE) support"
+      depends on CXL_PCI
+      default CXL_BUS
+      help
+        Driver for DOE auxiliary devices.
+
+	The DOE capabilities provides a simple mailbox in PCI config space that
+	is used for a number of different protocols useful to CXL.  The CXL PCI
+	subsystem creates auxiliary devices for each DOE mailbox capability
+	found.  This driver is required for the kernel to use these devices.
+
 endif
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 02a4776e7ab9..a6104845a774 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += core/
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
+obj-$(CONFIG_CXL_PCI_DOE) += cxl_doe.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
@@ -9,6 +10,7 @@ obj-$(CONFIG_CXL_REGION) += cxl_region.o
 
 cxl_mem-y := mem.o
 cxl_pci-y := pci.o
+cxl_doe-y := doe.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
 cxl_port-y := port.o
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 2ad8715173ce..821fe05e8289 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -79,6 +79,7 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
  *
  * @adev: Auxiliary bus device
  * @pdev: PCI device this belongs to
+ * @driver_access: Lock the driver during access
  * @cap_offset: Capability offset
  * @use_irq: Set if IRQs are to be used with this mailbox
  *
@@ -88,9 +89,21 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_doe_dev {
 	struct auxiliary_device adev;
 	struct pci_dev *pdev;
+	struct rw_semaphore driver_access;
 	int cap_offset;
 	bool use_irq;
 };
 #define DOE_DEV_NAME "doe"
 
+/**
+ * struct cxl_doe_drv_state - state of the DOE Aux driver
+ *
+ * @doe_dev: The Auxiliary DOE device
+ * @doe_mb: PCI DOE mailbox state
+ */
+struct cxl_doe_drv_state {
+	struct cxl_doe_dev *doe_dev;
+	struct pci_doe_mb *doe_mb;
+};
+
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/doe.c b/drivers/cxl/doe.c
new file mode 100644
index 000000000000..5b13d5ec738e
--- /dev/null
+++ b/drivers/cxl/doe.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+
+#include <linux/pci.h>
+#include <linux/pci-doe.h>
+
+#include "cxlpci.h"
+
+static void doe_destroy_mb(void *ds)
+{
+	struct cxl_doe_drv_state *doe_ds = ds;
+
+	pci_doe_destroy_mb(doe_ds->doe_mb);
+}
+
+static int cxl_pci_doe_probe(struct auxiliary_device *aux_dev,
+			     const struct auxiliary_device_id *id)
+{
+	struct cxl_doe_dev *doe_dev = container_of(aux_dev, struct cxl_doe_dev,
+						   adev);
+	struct device *dev = &aux_dev->dev;
+	struct cxl_doe_drv_state *doe_ds;
+	struct pci_doe_mb *doe_mb;
+
+	doe_ds = devm_kzalloc(dev, sizeof(*doe_ds), GFP_KERNEL);
+	if (!doe_ds)
+		return -ENOMEM;
+
+	doe_mb = pci_doe_create_mb(doe_dev->pdev, doe_dev->cap_offset,
+				   doe_dev->use_irq);
+	if (IS_ERR(doe_mb)) {
+		dev_err(dev, "Failed to create the DOE mailbox state machine\n");
+		return PTR_ERR(doe_mb);
+	}
+
+	doe_ds->doe_mb = doe_mb;
+	devm_add_action_or_reset(dev, doe_destroy_mb, doe_ds);
+
+	down_write(&doe_dev->driver_access);
+	auxiliary_set_drvdata(aux_dev, doe_ds);
+	up_write(&doe_dev->driver_access);
+
+	return 0;
+}
+
+static void cxl_pci_doe_remove(struct auxiliary_device *aux_dev)
+{
+	struct cxl_doe_dev *doe_dev = container_of(aux_dev, struct cxl_doe_dev,
+						   adev);
+
+	down_write(&doe_dev->driver_access);
+	auxiliary_set_drvdata(aux_dev, NULL);
+	up_write(&doe_dev->driver_access);
+}
+
+static const struct auxiliary_device_id cxl_pci_doe_auxiliary_id_table[] = {
+	{.name = "cxl_pci." DOE_DEV_NAME, },
+	{},
+};
+
+MODULE_DEVICE_TABLE(auxiliary, cxl_pci_doe_auxiliary_id_table);
+
+struct auxiliary_driver cxl_pci_doe_auxiliary_drv = {
+	.name = "cxl_doe_drv",
+	.id_table = cxl_pci_doe_auxiliary_id_table,
+	.probe = cxl_pci_doe_probe,
+	.remove = cxl_pci_doe_remove,
+};
+
+static int __init cxl_pci_doe_init_module(void)
+{
+	int ret;
+
+	ret = auxiliary_driver_register(&cxl_pci_doe_auxiliary_drv);
+	if (ret) {
+		pr_err("Failed cxl_pci_doe auxiliary_driver_register() ret=%d\n",
+		       ret);
+	}
+
+	return ret;
+}
+
+static void __exit cxl_pci_doe_exit_module(void)
+{
+	auxiliary_driver_unregister(&cxl_pci_doe_auxiliary_drv);
+}
+
+module_init(cxl_pci_doe_init_module);
+module_exit(cxl_pci_doe_exit_module);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 6249f2a30026..bc94811a8395 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -571,6 +571,17 @@ static void cxl_pci_doe_destroy_device(void *ad)
 	auxiliary_device_uninit(ad);
 }
 
+static struct cxl_doe_drv_state *cxl_pci_doe_get_drv(struct cxl_doe_dev *doe_dev)
+{
+	down_read(&doe_dev->driver_access);
+	return auxiliary_get_drvdata(&doe_dev->adev);
+}
+
+static void cxl_pci_doe_put_drv(struct cxl_doe_dev *doe_dev)
+{
+	up_read(&doe_dev->driver_access);
+}
+
 /**
  * cxl_pci_create_doe_devices - Create auxiliary bus DOE devices for all DOE
  *				mailboxes found
@@ -633,6 +644,7 @@ int cxl_pci_create_doe_devices(struct pci_dev *pdev)
 			return -ENOMEM;
 
 		new_dev->pdev = pdev;
+		init_rwsem(&new_dev->driver_access);
 		new_dev->cap_offset = off;
 		new_dev->use_irq = use_irq;
 
@@ -663,6 +675,13 @@ int cxl_pci_create_doe_devices(struct pci_dev *pdev)
 					      adev);
 		if (rc)
 			return rc;
+
+		if (device_attach(&adev->dev) != 1) {
+			dev_err(&adev->dev,
+				"Failed to attach a driver to DOE device %d\n",
+				adev->id);
+			return -ENODEV;
+		}
 	}
 
 	return 0;
@@ -777,6 +796,7 @@ static struct pci_driver cxl_pci_driver = {
 	},
 };
 
+MODULE_SOFTDEP("pre: cxl_doe");
 MODULE_LICENSE("GPL v2");
 module_pci_driver(cxl_pci_driver);
 MODULE_IMPORT_NS(CXL);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 4e96b45ee36d..c268df088dd4 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1118,6 +1118,7 @@
 #define  PCI_DOE_STATUS_DATA_OBJECT_READY	0x80000000  /* Data Object Ready */
 #define PCI_DOE_WRITE		0x10    /* DOE Write Data Mailbox Register */
 #define PCI_DOE_READ		0x14    /* DOE Read Data Mailbox Register */
+#define PCI_DOE_CAP_SIZE	(0x14 + 4)	/* Size of this register block */
 
 /* DOE Data Object - note not actually registers */
 #define PCI_DOE_DATA_OBJECT_HEADER_1_VID		0x0000ffff
-- 
2.35.1

