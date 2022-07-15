Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C973575854
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbiGOACj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240832AbiGOACj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:02:39 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BA070E7B;
        Thu, 14 Jul 2022 17:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843358; x=1689379358;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x6DEwfrNxtFEjZVK3XQKyoDaLt7xeCbDUji9zrzl8Ps=;
  b=I5vUmQY2PNOddbQtaB8oI9Fgb+Wuydpkwh+WEcw/3mMGl0t4tiskBIyF
   Hj7CDYJ58KxTYt4VQSKhf3yMVcmW/jyePRQYXZU+mTsIkmS8Zw4z0qKPK
   ya7lxhVTu+Flm+0b9mZPra/ZwQRdjnIBa82Mz+jxaw1F+ADMhPYJViebb
   pzGN3OKKSOzLF3A/ls2xQ+0VunfZLIodSOh0erJ391CnYfplvT22yrj9d
   MECY5+ASKol+9IVKFLGhfPfeN5ZiK9HYzEI1BIV64irtQLsHEskzGHWS9
   db3tR1zNbHT91PJn9s4x7h/3JnXSBRW7B9+clTRll9DEmNpCz82W4m/fX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="347339387"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="347339387"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="628896816"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:51 -0700
Subject: [PATCH v2 12/28] cxl/port: Move 'cxl_ep' references to an xarray
 per port
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:01:51 -0700
Message-ID: <165784331102.1758207.16035137217204481073.stgit@dwillia2-xfh.jf.intel.com>
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

In preparation for region provisioning that needs to walk the topology
by endpoints, use an xarray to record endpoint interest in a given port.
In addition to being more space and time efficient it also reduces the
complexity of the implementation by moving locking internal to the
xarray implementation. It also allows for a single cxl_ep reference to
be recorded in multiple xarrays.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://lore.kernel.org/r/20220624041950.559155-2-dan.j.williams@intel.com
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c |   60 +++++++++++++++++++++++------------------------
 drivers/cxl/cxl.h       |    4 +--
 2 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6d2846404ab8..727d861e21db 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -431,22 +431,27 @@ static struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
 
 static void cxl_ep_release(struct cxl_ep *ep)
 {
-	if (!ep)
-		return;
-	list_del(&ep->list);
 	put_device(ep->ep);
 	kfree(ep);
 }
 
+static void cxl_ep_remove(struct cxl_port *port, struct cxl_ep *ep)
+{
+	if (!ep)
+		return;
+	xa_erase(&port->endpoints, (unsigned long) ep->ep);
+	cxl_ep_release(ep);
+}
+
 static void cxl_port_release(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
-	struct cxl_ep *ep, *_e;
+	unsigned long index;
+	struct cxl_ep *ep;
 
-	device_lock(dev);
-	list_for_each_entry_safe(ep, _e, &port->endpoints, list)
-		cxl_ep_release(ep);
-	device_unlock(dev);
+	xa_for_each(&port->endpoints, index, ep)
+		cxl_ep_remove(port, ep);
+	xa_destroy(&port->endpoints);
 	ida_free(&cxl_port_ida, port->id);
 	kfree(port);
 }
@@ -577,7 +582,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	ida_init(&port->decoder_ida);
 	port->hdm_end = -1;
 	INIT_LIST_HEAD(&port->dports);
-	INIT_LIST_HEAD(&port->endpoints);
+	xa_init(&port->endpoints);
 
 	device_initialize(dev);
 	lockdep_set_class_and_subclass(&dev->mutex, &cxl_port_key, port->depth);
@@ -873,33 +878,21 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
 
-static struct cxl_ep *find_ep(struct cxl_port *port, struct device *ep_dev)
-{
-	struct cxl_ep *ep;
-
-	device_lock_assert(&port->dev);
-	list_for_each_entry(ep, &port->endpoints, list)
-		if (ep->ep == ep_dev)
-			return ep;
-	return NULL;
-}
-
 static int add_ep(struct cxl_ep *new)
 {
 	struct cxl_port *port = new->dport->port;
-	struct cxl_ep *dup;
+	int rc;
 
 	device_lock(&port->dev);
 	if (port->dead) {
 		device_unlock(&port->dev);
 		return -ENXIO;
 	}
-	dup = find_ep(port, new->ep);
-	if (!dup)
-		list_add_tail(&new->list, &port->endpoints);
+	rc = xa_insert(&port->endpoints, (unsigned long)new->ep, new,
+		       GFP_KERNEL);
 	device_unlock(&port->dev);
 
-	return dup ? -EEXIST : 0;
+	return rc;
 }
 
 /**
@@ -920,7 +913,6 @@ static int cxl_add_ep(struct cxl_dport *dport, struct device *ep_dev)
 	if (!ep)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&ep->list);
 	ep->ep = get_device(ep_dev);
 	ep->dport = dport;
 
@@ -1063,6 +1055,12 @@ static void delete_switch_port(struct cxl_port *port, struct list_head *dports)
 	devm_release_action(port->dev.parent, unregister_port, port);
 }
 
+static struct cxl_ep *cxl_ep_load(struct cxl_port *port,
+				  struct cxl_memdev *cxlmd)
+{
+	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
+}
+
 static void cxl_detach_ep(void *data)
 {
 	struct cxl_memdev *cxlmd = data;
@@ -1101,11 +1099,11 @@ static void cxl_detach_ep(void *data)
 		}
 
 		device_lock(&port->dev);
-		ep = find_ep(port, &cxlmd->dev);
+		ep = cxl_ep_load(port, cxlmd);
 		dev_dbg(&cxlmd->dev, "disconnect %s from %s\n",
 			ep ? dev_name(ep->ep) : "", dev_name(&port->dev));
-		cxl_ep_release(ep);
-		if (ep && !port->dead && list_empty(&port->endpoints) &&
+		cxl_ep_remove(port, ep);
+		if (ep && !port->dead && xa_empty(&port->endpoints) &&
 		    !is_cxl_root(parent_port)) {
 			/*
 			 * This was the last ep attached to a dynamically
@@ -1199,7 +1197,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
 			dev_name(&port->dev), dev_name(port->uport));
 		rc = cxl_add_ep(dport, &cxlmd->dev);
-		if (rc == -EEXIST) {
+		if (rc == -EBUSY) {
 			/*
 			 * "can't" happen, but this error code means
 			 * something to the caller, so translate it.
@@ -1262,7 +1260,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			 * the parent_port lock as the current port may be being
 			 * reaped.
 			 */
-			if (rc && rc != -EEXIST) {
+			if (rc && rc != -EBUSY) {
 				put_device(&port->dev);
 				return rc;
 			}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 973e0efe4bd4..de5cb8288cd4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -345,7 +345,7 @@ struct cxl_port {
 	struct device *host_bridge;
 	int id;
 	struct list_head dports;
-	struct list_head endpoints;
+	struct xarray endpoints;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	int hdm_end;
@@ -374,12 +374,10 @@ struct cxl_dport {
  * struct cxl_ep - track an endpoint's interest in a port
  * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
  * @dport: which dport routes to this endpoint on @port
- * @list: node on port->endpoints list
  */
 struct cxl_ep {
 	struct device *ep;
 	struct cxl_dport *dport;
-	struct list_head list;
 };
 
 /*

