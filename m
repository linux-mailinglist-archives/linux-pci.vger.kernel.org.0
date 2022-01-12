Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B8648CF4E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 00:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiALXsj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 18:48:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:13993 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235688AbiALXsU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 18:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642031300; x=1673567300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cqkYc373Jfzw41yZIi1uTdP2NYGZoYHUADmQqdhhF4A=;
  b=BbAHXZ5tzfWU7VtAcsWIS/dUVdDs65mVNQIlx2CX+STpMp01IIeYQcIS
   D7Zebhccc82U168INSfSmblBEIMMFelWeaM4PPqPhploId0LBuZJDFX5j
   IcSbUIODrar5HbaT6BkSdH3VC6mgb0LRXbSVn1NifKrP2T9RLKirgjk0C
   U+T5dsYw2W9mFKjY2PqYlZiKN9MbvTbaaUBhgVJC325znzJd4Dj+gqjzJ
   VntopsPj6EZrh34HTSUouGKPwQXSddZQhErHB3B2+nqIhGyO0VZZUkCr2
   OVxprgOcfjXfSjh+Oy1VLqFf00a7lTsq38RxZ7PAZOCAZtA2Tv/1RlVJ+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242695363"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242695363"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="670324215"
Received: from jmaclean-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.136.131])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:11 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Cc:     patches@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 13/15] cxl: Program decoders for regions
Date:   Wed, 12 Jan 2022 15:47:47 -0800
Message-Id: <20220112234749.1965960-14-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112234749.1965960-1-ben.widawsky@intel.com>
References: <20220112234749.1965960-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Configure and commit the HDM decoders for the region. Since the region
driver already was able to walk the topology and build the list of
needed decoders, all that was needed to finish region setup was to
actually write the HDM decoder MMIO.

CXL regions appear as linear addresses in the system's physical address
space. CXL memory devices comprise the storage for the region. In order
for traffic to be properly routed to the memory devices in the region, a
set of Host-manged Device Memory decoders must be present. The decoders
are a piece of hardware defined in the CXL specification.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
Changes since v1:
- Fix wait_for_commit (Jonathan)
- Improved commit message
- Fixed error handling
- Use devm actions for destruction
---
 drivers/cxl/core/hdm.c | 202 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |   3 +
 drivers/cxl/region.c   |  72 ++++++++++++---
 3 files changed, 265 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 44e48cea8cd4..9fcd6467f918 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -242,3 +242,205 @@ int devm_cxl_enumerate_switch_decoders(struct cxl_port *port)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_switch_decoders, CXL);
