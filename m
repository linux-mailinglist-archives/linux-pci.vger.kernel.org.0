Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85C9949C306
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 06:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbiAZFYK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 00:24:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:20239 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbiAZFYK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jan 2022 00:24:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643174650; x=1674710650;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AjJ3jl+UE6FaD8JAG1gG3qC0eTOrRDsTZmi1qCGYjwE=;
  b=KHO99Lb2os9EEW+fAQufiYUPRTjBV0ekNynrm1mQ9uG80Dl7yDxPEuB2
   TdXV1KS9JBaGiFV3L2oA+ig8E5Gb5RSxXkzUmrCraasMrCmHI7tBs9aTG
   3oeUs52zsZwL/eyD4HI95kq+pvP5JjzFVb5+8CgM8YpsWc35EHvhKhN+t
   /iBTAMtujxxHChZNHzQx7PfjI/g6VDKChvYkfJC8RD8by+yMGCt++rrAX
   UnoOJkhdNS0IMfJNdNps4P7bxbIcR5EJK5+OTPhhgknhp/luLoTEt/PQR
   1QC+x10ShAHPdQ4fO0R9UxuV1fGel9pHZ/GfbGKQGIdFsoJSWtW0Ab5v0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="230057652"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="230057652"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 21:24:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="624728233"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 21:24:09 -0800
Subject: [PATCH 2/2] cxl/core/port: Handle invalid decoders
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev,
        ben.widawsky@intel.com
Date:   Tue, 25 Jan 2022 21:24:09 -0800
Message-ID: <164317464918.3438644.12371149695618136198.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164317463887.3438644.4087819721493502301.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164317463887.3438644.4087819721493502301.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In case init_hdm_decoder() finds invalid settings, skip to the next
valid decoder. Only fail port enumeration if zero valid decoders are
found. This protects the driver init against broken hardware and / or
future interleave capabilities.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |   36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c966ab0d51fe..4955ba16c9c8 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -150,8 +150,8 @@ static int to_interleave_ways(u32 ctrl)
 	}
 }
 
-static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
-			     void __iomem *hdm, int which)
+static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
+			    int *target_map, void __iomem *hdm, int which)
 {
 	u64 size, base;
 	u32 ctrl;
@@ -167,6 +167,11 @@ static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
 
 	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
 		size = 0;
+	if (base == U64_MAX || size == U64_MAX) {
+		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
+			 port->id, cxld->id);
+		return -ENXIO;
+	}
 
 	cxld->decoder_range = (struct range) {
 		.start = base,
@@ -180,6 +185,12 @@ static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
 			cxld->flags |= CXL_DECODER_F_LOCK;
 	}
 	cxld->interleave_ways = to_interleave_ways(ctrl);
+	if (!cxld->interleave_ways) {
+		dev_warn(&port->dev,
+			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
+			 port->id, cxld->id, ctrl);
+		return -ENXIO;
+	}
 	cxld->interleave_granularity = to_interleave_granularity(ctrl);
 
 	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
@@ -188,12 +199,14 @@ static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
 		cxld->target_type = CXL_DECODER_ACCELERATOR;
 
 	if (is_cxl_endpoint(to_cxl_port(cxld->dev.parent)))
-		return;
+		return 0;
 
 	target_list.value =
 		ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 	for (i = 0; i < cxld->interleave_ways; i++)
 		target_map[i] = target_list.target_id[i];
+
+	return 0;
 }
 
 /**
@@ -204,7 +217,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
-	int i, committed;
+	int i, committed, failed;
 	u32 ctrl;
 
 	/*
@@ -224,7 +237,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 	if (committed != cxlhdm->decoder_count)
 		msleep(20);
 
-	for (i = 0; i < cxlhdm->decoder_count; i++) {
+	for (i = 0, failed = 0; i < cxlhdm->decoder_count; i++) {
 		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };
 		int rc, target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
@@ -239,7 +252,13 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			return PTR_ERR(cxld);
 		}
 
-		init_hdm_decoder(cxld, target_map, cxlhdm->regs.hdm_decoder, i);
+		rc = init_hdm_decoder(port, cxld, target_map,
+				      cxlhdm->regs.hdm_decoder, i);
+		if (rc) {
+			put_device(&cxld->dev);
+			failed++;
+			continue;
+		}
 		rc = add_hdm_decoder(port, cxld, target_map);
 		if (rc) {
 			dev_warn(&port->dev,
@@ -248,6 +267,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 		}
 	}
 
+	if (failed == cxlhdm->decoder_count) {
+		dev_err(&port->dev, "No valid decoders found\n");
+		return -ENXIO;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, CXL);

