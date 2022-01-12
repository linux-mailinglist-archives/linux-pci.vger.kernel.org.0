Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A0C48CF46
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 00:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235683AbiALXsS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 18:48:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:13995 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235686AbiALXsL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 18:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642031291; x=1673567291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YMA0pG+JOi6lFn2sVT6bUQtUSO1rh2VV0YW8tAKi+II=;
  b=K0WIdPHBuMXzz7Mtk4WPN3eNYWf3FdWQuErOmqcwwELHFJ+8Sad/JSML
   mBeER7ucKeGKvVAnwC15uXVpUv/EM04Fc8I0WCpJLDKwRSaWqSSTwmHyo
   s8F/i0SPTwSjsGYdFvUIPjREfsVZUHS4zSUgyO1jgTU3LWDjnoOFRaKOK
   aEXqLfRYiBFsdxk81saOU26ueUpeRuiaYsAvl9qMFcQQJ4frmBgGmCmzW
   7G6HPEUxFISVyrrsTkvOcy9tZQBIr34ZD6FxyJMU2FqWa6IZb21X8BBRC
   O70xvT2sro/6OqPwHvu27IA3GA0irdi53lv+XFgauyy+bRixHVMC1lV9y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242695351"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242695351"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="670324199"
Received: from jmaclean-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.136.131])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:08 -0800
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
Subject: [PATCH v2 09/15] cxl/region: Implement XHB verification
Date:   Wed, 12 Jan 2022 15:47:43 -0800
Message-Id: <20220112234749.1965960-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112234749.1965960-1-ben.widawsky@intel.com>
References: <20220112234749.1965960-1-ben.widawsky@intel.com>
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
Changes since v1:
- Fix for_each_cxl_decoder_target definition (Jonathan)
- Fix math XHB granularity check (Jonathan)
- Remove bogus xhb check (Jonathan)
- Rename ig/eniw to prevent confusion
---
 .clang-format        |  2 +
 drivers/cxl/cxl.h    | 13 +++++++
 drivers/cxl/region.c | 93 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 107 insertions(+), 1 deletion(-)

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
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 19e65ed35796..c62e93e8a369 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -63,6 +63,19 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 	return val ? val * 2 : 1;
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
+	return 8 - ilog2(g);
+}
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index c12d9bd22705..c01b1ab9f757 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -28,6 +28,19 @@
  */
 
 #define region_ways(region) ((region)->config.interleave_ways)
+#define region_eniw(region) (cxl_to_eniw((region)->config.interleave_ways))
+#define region_granularity(region) ((region)->config.interleave_granularity)
+#define region_ig(region) (cxl_to_ig((region)->config.interleave_granularity))
+
+#define for_each_cxl_endpoint(ep, region, idx)                                 \
+	for (idx = 0, ep = (region)->config.targets[idx];                      \
+	     idx < region_ways(region);                                        \
+	     ep = (region)->config.targets[++idx])
+
+#define for_each_cxl_decoder_target(dport, decoder, idx)                      \
+	for (idx = 0, dport = (decoder)->target[idx];                         \
+	     idx < (decoder)->nr_targets;                                     \
+	     dport = (decoder)->target[++idx])
 
 static struct cxl_decoder *rootd_from_region(struct cxl_region *r)
 {
@@ -177,6 +190,30 @@ static bool qtg_match(const struct cxl_decoder *rootd,
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
@@ -190,7 +227,61 @@ static bool qtg_match(const struct cxl_decoder *rootd,
 static bool region_xhb_config_valid(const struct cxl_region *region,
 				    const struct cxl_decoder *rootd)
 {
-	/* TODO: */
+	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	struct cxl_dport *target;
+	int rootd_ig, i;
+
+	/* Are all devices in this region on the same CXL host bridge */
+	if (get_unique_hostbridges(region, hbs) == 1)
+		return true;
+
+	rootd_ig = cxl_to_ig(rootd->interleave_granularity);
+
+	/* CFMWS.HBIG >= Device.Label.IG */
+	if (rootd_ig < (region_ig(region))) {
+		dev_dbg(&region->dev,
+			"%s HBIG must be greater than region IG (%d < %d)\n",
+			dev_name(&rootd->dev), rootd_ig, region_ig(region));
+		return false;
+	}
+
+	/*
+	 * ((2^(CFMWS.HBIG - Device.RLabel.IG) * (2^CFMWS.ENIW)) > Device.RLabel.NLabel)
+	 *
+	 * Linux notes: 2^CFMWS.ENIW is trying to decode the NIW. Instead we use
+	 * the look up function which supports non power of 2 interleave
+	 * configurations.
+	 */
+	if (((1 << (rootd_ig - region_ig(region))) *
+	     (1 << cxl_to_eniw(rootd->interleave_ways))) >
+	    region_ways(region)) {
+		dev_dbg(&region->dev,
+			"granularity ratio requires a larger number of devices (%d) than currently configured (%d)\n",
+			((1 << (rootd_ig - region_ig(region))) *
+			 (1 << cxl_to_eniw(rootd->interleave_ways))),
+			region_ways(region));
+		return false;
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
+		if (((i >> (rootd_ig - region_granularity(region)))) &
+		    (((1 << cxl_to_eniw(rootd->interleave_ways)) - 1) !=
+		     target->port_id)) {
+			dev_dbg(&region->dev,
+				"One or more devices are not connected to the correct hostbridge.\n");
+			return false;
+		}
+	}
+
 	return true;
 }
 
-- 
2.34.1

