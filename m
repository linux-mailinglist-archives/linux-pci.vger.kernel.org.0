Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1093577A4
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 00:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhDGW1G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 18:27:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:14310 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhDGW0w (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Apr 2021 18:26:52 -0400
IronPort-SDR: eTJBf6Jmz2/s8bY+l5JbH4iCGBzRNnAiZXwO7C4/jLAHswc0YvfCHsfKV96uMfZXBMJKcMOwOt
 YSsosqA7YXFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="193524917"
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="193524917"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:39 -0700
IronPort-SDR: TcfA77NmEoYkSd3GGFafs/dTMmDQ1a3NKWYAZoXuKOITlN0qRLpYjzzaghOz8o3cBWwOXV51iy
 q0I05IKpm7CA==
X-IronPort-AV: E=Sophos;i="5.82,204,1613462400"; 
   d="scan'208";a="458548533"
Received: from hmfaraby-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.128.243])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 15:26:38 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] cxl/mem: Split creation from mapping in probe
Date:   Wed,  7 Apr 2021 15:26:20 -0700
Message-Id: <20210407222625.320177-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407222625.320177-1-ben.widawsky@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a new function specifically for mapping the register blocks and
offsets within. The new function can be used more generically for other
register block identifiers.

No functional change is meant to be introduced in this patch with the
exception of a dev_err printed when the device register block isn't
found.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 64 +++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 24 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 99534260034e..520edaf233d4 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -925,22 +925,40 @@ static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
 	return 0;
 }
 
-static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
-				      u32 reg_hi)
+static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct cxl_mem *cxlm;
-	void __iomem *regs;
-	u64 offset;
-	u8 bar;
-	int rc;
 
 	cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
 	if (!cxlm) {
 		dev_err(dev, "No memory available\n");
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+	}
+
+	mutex_init(&cxlm->mbox_mutex);
+	cxlm->pdev = pdev;
+	cxlm->enabled_cmds =
+		devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
+				   sizeof(unsigned long),
+				   GFP_KERNEL | __GFP_ZERO);
+	if (!cxlm->enabled_cmds) {
+		dev_err(dev, "No memory available for bitmap\n");
+		return ERR_PTR(-ENOMEM);
 	}
 
+	return cxlm;
+}
+
+static int cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
+{
+	struct pci_dev *pdev = cxlm->pdev;
+	struct device *dev = &pdev->dev;
+	void __iomem *regs;
+	u64 offset;
+	u8 bar;
+	int rc;
+
 	offset = ((u64)reg_hi << 32) | FIELD_GET(CXL_REGLOC_ADDR_MASK, reg_lo);
 	bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
 
@@ -948,30 +966,20 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 	if (pci_resource_len(pdev, bar) < offset) {
 		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
 			&pdev->resource[bar], (unsigned long long)offset);
-		return NULL;
+		return -ENXIO;
 	}
 
 	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
 	if (rc) {
 		dev_err(dev, "failed to map registers\n");
-		return NULL;
+		return rc;
 	}
 	regs = pcim_iomap_table(pdev)[bar];
 
-	mutex_init(&cxlm->mbox_mutex);
-	cxlm->pdev = pdev;
 	cxlm->base = regs + offset;
-	cxlm->enabled_cmds =
-		devm_kmalloc_array(dev, BITS_TO_LONGS(cxl_cmd_count),
-				   sizeof(unsigned long),
-				   GFP_KERNEL | __GFP_ZERO);
-	if (!cxlm->enabled_cmds) {
-		dev_err(dev, "No memory available for bitmap\n");
-		return NULL;
-	}
 
 	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
-	return cxlm;
+	return 0;
 }
 
 static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
@@ -1403,14 +1411,18 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
 static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct device *dev = &pdev->dev;
-	struct cxl_mem *cxlm = NULL;
 	u32 regloc_size, regblocks;
+	struct cxl_mem *cxlm;
 	int rc, regloc, i;
 
 	rc = pcim_enable_device(pdev);
 	if (rc)
 		return rc;
 
+	cxlm = cxl_mem_create(pdev);
+	if (IS_ERR(cxlm))
+		return PTR_ERR(cxlm);
+
 	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
 	if (!regloc) {
 		dev_err(dev, "register location dvsec not found\n");
@@ -1435,13 +1447,17 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
 
 		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
-			cxlm = cxl_mem_create(pdev, reg_lo, reg_hi);
+			rc = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
+			if (rc)
+				return rc;
 			break;
 		}
 	}
 
-	if (!cxlm)
-		return -ENODEV;
+	if (i == regblocks) {
+		dev_err(dev, "Missing register locator for device registers\n");
+		return -ENXIO;
+	}
 
 	rc = cxl_mem_setup_regs(cxlm);
 	if (rc)
-- 
2.31.1

