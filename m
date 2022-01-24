Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3388497689
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbiAXA3s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:29:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:5532 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235119AbiAXA3s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:29:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984188; x=1674520188;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7bx4hQdaKAqoB0jDsKP6kI7Q4BWHrNEOmOPbSXrpGTo=;
  b=HFpFEtn5eWc7VGbHGygKziKJQ5p/EoXbKJpYwchn6KRZFQA0KVZwvcHy
   rITUNFCfLIApOt7TxAI7CtjMwBUZx7M+kcr91H9xfTYK+Z74Y+u9Tqacs
   AYcTTV/Z18Q6w3IJvOFgNYqnScvX4gEIpdaeQLeg8kb2jCJoLZuQuIl5K
   GL63wJK1ImkF6o8x22SugNWDRmZdw9QsvOgGdKHeBbZCTtpJvSU2addpr
   p780o2+05NihxW4AqDcEPtIj+QqWJi+gXtEoC45RHlw/4w7clqfwRQcMB
   i1gXBvGwpDhXEqDHwySer0BEu4eFgW7Gau8nDhr9FVl9pZzdhrPmWBz7c
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332288814"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332288814"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:48 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="766230157"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:48 -0800
Subject: [PATCH v3 13/40] cxl/core/port: Make passthrough decoder init
 implicit
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:29:47 -0800
Message-ID: <164298418778.3018233.13573986275832546547.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Unused CXL decoders, or ports which use a passthrough decoder (no HDM
decoder registers) are expected to be initialized in a specific way.
Since upcoming drivers will want the same initialization, and it was
already a requirement to have consumers of the API configure the decoder
specific to their needs, initialize to this passthrough state by
default.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      |    5 -----
 drivers/cxl/core/port.c |    9 ++++++++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 0b267eabb15e..4e8086525edc 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -264,11 +264,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (IS_ERR(cxld))
 		return PTR_ERR(cxld);
 
-	cxld->interleave_ways = 1;
-	cxld->interleave_granularity = PAGE_SIZE;
-	cxld->target_type = CXL_DECODER_EXPANDER;
-	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
-
 	device_lock(&port->dev);
 	dport = list_first_entry(&port->dports, typeof(*dport), list);
 	device_unlock(&port->dev);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2910c36a0e58..826b300ba950 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -505,7 +505,8 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
  * some address space for CXL.mem utilization. A decoder is expected to be
  * configured by the caller before registering.
  *
- * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ * Return: A new cxl decoder to be registered by cxl_decoder_add(). The decoder
+ *	   is initialized to be a "passthrough" decoder.
  */
 static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 					     unsigned int nr_targets)
@@ -537,6 +538,12 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	else
 		cxld->dev.type = &cxl_decoder_switch_type;
 
+	/* Pre initialize an "empty" decoder */
+	cxld->interleave_ways = 1;
+	cxld->interleave_granularity = PAGE_SIZE;
+	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
+
 	return cxld;
 err:
 	kfree(cxld);

