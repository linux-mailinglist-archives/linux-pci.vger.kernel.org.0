Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0955C575879
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241053AbiGOAFL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241093AbiGOAFJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:05:09 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18E5735B2;
        Thu, 14 Jul 2022 17:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843508; x=1689379508;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9b5PpGGK2UxDyTUnFeAvPu4Z8fwgVuv06qsL9vaoOeg=;
  b=fiM4wdfZEEWqxlZVGijkb6o2//RvEQMQ/UCVR28quv1DfE+5ZnNAs1ov
   TZuBiopzaSb0bGnEJxMDVxQfd6JKosPUuM/8H7D6qkOrJPKFbfSemHMe7
   VaDq+op01oiQf7JwE0BiyWsvi27wN+U3tUfBQO1ii6ScdQYT8PZdK2is1
   72GCEZgSwL9y2Nb1ck80JAM3rpfgqNsyINOSdg8ptXZnCqEsNtXmMYG7V
   2vvI7hNZ6ol2/4UXh7zuTqFoV9od9AMpv4vreEaivDGqAqkOFnSCNrtfp
   N+ImQrKqpy27+U+mkPxNmPhBrz90OFhjK4/sk2HM/Ktfown8puG/hGNT8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="283220810"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="283220810"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="600310911"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:02:58 -0700
Subject: [PATCH v2 24/28] cxl/region: Program target lists
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     hch@lst.de, nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:02:58 -0700
Message-ID: <165784337827.1758207.132121746122685208.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Once the region's interleave geometry (ways, granularity, size) is
established and all the endpoint decoder targets are assigned, the next
phase is to program all the intermediate decoders. Specifically, each
CXL switch in the path between the endpoint and its CXL host-bridge
(including the logical switch internal to the host-bridge) needs to have
its decoders programmed and the target list order assigned.

The difficulty in this implementation lies in determining which endpoint
decoder ordering combinations are valid. Consider the cxl_test case of 2
host bridges, each of those host-bridges attached to 2 switches, and
each of those switches attached to 2 endpoints for a potential 8-way
interleave. The x2 interleave at the host-bridge level requires that all
even numbered endpoint decoder positions be located on the "left" hand
side of the topology tree, and the odd numbered positions on the other.
The endpoints that are peers on the same switch need to have a position
that can be routed with a dedicated address bit per-endpoint. See
check_last_peer() for the details.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h   |    4 +
 drivers/cxl/core/port.c   |    4 -
 drivers/cxl/core/region.c |  262 +++++++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/cxl.h         |    2 
 4 files changed, 260 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 6edd8174c2b5..fcf14b8a3c87 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -42,9 +42,13 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled);
 extern struct rw_semaphore cxl_dpa_rwsem;
 
 bool is_switch_decoder(struct device *dev);
+struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 					 struct cxl_memdev *cxlmd)
 {
+	if (!port)
+		return NULL;
+
 	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
 }
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index d234afc47e89..215ce5e16986 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -146,8 +146,6 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
 	return offset;
 }
 
-static struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
-
 static ssize_t target_list_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -472,7 +470,7 @@ struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_endpoint_decoder, CXL);
 
-static struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
+struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, !is_switch_decoder(dev),
 			  "not a cxl_switch_decoder device\n"))
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8ac0c557f6aa..225340529fc3 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -485,6 +485,7 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
 		return NULL;
 	cxl_rr->port = port;
 	cxl_rr->region = cxlr;
+	cxl_rr->nr_targets = 1;
 	xa_init(&cxl_rr->endpoints);
 
 	rc = xa_insert(&port->regions, (unsigned long)cxlr, cxl_rr, GFP_KERNEL);
@@ -525,10 +526,12 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
 	struct cxl_decoder *cxld = cxl_rr->decoder;
 	struct cxl_ep *ep = cxl_ep_load(port, cxled_to_memdev(cxled));
 
