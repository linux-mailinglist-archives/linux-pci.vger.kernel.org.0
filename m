Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02563C6EF
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 19:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbiK2SBR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 13:01:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiK2SBQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 13:01:16 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638096B389;
        Tue, 29 Nov 2022 10:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744876; x=1701280876;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a+p4UrFUd5m75xnByDXKd3xUXY3Gfo1m0/ZGhmEz9fo=;
  b=bqT9/p3slKT1I3okh/h16edt4U+MgvdXBphIYrmcXzTiGVGtdkLIfLRX
   XG0euL4enQgy0Ep2f7h9KcF4dlW+w1alP9zfMJUJEiN1E6aNgNjjCTVaK
   ViY7dm8ichQRsduKsPb1XIXrtVJL/jzTCuMmxs0BXW634bf1dd1sa+TiC
   x/D67rxsj1bcSpxOXdJlLkQbKN0nyW3ZWq77EI0Uu5Nw6yNLE0KPvuCQq
   XixZCpDSYndVrKyu/2hyJDSP8VVyUxXwV2mce7iD6424twyeRlLirnoNI
   WmMhImO1qiPF3zf62rnYtUdOgC03PK496WBK1pdcv9ToVEa6eYqLBAPqw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379467555"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="379467555"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="621554597"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="621554597"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:24 -0800
Subject: [PATCH v4 03/11] cxl/pci: Kill cxl_map_regs()
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
Date:   Tue, 29 Nov 2022 10:48:24 -0700
Message-ID: <166974410443.1608150.15855499736133349600.stgit@djiang5-desk3.ch.intel.com>
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
 


