Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E93057583E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiGOAA5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbiGOAA4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:00:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97A727FF3;
        Thu, 14 Jul 2022 17:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843254; x=1689379254;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dtdJFh7kmK+xJYbCR5yQu8ImFrxaMhVVXsLFYvEJhPc=;
  b=PVjrtkjYQRwuqhgP3zm+BDEVjSIE/dR+XqL5vG0o1vlsT+q4PYpoWTNH
   jQJ+7FCJRH09ADr5MnKNkFb1kqchrQV8LTSh0bgBT8GaaND1XGunHclGy
   rqeg3EphngrspjM3YQoZmpW5Sl7cOLbtesuZWOSskHyoRD8flbiIRjeUF
   aZk/HwlnIBhweKLUXZTURVXkDDGVO0DLWjScG4Ah/r81Cc3C8Gr8WwIHQ
   i4KILTSR247myYsPXnvklfk+Vdc3JD5PZ8LiXkY0eWiMzlYXoOltlX8fE
   41KkUHKYq+mhY2LQKYV/uuw4nIF5L54DR/O29G0X78LGaEk8s5FvuEnzv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="284417226"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="284417226"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:00:54 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="600309476"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:00:53 -0700
Subject: [PATCH v2 02/28] cxl/core: Define a 'struct cxl_switch_decoder'
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <bwidawsk@kernel.org>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:00:53 -0700
Message-ID: <165784325340.1758207.5064717153608954960.stgit@dwillia2-xfh.jf.intel.com>
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

Currently 'struct cxl_decoder' contains the superset of attributes
needed for all decoder types. Before more type-specific attributes are
added to the common definition, reorganize 'struct cxl_decoder' into type
specific objects.

This patch, the first of three, factors out a cxl_switch_decoder type.
See the new kdoc for what a 'struct cxl_switch_decoder' represents in a
CXL topology.

Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c           |    4 +
 drivers/cxl/core/hdm.c       |   33 +++++--
 drivers/cxl/core/port.c      |  188 ++++++++++++++++++++++++++++--------------
 drivers/cxl/cxl.h            |   30 +++++--
 tools/testing/cxl/test/cxl.c |   23 ++++-
 5 files changed, 189 insertions(+), 89 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 541fc0b28b8f..62bf22ffb7aa 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -81,6 +81,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	int target_map[CXL_DECODER_MAX_INTERLEAVE];
 	struct cxl_cfmws_context *ctx = arg;
 	struct cxl_port *root_port = ctx->root_port;
+	struct cxl_switch_decoder *cxlsd;
 	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
 	struct cxl_decoder *cxld;
@@ -106,10 +107,11 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	for (i = 0; i < ways; i++)
 		target_map[i] = cfmws->interleave_targets[i];
 
-	cxld = cxl_root_decoder_alloc(root_port, ways);
+	cxlsd = cxl_root_decoder_alloc(root_port, ways);
 	if (IS_ERR(cxld))
 		return 0;
 
