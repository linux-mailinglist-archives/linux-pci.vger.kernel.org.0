Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6968E4976BB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiAXAcH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:32:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:36087 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235572AbiAXAcH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984327; x=1674520327;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V/dkc4CPx3gEN+GZBGOIM656AJunaWwi1Z0Gl1UWTVk=;
  b=blZKgYvGomWDyf0HskXQk4iu1toFZh/8Ltx+vPwp7tV6Tp3cjXOQfPLK
   wp3Rs7OmWk/7yyfwBeN22bSEPAdonMhDS4+RD9MuX/259cwZf4x1sBU3y
   jwgwB5td4WZNzUrOvHa4HuKXb1qnijtHgZAhdse7VRLM76G6fKJMojMdV
   xjT2v9I8yshaXYkByiuAb17jptCimq04Uis/fUIDDcNfDiCbjVgxJyxc3
   99DnJbNe/Bhk4OgE0PX2/L80bG4XdLqhgOXn/pswBfG6JPTGam7hXAaHG
   dEiPd4/H0NLUgUpeni6Xc0xbk4tSkcz06frNldptk98IamurE0yTLfJ71
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233292607"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233292607"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:32:07 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="519731468"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:32:07 -0800
Subject: [PATCH v3 39/40] tools/testing/cxl: Enumerate mock decoders
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:32:07 -0800
Message-ID: <164298432699.3018233.12131068635065601541.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enumerate 2-decoders per switch port and endpoint in the cxl_test
topology.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/cxl.c |  118 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 98 insertions(+), 20 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index ea88fabc3198..1b36e67dcd7e 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -14,6 +14,7 @@
 #define NR_CXL_HOST_BRIDGES 2
 #define NR_CXL_ROOT_PORTS 2
 #define NR_CXL_SWITCH_PORTS 2
+#define NR_CXL_PORT_DECODERS 2
 
 static struct platform_device *cxl_acpi;
 static struct platform_device *cxl_host_bridge[NR_CXL_HOST_BRIDGES];
@@ -406,38 +407,115 @@ static int mock_cxl_add_passthrough_decoder(struct cxl_port *port)
 	return -EOPNOTSUPP;
 }
 
-static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
+
+struct target_map_ctx {
+	int *target_map;
+	int index;
+	int target_count;
+};
+
+static int map_targets(struct device *dev, void *data)
 {
+	struct platform_device *pdev = to_platform_device(dev);
+	struct target_map_ctx *ctx = data;
+
+	ctx->target_map[ctx->index++] = pdev->id;
+
+	if (ctx->index > ctx->target_count) {
+		dev_WARN_ONCE(dev, 1, "too many targets found?\n");
+		return -ENXIO;
+	}
+
 	return 0;
 }
 
-static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
+static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 {
-	struct device *dev = &port->dev;
-	int i;
+	struct cxl_port *port = cxlhdm->port;
+	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	int target_count, i;
+
+	if (is_cxl_endpoint(port))
+		target_count = 0;
+	else if (is_cxl_root(parent_port))
+		target_count = NR_CXL_ROOT_PORTS;
+	else
+		target_count = NR_CXL_SWITCH_PORTS;
+
+	for (i = 0; i < NR_CXL_PORT_DECODERS; i++) {
+		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };
+		struct target_map_ctx ctx = {
+			.target_map = target_map,
+			.target_count = target_count,
+		};
+		struct cxl_decoder *cxld;
+		int rc;
+
+		if (target_count)
+			cxld = cxl_switch_decoder_alloc(port, target_count);
+		else
+			cxld = cxl_endpoint_decoder_alloc(port);
+		if (IS_ERR(cxld)) {
+			dev_warn(&port->dev,
+				 "Failed to allocate the decoder\n");
+			return PTR_ERR(cxld);
+		}
 
-	for (i = 0; i < ARRAY_SIZE(cxl_root_port); i++) {
-		struct platform_device *pdev = cxl_root_port[i];
-		struct cxl_dport *dport;
+		cxld->decoder_range = (struct range) {
+			.start = 0,
+			.end = -1,
+		};
+
+		cxld->flags = CXL_DECODER_F_ENABLE;
+		cxld->interleave_ways = min_not_zero(target_count, 1);
+		cxld->interleave_granularity = SZ_4K;
+		cxld->target_type = CXL_DECODER_EXPANDER;
+
+		if (target_count) {
+			rc = device_for_each_child(port->uport, &ctx,
+						   map_targets);
+			if (rc) {
+				put_device(&cxld->dev);
+				return rc;
+			}
+		}
 
-		if (pdev->dev.parent != port->uport)
-			continue;
+		rc = cxl_decoder_add_locked(cxld, target_map);
+		if (rc) {
+			put_device(&cxld->dev);
+			dev_err(&port->dev, "Failed to add decoder\n");
+			return rc;
+		}
 
-		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
-					   CXL_RESOURCE_NONE);
+		rc = cxl_decoder_autoremove(&port->dev, cxld);
+		if (rc)
+			return rc;
+		dev_dbg(&cxld->dev, "Added to port %s\n", dev_name(&port->dev));
+	}
 
-		if (IS_ERR(dport)) {
-			dev_err(dev, "failed to add dport: %s (%ld)\n",
-				dev_name(&pdev->dev), PTR_ERR(dport));
-			return PTR_ERR(dport);
-		}
+	return 0;
+}
 
-		dev_dbg(dev, "add dport%d: %s\n", pdev->id,
-			dev_name(&pdev->dev));
+static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
+{
+	struct device *dev = &port->dev;
+	struct platform_device **array;
+	int i, array_size;
+
+	if (port->depth == 1) {
+		array_size = ARRAY_SIZE(cxl_root_port);
+		array = cxl_root_port;
+	} else if (port->depth == 2) {
+		array_size = ARRAY_SIZE(cxl_switch_dport);
+		array = cxl_switch_dport;
+	} else {
+		dev_WARN_ONCE(&port->dev, 1, "unexpected depth %d\n",
+			      port->depth);
+		return -ENXIO;
 	}
 
-	for (i = 0; i < ARRAY_SIZE(cxl_switch_dport); i++) {
-		struct platform_device *pdev = cxl_switch_dport[i];
+	for (i = 0; i < array_size; i++) {
+		struct platform_device *pdev = array[i];
 		struct cxl_dport *dport;
 
 		if (pdev->dev.parent != port->uport)

