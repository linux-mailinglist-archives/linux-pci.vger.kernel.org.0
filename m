Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43173577A6
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 00:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhDGW1G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 18:27:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:14309 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229657AbhDGW06 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 18:26:58 -0400
IronPort-SDR: fHHpqEZiczKjV2oBkqp2/ZbL/oqW7ZTdjhdGd8UH2U5NBUytZoB1AkfRPwJXvV8cUNRoM39Xvi
 0IaL3QnizFaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193524928"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="193524928"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:39 -0700
IronPort-SDR: pClVTSlqwwacSc9z/awTDGKWaVz1hLuOS38qdfm6o+pAZ1fUWlleqahXU628TVhmTUVKmm66Ja
 cY9IRoQRsOIQ==
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="458548538"
Received: from hmfaraby-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.128.243])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:39 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] cxl/mem: Move register locator logic into reg setup
Date:   Wed,  7 Apr 2021 15:26:21 -0700
Message-Id: <20210407222625.320177-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407222625.320177-1-ben.widawsky@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Start moving code around to ultimately get rid of @cxlm.base. The
@cxlm.base member serves no purpose other than intermediate storage of
the offset found in cxl_mem_map_regblock() later used by
cxl_mem_setup_regs(). Aside from wanting to get rid of this useless
member, it will help later when adding new register block identifiers.

While @cxlm.base still exists, it will become trivial to remove it in a
future patch.

No functional change is meant to be introduced in this patch.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 135 +++++++++++++++++++++++-----------------------
 1 file changed, 68 insertions(+), 67 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 520edaf233d4..04b4f7445083 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -870,34 +870,6 @@ static int cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm, u16 opcode,
 	return 0;
 }
 
-/**
- * cxl_mem_setup_regs() - Setup necessary MMIO.
- * @cxlm: The CXL memory device to communicate with.
- *
- * Return: 0 if all necessary registers mapped.
- *
- * A memory device is required by spec to implement a certain set of MMIO
- * regions. The purpose of this function is to enumerate and map those
- * registers.
- */
-static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
-{
-	struct device *dev = &cxlm->pdev->dev;
-	struct cxl_regs *regs = &cxlm->regs;
-
-	cxl_setup_device_regs(dev, cxlm->base, &regs->device_regs);
-
-	if (!regs->status || !regs->mbox || !regs->memdev) {
-		dev_err(dev, "registers not found: %s%s%s\n",
-			!regs->status ? "status " : "",
-			!regs->mbox ? "mbox " : "",
-			!regs->memdev ? "memdev" : "");
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
 static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
 {
 	const int cap = readl(cxlm->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
@@ -1005,6 +977,73 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
+/**
+ * cxl_mem_setup_regs() - Setup necessary MMIO.
+ * @cxlm: The CXL memory device to communicate with.
+ *
+ * Return: 0 if all necessary registers mapped.
+ *
+ * A memory device is required by spec to implement a certain set of MMIO
+ * regions. The purpose of this function is to enumerate and map those
+ * registers.
+ */
+static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
+{
+	struct cxl_regs *regs = &cxlm->regs;
+	struct pci_dev *pdev = cxlm->pdev;
+	struct device *dev = &pdev->dev;
+	u32 regloc_size, regblocks;
+	int rc, regloc, i;
+
+	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
+	if (!regloc) {
+		dev_err(dev, "register location dvsec not found\n");
+		return -ENXIO;
+	}
+
+	/* Get the size of the Register Locator DVSEC */
+	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
+	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
+
+	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
+	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
+
+	for (i = 0; i < regblocks; i++, regloc += 8) {
+		u32 reg_lo, reg_hi;
+		u8 reg_type;
+
+		/* "register low and high" contain other bits */
+		pci_read_config_dword(pdev, regloc, &reg_lo);
+		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
+
+		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
+
+		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
+			rc = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
+			if (rc)
+				return rc;
+			break;
+		}
+	}
+
+	if (i == regblocks) {
+		dev_err(dev, "Missing register locator for device registers\n");
+		return -ENXIO;
+	}
+
+	cxl_setup_device_regs(dev, cxlm->base, &regs->device_regs);
+
+	if (!regs->status || !regs->mbox || !regs->memdev) {
+		dev_err(dev, "registers not found: %s%s%s\n",
+			!regs->status ? "status " : "",
+			!regs->mbox ? "mbox " : "",
+			!regs->memdev ? "memdev" : "");
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
 static struct cxl_memdev *to_cxl_memdev(struct device *dev)
 {
 	return container_of(dev, struct cxl_memdev, dev);
@@ -1410,10 +1449,8 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
 
 static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	struct device *dev = &pdev->dev;
-	u32 regloc_size, regblocks;
 	struct cxl_mem *cxlm;
-	int rc, regloc, i;
+	int rc;
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
@@ -1423,42 +1460,6 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlm))
 		return PTR_ERR(cxlm);
 
-	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
-	if (!regloc) {
-		dev_err(dev, "register location dvsec not found\n");
-		return -ENXIO;
-	}
-
-	/* Get the size of the Register Locator DVSEC */
-	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
-	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
-
-	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
-	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
-
-	for (i = 0; i < regblocks; i++, regloc += 8) {
-		u32 reg_lo, reg_hi;
-		u8 reg_type;
-
-		/* "register low and high" contain other bits */
-		pci_read_config_dword(pdev, regloc, &reg_lo);
-		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
-
-		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
-
-		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
-			rc = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
-			if (rc)
-				return rc;
-			break;
-		}
-	}
-
-	if (i == regblocks) {
-		dev_err(dev, "Missing register locator for device registers\n");
-		return -ENXIO;
-	}
-
 	rc = cxl_mem_setup_regs(cxlm);
 	if (rc)
 		return rc;
-- 
2.31.1

