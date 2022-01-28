Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5FC249EFBA
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 01:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344756AbiA1A3O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 19:29:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:64738 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344745AbiA1A3H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 19:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643329747; x=1674865747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FLeYXW6NWFrswyPwmJIx1vkrYrqwZ/21bKcdDaAYGsU=;
  b=B/J3WUKpvcbJIp4W5eccWACPNAY5qQ2MVkESc6NtR1x0irj4AXd1HT3Q
   mFtNxWrnJL2ML0Qan1M70eScT84fAWxuLm6c1OIXH6Vgs5Xe69F2IpIdq
   7pBvgzLjrBj0h0gmLo5txHVs9tx/qDi+CdC5rhUCPZCyukq7NOHiAcsJ0
   KhqMW067CA5TYdvjyoc2PWw2vtv989OrhwqzbkYj+WGoZuXVrqn00TCrn
   hZ4ZChDoYIvYdaOhGRUfQQ92tjuEcCFZ5SJbu0ptj3frtoB07rbxsFcre
   4aWcQ/PlrQzrvMHk1xjeus5mjyaetCijGriK7w2nJKvl9CNKxFR3ghgHR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230580018"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="230580018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:27 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="674909645"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:27 -0800
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
Subject: [PATCH v3 09/14] cxl/region: Add infrastructure for decoder programming
Date:   Thu, 27 Jan 2022 16:27:02 -0800
Message-Id: <20220128002707.391076-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128002707.391076-1-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are 3 steps in handling region programming once it has been
configured by userspace.
1. Sanitize the parameters against the system.
2. Collect decoder resources from the topology
3. Program decoder resources

The infrastructure added here addresses #2. Two new APIs are introduced
to allow collecting and returning decoder resources. Additionally the
infrastructure includes two lists managed by the region driver, a staged
list, and a commit list. The staged list contains those collected in
step #2, and the commit list are all the decoders programmed in step #3.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/port.c   |  71 ++++++++++++++++++++++
 drivers/cxl/core/region.c |   2 +
 drivers/cxl/cxl.h         |   8 +++
 drivers/cxl/cxlmem.h      |   7 +++
 drivers/cxl/port.c        |  62 ++++++++++++++++++-
 drivers/cxl/region.c      | 125 +++++++++++++++++++++++++++++++++-----
 drivers/cxl/region.h      |   5 ++
 7 files changed, 263 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 1d81c5f56a3e..92aaaa65ec61 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1212,6 +1212,8 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
 
+	INIT_LIST_HEAD(&cxld->region_link);
+
 	ida_init(&cxld->region_ida);
 
 	return cxld;
@@ -1366,6 +1368,75 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
 
+/**
+ * cxl_get_decoder() - Get an unused decoder from the port.
+ * @port: The port to obtain a decoder from.
+ *
+ * Region programming requires obtaining decoder resources from all ports that
+ * participate in the interleave set. This function shall be used to pull the
+ * decoder resource out of the list of available.
+ *
+ * Context: Process context. Takes and releases the device lock of the port.
+ *
+ * Return: A cxl_decoder that can be used for programming if successful, else a
+ *	   negative error code.
+ */
+struct cxl_decoder *cxl_get_decoder(struct cxl_port *port)
+{
+	struct cxl_hdm *cxlhdm;
+	int dec;
+
+	cxlhdm = dev_get_drvdata(&port->dev);
+	if (dev_WARN_ONCE(&port->dev, !cxlhdm, "No port drvdata\n"))
+		return ERR_PTR(-ENXIO);
+
+	device_lock(&port->dev);
+	dec = find_first_bit(cxlhdm->decoders.free_mask,
+			     cxlhdm->decoders.count);
+	if (dec == cxlhdm->decoders.count) {
+		device_unlock(&port->dev);
+		return ERR_PTR(-ENODEV);
+	}
+
+	clear_bit(dec, cxlhdm->decoders.free_mask);
+	device_unlock(&port->dev);
+
+	return cxlhdm->decoders.cxld[dec];
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_decoder, CXL);
+
+/**
+ * cxl_put_decoder() - Return an inactive decoder to the port.
+ * @cxld: The decoder being returned.
+ */
+void cxl_put_decoder(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	struct cxl_hdm *cxlhdm;
+	int i;
+
+	cxlhdm = dev_get_drvdata(&port->dev);
+	if (dev_WARN_ONCE(&port->dev, !cxlhdm, "No port drvdata\n"))
+		return;
+
+	device_lock(&port->dev);
+
+	for (i = 0; i < CXL_DECODER_MAX_INSTANCES; i++) {
+		struct cxl_decoder *d = cxlhdm->decoders.cxld[i];
+
+		if (!d)
+			continue;
+
+		if (d == cxld) {
+			set_bit(i, cxlhdm->decoders.free_mask);
+			break;
+		}
+	}
+
+	device_unlock(&port->dev);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_put_decoder, CXL);
+
 static void cxld_unregister(void *dev)
 {
 	device_unregister(dev);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 784e4ba25128..a62d48454a56 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -440,6 +440,8 @@ struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld, int id)
 	if (!cxlr)
 		return ERR_PTR(-ENOMEM);
 
