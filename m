Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD44A4A659D
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 21:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbiBAUYz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 15:24:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:6708 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbiBAUYy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 15:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643747094; x=1675283094;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vF9yP9Z8y0+Jx+Kq7p5ttusyaopSXwpCYnI0ZYUjsvM=;
  b=btQn592kG1Q8g+3JM7XAe7KTTbLSUPQkdJoWO7Xsfe2A0RnHvwD/neEW
   j1i+yyesQiD8GvXATvqmDuqdweJq/Tg7bp8jUnMkpfZt0G908JY2LY98a
   fgOYoKqK1/SR+f0cpQJjoWmECiDObq0VRa+1Hm1fL3dk3KPHhbGMePBdb
   oRniKeNN9g2bMUKSKcXpjrnDVbSyOLgk6G/LntvWqFJEIqbX4VZxsxukE
   yWhe/lACK0xa7qMWiL4vPL/JGAjnq8ODTXJJg2g8lxi6oyskVKGcoJWDA
   QBOnyeF7irEa04Z7ysBIGrPSKXfzLeR0RlVg4qMSDD66wUdP1elb/KeZ7
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247553432"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="247553432"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 12:24:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="523184743"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 12:24:30 -0800
Subject: [PATCH v5 22/40] cxl/core/hdm: Add CXL standard decoder enumeration
 to the core
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Tue, 01 Feb 2022 12:24:30 -0800
Message-ID: <164374688404.395335.9239248252443123526.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164316647461.3437452.7695738236907745246.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164316647461.3437452.7695738236907745246.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Unlike the decoder enumeration for "root decoders" described by platform
firmware, standard decoders can be enumerated from the component
registers space once the base address has been identified (via PCI,
ACPI, or another mechanism).

Add common infrastructure for HDM (Host-managed-Device-Memory) Decoder
enumeration and share it between host-bridge, upstream switch port, and
cxl_test defined decoders.

The locking model for switch level decoders is to hold the port lock
over the enumeration. This facilitates moving the dport and decoder
enumeration to a 'port' driver. For now, the only enumerator of decoder
resources is the cxl_acpi root driver.

Co-developed-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v4:
- Fix kdoc for @host arg, for real this time (Jonathan and Ben)
- Drop unused cxl_register_map from map_hdm_decoder_regs (Jonathan)
- s/coders/decoders/ in changelog (Ben)
- Add Ben's co-developed-by

 drivers/cxl/acpi.c            |   43 ++-----
 drivers/cxl/core/Makefile     |    1 
 drivers/cxl/core/core.h       |    2 
 drivers/cxl/core/hdm.c        |  248 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c       |   57 +++++++--
 drivers/cxl/core/regs.c       |    5 -
 drivers/cxl/cxl.h             |   33 ++++-
 drivers/cxl/cxlmem.h          |    8 +
 tools/testing/cxl/Kbuild      |    4 +
 tools/testing/cxl/test/cxl.c  |   29 +++++
 tools/testing/cxl/test/mock.c |   50 ++++++++
 tools/testing/cxl/test/mock.h |    3 
 12 files changed, 434 insertions(+), 49 deletions(-)
 create mode 100644 drivers/cxl/core/hdm.c

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 259441245687..8c2ced91518b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -168,10 +168,10 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	struct device *host = root_port->dev.parent;
 	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
 	struct acpi_pci_root *pci_root;
-	int single_port_map[1], rc;
-	struct cxl_decoder *cxld;
 	struct cxl_dport *dport;
+	struct cxl_hdm *cxlhdm;
 	struct cxl_port *port;
+	int rc;
 
 	if (!bridge)
 		return 0;
@@ -200,37 +200,24 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	rc = devm_cxl_port_enumerate_dports(host, port);
 	if (rc < 0)
 		return rc;
