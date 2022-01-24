Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 947F449767C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbiAXA3O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:29:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:41981 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240573AbiAXA3N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:29:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984153; x=1674520153;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K9DBt5Db5DcjDasB2xvNSXT23ZOkJOvFIebYescu+0Q=;
  b=hp+TZ5L379b/KBW+bicwBm6/lIahjU5gEFT3CBnht68POVD+PJkB8zYz
   vTa8YtvqDlXVrjWH8dHU5FVEyRMj7z0n3oLmazNO3sV8UuRbvsfY2v6pi
   uenGNfz12yYXWMyTqU8sE7yezGIZuLrz3/OkuOJux9GviyyEtsps33QAm
   kz15u9K1J18ZTN8TiIM3C9GnbaVjiGWz++n63r40CfwfJ8/Vw7jrrcEaJ
   aXvubwz6rRWfQPD2X2oVesrvqfwYsg2ZfPFiqoAPO1oG11fgkiNvITDsg
   9n2oX5hSjkb08sjOLUtRJlod/kSQ1ZONen2kfC9lYkQLSFlTpgON0NFlC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244766487"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244766487"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="533999602"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:10 -0800
Subject: [PATCH v3 06/40] cxl/acpi: Map component registers for Root Ports
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:29:10 -0800
Message-ID: <164298415080.3018233.14694957480228676592.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

This implements the TODO in cxl_acpi for mapping component registers.
cxl_acpi becomes the second consumer of CXL register block enumeration
(cxl_pci being the first). Moving the functionality to cxl_core allows
both of these drivers to use the functionality. Equally importantly it
allows cxl_core to use the functionality in the future.

CXL 2.0 root ports are similar to CXL 2.0 Downstream Ports with the main
distinction being they're a part of the CXL 2.0 host bridge. While
mapping their component registers is not immediately useful for the CXL
drivers, the movement of register block enumeration into core is a vital
step towards HDM decoder programming.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
[djbw: fix cxl_regmap_to_base() failure cases]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      |   13 +++++++++--
 drivers/cxl/core/regs.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |    4 +++
 drivers/cxl/pci.c       |   52 --------------------------------------------
 drivers/cxl/pci.h       |    9 ++++++++
 5 files changed, 80 insertions(+), 54 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3163167ecc3a..c656a49a11a9 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -7,6 +7,7 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include "cxl.h"
+#include "pci.h"
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
 #define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
@@ -134,11 +135,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 
 __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
 {
+	resource_size_t creg = CXL_RESOURCE_NONE;
 	struct cxl_walk_context *ctx = data;
 	struct pci_bus *root_bus = ctx->root;
 	struct cxl_port *port = ctx->port;
 	int type = pci_pcie_type(pdev);
 	struct device *dev = ctx->dev;
+	struct cxl_register_map map;
 	u32 lnkcap, port_num;
 	int rc;
 
@@ -152,9 +155,15 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
 				  &lnkcap) != PCIBIOS_SUCCESSFUL)
 		return 0;
 
-	/* TODO walk DVSEC to find component register base */
+	/* The driver doesn't rely on component registers for Root Ports yet. */
+	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
+	if (!rc)
+		dev_info(&pdev->dev, "No component register block found\n");
+
+	creg = cxl_regmap_to_base(pdev, &map);
+
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
+	rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
 	if (rc) {
 		ctx->error = rc;
 		return rc;
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index e37e23bf4355..0d63758e2605 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
+#include <pci.h>
 
 /**
  * DOC: cxl registers
@@ -247,3 +248,58 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);
+
+static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
+				struct cxl_register_map *map)
+{
+	map->block_offset = ((u64)reg_hi << 32) |
+			    (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
+	map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
+	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
+}
+
+/**
+ * cxl_find_regblock() - Locate register blocks by type
+ * @pdev: The CXL PCI device to enumerate.
+ * @type: Register Block Indicator id
+ * @map: Enumeration output, clobbered on error
+ *
+ * Return: 0 if register block enumerated, negative error code otherwise
+ *
+ * A CXL DVSEC may point to one or more register blocks, search for them
+ * by @type.
+ */
+int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+		      struct cxl_register_map *map)
+{
+	u32 regloc_size, regblocks;
+	int regloc, i;
+
+	map->block_offset = U64_MAX;
+	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+					   CXL_DVSEC_REG_LOCATOR);
+	if (!regloc)
+		return -ENXIO;
+
+	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
+	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
+
+	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
+	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
+
+	for (i = 0; i < regblocks; i++, regloc += 8) {
+		u32 reg_lo, reg_hi;
+
+		pci_read_config_dword(pdev, regloc, &reg_lo);
+		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
+
+		cxl_decode_regblock(reg_lo, reg_hi, map);
+
+		if (map->reg_type == type)
+			return 0;
+	}
+
+	map->block_offset = U64_MAX;
+	return -ENODEV;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a5a0be3f088b..6288a6c1fc5c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -145,6 +145,10 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 			struct cxl_device_regs *regs,
 			struct cxl_register_map *map);
 
+enum cxl_regloc_type;
+int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
+		      struct cxl_register_map *map);
+
 #define CXL_RESOURCE_NONE ((resource_size_t) -1)
 #define CXL_TARGET_STRLEN 20
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1eeba0ec46f3..bdfeb92ed028 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -367,58 +367,6 @@ static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *ma
 	return 0;
 }
 
-static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
-				struct cxl_register_map *map)
-{
-	map->block_offset = ((u64)reg_hi << 32) |
-			    (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
-	map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
-	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
-}
-
-/**
- * cxl_find_regblock() - Locate register blocks by type
- * @pdev: The CXL PCI device to enumerate.
- * @type: Register Block Indicator id
- * @map: Enumeration output, clobbered on error
- *
- * Return: 0 if register block enumerated, negative error code otherwise
- *
- * A CXL DVSEC may point to one or more register blocks, search for them
- * by @type.
- */
-static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
-			     struct cxl_register_map *map)
-{
-	u32 regloc_size, regblocks;
-	int regloc, i;
-
-	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
-					   CXL_DVSEC_REG_LOCATOR);
-	if (!regloc)
-		return -ENXIO;
-
-	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
-	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
-
-	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
-	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
-
-	for (i = 0; i < regblocks; i++, regloc += 8) {
-		u32 reg_lo, reg_hi;
-
-		pci_read_config_dword(pdev, regloc, &reg_lo);
-		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
-
-		cxl_decode_regblock(reg_lo, reg_hi, map);
-
-		if (map->reg_type == type)
-			return 0;
-	}
-
-	return -ENODEV;
-}
-
 static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 			  struct cxl_register_map *map)
 {
diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 8ae2b4adc59d..0623bb85f30a 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -47,4 +47,13 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_TYPES
 };
 
+static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
+						 struct cxl_register_map *map)
+{
+	if (map->block_offset == U64_MAX)
+		return CXL_RESOURCE_NONE;
+
+	return pci_resource_start(pdev, map->barno) + map->block_offset;
+}
+
 #endif /* __CXL_PCI_H__ */

