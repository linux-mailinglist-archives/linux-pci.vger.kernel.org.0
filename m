Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26671373015
	for <lists+linux-pci@lfdr.de>; Tue,  4 May 2021 20:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhEDS6y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 14:58:54 -0400
Received: from mga11.intel.com ([192.55.52.93]:34796 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231274AbhEDS6x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 14:58:53 -0400
IronPort-SDR: oYtBTgKOZA57U6EcMx+x5YEh34mns9vHJV7yJlnB7/d5tO3tdb66ro/AZ/tJ1quE3Cq63Gcsr5
 hDqi72ld2drA==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="194916572"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="194916572"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 11:57:58 -0700
IronPort-SDR: BtAmOe8TGl4GLcJ8ZihorMM82E4tHFfr4xq+0gMIhYyMfVkHUkOXVII9xiy+l1Q8htaFshAjRU
 QNL6JJ+xLCbw==
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; 
   d="scan'208";a="468634426"
Received: from scwoody-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.140.171])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2021 11:57:57 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH] cxl: Rename mem to pci
Date:   Tue,  4 May 2021 11:57:31 -0700
Message-Id: <20210504185731.1058813-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for introducing a new driver for the CXL.mem / HDM
decoder (Host-managed Device Memory) capabilities of a CXL memory
expander, rename mem.c to pci.c so that mem.c is available for this new
driver.

CXL capabilities exist in a parallel domain to PCIe. CXL devices are
enumerable and controllable via "legacy" PCIe mechanisms; however, their
CXL capabilities are a superset of PCIe. For example, a CXL device may
be connected to a non-CXL capable PCIe root port, and therefore will not
be able to participate in CXL.mem or CXL.cache operations, but can still
be accessed through PCIe mechanisms for CXL.io operations.

To date, all existing drivers/cxl/ functionality is in support of the
PCIe-only based mechanisms, and due to the aforementioned distinction it
makes sense to move to a new file.

The result of the change is that a systems administrator may load only
the cxl_pci module and gain access to such operations as, firmware
update, offline provisioning of devices, and error collection. In
addition to freeing up the file name for another purpose, there are two
primary reasons this is useful,
    1. Acting upon devices which don't have full CXL capabilities. This
       may happen for instance if the CXL device is connected in a CXL
       unaware part of the platform topology.
    2. Userspace-first provisioning for devices without kernel driver
       interference. This may be useful when provisioning a new device
       in a specific manner that might otherwise be blocked or prevented
       by the real CXL mem driver.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/driver-api/cxl/memory-devices.rst |  6 +++---
 drivers/cxl/Kconfig                             | 13 ++++---------
 drivers/cxl/Makefile                            |  4 ++--
 drivers/cxl/{mem.c => pci.c}                    |  9 ++++-----
 4 files changed, 13 insertions(+), 19 deletions(-)
 rename drivers/cxl/{mem.c => pci.c} (99%)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 1bad466f9167..3876ee5fea53 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -22,10 +22,10 @@ This section covers the driver infrastructure for a CXL memory device.
 CXL Memory Device
 -----------------
 
-.. kernel-doc:: drivers/cxl/mem.c
-   :doc: cxl mem
+.. kernel-doc:: drivers/cxl/pci.c
+   :doc: cxl pci
 
-.. kernel-doc:: drivers/cxl/mem.c
+.. kernel-doc:: drivers/cxl/pci.c
    :internal:
 
 CXL Bus
diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 97dc4d751651..5483ba92b6da 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -21,15 +21,10 @@ config CXL_MEM
 	  as if the memory was attached to the typical CPU memory
 	  controller.
 
-	  Say 'y/m' to enable a driver (named "cxl_mem.ko" when built as
-	  a module) that will attach to CXL.mem devices for
-	  configuration, provisioning, and health monitoring. This
-	  driver is required for dynamic provisioning of CXL.mem
-	  attached memory which is a prerequisite for persistent memory
-	  support. Typically volatile memory is mapped by platform
-	  firmware and included in the platform memory map, but in some
-	  cases the OS is responsible for mapping that memory. See
-	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification.
+	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
+	  configuration and management primarily via the mailbox interface. See
+	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification for more
+	  details.
 
 	  If unsure say 'm'.
 
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index a314a1891f4d..22a0ca59ab1b 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += cxl_bus.o
-obj-$(CONFIG_CXL_MEM) += cxl_mem.o
+obj-$(CONFIG_CXL_MEM) += cxl_pci.o
 
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
 cxl_bus-y := bus.o
-cxl_mem-y := mem.o
+cxl_pci-y := pci.o
diff --git a/drivers/cxl/mem.c b/drivers/cxl/pci.c
similarity index 99%
rename from drivers/cxl/mem.c
rename to drivers/cxl/pci.c
index 2acc6173da36..48fb3f56fc8f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/pci.c
@@ -15,10 +15,11 @@
 #include "cxl.h"
 
 /**
- * DOC: cxl mem
+ * DOC: cxl pci
  *
- * This implements a CXL memory device ("type-3") as it is defined by the
- * Compute Express Link specification.
+ * This implements the PCI exclusive functionality for a CXL device as it is
+ * defined by the Compute Express Link specification. CXL devices may surface
+ * certain functionality even if it isn't CXL enabled.
  *
  * The driver has several responsibilities, mainly:
  *  - Create the memX device and register on the CXL bus.
@@ -26,8 +27,6 @@
  *  - Probe the device attributes to establish sysfs interface.
  *  - Provide an IOCTL interface to userspace to communicate with the device for
  *    things like firmware update.
- *  - Support management of interleave sets.
- *  - Handle and manage error conditions.
  */
 
 /*
-- 
2.31.1

