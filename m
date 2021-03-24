Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794A73483AF
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 22:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbhCXVbF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 17:31:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:32604 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238386AbhCXVaf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 17:30:35 -0400
IronPort-SDR: 5t9lw1uWhtEln8eM/oe232lr1uteozHXjlFv1R6dn+tDY3oW/ucusgdfvcpZLniPyn72zMaMy5
 R64Uqm90IYTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="178344012"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="178344012"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:30:35 -0700
IronPort-SDR: gyMoS3zThZa/qy/1Khsm3v0qo55H1v1x+YeTG6M1AhcHvsnUaccQWUU96wAzcgfPK+xV7vazKv
 ZcWsMKzmW33w==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="525391425"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:30:35 -0700
Subject: [PATCH 2/8] cxl/mem: Introduce 'struct cxl_regs'
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ben.widawsky@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 14:30:35 -0700
Message-ID: <161662143530.1723715.15800475088422813585.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for common register mapping facility, introduce a generic
container, 'struct cxl_regs', for CXL device register and later
component register block base pointers. Some CXL device types implement
both.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h |   33 +++++++++++++++++++++++++++++++++
 drivers/cxl/mem.c |   44 ++++++++++++++++++++++++--------------------
 drivers/cxl/mem.h |   13 +++++--------
 3 files changed, 62 insertions(+), 28 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 2e3bdacb32e7..37325e504fb7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -34,5 +34,38 @@
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
+/* See note for 'struct cxl_regs' for the rationale of this organization */
+#define CXL_DEVICE_REGS() \
+	void __iomem *status; \
+	void __iomem *mbox; \
+	void __iomem *memdev
+
+/**
+ * struct cxl_device_regs - Common container of CXL Device register
+ * 			    block base pointers
+ * @status: CXL 2.0 8.2.8.3 Device Status Registers
+ * @mbox: CXL 2.0 8.2.8.4 Mailbox Registers
+ * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
+ */
+struct cxl_device_regs {
+	CXL_DEVICE_REGS();
+};
+
+/*
+ * Note, the anonymous union organization allows for per
+ * register-block-type helper routines, without requiring block-type
+ * agnostic code to include the prefix. I.e.
+ * cxl_setup_device_regs(&cxlm->regs.dev) vs readl(cxlm->regs.mbox).
+ * The specificity reads naturally from left-to-right.
+ */
+struct cxl_regs {
+	union {
+		struct {
+			CXL_DEVICE_REGS();
+		};
+		struct cxl_device_regs device_regs;
+	};
+};
+
 extern struct bus_type cxl_bus_type;
 #endif /* __CXL_H__ */
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 45871ef65152..6951243d128e 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -31,7 +31,7 @@
  */
 
 #define cxl_doorbell_busy(cxlm)                                                \
