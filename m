Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF4541645F
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 19:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242546AbhIWR21 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 13:28:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:47619 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242542AbhIWR20 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Sep 2021 13:28:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211144811"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="211144811"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 10:26:54 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="704832540"
Received: from unknown (HELO bad-guy.kumite) ([10.252.132.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 10:26:54 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/9] cxl/pci: Refactor cxl_pci_setup_regs
Date:   Thu, 23 Sep 2021 10:26:42 -0700
Message-Id: <20210923172647.72738-5-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923172647.72738-1-ben.widawsky@intel.com>
References: <20210923172647.72738-1-ben.widawsky@intel.com>
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
Changes since v1:
---
 drivers/cxl/pci.c | 126 +++++++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 56 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7256c236fdb3..bbbacbc94fbf 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -428,6 +428,45 @@ static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
 	*reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
 }
 
+static int find_register_block(struct pci_dev *pdev, enum cxl_regloc_type type,
+			       struct cxl_register_map *map)
+{
+	int regloc, i, rc = -ENODEV;
+	u32 regloc_size, regblocks;
+
+	regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
+	if (!regloc)
+		return -ENXIO;
+
+	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
+	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
+
+	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
+	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
+
+	for (i = 0; i < regblocks; i++, regloc += 8) {
+		u32 reg_lo, reg_hi;
+		u8 reg_type, bar;
+		u64 offset;
+
+		pci_read_config_dword(pdev, regloc, &reg_lo);
+		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
+
+		cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
+					  &reg_type);
+
+		if (reg_type == type) {
+			map->barno = bar;
+			map->block_offset = offset;
+			map->reg_type = reg_type;
+			rc = 0;
+			break;
+		}
+	}
+
+	return rc;
+}
+
 /**
  * cxl_pci_setup_regs() - Setup necessary MMIO.
  * @cxlm: The CXL memory device to communicate with.
@@ -440,69 +479,44 @@ static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
  */
 static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 {
-	void __iomem *base;
-	u32 regloc_size, regblocks;
-	int regloc, i, n_maps, ret = 0;
+	int rc, i;
 	struct device *dev = cxlm->dev;
 	struct pci_dev *pdev = to_pci_dev(dev);
-	struct cxl_register_map *map, maps[CXL_REGLOC_RBI_TYPES];
+	const enum cxl_regloc_type types[] = { CXL_REGLOC_RBI_MEMDEV,
+					       CXL_REGLOC_RBI_COMPONENT };
 
-	regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
-	if (!regloc) {
-		dev_err(dev, "register location dvsec not found\n");
-		return -ENXIO;
-	}
+	for (i = 0; i < ARRAY_SIZE(types); i++) {
+		struct cxl_register_map map;
+		void __iomem *base;
 
-	/* Get the size of the Register Locator DVSEC */
-	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
-	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
-
-	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
-	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
-
-	for (i = 0, n_maps = 0; i < regblocks; i++, regloc += 8) {
-		u32 reg_lo, reg_hi;
-		u8 reg_type;
-		u64 offset;
-		u8 bar;
-
-		pci_read_config_dword(pdev, regloc, &reg_lo);
-		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
-
-		cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
-					  &reg_type);
-
-		/* Ignore unknown register block types */
-		if (reg_type > CXL_REGLOC_RBI_MEMDEV)
-			continue;
-
-		base = cxl_pci_map_regblock(cxlm, bar, offset);
-		if (!base)
-			return -ENOMEM;
-
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
-		if (ret)
-			return ret;
-
-		n_maps++;
-	}
-
-	for (i = 0; i < n_maps; i++) {
-		ret = cxl_map_regs(cxlm, &maps[i]);
-		if (ret)
+		rc = find_register_block(pdev, types[i], &map);
+		if (rc) {
+			dev_err(dev, "Couldn't find %s register block\n",
+				types[i] == CXL_REGLOC_RBI_MEMDEV ?
+					      "device" :
+					      "component");
 			break;
+		}
+
+		base = cxl_pci_map_regblock(cxlm, map.barno, map.block_offset);
+		if (!base) {
+			rc = -ENOMEM;
+			break;
+		}
+
+		rc = cxl_probe_regs(cxlm, base + map.block_offset, &map);
+		cxl_pci_unmap_regblock(cxlm, base);
+		if (rc)
+			break;
+
+		rc = cxl_map_regs(cxlm, &map);
+		if (rc) {
+			dev_err(dev, "Failed to map CXL registers\n");
+			break;
+		}
 	}
 
-	return ret;
+	return rc;
 }
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.33.0

