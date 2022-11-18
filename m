Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E29A62FB2A
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 18:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235215AbiKRRIs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 12:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiKRRIr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 12:08:47 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07C9220EF;
        Fri, 18 Nov 2022 09:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668791326; x=1700327326;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a+p4UrFUd5m75xnByDXKd3xUXY3Gfo1m0/ZGhmEz9fo=;
  b=aV6qo64hGCHYoLX2+/9HRTo5+mpuH9ZLqbmDEyHoHjSaQEFKUnWbsSIa
   xUsMRkePqylfFOTN9f4s4SU1rCUrkZlc+P8at7jRnVvNJDA8Qw1CymK/v
   oq7BBUlE9oC1KyX9dxXMRMUPyPrYSt+dYmzKBXXMmLzScjUlf2802TpKx
   2E/lz2lU0hQrxND8wrhC1f9DfXrPDFnu63IdbRT4cA65kHl0IEWLqNx4H
   0pCHbtbJiziunQGZ4pEbiqVwcURkZNR6Q5YUnYE2/u86DoCvwG4+A+xeF
   TsM+4Ok/s5W4o1NHhaMHyqaW4tjJpa1Y6qngZprsJrmcNl/Sf7mazaKwA
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="375315755"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="375315755"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="703807663"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="703807663"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:20 -0800
Subject: [PATCH v3 03/11] cxl/pci: Kill cxl_map_regs()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com
Date:   Fri, 18 Nov 2022 10:08:20 -0700
Message-ID: <166879130031.674819.8764262180897782841.stgit@djiang5-desk3.ch.intel.com>
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

The component registers are currently unused by the cxl_pci driver.
Only the physical address base of the component registers is conveyed to
the cxl_mem driver. Just call cxl_map_device_registers() directly.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/pci.c |   23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 621a0522b554..350da1241d3a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -347,27 +347,6 @@ static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
 	return 0;
 }
 
-static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *map)
-{
-	struct device *dev = cxlds->dev;
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	switch (map->reg_type) {
-	case CXL_REGLOC_RBI_COMPONENT:
-		cxl_map_component_regs(pdev, &cxlds->regs.component, map);
-		dev_dbg(dev, "Mapping component registers...\n");
-		break;
-	case CXL_REGLOC_RBI_MEMDEV:
-		cxl_map_device_regs(pdev, &cxlds->regs.device_regs, map);
-		dev_dbg(dev, "Probing device registers...\n");
-		break;
-	default:
-		break;
-	}
-
-	return 0;
-}
-
 static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 			  struct cxl_register_map *map)
 {
@@ -466,7 +445,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_map_regs(cxlds, &map);
+	rc = cxl_map_device_regs(pdev, &cxlds->regs.device_regs, &map);
 	if (rc)
 		return rc;
 


