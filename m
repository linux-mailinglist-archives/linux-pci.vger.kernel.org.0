Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8921648CF49
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 00:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiALXsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 18:48:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:13997 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235701AbiALXsM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 18:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642031291; x=1673567291;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YO2Ot6y/mQlJkn+3gmnqrMaGYXUcIjEDLCqlgYoObAI=;
  b=B/dXz/sGEmexEsR30YY/6dHO3prEGTJCYsRxNIITCi1rLOzNrW3/8bqf
   OkKHSYmCyMaPZXq+RhfP0N/CVbcdY4I2+60wjjUJ/MRDF2qRret1ltueT
   NhG7mSn0NFu8AqQFoZif8Pw3OD8zRyWe+NIwyL9WSWIJnIu/QdZmjxAg8
   GhdIuerDbDRkPmFjoMtXvHhngXsSM8haCMNuH0Pk0fDiwRqVM3L1r5vSb
   iGCrlUI1eLJUB5YyLcF71WIZqxqHG+l3SgPobFXcfH9COPMqx58ADnq4w
   gOxAz+39QVw8avMcnAu0pXhy1WMTRv/xkDeARDBpJoDpN6R8ssdRrQ8rB
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242695355"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242695355"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:11 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="670324206"
Received: from jmaclean-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.136.131])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:10 -0800
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
Subject: [PATCH v2 11/15] cxl/region: Add infrastructure for decoder programming
Date:   Wed, 12 Jan 2022 15:47:45 -0800
Message-Id: <20220112234749.1965960-12-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112234749.1965960-1-ben.widawsky@intel.com>
References: <20220112234749.1965960-1-ben.widawsky@intel.com>
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
 drivers/cxl/core/port.c   |  75 +++++++++++++++++++++++++--
 drivers/cxl/core/region.c |   2 +
 drivers/cxl/cxl.h         |   8 +++
 drivers/cxl/cxlmem.h      |   7 +++
 drivers/cxl/port.c        |  42 +++++++++++++++-
 drivers/cxl/region.c      | 103 ++++++++++++++++++++++++++++++++------
 drivers/cxl/region.h      |   5 ++
 7 files changed, 224 insertions(+), 18 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 99589f23f1ff..41a7dccacb49 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -32,8 +32,6 @@ static DEFINE_XARRAY(cxl_root_buses);
 
 static void cxl_decoder_release(struct device *dev);
 