+	cxld = &cxlsd->cxld;
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->hpa_range = (struct range) {
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c524e772fdae..2f10d42798de 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -49,20 +49,20 @@ static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
  */
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 {
-	struct cxl_decoder *cxld;
+	struct cxl_switch_decoder *cxlsd;
 	struct cxl_dport *dport;
 	int single_port_map[1];
 
-	cxld = cxl_switch_decoder_alloc(port, 1);
-	if (IS_ERR(cxld))
-		return PTR_ERR(cxld);
+	cxlsd = cxl_switch_decoder_alloc(port, 1);
+	if (IS_ERR(cxlsd))
+		return PTR_ERR(cxlsd);
 
 	device_lock_assert(&port->dev);
 
 	dport = list_first_entry(&port->dports, typeof(*dport), list);
 	single_port_map[0] = dport->port_id;
 
-	return add_hdm_decoder(port, cxld, single_port_map);
+	return add_hdm_decoder(port, &cxlsd->cxld, single_port_map);
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
 
@@ -255,14 +255,23 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 		int rc, target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
-		if (is_cxl_endpoint(port))
+		if (is_cxl_endpoint(port)) {
 			cxld = cxl_endpoint_decoder_alloc(port);
-		else
-			cxld = cxl_switch_decoder_alloc(port, target_count);
-		if (IS_ERR(cxld)) {
-			dev_warn(&port->dev,
-				 "Failed to allocate the decoder\n");
-			return PTR_ERR(cxld);
+			if (IS_ERR(cxld)) {
+				dev_warn(&port->dev,
+					 "Failed to allocate the decoder\n");
+				return PTR_ERR(cxld);
+			}
+		} else {
+			struct cxl_switch_decoder *cxlsd;
+
+			cxlsd = cxl_switch_decoder_alloc(port, target_count);
+			if (IS_ERR(cxlsd)) {
+				dev_warn(&port->dev,
+					 "Failed to allocate the decoder\n");
+				return PTR_ERR(cxlsd);
+			}
+			cxld = &cxlsd->cxld;
 		}
 
 		rc = init_hdm_decoder(port, cxld, target_map, hdm, i);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index f62c0a6e17ea..27a2a6b839aa 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -120,20 +120,21 @@ static ssize_t target_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(target_type);
 
-static ssize_t emit_target_list(struct cxl_decoder *cxld, char *buf)
+static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
 {
+	struct cxl_decoder *cxld = &cxlsd->cxld;
 	ssize_t offset = 0;
 	int i, rc = 0;
 
 	for (i = 0; i < cxld->interleave_ways; i++) {
-		struct cxl_dport *dport = cxld->target[i];
+		struct cxl_dport *dport = cxlsd->target[i];
 		struct cxl_dport *next = NULL;
 
 		if (!dport)
 			break;
 
 		if (i + 1 < cxld->interleave_ways)
-			next = cxld->target[i + 1];
+			next = cxlsd->target[i + 1];
 		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
 				   next ? "," : "");
 		if (rc < 0)
@@ -144,18 +145,20 @@ static ssize_t emit_target_list(struct cxl_decoder *cxld, char *buf)
 	return offset;
 }
 
+static struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
+
 static ssize_t target_list_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
-	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
 	ssize_t offset;
 	unsigned int seq;
 	int rc;
 
 	do {
-		seq = read_seqbegin(&cxld->target_lock);
-		rc = emit_target_list(cxld, buf);
-	} while (read_seqretry(&cxld->target_lock, seq));
+		seq = read_seqbegin(&cxlsd->target_lock);
+		rc = emit_target_list(cxlsd, buf);
+	} while (read_seqretry(&cxlsd->target_lock, seq));
 
 	if (rc < 0)
 		return rc;
@@ -233,14 +236,28 @@ static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
 	NULL,
 };
 
+static void __cxl_decoder_release(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	ida_free(&port->decoder_ida, cxld->id);
+	put_device(&port->dev);
+}
+
 static void cxl_decoder_release(struct device *dev)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
-	struct cxl_port *port = to_cxl_port(dev->parent);
 
-	ida_free(&port->decoder_ida, cxld->id);
+	__cxl_decoder_release(cxld);
 	kfree(cxld);
-	put_device(&port->dev);
+}
+
+static void cxl_switch_decoder_release(struct device *dev)
+{
+	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
+
+	__cxl_decoder_release(&cxlsd->cxld);
+	kfree(cxlsd);
 }
 
 static const struct device_type cxl_decoder_endpoint_type = {
@@ -251,13 +268,13 @@ static const struct device_type cxl_decoder_endpoint_type = {
 
 static const struct device_type cxl_decoder_switch_type = {
 	.name = "cxl_decoder_switch",
-	.release = cxl_decoder_release,
+	.release = cxl_switch_decoder_release,
 	.groups = cxl_decoder_switch_attribute_groups,
 };
 
 static const struct device_type cxl_decoder_root_type = {
 	.name = "cxl_decoder_root",
-	.release = cxl_decoder_release,
+	.release = cxl_switch_decoder_release,
 	.groups = cxl_decoder_root_attribute_groups,
 };
 
@@ -272,15 +289,29 @@ bool is_root_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
 
+static bool is_switch_decoder(struct device *dev)
+{
+	return is_root_decoder(dev) || dev->type == &cxl_decoder_switch_type;
+}
+
 struct cxl_decoder *to_cxl_decoder(struct device *dev)
 {
-	if (dev_WARN_ONCE(dev, dev->type->release != cxl_decoder_release,
+	if (dev_WARN_ONCE(dev,
+			  !is_switch_decoder(dev) && !is_endpoint_decoder(dev),
 			  "not a cxl_decoder device\n"))
 		return NULL;
 	return container_of(dev, struct cxl_decoder, dev);
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_decoder, CXL);
 
+static struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_switch_decoder(dev),
+			  "not a cxl_switch_decoder device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_switch_decoder, cxld.dev);
+}
+
 static void cxl_ep_release(struct cxl_ep *ep)
 {
 	if (!ep)
@@ -1146,7 +1177,7 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_dport_by_dev, CXL);
 
-static int decoder_populate_targets(struct cxl_decoder *cxld,
+static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 				    struct cxl_port *port, int *target_map)
 {
 	int i, rc = 0;
@@ -1159,17 +1190,17 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 	if (list_empty(&port->dports))
 		return -EINVAL;
 
-	write_seqlock(&cxld->target_lock);
-	for (i = 0; i < cxld->nr_targets; i++) {
+	write_seqlock(&cxlsd->target_lock);
+	for (i = 0; i < cxlsd->nr_targets; i++) {
 		struct cxl_dport *dport = find_dport(port, target_map[i]);
 
 		if (!dport) {
 			rc = -ENXIO;
 			break;
 		}
-		cxld->target[i] = dport;
+		cxlsd->target[i] = dport;
 	}
-	write_sequnlock(&cxld->target_lock);
+	write_sequnlock(&cxlsd->target_lock);
 
 	return rc;
 }
@@ -1177,56 +1208,34 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 static struct lock_class_key cxl_decoder_key;
 
 /**
- * cxl_decoder_alloc - Allocate a new CXL decoder
+ * cxl_decoder_alloc - Common decoder setup / initialization
  * @port: owning port of this decoder
- * @nr_targets: downstream targets accessible by this decoder. All upstream
- *		ports and root ports must have at least 1 target. Endpoint
- *		devices will have 0 targets. Callers wishing to register an
- *		endpoint device should specify 0.
- *
- * A port should contain one or more decoders. Each of those decoders enable
- * some address space for CXL.mem utilization. A decoder is expected to be
- * configured by the caller before registering.
+ * @cxld: common decoder properties to initialize
  *
- * Return: A new cxl decoder to be registered by cxl_decoder_add(). The decoder
- *	   is initialized to be a "passthrough" decoder.
+ * A port may contain one or more decoders. Each of those decoders
+ * enable some address space for CXL.mem utilization. A decoder is
+ * expected to be configured by the caller before registering via
+ * cxl_decoder_add()
  */
-static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
-					     unsigned int nr_targets)
+static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
 {
-	struct cxl_decoder *cxld;
 	struct device *dev;
-	int rc = 0;
-
-	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
-		return ERR_PTR(-EINVAL);
-
-	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
-	if (!cxld)
-		return ERR_PTR(-ENOMEM);
+	int rc;
 
 	rc = ida_alloc(&port->decoder_ida, GFP_KERNEL);
 	if (rc < 0)
-		goto err;
+		return rc;
 
 	/* need parent to stick around to release the id */
 	get_device(&port->dev);
 	cxld->id = rc;
 
-	cxld->nr_targets = nr_targets;
-	seqlock_init(&cxld->target_lock);
 	dev = &cxld->dev;
 	device_initialize(dev);
 	lockdep_set_class(&dev->mutex, &cxl_decoder_key);
 	device_set_pm_not_required(dev);
 	dev->parent = &port->dev;
 	dev->bus = &cxl_bus_type;
-	if (is_cxl_root(port))
-		cxld->dev.type = &cxl_decoder_root_type;
-	else if (is_cxl_endpoint(port))
-		cxld->dev.type = &cxl_decoder_endpoint_type;
-	else
-		cxld->dev.type = &cxl_decoder_switch_type;
 
 	/* Pre initialize an "empty" decoder */
 	cxld->interleave_ways = 1;
@@ -1237,10 +1246,19 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 		.end = -1,
 	};
 
-	return cxld;
-err:
-	kfree(cxld);
-	return ERR_PTR(rc);
+	return 0;
+}
+
+static int cxl_switch_decoder_init(struct cxl_port *port,
+				   struct cxl_switch_decoder *cxlsd,
+				   int nr_targets)
+{
+	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
+		return -EINVAL;
+
+	cxlsd->nr_targets = nr_targets;
+	seqlock_init(&cxlsd->target_lock);
+	return cxl_decoder_init(port, &cxlsd->cxld);
 }
 
 /**
@@ -1253,13 +1271,29 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
  * firmware description of CXL resources into a CXL standard decode
  * topology.
  */
-struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
-					   unsigned int nr_targets)
+struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
+						  unsigned int nr_targets)
 {
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_decoder *cxld;
+	int rc;
+
 	if (!is_cxl_root(port))
 		return ERR_PTR(-EINVAL);
 
-	return cxl_decoder_alloc(port, nr_targets);
+	cxlsd = kzalloc(struct_size(cxlsd, target, nr_targets), GFP_KERNEL);
+	if (!cxlsd)
+		return ERR_PTR(-ENOMEM);
+
+	rc = cxl_switch_decoder_init(port, cxlsd, nr_targets);
+	if (rc) {
+		kfree(cxlsd);
+		return ERR_PTR(rc);
+	}
+
+	cxld = &cxlsd->cxld;
+	cxld->dev.type = &cxl_decoder_root_type;
+	return cxlsd;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
 
@@ -1274,13 +1308,29 @@ EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
  * that sit between Switch Upstream Ports / Switch Downstream Ports and
  * Host Bridges / Root Ports.
  */
-struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
-					     unsigned int nr_targets)
+struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
+						    unsigned int nr_targets)
 {
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_decoder *cxld;
+	int rc;
+
 	if (is_cxl_root(port) || is_cxl_endpoint(port))
 		return ERR_PTR(-EINVAL);
 
-	return cxl_decoder_alloc(port, nr_targets);
+	cxlsd = kzalloc(struct_size(cxlsd, target, nr_targets), GFP_KERNEL);
+	if (!cxlsd)
+		return ERR_PTR(-ENOMEM);
+
+	rc = cxl_switch_decoder_init(port, cxlsd, nr_targets);
+	if (rc) {
+		kfree(cxlsd);
+		return ERR_PTR(rc);
+	}
+
+	cxld = &cxlsd->cxld;
+	cxld->dev.type = &cxl_decoder_switch_type;
+	return cxlsd;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
 
@@ -1292,10 +1342,24 @@ EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
  */
 struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
 {
+	struct cxl_decoder *cxld;
+	int rc;
+
 	if (!is_cxl_endpoint(port))
 		return ERR_PTR(-EINVAL);
 
-	return cxl_decoder_alloc(port, 0);
+	cxld = kzalloc(sizeof(*cxld), GFP_KERNEL);
+	if (!cxld)
+		return ERR_PTR(-ENOMEM);
+
+	rc = cxl_decoder_init(port, cxld);
+	if (rc)	 {
+		kfree(cxld);
+		return ERR_PTR(rc);
+	}
+
+	cxld->dev.type = &cxl_decoder_endpoint_type;
+	return cxld;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_alloc, CXL);
 
@@ -1337,7 +1401,9 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
 
 	port = to_cxl_port(cxld->dev.parent);
 	if (!is_endpoint_decoder(dev)) {
-		rc = decoder_populate_targets(cxld, port, target_map);
+		struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
+
+		rc = decoder_populate_targets(cxlsd, port, target_map);
 		if (rc && (cxld->flags & CXL_DECODER_F_ENABLE)) {
 			dev_err(&port->dev,
 				"Failed to populate active decoder targets\n");
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 570bd9f8141b..0289c06ec72c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -220,7 +220,7 @@ enum cxl_decoder_type {
 #define CXL_DECODER_MAX_INTERLEAVE 16
 
 /**
- * struct cxl_decoder - CXL address range decode configuration
+ * struct cxl_decoder - Common CXL HDM Decoder Attributes
  * @dev: this decoder's device
  * @id: kernel device name id
  * @hpa_range: Host physical address range mapped by this decoder
@@ -228,9 +228,6 @@ enum cxl_decoder_type {
  * @interleave_granularity: data stride per dport
  * @target_type: accelerator vs expander (type2 vs type3) selector
  * @flags: memory type capabilities and locking
- * @target_lock: coordinate coherent reads of the target list
- * @nr_targets: number of elements in @target
- * @target: active ordered target list in current decoder configuration
  */
 struct cxl_decoder {
 	struct device dev;
@@ -240,6 +237,23 @@ struct cxl_decoder {
 	int interleave_granularity;
 	enum cxl_decoder_type target_type;
 	unsigned long flags;
+};
+
+/**
+ * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
+ * @cxld: base cxl_decoder object
+ * @target_lock: coordinate coherent reads of the target list
+ * @nr_targets: number of elements in @target
+ * @target: active ordered target list in current decoder configuration
+ *
+ * The 'switch' decoder type represents the decoder instances of cxl_port's that
+ * route from the root of a CXL memory decode topology to the endpoints. They
+ * come in two flavors, root-level decoders, statically defined by platform
+ * firmware, and mid-level decoders, where interleave-granularity,
+ * interleave-width, and the target list are mutable.
+ */
+struct cxl_switch_decoder {
+	struct cxl_decoder cxld;
 	seqlock_t target_lock;
 	int nr_targets;
 	struct cxl_dport *target[];
@@ -364,10 +378,10 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
-struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
-					   unsigned int nr_targets);
-struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
-					     unsigned int nr_targets);
+struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
+						  unsigned int nr_targets);
+struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
+						    unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
 int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 6e086fbc5c5b..7991ddc6e562 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -451,14 +451,23 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 		struct cxl_decoder *cxld;
 		int rc;
 
-		if (target_count)
-			cxld = cxl_switch_decoder_alloc(port, target_count);
-		else
+		if (target_count) {
+			struct cxl_switch_decoder *cxlsd;
+
+			cxlsd = cxl_switch_decoder_alloc(port, target_count);
+			if (IS_ERR(cxlsd)) {
+				dev_warn(&port->dev,
+					 "Failed to allocate the decoder\n");
+				return PTR_ERR(cxlsd);
+			}
+			cxld = &cxlsd->cxld;
+		} else {
 			cxld = cxl_endpoint_decoder_alloc(port);
-		if (IS_ERR(cxld)) {
-			dev_warn(&port->dev,
-				 "Failed to allocate the decoder\n");
-			return PTR_ERR(cxld);
+			if (IS_ERR(cxld)) {
+				dev_warn(&port->dev,
+					 "Failed to allocate the decoder\n");
+				return PTR_ERR(cxld);
+			}
 		}
 
 		cxld->hpa_range = (struct range) {

