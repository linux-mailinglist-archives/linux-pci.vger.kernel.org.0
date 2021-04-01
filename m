Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDCE6351E2F
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhDASgD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 14:36:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:38709 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237782AbhDAS2B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Apr 2021 14:28:01 -0400
IronPort-SDR: x27x1ulyE78LX0NN3oo9Bw0itMj8zJkImUTnoTgTJiozrSbaPetIH6MKvbyroh9eSdC9tdV2ij
 cv+jddw58sMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179789433"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179789433"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:30:58 -0700
IronPort-SDR: XxjuKf5pxI35kLYTzlvbchxzw09/Qazynfmqaoj5UF3yZjAsFGTnIi7S+qClNRhDOYE/827Th6
 MihUFrqKnBjg==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="416687041"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:30:58 -0700
Subject: [PATCH v2 3/8] cxl/core: Rename bus.c to core.c
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ben.widawsky@intel.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Apr 2021 07:30:58 -0700
Message-ID: <161728745839.2474040.8224160078719308484.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for more generic shared functionality across endpoint
consumers of core cxl resources, and platform-firmware producers of
those resources, rename bus.c to core.c. In addition to the central
rendezvous for interleave coordination, the core will also define common
routines like CXL register block mapping.

Acked-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/driver-api/cxl/memory-devices.rst |    6 ++---
 drivers/cxl/Makefile                            |    4 ++-
 drivers/cxl/bus.c                               |   29 ----------------------
 drivers/cxl/core.c                              |   30 +++++++++++++++++++++++
 4 files changed, 35 insertions(+), 34 deletions(-)
 delete mode 100644 drivers/cxl/bus.c
 create mode 100644 drivers/cxl/core.c

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 1bad466f9167..71495ed77069 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -28,10 +28,10 @@ CXL Memory Device
 .. kernel-doc:: drivers/cxl/mem.c
    :internal:
 
-CXL Bus
+CXL Core
 -------
-.. kernel-doc:: drivers/cxl/bus.c
-   :doc: cxl bus
+.. kernel-doc:: drivers/cxl/core.c
+   :doc: cxl core
 
 External Interfaces
 ===================
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index a314a1891f4d..3808e39dd31f 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CXL_BUS) += cxl_bus.o
+obj-$(CONFIG_CXL_BUS) += cxl_core.o
 obj-$(CONFIG_CXL_MEM) += cxl_mem.o
 
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
-cxl_bus-y := bus.o
+cxl_core-y := core.o
 cxl_mem-y := mem.o
diff --git a/drivers/cxl/bus.c b/drivers/cxl/bus.c
deleted file mode 100644
index 58f74796d525..000000000000
--- a/drivers/cxl/bus.c
+++ /dev/null
@@ -1,29 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
-#include <linux/device.h>
-#include <linux/module.h>
-
-/**
- * DOC: cxl bus
- *
- * The CXL bus provides namespace for control devices and a rendezvous
- * point for cross-device interleave coordination.
- */
-struct bus_type cxl_bus_type = {
-	.name = "cxl",
-};
-EXPORT_SYMBOL_GPL(cxl_bus_type);
-
-static __init int cxl_bus_init(void)
-{
-	return bus_register(&cxl_bus_type);
-}
-
-static void cxl_bus_exit(void)
-{
-	bus_unregister(&cxl_bus_type);
-}
-
-module_init(cxl_bus_init);
-module_exit(cxl_bus_exit);
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
new file mode 100644
index 000000000000..7f8d2034038a
--- /dev/null
+++ b/drivers/cxl/core.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <linux/module.h>
+
+/**
+ * DOC: cxl core
+ *
+ * The CXL core provides a sysfs hierarchy for control devices and a rendezvous
+ * point for cross-device interleave coordination through cxl ports.
+ */
+
+struct bus_type cxl_bus_type = {
+	.name = "cxl",
+};
+EXPORT_SYMBOL_GPL(cxl_bus_type);
+
+static __init int cxl_core_init(void)
+{
+	return bus_register(&cxl_bus_type);
+}
+
+static void cxl_core_exit(void)
+{
+	bus_unregister(&cxl_bus_type);
+}
+
+module_init(cxl_core_init);
+module_exit(cxl_core_exit);
+MODULE_LICENSE("GPL v2");

