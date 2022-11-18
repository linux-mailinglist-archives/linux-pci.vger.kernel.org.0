Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C023862FB33
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 18:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbiKRRJt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 12:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241673AbiKRRJt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 12:09:49 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B955B6E549;
        Fri, 18 Nov 2022 09:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668791385; x=1700327385;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PZVQOuzflumOZG6X5ju+iVoAQoD4JXjS8m19EL6tpSU=;
  b=I9FoEWTj0DSoKDmR86KnLeJjlMG9piazMvAHDG5DRWOQnAQGOmqxaMFA
   5YhO89H92NvGZ37B1wlhI4PV0vRmBiPHtxTq27L8ahNS1iRKMMI5WPtKk
   7pycOMmmLCNlqzJfGz9c+ALbqEB87+XQClZ4c8tcx+AduPvw2XSxpgIfI
   eitXjo6LSt7rHtDiSXwdNI0BpxwMV4/4HDlhAoDj00/HG5NfC1YwkNe9c
   EnwJRFlX/ZZBGybzCgSpHZ00YHldwaiQUERjyakAY2mRmgGnI8aN6eSD2
   xZPVQIZ4VdTy3ryPOwJRsEjzLkfSfDX798zGBcCI3S2jPEt3Us/7TrBdv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="293572957"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="293572957"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:27 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="703807725"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="703807725"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:26 -0800
Subject: [PATCH v3 04/11] cxl/core/regs: Make cxl_map_{component,
 device}_regs() device generic
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com
Date:   Fri, 18 Nov 2022 10:08:26 -0700
Message-ID: <166879130616.674819.6251433579640936736.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
References: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

There is no need to carry the barno and the block offset through the
stack, just convert them to a resource base immediately.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c  |    3 +--
 drivers/cxl/core/port.c |    2 +-
 drivers/cxl/core/regs.c |   40 +++++++++++++++++++++++-----------------
 drivers/cxl/cxl.h       |   14 ++++++--------
 drivers/cxl/cxlpci.h    |    9 ---------
 drivers/cxl/pci.c       |   25 ++++++-------------------
 6 files changed, 37 insertions(+), 56 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9240df53ed87..2a8a88d38533 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -54,8 +54,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
 		dev_dbg(&port->dev, "failed to find component registers\n");
 
 	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
-	dport = devm_cxl_add_dport(port, &pdev->dev, port_num,
-				   cxl_regmap_to_base(pdev, &map));
+	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
 	if (IS_ERR(dport)) {
 		ctx->error = PTR_ERR(dport);
 		return PTR_ERR(dport);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index bffde862de0b..2c78b28dbcc6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1236,7 +1236,7 @@ static resource_size_t find_component_registers(struct device *dev)
 	pdev = to_pci_dev(dev);
 
 	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
-	return cxl_regmap_to_base(pdev, &map);
+	return map.resource;
 }
 
 static int add_port_attach_ep(struct cxl_memdev *cxlmd,
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index f03ede86412d..e4b0d52ac3a1 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -186,17 +186,13 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 	return ret_val;
 }
 
