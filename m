Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786BE558F8D
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiFXEUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiFXEUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:20:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7544FC5E;
        Thu, 23 Jun 2022 21:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044410; x=1687580410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1mKsed5a/9jJBg/NphGcCjKLoy55zhUA5ypPBBCq63A=;
  b=h1Hqq2Z8tVQyinnuI+y9Bi/j4qzg/UFkELONP7vXmMvRVAnLAIP6mnBf
   7nBKXMFLyTrUps8pRkTQmK9k5QOgHd+yk7swcmnLWU8NwGze/0xUwI8kI
   lmwxOuKxVjXh1al9d0VLFCW4kweJoctIWtNrplxR5Ev/jNv+0aJsJ84Qz
   +yp4pn1UvHfVk2uxO0CY3Fel7abLwK8WGMiOCQCYpabE6no7t37VMIdXx
   BmVeu1vIwejavyI9GIQDtdCl/b+OzjN5VagnKja4yS4ONo083CjgymM9b
   EmcnVH5ONsx/VnkTvD2inG9FtEbMpi6I4Kx/UHdk1nIa/yK6iB0E7Zf53
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367237997"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367237997"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645092903"
Received: from daharell-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.intel.com) ([10.209.66.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:09 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
        patches@lists.linux.dev, hch@lst.de,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 28/46] cxl/port: Move dport tracking to an xarray
Date:   Thu, 23 Jun 2022 21:19:32 -0700
Message-Id: <20220624041950.559155-3-dan.j.williams@intel.com>
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

Reduce the complexity and the overhead of walking the topology to
determine endpoint connectivity to root decoder interleave
configurations.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      |  2 +-
 drivers/cxl/core/hdm.c  |  6 ++-
 drivers/cxl/core/port.c | 88 ++++++++++++++++++-----------------------
 drivers/cxl/cxl.h       | 12 +++---
 4 files changed, 51 insertions(+), 57 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 09fe92177d03..92ad1f359faf 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -197,7 +197,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	if (!bridge)
 		return 0;
 
-	dport = cxl_find_dport_by_dev(root_port, match);
+	dport = cxl_dport_load(root_port, match);
 	if (!dport) {
 		dev_dbg(host, "host bridge expected and not found\n");
 		return 0;
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c0164f9b2195..672bf3e97811 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -50,8 +50,9 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
 	struct cxl_switch_decoder *cxlsd;
-	struct cxl_dport *dport;
+	struct cxl_dport *dport = NULL;
 	int single_port_map[1];
+	unsigned long index;
 
 	cxlsd = cxl_switch_decoder_alloc(port, 1);
 	if (IS_ERR(cxlsd))
@@ -59,7 +60,8 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 
 	device_lock_assert(&port->dev);
 
-	dport = list_first_entry(&port->dports, typeof(*dport), list);
+	xa_for_each(&port->dports, index, dport)
+		break;
 	single_port_map[0] = dport->port_id;
 
 	return add_hdm_decoder(port, &cxlsd->cxld, single_port_map);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index ea3ab9baf232..d2f6898940fa 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -452,6 +452,7 @@ static void cxl_port_release(struct device *dev)
 	xa_for_each(&port->endpoints, index, ep)
 		cxl_ep_remove(port, ep);
 	xa_destroy(&port->endpoints);
+	xa_destroy(&port->dports);
 	ida_free(&cxl_port_ida, port->id);
 	kfree(port);
 }
@@ -566,7 +567,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->dpa_end = -1;
-	INIT_LIST_HEAD(&port->dports);
+	xa_init(&port->dports);
 	xa_init(&port->endpoints);
 
 	device_initialize(dev);
@@ -696,17 +697,13 @@ static int match_root_child(struct device *dev, const void *match)
 		return 0;
 
 	port = to_cxl_port(dev);
-	device_lock(dev);
-	list_for_each_entry(dport, &port->dports, list) {
-		iter = match;
-		while (iter) {
-			if (iter == dport->dport)
-				goto out;
-			iter = iter->parent;
-		}
+	iter = match;
+	while (iter) {
+		dport = cxl_dport_load(port, iter);
+		if (dport)
+			break;
+		iter = iter->parent;
 	}
-out:
-	device_unlock(dev);
 
 	return !!iter;
 }
@@ -730,9 +727,10 @@ EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
 static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 {
 	struct cxl_dport *dport;
+	unsigned long index;
 
 	device_lock_assert(&port->dev);
-	list_for_each_entry (dport, &port->dports, list)
+	xa_for_each(&port->dports, index, dport)
 		if (dport->port_id == id)
 			return dport;
 	return NULL;
@@ -741,18 +739,21 @@ static struct cxl_dport *find_dport(struct cxl_port *port, int id)
 static int add_dport(struct cxl_port *port, struct cxl_dport *new)
 {
 	struct cxl_dport *dup;
+	int rc;
 
 	device_lock_assert(&port->dev);
 	dup = find_dport(port, new->port_id);
-	if (dup)
+	if (dup) {
 		dev_err(&port->dev,
 			"unable to add dport%d-%s non-unique port id (%s)\n",
 			new->port_id, dev_name(new->dport),
 			dev_name(dup->dport));
-	else
-		list_add_tail(&new->list, &port->dports);
+		rc = -EBUSY;
+	} else
+		rc = xa_insert(&port->dports, (unsigned long)new->dport, new,
+			       GFP_KERNEL);
 
-	return dup ? -EEXIST : 0;
+	return rc;
 }
 
 /*
@@ -779,10 +780,8 @@ static void cxl_dport_remove(void *data)
 	struct cxl_dport *dport = data;
 	struct cxl_port *port = dport->port;
 
+	xa_erase(&port->dports, (unsigned long) dport->dport);
 	put_device(dport->dport);
-	cond_cxl_root_lock(port);
-	list_del(&dport->list);
-	cond_cxl_root_unlock(port);
 }
 
 static void cxl_dport_unlink(void *data)
@@ -834,7 +833,6 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 	if (!dport)
 		return ERR_PTR(-ENOMEM);
 
-	INIT_LIST_HEAD(&dport->list);
 	dport->dport = dport_dev;
 	dport->port_id = port_id;
 	dport->component_reg_phys = component_reg_phys;
@@ -925,7 +923,7 @@ static int match_port_by_dport(struct device *dev, const void *data)
 		return 0;
 
 	port = to_cxl_port(dev);
-	dport = cxl_find_dport_by_dev(port, ctx->dport_dev);
+	dport = cxl_dport_load(port, ctx->dport_dev);
 	if (ctx->dport)
 		*ctx->dport = dport;
 	return dport != NULL;
@@ -1025,19 +1023,27 @@ EXPORT_SYMBOL_NS_GPL(cxl_endpoint_autoremove, CXL);
  * for a port to be unregistered is when all memdevs beneath that port have gone
  * through ->remove(). This "bottom-up" removal selectively removes individual
  * child ports manually. This depends on devm_cxl_add_port() to not change is
- * devm action registration order.
+ * devm action registration order, and for dports to have already been
+ * destroyed by reap_dports().
  */
-static void delete_switch_port(struct cxl_port *port, struct list_head *dports)
+static void delete_switch_port(struct cxl_port *port)
+{
+	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
+	devm_release_action(port->dev.parent, unregister_port, port);
+}
+
+static void reap_dports(struct cxl_port *port)
 {
-	struct cxl_dport *dport, *_d;
+	struct cxl_dport *dport;
+	unsigned long index;
+
+	device_lock_assert(&port->dev);
 
-	list_for_each_entry_safe(dport, _d, dports, list) {
+	xa_for_each(&port->dports, index, dport) {
 		devm_release_action(&port->dev, cxl_dport_unlink, dport);
 		devm_release_action(&port->dev, cxl_dport_remove, dport);
 		devm_kfree(&port->dev, dport);
 	}
-	devm_release_action(port->dev.parent, cxl_unlink_uport, port);
-	devm_release_action(port->dev.parent, unregister_port, port);
 }
 
 static struct cxl_ep *cxl_ep_load(struct cxl_port *port,
@@ -1054,8 +1060,8 @@ static void cxl_detach_ep(void *data)
 	for (iter = &cxlmd->dev; iter; iter = grandparent(iter)) {
 		struct device *dport_dev = grandparent(iter);
 		struct cxl_port *port, *parent_port;
-		LIST_HEAD(reap_dports);
 		struct cxl_ep *ep;
+		bool died = false;
 
 		if (!dport_dev)
 			break;
@@ -1095,15 +1101,16 @@ static void cxl_detach_ep(void *data)
 			 * enumerated port. Block new cxl_add_ep() and garbage
 			 * collect the port.
 			 */
+			died = true;
 			port->dead = true;
-			list_splice_init(&port->dports, &reap_dports);
+			reap_dports(port);
 		}
 		device_unlock(&port->dev);
 
-		if (!list_empty(&reap_dports)) {
+		if (died) {
 			dev_dbg(&cxlmd->dev, "delete %s\n",
 				dev_name(&port->dev));
-			delete_switch_port(port, &reap_dports);
+			delete_switch_port(port);
 		}
 		put_device(&port->dev);
 		device_unlock(&parent_port->dev);
@@ -1282,23 +1289,6 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
 
-struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
-					const struct device *dev)
-{
-	struct cxl_dport *dport;
-
-	device_lock(&port->dev);
-	list_for_each_entry(dport, &port->dports, list)
-		if (dport->dport == dev) {
-			device_unlock(&port->dev);
-			return dport;
-		}
-
-	device_unlock(&port->dev);
-	return NULL;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_find_dport_by_dev, CXL);
-
 static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 				    struct cxl_port *port, int *target_map)
 {
@@ -1309,7 +1299,7 @@ static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 
 	device_lock_assert(&port->dev);
 
-	if (list_empty(&port->dports))
+	if (xa_empty(&port->dports))
 		return -EINVAL;
 
 	write_seqlock(&cxlsd->target_lock);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 3d149780d724..8e2c1b393552 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -336,7 +336,7 @@ struct cxl_port {
 	struct device dev;
 	struct device *uport;
 	int id;
-	struct list_head dports;
+	struct xarray dports;
 	struct xarray endpoints;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
@@ -346,20 +346,24 @@ struct cxl_port {
 	unsigned int depth;
 };
 
+static inline struct cxl_dport *cxl_dport_load(struct cxl_port *port,
+					       const struct device *dport_dev)
+{
+	return xa_load(&port->dports, (unsigned long)dport_dev);
+}
+
 /**
  * struct cxl_dport - CXL downstream port
  * @dport: PCI bridge or firmware device representing the downstream link
  * @port_id: unique hardware identifier for dport in decoder target list
  * @component_reg_phys: downstream port component registers
  * @port: reference to cxl_port that contains this downstream port
- * @list: node for a cxl_port's list of cxl_dport instances
  */
 struct cxl_dport {
 	struct device *dport;
 	int port_id;
 	resource_size_t component_reg_phys;
 	struct cxl_port *port;
-	struct list_head list;
 };
 
 /**
@@ -402,8 +406,6 @@ bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 				     struct device *dport, int port_id,
 				     resource_size_t component_reg_phys);
-struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
-					const struct device *dev);
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
-- 
2.36.1

