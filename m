Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1294349768A
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240592AbiAXA3y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:29:54 -0500
Received: from mga02.intel.com ([134.134.136.20]:35955 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235119AbiAXA3y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984194; x=1674520194;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UTXB90fHX0YFrPwy2cFPXU+svRsiutpCm81qYIsivY8=;
  b=bjgj/Tskr+Xi+Xc78zUqsIbb5Tvs/ejbjeYxtAo1SbtkWUJC852jCO/I
   Le9vI/uuaNXSSFB0S+Eb79LcfUVEP2rNOr812AY/hyUBSocomrE5k1ZXH
   qZQYxi6PHKqwLRfQH5aCSCL11DXZiH1wJ7ZFzMFvF4buvaYoyEZfQQsRU
   ADCdzYTDwl32hWQCHGJzxF0411Dd0kxiOZa0NXi/3aaGXsZEPmnZpUnrF
   u59negBWkQZjhuUdELUK/Y+qS3OlM2mXtx7pBJaS5L/4ZnwWr/Ex0c9O1
   AOAy4gGzt7NbQWqu3sdJEgswFe7FkLoxswH0Fmnxc0VCObs5k4HcIF2Wp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233292364"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233292364"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="617061576"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:53 -0800
Subject: [PATCH v3 14/40] cxl/core: Track port depth
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:29:53 -0800
Message-ID: <164298419321.3018233.4469731547378993606.stgit@dwillia2-desk3.amr.corp.intel.com>
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

In preparation for proving CXL subsystem usage of the device_lock()
order track the depth of ports with the expectation that  shallower port
locks can be held over deeper port locks.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |    2 ++
 drivers/cxl/cxl.h       |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 826b300ba950..4ec5febf73fb 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -362,6 +362,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 	if (IS_ERR(port))
 		return port;
 
+	if (parent_port)
+		port->depth = parent_port->depth + 1;
 	dev = &port->dev;
 	if (parent_port)
 		rc = dev_set_name(dev, "port%d", port->id);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e60878ab4569..c1dc53492773 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -252,6 +252,7 @@ struct cxl_walk_context {
  * @dports: cxl_dport instances referenced by decoders
  * @decoder_ida: allocator for decoder ids
  * @component_reg_phys: component register capability base address (optional)
+ * @depth: How deep this port is relative to the root. depth 0 is the root.
  */
 struct cxl_port {
 	struct device dev;
@@ -260,6 +261,7 @@ struct cxl_port {
 	struct list_head dports;
 	struct ida decoder_ida;
 	resource_size_t component_reg_phys;
+	unsigned int depth;
 };
 
 /**

