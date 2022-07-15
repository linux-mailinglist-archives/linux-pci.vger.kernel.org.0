Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675A7575849
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbiGOABx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbiGOABw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:01:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFC427CFF;
        Thu, 14 Jul 2022 17:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843311; x=1689379311;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bxzdzJ6W/nVe6j8R5tao1r1yoeBQICSH9UM4Ttac/L0=;
  b=CxTcBq1VwoDfsYQtcOcnM6c8mNTjlV1ZxcQLt+1sWZTgKEot0Yyad8aA
   rtDH6L8VdkrYVS/tZYO0BnDcyWSrXxmGXPEhc1kWd0IW6Q6fRuNHMcmUy
   R3BUJ3o+NDZRP6nabGimL2RWN4H8BJFN8jKD3+hg9ocyyVvByg1rFDJwf
   AiCdQ9GnrqM3BlG+jpdAQSDs3Lf1NYFcs19btz4ry4wxKQte54xM1pzXZ
   WEI4XcWLo9VdvLcJnXIheOgvdmVJvaoiaA5PpjKB54WJYE10mN5RddFPA
   vyi5r6dYj68kRevaqO/YSQbppuCNpapoTIlLiDSohQppt1JlnCiS+Amet
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="268687025"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="268687025"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="654092715"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:39 -0700
Subject: [PATCH v2 10/28] cxl/port: Record dport in endpoint references
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     hch@lst.de, nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:01:39 -0700
Message-ID: <165784329944.1758207.15203961796832072116.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recall that the primary role of the cxl_mem driver is to probe if the
given endpoint is connected to a CXL port topology. In that process it
walks its device ancestry to its PCI root port. If that root port is
also a CXL root port then the probe process adds cxl_port object
instances at switch in the path between to the root and the endpoint. As
those cxl_port instances are added, or if a previous enumeration
attempt already created the port, a 'struct cxl_ep' instance is
registered with that port to track the endpoints interested in that
port.

At the time the cxl_ep is registered the downstream egress path from the
port to the endpoint is known. Take the opportunity to record that
information as it will be needed for dynamic programming of decoder
targets during region provisioning.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |   52 ++++++++++++++++++++++++++++++++---------------
 drivers/cxl/cxl.h       |    2 ++
 2 files changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fdc1be7db917..a8d350361548 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -882,8 +882,9 @@ static struct cxl_ep *find_ep(struct cxl_port *port, struct device *ep_dev)
 	return NULL;
 }
 
-static int add_ep(struct cxl_port *port, struct cxl_ep *new)
+static int add_ep(struct cxl_ep *new)
 {
+	struct cxl_port *port = new->dport->port;
 	struct cxl_ep *dup;
 
 	device_lock(&port->dev);
@@ -901,14 +902,14 @@ static int add_ep(struct cxl_port *port, struct cxl_ep *new)
 
 /**
  * cxl_add_ep - register an endpoint's interest in a port
- * @port: a port in the endpoint's topology ancestry
+ * @dport: the dport that routes to @ep_dev
  * @ep_dev: device representing the endpoint
  *
  * Intermediate CXL ports are scanned based on the arrival of endpoints.
  * When those endpoints depart the port can be destroyed once all
  * endpoints that care about that port have been removed.
  */
-static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
+static int cxl_add_ep(struct cxl_dport *dport, struct device *ep_dev)
 {
 	struct cxl_ep *ep;
 	int rc;
@@ -919,8 +920,9 @@ static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
 
 	INIT_LIST_HEAD(&ep->list);
 	ep->ep = get_device(ep_dev);
+	ep->dport = dport;
 
-	rc = add_ep(port, ep);
+	rc = add_ep(ep);
 	if (rc)
 		cxl_ep_release(ep);
 	return rc;
@@ -929,11 +931,13 @@ static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
 struct cxl_find_port_ctx {
 	const struct device *dport_dev;
 	const struct cxl_port *parent_port;
+	struct cxl_dport **dport;
 };
 
 static int match_port_by_dport(struct device *dev, const void *data)
 {
 	const struct cxl_find_port_ctx *ctx = data;
+	struct cxl_dport *dport;
 	struct cxl_port *port;
 
 	if (!is_cxl_port(dev))
@@ -942,7 +946,10 @@ static int match_port_by_dport(struct device *dev, const void *data)
 		return 0;
 
 	port = to_cxl_port(dev);
-	return cxl_find_dport_by_dev(port, ctx->dport_dev) != NULL;
+	dport = cxl_find_dport_by_dev(port, ctx->dport_dev);
+	if (ctx->dport)
+		*ctx->dport = dport;
+	return dport != NULL;
 }
 
 static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
@@ -958,24 +965,32 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
 	return NULL;
 }
 
-static struct cxl_port *find_cxl_port(struct device *dport_dev)
+static struct cxl_port *find_cxl_port(struct device *dport_dev,
+				      struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
+		.dport = dport,
 	};
+	struct cxl_port *port;
 
-	return __find_cxl_port(&ctx);
+	port = __find_cxl_port(&ctx);
+	return port;
 }
 
 static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
