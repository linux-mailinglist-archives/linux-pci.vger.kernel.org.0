Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6852486EF2
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 01:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbiAGAiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 19:38:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:59426 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343881AbiAGAiK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 19:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641515890; x=1673051890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v+UW4m504aj7Y2/rdh0uUTe2dZa+1eAla8ODkXKHIW8=;
  b=SQhLAzNheCUxev8Ml8p99nt3OwQu9qbC2QsQXCz3ecKhPaCGUB/JQck4
   xdodoCIfPPrHIlmSRwhi6m6sbtQ8v+y9bhLvP/xl9oT8f/rUuZlAFznsd
   5v7cHy9kOSsjLi0KtPBL4uBbt/GV7k8g0HReoTERs9bprMTnsCpVXcl5C
   zwSt1buKaz2PduKymwGbEzwUgFyRArnwHW/eyIMZi/6HSvrEo8hHdM9B7
   PhYTHGjNeNwI32b3EsIVVetv4qt2wHuqE8ZljXLcIKsBTPyp2OaDvKLpo
   ULHK1egzldMAhR/nVUahvu8Xtfq2IXV9hqfMN8oSU8HchfFNi8aSHfQI0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="229582016"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="229582016"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="471123185"
Received: from elenawei-mobl2.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.138.104])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 16:38:09 -0800
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
Subject: [PATCH 02/13] cxl/core: Track port depth
Date:   Thu,  6 Jan 2022 16:37:45 -0800
Message-Id: <20220107003756.806582-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107003756.806582-1-ben.widawsky@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/port.c | 7 ++++++-
 drivers/cxl/cxl.h       | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 5a1ffadd5d0d..ecab7cfa88f0 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -436,13 +436,18 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 {
 	struct cxl_port *port;
 	struct device *dev;
-	int rc;
+	int rc, depth = parent_port ? parent_port->depth + 1 : 0;
 
 	port = cxl_port_alloc(uport, component_reg_phys, parent_port);
 	if (IS_ERR(port))
 		return port;
 
+	if (dev_WARN_ONCE(&port->dev, parent_port && !depth,
+			  "Invalid parent port depth\n"))
+		return ERR_PTR(-ENODEV);
+
 	port->host = host;
+	port->depth = depth;
 	dev = &port->dev;
 	if (is_cxl_memdev(uport))
 		rc = dev_set_name(dev, "endpoint%d", port->id);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 276b93316e7f..6eeb82711443 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -272,6 +272,7 @@ struct cxl_walk_context {
  * @decoder_ida: allocator for decoder ids
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
+ * @depth: How deep this port is relative to the root. depth 0 is the root.
  */
 struct cxl_port {
 	struct device dev;
@@ -283,6 +284,7 @@ struct cxl_port {
 	struct ida decoder_ida;
 	resource_size_t component_reg_phys;
 	bool dead;
+	unsigned int depth;
 };
 
 /**
-- 
2.34.1

