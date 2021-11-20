Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD9F4579F2
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbhKTAGW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:22 -0500
Received: from mga12.intel.com ([192.55.52.136]:5726 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236285AbhKTAGM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:12 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542410"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542410"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:58 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088382"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:58 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 13/23] cxl/core: Move target population locking to caller
Date:   Fri, 19 Nov 2021 16:02:40 -0800
Message-Id: <20211120000250.1663391-14-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for a port driver that enumerates a descendant port +
decoder hierarchy, arrange for an unlocked version of cxl_decoder_add().
Otherwise a port-driver that adds a child decoder will deadlock on the
device_lock() in ->probe().

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---

Changes since RFCv2:
- Reword commit message (Dan)
- Move decoder API changes into this patch (Dan)
---
 drivers/cxl/core/bus.c | 59 +++++++++++++++++++++++++++++++-----------
 drivers/cxl/cxl.h      |  1 +
 2 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index 16b15f54fb62..cd6fe7823c69 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -487,28 +487,22 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 {
 	int rc = 0, i;
 
+	device_lock_assert(&port->dev);
+
 	if (!target_map)
 		return 0;
 
-	device_lock(&port->dev);
-	if (list_empty(&port->dports)) {
-		rc = -EINVAL;
-		goto out_unlock;
-	}
+	if (list_empty(&port->dports))
+		return -EINVAL;
 
 	for (i = 0; i < cxld->nr_targets; i++) {
 		struct cxl_dport *dport = find_dport(port, target_map[i]);
 
-		if (!dport) {
-			rc = -ENXIO;
-			goto out_unlock;
-		}
+		if (!dport)
+			return -ENXIO;
 		cxld->target[i] = dport;
 	}
 
-out_unlock:
-	device_unlock(&port->dev);
-
 	return rc;
 }
 
@@ -571,7 +565,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
 
 /**
- * cxl_decoder_add - Add a decoder with targets
+ * cxl_decoder_add_locked - Add a decoder with targets
  * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
  * @target_map: A list of downstream ports that this decoder can direct memory
  *              traffic to. These numbers should correspond with the port number
@@ -581,12 +575,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
  * is an endpoint device. A more awkward example is a hostbridge whose root
  * ports get hot added (technically possible, though unlikely).
  *
- * Context: Process context. Takes and releases the cxld's device lock.
+ * This is the locked variant of cxl_decoder_add().
+ *
+ * Context: Process context. Expects the cxld's device lock to be held.
  *
  * Return: Negative error code if the decoder wasn't properly configured; else
  *	   returns 0.
  */
-int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
+int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
 {
 	struct cxl_port *port;
 	struct device *dev;
@@ -619,6 +615,39 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 
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
+ * Context: Process context. Takes and releases the cxld's device lock.
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
+	device_lock(&port->dev);
+	rc = cxl_decoder_add_locked(cxld, target_map);
+	device_unlock(&port->dev);
+
+	return rc;
+}
 EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
 
 static void cxld_unregister(void *dev)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b66ed8f241c6..2c5627fa8a34 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -290,6 +290,7 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 				      unsigned int nr_targets);
+int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 
-- 
2.34.0

