Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEE449EFC0
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 01:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbiA1A3Y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 19:29:24 -0500
Received: from mga18.intel.com ([134.134.136.126]:64742 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344607AbiA1A3M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 19:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643329752; x=1674865752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNc2RfHJQp8YCYBaAmfP7EjNqi6QM52sPg4WlCQ49+o=;
  b=AJgmqHzDomp9Yf5hYylZYzeQ/D47qOmMCaf58F3KsIbLcqdBWpaLH2lR
   F9TkXF/rcu8QB+e2yWo4fpm0OY9xUxiv9fLpTkVsBCyegPigW0xbCE9G+
   24oCvw/P/HuBVBDKYg7t5FzhTOEKL4HrloGFuQOvgKP7SD+DFKsKKmoda
   7aycYiBHlwfWBDy2EUW5p8NmXfu9A5NOpElHUTnhQ7J4DRQveo9RRSnWQ
   rwaYDtYsFmOHOn3zj8CwrdKLGWcHdSf9Jeb7GBKtSj8Z2a4ry8MT0yaD7
   nnqxy5DqhHsOU9dZPtZvknaBoRCqpLrtWU699YIfJrGbDpfGu6ekjPRNo
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230580020"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="230580020"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="674909649"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:27 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 10/14] cxl/region: Collect host bridge decoders
Date:   Thu, 27 Jan 2022 16:27:03 -0800
Message-Id: <20220128002707.391076-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128002707.391076-1-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Part of host bridge verification in the CXL Type 3 Memory Device
Software Guide calculates the host bridge interleave target list (6th
step in the flow chart), ie. verification and state update are done in
the same step. Host bridge verification is already in place, so go ahead
and store the decoders with their target lists.

Switches are implemented in a separate patch.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/region.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 145d7bb02714..b8982be13bfe 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -428,6 +428,7 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
 		return simple_config(cxlr, hbs[0]);
 
 	for (i = 0; i < hb_count; i++) {
+		struct cxl_decoder *cxld;
 		int idx, position_mask;
 		struct cxl_dport *rp;
 		struct cxl_port *hb;
@@ -486,6 +487,18 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
 						"One or more devices are not connected to the correct Host Bridge Root Port\n");
 					goto err;
 				}
+
+				if (!state_update)
+					continue;
+
+				if (dev_WARN_ONCE(&cxld->dev,
+						  port_grouping >= cxld->nr_targets,
+						  "Invalid port grouping %d/%d\n",
+						  port_grouping, cxld->nr_targets))
+					goto err;
+
+				cxld->interleave_ways++;
+				cxld->target[port_grouping] = get_rp(ep);
 			}
 		}
 	}
@@ -538,7 +551,7 @@ static bool rootd_valid(const struct cxl_region *cxlr,
 
 struct rootd_context {
 	const struct cxl_region *cxlr;
-	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	const struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
 	int count;
 };
 
@@ -564,7 +577,7 @@ static struct cxl_decoder *find_rootd(const struct cxl_region *cxlr,
 	struct rootd_context ctx;
 	struct device *ret;
 
-	ctx.cxlr = cxlr;
+	ctx.cxlr = (struct cxl_region *)cxlr;
 
 	ret = device_find_child((struct device *)&root->dev, &ctx, rootd_match);
 	if (ret)
-- 
2.35.0

