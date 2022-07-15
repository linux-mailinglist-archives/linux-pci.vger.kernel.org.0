Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEB8575841
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240879AbiGOABW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbiGOABV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:01:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6250771707;
        Thu, 14 Jul 2022 17:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843280; x=1689379280;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rFuYJU2RizqKHIoiSQcEsnIWX6Vqm+7jVfD6gBeg/Wc=;
  b=QRPG3g74ClHlt9vRcdo1u0SWjMXTja0/lscLV+d52+e3R+io2e2qyulq
   xB1O8FET4AHYfDhaSwRi0dKDXaCU98QcFAuZqJs3VPznkXS4TZRWaPETw
   tg/DD0cH+4U2GU53TXGLm2++Ude+7nH7lmeeLxuud5sE0SHnS761OyZOg
   7tHABoArtjoe1o0hfnvIC7n0j9k3Pj/lx8LQUqmwRqAIlIR6JLcmpqIVn
   PjbHjcd6tldGpVOmhSFDS4W0t+sNInIG8NF3jxOdAgaL7hPjIgsB0xtzo
   r4HUJglDQ4m69jlRoO1XcgX/ygvKRtSuVV/ZVA2nEjKOHT4A2Eg2YLAWN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="284417424"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="284417424"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:17 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="685766185"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:17 -0700
Subject: [PATCH v2 06/28] cxl/hdm: Enumerate allocated DPA
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <bwidawsk@kernel.org>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:01:16 -0700
Message-ID: <165784327682.1758207.7914919426043855876.stgit@dwillia2-xfh.jf.intel.com>
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

In preparation for provisioning CXL regions, add accounting for the DPA
space consumed by existing regions / decoders. Recall, a CXL region is a
memory range comprised from one or more endpoint devices contributing a
mapping of their DPA into HPA space through a decoder.

Record the DPA ranges covered by committed decoders at initial probe of
endpoint ports relative to a per-device resource tree of the DPA type
(pmem or volatile-ram).

The cxl_dpa_rwsem semaphore is introduced to globally synchronize DPA
state across all endpoints and their decoders at once. The vast majority
of DPA operations are reads as region creation is expected to be as rare
as disk partitioning and volume creation. The device_lock() for this
synchronization is specifically avoided for concern of entangling with
sysfs attribute removal.

Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c |  143 ++++++++++++++++++++++++++++++++++++++++++++----
 drivers/cxl/cxl.h      |    2 +
 drivers/cxl/cxlmem.h   |   13 ++++
 3 files changed, 147 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 650363d5272f..d4c17325001b 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -153,10 +153,105 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dpa_debug, CXL);
 
+/*
+ * Must be called in a context that synchronizes against this decoder's
+ * port ->remove() callback (like an endpoint decoder sysfs attribute)
+ */
+static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct resource *res = cxled->dpa_res;
+
+	lockdep_assert_held_write(&cxl_dpa_rwsem);
+
+	if (cxled->skip)
+		__release_region(&cxlds->dpa_res, res->start - cxled->skip,
+				 cxled->skip);
+	cxled->skip = 0;
+	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
+	cxled->dpa_res = NULL;
+}
+
+static void cxl_dpa_release(void *cxled)
+{
+	down_write(&cxl_dpa_rwsem);
+	__cxl_dpa_release(cxled);
+	up_write(&cxl_dpa_rwsem);
+}
+
+static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
+			     resource_size_t base, resource_size_t len,
+			     resource_size_t skipped)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *port = cxled_to_port(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct device *dev = &port->dev;
+	struct resource *res;
+
+	lockdep_assert_held_write(&cxl_dpa_rwsem);
+
+	if (!len)
+		return 0;
+
+	if (cxled->dpa_res) {
+		dev_dbg(dev, "decoder%d.%d: existing allocation %pr assigned\n",
+			port->id, cxled->cxld.id, cxled->dpa_res);
+		return -EBUSY;
+	}
+
+	if (skipped) {
+		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
+				       dev_name(&cxled->cxld.dev), 0);
+		if (!res) {
+			dev_dbg(dev,
+				"decoder%d.%d: failed to reserve skipped space\n",
+				port->id, cxled->cxld.id);
+			return -EBUSY;
+		}
+	}
+	res = __request_region(&cxlds->dpa_res, base, len,
+			       dev_name(&cxled->cxld.dev), 0);
+	if (!res) {
+		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
+			port->id, cxled->cxld.id);
+		if (skipped)
+			__release_region(&cxlds->dpa_res, base - skipped,
+					 skipped);
+		return -EBUSY;
+	}
+	cxled->dpa_res = res;
+	cxled->skip = skipped;
+
+	return 0;
+}
+
+static int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
+				resource_size_t base, resource_size_t len,
+				resource_size_t skipped)
+{
+	struct cxl_port *port = cxled_to_port(cxled);
+	int rc;
+
+	down_write(&cxl_dpa_rwsem);
+	rc = __cxl_dpa_reserve(cxled, base, len, skipped);
+	up_write(&cxl_dpa_rwsem);
+
+	if (rc)
+		return rc;
+
+	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
+}
+
 static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
