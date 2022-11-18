Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A51EA62FB4E
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 18:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiKRRMx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 12:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242478AbiKRRMo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 12:12:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0E68C08D;
        Fri, 18 Nov 2022 09:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668791563; x=1700327563;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3bLD5w+56OFgirzHZ9oUByLwMevh1eTSyzaQepHzZSc=;
  b=XQlDFpgYA5jHD1ZvNNKa7THIoXmxCgZE6IVgmuQGi+Mm31nF22LsudTV
   tgJkpLr+WW+J4Gz6YkSE5MxD3mzFHqHOEWsAEMgF9w0VbwWg48snhcjQV
   O1SCFpTyK+oL2Wmz6CFFXIgntvkch/YwJ1DLb/4N86ZGKWw63bgjDM7Ao
   rVl7jNUHMy+RVnvghnwr35Pzf4w0wc2tv0ciWuWGbX7QW1oP2ljt9+imJ
   eiXKQE3VkMadwGm01N3sDIpE50gQ2ooSgKP1lbkB5OWoYulKbperyFJEl
   63YX8yQkHBgEvbSzWr3ggkvZFlFsBwwAg/mg0T0MnQuqSaF49/Kgxa0dT
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="310814762"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="310814762"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:32 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="703807782"
X-IronPort-AV: E=Sophos;i="5.96,174,1665471600"; 
   d="scan'208";a="703807782"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 09:08:32 -0800
Subject: [PATCH v3 05/11] cxl/port: Limit the port driver to just the HDM
 Decoder Capability
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com
Date:   Fri, 18 Nov 2022 10:08:31 -0700
Message-ID: <166879131190.674819.14561755274104822108.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
References: <166879123216.674819.3578187187954311721.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Update the port driver to use cxl_map_component_registers() so that the
component register block can be shared between the cxl_pci driver and
the cxl_port driver. I.e. stop the port driver from reserving the entire
component register block for itself via request_region() when it only
needs the HDM Decoder Capability subset.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c |   32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d1d2caea5c62..061551148cfe 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -82,18 +82,22 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
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
@@ -103,25 +107,25 @@ static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
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