-					 struct device *dport_dev)
+					 struct device *dport_dev,
+					 struct cxl_dport **dport)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
 		.parent_port = parent_port,
+		.dport = dport,
 	};
+	struct cxl_port *port;
 
-	return __find_cxl_port(&ctx);
+	port = __find_cxl_port(&ctx);
+	return port;
 }
 
 /*
@@ -1060,7 +1075,7 @@ static void cxl_detach_ep(void *data)
 		if (!dport_dev)
 			break;
 
-		port = find_cxl_port(dport_dev);
+		port = find_cxl_port(dport_dev, NULL);
 		if (!port)
 			continue;
 
@@ -1135,6 +1150,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	struct device *dparent = grandparent(dport_dev);
 	struct cxl_port *port, *parent_port = NULL;
 	resource_size_t component_reg_phys;
+	struct cxl_dport *dport;
 	int rc;
 
 	if (!dparent) {
@@ -1148,7 +1164,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		return -ENXIO;
 	}
 
-	parent_port = find_cxl_port(dparent);
+	parent_port = find_cxl_port(dparent, NULL);
 	if (!parent_port) {
 		/* iterate to create this parent_port */
 		return -EAGAIN;
@@ -1163,13 +1179,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		goto out;
 	}
 
-	port = find_cxl_port_at(parent_port, dport_dev);
+	port = find_cxl_port_at(parent_port, dport_dev, &dport);
 	if (!port) {
 		component_reg_phys = find_component_registers(uport_dev);
 		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
 					 component_reg_phys, parent_port);
+		/* retry find to pick up the new dport information */
 		if (!IS_ERR(port))
-			get_device(&port->dev);
+			port = find_cxl_port_at(parent_port, dport_dev, &dport);
 	}
 out:
 	device_unlock(&parent_port->dev);
@@ -1179,7 +1196,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 	else {
 		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
 			dev_name(&port->dev), dev_name(port->uport));
-		rc = cxl_add_ep(port, &cxlmd->dev);
+		rc = cxl_add_ep(dport, &cxlmd->dev);
 		if (rc == -EEXIST) {
 			/*
 			 * "can't" happen, but this error code means
@@ -1213,6 +1230,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 	for (iter = dev; iter; iter = grandparent(iter)) {
 		struct device *dport_dev = grandparent(iter);
 		struct device *uport_dev;
+		struct cxl_dport *dport;
 		struct cxl_port *port;
 
 		if (!dport_dev)
@@ -1228,12 +1246,12 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
 			dev_name(iter), dev_name(dport_dev),
 			dev_name(uport_dev));
-		port = find_cxl_port(dport_dev);
+		port = find_cxl_port(dport_dev, &dport);
 		if (port) {
 			dev_dbg(&cxlmd->dev,
 				"found already registered port %s:%s\n",
 				dev_name(&port->dev), dev_name(port->uport));
-			rc = cxl_add_ep(port, &cxlmd->dev);
+			rc = cxl_add_ep(dport, &cxlmd->dev);
 
 			/*
 			 * If the endpoint already exists in the port's list,
@@ -1274,7 +1292,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
 
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd)
 {
-	return find_cxl_port(grandparent(&cxlmd->dev));
+	return find_cxl_port(grandparent(&cxlmd->dev), NULL);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 70cd24e4f3ce..31f33844279a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -371,10 +371,12 @@ struct cxl_dport {
 /**
  * struct cxl_ep - track an endpoint's interest in a port
  * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
+ * @dport: which dport routes to this endpoint on @port
  * @list: node on port->endpoints list
  */
 struct cxl_ep {
 	struct device *ep;
+	struct cxl_dport *dport;
 	struct list_head list;
 };
 