+
+#define COMMIT_TIMEOUT_MS 10
+static int wait_for_commit(struct cxl_decoder *cxld)
+{
+	const unsigned long end = jiffies + msecs_to_jiffies(COMMIT_TIMEOUT_MS);
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_port_state *cxlps;
+	void __iomem *hdm_decoder;
+	u32 ctrl;
+
+	cxlps = dev_get_drvdata(&port->dev);
+	hdm_decoder = cxlps->regs.hdm_decoder;
+
+	while (1) {
+		ctrl = readl(hdm_decoder +
+			     CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			break;
+
+		if (time_after(jiffies, end)) {
+			dev_err(&cxld->dev, "HDM decoder commit timeout %x\n", ctrl);
+			return -ETIMEDOUT;
+		}
+		if ((ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR) != 0) {
+			dev_err(&cxld->dev, "HDM decoder commit error %x\n", ctrl);
+			return -ENXIO;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_commit_decoder() - Program a configured cxl_decoder
+ * @cxld: The preconfigured cxl decoder.
+ *
+ * A cxl decoder that is to be committed should have been earmarked as enabled.
+ * This mechanism acts as a soft reservation on the decoder.
+ *
+ * Returns 0 if commit was successful, negative error code otherwise.
+ */
+int cxl_commit_decoder(struct cxl_decoder *cxld)
+{
+	u32 ctrl, tl_lo, tl_hi, base_lo, base_hi, size_lo, size_hi;
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_port_state *cxlps;
+	void __iomem *hdm_decoder;
+	int rc;
+
+	/*
+	 * Decoder flags are entirely software controlled and therefore this
+	 * case is purely a driver bug.
+	 */
+	if (dev_WARN_ONCE(&port->dev, (cxld->flags & CXL_DECODER_F_ENABLE) != 0,
+			  "Invalid %s enable state\n", dev_name(&cxld->dev)))
+		return -ENXIO;
+
+	cxlps = dev_get_drvdata(&port->dev);
+	hdm_decoder = cxlps->regs.hdm_decoder;
+	ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+
+	/*
+	 * A decoder that's currently active cannot be changed without the
+	 * system being quiesced. While the driver should prevent against this,
+	 * for a variety of reasons the hardware might not be in sync with the
+	 * hardware and so, do not splat on error.
+	 */
+	size_hi = readl(hdm_decoder +
+			CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
+	size_lo =
+		readl(hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
+	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl) &&
+	    (size_lo + size_hi)) {
+		dev_err(&port->dev, "Tried to change an active decoder (%s)\n",
+			dev_name(&cxld->dev));
+		return -EBUSY;
+	}
+
+	u32p_replace_bits(&ctrl, cxl_to_ig(cxld->interleave_granularity),
+			  CXL_HDM_DECODER0_CTRL_IG_MASK);
+	u32p_replace_bits(&ctrl, cxl_to_eniw(cxld->interleave_ways),
+			  CXL_HDM_DECODER0_CTRL_IW_MASK);
+	u32p_replace_bits(&ctrl, 1, CXL_HDM_DECODER0_CTRL_COMMIT);
+
+	/* TODO: set based on type */
+	u32p_replace_bits(&ctrl, 1, CXL_HDM_DECODER0_CTRL_TYPE);
+
+	base_lo = FIELD_PREP(GENMASK(31, 28),
+			     (u32)(cxld->decoder_range.start & 0xffffffff));
+	base_hi = FIELD_PREP(~0, (u32)(cxld->decoder_range.start >> 32));
+
+	size_lo = (u32)(range_len(&cxld->decoder_range)) & GENMASK(31, 28);
+	size_hi = (u32)((range_len(&cxld->decoder_range) >> 32));
+
+	if (cxld->nr_targets > 0) {
+		tl_lo |= FIELD_PREP(GENMASK(7, 0), cxld->target[0]->port_id);
+		if (cxld->interleave_ways > 1)
+			tl_lo |= FIELD_PREP(GENMASK(15, 8),
+					    cxld->target[1]->port_id);
+		if (cxld->interleave_ways > 2)
+			tl_lo |= FIELD_PREP(GENMASK(23, 16),
+					    cxld->target[2]->port_id);
+		if (cxld->interleave_ways > 3)
+			tl_lo |= FIELD_PREP(GENMASK(31, 24),
+					    cxld->target[3]->port_id);
+		if (cxld->interleave_ways > 4)
+			tl_hi |= FIELD_PREP(GENMASK(7, 0),
+					    cxld->target[4]->port_id);
+		if (cxld->interleave_ways > 5)
+			tl_hi |= FIELD_PREP(GENMASK(15, 8),
+					    cxld->target[5]->port_id);
+		if (cxld->interleave_ways > 6)
+			tl_hi |= FIELD_PREP(GENMASK(23, 16),
+					    cxld->target[6]->port_id);
+		if (cxld->interleave_ways > 7)
+			tl_hi |= FIELD_PREP(GENMASK(31, 24),
+					    cxld->target[7]->port_id);
+
+		writel(tl_hi, hdm_decoder + CXL_HDM_DECODER0_TL_HIGH(cxld->id));
+		writel(tl_lo, hdm_decoder + CXL_HDM_DECODER0_TL_LOW(cxld->id));
+	}
+
+	writel(size_hi,
+	       hdm_decoder + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
+	writel(size_lo,
+	       hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
+	writel(base_hi,
+	       hdm_decoder + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(cxld->id));
+	writel(base_lo,
+	       hdm_decoder + CXL_HDM_DECODER0_BASE_LOW_OFFSET(cxld->id));
+	writel(ctrl, hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+
+	rc = wait_for_commit(cxld);
+	if (rc)
+		return rc;
+
+	cxld->flags |= CXL_DECODER_F_ENABLE;
+
+#define DPORT_TL_STR "%d %d %d %d %d %d %d %d"
+#define DPORT(i)                                                               \
+	(cxld->nr_targets && cxld->interleave_ways > (i)) ?                    \
+		      cxld->target[(i)]->port_id :                                   \
+		      -1
+#define DPORT_TL                                                               \
+	DPORT(0), DPORT(1), DPORT(2), DPORT(3), DPORT(4), DPORT(5), DPORT(6),  \
+		DPORT(7)
+
+	dev_dbg(&port->dev,
+		"%s\n\tBase %pa\n\tSize %llu\n\tIG %u (%ub)\n\tENIW %u (x%u)\n\tTargetList: \n"
+		DPORT_TL_STR,
+		dev_name(&cxld->dev),
+		&cxld->decoder_range.start,
+		range_len(&cxld->decoder_range),
+		cxl_to_ig(cxld->interleave_granularity),
+		cxld->interleave_granularity,
+		cxl_to_eniw(cxld->interleave_ways),
+		cxld->interleave_ways,
+		DPORT_TL);
+#undef DPORT_TL
+#undef DPORT
+#undef DPORT_TL_STR
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_commit_decoder);
+
+/**
+ * cxl_disable_decoder() - Disables a decoder
+ * @cxld: The active cxl decoder.
+ *
+ * CXL decoders (as of 2.0 spec) have no way to deactivate them other than to
+ * set the size of the HDM to 0. This function will clear all registers, and if
+ * the decoder is active, commit the 0'd out registers.
+ */
+void cxl_disable_decoder(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_port_state *cxlps;
+	void __iomem *hdm_decoder;
+	u32 ctrl;
+
+	cxlps = dev_get_drvdata(&port->dev);
+	hdm_decoder = cxlps->regs.hdm_decoder;
+	ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+
+	if (dev_WARN_ONCE(&port->dev, (cxld->flags & CXL_DECODER_F_ENABLE) == 0,
+			  "Invalid decoder enable state\n"))
+		return;
+
+	/* There's no way to "uncommit" a committed decoder, only 0 size it */
+	writel(0, hdm_decoder + CXL_HDM_DECODER0_TL_HIGH(cxld->id));
+	writel(0, hdm_decoder + CXL_HDM_DECODER0_TL_LOW(cxld->id));
+	writel(0, hdm_decoder + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
+	writel(0, hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
+	writel(0, hdm_decoder + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(cxld->id));
+	writel(0, hdm_decoder + CXL_HDM_DECODER0_BASE_LOW_OFFSET(cxld->id));
+
+	/* If the device isn't actually active, just zero out all the fields */
+	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+		writel(CXL_HDM_DECODER0_CTRL_COMMIT,
+		       hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+}
+EXPORT_SYMBOL_GPL(cxl_disable_decoder);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 81c35be13416..1130165dfc8d 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -54,6 +54,7 @@
 #define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
 #define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
 #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
 #define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
@@ -377,6 +378,8 @@ int devm_cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 					const struct device *dev);
 struct cxl_port *ep_find_cxl_port(struct cxl_memdev *cxlmd, unsigned int depth);
+int cxl_commit_decoder(struct cxl_decoder *cxld);
+void cxl_disable_decoder(struct cxl_decoder *cxld);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 6d39f71b6dfa..d00305655f5a 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -167,6 +167,8 @@ static int allocate_address_space(struct cxl_region *region)
 		return -ENOMEM;
 	}
 
+	dev_dbg(&region->dev, "resource %pR", region->res);
+
 	return devm_add_action_or_reset(&region->dev, release_cxl_region,
 					region);
 }
@@ -592,10 +594,49 @@ static void cleanup_staged_decoders(struct cxl_region *region)
 	}
 }
 
-static int bind_region(const struct cxl_region *region)
+static int bind_region(struct cxl_region *region)
 {
-	/* TODO: */
-	return 0;
+	struct cxl_decoder *cxld, *d;
+	int rc;
+
+	list_for_each_entry_safe(cxld, d, &region->staged_list, region_link) {
+		rc = cxl_commit_decoder(cxld);
+		if (!rc) {
+			list_move_tail(&cxld->region_link, &region->commit_list);
+		} else {
+			dev_dbg(&region->dev, "Failed to commit %s\n",
+				dev_name(&cxld->dev));
+			break;
+		}
+	}
+
+	list_for_each_entry_safe(cxld, d, &region->commit_list, region_link) {
+		if (rc)
+			cxl_disable_decoder(cxld);
+		list_del(&cxld->region_link);
+	}
+
+	if (rc)
+		cleanup_staged_decoders((struct cxl_region *)region);
+
+	BUG_ON(!list_empty(&region->staged_list));
+	return rc;
+}
+
+static void region_unregister(void *dev)
+{
+	struct cxl_region *region = to_cxl_region(dev);
+	struct cxl_decoder *cxld, *d;
+
+	if (dev_WARN_ONCE(dev, !list_empty(&region->staged_list),
+			  "Decoders still staged"))
+		cleanup_staged_decoders(region);
+
+	list_for_each_entry_safe(cxld, d, &region->commit_list, region_link) {
+		cxl_disable_decoder(cxld);
+		list_del(&cxld->region_link);
+		cxl_put_decoder(cxld);
+	}
 }
 
 static int cxl_region_probe(struct device *dev)
@@ -646,20 +687,27 @@ static int cxl_region_probe(struct device *dev)
 		put_device(&ours->dev);
 
 	ret = collect_ep_decoders(region);
-	if (ret)
-		goto err;
+	if (ret) {
+		cleanup_staged_decoders(region);
+		return ret;
+	}
 
 	ret = bind_region(region);
-	if (ret)
-		goto err;
+	if (ret) {
+		/* bind_region should cleanup after itself */
+		if (dev_WARN_ONCE(dev, !list_empty(&region->staged_list),
+				  "Region bind failed to cleanup staged decoders\n"))
+			cleanup_staged_decoders(region);
+		if (dev_WARN_ONCE(dev, !list_empty(&region->commit_list),
+				  "Region bind failed to cleanup committed decoders\n"))
+			region_unregister(&region->dev);
+		return ret;
+	}
+
 
 	region->active = true;
 	dev_info(dev, "Bound");
-	return 0;
-
-err:
-	cleanup_staged_decoders(region);
-	return ret;
+	return devm_add_action_or_reset(dev, region_unregister, dev);
 }
 
 static struct cxl_driver cxl_region_driver = {
-- 
2.34.1

