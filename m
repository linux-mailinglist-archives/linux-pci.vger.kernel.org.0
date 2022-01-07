Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22780486EF7
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 01:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344354AbiAGAiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 19:38:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:59439 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344344AbiAGAiM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 19:38:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641515892; x=1673051892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eNiUyuscoWrKsHcVFMNsIaXDCETVVg9aq2jH6C6HHIk=;
  b=S9q7es6LPk9S6wU6LYYfggF12ijzkevZuvlhqzjggA5rWGGxuvqctOY0
   6VLaoMJcka2Chs5HzsMEKFCyZVTAP8D+qzQxIDKGtHq/Pm5Z/z7TInCnV
   3kL+nPvRDJ7pZk8d8tczNADe8uaWOl/kQMX6f/AidRng0GVc8Os6oapJO
   x9aCKNpmOIhDlVihM9Zp9A1tQYX0vyXWlHfgZO2HsurmmC+jwEYUjav8n
   SKnjfa5aC17Wwu5h/065Mnd/YmZGMcAImYz+50dTZIyLrIit5SKaBP9Rk
   9d3JjV9CHII3FBDnYn6CE0q4fpGx6drF/lVQ9eRVfUuwCzJZEAUQZceYd
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229582036"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="229582036"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="471123223"
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
Subject: [PATCH 08/13] cxl/region: Address space allocation
Date:   Thu,  6 Jan 2022 16:37:51 -0800
Message-Id: <20220107003756.806582-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107003756.806582-1-ben.widawsky@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a region is not assigned a host physical address, one is picked by
the driver. As the address will determine which CFMWS contains the
region, it's usually a better idea to let the driver make this
determination.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/region.c | 38 ++++++++++++++++++++++++++++++++++++--
 drivers/cxl/trace.h  |  3 +++
 2 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index b458d7b97120..c8e3c48dfbb9 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
 #include <linux/platform_device.h>
+#include <linux/genalloc.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -62,6 +63,20 @@ static struct cxl_port *get_root_decoder(const struct cxl_memdev *endpoint)
 	return NULL;
 }
 
+static void release_cxl_region(void *r)
+{
+	struct cxl_region *region = (struct cxl_region *)r;
+	struct cxl_decoder *rootd = rootd_from_region(region);
+	struct resource *res = &rootd->platform_res;
+	resource_size_t start, size;
+
+	start = region->res->start;
+	size = resource_size(region->res);
+
+	__release_region(res, start, size);
+	gen_pool_free(rootd->address_space, start, size);
+}
+
 /**
  * sanitize_region() - Check is region is reasonably configured
  * @region: The region to check
@@ -111,8 +126,27 @@ static int sanitize_region(const struct cxl_region *region)
  */
 static int allocate_address_space(struct cxl_region *region)
 {
-	/* TODO */
-	return 0;
+	struct cxl_decoder *rootd = rootd_from_region(region);
+	unsigned long start;
+
+	start = gen_pool_alloc(rootd->address_space, region->config.size);
+	if (!start) {
+		trace_allocation_failed(region,
+					"Couldn't allocate address space");
+		return -ENOMEM;
+	}
+
+	region->res = __request_region(&rootd->platform_res, start,
+				       region->config.size,
+				       dev_name(&region->dev), IORESOURCE_MEM);
+	if (!region->res) {
+		trace_allocation_failed(region, "Couldn't obtain region");
+		gen_pool_free(rootd->address_space, start, region->config.size);
+		return -ENOMEM;
+	}
+
+	return devm_add_action_or_reset(&region->dev, release_cxl_region,
+					region);
 }
 
 /**
diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
index 8f7f471e15b8..a53f00ba5d0e 100644
--- a/drivers/cxl/trace.h
+++ b/drivers/cxl/trace.h
@@ -35,6 +35,9 @@ DEFINE_EVENT(cxl_region_template, region_activated,
 DEFINE_EVENT(cxl_region_template, sanitize_failed,
 	     TP_PROTO(const struct cxl_region *region, char *status),
 	     TP_ARGS(region, status));
+DEFINE_EVENT(cxl_region_template, allocation_failed,
+	     TP_PROTO(const struct cxl_region *region, char *status),
+	     TP_ARGS(region, status));
 
 #endif /* if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ) */
 
-- 
2.34.1

