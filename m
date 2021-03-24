Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58B83483C6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 22:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhCXVcM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 17:32:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:30539 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238487AbhCXVbx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 17:31:53 -0400
IronPort-SDR: DeN2SK7No8pJIJNE+mm5rkMJVVFk8tpk7lzfd1JnLrvKR+bNWVLI4/3aIB5Wskgg0vFKWN9X/k
 WYTnORoI4bCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190884170"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="190884170"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:30:41 -0700
IronPort-SDR: 6MEAPcyq8kNRdOX16jZzroA8p0X+rCZ5iSfBxydRrehHiaxk6aMbYdo1Y4ASca8WpvcTJvGIFQ
 FtwH6TwAKIrQ==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="443123912"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:30:40 -0700
Subject: [PATCH 3/8] cxl/core: Rename bus.c to core.c
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ben.widawsky@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 14:30:40 -0700
Message-ID: <161662144049.1723715.7202999623564101920.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
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