-	rc = xa_insert(&cxl_rr->endpoints, (unsigned long)cxled, ep,
-			 GFP_KERNEL);
-	if (rc)
-		return rc;
+	if (ep) {
+		rc = xa_insert(&cxl_rr->endpoints, (unsigned long)cxled, ep,
+			       GFP_KERNEL);
+		if (rc)
+			return rc;
+	}
 	cxl_rr->nr_eps++;
 
 	if (!cxld->region) {
@@ -565,7 +568,7 @@ static int cxl_port_attach_region(struct cxl_port *port,
 				  struct cxl_endpoint_decoder *cxled, int pos)
 {
 	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
-	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	const struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
 	struct cxl_region_ref *cxl_rr = NULL, *iter;
 	struct cxl_region_params *p = &cxlr->params;
 	struct cxl_decoder *cxld = NULL;
@@ -649,6 +652,16 @@ static int cxl_port_attach_region(struct cxl_port *port,
 		goto out_erase;
 	}
 
+	dev_dbg(&cxlr->dev,
+		"%s:%s %s add: %s:%s @ %d next: %s nr_eps: %d nr_targets: %d\n",
+		dev_name(port->uport), dev_name(&port->dev),
+		dev_name(&cxld->dev), dev_name(&cxlmd->dev),
+		dev_name(&cxled->cxld.dev), pos,
+		ep ? ep->next ? dev_name(ep->next->uport) :
+				      dev_name(&cxlmd->dev) :
+			   "none",
+		cxl_rr->nr_eps, cxl_rr->nr_targets);
+
 	return 0;
 out_erase:
 	if (cxl_rr->nr_eps == 0)
@@ -667,7 +680,7 @@ static void cxl_port_detach_region(struct cxl_port *port,
 				   struct cxl_endpoint_decoder *cxled)
 {
 	struct cxl_region_ref *cxl_rr;
-	struct cxl_ep *ep;
+	struct cxl_ep *ep = NULL;
 
 	lockdep_assert_held_write(&cxl_region_rwsem);
 
@@ -675,7 +688,14 @@ static void cxl_port_detach_region(struct cxl_port *port,
 	if (!cxl_rr)
 		return;
 
-	ep = xa_erase(&cxl_rr->endpoints, (unsigned long)cxled);
+	/*
+	 * Endpoint ports do not carry cxl_ep references, and they
+	 * never target more than one endpoint by definition
+	 */
+	if (cxl_rr->decoder == &cxled->cxld)
+		cxl_rr->nr_eps--;
+	else
+		ep = xa_erase(&cxl_rr->endpoints, (unsigned long)cxled);
 	if (ep) {
 		struct cxl_ep *ep_iter;
 		unsigned long index;
@@ -696,6 +716,224 @@ static void cxl_port_detach_region(struct cxl_port *port,
 		free_region_ref(cxl_rr);
 }
 
+static int check_last_peer(struct cxl_endpoint_decoder *cxled,
+			   struct cxl_ep *ep, struct cxl_region_ref *cxl_rr,
+			   int distance)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_region *cxlr = cxl_rr->region;
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled_peer;
+	struct cxl_port *port = cxl_rr->port;
+	struct cxl_memdev *cxlmd_peer;
+	struct cxl_ep *ep_peer;
+	int pos = cxled->pos;
+
+	/*
+	 * If this position wants to share a dport with the last endpoint mapped
+	 * then that endpoint, at index 'position - distance', must also be
+	 * mapped by this dport.
+	 */
+	if (pos < distance) {
+		dev_dbg(&cxlr->dev, "%s:%s: cannot host %s:%s at %d\n",
+			dev_name(port->uport), dev_name(&port->dev),
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
+		return -ENXIO;
+	}
+	cxled_peer = p->targets[pos - distance];
+	cxlmd_peer = cxled_to_memdev(cxled_peer);
+	ep_peer = cxl_ep_load(port, cxlmd_peer);
+	if (ep->dport != ep_peer->dport) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s: %s:%s pos %d mismatched peer %s:%s\n",
+			dev_name(port->uport), dev_name(&port->dev),
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos,
+			dev_name(&cxlmd_peer->dev),
+			dev_name(&cxled_peer->cxld.dev));
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int cxl_port_setup_targets(struct cxl_port *port,
+				  struct cxl_region *cxlr,
+				  struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
+	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
+	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
+	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_decoder *cxld = cxl_rr->decoder;
+	struct cxl_switch_decoder *cxlsd;
+	u16 eig, peig;
+	u8 eiw, peiw;
+
+	/*
+	 * While root level decoders support x3, x6, x12, switch level
+	 * decoders only support powers of 2 up to x16.
+	 */
+	if (!is_power_of_2(cxl_rr->nr_targets)) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
+			dev_name(port->uport), dev_name(&port->dev),
+			cxl_rr->nr_targets);
+		return -EINVAL;
+	}
+
+	cxlsd = to_cxl_switch_decoder(&cxld->dev);
+	if (cxl_rr->nr_targets_set) {
+		int i, distance;
+
+		distance = p->nr_targets / cxl_rr->nr_targets;
+		for (i = 0; i < cxl_rr->nr_targets_set; i++)
+			if (ep->dport == cxlsd->target[i]) {
+				rc = check_last_peer(cxled, ep, cxl_rr,
+						     distance);
+				if (rc)
+					return rc;
+				goto out_target_set;
+			}
+		goto add_target;
+	}
+
+	if (is_cxl_root(parent_port)) {
+		parent_ig = cxlrd->cxlsd.cxld.interleave_granularity;
+		parent_iw = cxlrd->cxlsd.cxld.interleave_ways;
+		/*
+		 * For purposes of address bit routing, use power-of-2 math for
+		 * switch ports.
+		 */
+		if (!is_power_of_2(parent_iw))
+			parent_iw /= 3;
+	} else {
+		struct cxl_region_ref *parent_rr;
+		struct cxl_decoder *parent_cxld;
+
+		parent_rr = cxl_rr_load(parent_port, cxlr);
+		parent_cxld = parent_rr->decoder;
+		parent_ig = parent_cxld->interleave_granularity;
+		parent_iw = parent_cxld->interleave_ways;
+	}
+
+	granularity_to_cxl(parent_ig, &peig);
+	ways_to_cxl(parent_iw, &peiw);
+
+	iw = cxl_rr->nr_targets;
+	ways_to_cxl(iw, &eiw);
+	if (cxl_rr->nr_targets > 1) {
+		u32 address_bit = max(peig + peiw, eiw + peig);
+
+		eig = address_bit - eiw + 1;
+	} else {
+		eiw = peiw;
+		eig = peig;
+	}
+
+	rc = cxl_to_granularity(eig, &ig);
+	if (rc) {
+		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
+			dev_name(port->uport), dev_name(&port->dev),
+			256 << eig);
+		return rc;
+	}
+
+	cxld->interleave_ways = iw;
+	cxld->interleave_granularity = ig;
+	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport),
+		dev_name(&port->dev), iw, ig);
+add_target:
+	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
+		dev_dbg(&cxlr->dev,
+			"%s:%s: targets full trying to add %s:%s at %d\n",
+			dev_name(port->uport), dev_name(&port->dev),
+			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
+		return -ENXIO;
+	}
+	cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
+	inc = 1;
+out_target_set:
+	cxl_rr->nr_targets_set += inc;
+	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
+		dev_name(port->uport), dev_name(&port->dev),
+		cxl_rr->nr_targets_set - 1, dev_name(ep->dport->dport),
+		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
+
+	return 0;
+}
+
+static void cxl_port_reset_targets(struct cxl_port *port,
+				   struct cxl_region *cxlr)
+{
+	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
+
+	/*
+	 * After the last endpoint has been detached the entire cxl_rr may now
+	 * be gone.
+	 */
+	if (cxl_rr)
+		cxl_rr->nr_targets_set = 0;
+}
+
+static void cxl_region_teardown_targets(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
+	struct cxl_port *iter;
+	struct cxl_ep *ep;
+	int i;
+
+	for (i = 0; i < p->nr_targets; i++) {
+		cxled = p->targets[i];
+		cxlmd = cxled_to_memdev(cxled);
+
+		iter = cxled_to_port(cxled);
+		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
+			iter = to_cxl_port(iter->dev.parent);
+
+		for (ep = cxl_ep_load(iter, cxlmd); iter;
+		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd))
+			cxl_port_reset_targets(iter, cxlr);
+	}
+}
+
+static int cxl_region_setup_targets(struct cxl_region *cxlr)
+{
+	struct cxl_region_params *p = &cxlr->params;
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_memdev *cxlmd;
+	struct cxl_port *iter;
+	struct cxl_ep *ep;
+	int i, rc;
+
+	for (i = 0; i < p->nr_targets; i++) {
+		cxled = p->targets[i];
+		cxlmd = cxled_to_memdev(cxled);
+
+		iter = cxled_to_port(cxled);
+		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
+			iter = to_cxl_port(iter->dev.parent);
+
+		/*
+		 * Descend the topology tree programming targets while
+		 * looking for conflicts.
+		 */
+		for (ep = cxl_ep_load(iter, cxlmd); iter;
+		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
+			rc = cxl_port_setup_targets(iter, cxlr, cxled);
+			if (rc) {
+				cxl_region_teardown_targets(cxlr);
+				return rc;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int cxl_region_attach(struct cxl_region *cxlr,
 			     struct cxl_endpoint_decoder *cxled, int pos)
 {
@@ -808,8 +1046,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	cxled->pos = pos;
 	p->nr_targets++;
 
-	if (p->nr_targets == p->interleave_ways)
+	if (p->nr_targets == p->interleave_ways) {
+		rc = cxl_region_setup_targets(cxlr);
+		if (rc)
+			goto err;
 		p->state = CXL_CONFIG_ACTIVE;
+	}
 
 	return 0;
 
@@ -848,8 +1090,10 @@ static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
 		goto out;
 	}
 
-	if (p->state == CXL_CONFIG_ACTIVE)
+	if (p->state == CXL_CONFIG_ACTIVE) {
 		p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
+		cxl_region_teardown_targets(cxlr);
+	}
 	p->targets[cxled->pos] = NULL;
 	p->nr_targets--;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 637768609a75..70862141209b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -484,6 +484,7 @@ struct cxl_ep {
  * @decoder: decoder assigned for @region in @port
  * @region: region for this reference
  * @endpoints: cxl_ep references for region members beneath @port
+ * @nr_targets_set: track how many targets have been programmed during setup
  * @nr_eps: number of endpoints beneath @port
  * @nr_targets: number of distinct targets needed to reach @nr_eps
  */
@@ -492,6 +493,7 @@ struct cxl_region_ref {
 	struct cxl_decoder *decoder;
 	struct cxl_region *region;
 	struct xarray endpoints;
+	int nr_targets_set;
 	int nr_eps;
 	int nr_targets;
 };

