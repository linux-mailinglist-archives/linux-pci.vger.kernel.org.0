Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C16F376CF9
	for <lists+linux-pci@lfdr.de>; Sat,  8 May 2021 00:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbhEGWwi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 18:52:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:53407 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230034AbhEGWwi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 18:52:38 -0400
IronPort-SDR: bEQHjdFLMkPcXnxNHLRy/A25R9HX4tZ24SCKRFMoaqZQt+AiND66YsHU/CHyadf1HCLGBSSiTi
 bQ5lyWYj0SBw==
X-IronPort-AV: E=McAfee;i="6200,9189,9977"; a="219737087"
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="219737087"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 15:51:37 -0700
IronPort-SDR: pzfd0DELys5GA/Gya8t6hVfplerTXsu5IN2ipwOrHMXQdyMcizgPph/022aTubxE6zS47B9D+B
 R2IWOEjyaxVw==
X-IronPort-AV: E=Sophos;i="5.82,282,1613462400"; 
   d="scan'208";a="470054278"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 15:51:32 -0700
Subject: [PATCH 3/8] cxl/core: Rename bus.c to core.c
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Date:   Fri, 07 May 2021 15:51:31 -0700
Message-ID: <162042789118.1202325.17252779312531377335.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162042787450.1202325.5718541949681409566.stgit@dwillia2-desk3.amr.corp.intel.com>
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

