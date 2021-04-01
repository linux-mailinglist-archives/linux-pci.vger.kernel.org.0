Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFFE351778
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 19:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbhDARmR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 13:42:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:46951 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234759AbhDARjo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Apr 2021 13:39:44 -0400
IronPort-SDR: +LmthehJ1PLZRvDXjJyW8F8GO6VjqneIUKxIXwZ2ueD4sPW0DJ9MqAtRIgximA6k+IHBfbWCG1
 lw3hRpaltkbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="212511861"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="212511861"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:31:04 -0700
IronPort-SDR: rBUmT0zYTZoXy45GsDdBfMPzKc/L60oJswgxrTXJX4YVzRDMUnwFaW1LhZp4wcQC5hjtZnfHgy
 A6pu1u1ZYGfw==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="384864735"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:31:03 -0700
Subject: [PATCH v2 4/8] cxl/core: Refactor CXL register lookup for bridge
 reuse
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ben.widawsky@intel.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Apr 2021 07:31:03 -0700
Message-ID: <161728746354.2474040.14531317270409827157.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While CXL Memory Device endpoints locate the CXL MMIO registers in a PCI
BAR, CXL root bridges have their MMIO base address described by platform
firmware. Refactor the existing register lookup into a generic facility
for endpoints and bridges to share.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h  |    3 +++
 drivers/cxl/mem.c  |   50 +++++-----------------------------------------
 3 files changed, 65 insertions(+), 45 deletions(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 7f8d2034038a..2ab467ef9909 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+/* Copyright(c) 2020-2021 Intel Corporation. All rights reserved. */
 #include <linux/device.h>
 #include <linux/module.h>
+#include "cxl.h"
 
 /**
  * DOC: cxl core
@@ -10,6 +11,60 @@
  * point for cross-device interleave coordination through cxl ports.
  */
 
+/*
+ * cxl_setup_device_regs() - Detect CXL Device register blocks
+ * @dev: Host device of the @base mapping
+ * @base: mapping of CXL 2.0 8.2.8 CXL Device Register Interface
+ */
+void cxl_setup_device_regs(struct device *dev, void __iomem *base,
+			   struct cxl_device_regs *regs)
+{
+	int cap, cap_count;
+	u64 cap_array;
+
+	*regs = (struct cxl_device_regs) { 0 };
+
+	cap_array = readq(base + CXLDEV_CAP_ARRAY_OFFSET);
+	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
+	    CXLDEV_CAP_ARRAY_CAP_ID)
+		return;
+
+	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
+
+	for (cap = 1; cap <= cap_count; cap++) {
+		void __iomem *register_block;
+		u32 offset;
+		u16 cap_id;
+
+		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
+				   readl(base + cap * 0x10));
+		offset = readl(base + cap * 0x10 + 0x4);
+		register_block = base + offset;
+
+		switch (cap_id) {
+		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
+			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
+			regs->status = register_block;
+			break;
+		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
+			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
+			regs->mbox = register_block;
+			break;
+		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
+			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
+			break;
+		case CXLDEV_CAP_CAP_ID_MEMDEV:
+			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
+			regs->memdev = register_block;
+			break;
+		default:
+			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
+			break;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(cxl_setup_device_regs);
+
 struct bus_type cxl_bus_type = {
 	.name = "cxl",
 };
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 37325e504fb7..cbd29650c4e2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -67,5 +67,8 @@ struct cxl_regs {
 	};
 };
 
+void cxl_setup_device_regs(struct device *dev, void __iomem *base,
+			   struct cxl_device_regs *regs);
+
 extern struct bus_type cxl_bus_type;
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 6951243d128e..ee55abfa147e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -865,53 +865,15 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode,
 static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 {
 	struct device *dev = &cxlm->pdev->dev;
-	int cap, cap_count;
-	u64 cap_array;
+	struct cxl_regs *regs = &cxlm->regs;
 
-	cap_array = readq(cxlm->base + CXLDEV_CAP_ARRAY_OFFSET);
-	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
-	    CXLDEV_CAP_ARRAY_CAP_ID)
-		return -ENODEV;
-
-	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
-
-	for (cap = 1; cap <= cap_count; cap++) {
-		void __iomem *register_block;
-		u32 offset;
-		u16 cap_id;
-
-		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
-				   readl(cxlm->base + cap * 0x10));
-		offset = readl(cxlm->base + cap * 0x10 + 0x4);
-		register_block = cxlm->base + offset;
-
-		switch (cap_id) {
-		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
-			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
-			cxlm->regs.status = register_block;
-			break;
-		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
-			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
-			cxlm->regs.mbox = register_block;
-			break;
-		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
-			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
-			break;
-		case CXLDEV_CAP_CAP_ID_MEMDEV:
-			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
-			cxlm->regs.memdev = register_block;
-			break;
-		default:
-			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
-			break;
-		}
-	}
+	cxl_setup_device_regs(dev, cxlm->base, &regs->device_regs);
 
-	if (!cxlm->regs.status || !cxlm->regs.mbox || !cxlm->regs.memdev) {
+	if (!regs->status || !regs->mbox || !regs->memdev) {
 		dev_err(dev, "registers not found: %s%s%s\n",
-			!cxlm->regs.status ? "status " : "",
-			!cxlm->regs.mbox ? "mbox " : "",
-			!cxlm->regs.memdev ? "memdev" : "");
+			!regs->status ? "status " : "",
+			!regs->mbox ? "mbox " : "",
+			!regs->memdev ? "memdev" : "");
 		return -ENXIO;
 	}
 

