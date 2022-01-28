Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7EB49EFB1
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 01:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbiA1A3H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 19:29:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:64738 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344645AbiA1A27 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 19:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643329739; x=1674865739;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JRLB7CUs7371NAYrkD3KPcwzK+rjDWnGSvurqfC0vT4=;
  b=lz63mU2OkRUz32E7BLbF3tF/KD7caXURCP7fZNuEW8neAdLWhD++xvbp
   DzJxB8S2a0PRF2XPOt0f9XoHuPAsrwnO+boGiqv9JEDUet/qQB2xdJMLR
   F0sqe9G2QgedaHiCF2aItw2ffGLDXiNu6fOMyLs6PbodDMGEIDSIJlGAh
   VPIs0yS7dtyMJzoXr/TIbdakAu/1UIOKldttexIxOyvoIwJdUsCYy7Phm
   1JYdVx9shSCQdBxe+rB+EIPsauOxwhpW9Ma+zY6bDMoRn2QuZyI4ShO0O
   QalSGV1f1OsF/NGK7CW0VlPt7lJ9JzI02tiMeD1UApAzoxMUsb1z78gFr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230580010"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="230580010"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="674909627"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:25 -0800
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
Subject: [PATCH v3 06/14] cxl/region: Address space allocation
Date:   Thu, 27 Jan 2022 16:26:59 -0800
Message-Id: <20220128002707.391076-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128002707.391076-1-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
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
index cc41939a2f0a..5588873dd250 100644
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
@@ -64,6 +65,20 @@ static struct cxl_port *get_root_decoder(const struct cxl_memdev *endpoint)
 	return NULL;
 }
 
+static void release_cxl_region(void *r)
+{
+	struct cxl_region *cxlr = (struct cxl_region *)r;
+	struct cxl_decoder *rootd = rootd_from_region(cxlr);
+	struct resource *res = &rootd->platform_res;
+	resource_size_t start, size;
+
+	start = cxlr->res->start;
+	size = resource_size(cxlr->res);
+
+	__release_region(res, start, size);
+	gen_pool_free(rootd->address_space, start, size);
+}
+
 /**
  * sanitize_region() - Check is region is reasonably configured
  * @cxlr: The region to check
@@ -129,8 +144,29 @@ static int sanitize_region(const struct cxl_region *cxlr)
  */
 static int allocate_address_space(struct cxl_region *cxlr)
 {
-	/* TODO */
-	return 0;
+	struct cxl_decoder *rootd = rootd_from_region(cxlr);
+	unsigned long start;
+
+	start = gen_pool_alloc(rootd->address_space, cxlr->config.size);
+	if (!start) {
+		dev_dbg(&cxlr->dev, "Couldn't allocate %lluM of address space",
+			cxlr->config.size >> 20);
+		return -ENOMEM;
+	}
+
+	cxlr->res =
+		__request_region(&rootd->platform_res, start, cxlr->config.size,
+				 dev_name(&cxlr->dev), IORESOURCE_MEM);
+	if (!cxlr->res) {
+		dev_dbg(&cxlr->dev, "Couldn't obtain region from %s (%pR)\n",
+			dev_name(&rootd->dev), &rootd->platform_res);
+		gen_pool_free(rootd->address_space, start, cxlr->config.size);
+		return -ENOMEM;
+	}
+
+	dev_dbg(&cxlr->dev, "resource %pR", cxlr->res);
+
+	return devm_add_action_or_reset(&cxlr->dev, release_cxl_region, cxlr);
 }
 
 /**
-- 
2.35.0

