Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41963C6B8
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 18:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbiK2RsV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 12:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236226AbiK2RsU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 12:48:20 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22676037F;
        Tue, 29 Nov 2022 09:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744099; x=1701280099;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ig6IYGyco4Ircmf+dM2aCWwHwBoE9FQJjp00RqKrQYY=;
  b=V8vfwfYOFX/c0BOmyUFJJiUsLCeteCDszB/My4Za++F7Gf4BTgW04k1f
   JV8bDv5z1/IdFhhknEgZsA6p/fwK8wApKoyfXqsYtp01MUcBDv+XamrKk
   OjFMICeh4g16XENYgcgZg8YzzNyrC2knmLA6VdDhJI18vlOQnhJBFInET
   wsd7S0aAwX+OBKSRnkGz6/00/ptu+pQhPbwnxYfcRP4nB0pXA0Ggxs/84
   7jQRjRjsi80JPvyv03rEj2A6DEa80VXYWa7yFbpq7OJoIaevoYf2SKQYF
   jNQjtTn/mMikECFCoOxRTF7E2Io0FVYneUHdjLK+SIyuy9m1XgEvZjbZs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342104815"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="342104815"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="972772829"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="972772829"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:18 -0800
Subject: [PATCH v4 02/11] cxl/pci: Cleanup cxl_map_device_regs()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
Date:   Tue, 29 Nov 2022 10:48:18 -0700
Message-ID: <166974409867.1608150.14886452053935226038.stgit@djiang5-desk3.ch.intel.com>
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

Use a loop to reduce the duplicated code in cxl_map_device_regs(). This
is in preparation for deleting cxl_map_regs().

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/regs.c |   51 ++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 17078b593cea..6c42b74a54c5 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -216,42 +216,31 @@ int cxl_map_device_regs(struct pci_dev *pdev,
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
 