+	INIT_LIST_HEAD(&cxlr->staged_list);
+	INIT_LIST_HEAD(&cxlr->commit_list);
 	cxlr->id = id;
 
 	return cxlr;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ed984465b59c..8ace6cca0776 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -35,6 +35,8 @@
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
+#define CXL_DECODER_MAX_INSTANCES 10
+
 /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
 #define CXL_HDM_DECODER_CAP_OFFSET 0x0
 #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
@@ -265,6 +267,7 @@ enum cxl_decoder_type {
  * @target_lock: coordinate coherent reads of the target list
  * @region_ida: allocator for region ids.
  * @address_space: Used/free address space for regions.
+ * @region_link: This decoder's place on either the staged, or commit list.
  * @nr_targets: number of elements in @target
  * @target: active ordered target list in current decoder configuration
  */
@@ -282,6 +285,7 @@ struct cxl_decoder {
 	seqlock_t target_lock;
 	struct ida region_ida;
 	struct gen_pool *address_space;
+	struct list_head region_link;
 	int nr_targets;
 	struct cxl_dport *target[];
 };
@@ -326,6 +330,7 @@ struct cxl_nvdimm {
  * @id: id for port device-name
  * @dports: cxl_dport instances referenced by decoders
  * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
+ * @region_link: this port's node on the region's list of ports
  * @decoder_ida: allocator for decoder ids
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
@@ -396,6 +401,8 @@ struct cxl_port *find_cxl_root(struct device *dev);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 int cxl_bus_rescan(void);
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd);
+struct cxl_decoder *cxl_get_decoder(struct cxl_port *port);
+void cxl_put_decoder(struct cxl_decoder *cxld);
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
@@ -406,6 +413,7 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 struct cxl_port *ep_find_cxl_port(struct cxl_memdev *cxlmd, unsigned int depth);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
+bool is_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_cxl_decoder(struct device *dev);
 struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2b8c66616d4e..6db66eaf51be 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -305,5 +305,12 @@ struct cxl_hdm {
 	unsigned int target_count;
 	unsigned int interleave_mask;
 	struct cxl_port *port;
+
+	struct port_decoders {
+		unsigned long *free_mask;
+		int count;
+
+		struct cxl_decoder *cxld[CXL_DECODER_MAX_INSTANCES];
+	} decoders;
 };
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d420da5fc39c..fdb62ed06433 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -30,11 +30,55 @@ static void schedule_detach(void *cxlmd)
 	schedule_cxl_memdev_detach(cxlmd);
 }
 
+static int count_decoders(struct device *dev, void *data)
+{
+	if (is_cxl_decoder(dev))
+		(*(int *)data)++;
+
+	return 0;
+}
+
+struct dec_init_ctx {
+	struct cxl_hdm *cxlhdm;
+	int ndx;
+};
+
+static int set_decoders(struct device *dev, void *data)
+{
+	struct cxl_decoder *cxld;
+	struct dec_init_ctx *ctx;
+	struct cxl_hdm *cxlhdm;
+	int dec;
+
+	if (!is_cxl_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+
+	ctx = data;
+
+	cxlhdm = ctx->cxlhdm;
+	dec = ctx->ndx++;
+	cxlhdm->decoders.cxld[dec] = cxld;
+
+	if (cxld->flags & CXL_DECODER_F_ENABLE) {
+		dev_dbg(dev, "Not adding to free decoders\n");
+		return 0;
+	}
+
+	set_bit(dec, cxlhdm->decoders.free_mask);
+
+	dev_dbg(dev, "Adding to free decoder list\n");
+
+	return 0;
+}
+
 static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
+	int rc, decoder_count = 0;
+	struct dec_init_ctx ctx;
 	struct cxl_hdm *cxlhdm;
-	int rc;
 
 	if (is_cxl_endpoint(port)) {
 		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
@@ -61,6 +105,22 @@ static int cxl_port_probe(struct device *dev)
 		return rc;
 	}
 
+	device_for_each_child(dev, &decoder_count, count_decoders);
+
+	cxlhdm->decoders.free_mask =
+		devm_bitmap_zalloc(dev, decoder_count, GFP_KERNEL);
+	cxlhdm->decoders.count = decoder_count;
+
+	ctx.cxlhdm = cxlhdm;
+	ctx.ndx = 0;
+	if (device_for_each_child(dev, &ctx, set_decoders))
+		return -ENXIO;
+
+	dev_set_drvdata(dev, cxlhdm);
+
+	dev_dbg(dev, "Setup complete. Free decoders %*pb\n",
+		cxlhdm->decoders.count, &cxlhdm->decoders.free_mask);
+
 	return 0;
 }
 
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index d2f6c990c8a8..145d7bb02714 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -359,21 +359,59 @@ static bool has_switch(const struct cxl_region *cxlr)
 	return false;
 }
 
