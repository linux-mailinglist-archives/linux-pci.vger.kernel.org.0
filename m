Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E3F4DA92E
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 05:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346133AbiCPEPG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 00:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiCPEPF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 00:15:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434EF33E08;
        Tue, 15 Mar 2022 21:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647404032; x=1678940032;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZSLItZAXJIG/eKpF4GSFE8mJ7y09/lI4y0O6QSK69Tg=;
  b=kmf6EyAh6k60nQmKzrzweu8oDwF+eMcFgH3TPHOuplKTV7GYW2X9/j6S
   7NXXqFng6t0gNt1V9mBcGikoh3SLeM9wDqFTfEjaw9q145oJt5R1MeQPh
   MzcW06VyjkjSavOY0VyurHbCSsehz4ucAoJHLQcVNvGTCNuuf18XL1/3y
   Av6WZuAvVCzHTRos3ntRgcgEqFQpNk+LcZ29FuBXtjMfUzeI49vvkBD3z
   jFkjpUC8t/eUu9QhqFHSr20thR6TKw2YrsGJYV2ztwGeBeMO0cx9mLMRP
   +WymQPeBM1LqvMDCPjn0cMUqRnnGhrC51q0/ji5tQ4KfUReJNMlnT/gDj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255318968"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="255318968"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:13:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="580767820"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:13:47 -0700
Subject: [PATCH 1/8] cxl/pci: Cleanup repeated code in cxl_probe_regs()
 helpers
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Date:   Tue, 15 Mar 2022 21:13:47 -0700
Message-ID: <164740402774.3912056.671750814250190348.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rather then duplicating the setting of valid, length, and offset for
each type, just convey a pointer to the register map to common code.

Yes, the equivalent change in cxl_probe_component_regs() does not save
any lines of code, but it is preparation for adding another component
register type to map (RAS Capability Strucutre).

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/regs.c |   46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 39a129c57d40..bd6ae14b679e 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -59,36 +59,41 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 
 	for (cap = 1; cap <= cap_count; cap++) {
 		void __iomem *register_block;
-		u32 hdr;
-		int decoder_cnt;
+		struct cxl_reg_map *rmap;
 		u16 cap_id, offset;
-		u32 length;
+		u32 length, hdr;
 
 		hdr = readl(base + cap * 0x4);
 
 		cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
 		offset = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
 		register_block = base + offset;
+		hdr = readl(register_block);
 
+		rmap = NULL;
 		switch (cap_id) {
-		case CXL_CM_CAP_CAP_ID_HDM:
+		case CXL_CM_CAP_CAP_ID_HDM: {
+			int decoder_cnt;
+
 			dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
 				offset);
 
-			hdr = readl(register_block);
-
 			decoder_cnt = cxl_hdm_decoder_count(hdr);
 			length = 0x20 * decoder_cnt + 0x10;
-
-			map->hdm_decoder.valid = true;
-			map->hdm_decoder.offset = CXL_CM_OFFSET + offset;
-			map->hdm_decoder.size = length;
+			rmap = &map->hdm_decoder;
 			break;
+		}
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
 			break;
 		}
+
+		if (!rmap)
+			continue;
+		rmap->valid = true;
+		rmap->offset = CXL_CM_OFFSET + offset;
+		rmap->size = length;
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
@@ -117,6 +122,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
 
 	for (cap = 1; cap <= cap_count; cap++) {
+		struct cxl_reg_map *rmap;
 		u32 offset, length;
 		u16 cap_id;
 
@@ -125,28 +131,22 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 		offset = readl(base + cap * 0x10 + 0x4);
 		length = readl(base + cap * 0x10 + 0x8);
 
+		rmap = NULL;
 		switch (cap_id) {
 		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
 			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
-
-			map->status.valid = true;
-			map->status.offset = offset;
-			map->status.size = length;
+			rmap = &map->status;
 			break;
 		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
 			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
-			map->mbox.valid = true;
-			map->mbox.offset = offset;
-			map->mbox.size = length;
+			rmap = &map->mbox;
 			break;
 		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
 			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
 			break;
 		case CXLDEV_CAP_CAP_ID_MEMDEV:
 			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
-			map->memdev.valid = true;
-			map->memdev.offset = offset;
-			map->memdev.size = length;
+			rmap = &map->memdev;
 			break;
 		default:
 			if (cap_id >= 0x8000)
@@ -155,6 +155,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 				dev_dbg(dev, "Unknown cap ID: %#x offset: %#x\n", cap_id, offset);
 			break;
 		}
+
+		if (!rmap)
+			continue;
+		rmap->valid = true;
+		rmap->offset = offset;
+		rmap->size = length;
 	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, CXL);

