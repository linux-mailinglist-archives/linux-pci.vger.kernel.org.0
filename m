Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4D7A558F8E
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbiFXEUM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiFXEUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:20:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6623049CBE;
        Thu, 23 Jun 2022 21:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044410; x=1687580410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d8ij3u11o75oSSOGptJFkUuJ7uZDU0gk5H3Gjw/F+sU=;
  b=S+28G0gGgiH+kNGDGC+2Ul6+KHX5MWTa6QG18Ka1V2+GSyfZTjoTmdqd
   lDzYPkwYQAlXKXdeXnIrnPxAWosmLkRc2+LIPCyYbQLy4Tiw/qQkass7a
   QdBAqtIrFyANfAib1/3veo8yzkk+qDpD1UuZVrH8LBdBuu92dHaYLeQX8
   iNyFknC/zsCXUFQmyD4HXhdYVtgh3mEzI+/y7iFXu5SVhxlH234wdQcS2
   JCZegJAsaw38LwoLSUaUEVd+wgCqApwg3qUTHQsKbuM4ZS6y0Whco7YCN
   CMyBNFXoV8bxwcY2XiyTVYwinPe9qhFZYKP3grVboI/cmGCxK9gYTQNPg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367237996"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367237996"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:09 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645092899"
Received: from daharell-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.intel.com) ([10.209.66.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:09 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
        patches@lists.linux.dev, hch@lst.de,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 27/46] cxl/port: Move 'cxl_ep' references to an xarray per port
Date:   Thu, 23 Jun 2022 21:19:31 -0700
Message-Id: <20220624041950.559155-2-dan.j.williams@intel.com>
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

In preparation for region provisioning that needs to walk the topology
by endpoints, use an xarray to record endpoint interest in a given port.
In addition to being more space and time efficient it also reduces the
complexity of the implementation by moving locking internal to the
xarray implementation. It also allows for a single cxl_ep reference to
be recorded in multiple xarrays.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/port.c | 60 ++++++++++++++++++++---------------------
 drivers/cxl/cxl.h       |  4 +--
 2 files changed, 30 insertions(+), 34 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 8f53f59dd0fa..ea3ab9baf232 100644
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
@@ -562,7 +567,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	ida_init(&port->decoder_ida);
 	port->dpa_end = -1;
 	INIT_LIST_HEAD(&port->dports);
-	INIT_LIST_HEAD(&port->endpoints);
+	xa_init(&port->endpoints);
 
 	device_initialize(dev);
 	lockdep_set_class_and_subclass(&dev->mutex, &cxl_port_key, port->depth);
@@ -858,33 +863,21 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
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
@@ -905,7 +898,6 @@ static int cxl_add_ep(struct cxl_dport *dport, struct device *ep_dev)
 	if (!ep)
 		return -ENOMEM;
 
-	INIT_LIST_HEAD(&ep->list);
 	ep->ep = get_device(ep_dev);
 	ep->dport = dport;
 
@@ -1048,6 +1040,12 @@ static void delete_switch_port(struct cxl_port *port, struct list_head *dports)
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
@@ -1086,11 +1084,11 @@ static void cxl_detach_ep(void *data)
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
@@ -1184,7 +1182,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
 		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
 			dev_name(&port->dev), dev_name(port->uport));
 		rc = cxl_add_ep(dport, &cxlmd->dev);
-		if (rc == -EEXIST) {
+		if (rc == -EBUSY) {
 			/*
 			 * "can't" happen, but this error code means
 			 * something to the caller, so translate it.
@@ -1247,7 +1245,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 			 * the parent_port lock as the current port may be being
 			 * reaped.
 			 */
-			if (rc && rc != -EEXIST) {
+			if (rc && rc != -EBUSY) {
 				put_device(&port->dev);
 				return rc;
 			}
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 55d34b1576f1..3d149780d724 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -337,7 +337,7 @@ struct cxl_port {
 	struct device *uport;
 	int id;
 	struct list_head dports;
-	struct list_head endpoints;
+	struct xarray endpoints;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
 	int dpa_end;
@@ -366,12 +366,10 @@ struct cxl_dport {
  * struct cxl_ep - track an endpoint's interest in a port
  * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
  * @dport: which dport routes to this endpoint on this port
- * @list: node on port->endpoints list
  */
 struct cxl_ep {
 	struct device *ep;
 	struct cxl_dport *dport;
-	struct list_head list;
 };
 
 /*
-- 
2.36.1

