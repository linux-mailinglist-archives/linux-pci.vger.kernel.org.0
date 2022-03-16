Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DD84DA933
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 05:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350645AbiCPEP0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 00:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350184AbiCPEPY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 00:15:24 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F18381A9;
        Tue, 15 Mar 2022 21:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647404049; x=1678940049;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=imNb4z4rg9GqdaDPmtK5BMT2j1lOS6RZnBaSZaxPfCU=;
  b=RIqewtxlFJN7qdTU5lRQ4lXWYW04/bkvCeJWh66WTXcYSnbtKlcOzgoB
   ByeaMEbcnNXcw+SvP2rvesBeCHG8+yltDqi164VRgeW8sHw3cWWPP6RHB
   1q9ISFyfX+1PVdDhqwF3/vE8h/+WGAS1rrgKSfkDX4okzUPSLywTwdlsn
   GxFoIXB6SaIdrECA7U4pSWo5QKW4VnFy3hJ+L/r8w3zZV+HUyoTj4pYeR
   W38qQ/fbIeJNlvAgnbNQ/GT/Jn0D9AcdufBjUrZ1E9XMzCCYAdO8FdWjs
   +Pya4Bfyb7SNAgfFkI8FYSQQ9NvJNnSzg0uF9fXv4qqnl4yPR2B+m1hoo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="317210081"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="317210081"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:14:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="598559918"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:14:08 -0700
Subject: [PATCH 5/8] cxl/port: Limit the port driver to just the HDM Decoder
 Capability
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Date:   Tue, 15 Mar 2022 21:14:08 -0700
Message-ID: <164740404858.3912056.13421993054614655037.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update the port driver to use cxl_map_component_registers() so that the
component register block can be shared between the cxl_pci driver and
the cxl_port driver. I.e. stop the port driver from reserving the entire
component register block for itself via request_region() when it only
needs the HDM Decoder Capability subset.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 0e89a7a932d4..09221afca309 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -77,18 +77,22 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 		cxlhdm->interleave_mask |= GENMASK(14, 12);
 }
 
-static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
-					  void __iomem *crb)
+static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
+				struct cxl_component_regs *regs)
 {
-	struct cxl_component_reg_map map;
+	struct cxl_register_map map = {
+		.resource = port->component_reg_phys,
+		.base = crb,
+		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
+	};
 
-	cxl_probe_component_regs(&port->dev, crb, &map);
-	if (!map.hdm_decoder.valid) {
+	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
+	if (!map.component_map.hdm_decoder.valid) {
 		dev_err(&port->dev, "HDM decoder registers invalid\n");
-		return IOMEM_ERR_PTR(-ENXIO);
+		return -ENXIO;
 	}
 
-	return crb + map.hdm_decoder.offset;
+	return cxl_map_component_regs(&port->dev, regs, &map);
 }
 
 /**
@@ -98,25 +102,25 @@ static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
 {
 	struct device *dev = &port->dev;
-	void __iomem *crb, *hdm;
 	struct cxl_hdm *cxlhdm;
+	void __iomem *crb;
+	int rc;
 
 	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
 	if (!cxlhdm)
 		return ERR_PTR(-ENOMEM);
 
 	cxlhdm->port = port;
-	crb = devm_cxl_iomap_block(dev, port->component_reg_phys,
-				   CXL_COMPONENT_REG_BLOCK_SIZE);
+	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
 	if (!crb) {
 		dev_err(dev, "No component registers mapped\n");
 		return ERR_PTR(-ENXIO);
 	}
 
-	hdm = map_hdm_decoder_regs(port, crb);
-	if (IS_ERR(hdm))
-		return ERR_CAST(hdm);
-	cxlhdm->regs.hdm_decoder = hdm;
+	rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);
+	iounmap(crb);
+	if (rc)
+		return ERR_PTR(rc);
 
 	parse_hdm_decoder_caps(cxlhdm);
 	if (cxlhdm->decoder_count == 0) {