-	if (rc > 1)
-		return 0;
-
-	/* TODO: Scan CHBCR for HDM Decoder resources */
-
-	/*
-	 * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability
-	 * Structure) single ported host-bridges need not publish a decoder
-	 * capability when a passthrough decode can be assumed, i.e. all
-	 * transactions that the uport sees are claimed and passed to the single
-	 * dport. Disable the range until the first CXL region is enumerated /
-	 * activated.
-	 */
-	cxld = cxl_switch_decoder_alloc(port, 1);
-	if (IS_ERR(cxld))
-		return PTR_ERR(cxld);
-
 	cxl_device_lock(&port->dev);
-	dport = list_first_entry(&port->dports, typeof(*dport), list);
-	cxl_device_unlock(&port->dev);
+	if (rc == 1) {
+		rc = devm_cxl_add_passthrough_decoder(host, port);
+		goto out;
+	}
 
-	single_port_map[0] = dport->port_id;
+	cxlhdm = devm_cxl_setup_hdm(host, port);
+	if (IS_ERR(cxlhdm)) {
+		rc = PTR_ERR(cxlhdm);
+		goto out;
+	}
 
-	rc = cxl_decoder_add(cxld, single_port_map);
+	rc = devm_cxl_enumerate_decoders(host, cxlhdm);
 	if (rc)
-		put_device(&cxld->dev);
-	else
-		rc = cxl_decoder_autoremove(host, cxld);
+		dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
 
-	if (rc == 0)
-		dev_dbg(host, "add: %s\n", dev_name(&cxld->dev));
+out:
+	cxl_device_unlock(&port->dev);
 	return rc;
 }
 
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 91057f0ec763..6d37cd78b151 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -8,3 +8,4 @@ cxl_core-y += regs.o
 cxl_core-y += memdev.o
 cxl_core-y += mbox.o
 cxl_core-y += pci.o