-			    int *target_map, void __iomem *hdm, int which)
+			    int *target_map, void __iomem *hdm, int which,
+			    u64 *dpa_base)
 {
-	u64 size, base;
+	struct cxl_endpoint_decoder *cxled = NULL;
+	u64 size, base, skip, dpa_size;
+	bool committed;
+	u32 remainder;
 	int i, rc;
 	u32 ctrl;
 	union {
@@ -164,11 +259,15 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		unsigned char target_id[8];
 	} target_list;
 
+	if (is_endpoint_decoder(&cxld->dev))
+		cxled = to_cxl_endpoint_decoder(&cxld->dev);
+
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
 	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
 	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
+	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
 
-	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+	if (!committed)
 		size = 0;
 	if (base == U64_MAX || size == U64_MAX) {
 		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
@@ -181,8 +280,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		.end = base + size - 1,
 	};
 
-	/* switch decoders are always enabled if committed */
-	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+	/* decoders are enabled if committed */
+	if (committed) {
 		cxld->flags |= CXL_DECODER_F_ENABLE;
 		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
 			cxld->flags |= CXL_DECODER_F_LOCK;
@@ -211,14 +310,35 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	if (rc)
 		return rc;
 
-	if (is_endpoint_decoder(&cxld->dev))
+	if (!cxled) {
+		target_list.value =
+			ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+		for (i = 0; i < cxld->interleave_ways; i++)
+			target_map[i] = target_list.target_id[i];
+
 		return 0;
+	}
 
-	target_list.value =
-		ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
-	for (i = 0; i < cxld->interleave_ways; i++)
-		target_map[i] = target_list.target_id[i];
+	if (!committed)
+		return 0;
 
+	dpa_size = div_u64_rem(size, cxld->interleave_ways, &remainder);
+	if (remainder) {
+		dev_err(&port->dev,
+			"decoder%d.%d: invalid committed configuration size: %#llx ways: %d\n",
+			port->id, cxld->id, size, cxld->interleave_ways);
+		return -ENXIO;
+	}
+	skip = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
+	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
+	if (rc) {
+		dev_err(&port->dev,
+			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
+			port->id, cxld->id, *dpa_base,
+			*dpa_base + dpa_size + skip - 1, rc);
+		return rc;
+	}
+	*dpa_base += dpa_size + skip;
 	return 0;
 }
 
@@ -231,6 +351,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
 	int i, committed;
+	u64 dpa_base = 0;
 	u32 ctrl;
 
 	/*
@@ -277,7 +398,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			cxld = &cxlsd->cxld;
 		}
 
-		rc = init_hdm_decoder(port, cxld, target_map, hdm, i);
+		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base);
 		if (rc) {
 			put_device(&cxld->dev);
 			return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 7e1460d89296..d5e4cfac35ea 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -56,6 +56,8 @@
 #define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
+#define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
+#define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
 
 static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index c6d6f57856cc..eee96016c3c7 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -50,6 +50,19 @@ static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
 	return container_of(dev, struct cxl_memdev, dev);
 }
 
+static inline struct cxl_port *cxled_to_port(struct cxl_endpoint_decoder *cxled)
+{
+	return to_cxl_port(cxled->cxld.dev.parent);
+}
+
+static inline struct cxl_memdev *
+cxled_to_memdev(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
+
+	return to_cxl_memdev(port->uport);
+}
+
 bool is_cxl_memdev(struct device *dev);
 static inline bool is_cxl_endpoint(struct cxl_port *port)
 {

