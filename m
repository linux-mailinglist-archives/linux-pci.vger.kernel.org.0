Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDC548CF44
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 00:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbiALXsN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 18:48:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:13993 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235668AbiALXsJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 18:48:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642031289; x=1673567289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fs4eWwWtKQxb4Ql0idu7hLWWW+GKm1Vhmjtj9J1yEIw=;
  b=eailmkaa5vJCVU0ULaEi/EmVuQaSHA/X4WMHK5rh+8TI3l4HQRYrrQi2
   2HDTCvFwFcg+iFlNjfksGv2RHzZBXCVmC4imbd2KGoioXw8QUfDb4MLVr
   iRewGuYw2HyvwV1AGdGVHu3Oy0cF06cdBlRMPbFXvgfGmVaEkPOB5/dlZ
   A0Kv9OeUfp6iyCdBRFYdieKP+lfJpdP1HzbIyw5bBtc3eGbzcfB33zJLp
   8/fWjTSb7mJ94OMpsU0m3JW5XcA6IjNgMc9+HR67omQQfdZv579EgQGfw
   nBgduzN55yl8dLPr75bzF6klAQKQYR02u5xbF4XOmiY25xFkezm9Mt5jd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242695347"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242695347"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:08 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="670324196"
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
Subject: [PATCH v2 08/15] cxl/region: Address space allocation
Date:   Wed, 12 Jan 2022 15:47:42 -0800
Message-Id: <20220112234749.1965960-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112234749.1965960-1-ben.widawsky@intel.com>
References: <20220112234749.1965960-1-ben.widawsky@intel.com>
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
 drivers/cxl/region.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 53046da2e131..c12d9bd22705 100644
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
@@ -111,8 +126,29 @@ static int sanitize_region(const struct cxl_region *region)
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
+		dev_dbg(&region->dev,
+			"Couldn't allocate %lluM of address space",
+			region->config.size >> 20);
+		return -ENOMEM;
+	}
+
+	region->res = __request_region(&rootd->platform_res, start,
+				       region->config.size,
+				       dev_name(&region->dev), IORESOURCE_MEM);
+	if (!region->res) {
+		dev_dbg(&region->dev, "Couldn't obtain region from %s (%pR)\n",
+			dev_name(&rootd->dev), &rootd->platform_res);
+		gen_pool_free(rootd->address_space, start, region->config.size);
+		return -ENOMEM;
+	}
+
+	return devm_add_action_or_reset(&region->dev, release_cxl_region,
+					region);
 }
 
 /**
-- 
2.34.1

