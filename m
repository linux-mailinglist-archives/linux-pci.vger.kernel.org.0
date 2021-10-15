Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556DA42FDB7
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 23:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbhJOV74 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 17:59:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:45565 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229921AbhJOV7z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 17:59:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="227947433"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="227947433"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 14:57:27 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="442664290"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 14:57:27 -0700
Subject: [PATCH v6 06/10] cxl/pci: Add @base to cxl_register_map
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 15 Oct 2021 14:57:27 -0700
Message-ID: <163433497228.889435.11271988238496181536.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163416940205.816123.10667482871687420836.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163416940205.816123.10667482871687420836.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In addition to carrying @barno, @block_offset, and @reg_type, add @base
to keep all map/unmap parameters in one object. The helpers
cxl_{map,unmap}_regblock() handle adjusting @base to the @block_offset
at map and unmap time.

Document that @base incorporates @block_offset so that downstream
consumers of a mapped cxl_register_map instance do not need perform any
fixups / can use @base directly.

Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v5:
- add kernel-doc for cxl_register_map to explain the interaction between
  @base and @block_offset. (Ira and Jonathan)

 drivers/cxl/cxl.h |   10 ++++++++++
 drivers/cxl/pci.c |   31 ++++++++++++++++---------------
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a6687e7fd598..5e2e93451928 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -139,7 +139,17 @@ struct cxl_device_reg_map {
 	struct cxl_reg_map memdev;
 };
 
+/**
+ * struct cxl_register_map - DVSEC harvested register block mapping parameters
+ * @base: virtual base of the register-block-BAR + @block_offset
+ * @block_offset: offset to start of register block in @barno
+ * @reg_type: see enum cxl_regloc_type
+ * @barno: PCI BAR number containing the register block
+ * @component_map: cxl_reg_map for component registers
+ * @device_map: cxl_reg_maps for device registers
+ */
 struct cxl_register_map {
+	void __iomem *base;
 	u64 block_offset;
 	u8 reg_type;
 	u8 barno;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index eb0c2f1b9e65..7d5e5548b316 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -306,8 +306,7 @@ static int cxl_pci_setup_mailbox(struct cxl_mem *cxlm)
 	return 0;
 }
 
-static void __iomem *cxl_pci_map_regblock(struct pci_dev *pdev,
-					  struct cxl_register_map *map)
+static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
 {
 	void __iomem *addr;
 	int bar = map->barno;
@@ -318,24 +317,27 @@ static void __iomem *cxl_pci_map_regblock(struct pci_dev *pdev,
 	if (pci_resource_len(pdev, bar) < offset) {
 		dev_err(dev, "BAR%d: %pr: too small (offset: %pa)\n", bar,
 			&pdev->resource[bar], &offset);
-		return NULL;
+		return -ENXIO;
 	}
 
 	addr = pci_iomap(pdev, bar, 0);
 	if (!addr) {
 		dev_err(dev, "failed to map registers\n");
-		return addr;
+		return -ENOMEM;
 	}
 
 	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %pa\n",
 		bar, &offset);
 
-	return addr;
+	map->base = addr + map->block_offset;
+	return 0;
 }
 
-static void cxl_pci_unmap_regblock(struct pci_dev *pdev, void __iomem *base)
+static void cxl_unmap_regblock(struct pci_dev *pdev,
+			       struct cxl_register_map *map)
 {
-	pci_iounmap(pdev, base);
+	pci_iounmap(pdev, map->base - map->block_offset);
+	map->base = NULL;
 }
 
 static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
@@ -361,12 +363,12 @@ static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
-static int cxl_probe_regs(struct pci_dev *pdev, void __iomem *base,
-			  struct cxl_register_map *map)
+static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
 	struct device *dev = &pdev->dev;
+	void __iomem *base = map->base;
 
 	switch (map->reg_type) {
 	case CXL_REGLOC_RBI_COMPONENT:
@@ -442,7 +444,6 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
  */
 static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 {
-	void __iomem *base;
 	u32 regloc_size, regblocks;
 	int regloc, i, n_maps, ret = 0;
 	struct device *dev = cxlm->dev;
@@ -475,12 +476,12 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 		if (map->reg_type > CXL_REGLOC_RBI_MEMDEV)
 			continue;
 
-		base = cxl_pci_map_regblock(pdev, map);
-		if (!base)
-			return -ENOMEM;
+		ret = cxl_map_regblock(pdev, map);
+		if (ret)
+			return ret;
 
-		ret = cxl_probe_regs(pdev, base + map->block_offset, map);
-		cxl_pci_unmap_regblock(pdev, base);
+		ret = cxl_probe_regs(pdev, map);
+		cxl_unmap_regblock(pdev, map);
 		if (ret)
 			return ret;
 

