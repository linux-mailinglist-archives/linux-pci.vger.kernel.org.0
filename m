Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7AE32AE844
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 06:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgKKFoZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 00:44:25 -0500
Received: from mga12.intel.com ([192.55.52.136]:54147 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgKKFoI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Nov 2020 00:44:08 -0500
IronPort-SDR: Xib6Unz4nvgjBZTQXI9MC9fGyBlfhq/0pkbCt6yMEadn7hemiUtVsOokAp7vW1GH501oV+T4WC
 osAY/XH/szTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="149372969"
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="149372969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:44:07 -0800
IronPort-SDR: 3HSWyoqmBuMGPPs8yl+Dj+egPIPs7BqYQ6BXx49QZFpg3xFCZgeIyF0zpbrasoVJksghbJiA09
 h02KmG0Zw2dA==
X-IronPort-AV: E=Sophos;i="5.77,468,1596524400"; 
   d="scan'208";a="360414807"
Received: from hccoutan-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.131.159])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 21:44:06 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>
Subject: [RFC PATCH 6/9] cxl/mem: Initialize the mailbox interface
Date:   Tue, 10 Nov 2020 21:43:53 -0800
Message-Id: <20201111054356.793390-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111054356.793390-1-ben.widawsky@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide enough functionality to utilize the mailbox of a memory device.
The mailbox is used to interact with the firmware running on the memory
device.

The CXL specification defines separate capabilities for the mailbox and the
memory device. While we can confirm the mailbox is ready, in order to actually
interact with the memory device, the driver must also confirm the device's
firmware is ready.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h | 28 ++++++++++++++++++++++
 drivers/cxl/mem.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 02858ae63d6d..482fc9cdc890 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -19,14 +19,41 @@
 #define CXLDEV_MB_CAPS 0x00
 #define   CXLDEV_MB_CAP_PAYLOAD_SIZE(cap) ((cap) & 0x1F)
 #define CXLDEV_MB_CTRL 0x04
+#define   CXLDEV_MB_CTRL_DOORBELL BIT(0)
 #define CXLDEV_MB_CMD 0x08
 #define CXLDEV_MB_STATUS 0x10
 #define CXLDEV_MB_BG_CMD_STATUS 0x18
 
+/* Memory Device */
+#define CXLMDEV_STATUS 0
+#define CXLMDEV_DEV_FATAL BIT(0)
+#define CXLMDEV_FW_HALT BIT(1)
+#define CXLMDEV_MEDIA_STATUS_SHIFT 2
+#define CXLMDEV_MEDIA_STATUS_MASK 0x3
+#define CXLMDEV_READY(status)                                                  \
+	((((status) >> CXLMDEV_MEDIA_STATUS_SHIFT) &                           \
+	  CXLMDEV_MEDIA_STATUS_MASK) == CXLMDEV_MS_READY)
+#define CXLMDEV_MS_NOT_READY 0
+#define CXLMDEV_MS_READY 1
+#define CXLMDEV_MS_ERROR 2
+#define CXLMDEV_MS_DISABLED 3
+#define CXLMDEV_MBOX_IF_READY BIT(4)
+#define CXLMDEV_RESET_NEEDED_SHIFT 5
+#define CXLMDEV_RESET_NEEDED_MASK 0x7
+#define CXLMDEV_RESET_NEEDED(status)                                           \
+	(((status) >> CXLMDEV_RESET_NEEDED_SHIFT) & CXLMDEV_RESET_NEEDED_MASK)
+#define CXLMDEV_RESET_NEEDED_NOT 0
+#define CXLMDEV_RESET_NEEDED_COLD 1
+#define CXLMDEV_RESET_NEEDED_WARM 2
+#define CXLMDEV_RESET_NEEDED_HOT 3
+#define CXLMDEV_RESET_NEEDED_CXL 4
+
 struct cxl_mem {
 	struct pci_dev *pdev;
 	void __iomem *regs;
 
+	spinlock_t mbox_lock; /* Protects device mailbox and firmware */
+
 	/* Cap 0000h */
 	struct {
 		void __iomem *regs;
@@ -72,6 +99,7 @@ struct cxl_mem {
 
 cxl_reg(status)
 cxl_reg(mbox)
+cxl_reg(mem)
 
 static inline u32 __cxl_raw_read_reg32(struct cxl_mem *cxlm, u32 reg)
 {
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 4109ef7c3ecb..9fd2d1daa534 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -7,6 +7,56 @@
 #include "pci.h"
 #include "cxl.h"
 
+static int cxl_mem_mbox_get(struct cxl_mem *cxlm)
+{
+	u64 md_status;
+	u32 ctrl;
+	int rc = -EBUSY;
+
+	spin_lock(&cxlm->mbox_lock);
+
+	ctrl = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CTRL);
+	if (ctrl & CXLDEV_MB_CTRL_DOORBELL)
+		goto out;
+
+	md_status = cxl_read_mem_reg64(cxlm, CXLMDEV_STATUS);
+	if (md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status)) {
+		/*
+		 * Hardware shouldn't allow a ready status but also have failure
+		 * bits set. Spit out an error, this should be a bug report
+		 */
+		if (md_status & CXLMDEV_DEV_FATAL) {
+			dev_err(&cxlm->pdev->dev,
+				"CXL device reporting ready and fatal\n");
+			rc = -EFAULT;
+			goto out;
+		}
+		if (md_status & CXLMDEV_FW_HALT) {
+			dev_err(&cxlm->pdev->dev,
+				"CXL device reporting ready and halted\n");
+			rc = -EFAULT;
+			goto out;
+		}
+		if (CXLMDEV_RESET_NEEDED(md_status)) {
+			dev_err(&cxlm->pdev->dev,
+				"CXL device reporting ready and reset needed\n");
+			rc = -EFAULT;
+			goto out;
+		}
+
+		return 0;
+	}
+
+out:
+	spin_unlock(&cxlm->mbox_lock);
+	return rc;
+}
+
+static void cxl_mem_mbox_put(struct cxl_mem *cxlm)
+{
+	spin_unlock(&cxlm->mbox_lock);
+}
+
 static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 {
 	u64 cap_array;
@@ -88,6 +138,8 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo, u32 reg_
 		return ERR_PTR(-ENOMEM);
 	}
 
+	spin_lock_init(&cxlm->mbox_lock);
+
 	regs = pcim_iomap_table(pdev)[bar];
 	cxlm->pdev = pdev;
 	cxlm->regs = regs + offset;
@@ -160,6 +212,13 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	/* Check that hardware "looks" okay. */
+	rc = cxl_mem_mbox_get(cxlm);
+	if (rc)
+		return rc;
+
+	cxl_mem_mbox_put(cxlm);
+	dev_dbg(&pdev->dev, "CXL Memory Device Interface Up\n");
 	pci_set_drvdata(pdev, cxlm);
 
 	return 0;
-- 
2.29.2

