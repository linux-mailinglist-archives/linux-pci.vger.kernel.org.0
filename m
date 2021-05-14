Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE5738033E
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 07:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbhENFXB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 01:23:01 -0400
Received: from mga07.intel.com ([134.134.136.100]:33955 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232419AbhENFXA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 01:23:00 -0400
IronPort-SDR: GTR4oKx3W9yFXxe3exCCsmA5GjtCotahCS3tOICKDJzo5J59yGN4bNazESxmdBy9qo7xplNJVX
 L3DCHVxwVQsg==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="264039914"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="264039914"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 22:21:49 -0700
IronPort-SDR: Li9VxngSPIqq7gICGIZBvzD7qjaVfsHAtX3UA8NxYtMeH0gv4cvfYvJPTPPZnAaIzY23q42qY5
 16Lkl3FTvr+g==
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="610642373"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 22:21:49 -0700
Subject: [PATCH v4 1/8] cxl/mem: Move some definitions to mem.h
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>, hch@lst.de,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 May 2021 22:21:49 -0700
Message-ID: <162096970932.1865304.14510894426562947262.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162096970332.1865304.10280028741091576940.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162096970332.1865304.10280028741091576940.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for sharing cxl.h with other generic CXL consumers,
move / consolidate some of the memory device specifics to mem.h.

The motivation for moving out of cxl.h is to maintain least privilege
access to memory-device details since cxl.h is used in multiple files.
The motivation for moving definitions into a new mem.h header is for
code readability and organization. I.e. minimize implementation details
when reading data structures and other definitions.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h |   57 -------------------------------------
 drivers/cxl/mem.c |   21 +-------------
 drivers/cxl/mem.h |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 82 insertions(+), 77 deletions(-)
 create mode 100644 drivers/cxl/mem.h

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6f14838c2d25..2e3bdacb32e7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -34,62 +34,5 @@
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
-/* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
-#define CXLMDEV_STATUS_OFFSET 0x0
-#define   CXLMDEV_DEV_FATAL BIT(0)
-#define   CXLMDEV_FW_HALT BIT(1)
-#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
-#define     CXLMDEV_MS_NOT_READY 0
-#define     CXLMDEV_MS_READY 1
-#define     CXLMDEV_MS_ERROR 2
-#define     CXLMDEV_MS_DISABLED 3
-#define CXLMDEV_READY(status)                                                  \
-	(FIELD_GET(CXLMDEV_STATUS_MEDIA_STATUS_MASK, status) ==                \
-	 CXLMDEV_MS_READY)
-#define   CXLMDEV_MBOX_IF_READY BIT(4)
-#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
-#define     CXLMDEV_RESET_NEEDED_NOT 0
-#define     CXLMDEV_RESET_NEEDED_COLD 1
-#define     CXLMDEV_RESET_NEEDED_WARM 2
-#define     CXLMDEV_RESET_NEEDED_HOT 3
-#define     CXLMDEV_RESET_NEEDED_CXL 4
-#define CXLMDEV_RESET_NEEDED(status)                                           \
-	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
-	 CXLMDEV_RESET_NEEDED_NOT)
-
-struct cxl_memdev;
-/**
- * struct cxl_mem - A CXL memory device
- * @pdev: The PCI device associated with this CXL device.
- * @regs: IO mappings to the device's MMIO
- * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
- * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
- * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
- * @payload_size: Size of space for payload
- *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
- * @mbox_mutex: Mutex to synchronize mailbox access.
- * @firmware_version: Firmware version for the memory device.
- * @enabled_commands: Hardware commands found enabled in CEL.
- * @pmem_range: Persistent memory capacity information.
- * @ram_range: Volatile memory capacity information.
- */
-struct cxl_mem {
-	struct pci_dev *pdev;
-	void __iomem *regs;
-	struct cxl_memdev *cxlmd;
-
-	void __iomem *status_regs;
-	void __iomem *mbox_regs;
-	void __iomem *memdev_regs;
-
-	size_t payload_size;
-	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
-	char firmware_version[0x10];
-	unsigned long *enabled_cmds;
-
-	struct range pmem_range;
-	struct range ram_range;
-};
-
 extern struct bus_type cxl_bus_type;
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2acc6173da36..53933d7d8d12 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -13,6 +13,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include "pci.h"
 #include "cxl.h"
+#include "mem.h"
 
 /**
  * DOC: cxl mem
@@ -30,12 +31,6 @@
  *  - Handle and manage error conditions.
  */
 
-/*
- * An entire PCI topology full of devices should be enough for any
- * config
- */
-#define CXL_MEM_MAX_DEVS 65536
-
 #define cxl_doorbell_busy(cxlm)                                                \
 	(readl((cxlm)->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET) &                  \
 	 CXLDEV_MBOX_CTRL_DOORBELL)
@@ -92,20 +87,6 @@ struct mbox_cmd {
 #define CXL_MBOX_SUCCESS 0
 };
 
-/**
- * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
- * @dev: driver core device object
- * @cdev: char dev core object for ioctl operations
- * @cxlm: pointer to the parent device driver data
- * @id: id number of this memdev instance.
- */
-struct cxl_memdev {
-	struct device dev;
-	struct cdev cdev;
-	struct cxl_mem *cxlm;
-	int id;
-};
-
 static int cxl_mem_major;
 static DEFINE_IDA(cxl_memdev_ida);
 static DECLARE_RWSEM(cxl_memdev_rwsem);
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
new file mode 100644
index 000000000000..451db0984b92
--- /dev/null
+++ b/drivers/cxl/mem.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2020-2021 Intel Corporation. */
+#ifndef __CXL_MEM_H__
+#define __CXL_MEM_H__
+
+/* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
+#define CXLMDEV_STATUS_OFFSET 0x0
+#define   CXLMDEV_DEV_FATAL BIT(0)
+#define   CXLMDEV_FW_HALT BIT(1)
+#define   CXLMDEV_STATUS_MEDIA_STATUS_MASK GENMASK(3, 2)
+#define     CXLMDEV_MS_NOT_READY 0
+#define     CXLMDEV_MS_READY 1
+#define     CXLMDEV_MS_ERROR 2
+#define     CXLMDEV_MS_DISABLED 3
+#define CXLMDEV_READY(status)                                                  \
+	(FIELD_GET(CXLMDEV_STATUS_MEDIA_STATUS_MASK, status) ==                \
+	 CXLMDEV_MS_READY)
+#define   CXLMDEV_MBOX_IF_READY BIT(4)
+#define   CXLMDEV_RESET_NEEDED_MASK GENMASK(7, 5)
+#define     CXLMDEV_RESET_NEEDED_NOT 0
+#define     CXLMDEV_RESET_NEEDED_COLD 1
+#define     CXLMDEV_RESET_NEEDED_WARM 2
+#define     CXLMDEV_RESET_NEEDED_HOT 3
+#define     CXLMDEV_RESET_NEEDED_CXL 4
+#define CXLMDEV_RESET_NEEDED(status)                                           \
+	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
+	 CXLMDEV_RESET_NEEDED_NOT)
+
+/*
+ * An entire PCI topology full of devices should be enough for any
+ * config
+ */
+#define CXL_MEM_MAX_DEVS 65536
+
+/**
+ * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
+ * @dev: driver core device object
+ * @cdev: char dev core object for ioctl operations
+ * @cxlm: pointer to the parent device driver data
+ * @id: id number of this memdev instance.
+ */
+struct cxl_memdev {
+	struct device dev;
+	struct cdev cdev;
+	struct cxl_mem *cxlm;
+	int id;
+};
+
+/**
+ * struct cxl_mem - A CXL memory device
+ * @pdev: The PCI device associated with this CXL device.
+ * @regs: IO mappings to the device's MMIO
+ * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
+ * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
+ * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
+ * @payload_size: Size of space for payload
+ *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
+ * @mbox_mutex: Mutex to synchronize mailbox access.
+ * @firmware_version: Firmware version for the memory device.
+ * @enabled_cmds: Hardware commands found enabled in CEL.
+ * @pmem_range: Persistent memory capacity information.
+ * @ram_range: Volatile memory capacity information.
+ */
+struct cxl_mem {
+	struct pci_dev *pdev;
+	void __iomem *regs;
+	struct cxl_memdev *cxlmd;
+
+	void __iomem *status_regs;
+	void __iomem *mbox_regs;
+	void __iomem *memdev_regs;
+
+	size_t payload_size;
+	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
+	char firmware_version[0x10];
+	unsigned long *enabled_cmds;
+
+	struct range pmem_range;
+	struct range ram_range;
+};
+#endif /* __CXL_MEM_H__ */

