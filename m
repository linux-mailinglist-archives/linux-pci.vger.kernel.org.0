Return-Path: <linux-pci+bounces-43074-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B746CC0642
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 01:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07FFA30220ED
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 00:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7315F280023;
	Tue, 16 Dec 2025 00:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j1CKDVO/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE522701B8;
	Tue, 16 Dec 2025 00:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846536; cv=none; b=QqlXl2H3k4AbC5ZalAuSxeD3VXQPVK0Sf69XQ/zaIfS16o34VQiPe1ZZIGKQMq3GyFOgID0EnrUW78IJx82CSH8L/Fg8inUZKhgVHXEtsrbIFhN/c5m6iBQSTncfDfYRVSLReR12wFQmLzWrsVf/ZWRLXRI6a7K9/OoLUxrq7pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846536; c=relaxed/simple;
	bh=wHO7V2oELIaRdDJ1ZRbnM7/nWHFm2hlak1HFVK1ad+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDLXF2krwv65h+nJitMGdeJc+p7Fd9jHwznu4DckHR63fo0iPmq4kfU9MEExBlk/6NePua13wMpJDtPdwqzvcan7vG4Qvta0+Wsd56lKzQV6KSLRIQL7tHrx7JoQriIxcclAGRgq5QEfObe+ohBlDMzJ96oCmdg+K7fIUgxgorQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j1CKDVO/; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765846535; x=1797382535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wHO7V2oELIaRdDJ1ZRbnM7/nWHFm2hlak1HFVK1ad+c=;
  b=j1CKDVO/6+7SrlUlMzoO4ZhlO45SOwJopbru+OeR06z9R5uUol5nunVa
   cD5XW+NQ1JnQRs+Lwz2Xgc0z39SQxgu1Boa8aXPn5KZl+CJLgS8veafUV
   nYuKvuZzAtT6Sd9ZK/5Z3+nNShKrcYUJC44EhMmeVsRVvKQtIFiON0M8I
   cjnLktF6WU9wkPWv0S5VUw0uourJ7hX1P3SeA0bBxeRiZZovRz/faab+p
   iHOozjTCDfxQW+YF+eFUyVHt2jjKRHLxZ4H1/mj8R9JckdVm9sUpfj+xx
   TWWSmb/gXYocGBSSshxFmy9RQY0BQf7ql6dYJsViE150D6P/C2QWjuvP1
   g==;
X-CSE-ConnectionGUID: s2ea93RwTVi0AfxMicDp6Q==
X-CSE-MsgGUID: 19zFchiTSgmL4GHTUzTM/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11643"; a="79215480"
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="79215480"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 16:55:33 -0800
X-CSE-ConnectionGUID: kmT8rWGRQEyf/1becGAl0A==
X-CSE-MsgGUID: Yw7GjjbDQuSMs3mrqwNkUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,152,1763452800"; 
   d="scan'208";a="198131531"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by fmviesa008.fm.intel.com with ESMTP; 15 Dec 2025 16:55:32 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Smita.KoralahalliChannabasappa@amd.com,
	alison.schofield@intel.com,
	terry.bowman@amd.com,
	alejandro.lucero-palau@amd.com,
	linux-pci@vger.kernel.org,
	Jonathan.Cameron@huawei.com,
	Alejandro Lucero <alucerop@amd.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>
Subject: [PATCH v2 3/6] cxl/port: Arrange for always synchronous endpoint attach
Date: Mon, 15 Dec 2025 16:56:13 -0800
Message-ID: <20251216005616.3090129-4-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251216005616.3090129-1-dan.j.williams@intel.com>
References: <20251216005616.3090129-1-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it so that upon return from devm_cxl_add_endpoint() that
cxl_mem_probe() can assume that the endpoint has had a chance to complete
cxl_port_probe().  I.e. cxl_port module loading has completed prior to
device registration.

Delete the MODULE_SOFTDEP() as it is not sufficient for this purpose, but a
hard link-time dependency is reliable. Specifically MODULE_SOFTDEP() does
not guarantee that the module loading has completed prior to the completion
of the current module's init.

