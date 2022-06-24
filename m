Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99C3558FA4
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiFXEUW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiFXEUR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:20:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825B253A53;
        Thu, 23 Jun 2022 21:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044415; x=1687580415;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GD0fI9W169kNkPUeklMh94ytuqKPsBZlYoI0XMrAxAs=;
  b=NjLFlHgmbLQP1N4FJRJWkksUbvduNbzYF89Usy/V8WvLj5iNEFpBXNk4
   fQRJ1onLGzs/HpXlX+DxWx6qUEnC2v3OrIhHjhqQP7vfp3KLM2n3elpDF
   8Lmoio+fR94Mm7ujSDKv04gNjikVOg1aZq/6eHyGX+roWoJlvqMAH2vOq
   H0mKkAtmRDbnca1TSPSqpDTBhVdBEU6M7rY4pd+u6vmRjUPBI/hXpAuOi
   u3aByCUJP5CSI6ZGtjY8mowyyUN/Oz70JcKTZfQyWM/J76/llbeMNIluw
   9Bf/S7PTl+VEfENj00FIuX8OI2Y8L+VgAU7ZVOm1VXzLh/hQz9AcjqsXq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367238051"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367238051"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645092958"
Received: from daharell-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.intel.com) ([10.209.66.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
        patches@lists.linux.dev, hch@lst.de,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 42/46] cxl/hdm: Commit decoder state to hardware
Date:   Thu, 23 Jun 2022 21:19:46 -0700
Message-Id: <20220624041950.559155-17-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After all the soft validation of the region has completed, convey the
region configuration to hardware while being careful to commit decoders
in specification mandated order. In addition to programming the endpoint
decoder base-addres, intereleave ways and granularity, the switch
decoder target lists are also established.

While the kernel can enforce spec-mandated commit order, it can not
enforce spec-mandated reset order. For example, the kernel can't stop
someone from removing an endpoint device that is occupying decoderN in a
switch decoder where decoderN+1 is also committed. To reset decoderN,
decoderN+1 must be torn down first. That "tear down the world"
implementation is saved for a follow-on patch.

Callback operations are provided for the 'commit' and 'reset'
operations. While those callbacks may prove useful for CXL accelerators
(Type-2 devices with memory) the primary motivation is to enable a
simple way for cxl_test to intercept those operations.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  16 ++
 drivers/cxl/core/hdm.c                  | 218 ++++++++++++++++++++++++
 drivers/cxl/core/port.c                 |   1 +
 drivers/cxl/core/region.c               | 189 ++++++++++++++++++--
 drivers/cxl/cxl.h                       |  11 ++
 tools/testing/cxl/test/cxl.c            |  46 +++++
 6 files changed, 471 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index f1b74a71927d..0debe2955f34 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -338,3 +338,19 @@ Description:
 		not an endpoint decoder. Once all positions have been
 		successfully written a final validation for decode conflicts is
 		performed before activating the region.
+
+
+What:		/sys/bus/cxl/devices/regionZ/commit
+Date:		May, 2022
+KernelVersion:	v5.20
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RW) Write a boolean 'true' string value to this attribute to
+		trigger the region to transition from the software programmed
+		state to the actively decoding in hardware state. The commit
+		operation in addition to validating that the region is in proper
+		configured state, validates that the decoders are being
+		committed in spec mandated order (last committed decoder id +
+		1), and checks that the hardware accepts the commit request.
+		Reading this value indicates whether the region is committed or
+		not.
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 2ee62dde8b23..72f98f1a782c 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -129,6 +129,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
 		return ERR_PTR(-ENXIO);
 	}
 
+	dev_set_drvdata(&port->dev, cxlhdm);
+
 	return cxlhdm;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
@@ -444,6 +446,213 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
 	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
 }
 
