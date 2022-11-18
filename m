Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7BD62FB29
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 18:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbiKRRIr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 12:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbiKRRIr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 12:08:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFFA1FF81;
        Fri, 18 Nov 2022 09:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668791325; x=1700327325;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dtCnVY9W81yc9vix7z4DELknnnqJJU5aJ9NAFNn5thk=;
  b=TYUrV8v8zPZtZbNM2NbRxPrDX77PWkb4opC9Dag1i3+feI11xXFVdyYS
   ckxsSpfwSJkzxN5RjIJhjSeitvzaiS8q53Y0pFwb/puTqhx/h/FYdQpc1
   mYLDyOOOuMKC5DC1u+dXN5eaOiTLrDjclENFUFMlsV4QZ+gA1h3lg8G0E
   ANtngdi9EOd0b/foe5XCxid1LwmW3vGuhEFzVi4jYrzRFt0I6KAnJm10S
   LC32M0nVIQZ/b7XoxuVF0JI9xSorQeFsrQfNAIyAmqIX2cwZL04eDQBrI
   NvY64KM+zsh/LWRWUGNaLztL+AEP8FPS9IE6bmmwDGwp9lWKsw5+HPMva
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="375315741"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="375315741"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="703807535"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="703807535"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:14 -0800
Subject: [PATCH v3 02/11] cxl/pci: Cleanup cxl_map_device_regs()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com
Date:   Fri, 18 Nov 2022 10:08:14 -0700
Message-ID: <166879129453.674819.15524951681832915583.stgit@djiang5-desk3.ch.intel.com>
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

Use a loop to reduce the duplicated code in cxl_map_device_regs(). This
is in preparation for deleting cxl_map_regs().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/regs.c |   51 ++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index bd6ae14b679e..f03ede86412d 100644
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
+		{ &map->device_map.status, &regs->status, },
+		{ &map->device_map.mbox, &regs->mbox, },
+		{ &map->device_map.memdev, &regs->memdev, },
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
 


