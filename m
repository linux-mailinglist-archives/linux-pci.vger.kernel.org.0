Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471F649EFB8
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 01:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344709AbiA1A3N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 19:29:13 -0500
Received: from mga18.intel.com ([134.134.136.126]:64742 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344754AbiA1A3H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 19:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643329747; x=1674865747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CnVQ+raP+8W2aD0G0WlAiX+0TelcLCLH1moW72XwUD0=;
  b=MZBDUkWP4ICsY2ZkjFz1njovPDzv3aRhoTy/ntJa35ojUwyQVp8ZAqJ1
   d669cDrY7JjSOoL1DA0In9nUika5XAzcGm+FiRLrrUEmZVnBEZPLtM/VP
   jzWqsHdU6j5X60AkXeIfDuhAyeHVtm1qDmK1U+DJHobTWuZGAVCKu5/BF
   /Z4AQADpDdSjLFUTVJEVtuxg6IdDf6Gs8eBJNZ22aM6P+oyiAPbXhg6DJ
   T7W78DSRvu3BSkUoiPcMTXTE2S03DtXrOfW3NXugPNF+CDnBIy9FmAu5G
   aaB9XabU/YMXqEvy/PFi3Nn+B7waVLZIP+JHqnDEJnh2z8a16AfpjhSt9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230580026"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="230580026"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:29 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="674909657"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:28 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 12/14] cxl: Program decoders for regions
Date:   Thu, 27 Jan 2022 16:27:05 -0800
Message-Id: <20220128002707.391076-13-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128002707.391076-1-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
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
Changes since v2:
- Fix unwind issue in bind_region introduced in v2
---
 drivers/cxl/core/hdm.c | 209 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h      |   3 +
 drivers/cxl/region.c   |  72 +++++++++++---
 3 files changed, 272 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index a28369f264da..66c08d69f7a6 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -268,3 +268,212 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, CXL);