+cxl_core-y += hdm.o
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index e0c9aacc4e9c..1a50c0fc399c 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -14,6 +14,8 @@ struct cxl_mem_query_commands;
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
 		  struct cxl_mem_query_commands __user *q);
 int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length);
 
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
new file mode 100644
index 000000000000..84f4ed288a88
--- /dev/null
+++ b/drivers/cxl/core/hdm.c
@@ -0,0 +1,248 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
+#include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+
+#include "cxlmem.h"
+#include "core.h"
+
+/**
+ * DOC: cxl core hdm
+ *
+ * Compute Express Link Host Managed Device Memory, starting with the
+ * CXL 2.0 specification, is managed by an array of HDM Decoder register
+ * instances per CXL port and per CXL endpoint. Define common helpers
+ * for enumerating these registers and capabilities.
+ */
+
+static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
+			   int *target_map)
+{
+	int rc;
+
+	rc = cxl_decoder_add_locked(cxld, target_map);
+	if (rc) {
+		put_device(&cxld->dev);
+		dev_err(&port->dev, "Failed to add decoder\n");
+		return rc;
+	}
+
+	rc = cxl_decoder_autoremove(&port->dev, cxld);
+	if (rc)
+		return rc;
+
+	dev_dbg(&cxld->dev, "Added to port %s\n", dev_name(&port->dev));
+
+	return 0;
+}
+
+/*
+ * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability Structure)
+ * single ported host-bridges need not publish a decoder capability when a
+ * passthrough decode can be assumed, i.e. all transactions that the uport sees
+ * are claimed and passed to the single dport. Disable the range until the first
+ * CXL region is enumerated / activated.
+ */
+int devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port)
+{
+	struct cxl_decoder *cxld;
+	struct cxl_dport *dport;
+	int single_port_map[1];
+
+	cxld = cxl_switch_decoder_alloc(port, 1);
+	if (IS_ERR(cxld))
+		return PTR_ERR(cxld);
+
+	device_lock_assert(&port->dev);
+
+	dport = list_first_entry(&port->dports, typeof(*dport), list);
+	single_port_map[0] = dport->port_id;
+
+	return add_hdm_decoder(port, cxld, single_port_map);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
+
+static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
+{
+	u32 hdm_cap;
+
+	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
+	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
+	cxlhdm->target_count =
+		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
+		cxlhdm->interleave_mask |= GENMASK(11, 8);
+	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
+		cxlhdm->interleave_mask |= GENMASK(14, 12);
+}
+
+static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
+					  void __iomem *crb)
+{
+	struct cxl_component_reg_map map;
+
+	cxl_probe_component_regs(&port->dev, crb, &map);
+	if (!map.hdm_decoder.valid) {
+		dev_err(&port->dev, "HDM decoder registers invalid\n");
+		return IOMEM_ERR_PTR(-ENXIO);
+	}
+
+	return crb + map.hdm_decoder.offset;
+}
+
+/**
+ * devm_cxl_setup_hdm - map HDM decoder component registers
+ * @host: devm context for allocations
+ * @port: cxl_port to map
+ */
+struct cxl_hdm *devm_cxl_setup_hdm(struct device *host, struct cxl_port *port)
+{
+	struct device *dev = &port->dev;
+	void __iomem *crb, *hdm;
+	struct cxl_hdm *cxlhdm;
+
+	cxlhdm = devm_kzalloc(host, sizeof(*cxlhdm), GFP_KERNEL);
+	if (!cxlhdm)
+		return ERR_PTR(-ENOMEM);
+
+	cxlhdm->port = port;
+	crb = devm_cxl_iomap_block(host, port->component_reg_phys,
+				   CXL_COMPONENT_REG_BLOCK_SIZE);
+	if (!crb) {
+		dev_err(dev, "No component registers mapped\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	hdm = map_hdm_decoder_regs(port, crb);
+	if (IS_ERR(hdm))
+		return ERR_CAST(hdm);
+	cxlhdm->regs.hdm_decoder = hdm;
+
+	parse_hdm_decoder_caps(cxlhdm);
+	if (cxlhdm->decoder_count == 0) {
+		dev_err(dev, "Spec violation. Caps invalid\n");
+		return ERR_PTR(-ENXIO);
+	}
+
+	return cxlhdm;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
+
+static int to_interleave_granularity(u32 ctrl)
+{
+	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
+
+	return 256 << val;
+}
+
+static int to_interleave_ways(u32 ctrl)
+{
+	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
+
+	switch (val) {
+	case 0 ... 4:
+		return 1 << val;
+	case 8 ... 10:
+		return 3 << (val - 8);
+	default:
+		return 0;
+	}
+}
+
+static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
+			     void __iomem *hdm, int which)
+{
+	u64 size, base;
+	u32 ctrl;
+	int i;
+	union {
+		u64 value;
+		unsigned char target_id[8];
+	} target_list;
+
+	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
+	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
+	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
+
+	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
+		size = 0;
+
+	cxld->decoder_range = (struct range) {
+		.start = base,
+		.end = base + size - 1,
+	};
+
+	/* switch decoders are always enabled if committed */
+	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
+		cxld->flags |= CXL_DECODER_F_ENABLE;
+		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
+			cxld->flags |= CXL_DECODER_F_LOCK;
+	}
+	cxld->interleave_ways = to_interleave_ways(ctrl);
+	cxld->interleave_granularity = to_interleave_granularity(ctrl);
+
+	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
+		cxld->target_type = CXL_DECODER_EXPANDER;
+	else
+		cxld->target_type = CXL_DECODER_ACCELERATOR;
+
+	target_list.value =
+		ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
+	for (i = 0; i < cxld->interleave_ways; i++)
+		target_map[i] = target_list.target_id[i];
+}
+
+/**
+ * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
+ * @host: devm allocation context
+ * @cxlhdm: Structure to populate with HDM capabilities
+ */
+int devm_cxl_enumerate_decoders(struct device *host, struct cxl_hdm *cxlhdm)
+{
+	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
+	struct cxl_port *port = cxlhdm->port;
+	int i, committed;
+	u32 ctrl;
+
+	/*
+	 * Since the register resource was recently claimed via request_region()
+	 * be careful about trusting the "not-committed" status until the commit
+	 * timeout has elapsed.  The commit timeout is 10ms (CXL 2.0
+	 * 8.2.5.12.20), but double it to be tolerant of any clock skew between
+	 * host and target.
+	 */
+	for (i = 0, committed = 0; i < cxlhdm->decoder_count; i++) {
+		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
+		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
+			committed++;
+	}
+
+	/* ensure that future checks of committed can be trusted */
+	if (committed != cxlhdm->decoder_count)
+		msleep(20);
+
+	for (i = 0; i < cxlhdm->decoder_count; i++) {
+		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };
+		int rc, target_count = cxlhdm->target_count;
+		struct cxl_decoder *cxld;
+
+		cxld = cxl_switch_decoder_alloc(port, target_count);
+		if (IS_ERR(cxld)) {
+			dev_warn(&port->dev,
+				 "Failed to allocate the decoder\n");
+			return PTR_ERR(cxld);
+		}
+
+		init_hdm_decoder(cxld, target_map, cxlhdm->regs.hdm_decoder, i);
+		rc = add_hdm_decoder(port, cxld, target_map);
+		if (rc) {
+			dev_warn(&port->dev,
+				 "Failed to add decoder to port\n");
+			return rc;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, CXL);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fee9c7affef4..4dfb9df9e648 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -594,16 +594,15 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
 static int decoder_populate_targets(struct cxl_decoder *cxld,
 				    struct cxl_port *port, int *target_map)
 {
-	int rc = 0, i;
+	int i, rc = 0;
 
 	if (!target_map)
 		return 0;
 
-	cxl_device_lock(&port->dev);
-	if (list_empty(&port->dports)) {
-		rc = -EINVAL;
-		goto out_unlock;
-	}
+	device_lock_assert(&port->dev);
+
+	if (list_empty(&port->dports))
+		return -EINVAL;
 
 	write_seqlock(&cxld->target_lock);
 	for (i = 0; i < cxld->nr_targets; i++) {
@@ -617,9 +616,6 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 	}
 	write_sequnlock(&cxld->target_lock);
 
-out_unlock:
-	cxl_device_unlock(&port->dev);
-
 	return rc;
 }
 
@@ -721,7 +717,7 @@ struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
 
 /**
- * cxl_decoder_add - Add a decoder with targets
+ * cxl_decoder_add_locked - Add a decoder with targets
  * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
  * @target_map: A list of downstream ports that this decoder can direct memory
  *              traffic to. These numbers should correspond with the port number
@@ -731,12 +727,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
  * is an endpoint device. A more awkward example is a hostbridge whose root
  * ports get hot added (technically possible, though unlikely).
  *
- * Context: Process context. Takes and releases the cxld's device lock.
+ * This is the locked variant of cxl_decoder_add().
+ *
+ * Context: Process context. Expects the device lock of the port that owns the
+ *	    @cxld to be held.
  *
  * Return: Negative error code if the decoder wasn't properly configured; else
  *	   returns 0.
  */
-int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
+int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
 {
 	struct cxl_port *port;
 	struct device *dev;
@@ -770,6 +769,40 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 
 	return device_add(dev);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_decoder_add_locked, CXL);
+
+/**
+ * cxl_decoder_add - Add a decoder with targets
+ * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
+ * @target_map: A list of downstream ports that this decoder can direct memory
+ *              traffic to. These numbers should correspond with the port number
+ *              in the PCIe Link Capabilities structure.
+ *
+ * This is the unlocked variant of cxl_decoder_add_locked().
+ * See cxl_decoder_add_locked().
+ *
+ * Context: Process context. Takes and releases the device lock of the port that
+ *	    owns the @cxld.
+ */
+int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
+{
+	struct cxl_port *port;
+	int rc;
+
+	if (WARN_ON_ONCE(!cxld))
+		return -EINVAL;
+
+	if (WARN_ON_ONCE(IS_ERR(cxld)))
+		return PTR_ERR(cxld);
+
+	port = to_cxl_port(cxld->dev.parent);
+
+	cxl_device_lock(&port->dev);
+	rc = cxl_decoder_add_locked(cxld, target_map);
+	cxl_device_unlock(&port->dev);
+
+	return rc;
+}
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
 
 static void cxld_unregister(void *dev)
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 65d7f5880671..718b6b0ae4b3 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -159,9 +159,8 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, CXL);
 
-static void __iomem *devm_cxl_iomap_block(struct device *dev,
-					  resource_size_t addr,
-					  resource_size_t length)
+void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
+				   resource_size_t length)
 {
 	void __iomem *ret_val;
 	struct resource *res;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0754c68ccd33..c127d5c0ac96 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -17,6 +17,9 @@
  * (port-driver, region-driver, nvdimm object-drivers... etc).
  */
 
+/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
+#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
+
 /* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
 #define CXL_CM_OFFSET 0x1000
 #define CXL_CM_CAP_HDR_OFFSET 0x0
@@ -36,11 +39,23 @@
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
 #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
 #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
-#define CXL_HDM_DECODER0_BASE_LOW_OFFSET 0x10
-#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET 0x14
-#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET 0x18
-#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET 0x1c
-#define CXL_HDM_DECODER0_CTRL_OFFSET 0x20
+#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
+#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
+#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
+#define   CXL_HDM_DECODER_ENABLE BIT(1)
+#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
+#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
+#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
+#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
+#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
+#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
+#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
+#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
+#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
+#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
+#define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
+#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
+#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
 
 static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 {
@@ -162,7 +177,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
 #define CXL_DECODER_F_TYPE2 BIT(2)
 #define CXL_DECODER_F_TYPE3 BIT(3)
 #define CXL_DECODER_F_LOCK  BIT(4)
-#define CXL_DECODER_F_MASK  GENMASK(4, 0)
+#define CXL_DECODER_F_ENABLE    BIT(5)
+#define CXL_DECODER_F_MASK  GENMASK(5, 0)
 
 enum cxl_decoder_type {
        CXL_DECODER_ACCELERATOR = 2,
@@ -306,7 +322,12 @@ struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 					     unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
+int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
+struct cxl_hdm;
+struct cxl_hdm *devm_cxl_setup_hdm(struct device *host, struct cxl_port *port);
+int devm_cxl_enumerate_decoders(struct device *host, struct cxl_hdm *cxlhdm);
+int devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port);
 
 extern struct bus_type cxl_bus_type;
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8d96d009ad90..fca2d1b5f6ff 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -264,4 +264,12 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
+
+struct cxl_hdm {
+	struct cxl_component_regs regs;
+	unsigned int decoder_count;
+	unsigned int target_count;
+	unsigned int interleave_mask;
+	struct cxl_port *port;
+};
 #endif /* __CXL_MEM_H__ */
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 61123544aa49..3045d7cba0db 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -5,6 +5,9 @@ ldflags-y += --wrap=acpi_evaluate_integer
 ldflags-y += --wrap=acpi_pci_find_root
 ldflags-y += --wrap=nvdimm_bus_register
 ldflags-y += --wrap=devm_cxl_port_enumerate_dports
+ldflags-y += --wrap=devm_cxl_setup_hdm
+ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
+ldflags-y += --wrap=devm_cxl_enumerate_decoders
 
 DRIVERS := ../../../drivers
 CXL_SRC := $(DRIVERS)/cxl
@@ -31,6 +34,7 @@ cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o
 cxl_core-y += $(CXL_CORE_SRC)/mbox.o
 cxl_core-y += $(CXL_CORE_SRC)/pci.o
+cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += config_check.o
 
 obj-m += test/
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index ef002e909d38..81c09380c537 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -8,6 +8,7 @@
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include <linux/mm.h>
+#include <cxlmem.h>
 #include "mock.h"
 
 #define NR_CXL_HOST_BRIDGES 4
@@ -398,6 +399,31 @@ static struct acpi_pci_root *mock_acpi_pci_find_root(acpi_handle handle)
 	return &mock_pci_root[host_bridge_index(adev)];
 }
 
