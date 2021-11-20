Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A69C4579E8
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbhKTAGP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:15 -0500
Received: from mga12.intel.com ([192.55.52.136]:5719 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233497AbhKTAGK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:10 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542406"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542406"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088374"
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
Subject: [PATCH 11/23] cxl/core: Document and tighten up decoder APIs
Date:   Fri, 19 Nov 2021 16:02:38 -0800
Message-Id: <20211120000250.1663391-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since the code to add decoders for switches and endpoints is on the
horizon it helps to have properly documented APIs. In addition, the
decoder APIs will never need to support a negative count for downstream
targets as the spec explicitly starts numbering them at 1, ie. even 0 is
an "invalid" value which can be used as a sentinel.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---

This is respun from a previous incantation here:
https://lore.kernel.org/linux-cxl/20210915155946.308339-1-ben.widawsky@intel.com/
---
 drivers/cxl/core/bus.c | 33 +++++++++++++++++++++++++++++++--
 drivers/cxl/cxl.h      |  3 ++-
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 8e80e85350b1..1ee12a60f3f4 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -495,7 +495,20 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 	return rc;
 }
 
-struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
+/**
+ * cxl_decoder_alloc - Allocate a new CXL decoder
+ * @port: owning port of this decoder
+ * @nr_targets: downstream targets accessible by this decoder. All upstream
+ *		ports and root ports must have at least 1 target.
+ *
+ * A port should contain one or more decoders. Each of those decoders enable
+ * some address space for CXL.mem utilization. A decoder is expected to be
+ * configured by the caller before registering.
+ *
+ * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ */
+struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
+				      unsigned int nr_targets)
 {
 	struct cxl_decoder *cxld, cxld_const_init = {
 		.nr_targets = nr_targets,
@@ -503,7 +516,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 	struct device *dev;
 	int rc = 0;
 
-	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
+	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
 		return ERR_PTR(-EINVAL);
 
 	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
@@ -535,6 +548,22 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
 
+/**
+ * cxl_decoder_add - Add a decoder with targets
+ * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
+ * @target_map: A list of downstream ports that this decoder can direct memory
+ *              traffic to. These numbers should correspond with the port number
+ *              in the PCIe Link Capabilities structure.
+ *
+ * Certain types of decoders may not have any targets. The main example of this
+ * is an endpoint device. A more awkward example is a hostbridge whose root
+ * ports get hot added (technically possible, though unlikely).
+ *
+ * Context: Process context. Takes and releases the cxld's device lock.
+ *
+ * Return: Negative error code if the decoder wasn't properly configured; else
+ *	   returns 0.
+ */
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 {
 	struct cxl_port *port;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ad816fb5bdcc..b66ed8f241c6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -288,7 +288,8 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
-struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
+struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
+				      unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 
-- 
2.34.0