+
+#define COMMIT_TIMEOUT_MS 10
+static int wait_for_commit(struct cxl_decoder *cxld)
+{
+	const unsigned long end = jiffies + msecs_to_jiffies(COMMIT_TIMEOUT_MS);
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	void __iomem *hdm_decoder;
+	struct cxl_hdm *cxlhdm;
+	u32 ctrl;
+
+	cxlhdm = dev_get_drvdata(&port->dev);
+	hdm_decoder = cxlhdm->regs.hdm_decoder;
+
+	while (1) {
+		ctrl = readl(hdm_decoder +
+			     CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
+			break;
+
+		if (time_after(jiffies, end)) {
+			dev_err(&cxld->dev, "HDM decoder commit timeout %x\n",
+				ctrl);
+			return -ETIMEDOUT;
+		}
+		if ((ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR) != 0) {
+			dev_err(&cxld->dev, "HDM decoder commit error %x\n",
+				ctrl);
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
+	void __iomem *hdm_decoder;
+	struct cxl_hdm *cxlhdm;
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
+	cxlhdm = dev_get_drvdata(&port->dev);
+	hdm_decoder = cxlhdm->regs.hdm_decoder;
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
+	base_lo = GENMASK(31, 28) & lower_32_bits(cxld->decoder_range.start);
+	base_hi = upper_32_bits(cxld->decoder_range.start);
+
+	size_lo = GENMASK(31, 28) & (u32)(range_len(&cxld->decoder_range));
+	size_hi = upper_32_bits(range_len(&cxld->decoder_range) >> 32);
+
+	if (cxld->nr_targets > 0) {
+		tl_hi = 0;
+
+		tl_lo = FIELD_PREP(GENMASK(7, 0), cxld->target[0]->port_id);
+
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
+	} else {
+		/* Zero out skip list for devices */
+		writel(0, hdm_decoder + CXL_HDM_DECODER0_TL_HIGH(cxld->id));
+		writel(0, hdm_decoder + CXL_HDM_DECODER0_TL_LOW(cxld->id));
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
+		cxld->target[(i)]->port_id :                                   \
+		      -1
+#define DPORT_TL                                                               \
+	DPORT(0), DPORT(1), DPORT(2), DPORT(3), DPORT(4), DPORT(5), DPORT(6),  \
+		DPORT(7)
+
+	dev_dbg(&cxld->dev,
+		"%s (depth %d)\n\tBase %pa\n\tSize %llu\n\tIG %u (%ub)\n\tENIW %u (x%u)\n\tTargetList: \n" DPORT_TL_STR,
+		dev_name(&port->dev), port->depth, &cxld->decoder_range.start,
+		range_len(&cxld->decoder_range),
+		cxl_to_ig(cxld->interleave_granularity),
+		cxld->interleave_granularity,
+		cxl_to_eniw(cxld->interleave_ways), cxld->interleave_ways,
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
+	void __iomem *hdm_decoder;
+	struct cxl_hdm *cxlhdm;
+	u32 ctrl;
+
+	cxlhdm = dev_get_drvdata(&port->dev);
+	hdm_decoder = cxlhdm->regs.hdm_decoder;
+	ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
+
+	if (dev_WARN_ONCE(&port->dev, (cxld->flags & CXL_DECODER_F_ENABLE) == 0,
+			  "Invalid decoder enable state\n"))
+		return;
+
+	cxld->flags &= ~CXL_DECODER_F_ENABLE;
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
index d70d8c85d05f..f9dab312ed26 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -55,6 +55,7 @@
 #define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
 #define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
 #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
 #define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
 #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
 #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
@@ -416,6 +417,8 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 					const struct device *dev);
 struct cxl_port *ep_find_cxl_port(struct cxl_memdev *cxlmd, unsigned int depth);
+int cxl_commit_decoder(struct cxl_decoder *cxld);
+void cxl_disable_decoder(struct cxl_decoder *cxld);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_cxl_decoder(struct device *dev);
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index f748060733dd..ac290677534d 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -678,10 +678,52 @@ static int collect_ep_decoders(struct cxl_region *cxlr)
 	return rc;
 }
 
-static int bind_region(const struct cxl_region *cxlr)
+static int bind_region(struct cxl_region *cxlr)
 {
-	/* TODO: */
-	return 0;
+	struct cxl_decoder *cxld, *d;
+	int rc;
+
+	list_for_each_entry_safe(cxld, d, &cxlr->staged_list, region_link) {
+		rc = cxl_commit_decoder(cxld);
+		if (!rc) {
+			list_move_tail(&cxld->region_link, &cxlr->commit_list);
+		} else {
+			dev_dbg(&cxlr->dev, "Failed to commit %s\n",
+				dev_name(&cxld->dev));
+			break;
+		}
+	}
+
+	list_for_each_entry_safe(cxld, d, &cxlr->commit_list, region_link) {
+		if (rc) {
+			cxl_disable_decoder(cxld);
+			list_del(&cxld->region_link);
+		}
+	}
+
+	if (rc)
+		cleanup_staged_decoders(cxlr);
+
+	BUG_ON(!list_empty(&cxlr->staged_list));
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
+	/* TODO: teardown the nd_region */
+
+	list_for_each_entry_safe(cxld, d, &region->commit_list, region_link) {
+		cxl_disable_decoder(cxld);
+		list_del(&cxld->region_link);
+		cxl_put_decoder(cxld);
+	}
 }
 
 static int cxl_region_probe(struct device *dev)
@@ -732,20 +774,26 @@ static int cxl_region_probe(struct device *dev)
 		put_device(&ours->dev);
 
 	ret = collect_ep_decoders(cxlr);
-	if (ret)
-		goto err;
+	if (ret) {
+		cleanup_staged_decoders(cxlr);
+		return ret;
+	}
 
 	ret = bind_region(cxlr);
-	if (ret)
-		goto err;
+	if (ret) {
+		/* bind_region should cleanup after itself */
+		if (dev_WARN_ONCE(dev, !list_empty(&cxlr->staged_list),
+				  "Region bind failed to cleanup staged decoders\n"))
+			cleanup_staged_decoders(cxlr);
+		if (dev_WARN_ONCE(dev, !list_empty(&cxlr->commit_list),
+				  "Region bind failed to cleanup committed decoders\n"))
+			region_unregister(&cxlr->dev);
+		return ret;
+	}
 
 	cxlr->active = true;
 	dev_info(dev, "Bound");
-	return 0;
-
-err:
-	cleanup_staged_decoders(cxlr);
-	return ret;
+	return devm_add_action_or_reset(dev, region_unregister, dev);
 }
 
 static struct cxl_driver cxl_region_driver = {
-- 
2.35.0