Cc: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Alejandro Lucero <alucerop@amd.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h  |  2 ++
 drivers/cxl/mem.c  | 43 -------------------------------------------
 drivers/cxl/port.c | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ba17fa86d249..c796c3db36e0 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -780,6 +780,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host,
 				   struct cxl_dport *parent_dport);
 struct cxl_root *devm_cxl_add_root(struct device *host,
 				   const struct cxl_root_ops *ops);
+int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+			  struct cxl_dport *parent_dport);
 struct cxl_root *find_cxl_root(struct cxl_port *port);
 
 DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 55883797ab2d..d62931526fd4 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -45,44 +45,6 @@ static int cxl_mem_dpa_show(struct seq_file *file, void *data)
 	return 0;
 }
 
-static int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
-				 struct cxl_dport *parent_dport)
-{
-	struct cxl_port *parent_port = parent_dport->port;
-	struct cxl_port *endpoint, *iter, *down;
-	int rc;
-
-	/*
-	 * Now that the path to the root is established record all the
-	 * intervening ports in the chain.
-	 */
-	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
-	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
-		struct cxl_ep *ep;
-
-		ep = cxl_ep_load(iter, cxlmd);
-		ep->next = down;
-	}
-
-	/* Note: endpoint port component registers are derived from @cxlds */
-	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
-				     parent_dport);
-	if (IS_ERR(endpoint))
-		return PTR_ERR(endpoint);
-
-	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
-	if (rc)
-		return rc;
-
-	if (!endpoint->dev.driver) {
-		dev_err(&cxlmd->dev, "%s failed probe\n",
-			dev_name(&endpoint->dev));
-		return -ENXIO;
-	}
-
-	return 0;
-}
-
 static int cxl_debugfs_poison_inject(void *data, u64 dpa)
 {
 	struct cxl_memdev *cxlmd = data;
@@ -275,8 +237,3 @@ MODULE_DESCRIPTION("CXL: Memory Expansion");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS("CXL");
 MODULE_ALIAS_CXL(CXL_DEVICE_MEMORY_EXPANDER);
-/*
- * create_endpoint() wants to validate port driver attach immediately after
- * endpoint registration.
- */
-MODULE_SOFTDEP("pre: cxl_port");
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 51c8f2f84717..7937e7e53797 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -156,10 +156,50 @@ static struct cxl_driver cxl_port_driver = {
 	.probe = cxl_port_probe,
 	.id = CXL_DEVICE_PORT,
 	.drv = {
+		.probe_type = PROBE_FORCE_SYNCHRONOUS,
 		.dev_groups = cxl_port_attribute_groups,
 	},
 };
 
+int devm_cxl_add_endpoint(struct device *host, struct cxl_memdev *cxlmd,
+			  struct cxl_dport *parent_dport)
+{
+	struct cxl_port *parent_port = parent_dport->port;
+	struct cxl_port *endpoint, *iter, *down;
+	int rc;
+
+	/*
+	 * Now that the path to the root is established record all the
+	 * intervening ports in the chain.
+	 */
+	for (iter = parent_port, down = NULL; !is_cxl_root(iter);
+	     down = iter, iter = to_cxl_port(iter->dev.parent)) {
+		struct cxl_ep *ep;
+
+		ep = cxl_ep_load(iter, cxlmd);
+		ep->next = down;
+	}
+
+	/* Note: endpoint port component registers are derived from @cxlds */
+	endpoint = devm_cxl_add_port(host, &cxlmd->dev, CXL_RESOURCE_NONE,
+				     parent_dport);
+	if (IS_ERR(endpoint))
+		return PTR_ERR(endpoint);
+
+	rc = cxl_endpoint_autoremove(cxlmd, endpoint);
+	if (rc)
+		return rc;
+
+	if (!endpoint->dev.driver) {
+		dev_err(&cxlmd->dev, "%s failed probe\n",
+			dev_name(&endpoint->dev));
+		return -ENXIO;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_FOR_MODULES(devm_cxl_add_endpoint, "cxl_mem");
+
 static int __init cxl_port_init(void)
 {
 	return cxl_driver_register(&cxl_port_driver);
-- 
2.51.1