+static struct cxl_decoder *get_decoder(struct cxl_region *cxlr,
+				       struct cxl_port *p)
+{
+	struct cxl_decoder *cxld;
+
+	cxld = cxl_get_decoder(p);
+	if (IS_ERR(cxld)) {
+		dev_dbg(&cxlr->dev, "Couldn't get decoder for %s\n",
+			dev_name(&p->dev));
+		return cxld;
+	}
+
+	cxld->decoder_range = (struct range){ .start = cxlr->res->start,
+					      .end = cxlr->res->end };
+
+	list_add_tail(&cxld->region_link,
+		      (struct list_head *)&cxlr->staged_list);
+
+	return cxld;
+}
+
+static bool simple_config(struct cxl_region *cxlr, struct cxl_port *hb)
+{
+	struct cxl_decoder *cxld;
+
+	cxld = get_decoder(cxlr, hb);
+	if (IS_ERR(cxld))
+		return false;
+
+	cxld->interleave_ways = 1;
+	cxld->interleave_granularity = region_granularity(cxlr);
+	cxld->target[0] = get_rp(cxlr->config.targets[0]);
+	return true;
+}
+
 /**
  * region_hb_rp_config_valid() - determine root port ordering is correct
  * @cxlr: Region to validate
  * @rootd: root decoder for this @cxlr
+ * @state_update: Whether or not to update port state
  *
  * The algorithm is outlined in 2.13.15 "Verify HB root port configuration
  * sequence" of the CXL Memory Device SW Guide (Rev1p0).
  *
  * Returns true if the configuration is valid.
  */