-	(readl((cxlm)->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET) &                  \
+	(readl((cxlm)->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET) &                  \
 	 CXLDEV_MBOX_CTRL_DOORBELL)
 
 /* CXL 2.0 - 8.2.8.4 */
@@ -271,7 +271,7 @@ static void cxl_mem_mbox_timeout(struct cxl_mem *cxlm,
 static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 				   struct mbox_cmd *mbox_cmd)
 {
-	void __iomem *payload = cxlm->mbox_regs + CXLDEV_MBOX_PAYLOAD_OFFSET;
+	void __iomem *payload = cxlm->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
 	u64 cmd_reg, status_reg;
 	size_t out_len;
 	int rc;
@@ -314,12 +314,12 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 	}
 
 	/* #2, #3 */
-	writeq(cmd_reg, cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
+	writeq(cmd_reg, cxlm->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
 
 	/* #4 */
 	dev_dbg(&cxlm->pdev->dev, "Sending command\n");
 	writel(CXLDEV_MBOX_CTRL_DOORBELL,
-	       cxlm->mbox_regs + CXLDEV_MBOX_CTRL_OFFSET);
+	       cxlm->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
 
 	/* #5 */
 	rc = cxl_mem_wait_for_doorbell(cxlm);
@@ -329,7 +329,7 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 	}
 
 	/* #6 */
-	status_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_STATUS_OFFSET);
+	status_reg = readq(cxlm->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
 	mbox_cmd->return_code =
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
@@ -339,7 +339,7 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 	}
 
 	/* #7 */
-	cmd_reg = readq(cxlm->mbox_regs + CXLDEV_MBOX_CMD_OFFSET);
+	cmd_reg = readq(cxlm->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
 	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
 
 	/* #8 */
@@ -400,7 +400,7 @@ static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
 		goto out;
 	}
 
-	md_status = readq(cxlm->memdev_regs + CXLMDEV_STATUS_OFFSET);
+	md_status = readq(cxlm->regs.memdev + CXLMDEV_STATUS_OFFSET);
 	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
 		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
 		rc = -EBUSY;
@@ -868,7 +868,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 	int cap, cap_count;
 	u64 cap_array;
 
-	cap_array = readq(cxlm->regs + CXLDEV_CAP_ARRAY_OFFSET);
+	cap_array = readq(cxlm->base + CXLDEV_CAP_ARRAY_OFFSET);
 	if (FIELD_GET(CXLDEV_CAP_ARRAY_ID_MASK, cap_array) !=
 	    CXLDEV_CAP_ARRAY_CAP_ID)
 		return -ENODEV;
@@ -881,25 +881,25 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		u16 cap_id;
 
 		cap_id = FIELD_GET(CXLDEV_CAP_HDR_CAP_ID_MASK,
-				   readl(cxlm->regs + cap * 0x10));
-		offset = readl(cxlm->regs + cap * 0x10 + 0x4);
-		register_block = cxlm->regs + offset;
+				   readl(cxlm->base + cap * 0x10));
+		offset = readl(cxlm->base + cap * 0x10 + 0x4);
+		register_block = cxlm->base + offset;
 
 		switch (cap_id) {
 		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
 			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
-			cxlm->status_regs = register_block;
+			cxlm->regs.status = register_block;
 			break;
 		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
 			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
-			cxlm->mbox_regs = register_block;
+			cxlm->regs.mbox = register_block;
 			break;
 		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
 			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
 			break;
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
-			cxlm->memdev_regs = register_block;
+			cxlm->regs.memdev = register_block;
 			break;
 		default:
 			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
@@ -907,11 +907,11 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		}
 	}
 
-	if (!cxlm->status_regs || !cxlm->mbox_regs || !cxlm->memdev_regs) {
+	if (!cxlm->regs.status || !cxlm->regs.mbox || !cxlm->regs.memdev) {
 		dev_err(dev, "registers not found: %s%s%s\n",
-			!cxlm->status_regs ? "status " : "",
-			!cxlm->mbox_regs ? "mbox " : "",
-			!cxlm->memdev_regs ? "memdev" : "");
+			!cxlm->regs.status ? "status " : "",
+			!cxlm->regs.mbox ? "mbox " : "",
+			!cxlm->regs.memdev ? "memdev" : "");
 		return -ENXIO;
 	}
 
@@ -920,7 +920,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 
 static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
 {
-	const int cap = readl(cxlm->mbox_regs + CXLDEV_MBOX_CAPS_OFFSET);
+	const int cap = readl(cxlm->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
 
 	cxlm->payload_size =
 		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
@@ -980,7 +980,7 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 
 	mutex_init(&cxlm->mbox_mutex);
 	cxlm->pdev = pdev;
-	cxlm->regs = regs + offset;
+	cxlm->base = regs + offset;
 	cxlm->enabled_cmds =
 		devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
 				   sizeof(unsigned long),
@@ -1495,6 +1495,10 @@ static __init int cxl_mem_init(void)
 	dev_t devt;
 	int rc;
 
+	/* Double check the anonymous union trickery in struct cxl_regs */
+	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
+		     offsetof(struct cxl_regs, device_regs.memdev));
+
 	rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index daa9aba0e218..c247cf9c71af 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -53,10 +53,9 @@ struct cxl_memdev {
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
- * @regs: IO mappings to the device's MMIO
- * @status_regs: CXL 2.0 8.2.8.3 Device Status Registers
- * @mbox_regs: CXL 2.0 8.2.8.4 Mailbox Registers
- * @memdev_regs: CXL 2.0 8.2.8.5 Memory Device Registers
+ * @base: IO mappings to the device's MMIO
+ * @cxlmd: Logical memory device chardev / interface
+ * @regs: Parsed register blocks
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
  * @mbox_mutex: Mutex to synchronize mailbox access.
@@ -67,12 +66,10 @@ struct cxl_memdev {
  */
 struct cxl_mem {
 	struct pci_dev *pdev;
-	void __iomem *regs;
+	void __iomem *base;
 	struct cxl_memdev *cxlmd;
 
-	void __iomem *status_regs;
-	void __iomem *mbox_regs;
-	void __iomem *memdev_regs;
+	struct cxl_regs regs;
 
 	size_t payload_size;
 	struct mutex mbox_mutex; /* Protects device mailbox and firmware */

