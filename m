Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8F6575846
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240858AbiGOABg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbiGOABg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:01:36 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423FC72EC9;
        Thu, 14 Jul 2022 17:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843295; x=1689379295;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tkxgOqLN93njdIDOPSIv2OVwmPW6481uGNMLoC79dd4=;
  b=mjVys+TSTpcLEfrsgQUrHU9QZxk1DmsR6cTbpQTyJ7VUULOFbIk4qIE0
   ttuvpHIZTkILk5scHuJzsTsCh+9x/aZH2+R63hNeUWlKUlSfD+MxlgUHO
   3PpcPcU4rjpiRw95ot0duQuCz2tkeKe9Ku0BEpH+yyClDuL4SYLdPV6w0
   x+Xi3pQsO7YrgJbwytSPUGvwIJCdpQZSH+Fv3J4M5g0wfYd3UkHkPkSkU
   QiE706yRjo22sj1/LyN34knbP7o1ID10r4IEvP+kw0iATCD1c20LGUWUz
   VrRK3K/hDgCNX8lB5Zz60HQoNWb9lwoKjV+yJdB5n6w5d7lo9Dewklnmp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="371976926"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="371976926"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:29 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="698993528"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:28 -0700
Subject: [PATCH v2 08/28] cxl/hdm: Track next decoder to allocate
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     hch@lst.de, nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:01:28 -0700
Message-ID: <165784328827.1758207.9627538529944559954.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CXL specification enforces that endpoint decoders are committed in
hw instance id order. In preparation for adding dynamic DPA allocation,
record the hw instance id in endpoint decoders, and enforce allocations
to occur in hw instance id order.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c  |   15 +++++++++++++++
 drivers/cxl/core/port.c |    1 +
 drivers/cxl/cxl.h       |    2 ++
 3 files changed, 18 insertions(+)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index acd46b0d69c6..582f48141767 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -160,6 +160,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, CXL);
 static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxled_to_port(cxled);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct resource *res = cxled->dpa_res;
 
@@ -171,6 +172,7 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
 	cxled->skip = 0;
 	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
 	cxled->dpa_res = NULL;
+	port->hdm_end--;
 }
 
 static void cxl_dpa_release(void *cxled)
@@ -201,6 +203,18 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 		return -EBUSY;
 	}
 
+	if (port->hdm_end + 1 != cxled->cxld.id) {
+		/*
+		 * Assumes alloc and commit order is always in hardware instance
+		 * order per expectations from 8.2.5.12.20 Committing Decoder
+		 * Programming that enforce decoder[m] committed before
+		 * decoder[m+1] commit start.
+		 */
+		dev_dbg(dev, "decoder%d.%d: expected decoder%d.%d\n", port->id,
+			cxled->cxld.id, port->id, port->hdm_end + 1);
+		return -EBUSY;
+	}
+
 	if (skipped) {
 		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
 				       dev_name(&cxled->cxld.dev), 0);
@@ -233,6 +247,7 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			cxled->cxld.id, cxled->dpa_res);
 		cxled->mode = CXL_DECODER_MIXED;
 	}
+	port->hdm_end++;
 
 	return 0;
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0ac5dcd612e0..109611318760 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -502,6 +502,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 
 	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
+	port->hdm_end = -1;
 	INIT_LIST_HEAD(&port->dports);
 	INIT_LIST_HEAD(&port->endpoints);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3e7363dde80f..70cd24e4f3ce 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -333,6 +333,7 @@ struct cxl_nvdimm {
  * @dports: cxl_dport instances referenced by decoders
  * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
  * @decoder_ida: allocator for decoder ids
+ * @hdm_end: track last allocated HDM decoder instance for allocation ordering
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
@@ -345,6 +346,7 @@ struct cxl_port {
 	struct list_head dports;
 	struct list_head endpoints;
 	struct ida decoder_ida;
+	int hdm_end;
 	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;

