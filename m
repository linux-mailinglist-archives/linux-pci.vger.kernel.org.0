Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6523486EFA
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 01:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344348AbiAGAiN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 19:38:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:59445 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344344AbiAGAiN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 19:38:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641515893; x=1673051893;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cZTnKVoXNxhRnTeYjwBljyoNomUxyoelh6mPcgvMeyQ=;
  b=Andhc+0P21JCGB2lAWeu3yScI04/PAVlLUkl+Zxq1D2ZIMQhLLwR+7hI
   mMRaFwG+1QaPWreHSZ62zlDLce3BVdlGeTHEm7oYXG7geiKIn5DLGBlCc
   Xcgn5wpHRUTJntW00n/FCoRsBnCKXhGW+9sTzE7S9FyDnbM3YQLfHZ6yx
   OwlbU/2TJ2Nn79w2LEwmvESMCAiSn9naMj4eHqIvOFZwIg2H/WY3FIm9Z
   +Uvyg7tqvNPi4P9190J9d+m+q3dLH9gwnkKecXfTwhtr/77QWunLfp4pN
   4sMjOn6UryuGAUqS3mEsHfhAaqJDpnt6u+kTfsRNBUUn9myL+SrqZHJb0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229582041"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="229582041"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="471123234"
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
Subject: [PATCH 10/13] cxl/region: HB port config verification
Date:   Thu,  6 Jan 2022 16:37:53 -0800
Message-Id: <20220107003756.806582-11-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107003756.806582-1-ben.widawsky@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Host bridge root port verification determines if the device ordering in
an interleave set can be programmed through the host bridges and
switches.

The algorithm implemented here is based on the CXL Type 3 Memory Device
Software Guide, chapter 2.13.15

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 .clang-format           |   1 +
 drivers/cxl/core/port.c |   1 +
 drivers/cxl/cxl.h       |   2 +
 drivers/cxl/region.c    | 122 +++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/trace.h     |   3 +
 5 files changed, 128 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 55f628f21722..96c282b63e7b 100644
--- a/.clang-format
+++ b/.clang-format
@@ -171,6 +171,7 @@ ForEachMacros:
   - 'for_each_cpu_wrap'
   - 'for_each_cxl_decoder_target'
   - 'for_each_cxl_endpoint'
