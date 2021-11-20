Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C984579DE
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbhKTAGI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:5719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229801AbhKTAGG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542391"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542391"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088328"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:55 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 01/23] cxl: Rename CXL_MEM to CXL_PCI
Date:   Fri, 19 Nov 2021 16:02:28 -0800
Message-Id: <20211120000250.1663391-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The cxl_mem module was renamed cxl_pci in commit 21e9f76733a8 ("cxl:
Rename mem to pci"). In preparation for adding an ancillary driver for
cxl_memdev devices (registered on the cxl bus by cxl_pci), go ahead and
rename CONFIG_CXL_MEM to CONFIG_CXL_PCI. Free up the CXL_MEM name for
that new driver to manage CXL.mem endpoint operations.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
Changes since RFCv2:
- Reword commit message (Dan)
- Reword Kconfig description (Dan)
---
 drivers/cxl/Kconfig  | 23 ++++++++++++-----------
 drivers/cxl/Makefile |  2 +-
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 67c91378f2dd..ef05e96f8f97 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -13,25 +13,26 @@ menuconfig CXL_BUS
 
 if CXL_BUS
 
-config CXL_MEM
-	tristate "CXL.mem: Memory Devices"
+config CXL_PCI
+	tristate "PCI manageability"
 	default CXL_BUS
 	help
-	  The CXL.mem protocol allows a device to act as a provider of
-	  "System RAM" and/or "Persistent Memory" that is fully coherent
-	  as if the memory was attached to the typical CPU memory
-	  controller.
+	  The CXL specification defines a "CXL memory device" sub-class in the
+	  PCI "memory controller" base class of devices. Device's identified by
+	  this class code provide support for volatile and / or persistent
+	  memory to be mapped into the system address map (Host-managed Device
+	  Memory (HDM)).
 
-	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
-	  configuration and management primarily via the mailbox interface. See
-	  Chapter 2.3 Type 3 CXL Device in the CXL 2.0 specification for more
-	  details.
+	  Say 'y/m' to enable a driver that will attach to CXL memory expander
+	  devices enumerated by the memory device class code for configuration
+	  and management primarily via the mailbox interface. See Chapter 2.3
+	  Type 3 CXL Device in the CXL 2.0 specification for more details.
 
 	  If unsure say 'm'.
 
 config CXL_MEM_RAW_COMMANDS
 	bool "RAW Command Interface for Memory Devices"
-	depends on CXL_MEM
+	depends on CXL_PCI
 	help
 	  Enable CXL RAW command interface.
 
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index d1aaabc940f3..cf07ae6cea17 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CXL_BUS) += core/
-obj-$(CONFIG_CXL_MEM) += cxl_pci.o
+obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 
-- 
2.34.0

