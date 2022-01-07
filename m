Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671A6486EF9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 01:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbiAGAiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 19:38:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:59439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344348AbiAGAiM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 19:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641515892; x=1673051892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3SQ58k6I33qXj+YfuZsAdR1fFONp6rdLz6wO4uT72dE=;
  b=a17ZNsnSGQCtf3Ap1qSHG2ksGLCMX+ewmy9ody9saRXlVRqlJpffcXso
   WTX1C6Zk8QRMX6GqddRFapCdzQTAHQyndJElPHt+OWDeWMaqohISaha4x
   FTC0bMp9ZtZo/eGHvli0e8Ch7vzX/xKKWWf8QePDxYBWQG9ZdaO1JWBxr
   QBcNl9UTyW/2wz2wcJLwQCwh9V8k7hcOMya8b6AgFStDAB1e6dHcsLR2w
   n0XtCIYDFRbEMQCfFPtRwNmbWLyG/2qE9HVpaOps3WvkxaOcYfp7Adhr6
   y106AP85zrowp/6cNcaoHy7LyovPYXp6Z9aapG8xvdLmb3DzRP1QMXBLX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229582038"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="229582038"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="471123228"
Received: from elenawei-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.138.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:12 -0800
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
Subject: [PATCH 09/13] cxl/region: Implement XHB verification
Date:   Thu,  6 Jan 2022 16:37:52 -0800
Message-Id: <20220107003756.806582-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107003756.806582-1-ben.widawsky@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cross host bridge verification primarily determines if the requested
interleave ordering can be achieved by the root decoder, which isn't as
programmable as other decoders.

The algorithm implemented here is based on the CXL Type 3 Memory Device
Software Guide, chapter 2.13.14

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .clang-format        |  2 +
 drivers/cxl/region.c | 89 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/trace.h  |  3 ++
 3 files changed, 93 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 15d4eaabc6b5..55f628f21722 100644
--- a/.clang-format
+++ b/.clang-format
@@ -169,6 +169,8 @@ ForEachMacros:
   - 'for_each_cpu_and'
   - 'for_each_cpu_not'
   - 'for_each_cpu_wrap'
+  - 'for_each_cxl_decoder_target'
+  - 'for_each_cxl_endpoint'
   - 'for_each_dapm_widgets'
   - 'for_each_dev_addr'
   - 'for_each_dev_scope'
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index c8e3c48dfbb9..ca559a4b5347 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -28,6 +28,17 @@
  */
 
 #define region_ways(region) ((region)->config.eniw)
+#define region_ig(region) (ilog2((region)->config.ig))
+
+#define for_each_cxl_endpoint(ep, region, idx)                                 \
+	for (idx = 0, ep = (region)->config.targets[idx];                      \
+	     idx < region_ways(region);                                        \
+	     idx++, ep = (region)->config.targets[idx])
+
+#define for_each_cxl_decoder_target(target, decoder, idx)                      \
+	for (idx = 0, target = (decoder)->target[idx];                         \
+	     idx < (decoder)->nr_targets;                                      \
+	     idx++, target++)
 
 static struct cxl_decoder *rootd_from_region(struct cxl_region *r)
 {
@@ -175,6 +186,30 @@ static bool qtg_match(const struct cxl_decoder *rootd,
 	return true;
 }
 
+static int get_unique_hostbridges(const struct cxl_region *region,
+				  struct cxl_port **hbs)
+{
+	struct cxl_memdev *ep;
+	int i, hb_count = 0;
+
+	for_each_cxl_endpoint(ep, region, i) {
+		struct cxl_port *hb = get_hostbridge(ep);
+		bool found = false;
+		int j;
+
+		BUG_ON(!hb);
+
+		for (j = 0; j < hb_count; j++) {
+			if (hbs[j] == hb)
+				found = true;
+		}
+		if (!found)
+			hbs[hb_count++] = hb;
+	}
+
+	return hb_count;
+}
+
 /**
  * region_xhb_config_valid() - determine cross host bridge validity
  * @rootd: The root decoder to check against
@@ -188,7 +223,59 @@ static bool qtg_match(const struct cxl_decoder *rootd,
 static bool region_xhb_config_valid(const struct cxl_region *region,
 				    const struct cxl_decoder *rootd)
 {
-	/* TODO: */
+	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	int rootd_ig, i;
+	struct cxl_dport *target;
+
+	/* Are all devices in this region on the same CXL host bridge */
+	if (get_unique_hostbridges(region, hbs) == 1)
+		return true;
+
+	rootd_ig = rootd->interleave_granularity;
+
+	/* CFMWS.HBIG >= Device.Label.IG */
+	if (rootd_ig < region_ig(region)) {
+		trace_xhb_valid(region,
+				"granularity does not support the region interleave granularity\n");
+		return false;
+	}
+
+	/* ((2^(CFMWS.HBIG - Device.RLabel.IG) * (2^CFMWS.ENIW)) > Device.RLabel.NLabel) */
+	if (1 << (rootd_ig - region_ig(region)) * (1 << rootd->interleave_ways) >
+	    region_ways(region)) {
+		trace_xhb_valid(region,
+				"granularity to device granularity ratio requires a larger number of devices than currently configured");
+		return false;
+	}
+
+	/* Check that endpoints are hooked up in the correct order */
+	for_each_cxl_decoder_target(target, rootd, i) {
+		struct cxl_memdev *endpoint = region->config.targets[i];
+
+		if (get_hostbridge(endpoint) != target->port) {
+			trace_xhb_valid(region, "device ordering bad\n");
+			return false;
+		}
+	}
+
+	/*
+	 * CFMWS.InterleaveTargetList[n] must contain all devices, x where:
+	 *	(Device[x],RegionLabel.Position >> (CFMWS.HBIG -
+	 *	Device[x].RegionLabel.InterleaveGranularity)) &
+	 *	((2^CFMWS.ENIW) - 1) = n
+	 *
+	 * Linux notes: All devices are known to have the same interleave
+	 * granularity at this point.
+	 */
+	for_each_cxl_decoder_target(target, rootd, i) {
+		if (((i >> (rootd_ig - region_ig(region)))) &
+		    (((1 << rootd->interleave_ways) - 1) != target->port_id)) {
+			trace_xhb_valid(region,
+					"One or more devices are not connected to the correct hostbridge.");
+			return false;
+		}
+	}
+
 	return true;
 }
 
diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
index a53f00ba5d0e..4de47d1111ac 100644
--- a/drivers/cxl/trace.h
+++ b/drivers/cxl/trace.h
@@ -38,6 +38,9 @@ DEFINE_EVENT(cxl_region_template, sanitize_failed,
 DEFINE_EVENT(cxl_region_template, allocation_failed,
 	     TP_PROTO(const struct cxl_region *region, char *status),
 	     TP_ARGS(region, status));
+DEFINE_EVENT(cxl_region_template, xhb_valid,
+	     TP_PROTO(const struct cxl_region *region, char *status),
+	     TP_ARGS(region, status));
 
 #endif /* if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ) */
 
-- 
2.34.1

