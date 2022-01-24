Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3600497683
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240585AbiAXA3f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:29:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:5516 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240573AbiAXA3f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:29:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984174; x=1674520174;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Na3Srh7RAlzCpu8KaRMYXfw0Dnvg6QJ1LrH+KrSohok=;
  b=X5hyKmG6/B3KPxrsdP9swgEv9gsdrmiJMvdB61YkDTKc7kp+/63wC5uS
   vgl4cj434EmWPEgA/aq5l4ZFL3VXOyPA30L97HOcyIhY5Eemb86UvS18M
   w4qJjRfI4emQLvOeFwha92Da4KJ+xN2F5RtnaLeLxy4ny+UNRnOS6YiU2
   2CFCzaTPl184dmjDcdNbljd2aH7O7ZWj0I5t2YViPyFyLxfBOmyA7FBYj
   26bW/kcn0hbwHmPRg6n7bOMYNdKCrEFGTbQkmctu4YEdx+RZyLt8AfJgy
   T2ZOhaXV/vzHacW39oUdyYKoQBkEsCG4R1W/2I5lQF798uiOciU1t3i1j
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332288792"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332288792"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="768516986"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:32 -0800
Subject: [PATCH v3 10/40] cxl/core: Convert decoder range to resource
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:29:31 -0800
Message-ID: <164298417191.3018233.5201055578165414714.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

CXL decoders manage address ranges in a hierarchical fashion whereby a
leaf is a unique subregion of its parent decoder (midlevel or root). It
therefore makes sense to use the resource API for handling this.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> (v1)
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      |   22 ++++++++--------------
 drivers/cxl/core/port.c |   23 +++++++++++++++++++++--
 drivers/cxl/cxl.h       |    8 ++++++--
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index c656a49a11a9..da70f1836db6 100644
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
 
@@ -121,14 +119,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	else
 		rc = cxl_decoder_autoremove(dev, cxld);
 	if (rc) {
-		dev_err(dev, "Failed to add decoder for %#llx-%#llx\n",
-			cfmws->base_hpa,
-			cfmws->base_hpa + cfmws->window_size - 1);
+		dev_err(dev, "Failed to add decoder for %pr\n",
+			&cxld->platform_res);
 		return 0;
 	}
-	dev_dbg(dev, "add: %s node: %d range %#llx-%#llx\n",
-		dev_name(&cxld->dev), phys_to_target_node(cxld->range.start),
-		cfmws->base_hpa, cfmws->base_hpa + cfmws->window_size - 1);
+	dev_dbg(dev, "add: %s node: %d range %pr\n", dev_name(&cxld->dev),
+		phys_to_target_node(cxld->platform_res.start),
+		&cxld->platform_res);
 
 	return 0;
 }
@@ -270,10 +267,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
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
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index c5e74c6f04e8..63c76cb2a2ec 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -46,8 +46,14 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	u64 start;
 
-	return sysfs_emit(buf, "%#llx\n", cxld->range.start);
+	if (is_root_decoder(dev))
+		start = cxld->platform_res.start;
+	else
+		start = cxld->decoder_range.start;
+
+	return sysfs_emit(buf, "%#llx\n", start);
 }
 static DEVICE_ATTR_ADMIN_RO(start);
 
@@ -55,8 +61,14 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 			char *buf)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	u64 size;
+
+	if (is_root_decoder(dev))
+		size = resource_size(&cxld->platform_res);
+	else
+		size = range_len(&cxld->decoder_range);
 
-	return sysfs_emit(buf, "%#llx\n", range_len(&cxld->range));
+	return sysfs_emit(buf, "%#llx\n", size);
 }
 static DEVICE_ATTR_RO(size);
 
@@ -546,6 +558,13 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 	if (rc)
 		return rc;
 
+	/*
+	 * Platform decoder resources should show up with a reasonable name. All
+	 * other resources are just sub ranges within the main decoder resource.
+	 */
+	if (is_root_decoder(dev))
+		cxld->platform_res.name = dev_name(dev);
+
 	return device_add(dev);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 38779409a419..bfd95acea66c 100644
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