-static bool region_hb_rp_config_valid(const struct cxl_region *cxlr,
-				      const struct cxl_decoder *rootd)
+static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
+				      const struct cxl_decoder *rootd,
+				      bool state_update)
 {
 	const int num_root_ports = get_num_root_ports(cxlr);
 	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	struct cxl_decoder *cxld, *c;
 	int hb_count, i;
 
 	hb_count = get_unique_hostbridges(cxlr, hbs);
@@ -386,8 +424,8 @@ static bool region_hb_rp_config_valid(const struct cxl_region *cxlr,
 	 * Are all devices in this region on the same CXL Host Bridge
 	 * Root Port?
 	 */
-	if (num_root_ports == 1 && !has_switch(cxlr))
-		return true;
+	if (num_root_ports == 1 && !has_switch(cxlr) && state_update)
+		return simple_config(cxlr, hbs[0]);
 
 	for (i = 0; i < hb_count; i++) {
 		int idx, position_mask;
@@ -397,6 +435,20 @@ static bool region_hb_rp_config_valid(const struct cxl_region *cxlr,
 		/* Get next CXL Host Bridge this region spans */
 		hb = hbs[i];
 
+		if (state_update) {
+			cxld = get_decoder(cxlr, hb);
+			if (IS_ERR(cxld)) {
+				dev_dbg(&cxlr->dev,
+					"Couldn't get decoder for %s\n",
+					dev_name(&hb->dev));
+				goto err;
+			}
+			cxld->interleave_ways = 0;
+			cxld->interleave_granularity = region_granularity(cxlr);
+		} else {
+			cxld = NULL;
+		}
+
 		/*
 		 * Calculate the position mask: NumRootPorts = 2^PositionMask
 		 * for this region.
@@ -432,13 +484,20 @@ static bool region_hb_rp_config_valid(const struct cxl_region *cxlr,
 				if ((idx & position_mask) != port_grouping) {
 					dev_dbg(&cxlr->dev,
 						"One or more devices are not connected to the correct Host Bridge Root Port\n");
-					return false;
+					goto err;
 				}
 			}
 		}
 	}
 
 	return true;
+
+err:
+	dev_dbg(&cxlr->dev, "Couldn't get decoder for region\n");
+	list_for_each_entry_safe(cxld, c, &cxlr->staged_list, region_link)
+		cxl_put_decoder(cxld);
+
+	return false;
 }
 
 /**
@@ -454,7 +513,7 @@ static bool rootd_contains(const struct cxl_region *cxlr,
 }
 
 static bool rootd_valid(const struct cxl_region *cxlr,
-			const struct cxl_decoder *rootd)
+			const struct cxl_decoder *rootd, bool state_update)
 {
 	const struct cxl_memdev *endpoint = cxlr->config.targets[0];
 
@@ -467,7 +526,8 @@ static bool rootd_valid(const struct cxl_region *cxlr,
 	if (!region_xhb_config_valid(cxlr, rootd))
 		return false;
 
-	if (!region_hb_rp_config_valid(cxlr, rootd))
+	if (!region_hb_rp_config_valid((struct cxl_region *)cxlr, rootd,
+				       state_update))
 		return false;
 
 	if (!rootd_contains(cxlr, rootd))
@@ -490,7 +550,7 @@ static int rootd_match(struct device *dev, void *data)
 	if (!is_root_decoder(dev))
 		return 0;
 
-	return !!rootd_valid(cxlr, to_cxl_decoder(dev));
+	return !!rootd_valid(cxlr, to_cxl_decoder(dev), false);
 }
 
 /*
@@ -513,10 +573,39 @@ static struct cxl_decoder *find_rootd(const struct cxl_region *cxlr,
 	return NULL;
 }
 
-static int collect_ep_decoders(const struct cxl_region *cxlr)
+static void cleanup_staged_decoders(struct cxl_region *cxlr)
 {
-	/* TODO: */
+	struct cxl_decoder *cxld, *d;
+
+	list_for_each_entry_safe(cxld, d, &cxlr->staged_list, region_link) {
+		cxl_put_decoder(cxld);
+		list_del_init(&cxld->region_link);
+	}
+}
+
+static int collect_ep_decoders(struct cxl_region *cxlr)
+{
+	struct cxl_memdev *ep;
+	int i, rc = 0;
+
+	for_each_cxl_endpoint(ep, cxlr, i) {
+		struct cxl_decoder *cxld;
+
+		cxld = get_decoder(cxlr, ep->port);
+		if (IS_ERR(cxld)) {
+			rc = PTR_ERR(cxld);
+			goto err;
+		}
+
+		cxld->interleave_granularity = region_granularity(cxlr);
+		cxld->interleave_ways = region_ways(cxlr);
+	}
+
 	return 0;
+
+err:
+	cleanup_staged_decoders(cxlr);
+	return rc;
 }
 
 static int bind_region(const struct cxl_region *cxlr)
@@ -559,7 +648,7 @@ static int cxl_region_probe(struct device *dev)
 		return -ENXIO;
 	}
 
-	if (!rootd_valid(cxlr, rootd)) {
+	if (!rootd_valid(cxlr, rootd, true)) {
 		dev_err(dev, "Picked invalid rootd\n");
 		return -ENXIO;
 	}
@@ -574,14 +663,18 @@ static int cxl_region_probe(struct device *dev)
 
 	ret = collect_ep_decoders(cxlr);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = bind_region(cxlr);
-	if (!ret) {
-		cxlr->active = true;
-		dev_info(dev, "Bound");
-	}
+	if (ret)
+		goto err;
 
+	cxlr->active = true;
+	dev_info(dev, "Bound");
+	return 0;
+
+err:
+	cleanup_staged_decoders(cxlr);
 	return ret;
 }
 
diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
index 00a6dc729c26..fc15abaeb638 100644
--- a/drivers/cxl/region.h
+++ b/drivers/cxl/region.h
@@ -14,6 +14,9 @@
  * @list: Node in decoder's region list.
  * @res: Resource this region carves out of the platform decode range.
  * @active: If the region has been activated.
+ * @staged_list: All decoders staged for programming.
+ * @commit_list: All decoders programmed for this region's parameters.
+ *
  * @config: HDM decoder program config
  * @config.size: Size of the region determined from LSA or userspace.
  * @config.uuid: The UUID for this region.
@@ -27,6 +30,8 @@ struct cxl_region {
 	struct list_head list;
 	struct resource *res;
 	bool active;
+	struct list_head staged_list;
+	struct list_head commit_list;
 
 	struct {
 		u64 size;
-- 
2.35.0

