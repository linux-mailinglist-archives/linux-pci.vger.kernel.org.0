Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEE6486EFD
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 01:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344379AbiAGAiO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 19:38:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:59445 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344344AbiAGAiO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 19:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641515894; x=1673051894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S3/Kq/osf7+VgU7Z00YKp/sD4tQL9+LQB2DSqzzXKk4=;
  b=PVQdqVuuvQGTAb8D2BsfkJEHyESdhiAHDYT/B6Ul8gYES56BzEQvJdkt
   jhz+FFze9XAkrzJcKhygaD7DnAa0bnzycBLUxMRrekYR3hbDVRcFdWLk4
   1U6xUmxJFug4i86PElOtmhy9H9zOqfIk8Hk//oSrFMwFSHCjDp4yRHgKZ
   wUe2MjVNJp8IZxAD5vNZm3ugV3FtrK9rWNF7GoigmTwgJiaIM+8z0ZuD2
   2q/kylbrydA2f86DJ0ao2RZXOa/gGNHrcI9WHbVWCk9MwJlGQDGS67s/L
   rY4zll+/EpajEBSSW0GYRmYSOgVOCocNKya/i/nVJ//RA/r7b0uL+1EKO
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229582045"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="229582045"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="471123246"
Received: from elenawei-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.138.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:13 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org
Cc:     patches@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 12/13] cxl/region: Record host bridge target list
Date:   Thu,  6 Jan 2022 16:37:55 -0800
Message-Id: <20220107003756.806582-13-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107003756.806582-1-ben.widawsky@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Part of host bridge verification in the CXL Type 3 Memory Device
Software Guide calculates the host bridge interleave target list (6th
step in the flow chart). With host bridge verification already done, it
is trivial to store away the configuration information.

TODO: Needs support for switches (7th step in the flow chart).

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/region.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index eafd95419895..3120b65b0bc5 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -385,6 +385,7 @@ static bool region_hb_rp_config_valid(struct cxl_region *region,
 	}
 
 	for (i = 0; i < hb_count; i++) {
+		struct cxl_decoder *cxld;
 		int idx, position_mask;
 		struct cxl_dport *rp;
 		struct cxl_port *hb;
@@ -422,10 +423,8 @@ static bool region_hb_rp_config_valid(struct cxl_region *region,
 				if (get_rp(ep) != rp)
 					continue;
 
-				if (port_grouping == -1) {
+				if (port_grouping == -1)
 					port_grouping = idx & position_mask;
-					continue;
-				}
 
 				/*
 				 * Do all devices in the region connected to this CXL
@@ -436,10 +435,32 @@ static bool region_hb_rp_config_valid(struct cxl_region *region,
 							  "One or more devices are not connected to the correct Host Bridge Root Port\n");
 					return false;
 				}
+
+				if (!state_update)
+					continue;
+
+				if (dev_WARN_ONCE(&cxld->dev,
+						  port_grouping >= cxld->nr_targets,
+						  "Invalid port grouping %d/%d\n",
+						  port_grouping, cxld->nr_targets))
+					return false;
+
+				cxld->interleave_ways++;
+				cxld->target[port_grouping] = get_rp(ep);
 			}
 		}
-		if (state_update)
+
+		if (state_update) {
+			/* IG doesn't change across host bridges */
+			cxld->interleave_granularity = region_ig(region);
+
+			cxld->decoder_range = (struct range) {
+				.start = region->res->start,
+				.end = region->res->end
+			};
+
 			list_add_tail(&cxld->region_link, &region->staged_list);
+		}
 	}
 
 	return true;
@@ -464,7 +485,7 @@ static bool rootd_contains(const struct cxl_region *region,
 	return true;
 }
 
-static bool rootd_valid(const struct cxl_region *region,
+static bool rootd_valid(struct cxl_region *region,
 			const struct cxl_decoder *rootd,
 			bool state_update)
 {
@@ -489,20 +510,20 @@ static bool rootd_valid(const struct cxl_region *region,
 }
 
 struct rootd_context {
-	const struct cxl_region *region;
-	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	struct cxl_region *region;
+	const struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
 	int count;
 };
 
 static int rootd_match(struct device *dev, void *data)
 {
 	struct rootd_context *ctx = (struct rootd_context *)data;
-	const struct cxl_region *region = ctx->region;
+	struct cxl_region *region = ctx->region;
 
 	if (!is_root_decoder(dev))
 		return 0;
 
-	return !!rootd_valid(region, to_cxl_decoder(dev), false);
+	return rootd_valid(region, to_cxl_decoder(dev), false);
 }
 
 /*
@@ -516,7 +537,7 @@ static struct cxl_decoder *find_rootd(const struct cxl_region *region,
 	struct rootd_context ctx;
 	struct device *ret;
 
-	ctx.region = region;
+	ctx.region = (struct cxl_region *)region;
 
 	ret = device_find_child((struct device *)&root->dev, &ctx, rootd_match);
 	if (ret)
-- 
2.34.1

