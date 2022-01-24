Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEEF497671
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240568AbiAXA2o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:28:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:41947 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235008AbiAXA2o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984124; x=1674520124;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5qUmJVhdpHru+9iai5Jb7cr86cHMGIXY/Xi0hUqO6y0=;
  b=OxKQeWhllqkojBhyYcsgIA+sij6HpSi16kYrm5iyyoTOrD3NBrdRo/Xd
   /Uca4d6cKK479x2kwafGpHMig3AvtMmaatag7LlZQh5ZAORjLWxyLPUlC
   XA/ONX6yTJlT2OUC3ywz8Vhz2u/PG5Gu5Ymn9udSzf0OqaK5OdyBxUoQc
   SrQGra9kMK2wyXoaZf7jHqFwrASW4bri5ZHui6NJyCqj0GaYt2wtkdoh+
   Ts8wl00BwllEV51CY6gD0EB/48lQ3IWoVp+kvqwMwWs/KDMRjEk1CMW85
   Qugk7CsQOf+KSLu8NC4L+6/WOft3Mhuma0nVtjvO2MYN5Wd411Mu4h74s
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244766445"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244766445"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:28:44 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="476536353"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:28:44 -0800
Subject: [PATCH v3 01/40] cxl: Rename CXL_MEM to CXL_PCI
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:28:44 -0800
Message-ID: <164298412409.3018233.12407355692407890752.stgit@dwillia2-desk3.amr.corp.intel.com>
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

The cxl_mem module was renamed cxl_pci in commit 21e9f76733a8 ("cxl:
Rename mem to pci"). In preparation for adding an ancillary driver for
cxl_memdev devices (registered on the cxl bus by cxl_pci), go ahead and
rename CONFIG_CXL_MEM to CONFIG_CXL_PCI. Free up the CXL_MEM name for
that new driver to manage CXL.mem endpoint operations.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/Kconfig  |   23 ++++++++++++-----------
 drivers/cxl/Makefile |    2 +-
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
 