+  - 'for_each_cxl_endpoint_hb'
   - 'for_each_dapm_widgets'
   - 'for_each_dev_addr'
   - 'for_each_dev_scope'
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 67f3345d44ef..99589f23f1ff 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -585,6 +585,7 @@ struct cxl_dport *cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&dport->list);
+	INIT_LIST_HEAD(&dport->verify_link);
 	dport->dport = get_device(dport_dev);
 	dport->port_id = port_id;
 	dport->component_reg_phys = component_reg_phys;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 19e65ed35796..762da3621ca4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -303,6 +303,7 @@ struct cxl_port {
  * @port: reference to cxl_port that contains this downstream port
  * @list: node for a cxl_port's list of cxl_dport instances
  * @link_name: the name of the sysfs link from @port to @dport
+ * @verify_link: node used for hb root port verification
  */
 struct cxl_dport {
 	struct device *dport;
@@ -311,6 +312,7 @@ struct cxl_dport {
 	struct cxl_port *port;
 	struct list_head list;
 	char link_name[CXL_TARGET_STRLEN];
+	struct list_head verify_link;
 };
 
 /**
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index ca559a4b5347..87fdcf0049d8 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -4,6 +4,7 @@
 #include <linux/genalloc.h>
 #include <linux/device.h>
 #include <linux/module.h>
+#include <linux/sort.h>
 #include <linux/pci.h>
 #include "cxlmem.h"
 #include "region.h"
@@ -35,6 +36,12 @@
 	     idx < region_ways(region);                                        \
 	     idx++, ep = (region)->config.targets[idx])
 
+#define for_each_cxl_endpoint_hb(ep, region, hb, idx)                          \
+	for (idx = 0, (ep) = (region)->config.targets[idx];                    \
+	     idx < region_ways(region);                                        \
+	     idx++, (ep) = (region)->config.targets[idx])                      \
+		if (get_hostbridge(ep) == (hb))
+
 #define for_each_cxl_decoder_target(target, decoder, idx)                      \
 	for (idx = 0, target = (decoder)->target[idx];                         \
 	     idx < (decoder)->nr_targets;                                      \
@@ -279,6 +286,59 @@ static bool region_xhb_config_valid(const struct cxl_region *region,
 	return true;
 }
 
+static struct cxl_dport *get_rp(struct cxl_memdev *ep)
+{
+	struct cxl_port *port, *parent_port = port = ep->port;
+	struct cxl_dport *dport;
+
+	while (!is_cxl_root(port)) {
+		parent_port = to_cxl_port(port->dev.parent);
+		if (parent_port->depth == 1)
+			list_for_each_entry(dport, &parent_port->dports, list)
+				if (dport->dport == port->uport->parent->parent)
+					return dport;
+		port = parent_port;
+	}
+
+	BUG();
+	return NULL;
+}
+
+static int get_num_root_ports(const struct cxl_region *region)
+{
+	struct cxl_memdev *endpoint;
+	struct cxl_dport *dport, *tmp;
+	int num_root_ports = 0;
+	LIST_HEAD(root_ports);
+	int idx;
+
+	for_each_cxl_endpoint(endpoint, region, idx) {
+		struct cxl_dport *root_port = get_rp(endpoint);
+
+		if (list_empty(&root_port->verify_link)) {
+			list_add_tail(&root_port->verify_link, &root_ports);
+			num_root_ports++;
+		}
+	}
+
+	list_for_each_entry_safe(dport, tmp, &root_ports, verify_link)
+		list_del_init(&dport->verify_link);
+
+	return num_root_ports;
+}
+
+static bool has_switch(const struct cxl_region *region)
+{
+	struct cxl_memdev *ep;
+	int i;
+
+	for_each_cxl_endpoint(ep, region, i)
+		if (ep->port->depth > 2)
+			return true;
+
+	return false;
+}
+
 /**
  * region_hb_rp_config_valid() - determine root port ordering is correct
  * @rootd: root decoder for this @region
@@ -292,7 +352,67 @@ static bool region_xhb_config_valid(const struct cxl_region *region,
 static bool region_hb_rp_config_valid(const struct cxl_region *region,
 				      const struct cxl_decoder *rootd)
 {
-	/* TODO: */
+	const int num_root_ports = get_num_root_ports(region);
+	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	int hb_count, i;
+
+	hb_count = get_unique_hostbridges(region, hbs);
+
+	/*
+	 * Are all devices in this region on the same CXL Host Bridge
+	 * Root Port?
+	 */
+	if (num_root_ports == 1 && !has_switch(region))
+		return true;
+
+	for (i = 0; i < hb_count; i++) {
+		int idx, position_mask;
+		struct cxl_dport *rp;
+		struct cxl_port *hb;
+
+		/* Get next CXL Host Bridge this region spans */
+		hb = hbs[i];
+
+		/*
+		 * Calculate the position mask: NumRootPorts = 2^PositionMask
+		 * for this region.
+		 *
+		 * XXX: pos_mask is actually (1 << PositionMask)  - 1
+		 */
+		position_mask = (1 << (ilog2(num_root_ports))) - 1;
+
+		/*
+		 * Calculate the PortGrouping for each device on this CXL Host
+		 * Bridge Root Port:
+		 * PortGrouping = RegionLabel.Position & PositionMask
+		 */
+		list_for_each_entry(rp, &hb->dports, list) {
+			struct cxl_memdev *ep;
+			int port_grouping = -1;
+
+			for_each_cxl_endpoint_hb(ep, region, hb, idx) {
+				/* Only endpoints under the same root port */
+				if (get_rp(ep) != rp)
+					continue;
+
+				if (port_grouping == -1) {
+					port_grouping = idx & position_mask;
+					continue;
+				}
+
+				/*
+				 * Do all devices in the region connected to this CXL
+				 * Host Bridge Root Port have the same PortGrouping?
+				 */
+				if ((idx & position_mask) != port_grouping) {
+					trace_hb_rp_valid(region,
+							  "One or more devices are not connected to the correct Host Bridge Root Port\n");
+					return false;
+				}
+			}
+		}
+	}
+
 	return true;
 }
 
diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
index 4de47d1111ac..57fe9342817c 100644
--- a/drivers/cxl/trace.h
+++ b/drivers/cxl/trace.h
@@ -41,6 +41,9 @@ DEFINE_EVENT(cxl_region_template, allocation_failed,
 DEFINE_EVENT(cxl_region_template, xhb_valid,
 	     TP_PROTO(const struct cxl_region *region, char *status),
 	     TP_ARGS(region, status));
+DEFINE_EVENT(cxl_region_template, hb_rp_valid,
+	     TP_PROTO(const struct cxl_region *region, char *status),
+	     TP_ARGS(region, status));
 
 #endif /* if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ) */
 
-- 
2.34.1

