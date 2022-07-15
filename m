Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48494575872
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbiGOAEr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241076AbiGOAEr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:04:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FC873592;
        Thu, 14 Jul 2022 17:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843485; x=1689379485;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AGGVqkzYjbpmuio4U2LN0wVdQD5CLNvX7/u550PTzko=;
  b=Pvbyy+AGQhHxoavJ3cMo1bABCKaSchLuRKwiyziA1sUhZyLbH2bkOYjE
   Xko+33NU5QPLmhe2bW3xlwqEZ/f3DQktVTpMm2HAitxPvj2b/dKi35P+7
   VyjdcYy9q74ZR1S0tzbK7JyIYheYgiZmCBxhaPhAHBmyXvS7eV2aI6Ivf
   1oRrKPVZ9Teh+fmjyKgNU0ZEc25Bb5YFEfxL5rQsGG/mkC1zuBZdy8oUQ
   MSNPX2p6k91yjB4GlpWJfKpYcwrQ2/qSDNVvhgkOYRxQzu+M+hGkQX6bW
   3Y8zctZ/wFYxWybRIDBjavTvAd7rhzosZeEeByX3oB+gmQWWJx98JVplY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="284418754"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="284418754"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:53 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="571302969"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:52 -0700
Subject: [PATCH v2 23/28] cxl/region: Attach endpoint decoders
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <bwidawsk@kernel.org>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:02:52 -0700
Message-ID: <165784337277.1758207.4108508181328528703.stgit@dwillia2-xfh.jf.intel.com>
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

CXL regions (interleave sets) are made up of a set of memory devices
where each device maps a portion of the interleave with one of its
decoders (see CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure).
As endpoint decoders are identified by a provisioning tool they can be
added to a region provided the region interleave properties are set
(way, granularity, HPA) and DPA has been assigned to the decoder.

The attach event triggers several validation checks, for example:
- is the DPA sized appropriately for the region
- is the decoder reachable via the host-bridges identified by the
  region's root decoder
- is the device already active in a different region position slot
- are there already regions with a higher HPA active on a given port
  (per CXL 2.0 8.2.5.12.20 Committing Decoder Programming)

...and the attach event affords an opportunity to collect data and
resources relevant to later programming the target lists in switch
decoders, for example:
- allocate a decoder at each cxl_port in the decode chain
- for a given switch port, how many the region's endpoints are hosted
  through the port
- how many unique targets (next hops) does a port need to map to reach
  those endpoints

The act of reconciling this information and deploying it to the decoder
configuration is saved for a follow-on patch.

Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h   |    7 +
 drivers/cxl/core/port.c   |   10 -
 drivers/cxl/core/region.c |  364 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h         |   20 ++
 drivers/cxl/cxlmem.h      |    5 +
 5 files changed, 394 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index a60ad9f656fd..6edd8174c2b5 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -41,6 +41,13 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
 resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
 extern struct rw_semaphore cxl_dpa_rwsem;
 
+bool is_switch_decoder(struct device *dev);
+static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
+					 struct cxl_memdev *cxlmd)
+{
+	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
+}
+
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
 void cxl_mbox_init(void);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 2f0b47db53da..d234afc47e89 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -448,7 +448,7 @@ bool is_root_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
 
-static bool is_switch_decoder(struct device *dev)
+bool is_switch_decoder(struct device *dev)
 {
 	return is_root_decoder(dev) || dev->type == &cxl_decoder_switch_type;
 }
@@ -504,6 +504,7 @@ static void cxl_port_release(struct device *dev)
 		cxl_ep_remove(port, ep);
 	xa_destroy(&port->endpoints);
 	xa_destroy(&port->dports);
+	xa_destroy(&port->regions);
 	ida_free(&cxl_port_ida, port->id);
 	kfree(port);
 }
@@ -635,6 +636,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	port->hdm_end = -1;
 	xa_init(&port->dports);
 	xa_init(&port->endpoints);
+	xa_init(&port->regions);
 
 	device_initialize(dev);
 	lockdep_set_class_and_subclass(&dev->mutex, &cxl_port_key, port->depth);
@@ -1109,12 +1111,6 @@ static void reap_dports(struct cxl_port *port)
 	}
 }
 
-static struct cxl_ep *cxl_ep_load(struct cxl_port *port,
-				  struct cxl_memdev *cxlmd)
-{
-	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
-}
-
 int devm_cxl_add_endpoint(struct cxl_memdev *cxlmd,
 			  struct cxl_dport *parent_dport)
 {
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 871bfdbb9bc8..8ac0c557f6aa 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -433,21 +433,294 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	return rc;
 }
 
