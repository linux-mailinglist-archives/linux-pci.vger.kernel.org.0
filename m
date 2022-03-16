Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934C74DA931
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 05:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346678AbiCPEPI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 00:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347719AbiCPEPG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 00:15:06 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B32340C7;
        Tue, 15 Mar 2022 21:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647404033; x=1678940033;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=53vzMOHjErR4dbS2Kgy3GzvXTkOvQUidDmgDE3n4p1k=;
  b=HuAShqTxWyqHtXyZXH7WbLSoBoXWwQVAkEQl9acELMHLf9FsjGr28r0P
   zfAmzcf2mcnYP6BAhdEEeDvjMBCgcvkSKCo/UEiVMc5L4S6g10nr/PVa0
   wfibZpkOrzbDrLWarRxM7YGPs389aO6YguQKXiTzOtSmu6uL6tJ9pqoCB
   YPhbqxqubuLrRywZcr8OCcjSYygRtGBrvS9CUK47iVRNatdYT+91s1HcK
   Rn1ogkK/gzBd5U/vFDgiQ3qxuNTFpgcIJI7Gs9Wf9SdY0ZYNSmVnxqD63
   kvXg4/IuPwB3IKooX4KQKrPOKxtQ+huyaM/EsFrh+kj9qYfGduu5hJPph
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238655216"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="238655216"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:13:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="516166395"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:13:52 -0700
Subject: [PATCH 2/8] cxl/pci: Cleanup cxl_map_device_regs()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Date:   Tue, 15 Mar 2022 21:13:52 -0700
Message-ID: <164740403286.3912056.2514975283929305856.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use a loop to reduce the duplicated code in cxl_map_device_regs(). This
is in preparation for deleting cxl_map_regs().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/regs.c |   51 ++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index bd6ae14b679e..bd766e461f7d 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -211,42 +211,31 @@ int cxl_map_device_regs(struct pci_dev *pdev,
 			struct cxl_device_regs *regs,
 			struct cxl_register_map *map)
 {
+	resource_size_t phys_addr =
+		pci_resource_start(pdev, map->barno) + map->block_offset;
 	struct device *dev = &pdev->dev;
-	resource_size_t phys_addr;
-
-	phys_addr = pci_resource_start(pdev, map->barno);
-	phys_addr += map->block_offset;
-
-	if (map->device_map.status.valid) {
-		resource_size_t addr;
+	struct mapinfo {
+		struct cxl_reg_map *rmap;
+		void __iomem **addr;
+	} mapinfo[] = {
+		{ .rmap = &map->device_map.status, &regs->status, },
+		{ .rmap = &map->device_map.mbox, &regs->mbox, },
+		{ .rmap = &map->device_map.memdev, &regs->memdev, },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
+		struct mapinfo *mi = &mapinfo[i];
 		resource_size_t length;
-
-		addr = phys_addr + map->device_map.status.offset;
-		length = map->device_map.status.size;
-		regs->status = devm_cxl_iomap_block(dev, addr, length);
-		if (!regs->status)
-			return -ENOMEM;
-	}
-
-	if (map->device_map.mbox.valid) {
 		resource_size_t addr;
-		resource_size_t length;
 
-		addr = phys_addr + map->device_map.mbox.offset;
-		length = map->device_map.mbox.size;
-		regs->mbox = devm_cxl_iomap_block(dev, addr, length);
-		if (!regs->mbox)
-			return -ENOMEM;
-	}
-
-	if (map->device_map.memdev.valid) {
-		resource_size_t addr;
-		resource_size_t length;
+		if (!mi->rmap->valid)
+			continue;
 
-		addr = phys_addr + map->device_map.memdev.offset;
-		length = map->device_map.memdev.size;
-		regs->memdev = devm_cxl_iomap_block(dev, addr, length);
-		if (!regs->memdev)
+		addr = phys_addr + mi->rmap->offset;
+		length = mi->rmap->size;
+		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
+		if (!*(mi->addr))
 			return -ENOMEM;
 	}
 

