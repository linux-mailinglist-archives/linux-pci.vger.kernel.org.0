Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB7449EFB5
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 01:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241307AbiA1A3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 19:29:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:64728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344747AbiA1A3H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 19:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643329747; x=1674865747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8bZ/y5CvmAUZBLyNdbWRgpD9oM1QXHWBY0H6dpPm7No=;
  b=j4R5nifL3gH5AnhYpR25+9tyou3W0VrB6lB/EAeh2zGHiZpF2Utuqjpo
   XaNdMFhRMlVQaNHrlK3YyVWuQYlcxefLYlgxP13FI2fsMEifjF4Jv8zJu
   fvGkwXIsvgdprrrgR46hObZOtjNq1EYaMA3T3OF17EJDbQuPKJR7tuYNF
   A6FyhPEPSBU9NEL+sCrlvEZMLv0WRA0nAl+ZKa+nVVX+eX2cdVlAZPv2J
   VosGrx369PJ7U28SHHmro2GCX04EuU2QAANZf1Mzbbs4rLmMZ84nhE/dE
   l3OjNurCBPlOir/QIHmvaPk3SmjLBRaxkYVlpMU1+jU3ZIIS7u2+N9xJ1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230580023"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="230580023"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="674909654"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:28 -0800
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
Subject: [PATCH v3 11/14] cxl/region: Add support for single switch level
Date:   Thu, 27 Jan 2022 16:27:04 -0800
Message-Id: <20220128002707.391076-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128002707.391076-1-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CXL switches have HDM decoders just like host bridges and endpoints.
Their programming works in a similar fashion.

The spec does not prohibit multiple levels of switches, however, those
are not implemented at this time.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/cxl.h    |  5 ++++
 drivers/cxl/region.c | 61 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 8ace6cca0776..d70d8c85d05f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -96,6 +96,11 @@ static inline u8 cxl_to_ig(u16 g)
 	return ilog2(g) - 8;
 }
 
+static inline int cxl_to_ways(u8 ways)
+{
+	return 1 << ways;
+}
+
 static inline bool cxl_is_interleave_ways_valid(int iw)
 {
 	switch (iw) {
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index b8982be13bfe..f748060733dd 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -359,6 +359,23 @@ static bool has_switch(const struct cxl_region *cxlr)
 	return false;
 }
 
+static bool has_multi_switch(const struct cxl_region *cxlr)
+{
+	struct cxl_memdev *ep;
+	int i;
+
+	for_each_cxl_endpoint(ep, cxlr, i)
+		if (ep->port->depth > 3)
+			return true;
+
+	return false;
+}
+
+static struct cxl_port *get_switch(struct cxl_memdev *ep)
+{
+	return to_cxl_port(ep->port->dev.parent);
+}
+
 static struct cxl_decoder *get_decoder(struct cxl_region *cxlr,
 				       struct cxl_port *p)
 {
@@ -409,6 +426,8 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
 				      const struct cxl_decoder *rootd,
 				      bool state_update)
 {
+	const int region_ig = cxl_to_ig(cxlr->config.interleave_granularity);
+	const int region_eniw = cxl_to_eniw(cxlr->config.interleave_ways);
 	const int num_root_ports = get_num_root_ports(cxlr);
 	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
 	struct cxl_decoder *cxld, *c;
@@ -416,8 +435,12 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
 
 	hb_count = get_unique_hostbridges(cxlr, hbs);
 
-	/* TODO: Switch support */
-	if (has_switch(cxlr))
+	/* TODO: support multiple levels of switches */
+	if (has_multi_switch(cxlr))
+		return false;
+
+	/* TODO: x3 interleave for switches is hard. */
+	if (has_switch(cxlr) && !is_power_of_2(region_ways(cxlr)))
 		return false;
 
 	/*
@@ -470,8 +493,14 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
 		list_for_each_entry(rp, &hb->dports, list) {
 			struct cxl_memdev *ep;
 			int port_grouping = -1;
+			int target_ndx;
 
 			for_each_cxl_endpoint_hb(ep, cxlr, hb, idx) {
+				struct cxl_decoder *switch_cxld;
+				struct cxl_dport *target;
+				struct cxl_port *switch_port;
+				bool found = false;
+
 				if (get_rp(ep) != rp)
 					continue;
 
@@ -499,6 +528,34 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
 
 				cxld->interleave_ways++;
 				cxld->target[port_grouping] = get_rp(ep);
+
+				/*
+				 * At least one switch is connected here if the endpoint
+				 * has a depth > 2
+				 */
+				if (ep->port->depth == 2)
+					continue;
+
+				/* Check the staged list to see if this
+				 * port has already been added
+				 */
+				switch_port = get_switch(ep);
+				list_for_each_entry(switch_cxld, &cxlr->staged_list, region_link) {
+					if (to_cxl_port(switch_cxld->dev.parent) == switch_port)
+						found = true;
+				}
+
+				if (found) {
+					target = cxl_find_dport_by_dev(switch_port, ep->dev.parent->parent);
+					switch_cxld->target[target_ndx++] = target;
+					continue;
+				}
+
+				target_ndx = 0;
+
+				switch_cxld = get_decoder(cxlr, switch_port);
+				switch_cxld->interleave_ways++;
+				switch_cxld->interleave_granularity = cxl_to_ways(region_ig + region_eniw);
 			}
 		}
 	}
-- 
2.35.0