-/*
- * - Check that the given endpoint is attached to a host-bridge identified
- *   in the root interleave.
+static int match_free_decoder(struct device *dev, void *data)
+{
+	struct cxl_decoder *cxld;
+	int *id = data;
+
+	if (!is_switch_decoder(dev))
+		return 0;
+
+	cxld = to_cxl_decoder(dev);
+
+	/* enforce ordered allocation */
+	if (cxld->id != *id)
+		return 0;
+
+	if (!cxld->region)
+		return 1;
+
+	(*id)++;
+
+	return 0;
+}
+
+static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
+						   struct cxl_region *cxlr)
+{
+	struct device *dev;
+	int id = 0;
+
+	dev = device_find_child(&port->dev, &id, match_free_decoder);
+	if (!dev)
+		return NULL;
+	/*
+	 * This decoder is pinned registered as long as the endpoint decoder is
+	 * registered, and endpoint decoder unregistration holds the
+	 * cxl_region_rwsem over unregister events, so no need to hold on to
+	 * this extra reference.
+	 */
+	put_device(dev);
+	return to_cxl_decoder(dev);
+}
+
+static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
+					       struct cxl_region *cxlr)
+{
+	struct cxl_region_ref *cxl_rr;
+	int rc;
+
+	cxl_rr = kzalloc(sizeof(*cxl_rr), GFP_KERNEL);
+	if (!cxl_rr)
+		return NULL;
+	cxl_rr->port = port;
+	cxl_rr->region = cxlr;
+	xa_init(&cxl_rr->endpoints);
+
+	rc = xa_insert(&port->regions, (unsigned long)cxlr, cxl_rr, GFP_KERNEL);
+	if (rc) {
+		dev_dbg(&cxlr->dev,
+			"%s: failed to track region reference: %d\n",
+			dev_name(&port->dev), rc);
+		kfree(cxl_rr);
+		return NULL;
+	}
+
+	return cxl_rr;
+}
+
+static void free_region_ref(struct cxl_region_ref *cxl_rr)
+{
+	struct cxl_port *port = cxl_rr->port;
+	struct cxl_region *cxlr = cxl_rr->region;
+	struct cxl_decoder *cxld = cxl_rr->decoder;
+
+	dev_WARN_ONCE(&cxlr->dev, cxld->region != cxlr, "region mismatch\n");
+	if (cxld->region == cxlr) {
+		cxld->region = NULL;
+		put_device(&cxlr->dev);
+	}
+
+	xa_erase(&port->regions, (unsigned long)cxlr);
+	xa_destroy(&cxl_rr->endpoints);
+	kfree(cxl_rr);
+}
+
+static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
+			 struct cxl_endpoint_decoder *cxled)
+{
+	int rc;
+	struct cxl_port *port = cxl_rr->port;
+	struct cxl_region *cxlr = cxl_rr->region;
+	struct cxl_decoder *cxld = cxl_rr->decoder;
+	struct cxl_ep *ep = cxl_ep_load(port, cxled_to_memdev(cxled));
+
+	rc = xa_insert(&cxl_rr->endpoints, (unsigned long)cxled, ep,
+			 GFP_KERNEL);
+	if (rc)
+		return rc;
+	cxl_rr->nr_eps++;
+
+	if (!cxld->region) {
+		cxld->region = cxlr;
+		get_device(&cxlr->dev);
+	}
+
+	return 0;
+}
+
+/**
+ * cxl_port_attach_region() - track a region's interest in a port by endpoint
+ * @port: port to add a new region reference 'struct cxl_region_ref'
+ * @cxlr: region to attach to @port
+ * @cxled: endpoint decoder used to create or further pin a region reference
+ * @pos: interleave position of @cxled in @cxlr
+ *
+ * The attach event is an opportunity to validate CXL decode setup
+ * constraints and record metadata needed for programming HDM decoders,
+ * in particular decoder target lists.
+ *
+ * The steps are:
+ * - validate that there are no other regions with a higher HPA already
+ *   associated with @port
+ * - establish a region reference if one is not already present
+ *   - additionally allocate a decoder instance that will host @cxlr on
+ *     @port
+ * - pin the region reference by the endpoint
+ * - account for how many entries in @port's target list are needed to
+ *   cover all of the added endpoints.
  */
