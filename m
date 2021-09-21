Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A64413D47
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 00:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbhIUWGg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 18:06:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:40128 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235890AbhIUWGf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Sep 2021 18:06:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="223119128"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="223119128"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:05 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="557114670"
Received: from ksankar-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.132.1])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:05 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 3/7] cxl/pci: Refactor cxl_pci_setup_regs
Date:   Tue, 21 Sep 2021 15:04:55 -0700
Message-Id: <20210921220459.2437386-4-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921220459.2437386-1-ben.widawsky@intel.com>
References: <20210921220459.2437386-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for moving parts of register mapping to cxl_core, the
cxl_pci driver is refactored to utilize a new helper to find register
blocks by type.

cxl_pci scanned through all register blocks and mapping the ones that
the driver will use. This logic is inverted so that the driver
specifically requests the register blocks from a new helper. Under the
hood, the same implementation of scanning through all register locator
DVSEC entries exists.

There are 2 behavioral changes (#2 is arguable):
1. A dev_err is introduced if cxl_map_regs fails.
2. The previous logic would try to map component registers and device
   registers multiple times if there were present and keep the mapping
   of the last one found (furthest offset in the register locator).
   While this is disallowed in the spec, CXL 2.0 8.1.9: "Each register
   block identifier shall only occur once in the Register Locator DVSEC
   structure" it was how the driver would respond to the spec violation.
   The new logic will take the first found register block by type and
   move on.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 113 ++++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 48 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ccc7c2573ddc..6e5c026f5262 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -428,46 +428,28 @@ static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
 	*reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
 }
 
-/**
- * cxl_pci_setup_regs() - Setup necessary MMIO.
- * @cxlm: The CXL memory device to communicate with.
- *
- * Return: 0 if all necessary registers mapped.
- *
- * A memory device is required by spec to implement a certain set of MMIO
- * regions. The purpose of this function is to enumerate and map those
- * registers.
- */
-static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
+static int find_register_block(struct pci_dev *pdev, enum cxl_regloc_type type,
+			       struct cxl_register_map *map)
 {
-	void __iomem *base;
+	int regloc, i, rc = -ENODEV;
 	u32 regloc_size, regblocks;
-	int regloc, i, n_maps, ret = 0;
-	struct device *dev = cxlm->dev;
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct cxl_register_map *map, maps[CXL_REGLOC_RBI_TYPES];
+
+	memset(map, 0, sizeof(*map));
 
 	regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
-	if (!regloc) {
-		dev_err(dev, "register location dvsec not found\n");
+	if (!regloc)
 		return -ENXIO;
-	}
-
-	if (pci_request_mem_regions(pdev, pci_name(pdev)))
-		return -ENODEV;
 
-	/* Get the size of the Register Locator DVSEC */
 	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
 	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
 
 	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
 	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
 
-	for (i = 0, n_maps = 0; i < regblocks; i++, regloc += 8) {
+	for (i = 0; i < regblocks; i++, regloc += 8) {
 		u32 reg_lo, reg_hi;
-		u8 reg_type;
+		u8 reg_type, bar;
 		u64 offset;
-		u8 bar;
 
 		pci_read_config_dword(pdev, regloc, &reg_lo);
 		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
@@ -475,39 +457,74 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 		cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
 					  &reg_type);
 
-		/* Ignore unknown register block types */
-		if (reg_type > CXL_REGLOC_RBI_MEMDEV)
-			continue;
+		if (reg_type == type) {
+			map->barno = bar;
+			map->block_offset = offset;
+			map->reg_type = reg_type;
+			rc = 0;
+			break;
+		}
+	}
 
-		base = cxl_pci_map_regblock(cxlm, bar, offset);
-		if (!base)
-			return -ENOMEM;
+	pci_release_mem_regions(pdev);
 
-		map = &maps[n_maps];
-		map->barno = bar;
-		map->block_offset = offset;
-		map->reg_type = reg_type;
+	return rc;
+}
 
-		ret = cxl_probe_regs(cxlm, base + offset, map);
+/**
+ * cxl_pci_setup_regs() - Setup necessary MMIO.
+ * @cxlm: The CXL memory device to communicate with.
+ *
+ * Return: 0 if all necessary registers mapped.
+ *
+ * A memory device is required by spec to implement a certain set of MMIO
+ * regions. The purpose of this function is to enumerate and map those
+ * registers.
+ */
+static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
+{
+	int rc, i;
+	struct device *dev = cxlm->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	const enum cxl_regloc_type types[] = { CXL_REGLOC_RBI_MEMDEV,
+					       CXL_REGLOC_RBI_COMPONENT };
 
-		/* Always unmap the regblock regardless of probe success */
-		cxl_pci_unmap_regblock(cxlm, base);
+	if (pci_request_mem_regions(pdev, pci_name(pdev)))
+		return -ENODEV;
 
-		if (ret)
-			return ret;
+	for (i = 0; i < ARRAY_SIZE(types); i++) {
+		struct cxl_register_map map;
+		void __iomem *base;
 
-		n_maps++;
-	}
+		rc = find_register_block(pdev, types[i], &map);
+		if (rc) {
+			dev_err(dev, "Couldn't find %s register block\n",
+				types[i] == CXL_REGLOC_RBI_MEMDEV ?
+					      "device" :
+					      "component");
+			break;
+		}
 
-	pci_release_mem_regions(pdev);
+		base = cxl_pci_map_regblock(cxlm, map.barno, map.block_offset);
+		if (!base) {
+			rc = -ENOMEM;
+			break;
+		}
 
-	for (i = 0; i < n_maps; i++) {
-		ret = cxl_map_regs(cxlm, &maps[i]);
-		if (ret)
+		rc = cxl_probe_regs(cxlm, base + map.block_offset, &map);
+		cxl_pci_unmap_regblock(cxlm, base);
+		if (rc)
+			break;
+
+		rc = cxl_map_regs(cxlm, &map);
+		if (rc) {
+			dev_err(dev, "Failed to map CXL registers\n");
 			break;
+		}
 	}
 
-	return ret;
+	pci_release_mem_regions(pdev);
+	return rc;
 }
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.33.0

