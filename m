Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F10B4579E9
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbhKTAGQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:16 -0500
Received: from mga12.intel.com ([192.55.52.136]:5724 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231298AbhKTAGK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542405"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542405"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:57 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088370"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:57 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 10/23] cxl/core: Convert decoder range to resource
Date:   Fri, 19 Nov 2021 16:02:37 -0800
Message-Id: <20211120000250.1663391-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CXL decoders manage address ranges in a hierarchical fashion whereby a
leaf is a unique subregion of its parent decoder (midlevel or root). It
therefore makes sense to use the resource API for handling this.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
Changes since RFCv2
- Switch to DEFINE_RES_MEM from NAMED variant (Dan)
- Differentiate CFMWS resources and other decoder resources (Ben)
- Make decoder resources be range, nor resource (Dan)
- Set decoder name in cxl_decoder_add() (Dan)
---
 drivers/cxl/acpi.c     | 16 ++++++----------
 drivers/cxl/core/bus.c | 19 +++++++++++++++++--
 drivers/cxl/cxl.h      |  8 ++++++--
 3 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 7cfa8b568013..3415184a2e61 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -108,10 +108,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 	cxld->target_type = CXL_DECODER_EXPANDER;
-	cxld->range = (struct range){
-		.start = cfmws->base_hpa,
-		.end = cfmws->base_hpa + cfmws->window_size - 1,
-	};
+	cxld->platform_res = (struct resource)DEFINE_RES_MEM(cfmws->base_hpa,
+							     cfmws->window_size);
 	cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
 	cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
 
@@ -127,8 +125,9 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		return 0;
 	}
 	dev_dbg(dev, "add: %s node: %d range %#llx-%#llx\n",
-		dev_name(&cxld->dev), phys_to_target_node(cxld->range.start),
-		cfmws->base_hpa, cfmws->base_hpa + cfmws->window_size - 1);
+		dev_name(&cxld->dev),
+		phys_to_target_node(cxld->platform_res.start), cfmws->base_hpa,
+		cfmws->base_hpa + cfmws->window_size - 1);
 
 	return 0;
 }
@@ -267,10 +266,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	cxld->interleave_ways = 1;
 	cxld->interleave_granularity = PAGE_SIZE;
 	cxld->target_type = CXL_DECODER_EXPANDER;
-	cxld->range = (struct range) {
-		.start = 0,
-		.end = -1,
-	};
+	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
 
 	device_lock(&port->dev);
 	dport = list_first_entry(&port->dports, typeof(*dport), list);
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 17a4fff029f8..8e80e85350b1 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -46,8 +46,14 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	u64 start = 0;
 
-	return sysfs_emit(buf, "%#llx\n", cxld->range.start);
+	if (is_root_decoder(dev))
+		start = cxld->platform_res.start;
+	else
+		start = cxld->decoder_range.start;
+
+	return sysfs_emit(buf, "%#llx\n", start);
 }
 static DEVICE_ATTR_RO(start);
 
@@ -55,8 +61,14 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	u64 size = 0;
 
-	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->range));
+	if (is_root_decoder(dev))
+		size = resource_size(&cxld->platform_res);
+	else
+		size = range_len(&cxld->decoder_range);
+
+	return sysfs_emit(buf, "%#llx\n", size);
 }
 static DEVICE_ATTR_RO(size);
 
@@ -548,6 +560,9 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 	if (rc)
 		return rc;
 
+	if (is_root_decoder(dev))
+		cxld->platform_res.name = dev_name(dev);
+
 	return device_add(dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d39d45f4a770..ad816fb5bdcc 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -179,7 +179,8 @@ enum cxl_decoder_type {
  * struct cxl_decoder - CXL address range decode configuration
  * @dev: this decoder's device
  * @id: kernel device name id
- * @range: address range considered by this decoder
+ * @platform_res: address space resources considered by root decoder
+ * @decoder_range: address space resources considered by midlevel decoder
  * @interleave_ways: number of cxl_dports in this decode
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
@@ -190,7 +191,10 @@ enum cxl_decoder_type {
 struct cxl_decoder {
 	struct device dev;
 	int id;
-	struct range range;
+	union {
+		struct resource platform_res;
+		struct range decoder_range;
+	};
 	int interleave_ways;
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
-- 
2.34.0

