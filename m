Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 503EC4DA934
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 05:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351341AbiCPEP3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 00:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350184AbiCPEP2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 00:15:28 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D55381BC;
        Tue, 15 Mar 2022 21:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647404054; x=1678940054;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qe7YZzcyp/5v/goFi6W6IFF5j3H8Us8oUewaVXaJVLQ=;
  b=U8aqQqc+Bvny+KYK+cvB808ZE3rOOzBCHsNGJYNHteeeM0tU0FJN97sr
   Q/li/zbP6kYPG3gfE8YfgPqG1a8KXbMq8FsLK6woVb8R2uLcR+tIpJPpP
   o5rIdXmSMV9CKZBtq+pPrjra4fQFCQAmxT0vkP2C3EKxXoA/fRiKHFaRi
   PJoPa9zMV7aIHy7ikpJ4Yc3T/h1qDumOuBkNc/dVhKZYx1eH5Q2vU/pvI
   AB/RSjV1Df4t2osGLoQ2htfCKdysc8TsuIx2O4sIZ9BvuTBEjrkOhx5wP
   4UnM3Ds7ymCgGE6Wxor0fC88JjLaWieeCGNhCPhq1v3bg8Ku9BZFm4pxf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256678743"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="256678743"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:14:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="540739843"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:14:14 -0700
Subject: [PATCH 6/8] cxl/pci: Prepare for mapping RAS Capability Structure
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Date:   Tue, 15 Mar 2022 21:14:14 -0700
Message-ID: <164740405408.3912056.16337643017370667205.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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
---
 drivers/cxl/core/hdm.c  |    3 ++-
 drivers/cxl/core/regs.c |   36 ++++++++++++++++++++++++++----------
 drivers/cxl/cxl.h       |    7 ++++---
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 09221afca309..b348217ab704 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -92,7 +92,8 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
 		return -ENXIO;
 	}
 
-	return cxl_map_component_regs(&port->dev, regs, &map);
+	return cxl_map_component_regs(&port->dev, regs, &map,
+				      BIT(CXL_CM_CAP_CAP_ID_HDM));
 }
 
 /**
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 219c7d0e43e2..c022c8937dfc 100644
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
+		{ .rmap = &map->component_map.hdm_decoder, &regs->hdm_decoder },
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
index 2080a75c61fe..52bd77d8e22a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -115,6 +115,7 @@ struct cxl_regs {
 
 struct cxl_reg_map {
 	bool valid;
+	int id;
 	unsigned long offset;
 	unsigned long size;
 };
@@ -153,9 +154,9 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			      struct cxl_component_reg_map *map);
 void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 			   struct cxl_device_reg_map *map);
-int cxl_map_component_regs(struct device *dev,
-			   struct cxl_component_regs *regs,
-			   struct cxl_register_map *map);
+int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
+			   struct cxl_register_map *map,
+			   unsigned long map_mask);
 int cxl_map_device_regs(struct device *dev,
 			struct cxl_device_regs *regs,
 			struct cxl_register_map *map);