+static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
+{
+	u16 eig;
+	u8 eiw;
+
+	ways_to_cxl(cxld->interleave_ways, &eiw);
+	granularity_to_cxl(cxld->interleave_granularity, &eig);
+
+	u32p_replace_bits(ctrl, eig, CXL_HDM_DECODER0_CTRL_IG_MASK);
+	u32p_replace_bits(ctrl, eiw, CXL_HDM_DECODER0_CTRL_IW_MASK);
+	*ctrl |= CXL_HDM_DECODER0_CTRL_COMMIT;
+}
+
+static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
+{
+	u32p_replace_bits(ctrl, !!(cxld->target_type == 3),
+			  CXL_HDM_DECODER0_CTRL_TYPE);
+}
+
+static void cxld_set_hpa(struct cxl_decoder *cxld, u64 *base, u64 *size)
+{
+	struct cxl_region *cxlr = cxld->region;
+	struct cxl_region_params *p = &cxlr->params;
+
+	cxld->hpa_range = (struct range) {
+		.start = p->res->start,
+		.end = p->res->end,
+	};
+
+	*base = p->res->start;
+	*size = resource_size(p->res);
+}
+
+static void cxld_clear_hpa(struct cxl_decoder *cxld)
+{
+	cxld->hpa_range = (struct range) {
+		.start = 0,
+		.end = -1,
+	};
+}
+
+static int cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
+{
+	struct cxl_dport **t = &cxlsd->target[0];
+	int ways = cxlsd->cxld.interleave_ways;
+
+	if (dev_WARN_ONCE(&cxlsd->cxld.dev,
+			  ways > 8 || ways > cxlsd->nr_targets,
+			  "ways: %d overflows targets: %d\n", ways,
+			  cxlsd->nr_targets))
+		return -ENXIO;
+
+	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
+	if (ways > 1)
+		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
+	if (ways > 2)
+		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
+	if (ways > 3)
+		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
+	if (ways > 4)
+		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
+	if (ways > 5)
+		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
+	if (ways > 6)
+		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
+	if (ways > 7)
+		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
+
+	return 0;
+}
+
+/*
+ * Per CXL 2.0 8.2.5.12.20 Committing Decoder Programming, hardware must set
+ * committed or error within 10ms, but just be generous with 20ms to account for
+ * clock skew and other marginal behavior
+ */
+#define COMMIT_TIMEOUT_MS 20
+static int cxld_await_commit(void __iomem *hdm, int id)
+{
+	u32 ctrl;
+	int i;
+
+	for (i = 0; i < COMMIT_TIMEOUT_MS; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMIT_ERROR, ctrl)) {
+			ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+			return -EIO;
+		}
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			return 0;
+		fsleep(1000);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int cxl_decoder_commit(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	int id = cxld->id, rc;
+	u64 base, size;
+	u32 ctrl;
+
+	if (cxld->flags & CXL_DECODER_F_ENABLE)
+		return 0;
+
+	if (port->commit_end + 1 != id) {
+		dev_dbg(&port->dev,
+			"%s: out of order commit, expected decoder%d.%d\n",
+			dev_name(&cxld->dev), port->id, port->commit_end + 1);
+		return -EBUSY;
+	}
+
+	down_read(&cxl_dpa_rwsem);
+	/* common decoder settings */
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+	cxld_set_interleave(cxld, &ctrl);
+	cxld_set_type(cxld, &ctrl);
+	cxld_set_hpa(cxld, &base, &size);
+
+	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
+		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
+		u64 targets;
+
+		rc = cxlsd_set_targets(cxlsd, &targets);
+		if (rc) {
+			dev_dbg(&port->dev, "%s: target configuration error\n",
+				dev_name(&cxld->dev));
+			goto err;
+		}
+
+		writel(upper_32_bits(targets), tl_hi);
+		writel(lower_32_bits(targets), tl_lo);
+	} else {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
+		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
+
+		writel(upper_32_bits(cxled->skip), sk_hi);
+		writel(lower_32_bits(cxled->skip), sk_lo);
+	}
+
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	up_read(&cxl_dpa_rwsem);
+
+	port->commit_end++;
+	rc = cxld_await_commit(hdm, cxld->id);
+err:
+	if (rc) {
+		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
+			dev_name(&cxld->dev), rc);
+		cxld->reset(cxld);
+		return rc;
+	}
+	cxld->flags |= CXL_DECODER_F_ENABLE;
+
+	return 0;
+}
+
+static int cxl_decoder_reset(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	int id = cxld->id;
+	u32 ctrl;
+
+	if ((cxld->flags & CXL_DECODER_F_ENABLE) ==  0)
+		return 0;
+
+	if (port->commit_end != id) {
+		dev_dbg(&port->dev,
+			"%s: out of order reset, expected decoder%d.%d\n",
+			dev_name(&cxld->dev), port->id, port->commit_end);
+		return -EBUSY;
+	}
+
+	down_read(&cxl_dpa_rwsem);
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
+	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
+
+	cxld_clear_hpa(cxld);
+	writel(0, hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
+	writel(0, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
+	writel(0, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
+	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
+	up_read(&cxl_dpa_rwsem);
+
+	port->commit_end--;
+	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+
+	return 0;
+}
+
 static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    int *target_map, void __iomem *hdm, int which,
 			    u64 *dpa_base)
@@ -466,6 +675,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
 	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
 	committed = !!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED);
+	cxld->commit = cxl_decoder_commit;
+	cxld->reset = cxl_decoder_reset;
 
 	if (!committed)
 		size = 0;
@@ -489,6 +700,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			cxld->target_type = CXL_DECODER_EXPANDER;
 		else
 			cxld->target_type = CXL_DECODER_ACCELERATOR;
+		if (cxld->id != port->commit_end + 1) {
+			dev_warn(&port->dev,
+				 "decoder%d.%d: Committed out of order\n",
+				 port->id, cxld->id);
+			return -ENXIO;
+		}
+		port->commit_end = cxld->id;
 	} else {
 		/* unless / until type-2 drivers arrive, assume type-3 */
 		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl) == 0) {
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 7034300e72b2..eee1615d2319 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -630,6 +630,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->dpa_end = -1;
+	port->commit_end = -1;
 	xa_init(&port->dports);
 	xa_init(&port->endpoints);
 	xa_init(&port->regions);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 071b8cafe2bb..b90160c4f975 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -112,6 +112,168 @@ static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(uuid);
 
+static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
+					  struct cxl_region *cxlr)
+{
+	return xa_load(&port->regions, (unsigned long)cxlr);
+}
+
+static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int i;
+
+	for (i = count - 1; i >= 0; i--) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+		struct cxl_port *iter = cxled_to_port(cxled);
+		struct cxl_ep *ep;
+		int rc;
+
+		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
+			iter = to_cxl_port(iter->dev.parent);
+
+		for (ep = cxl_ep_load(iter, cxlmd); iter;
+		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
+			struct cxl_region_ref *cxl_rr;
+			struct cxl_decoder *cxld;
+
+			cxl_rr = cxl_rr_load(iter, cxlr);
+			cxld = cxl_rr->decoder;
+			rc = cxld->reset(cxld);
+			if (rc)
+				return rc;
+		}
+
+		rc = cxled->cxld.reset(&cxled->cxld);
+		if (rc)
+			return rc;
+	}
+
+	return 0;
+}
+
+static int cxl_region_decode_commit(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	int i, rc;
+
+	for (i = 0; i < p->nr_targets; i++) {
+		struct cxl_endpoint_decoder *cxled = p->targets[i];
+		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+		struct cxl_region_ref *cxl_rr;
+		struct cxl_decoder *cxld;
+		struct cxl_port *iter;
+		struct cxl_ep *ep;
+
+		/* commit bottom up */
+		for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
+		     iter = to_cxl_port(iter->dev.parent)) {
+			cxl_rr = cxl_rr_load(iter, cxlr);
+			cxld = cxl_rr->decoder;
+			rc = cxld->commit(cxld);
+			if (rc)
+				break;
+		}
+
+		if (is_cxl_root(iter))
+			continue;
+
+		/* teardown top down */
+		for (ep = cxl_ep_load(iter, cxlmd); ep && iter;
+		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
+			cxl_rr = cxl_rr_load(iter, cxlr);
+			cxld = cxl_rr->decoder;
+			cxld->reset(cxld);
+		}
+
+		cxled->cxld.reset(&cxled->cxld);
+		if (i == 0)
+			return rc;
+		break;
+	}
+
+	if (i >= p->nr_targets)
+		return 0;
+
+	/* undo the targets that were successfully committed */
+	cxl_region_decode_reset(cxlr, i);
+	return rc;
+}
+
+static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	bool commit;
+	ssize_t rc;
+
+	rc = kstrtobool(buf, &commit);
+	if (rc)
+		return rc;
+
+	rc = down_write_killable(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+
+	/* Already in the requested state? */
+	if (commit && p->state >= CXL_CONFIG_COMMIT)
+		goto out;
+	if (!commit && p->state < CXL_CONFIG_COMMIT)
+		goto out;
+
+	/* Not ready to commit? */
+	if (commit && p->state < CXL_CONFIG_ACTIVE) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	if (commit)
+		rc = cxl_region_decode_commit(cxlr);
+	else {
+		p->state = CXL_CONFIG_RESET_PENDING;
+		up_write(&cxl_region_rwsem);
+		device_release_driver(&cxlr->dev);
+		down_write(&cxl_region_rwsem);
+
+		if (p->state == CXL_CONFIG_RESET_PENDING)
+			rc = cxl_region_decode_reset(cxlr, p->interleave_ways);
+	}
+
+	if (rc)
+		goto out;
+
+	if (commit)
+		p->state = CXL_CONFIG_COMMIT;
+	else if (p->state == CXL_CONFIG_RESET_PENDING)
+		p->state = CXL_CONFIG_ACTIVE;
+
+out:
+	up_write(&cxl_region_rwsem);
+
+	if (rc)
+		return rc;
+	return len;
+}
+
+static ssize_t commit_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	ssize_t rc;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc)
+		return rc;
+	rc = sysfs_emit(buf, "%d\n", p->state >= CXL_CONFIG_COMMIT);
+	up_read(&cxl_region_rwsem);
+
+	return rc;
+}
+static DEVICE_ATTR_RW(commit);
+
 static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
 				  int n)
 {
@@ -388,6 +550,7 @@ static DEVICE_ATTR_RW(size);
 
 static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_uuid.attr,
+	&dev_attr_commit.attr,
 	&dev_attr_interleave_ways.attr,
 	&dev_attr_interleave_granularity.attr,
 	&dev_attr_resource.attr,
@@ -649,12 +812,6 @@ static int cxl_port_attach_region(struct cxl_port *port,
 	return rc;
 }
 
-static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
-					  struct cxl_region *cxlr)
-{
-	return xa_load(&port->regions, (unsigned long)cxlr);
-}
-
 static void cxl_port_detach_region(struct cxl_port *port,
 				   struct cxl_region *cxlr,
 				   struct cxl_endpoint_decoder *cxled)
