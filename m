Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A898563C6F2
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 19:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbiK2SBZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 13:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiK2SBX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 13:01:23 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ECCF6B38F;
        Tue, 29 Nov 2022 10:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744883; x=1701280883;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VJigvk5TmaH6zcrDjVVK8ODUTzgRLtCxnXNNzfQZwK4=;
  b=mLtB5SdeXcGYSlJZapxUH/CZjgJPr4SeN2ATnmE7ZfjIm9lOCAcYgh2U
   GDWcU5UPJ0zixBPOJQ3AvSpEoTYteVGnSyqgy5XGWa/waXECsib3cU6Do
   ZuE50sgB0+5JS/5SbBqF/uhGuBJrz6h/6dL44DHWoUagGjEaMXML9Ny9f
   pT0wUy2XfWFHDjXomUrVfPlhCkC/dvPtwUcLnztyf2Mc4iiCPx20xuEP7
   pSaqOBTaFXskzjjW6GKJ3zelJfEXt5+shYu8qk9FxdCCCfadkBiNeWC7o
   uhLuaaI8wT0BzHaWS704rBbH+1rpnZ69BalFNHILTahaUUwk+T+cwktPr
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379467652"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="379467652"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="621554721"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="621554721"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:42 -0800
Subject: [PATCH v4 06/11] cxl/pci: Prepare for mapping RAS Capability
 Structure
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
Date:   Tue, 29 Nov 2022 10:48:42 -0700
Message-ID: <166974412214.1608150.11487843455070795378.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
References: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
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

The RAS Capabilitiy Structure is a CXL Component register capability
block. Unlike the HDM Decoder Capability, it will be referenced by the
cxl_pci driver in response to PCIe AER events. Due to this it is no
longer the case that cxl_map_component_regs() can assume that it should
map all component registers. Plumb a bitmask of capability ids to map
through cxl_map_component_regs().

For symmetry cxl_probe_device_regs() is updated to populate @id in
'struct cxl_reg_map' even though cxl_map_device_regs() does not have a
need to map a subset of the device registers per caller.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c  |    3 ++-
 drivers/cxl/core/regs.c |   36 ++++++++++++++++++++++++++----------
 drivers/cxl/cxl.h       |    4 +++-
 3 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 061551148cfe..100d0881bde4 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -97,7 +97,8 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
 		return -ENXIO;
 	}
 
-	return cxl_map_component_regs(&port->dev, regs, &map);
+	return cxl_map_component_regs(&port->dev, regs, &map,
+				      BIT(CXL_CM_CAP_CAP_ID_HDM));
 }
 
 /**
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 8d986b271876..0efb76658e66 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -94,6 +94,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 		if (!rmap)
 			continue;
 		rmap->valid = true;
+		rmap->id = cap_id;
 		rmap->offset = CXL_CM_OFFSET + offset;
 		rmap->size = length;
 	}
@@ -161,6 +162,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		if (!rmap)
 			continue;
 		rmap->valid = true;
+		rmap->id = cap_id;
 		rmap->offset = offset;
 		rmap->size = length;
 	}
@@ -192,17 +194,31 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 }
 
 int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
-			   struct cxl_register_map *map)
+			   struct cxl_register_map *map, unsigned long map_mask)
 {
-	resource_size_t phys_addr;
-	resource_size_t length;
-
-	phys_addr = map->resource;
-	phys_addr += map->component_map.hdm_decoder.offset;
-	length = map->component_map.hdm_decoder.size;
-	regs->hdm_decoder = devm_cxl_iomap_block(dev, phys_addr, length);
-	if (!regs->hdm_decoder)
-		return -ENOMEM;
+	struct mapinfo {
+		struct cxl_reg_map *rmap;
+		void __iomem **addr;
+	} mapinfo[] = {
+		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
+		struct mapinfo *mi = &mapinfo[i];
+		resource_size_t phys_addr;
+		resource_size_t length;
+
+		if (!mi->rmap->valid)
+			continue;
+		if (!test_bit(mi->rmap->id, &map_mask))
+			continue;
+		phys_addr = map->resource + mi->rmap->offset;
+		length = mi->rmap->size;
+		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
+		if (!*(mi->addr))
+			return -ENOMEM;
+	}
 
 	return 0;
 }
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cd5233b45884..b3fa0c6525af 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -174,6 +174,7 @@ struct cxl_regs {
 
 struct cxl_reg_map {
 	bool valid;
+	int id;
 	unsigned long offset;
 	unsigned long size;
 };
@@ -213,7 +214,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
 int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
-			   struct cxl_register_map *map);
+			   struct cxl_register_map *map,
+			   unsigned long map_mask);
 int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
 			struct cxl_register_map *map);
 