+static int cxl_port_attach_region(struct cxl_port *port,
+				  struct cxl_region *cxlr,
+				  struct cxl_endpoint_decoder *cxled, int pos)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_region_ref *cxl_rr = NULL, *iter;
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_decoder *cxld = NULL;
+	unsigned long index;
+	int rc = -EBUSY;
+
+	lockdep_assert_held_write(&cxl_region_rwsem);
+
+	xa_for_each(&port->regions, index, iter) {
+		struct cxl_region_params *ip = &iter->region->params;
+
+		if (iter->region == cxlr)
+			cxl_rr = iter;
+		if (ip->res->start > p->res->start) {
+			dev_dbg(&cxlr->dev,
+				"%s: HPA order violation %s:%pr vs %pr\n",
+				dev_name(&port->dev),
+				dev_name(&iter->region->dev), ip->res, p->res);
+			return -EBUSY;
+		}
+	}
+
+	if (cxl_rr) {
+		struct cxl_ep *ep_iter;
+		int found = 0;
+
+		cxld = cxl_rr->decoder;
+		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
+			if (ep_iter == ep)
+				continue;
+			if (ep_iter->next == ep->next) {
+				found++;
+				break;
+			}
+		}
+
+		/*
+		 * If this is a new target or if this port is direct connected
+		 * to this endpoint then add to the target count.
+		 */
+		if (!found || !ep->next)
+			cxl_rr->nr_targets++;
+	} else {
+		cxl_rr = alloc_region_ref(port, cxlr);
+		if (!cxl_rr) {
+			dev_dbg(&cxlr->dev,
+				"%s: failed to allocate region reference\n",
+				dev_name(&port->dev));
+			return -ENOMEM;
+		}
+	}
+
+	if (!cxld) {
+		if (port == cxled_to_port(cxled))
+			cxld = &cxled->cxld;
+		else
+			cxld = cxl_region_find_decoder(port, cxlr);
+		if (!cxld) {
+			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
+				dev_name(&port->dev));
+			goto out_erase;
+		}
+
+		if (cxld->region) {
+			dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
+				dev_name(&port->dev), dev_name(&cxld->dev),
+				dev_name(&cxld->region->dev));
+			rc = -EBUSY;
+			goto out_erase;
+		}
+
+		cxl_rr->decoder = cxld;
+	}
+
+	rc = cxl_rr_ep_add(cxl_rr, cxled);
+	if (rc) {
+		dev_dbg(&cxlr->dev,
+			"%s: failed to track endpoint %s:%s reference\n",
+			dev_name(&port->dev), dev_name(&cxlmd->dev),
+			dev_name(&cxld->dev));
+		goto out_erase;
+	}
+
+	return 0;
+out_erase:
+	if (cxl_rr->nr_eps == 0)
+		free_region_ref(cxl_rr);
+	return rc;
+}
+
+static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
+					  struct cxl_region *cxlr)
+{
+	return xa_load(&port->regions, (unsigned long)cxlr);
+}
+
+static void cxl_port_detach_region(struct cxl_port *port,
+				   struct cxl_region *cxlr,
+				   struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_region_ref *cxl_rr;
+	struct cxl_ep *ep;
+
+	lockdep_assert_held_write(&cxl_region_rwsem);
+
+	cxl_rr = cxl_rr_load(port, cxlr);
+	if (!cxl_rr)
+		return;
+
+	ep = xa_erase(&cxl_rr->endpoints, (unsigned long)cxled);
+	if (ep) {
+		struct cxl_ep *ep_iter;
+		unsigned long index;
+		int found = 0;
+
+		cxl_rr->nr_eps--;
+		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
+			if (ep_iter->next == ep->next) {
+				found++;
+				break;
+			}
+		}
+		if (!found)
+			cxl_rr->nr_targets--;
+	}
+
+	if (cxl_rr->nr_eps == 0)
+		free_region_ref(cxl_rr);
+}
+
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_port *ep_port, *root_port, *iter;
 	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_dport *dport;
+	int i, rc = -ENXIO;
 
 	if (cxled->mode == CXL_DECODER_DEAD) {
 		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
 		return -ENODEV;
 	}
 
-	if (pos >= p->interleave_ways) {
+	/* all full of members, or interleave config not established? */
+	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_dbg(&cxlr->dev, "region already active\n");
+		return -EBUSY;
+	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
+		dev_dbg(&cxlr->dev, "interleave config missing\n");
+		return -ENXIO;
+	}
+
+	if (pos < 0 || pos >= p->interleave_ways) {
 		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
 			p->interleave_ways);
 		return -ENXIO;
@@ -466,15 +739,90 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EBUSY;
 	}
 
