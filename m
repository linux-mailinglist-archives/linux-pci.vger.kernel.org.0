Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9F848CF4A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 00:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiALXsZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 18:48:25 -0500
Received: from mga04.intel.com ([192.55.52.120]:13995 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235715AbiALXsQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 18:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642031296; x=1673567296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bNUuS4s5rZE09BWv/IGnHKugbikJHOM0rLN4X5bFmXA=;
  b=bCxqh3RYgD7E9jQSaxpV97YCoSTlSWlCk7zsU57ovolRv7owfOck9Vr2
   HBa5LUenoDzPSHJ2uOMh+RPsj3gQJMNrwmTJbDxo8qfS2T4tSaFugHd8x
   F8OAnmtn5fo9/sFhaMj9zSZ9rZnNsGeDl1c3gHKpxslmr15Nwd93NNNsN
   OYBYYO3g/OlXez5p3LKD2Ffy/qOS+1nMjnCsb4GMdkBNUaF7C7s79I56g
   LSy9ynOCSLHnY4mDnYsMZRTCdj4rfbAqAd/yc9U4ka8POHOuZyj2XeHu+
   wtI5Bv5GMZgZUIqxk0Sy8k/GOGlWdD7xLF/j7HeW+Mute7WzJuUxJV8xF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242695359"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242695359"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="670324210"
Received: from jmaclean-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.136.131])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:11 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Cc:     patches@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 12/15] cxl/region: Collect host bridge decoders
Date:   Wed, 12 Jan 2022 15:47:46 -0800
Message-Id: <20220112234749.1965960-13-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112234749.1965960-1-ben.widawsky@intel.com>
References: <20220112234749.1965960-1-ben.widawsky@intel.com>
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

TODO: Needs support for switches (7th step in the flow chart).

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/region.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index cb3fc8de4c23..6d39f71b6dfa 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -392,6 +392,7 @@ static bool region_hb_rp_config_valid(struct cxl_region *region,
 	}
 
 	for (i = 0; i < hb_count; i++) {
+		struct cxl_decoder *cxld;
 		int idx, position_mask;
 		struct cxl_dport *rp;
 		struct cxl_port *hb;
@@ -434,10 +435,8 @@ static bool region_hb_rp_config_valid(struct cxl_region *region,
 				if (get_rp(ep) != rp)
 					continue;
 
-				if (port_grouping == -1) {
+				if (port_grouping == -1)
 					port_grouping = idx & position_mask;
-					continue;
-				}
 
 				/*
 				 * Do all devices in the region connected to this CXL
@@ -448,10 +447,32 @@ static bool region_hb_rp_config_valid(struct cxl_region *region,
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
+			cxld->interleave_granularity = region_granularity(region);
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
@@ -476,7 +497,7 @@ static bool rootd_contains(const struct cxl_region *region,
 	return true;
 }
 
-static bool rootd_valid(const struct cxl_region *region,
+static bool rootd_valid(struct cxl_region *region,
 			const struct cxl_decoder *rootd,
 			bool state_update)
 {
@@ -501,20 +522,20 @@ static bool rootd_valid(const struct cxl_region *region,
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
@@ -528,7 +549,7 @@ static struct cxl_decoder *find_rootd(const struct cxl_region *region,
 	struct rootd_context ctx;
 	struct device *ret;
 
-	ctx.region = region;
+	ctx.region = (struct cxl_region *)region;
 
 	ret = device_find_child((struct device *)&root->dev, &ctx, rootd_match);
 	if (ret)
-- 
2.34.1