@@ -1039,20 +1196,32 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	return rc;
 }
 
-static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
+static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
 	struct cxl_region *cxlr = cxled->cxld.region;
 	struct cxl_region_params *p;
+	int rc = 0;
 
 	lockdep_assert_held_write(&cxl_region_rwsem);
 
 	if (!cxlr)
-		return;
+		return 0;
 
 	p = &cxlr->params;
 	get_device(&cxlr->dev);
 
+	if (p->state > CXL_CONFIG_ACTIVE) {
+		/*
+		 * TODO: tear down all impacted regions if a device is
+		 * removed out of order
+		 */
+		rc = cxl_region_decode_reset(cxlr, p->interleave_ways);
+		if (rc)
+			goto out;
+		p->state = CXL_CONFIG_ACTIVE;
+	}
+
 	for (iter = ep_port; !is_cxl_root(iter);
 	     iter = to_cxl_port(iter->dev.parent))
 		cxl_port_detach_region(iter, cxlr, cxled);
@@ -1080,6 +1249,7 @@ static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	down_write(&cxl_region_rwsem);
 out:
 	put_device(&cxlr->dev);
+	return rc;
 }
 
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
@@ -1137,8 +1307,7 @@ static int detach_target(struct cxl_region *cxlr, int pos)
 		goto out;
 	}
 
