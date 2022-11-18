Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF7962FB42
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 18:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbiKRRLO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 12:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242546AbiKRRKz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 12:10:55 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0168CF1A;
        Fri, 18 Nov 2022 09:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668791450; x=1700327450;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31hllwxfwL5zAyT/KbkRAtlGXyy0LyaQjb/WNQ3ZMtA=;
  b=WIVp9yU8ELyTDTrrvwmnAf/8e3BJuLvIx4DJv1G84N6lZpLl5sFdsGIS
   jNnK4OKuEPTxlS2a2K/F7HWSw8iLchGzH7zG5HyWJeCqr5lM4NabWvA7n
   h+xBW73o9dhKyJXXEiZkfE99yCXGRIhnJAEtGmkWCgcEWdNMKFymiZ/vF
   ReA6UnukdBsG0MRjKAbiD/zz88dAPGIFQP4h1IM4LnMN2IDweecNrIq/C
   OOxMjmwCKR5lD1DMPAN4J/Zy0VTY+gH2xRHXvBBxhsAcvHKXLuyPi+cmf
   5C/p2c0KBhdsWgs3MHaTf57UeSprL5sV8/5BZ52cdXPbT2QQWVIlpAHr1
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="296545885"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="296545885"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:41 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="765224079"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="765224079"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:38 -0800
Subject: [PATCH v3 06/11] cxl/pci: Prepare for mapping RAS Capability
 Structure
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com
Date:   Fri, 18 Nov 2022 10:08:37 -0700
Message-ID: <166879131773.674819.15195283908241192601.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
References: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index e4b0d52ac3a1..97e8f4201493 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -92,6 +92,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 		if (!rmap)
 			continue;
 		rmap->valid = true;
+		rmap->id = cap_id;
 		rmap->offset = CXL_CM_OFFSET + offset;
 		rmap->size = length;
 	}
@@ -159,6 +160,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		if (!rmap)
 			continue;
 		rmap->valid = true;
+		rmap->id = cap_id;
 		rmap->offset = offset;
 		rmap->size = length;
 	}
@@ -187,17 +189,31 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
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
index c46db87f4ad5..fb719a5e83b2 100644
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
 


