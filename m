Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE142CF50
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 01:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhJMXze (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 19:55:34 -0400
Received: from mga02.intel.com ([134.134.136.20]:42541 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229575AbhJMXzd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 19:55:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10136"; a="214721456"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="214721456"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 16:53:29 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; 
   d="scan'208";a="442497745"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2021 16:53:29 -0700
Subject: [PATCH v5 05/10] cxl/pci: Make more use of cxl_register_map
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        kernel test robot <lkp@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Oct 2021 16:53:29 -0700
Message-ID: <163416901172.806743.10056306321247850914.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163381262522.716926.15040239940531720280.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163381262522.716926.15040239940531720280.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

The structure exists to pass around information about register mapping.
Use it for passing @barno and @block_offset, and eliminate duplicate
local variables.

The helpers that use @map do not care about @cxlm, so just pass them a
pdev instead.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
[djbw: separate @base conversion]
[djbw: reorder before cxl_pci_setup_regs() refactor to improver readability]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v4:
- Collect Ira's reviewed-by, thanks Ira!
- Fixup the dev_err() in cxl_pci_map_regblock() to use %pa just like the
  same fixup in v3 of the warning introduced by changing @offset from u64 to
  resource_size_t. 

 drivers/cxl/pci.c |   59 ++++++++++++++++++++++-------------------------------
 1 file changed, 25 insertions(+), 34 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 21dd10a77eb3..eb0c2f1b9e65 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -306,17 +306,18 @@ static int cxl_pci_setup_mailbox(struct cxl_mem *cxlm)
 	return 0;
 }
 
-static void __iomem *cxl_pci_map_regblock(struct cxl_mem *cxlm,
-					  u8 bar, u64 offset)
+static void __iomem *cxl_pci_map_regblock(struct pci_dev *pdev,
+					  struct cxl_register_map *map)
 {
 	void __iomem *addr;
-	struct device *dev = cxlm->dev;
-	struct pci_dev *pdev = to_pci_dev(dev);
+	int bar = map->barno;
+	struct device *dev = &pdev->dev;
+	resource_size_t offset = map->block_offset;
 
 	/* Basic sanity check that BAR is big enough */
 	if (pci_resource_len(pdev, bar) < offset) {
-		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
-			&pdev->resource[bar], (unsigned long long)offset);
+		dev_err(dev, "BAR%d: %pr: too small (offset: %pa)\n", bar,
+			&pdev->resource[bar], &offset);
 		return NULL;
 	}
 
@@ -326,15 +327,15 @@ static void __iomem *cxl_pci_map_regblock(struct cxl_mem *cxlm,
 		return addr;
 	}
 
-	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %#llx\n",
-		bar, offset);
+	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %pa\n",
+		bar, &offset);
 
 	return addr;
 }
 
-static void cxl_pci_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
+static void cxl_pci_unmap_regblock(struct pci_dev *pdev, void __iomem *base)
 {
-	pci_iounmap(to_pci_dev(cxlm->dev), base);
+	pci_iounmap(pdev, base);
 }
 
 static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
@@ -360,12 +361,12 @@ static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
 	return 0;
 }
 
-static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
+static int cxl_probe_regs(struct pci_dev *pdev, void __iomem *base,
 			  struct cxl_register_map *map)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
-	struct device *dev = cxlm->dev;
+	struct device *dev = &pdev->dev;
 
 	switch (map->reg_type) {
 	case CXL_REGLOC_RBI_COMPONENT:
@@ -420,12 +421,13 @@ static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
 	return 0;
 }
 
-static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
-				      u8 *bar, u64 *offset, u8 *reg_type)
+static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
+				struct cxl_register_map *map)
 {
-	*offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
-	*bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
-	*reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
+	map->block_offset =
+		((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
+	map->barno = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
+	map->reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
 }
 
 /**
@@ -462,34 +464,23 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 
 	for (i = 0, n_maps = 0; i < regblocks; i++, regloc += 8) {
 		u32 reg_lo, reg_hi;
-		u8 reg_type;
-		u64 offset;
-		u8 bar;
 
 		pci_read_config_dword(pdev, regloc, &reg_lo);
 		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
 
-		cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
-					  &reg_type);
+		map = &maps[n_maps];
+		cxl_decode_regblock(reg_lo, reg_hi, map);
 
 		/* Ignore unknown register block types */
-		if (reg_type > CXL_REGLOC_RBI_MEMDEV)
+		if (map->reg_type > CXL_REGLOC_RBI_MEMDEV)
 			continue;
 
-		base = cxl_pci_map_regblock(cxlm, bar, offset);
+		base = cxl_pci_map_regblock(pdev, map);
 		if (!base)
 			return -ENOMEM;
 
-		map = &maps[n_maps];
-		map->barno = bar;
-		map->block_offset = offset;
-		map->reg_type = reg_type;
-
-		ret = cxl_probe_regs(cxlm, base + offset, map);
-
-		/* Always unmap the regblock regardless of probe success */
-		cxl_pci_unmap_regblock(cxlm, base);
-
+		ret = cxl_probe_regs(pdev, base + map->block_offset, map);
+		cxl_pci_unmap_regblock(pdev, base);
 		if (ret)
 			return ret;
 