-static bool is_cxl_decoder(struct device *dev);
-
 static int decoder_match(struct device *dev, void *data)
 {
 	struct resource *theirs = (struct resource *)data;
@@ -291,10 +289,11 @@ bool is_root_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
 
-static bool is_cxl_decoder(struct device *dev)
+bool is_cxl_decoder(struct device *dev)
 {
 	return dev->type->release == cxl_decoder_release;
 }
+EXPORT_SYMBOL_NS_GPL(is_cxl_decoder, CXL);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev)
 {
@@ -1040,6 +1039,8 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
 
+	INIT_LIST_HEAD(&cxld->region_link);
+
 	ida_init(&cxld->region_ida);
 
 	return cxld;
@@ -1200,6 +1201,74 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
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
+	struct cxl_port_state *cxlps;
+	int dec;
+
+	cxlps = dev_get_drvdata(&port->dev);
+	if (dev_WARN_ONCE(&port->dev, !cxlps, "No port drvdata\n"))
+		return ERR_PTR(-ENXIO);
+
+	device_lock(&port->dev);
+	dec = find_first_bit(cxlps->decoders.free_mask, cxlps->decoders.count);
+	if (dec == cxlps->decoders.count) {
+		device_unlock(&port->dev);
+		return ERR_PTR(-ENODEV);
+	}
+
+	clear_bit(dec, cxlps->decoders.free_mask);
+	device_unlock(&port->dev);
+
+	return cxlps->decoders.cxld[dec];
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
+	struct cxl_port_state *cxlps;
+	int i;
+
+	cxlps = dev_get_drvdata(&port->dev);
+	if (dev_WARN_ONCE(&port->dev, !cxlps, "No port drvdata\n"))
+		return;
+
+	device_lock(&port->dev);
+
+	for (i = 0; i < CXL_DECODER_MAX_INSTANCES; i++) {
+		struct cxl_decoder *d = cxlps->decoders.cxld[i];
+
+		if (!d)
+			break;
+
+		if (d == cxld) {
+			set_bit(i, cxlps->decoders.free_mask);
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
 	struct cxl_decoder *plat_decoder, *cxld = to_cxl_decoder(dev);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 051cd32ea628..0ecd17e4dd0c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -435,6 +435,8 @@ struct cxl_region *cxl_alloc_region(struct cxl_decoder *cxld, int id)
 	if (!region)
 		return ERR_PTR(-ENOMEM);
 
+	INIT_LIST_HEAD(&region->staged_list);
+	INIT_LIST_HEAD(&region->commit_list);
 	region->id = id;
 
 	return region;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 4de4c0ee8eb2..81c35be13416 100644
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
@@ -221,6 +223,7 @@ enum cxl_decoder_type {
  * @flags: memory type capabilities and locking
  * @region_ida: allocator for region ids.
  * @address_space: Used/free address space for regions.
+ * @region_link: This decoder's place on either the staged, or commit list.
  * @nr_targets: number of elements in @target
  * @target: active ordered target list in current decoder configuration
  */
@@ -237,6 +240,7 @@ struct cxl_decoder {
 	unsigned long flags;
 	struct ida region_ida;
 	struct gen_pool *address_space;
+	struct list_head region_link;
 	const int nr_targets;
 	struct cxl_dport *target[];
 };
@@ -290,6 +294,7 @@ struct cxl_walk_context {
  * @id: id for port device-name
  * @dports: cxl_dport instances referenced by decoders
  * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
+ * @region_link: this port's node on the region's list of ports
  * @decoder_ida: allocator for decoder ids
  * @component_reg_phys: component register capability base address (optional)
  * @dead: last ep has been removed, force port re-creation
@@ -360,6 +365,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   struct cxl_port *parent_port);
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd);
+struct cxl_decoder *cxl_get_decoder(struct cxl_port *port);
+void cxl_put_decoder(struct cxl_decoder *cxld);
 bool schedule_cxl_rescan(void);
 
 struct cxl_dport *cxl_add_dport(struct cxl_port *port, struct device *dport,
@@ -372,6 +379,7 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 struct cxl_port *ep_find_cxl_port(struct cxl_memdev *cxlmd, unsigned int depth);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
+bool is_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 					   unsigned int nr_targets);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 38d6129499c8..e4793e5f25bc 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -301,6 +301,13 @@ struct cxl_port_state {
 		unsigned int interleave11_8;
 		unsigned int interleave14_12;
 	} caps;
+
+	struct port_decoders {
+		unsigned long *free_mask;
+		int count;
+
+		struct cxl_decoder *cxld[CXL_DECODER_MAX_INSTANCES];
+	} decoders;
 };
 
 int devm_cxl_setup_hdm(struct cxl_port *port);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c10b462373db..ddf6e78189ee 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -41,10 +41,39 @@ static bool is_cxl_endpoint(struct cxl_port *port)
 	return is_cxl_memdev(port->uport);
 }
 
+static int count_decoders(struct device *dev, void *data)
+{
+	if (is_cxl_decoder(dev))
+		(*(int *)data)++;
+
+	return 0;
+}
+
+static int set_decoders(struct device *dev, void *data)
+{
+	struct cxl_port_state *cxlps;
+	int dec;
+
+	if (!is_cxl_decoder(dev))
+		return 0;
+
+	cxlps = data;
+	dec = find_first_zero_bit(cxlps->decoders.free_mask, cxlps->decoders.count);
+	if (dev_WARN_ONCE(dev, dec == cxlps->decoders.count,
+			  "Impossible decoder bitmap state\n"))
+		return 1;
+
+	set_bit(dec, cxlps->decoders.free_mask);
+	cxlps->decoders.cxld[dec] = to_cxl_decoder(dev);
+
+	return 0;
+}
+
 static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
-	int rc;
+	struct cxl_port_state *cxlps;
+	int rc, decoder_count = 0;
 
 	if (!is_cxl_endpoint(port)) {
 		rc = cxl_port_enumerate_dports(port);
@@ -59,6 +88,8 @@ static int cxl_port_probe(struct device *dev)
 	if (rc)
 		return rc;
 
+	cxlps = dev_get_drvdata(dev);
+
 	if (is_cxl_endpoint(port))
 		rc = devm_cxl_enumerate_endpoint_decoders(port);
 	else
@@ -68,6 +99,15 @@ static int cxl_port_probe(struct device *dev)
 		return rc;
 	}
 
+	device_for_each_child(&port->dev, &decoder_count, count_decoders);
+
+	cxlps->decoders.free_mask =
+		devm_bitmap_zalloc(&port->dev, decoder_count, GFP_KERNEL);
+	cxlps->decoders.count = decoder_count;
+
+	if (device_for_each_child(&port->dev, cxlps, set_decoders))
+		return -ENXIO;
+
 	schedule_cxl_rescan();
 
 	return 0;
diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
index 1f8919ad8dcc..cb3fc8de4c23 100644
--- a/drivers/cxl/region.c
+++ b/drivers/cxl/region.c
@@ -349,17 +349,20 @@ static bool has_switch(const struct cxl_region *region)
  * region_hb_rp_config_valid() - determine root port ordering is correct
  * @rootd: root decoder for this @region
  * @region: Region to validate
+ * @state_update: Whether or not to update port state
  *
  * The algorithm is outlined in 2.13.15 "Verify HB root port configuration
  * sequence" of the CXL Memory Device SW Guide (Rev1p0).
  *
  * Returns true if the configuration is valid.
  */
-static bool region_hb_rp_config_valid(const struct cxl_region *region,
-				      const struct cxl_decoder *rootd)
+static bool region_hb_rp_config_valid(struct cxl_region *region,
+				      const struct cxl_decoder *rootd,
+				      bool state_update)
 {
 	const int num_root_ports = get_num_root_ports(region);
 	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
+	struct cxl_decoder *cxld, *c;
 	int hb_count, i;
 
 	hb_count = get_unique_hostbridges(region, hbs);
@@ -368,8 +371,25 @@ static bool region_hb_rp_config_valid(const struct cxl_region *region,
 	 * Are all devices in this region on the same CXL Host Bridge
 	 * Root Port?
 	 */
-	if (num_root_ports == 1 && !has_switch(region))
+	if (num_root_ports == 1 && !has_switch(region)) {
+		struct cxl_decoder *cxld;
+
+		if (!state_update)
+			return true;
+
+		cxld = cxl_get_decoder(hbs[0]);
+		if (!cxld) {
+			dev_dbg(&region->dev, "Couldn't get decoder for %s\n",
+				dev_name(&hbs[0]->dev));
+			return false;
+		}
+
+		cxld->interleave_ways = 1;
+		cxld->interleave_granularity = region_granularity(region);
+		cxld->target[0] = get_rp(region->config.targets[0]);
+		list_add_tail(&cxld->region_link, (struct list_head *)&region->staged_list);
 		return true;
+	}
 
 	for (i = 0; i < hb_count; i++) {
 		int idx, position_mask;
@@ -379,6 +399,19 @@ static bool region_hb_rp_config_valid(const struct cxl_region *region,
 		/* Get next CXL Host Bridge this region spans */
 		hb = hbs[i];
 
+		if (state_update) {
+			cxld = cxl_get_decoder(hbs[i]);
+			if (IS_ERR(cxld)) {
+				dev_dbg(&region->dev,
+					"Couldn't get decoder for %s\n",
+					dev_name(&hb->dev));
+				goto err;
+			}
+			cxld->interleave_ways = 0;
+		} else {
+			cxld = NULL;
+		}
+
 		/*
 		 * Calculate the position mask: NumRootPorts = 2^PositionMask
 		 * for this region.
@@ -417,9 +450,18 @@ static bool region_hb_rp_config_valid(const struct cxl_region *region,
 				}
 			}
 		}
+		if (state_update)
+			list_add_tail(&cxld->region_link, &region->staged_list);
 	}
 
 	return true;
+
+err:
+	dev_dbg(&region->dev, "Couldn't get decoder for region\n");
+	list_for_each_entry_safe(cxld, c, &region->staged_list, region_link)
+		cxl_put_decoder(cxld);
+
+	return false;
 }
 
 /**
@@ -435,7 +477,8 @@ static bool rootd_contains(const struct cxl_region *region,
 }
 
 static bool rootd_valid(const struct cxl_region *region,
-			const struct cxl_decoder *rootd)
+			const struct cxl_decoder *rootd,
+			bool state_update)
 {
 	const struct cxl_memdev *endpoint = region->config.targets[0];
 
@@ -448,7 +491,7 @@ static bool rootd_valid(const struct cxl_region *region,
 	if (!region_xhb_config_valid(region, rootd))
 		return false;
 
-	if (!region_hb_rp_config_valid(region, rootd))
+	if (!region_hb_rp_config_valid((struct cxl_region *)region, rootd, state_update))
 		return false;
 
 	if (!rootd_contains(region, rootd))
@@ -471,7 +514,7 @@ static int rootd_match(struct device *dev, void *data)
 	if (!is_root_decoder(dev))
 		return 0;
 
-	return !!rootd_valid(region, to_cxl_decoder(dev));
+	return !!rootd_valid(region, to_cxl_decoder(dev), false);
 }
 
 /*
@@ -494,12 +537,40 @@ static struct cxl_decoder *find_rootd(const struct cxl_region *region,
 	return NULL;
 }
 
-static int collect_ep_decoders(const struct cxl_region *region)
+static int collect_ep_decoders(struct cxl_region *region)
 {
-	/* TODO: */
+	struct cxl_memdev *ep;
+	int i;
+
+	for_each_cxl_endpoint(ep, region, i) {
+		struct cxl_decoder *cxld;
+
+		cxld = cxl_get_decoder(ep->port);
+		if (IS_ERR(cxld))
+			return PTR_ERR(cxld);
+
+		cxld->decoder_range = (struct range) {
+			.start = region->res->start,
+			.end = region->res->end
+		};
+		cxld->interleave_granularity = region_granularity(region);
+		cxld->interleave_ways = region_ways(region);
+		list_add_tail(&cxld->region_link, &region->staged_list);
+	}
+
 	return 0;
 }
 
+static void cleanup_staged_decoders(struct cxl_region *region)
+{
+	struct cxl_decoder *cxld, *d;
+
+	list_for_each_entry_safe(cxld, d, &region->staged_list, region_link) {
+		cxl_put_decoder(cxld);
+		list_del_init(&cxld->region_link);
+	}
+}
+
 static int bind_region(const struct cxl_region *region)
 {
 	/* TODO: */
@@ -540,7 +611,7 @@ static int cxl_region_probe(struct device *dev)
 		return -ENXIO;
 	}
 
-	if (!rootd_valid(region, rootd)) {
+	if (!rootd_valid(region, rootd, true)) {
 		dev_err(dev, "Picked invalid rootd\n");
 		return -ENXIO;
 	}
@@ -555,14 +626,18 @@ static int cxl_region_probe(struct device *dev)
 
 	ret = collect_ep_decoders(region);
 	if (ret)
-		return ret;
+		goto err;
 
 	ret = bind_region(region);
-	if (!ret) {
-		region->active = true;
-		dev_info(dev, "Bound");
-	}
+	if (ret)
+		goto err;
 
+	region->active = true;
+	dev_info(dev, "Bound");
+	return 0;
+
+err:
+	cleanup_staged_decoders(region);
 	return ret;
 }
 
diff --git a/drivers/cxl/region.h b/drivers/cxl/region.h
index 9f89f0e8744b..a7938d5090bd 100644
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
2.34.1

