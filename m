Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8310857583F
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241010AbiGOABR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbiGOABN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:01:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DBD71720;
        Thu, 14 Jul 2022 17:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843272; x=1689379272;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ihFnLM0nNzB7sHl4ZXxnyM/LsP/E8epqdxlAvbvAKI=;
  b=fAgOCunbty/a7Vbi4ciu1j68ygzdxLLjz5MT/YxKFHjnIt7P8Jsd4+zy
   HUq4R1uXxczbqU5FFPo3oyEq0p7s+DQIebFzD4DqqaWMAqzXCugZ4+wGk
   7vbPvAj2cPoM3q0Z8+ilnM8rEFoduruCqj6moRtpvTIxRDrObDHB5K5V9
   4QGnpiWPM3RV/qwdfygGmUHczcN0lt7hRvwFgRJCcUuKjXw+dcGvFz2lr
   KvOiK1c65Gdg9MQnRCh52tVBkrsTQYH0ngzc5RJ5ZJ9TfwvJB5o4fZsXE
   5d5dRokudvWJyMAF9eNn738POEWTgKPTmVkA2Ba6DZwaK87h8PO881qD7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286799483"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="286799483"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:12 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="663984569"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:11 -0700
Subject: [PATCH v2 05/28] cxl/core: Define a 'struct cxl_endpoint_decoder'
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <bwidawsk@kernel.org>, hch@lst.de,
        nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:01:10 -0700
Message-ID: <165784327088.1758207.15502834501671201192.stgit@dwillia2-xfh.jf.intel.com>
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

Previously the target routing specifics of switch decoders and platform
CXL window resource tracking of root decoders were factored out of
'struct cxl_decoder'. While switch decoders translate from SPA to
downstream ports, endpoint decoders translate from SPA to DPA.

This patch, 3 of 3, adds a 'struct cxl_endpoint_decoder' that tracks an
endpoint-specific Device Physical Address (DPA) resource. For now this
just defines ->dpa_res, a follow-on patch will handle requesting DPA
resource ranges from a device-DPA resource tree.

Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c       |    9 ++++++---
 drivers/cxl/core/port.c      |   31 +++++++++++++++++++++----------
 drivers/cxl/cxl.h            |   15 ++++++++++++++-
 tools/testing/cxl/test/cxl.c |   10 +++++++---
 4 files changed, 48 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 2f10d42798de..650363d5272f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -256,12 +256,15 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 		struct cxl_decoder *cxld;
 
 		if (is_cxl_endpoint(port)) {
-			cxld = cxl_endpoint_decoder_alloc(port);
-			if (IS_ERR(cxld)) {
+			struct cxl_endpoint_decoder *cxled;
+
+			cxled = cxl_endpoint_decoder_alloc(port);
+			if (IS_ERR(cxled)) {
 				dev_warn(&port->dev,
 					 "Failed to allocate the decoder\n");
-				return PTR_ERR(cxld);
+				return PTR_ERR(cxled);
 			}
+			cxld = &cxled->cxld;
 		} else {
 			struct cxl_switch_decoder *cxlsd;
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 4953a1c7b245..ca4f23204e5c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -244,12 +244,12 @@ static void __cxl_decoder_release(struct cxl_decoder *cxld)
 	put_device(&port->dev);
 }
 
-static void cxl_decoder_release(struct device *dev)
+static void cxl_endpoint_decoder_release(struct device *dev)
 {
-	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+	struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(dev);
 
-	__cxl_decoder_release(cxld);
-	kfree(cxld);
+	__cxl_decoder_release(&cxled->cxld);
+	kfree(cxled);
 }
 
 static void cxl_switch_decoder_release(struct device *dev)
@@ -279,7 +279,7 @@ static void cxl_root_decoder_release(struct device *dev)
 
 static const struct device_type cxl_decoder_endpoint_type = {
 	.name = "cxl_decoder_endpoint",
-	.release = cxl_decoder_release,
+	.release = cxl_endpoint_decoder_release,
 	.groups = cxl_decoder_endpoint_attribute_groups,
 };
 
@@ -321,6 +321,15 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(to_cxl_decoder, CXL);
 
+struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev)
+{
+	if (dev_WARN_ONCE(dev, !is_endpoint_decoder(dev),
+			  "not a cxl_endpoint_decoder device\n"))
+		return NULL;
+	return container_of(dev, struct cxl_endpoint_decoder, cxld.dev);
+}
+EXPORT_SYMBOL_NS_GPL(to_cxl_endpoint_decoder, CXL);
+
 static struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
 {
 	if (dev_WARN_ONCE(dev, !is_switch_decoder(dev),
@@ -1360,26 +1369,28 @@ EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
  *
  * Return: A new cxl decoder to be registered by cxl_decoder_add()
  */
-struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
+struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
 {
+	struct cxl_endpoint_decoder *cxled;
 	struct cxl_decoder *cxld;
 	int rc;
 
 	if (!is_cxl_endpoint(port))
 		return ERR_PTR(-EINVAL);
 
-	cxld = kzalloc(sizeof(*cxld), GFP_KERNEL);
-	if (!cxld)
+	cxled = kzalloc(sizeof(*cxled), GFP_KERNEL);
+	if (!cxled)
 		return ERR_PTR(-ENOMEM);
 
+	cxld = &cxled->cxld;
 	rc = cxl_decoder_init(port, cxld);
 	if (rc)	 {
-		kfree(cxld);
+		kfree(cxled);
 		return ERR_PTR(rc);
 	}
 
 	cxld->dev.type = &cxl_decoder_endpoint_type;
-	return cxld;
+	return cxled;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_alloc, CXL);
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index ebdac8e7d181..7e1460d89296 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -239,6 +239,18 @@ struct cxl_decoder {
 	unsigned long flags;
 };
 
+/**
+ * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
+ * @cxld: base cxl_decoder_object
+ * @dpa_res: actively claimed DPA span of this decoder
+ * @skip: offset into @dpa_res where @cxld.hpa_range maps
+ */
+struct cxl_endpoint_decoder {
+	struct cxl_decoder cxld;
+	struct resource *dpa_res;
+	resource_size_t skip;
+};
+
 /**
  * struct cxl_switch_decoder - Switch specific CXL HDM Decoder
  * @cxld: base cxl_decoder object
@@ -387,6 +399,7 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
+struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
 bool is_endpoint_decoder(struct device *dev);
 struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
@@ -394,7 +407,7 @@ struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 						    unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
-struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
+struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
 int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 7991ddc6e562..4dad0fa7ac4c 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -462,12 +462,16 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			}
 			cxld = &cxlsd->cxld;
 		} else {
-			cxld = cxl_endpoint_decoder_alloc(port);
-			if (IS_ERR(cxld)) {
+			struct cxl_endpoint_decoder *cxled;
+
+			cxled = cxl_endpoint_decoder_alloc(port);
+
+			if (IS_ERR(cxled)) {
 				dev_warn(&port->dev,
 					 "Failed to allocate the decoder\n");
-				return PTR_ERR(cxld);
+				return PTR_ERR(cxled);
 			}
+			cxld = &cxled->cxld;
 		}
 
 		cxld->hpa_range = (struct range) {

