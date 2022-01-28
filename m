Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EF49EFBD
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 01:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241510AbiA1A3R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 19:29:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:64771 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344769AbiA1A3J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 19:29:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643329749; x=1674865749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/qLuADfUOCfFVCPn9Z+LbWyL/p2QgPjE/xoSdfj8Kj0=;
  b=CfNi5SVlutfDHycHis2Srtz8wjvYHfwM+0mcGNVLSIxuTmyCrolEEoAJ
   oIcu3r9TUHNZof20AMZrKcyBSS4xBB5EVbk+D8WEZT9/wma5sY73T5pIy
   STf91fXtTP/fQ42bpRmGVSqXBJlJBzPxecApNVAB7A1fvSRTNiyhxGpUR
   L4D6Oexl2OpteuOpVODES1CxUBtnzL5e3pWNp6Md8jPA99A2FaS1TouyM
   En+2KBu3OmOJvPyExqGNLJ66/CLNw9RXaH7P8/6m2JccD4m22l9VP1oUD
   h0y6s42/vAXzcLhdLSar10gK2N7rLpTWeLRyDCCt2Le28VpZry5YxBzup
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230580012"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="230580012"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="674909631"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:26 -0800
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
Subject: [PATCH v3 07/14] cxl/region: Implement XHB verification
Date:   Thu, 27 Jan 2022 16:27:00 -0800
Message-Id: <20220128002707.391076-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128002707.391076-1-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
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
Changes since v2:
- Fail earlier on lack of host bridges. This should only be capable as
  of now with cxl_test memdevs.
---
 .clang-format        |  2 +
 drivers/cxl/cxl.h    | 13 +++++++
 drivers/cxl/region.c | 89 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index fa959436bcfd..1221d53be90b 100644
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
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b300673072f5..a291999431c7 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -81,6 +81,19 @@ static inline int cxl_to_interleave_ways(u8 eniw)
 	}
 }
 
+static inline u8 cxl_to_eniw(u8 ways)
+{
+	if (is_power_of_2(ways))
+		return ilog2(ways);
+
+	return ways / 3 + 8;
+}
+
+static inline u8 cxl_to_ig(u16 g)
+{
+	return ilog2(g) - 8;
+}
+
 static inline bool cxl_is_interleave_ways_valid(int iw)
 {
 	switch (iw) {
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 5588873dd250..562c8720da56 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -29,6 +29,17 @@
 
 #define region_ways(region) ((region)->config.interleave_ways)
 #define region_granularity(region) ((region)->config.interleave_granularity)
+#define region_eniw(region) (cxl_to_eniw(region_ways(region)))
+#define region_ig(region) (cxl_to_ig(region_granularity(region)))
+
+#define for_each_cxl_endpoint(ep, region, idx)                                 \
+	for (idx = 0, ep = (region)->config.targets[idx];                      \
+	     idx < region_ways(region); ep = (region)->config.targets[++idx])
+
+#define for_each_cxl_decoder_target(dport, decoder, idx)                       \
+	for (idx = 0, dport = (decoder)->target[idx];                          \
+	     idx < (decoder)->nr_targets - 1;                                  \
+	     dport = (decoder)->target[++idx])
 
 static struct cxl_decoder *rootd_from_region(struct cxl_region *cxlr)
 {
@@ -195,6 +206,30 @@ static bool qtg_match(const struct cxl_decoder *rootd,
 	return true;
 }
 
+static int get_unique_hostbridges(const struct cxl_region *cxlr,
+				  struct cxl_port **hbs)
+{
+	struct cxl_memdev *ep;
+	int i, hb_count = 0;
+
+	for_each_cxl_endpoint(ep, cxlr, i) {
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
  * @cxlr: The region being programmed
@@ -208,7 +243,59 @@ static bool qtg_match(const struct cxl_decoder *rootd,
 static bool region_xhb_config_valid(const struct cxl_region *cxlr,
 				    const struct cxl_decoder *rootd)
 {
-	/* TODO: */
+	const int rootd_eniw = cxl_to_eniw(rootd->interleave_ways);
+	const int rootd_ig = cxl_to_ig(rootd->interleave_granularity);
+	const int cxlr_ig = region_ig(cxlr);
+	const int cxlr_iw = region_ways(cxlr);
+	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	struct cxl_dport *target;
+	int i;
+
+	i = get_unique_hostbridges(cxlr, hbs);
+	if (dev_WARN_ONCE(&cxlr->dev, i == 0, "Cannot find a valid host bridge\n"))
+		return false;
+
+	/* Are all devices in this region on the same CXL host bridge */
+	if (i == 1)
+		return true;
+
+	/* CFMWS.HBIG >= Device.Label.IG */
+	if (rootd_ig < cxlr_ig) {
+		dev_dbg(&cxlr->dev,
+			"%s HBIG must be greater than region IG (%d < %d)\n",
+			dev_name(&rootd->dev), rootd_ig, cxlr_ig);
+		return false;
+	}
+
+	/*
+	 * ((2^(CFMWS.HBIG - Device.RLabel.IG) * (2^CFMWS.ENIW)) > Device.RLabel.NLabel)
+	 *
+	 * XXX: 2^CFMWS.ENIW is trying to decode the NIW. Instead, use the look
+	 * up function which supports non power of 2 interleave configurations.
+	 */
+	if (((1 << (rootd_ig - cxlr_ig)) * (1 << rootd_eniw)) > cxlr_iw) {
+		dev_dbg(&cxlr->dev,
+			"granularity ratio requires a larger number of devices (%d) than currently configured (%d)\n",
+			((1 << (rootd_ig - cxlr_ig)) * (1 << rootd_eniw)),
+			cxlr_iw);
+		return false;
+	}
+
+	/*
+	 * CFMWS.InterleaveTargetList[n] must contain all devices, x where:
+	 *	(Device[x],RegionLabel.Position >> (CFMWS.HBIG -
+	 *	Device[x].RegionLabel.InterleaveGranularity)) &
+	 *	((2^CFMWS.ENIW) - 1) = n
+	 */
+	for_each_cxl_decoder_target(target, rootd, i) {
+		if (((i >> (rootd_ig - cxlr_ig))) &
+		    (((1 << rootd_eniw) - 1) != target->port_id)) {
+			dev_dbg(&cxlr->dev,
+				"One or more devices are not connected to the correct hostbridge.\n");
+			return false;
+		}
+	}
+
 	return true;
 }
 
-- 
2.35.0

