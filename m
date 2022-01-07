Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51445486EF8
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 01:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbiAGAiM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 19:38:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:59439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344330AbiAGAiM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 19:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641515892; x=1673051892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HuSvgVpzJSSAubpqgAFpQpX4vcFnujpazSMVsY3KGZ8=;
  b=DsSIQ8Em++A555gTdTJsiG6DURhmDAjIhPo41pN6zZUmZoWbE1B+xCA+
   4dnN7/DtXWD0ltq2na7mT/jYQXuA+hZOmZ1GtYuBAB3CKuCLOjk0QiRMh
   TraN3vW1AmEczDwKqiHQarr53cETuUr4+LmAoDMJTnOiUnP0YJUg2T/BE
   zTYlSTBer7eHk4jqoOiJaZjDnAoQegT5iyZY2Dlg0vgUI/C/EyQQdqhH8
   LCmhqmrRqhiaA2Jb/AjDi01M9lDzK9dMgvc12C1tlpf97GU6aYVEQfiAq
   LXHdWlKKsIx5DjQ76erAbekELn0XGFToP1GKYiMm3eIDes0XUlfxkN5EC
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229582031"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="229582031"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="471123218"
Received: from elenawei-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.138.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:11 -0800
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
Subject: [PATCH 07/13] cxl/acpi: Handle address space allocation
Date:   Thu,  6 Jan 2022 16:37:50 -0800
Message-Id: <20220107003756.806582-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107003756.806582-1-ben.widawsky@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Regions are carved out of an addresses space which is claimed by top
level decoders, and subsequently their children decoders. Regions are
created with a size and therefore must fit, with proper alignment, in
that address space. The support for doing this fitting is handled by the
driver automatically.

As an example, a platform might configure a top level decoder to claim
1TB of address space @ 0x800000000 -> 0x10800000000; it would be
possible to create M regions with appropriate alignment to occupy that
address space. Each of those regions would have a host physical address
somewhere in the range between 32G and 1.3TB, and the location will be
determined by the logic added here.

The request_region() usage is not strictly mandatory at this point as
the actual handling of the address space is done with genpools. It is
highly likely however that the resource/region APIs will become useful
in the not too distant future.

All decoders manage a host physical address space while active. Only the
root decoder has constraints on location and size. As a result, it makes
most sense for the root decoder to be responsible for managing the
entire address space, and mid-level decoders and endpoints can ask the
root decoder for suballocations.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/acpi.c   | 30 ++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h    |  2 ++
 drivers/cxl/region.c | 12 ++++++------
 3 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 4c746a6ef48c..a7ce0d660b34 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
 #include <linux/platform_device.h>
+#include <linux/genalloc.h>
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
@@ -73,6 +74,27 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 	return 0;
 }
 
+/*
+ * Every decoder while active has an address space that it is decoding. However,
+ * only the root level decoders have fixed host physical address space ranges.
+ */
+static int cxl_create_cfmws_address_space(struct cxl_decoder *cxld,
+					  struct acpi_cedt_cfmws *cfmws)
+{
+	const int order = ilog2(SZ_256M * cxld->interleave_ways);
+	struct device *dev = &cxld->dev;
+	struct gen_pool *pool;
+
+	pool = devm_gen_pool_create(dev, order, NUMA_NO_NODE, dev_name(dev));
+	if (IS_ERR(pool))
+		return PTR_ERR(pool);
+
+	cxld->address_space = pool;
+
+	return gen_pool_add(cxld->address_space, cfmws->base_hpa,
+			    cfmws->window_size, NUMA_NO_NODE);
+}
+
 struct cxl_cfmws_context {
 	struct device *dev;
 	struct cxl_port *root_port;
@@ -113,6 +135,14 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
 	cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
 
+	rc = cxl_create_cfmws_address_space(cxld, cfmws);
+	if (rc) {
+		dev_err(dev,
+			"Failed to create CFMWS address space for decoder\n");
+		put_device(&cxld->dev);
+		return 0;
+	}
+
 	rc = cxl_decoder_add(cxld, target_map);
 	if (rc)
 		put_device(&cxld->dev);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b318cabfc4a2..19e65ed35796 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -207,6 +207,7 @@ enum cxl_decoder_type {
  * @target_type: accelerator vs expander (type2 vs type3) selector
  * @flags: memory type capabilities and locking
  * @region_ida: allocator for region ids.
+ * @address_space: Used/free address space for regions.
  * @nr_targets: number of elements in @target
  * @target: active ordered target list in current decoder configuration
  */
@@ -222,6 +223,7 @@ struct cxl_decoder {
 	enum cxl_decoder_type target_type;
 	unsigned long flags;
 	struct ida region_ida;
+	struct gen_pool *address_space;
 	const int nr_targets;
 	struct cxl_dport *target[];
 };
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 9174925b67e3..b458d7b97120 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -126,7 +126,7 @@ static bool find_cdat_dsmas(const struct cxl_region *region)
 
 /**
  * qtg_match() - Does this CFMWS have desirable QTG for the endpoint
- * @cfmws: The CFMWS for the region
+ * @rootd: The root decoder for the region
  * @endpoint: Endpoint whose QTG is being compared
  *
  * Prior to calling this function, the caller should verify that all endpoints
@@ -134,7 +134,7 @@ static bool find_cdat_dsmas(const struct cxl_region *region)
  *
  * Returns true if the QTG ID of the CFMWS matches the endpoint
  */
-static bool qtg_match(const struct cxl_decoder *cfmws,
+static bool qtg_match(const struct cxl_decoder *rootd,
 		      const struct cxl_memdev *endpoint)
 {
 	/* TODO: */
@@ -143,7 +143,7 @@ static bool qtg_match(const struct cxl_decoder *cfmws,
 
 /**
  * region_xhb_config_valid() - determine cross host bridge validity
- * @cfmws: The CFMWS to check against
+ * @rootd: The root decoder to check against
  * @region: The region being programmed
  *
  * The algorithm is outlined in 2.13.14 "Verify XHB configuration sequence" of
@@ -152,7 +152,7 @@ static bool qtg_match(const struct cxl_decoder *cfmws,
  * Returns true if the configuration is valid.
  */
 static bool region_xhb_config_valid(const struct cxl_region *region,
-				    const struct cxl_decoder *cfmws)
+				    const struct cxl_decoder *rootd)
 {
 	/* TODO: */
 	return true;
@@ -160,7 +160,7 @@ static bool region_xhb_config_valid(const struct cxl_region *region,
 
 /**
  * region_hb_rp_config_valid() - determine root port ordering is correct
- * @cfmws: CFMWS decoder for this @region
+ * @rootd: root decoder for this @region
  * @region: Region to validate
  *
  * The algorithm is outlined in 2.13.15 "Verify HB root port configuration
@@ -169,7 +169,7 @@ static bool region_xhb_config_valid(const struct cxl_region *region,
  * Returns true if the configuration is valid.
  */
 static bool region_hb_rp_config_valid(const struct cxl_region *region,
-				      const struct cxl_decoder *cfmws)
+				      const struct cxl_decoder *rootd)
 {
 	/* TODO: */
 	return true;
-- 
2.34.1

