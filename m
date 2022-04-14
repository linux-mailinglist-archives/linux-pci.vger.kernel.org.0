Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4DC501CDA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 22:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346363AbiDNUfU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 16:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346367AbiDNUfO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 16:35:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A98AAC9D;
        Thu, 14 Apr 2022 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649968367; x=1681504367;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bYJtVExh9ya6dkOfv/s8l5rDL/6UedPrhO6YnabSYfg=;
  b=KEwmohJYM+7+SuVfy5PtYWJd5NcscYBo2pSNLgUiLGm0qT4R+QHwgeGb
   Fmo1xBv6bR0RMDEb8M02bOfvEzpQ5c30v/DlAzXtbp1ekTn4knvrbKQ6N
   zSp/48JPDmZV6+JNMFl3jdDwwJO7EPrFVtwcom1AY+0MIMTIw7JePkvW0
   g5mBLsr7aRePbKuEAYQep59h2iB1l5ftXGt+YbKVA0beuiU/7MMu01O3R
   qd1B0gKGqu0fg8MM4wyh6Qn4Z+BXWA9c0NqE+WMoOm+/KR38uf8Z8ajMM
   2ldbzzmCseqmCv3gzrF6tiEqJbz7R7y+Tm3DgX9C+NN5aBu44GddQwLOA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="250323640"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="250323640"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="591319543"
Received: from aimeehax-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.113.132])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:46 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V8 05/10] cxl/pci: Create DOE auxiliary driver
Date:   Thu, 14 Apr 2022 13:32:32 -0700
Message-Id: <20220414203237.2198665-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414203237.2198665-1-ira.weiny@intel.com>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Changes from V7:
	Now need to select PCI_DOE
	Change MODULE_LICENSE to 'GPL' instead of old 'GPL v2'

Changes from V6:
	The CXL layer now contains the driver for these auxiliary
	devices.

Changes from V5:
	Split the CXL specific stuff off from the PCI DOE create
	auxiliary device code.
---
 drivers/cxl/Kconfig           | 13 +++++
 drivers/cxl/Makefile          |  2 +
 drivers/cxl/cxlpci.h          | 13 +++++
 drivers/cxl/doe.c             | 90 +++++++++++++++++++++++++++++++++++
 drivers/cxl/pci.c             | 20 ++++++++
 include/uapi/linux/pci_regs.h |  1 +
 6 files changed, 139 insertions(+)
 create mode 100644 drivers/cxl/doe.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index ac0f5ca95431..82f3908fa5cc 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -103,4 +103,17 @@ config CXL_SUSPEND
 	def_bool y
 	depends on SUSPEND && CXL_MEM
 
+config CXL_PCI_DOE
+      tristate "CXL PCI Data Object Exchange (DOE) support"
+      depends on CXL_PCI
+      default CXL_BUS
+      select PCI_DOE
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
index a78270794150..c71b7a6345fb 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-y += core/
 obj-$(CONFIG_CXL_PCI) += cxl_pci.o
+obj-$(CONFIG_CXL_PCI_DOE) += cxl_doe.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
@@ -8,6 +9,7 @@ obj-$(CONFIG_CXL_PORT) += cxl_port.o
 
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
index 000000000000..1d3a24a77002
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
+MODULE_LICENSE("GPL");
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 41a6f3eb0a5c..0dec1f1a3f38 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -590,6 +590,17 @@ static void cxl_pci_doe_destroy_device(void *ad)
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
@@ -652,6 +663,7 @@ static int cxl_pci_create_doe_devices(struct pci_dev *pdev)
 			return -ENOMEM;
 
 		new_dev->pdev = pdev;
+		init_rwsem(&new_dev->driver_access);
 		new_dev->cap_offset = off;
 		new_dev->use_irq = use_irq;
 
@@ -682,6 +694,13 @@ static int cxl_pci_create_doe_devices(struct pci_dev *pdev)
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
@@ -785,6 +804,7 @@ static struct pci_driver cxl_pci_driver = {
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

