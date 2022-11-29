Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CEB63C6B9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 18:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236125AbiK2RsU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 12:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236236AbiK2RsQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 12:48:16 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DD86037F;
        Tue, 29 Nov 2022 09:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744095; x=1701280095;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NKGxOFvJVed1CBbhZemEacrGnR9VSwhyY37TG3iSonU=;
  b=X1NxkWWiasF0O/fmprkHujVu4naCU5ojseYhpL43NLAaHst1P0Xcug1A
   goyHxarKzuVEyWwj1bvP8/eH5+h07B/Rjgdg5ysGxXMHhK2DQWra9slku
   segjWaLlDgvoYlVjletdSEFPrPDNNeW4IhzAW4Bh0YNgUzP09Op/gAesk
   v0NNBDbjMdT9ZJ0mFEDnR6+2tLzBtr0mAJqZ1RoEYKWUNUm6pmZKlScBR
   RGUwrL2abMQbrvjWP64JDDkXZEYDKIXwb+BoxUAA+3evVKO5b/gj+DNqk
   179I8/grWPms+kcx+63V8a5gXSl482+vi2ZZxcux97UmJf+TkG+O9ykcf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342104782"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="342104782"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="972772743"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="972772743"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:13 -0800
Subject: [PATCH v4 01/11] cxl/pci: Cleanup repeated code in cxl_probe_regs()
 helpers
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
Date:   Tue, 29 Nov 2022 10:48:12 -0700
Message-ID: <166974409293.1608150.17661353937678581423.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
References: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Rather then duplicating the setting of valid, length, and offset for
each type, just convey a pointer to the register map to common code.

Yes, the change in cxl_probe_component_regs() does not save
any lines of code, but it is preparation for adding another component
register type to map (RAS Capability Structure).

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/regs.c |   46 ++++++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index ec178e69b18f..17078b593cea 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -61,36 +61,41 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 
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
@@ -119,6 +124,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
 
 	for (cap = 1; cap <= cap_count; cap++) {
+		struct cxl_reg_map *rmap;
 		u32 offset, length;
 		u16 cap_id;
 
@@ -127,28 +133,22 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
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
@@ -157,6 +157,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
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