-int cxl_map_component_regs(struct pci_dev *pdev,
-			   struct cxl_component_regs *regs,
+int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
 			   struct cxl_register_map *map)
 {
-	struct device *dev = &pdev->dev;
 	resource_size_t phys_addr;
 	resource_size_t length;
 
-	phys_addr = pci_resource_start(pdev, map->barno);
-	phys_addr += map->block_offset;
-
+	phys_addr = map->resource;
 	phys_addr += map->component_map.hdm_decoder.offset;
 	length = map->component_map.hdm_decoder.size;
 	regs->hdm_decoder = devm_cxl_iomap_block(dev, phys_addr, length);
@@ -207,13 +203,11 @@ int cxl_map_component_regs(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
 
-int cxl_map_device_regs(struct pci_dev *pdev,
+int cxl_map_device_regs(struct device *dev,
 			struct cxl_device_regs *regs,
 			struct cxl_register_map *map)
 {
-	resource_size_t phys_addr =
-		pci_resource_start(pdev, map->barno) + map->block_offset;
-	struct device *dev = &pdev->dev;
+	resource_size_t phys_addr = map->resource;
 	struct mapinfo {
 		struct cxl_reg_map *rmap;
 		void __iomem **addr;
@@ -243,13 +237,24 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);
 
-static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
+static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 				struct cxl_register_map *map)
 {
-	map->block_offset = ((u64)reg_hi << 32) |
-			    (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
-	map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
+	int bar = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
+	u64 offset = ((u64)reg_hi << 32) |
+		     (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
+
+	if (offset > pci_resource_len(pdev, bar)) {
+		dev_warn(&pdev->dev,
+			 "BAR%d: %pr: too small (offset: %pa, type: %d)\n", bar,
+			 &pdev->resource[bar], &offset, map->reg_type);
+		return false;
+	}
+
 	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
+	map->resource = pci_resource_start(pdev, bar) + offset;
+	map->max_size = pci_resource_len(pdev, bar) - offset;
+	return true;
 }
 
 /**
@@ -269,7 +274,7 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 	u32 regloc_size, regblocks;
 	int regloc, i;
 
-	map->block_offset = U64_MAX;
+	map->resource = CXL_RESOURCE_NONE;
 	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
 					   CXL_DVSEC_REG_LOCATOR);
 	if (!regloc)
@@ -287,13 +292,14 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 		pci_read_config_dword(pdev, regloc, &reg_lo);
 		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
 
-		cxl_decode_regblock(reg_lo, reg_hi, map);
+		if (!cxl_decode_regblock(pdev, reg_lo, reg_hi, map))
+			continue;
 
 		if (map->reg_type == type)
 			return 0;
 	}
 
-	map->block_offset = U64_MAX;
+	map->resource = CXL_RESOURCE_NONE;
 	return -ENODEV;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3ab81ad9d2e5..c46db87f4ad5 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -191,17 +191,17 @@ struct cxl_device_reg_map {
 /**
  * struct cxl_register_map - DVSEC harvested register block mapping parameters
  * @base: virtual base of the register-block-BAR + @block_offset
- * @block_offset: offset to start of register block in @barno
+ * @resource: physical resource base of the register block
+ * @max_size: maximum mapping size to perform register search
  * @reg_type: see enum cxl_regloc_type
- * @barno: PCI BAR number containing the register block
  * @component_map: cxl_reg_map for component registers
  * @device_map: cxl_reg_maps for device registers
  */
 struct cxl_register_map {
 	void __iomem *base;
-	u64 block_offset;
+	resource_size_t resource;
+	resource_size_t max_size;
 	u8 reg_type;
-	u8 barno;
 	union {
 		struct cxl_component_reg_map component_map;
 		struct cxl_device_reg_map device_map;
@@ -212,11 +212,9 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
-int cxl_map_component_regs(struct pci_dev *pdev,
-			   struct cxl_component_regs *regs,
+int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
 			   struct cxl_register_map *map);
-int cxl_map_device_regs(struct pci_dev *pdev,
-			struct cxl_device_regs *regs,
+int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
 			struct cxl_register_map *map);
 
 enum cxl_regloc_type;
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index eec597dbe763..920909791bb9 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -62,15 +62,6 @@ enum cxl_regloc_type {
 	CXL_REGLOC_RBI_TYPES
 };
 
-static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
-						 struct cxl_register_map *map)
-{
-	if (map->block_offset == U64_MAX)
-		return CXL_RESOURCE_NONE;
-
-	return pci_resource_start(pdev, map->barno) + map->block_offset;
-}
-
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 350da1241d3a..8cad9d5fd49a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -276,35 +276,22 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 
 static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
 {
-	void __iomem *addr;
-	int bar = map->barno;
 	struct device *dev = &pdev->dev;
-	resource_size_t offset = map->block_offset;
 
-	/* Basic sanity check that BAR is big enough */
-	if (pci_resource_len(pdev, bar) < offset) {
-		dev_err(dev, "BAR%d: %pr: too small (offset: %pa)\n", bar,
-			&pdev->resource[bar], &offset);
-		return -ENXIO;
-	}
-
-	addr = pci_iomap(pdev, bar, 0);
-	if (!addr) {
+	map->base = ioremap(map->resource, map->max_size);
+	if (!map->base) {
 		dev_err(dev, "failed to map registers\n");
 		return -ENOMEM;
 	}
 
-	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %pa\n",
-		bar, &offset);
-
-	map->base = addr + map->block_offset;
+	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
 	return 0;
 }
 
 static void cxl_unmap_regblock(struct pci_dev *pdev,
 			       struct cxl_register_map *map)
 {
-	pci_iounmap(pdev, map->base - map->block_offset);
+	iounmap(map->base);
 	map->base = NULL;
 }
 
@@ -445,7 +432,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_map_device_regs(pdev, &cxlds->regs.device_regs, &map);
+	rc = cxl_map_device_regs(&pdev->dev, &cxlds->regs.device_regs, &map);
 	if (rc)
 		return rc;
 
@@ -458,7 +445,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
 
-	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
+	cxlds->component_reg_phys = map.resource;
 
 	devm_cxl_pci_create_doe(cxlds);
 