+static struct cxl_hdm *mock_cxl_setup_hdm(struct device *host,
+					  struct cxl_port *port)
+{
+	struct cxl_hdm *cxlhdm = devm_kzalloc(&port->dev, sizeof(*cxlhdm), GFP_KERNEL);
+
+	if (!cxlhdm)
+		return ERR_PTR(-ENOMEM);
+
+	cxlhdm->port = port;
+	return cxlhdm;
+}
+
+static int mock_cxl_add_passthrough_decoder(struct device *host,
+					    struct cxl_port *port)
+{
+	dev_err(&port->dev, "unexpected passthrough decoder for cxl_test\n");
+	return -EOPNOTSUPP;
+}
+
+static int mock_cxl_enumerate_decoders(struct device *host,
+				       struct cxl_hdm *cxlhdm)
+{
+	return 0;
+}
+
 static int mock_cxl_port_enumerate_dports(struct device *host,
 					  struct cxl_port *port)
 {
@@ -439,6 +465,9 @@ static struct cxl_mock_ops cxl_mock_ops = {
 	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
 	.acpi_pci_find_root = mock_acpi_pci_find_root,
 	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
+	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
+	.devm_cxl_add_passthrough_decoder = mock_cxl_add_passthrough_decoder,
+	.devm_cxl_enumerate_decoders = mock_cxl_enumerate_decoders,
 	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
 };
 
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 56b4b7d734bc..18d3b65e2a9b 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -131,6 +131,56 @@ __wrap_nvdimm_bus_register(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
 
+struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct device *host,
+					  struct cxl_port *port)
+{
+	int index;
+	struct cxl_hdm *cxlhdm;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_port(port->uport))
+		cxlhdm = ops->devm_cxl_setup_hdm(host, port);
+	else
+		cxlhdm = devm_cxl_setup_hdm(host, port);
+	put_cxl_mock_ops(index);
+
+	return cxlhdm;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_setup_hdm, CXL);
+
+int __wrap_devm_cxl_add_passthrough_decoder(struct device *host,
+					    struct cxl_port *port)
+{
+	int rc, index;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_port(port->uport))
+		rc = ops->devm_cxl_add_passthrough_decoder(host, port);
+	else
+		rc = devm_cxl_add_passthrough_decoder(host, port);
+	put_cxl_mock_ops(index);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_passthrough_decoder, CXL);
+
+int __wrap_devm_cxl_enumerate_decoders(struct device *host,
+				       struct cxl_hdm *cxlhdm)
+{
+	int rc, index;
+	struct cxl_port *port = cxlhdm->port;
+	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
+
+	if (ops && ops->is_mock_port(port->uport))
+		rc = ops->devm_cxl_enumerate_decoders(host, cxlhdm);
+	else
+		rc = devm_cxl_enumerate_decoders(host, cxlhdm);
+	put_cxl_mock_ops(index);
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_enumerate_decoders, CXL);
+
 int __wrap_devm_cxl_port_enumerate_dports(struct device *host,
 					  struct cxl_port *port)
 {
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index 99e7ff38090d..15e48063ea4b 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -21,6 +21,9 @@ struct cxl_mock_ops {
 	bool (*is_mock_dev)(struct device *dev);
 	int (*devm_cxl_port_enumerate_dports)(struct device *host,
 					      struct cxl_port *port);
+	struct cxl_hdm *(*devm_cxl_setup_hdm)(struct device *host, struct cxl_port *port);
+	int (*devm_cxl_add_passthrough_decoder)(struct device *host, struct cxl_port *port);
+	int (*devm_cxl_enumerate_decoders)(struct device *host, struct cxl_hdm *hdm);
 };
 
 void register_cxl_mock_ops(struct cxl_mock_ops *ops);

