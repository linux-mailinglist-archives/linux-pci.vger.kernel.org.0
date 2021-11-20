Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65844579E0
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbhKTAGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:10 -0500
Received: from mga12.intel.com ([192.55.52.136]:5724 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231298AbhKTAGH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542393"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542393"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:55 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088333"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:55 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 02/23] cxl: Flesh out register names
Date:   Fri, 19 Nov 2021 16:02:29 -0800
Message-Id: <20211120000250.1663391-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Get a better naming scheme in place for upcoming additions.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
Changes since RFCv2:
Use some abbreviations (Jonathan)
Prefix everything with CXL (Jonathan)
Remove new additions (Dan)

Original discussion motivating this occurred here:
https://lore.kernel.org/linux-pci/20210913190131.xiiszmno46qie7v5@intel.com/
---
 drivers/cxl/pci.c | 14 +++++++-------
 drivers/cxl/pci.h | 19 ++++++++++---------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8dc91fd3396a..a6ea9811a05b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -403,10 +403,10 @@ static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *ma
 static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
 				struct cxl_register_map *map)
 {
-	map->block_offset =
-		((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
-	map->barno = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
-	map->reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
+	map->block_offset = ((u64)reg_hi << 32) |
+			    (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
+	map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
+	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
 }
 
 /**
@@ -427,15 +427,15 @@ static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 	int regloc, i;
 
 	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
-					   PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
+					   CXL_DVSEC_REG_LOCATOR);
 	if (!regloc)
 		return -ENXIO;
 
 	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
 	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
 
-	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
-	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
+	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
+	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
 
 	for (i = 0; i < regblocks; i++, regloc += 8) {
 		u32 reg_lo, reg_hi;
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 7d3e4bf06b45..29b8eaef3a0a 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -7,17 +7,21 @@
 
 /*
  * See section 8.1 Configuration Space Registers in the CXL 2.0
- * Specification
+ * Specification. Names are taken straight from the specification with "CXL" and
+ * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
  */
 #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
 #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
-#define PCI_DVSEC_ID_CXL		0x0
 
-#define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8
-#define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
+/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
+#define CXL_DVSEC_PCIE_DEVICE					0
 
-/* BAR Indicator Register (BIR) */
-#define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
+/* CXL 2.0 8.1.9: Register Locator DVSEC */
+#define CXL_DVSEC_REG_LOCATOR					8
+#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
+#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
+#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
+#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
 
 /* Register Block Identifier (RBI) */
 enum cxl_regloc_type {
@@ -28,7 +32,4 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_TYPES
 };
 
-#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
-#define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
-
 #endif /* __CXL_PCI_H__ */
-- 
2.34.0