+	for (i = 0; i < p->interleave_ways; i++) {
+		struct cxl_endpoint_decoder *cxled_target;
+		struct cxl_memdev *cxlmd_target;
+
+		cxled_target = p->targets[pos];
+		if (!cxled_target)
+			continue;
+
+		cxlmd_target = cxled_to_memdev(cxled_target);
+		if (cxlmd_target == cxlmd) {
+			dev_dbg(&cxlr->dev,
+				"%s already specified at position %d via: %s\n",
+				dev_name(&cxlmd->dev), pos,
+				dev_name(&cxled_target->cxld.dev));
+			return -EBUSY;
+		}
+	}
+
+	ep_port = cxled_to_port(cxled);
+	root_port = cxlrd_to_port(cxlrd);
+	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
+	if (!dport) {
+		dev_dbg(&cxlr->dev, "%s:%s invalid target for %s\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			dev_name(cxlr->dev.parent));
+		return -ENXIO;
+	}
+
+	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
+		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			dev_name(&cxlrd->cxlsd.cxld.dev));
+		return -ENXIO;
+	}
+
+	if (cxled->cxld.target_type != cxlr->type) {
+		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			cxled->cxld.target_type, cxlr->type);
+		return -ENXIO;
+	}
+
+	if (!cxled->dpa_res) {
+		dev_dbg(&cxlr->dev, "%s:%s: missing DPA allocation.\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev));
+		return -ENXIO;
+	}
+
+	if (resource_size(cxled->dpa_res) * p->interleave_ways !=
+	    resource_size(p->res)) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s: decoder-size-%#llx * ways-%d != region-size-%#llx\n",
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
+			(u64)resource_size(cxled->dpa_res), p->interleave_ways,
+			(u64)resource_size(p->res));
+		return -EINVAL;
+	}
+
+	for (iter = ep_port; !is_cxl_root(iter);
+	     iter = to_cxl_port(iter->dev.parent)) {
+		rc = cxl_port_attach_region(iter, cxlr, cxled, pos);
+		if (rc)
+			goto err;
+	}
+
 	p->targets[pos] = cxled;
 	cxled->pos = pos;
 	p->nr_targets++;
 
+	if (p->nr_targets == p->interleave_ways)
+		p->state = CXL_CONFIG_ACTIVE;
+
 	return 0;
+
+err:
+	for (iter = ep_port; !is_cxl_root(iter);
+	     iter = to_cxl_port(iter->dev.parent))
+		cxl_port_detach_region(iter, cxlr, cxled);
+	return rc;
 }
 
 static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 {
+	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
 	struct cxl_region *cxlr = cxled->cxld.region;
 	struct cxl_region_params *p;
 
@@ -486,6 +834,10 @@ static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 	p = &cxlr->params;
 	get_device(&cxlr->dev);
 
+	for (iter = ep_port; !is_cxl_root(iter);
+	     iter = to_cxl_port(iter->dev.parent))
+		cxl_port_detach_region(iter, cxlr, cxled);
+
 	if (cxled->pos < 0 || cxled->pos >= p->interleave_ways ||
 	    p->targets[cxled->pos] != cxled) {
 		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -496,10 +848,12 @@ static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 		goto out;
 	}
 
+	if (p->state == CXL_CONFIG_ACTIVE)
+		p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
 	p->targets[cxled->pos] = NULL;
 	p->nr_targets--;
 
-	/* notify the region driver that one of its targets has deparated */
+	/* notify the region driver that one of its targets has departed */
 	up_write(&cxl_region_rwsem);
 	device_release_driver(&cxlr->dev);
 	down_write(&cxl_region_rwsem);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cd81e642e900..637768609a75 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -421,6 +421,7 @@ struct cxl_nvdimm {
  * @id: id for port device-name
  * @dports: cxl_dport instances referenced by decoders
  * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
+ * @regions: cxl_region_ref instances, regions mapped by this port
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
@@ -435,6 +436,7 @@ struct cxl_port {
 	int id;
 	struct xarray dports;
 	struct xarray endpoints;
+	struct xarray regions;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	int hdm_end;
@@ -476,6 +478,24 @@ struct cxl_ep {
 	struct cxl_port *next;
 };
 
+/**
+ * struct cxl_region_ref - track a region's interest in a port
+ * @port: point in topology to install this reference
+ * @decoder: decoder assigned for @region in @port
+ * @region: region for this reference
+ * @endpoints: cxl_ep references for region members beneath @port
+ * @nr_eps: number of endpoints beneath @port
+ * @nr_targets: number of distinct targets needed to reach @nr_eps
+ */
+struct cxl_region_ref {
+	struct cxl_port *port;
+	struct cxl_decoder *decoder;
+	struct cxl_region *region;
+	struct xarray endpoints;
+	int nr_eps;
+	int nr_targets;
+};
+
 /*
  * The platform firmware device hosting the root is also the top of the
  * CXL port topology. All other CXL ports have another CXL port as their
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index eee96016c3c7..a83bb6782d23 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -55,6 +55,11 @@ static inline struct cxl_port *cxled_to_port(struct cxl_endpoint_decoder *cxled)
 	return to_cxl_port(cxled->cxld.dev.parent);
 }
 
+static inline struct cxl_port *cxlrd_to_port(struct cxl_root_decoder *cxlrd)
+{
+	return to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
+}
+
 static inline struct cxl_memdev *
 cxled_to_memdev(struct cxl_endpoint_decoder *cxled)
 {