-	cxl_region_detach(p->targets[pos]);
-	rc = 0;
+	rc = cxl_region_detach(p->targets[pos]);
 out:
 	up_write(&cxl_region_rwsem);
 	return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a93d7c4efd1a..fc14f6805f2c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -54,6 +54,7 @@
 #define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
 #define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
 #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
 #define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
@@ -257,6 +258,8 @@ enum cxl_decoder_type {
  * @target_type: accelerator vs expander (type2 vs type3) selector
  * @region: currently assigned region for this decoder
  * @flags: memory type capabilities and locking
+ * @commit: device/decoder-type specific callback to commit settings to hw
+ * @commit: device/decoder-type specific callback to reset hw settings
 */
 struct cxl_decoder {
 	struct device dev;
@@ -267,6 +270,8 @@ struct cxl_decoder {
 	enum cxl_decoder_type target_type;
 	struct cxl_region *region;
 	unsigned long flags;
+	int (*commit)(struct cxl_decoder *cxld);
+	int (*reset)(struct cxl_decoder *cxld);
 };
 
 /*
@@ -332,11 +337,15 @@ struct cxl_root_decoder {
  * changes to interleave_ways or interleave_granularity
  * @CXL_CONFIG_ACTIVE: All targets have been added the region is now
  * active
+ * @CXL_CONFIG_RESET_PENDING: see commit_store()
+ * @CXL_CONFIG_COMMIT: Soft-config has been committed to hardware
  */
 enum cxl_config_state {
 	CXL_CONFIG_IDLE,
 	CXL_CONFIG_INTERLEAVE_ACTIVE,
 	CXL_CONFIG_ACTIVE,
+	CXL_CONFIG_RESET_PENDING,
+	CXL_CONFIG_COMMIT,
 };
 
 /**
@@ -418,6 +427,7 @@ struct cxl_nvdimm {
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @dpa_end: cursor to track highest allocated decoder for allocation ordering
+ * @commit_end: cursor to track highest committed decoder for commit ordering
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
  * @depth: How deep this port is relative to the root. depth 0 is the root.
@@ -433,6 +443,7 @@ struct cxl_port {
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	int dpa_end;
+	int commit_end;
 	resource_size_t component_reg_phys;
 	bool dead;
 	unsigned int depth;
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 51d517fa62ee..94653201631c 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -429,6 +429,50 @@ static int map_targets(struct device *dev, void *data)
 	return 0;
 }
 
+static int mock_decoder_commit(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	int id = cxld->id;
+
+	if (cxld->flags & CXL_DECODER_F_ENABLE)
+		return 0;
+
+	dev_dbg(&port->dev, "%s commit\n", dev_name(&cxld->dev));
+	if (port->commit_end + 1 != id) {
+		dev_dbg(&port->dev,
+			"%s: out of order commit, expected decoder%d.%d\n",
+			dev_name(&cxld->dev), port->id, port->commit_end + 1);
+		return -EBUSY;
+	}
+
+	port->commit_end++;
+	cxld->flags |= CXL_DECODER_F_ENABLE;
+
+	return 0;
+}
+
+static int mock_decoder_reset(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	int id = cxld->id;
+
+	if ((cxld->flags & CXL_DECODER_F_ENABLE) ==  0)
+		return 0;
+
+	dev_dbg(&port->dev, "%s reset\n", dev_name(&cxld->dev));
+	if (port->commit_end != id) {
+		dev_dbg(&port->dev,
+			"%s: out of order reset, expected decoder%d.%d\n",
+			dev_name(&cxld->dev), port->id, port->commit_end);
+		return -EBUSY;
+	}
+
+	port->commit_end--;
+	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+
+	return 0;
+}
+
 static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 {
 	struct cxl_port *port = cxlhdm->port;
@@ -482,6 +526,8 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 		cxld->interleave_ways = min_not_zero(target_count, 1);
 		cxld->interleave_granularity = SZ_4K;
 		cxld->target_type = CXL_DECODER_EXPANDER;
+		cxld->commit = mock_decoder_commit;
+		cxld->reset = mock_decoder_reset;
 
 		if (target_count) {
 			rc = device_for_each_child(port->uport, &ctx,
-- 
2.36.1

