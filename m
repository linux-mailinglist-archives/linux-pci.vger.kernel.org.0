Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4E380348
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 07:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhENFXY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 01:23:24 -0400
Received: from mga17.intel.com ([192.55.52.151]:44626 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232479AbhENFXR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 01:23:17 -0400
IronPort-SDR: jERPCuZZDYPoMOmX/h1ZR5AmITHHnKMMzXp5Ax5hC4TVbGwQEsW5rimau0KQxZXVQ0T4L1BcCm
 0kkRkBFqXp/Q==
X-IronPort-AV: E=McAfee;i="6200,9189,9983"; a="180389379"
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="180389379"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 22:22:05 -0700
IronPort-SDR: gQmVZs0w91wJ+3FAS0wk+xiSJ+Hbk2pPH7kXFh7adNVObNiEByV5nt91cJXpZUyTD3KznDwgBB
 /agQqfI7ozvg==
X-IronPort-AV: E=Sophos;i="5.82,299,1613462400"; 
   d="scan'208";a="392560248"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 22:22:05 -0700
Subject: [PATCH v4 4/8] cxl/core: Refactor CXL register lookup for bridge
 reuse
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>, hch@lst.de,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 13 May 2021 22:22:05 -0700
Message-ID: <162096972534.1865304.3218686216153688039.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162096970332.1865304.10280028741091576940.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162096970332.1865304.10280028741091576940.stgit@dwillia2-desk3.amr.corp.intel.com>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h  |    3 +++
 drivers/cxl/mem.c  |   50 +++++-----------------------------------------
 3 files changed, 66 insertions(+), 44 deletions(-)

diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
index 7f8d2034038a..84b90db57420 100644
--- a/drivers/cxl/core.c
+++ b/drivers/cxl/core.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include "cxl.h"
 
 /**
  * DOC: cxl core
@@ -10,6 +12,61 @@
  * point for cross-device interleave coordination through cxl ports.
  */
 
+/**
+ * cxl_setup_device_regs() - Detect CXL Device register blocks
+ * @dev: Host device of the @base mapping
+ * @base: Mapping of CXL 2.0 8.2.8 CXL Device Register Interface
+ * @regs: Base pointers for device register blocks (see CXL_DEVICE_REGS())
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
index 1f3434f89ef2..d49e0cb679fa 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -66,5 +66,8 @@ struct cxl_regs {
 	};
 };
 
+void cxl_setup_device_regs(struct device *dev, void __iomem *base,
+			   struct cxl_device_regs *regs);
+
 extern struct bus_type cxl_bus_type;
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index ddc94c7bd422..c5fdf2c57181 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -884,53 +884,15 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode,
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
 

