Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF542FEAE
	for <lists+linux-pci@lfdr.de>; Sat, 16 Oct 2021 01:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243509AbhJOXcv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 19:32:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:18906 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243501AbhJOXcu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Oct 2021 19:32:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="288867325"
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="288867325"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:30:43 -0700
X-IronPort-AV: E=Sophos;i="5.85,376,1624345200"; 
   d="scan'208";a="718282802"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2021 16:30:43 -0700
Subject: [PATCH v6 07/10] cxl/pci: Split cxl_pci_setup_regs()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 15 Oct 2021 16:30:42 -0700
Message-ID: <163434053788.914258.18412599112859205220.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

In preparation for moving parts of register mapping to cxl_core, split
cxl_pci_setup_regs() into a helper that finds register blocks,
(cxl_find_regblock()), and a generic wrapper that probes the precise
register sets within a block (cxl_setup_regs()).

Move the actual mapping (cxl_map_regs()) of the only register-set that
cxl_pci cares about (memory device registers) up a level from the former
cxl_pci_setup_regs() into cxl_pci_probe().

With this change the unused component registers are no longer mapped,
but the helpers are primed to move into the core.

[djbw: drop cxl_map_regs() for component registers]

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
[djbw: rebase on the cxl_register_map refactor]
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v3:
- fixup grammar in kernel-doc for cxl_find_regblock() (Jonathan)

 drivers/cxl/pci.c |   73 +++++++++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7d5e5548b316..691a4e59ad8b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -433,72 +433,69 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
 }
 
 /**
- * cxl_pci_setup_regs() - Setup necessary MMIO.
- * @cxlm: The CXL memory device to communicate with.
+ * cxl_find_regblock() - Locate register blocks by type
+ * @pdev: The CXL PCI device to enumerate.
+ * @type: Register Block Indicator id
+ * @map: Enumeration output, clobbered on error
  *
- * Return: 0 if all necessary registers mapped.
+ * Return: 0 if register block enumerated, negative error code otherwise
  *
- * A memory device is required by spec to implement a certain set of MMIO
- * regions. The purpose of this function is to enumerate and map those
- * registers.
+ * A CXL DVSEC may point to one or more register blocks, search for them
+ * by @type.
  */
-static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
+static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+			     struct cxl_register_map *map)
 {
 	u32 regloc_size, regblocks;
-	int regloc, i, n_maps, ret = 0;
-	struct device *dev = cxlm->dev;
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct cxl_register_map *map, maps[CXL_REGLOC_RBI_TYPES];
+	int regloc, i;
 
 	regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
-	if (!regloc) {
-		dev_err(dev, "register location dvsec not found\n");
+	if (!regloc)
 		return -ENXIO;
-	}
 
-	/* Get the size of the Register Locator DVSEC */
 	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
 	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
 
 	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
 	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
 
-	for (i = 0, n_maps = 0; i < regblocks; i++, regloc += 8) {
+	for (i = 0; i < regblocks; i++, regloc += 8) {
 		u32 reg_lo, reg_hi;
 
 		pci_read_config_dword(pdev, regloc, &reg_lo);
 		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
 
-		map = &maps[n_maps];
 		cxl_decode_regblock(reg_lo, reg_hi, map);
 
-		/* Ignore unknown register block types */
-		if (map->reg_type > CXL_REGLOC_RBI_MEMDEV)
-			continue;
+		if (map->reg_type == type)
+			return 0;
+	}
 
-		ret = cxl_map_regblock(pdev, map);
-		if (ret)
-			return ret;
+	return -ENODEV;
+}
 
-		ret = cxl_probe_regs(pdev, map);
-		cxl_unmap_regblock(pdev, map);
-		if (ret)
-			return ret;
+static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
+			  struct cxl_register_map *map)
+{
+	int rc;
 
-		n_maps++;
-	}
+	rc = cxl_find_regblock(pdev, type, map);
+	if (rc)
+		return rc;
 
-	for (i = 0; i < n_maps; i++) {
-		ret = cxl_map_regs(cxlm, &maps[i]);
-		if (ret)
-			break;
-	}
+	rc = cxl_map_regblock(pdev, map);
+	if (rc)
+		return rc;
+
+	rc = cxl_probe_regs(pdev, map);
+	cxl_unmap_regblock(pdev, map);
 
-	return ret;
+	return rc;
 }
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
+	struct cxl_register_map map;
 	struct cxl_memdev *cxlmd;
 	struct cxl_mem *cxlm;
 	int rc;
@@ -518,7 +515,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlm))
 		return PTR_ERR(cxlm);
 
-	rc = cxl_pci_setup_regs(cxlm);
+	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
+	if (rc)
+		return rc;
+
+	rc = cxl_map_regs(cxlm, &map);
 	if (rc)
 		return rc;
 

