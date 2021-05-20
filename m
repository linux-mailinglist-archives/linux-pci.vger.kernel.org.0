Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D15838B8F8
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 23:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhETVbW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 17:31:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:58916 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhETVbW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 May 2021 17:31:22 -0400
IronPort-SDR: AFGR07yVlOPhprIkwDyUzOSZN44IZ7y8Kl7Re4Si8HyxnbMN5c1tgzwq3uUWKMO9JyDFx3/N0e
 uo9Z3yE2+pSw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="286874974"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="286874974"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 14:29:59 -0700
IronPort-SDR: ZiQfpTc4Xd8/VVRq09t21Ofjk5TBre0u+LyF/RUujFwgDVpbqdhXlwekh5MTB/TJrUpNmIoUsw
 pNQmQCO0J3AA==
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; 
   d="scan'208";a="395853393"
Received: from santoshi-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.11])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2021 14:29:59 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>
Subject: [PATCH v2 4/7] cxl/mem: Get rid of @cxlm.base
Date:   Thu, 20 May 2021 14:29:53 -0700
Message-Id: <20210520212953.1181695-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210413161726.tz7rg46krrekk3lp@intel.com>
References: <20210413161726.tz7rg46krrekk3lp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

@cxlm.base only existed to support holding the base found in the
register block mapping code, and pass it along to the register setup
code. Now that the register setup function has all logic around managing
the registers, from DVSEC to iomapping up to populating our CXL specific
information, it is easy to turn the @base values into local variables
and remove them from our device driver state.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.h |  2 --
 drivers/cxl/pci.c | 24 +++++++++++-------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 23fc40dde27e..13868ff7cadf 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -49,7 +49,6 @@ struct cxl_memdev {
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
- * @base: IO mappings to the device's MMIO
  * @cxlmd: Logical memory device chardev / interface
  * @regs: Parsed register blocks
  * @payload_size: Size of space for payload
@@ -64,7 +63,6 @@ struct cxl_memdev {
  */
 struct cxl_mem {
 	struct pci_dev *pdev;
-	void __iomem *base;
 	struct cxl_memdev *cxlmd;
 
 	struct cxl_regs regs;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 285a898a0867..d47258e51563 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -941,11 +941,10 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev)
 	return cxlm;
 }
 
-static int cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
+static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
 {
 	struct pci_dev *pdev = cxlm->pdev;
 	struct device *dev = &pdev->dev;
-	void __iomem *regs;
 	u64 offset;
 	u8 bar;
 	int rc;
@@ -957,20 +956,18 @@ static int cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
 	if (pci_resource_len(pdev, bar) < offset) {
 		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
 			&pdev->resource[bar], (unsigned long long)offset);
-		return -ENXIO;
+		return IOMEM_ERR_PTR(-ENXIO);
 	}
 
 	rc = pcim_iomap_regions(pdev, BIT(bar), pci_name(pdev));
 	if (rc) {
 		dev_err(dev, "failed to map registers\n");
-		return rc;
+		return IOMEM_ERR_PTR(rc);
 	}
-	regs = pcim_iomap_table(pdev)[bar];
-
-	cxlm->base = regs + offset;
 
 	dev_dbg(dev, "Mapped CXL Memory Device resource\n");
-	return 0;
+
+	return pcim_iomap_table(pdev)[bar] + offset;
 }
 
 static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
@@ -1012,7 +1009,8 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 	struct pci_dev *pdev = cxlm->pdev;
 	struct device *dev = &pdev->dev;
 	u32 regloc_size, regblocks;
-	int rc, regloc, i;
+	void __iomem *base;
+	int regloc, i;
 
 	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_OFFSET);
 	if (!regloc) {
@@ -1038,9 +1036,9 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
 
 		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
-			rc = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
-			if (rc)
-				return rc;
+			base = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
+			if (IS_ERR(base))
+				return PTR_ERR(base);
 			break;
 		}
 	}
@@ -1050,7 +1048,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 		return -ENXIO;
 	}
 
-	cxl_setup_device_regs(dev, cxlm->base, &regs->device_regs);
+	cxl_setup_device_regs(dev, base, &regs->device_regs);
 
 	if (!regs->status || !regs->mbox || !regs->memdev) {
 		dev_err(dev, "registers not found: %s%s%s\n",
-- 
2.31.1

