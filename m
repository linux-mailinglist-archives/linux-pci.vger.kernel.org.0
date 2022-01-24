Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 217B64976B3
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240627AbiAXAbr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:31:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:23009 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235327AbiAXAbq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:31:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984306; x=1674520306;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cD9NpRWN1E4ZUBheds5b8NOUSefH5Ue1orQiv6OMIEg=;
  b=Cp0yA/G3AH/+Fns22IXalzxt23HzkjzPDcc3JjNT7fZ2Jc/U2zlSRVn2
   b0J52AymS+1OstCh6ThN+eP2nlnlFnJgBDmzR9ko+KiefArHVOi8nh6M9
   TZ8emd+kipfKpfXoa/HFYfLAD7/fGphXQsLywGeqaVX2sMuM3EBSotCW1
   E3ezUlJACDn2Nl45Y0COYH2xpo7CYvzo9VqQ8KUxmM0dejIm35BtzmjtC
   3wLYm9alM+w/zA5wYrvkZAipIvA7cBKMCwBHGCg4DlY2HTGuTCVEBEJYi
   +u/4omCQ1mminIaD2gRFbvLNc6gY1WebNIRp8hI1PScuIuO9XDJG3XRjU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="243529288"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="243529288"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:46 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="562473670"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:31:46 -0800
Subject: [PATCH v3 35/40] cxl/core/port: Add endpoint decoders
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:31:46 -0800
Message-ID: <164298430609.3018233.3860765171749496117.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Recall that a CXL Port is any object that publishes a CXL HDM Decoder
Capability structure. That is Host Bridge and Switches that have been
enabled so far. Now, add decoder support to the 'endpoint' CXL Ports
registered by the cxl_mem driver. They mostly share the same enumeration
as Bridges and Switches, but witout a target list. The target of
endpoint decode is device-internal DPA space, not another downstream
port.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
[djbw: clarify changelog, hookup enumeration in the port driver]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c  |    8 +++++-
 drivers/cxl/core/port.c |   63 ++++++++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxl.h       |    1 +
 drivers/cxl/port.c      |   16 +++++++-----
 4 files changed, 73 insertions(+), 15 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 701b510c76d2..2f3b08459511 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -187,6 +187,9 @@ static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
 	else
 		cxld->target_type = CXL_DECODER_ACCELERATOR;
 
+	if (is_cxl_endpoint(to_cxl_port(cxld->dev.parent)))
+		return;
+
 	target_list.value =
 		ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 	for (i = 0; i < cxld->interleave_ways; i++)
@@ -226,7 +229,10 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 		int rc, target_count = cxlhdm->target_count;
 		struct cxl_decoder *cxld;
 
-		cxld = cxl_switch_decoder_alloc(port, target_count);
+		if (is_cxl_endpoint(port))
+			cxld = cxl_endpoint_decoder_alloc(port);
+		else
+			cxld = cxl_switch_decoder_alloc(port, target_count);
 		if (IS_ERR(cxld)) {
 			dev_warn(&port->dev,
 				 "Failed to allocate the decoder\n");
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 39ce0fa7b285..a093215e6496 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -230,6 +230,22 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
 	NULL,
 };
 
+static struct attribute *cxl_decoder_endpoint_attrs[] = {
+	&dev_attr_target_type.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_decoder_endpoint_attribute_group = {
+	.attrs = cxl_decoder_endpoint_attrs,
+};
+
+static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
+	&cxl_decoder_base_attribute_group,
+	&cxl_decoder_endpoint_attribute_group,
+	&cxl_base_attribute_group,
+	NULL,
+};
+
 static void cxl_decoder_release(struct device *dev)
 {
 	struct cxl_decoder *cxld = to_cxl_decoder(dev);
@@ -239,6 +255,12 @@ static void cxl_decoder_release(struct device *dev)
 	kfree(cxld);
 }
 
+static const struct device_type cxl_decoder_endpoint_type = {
+	.name = "cxl_decoder_endpoint",
+	.release = cxl_decoder_release,
+	.groups = cxl_decoder_endpoint_attribute_groups,
+};
+
 static const struct device_type cxl_decoder_switch_type = {
 	.name = "cxl_decoder_switch",
 	.release = cxl_decoder_release,
@@ -251,6 +273,11 @@ static const struct device_type cxl_decoder_root_type = {
 	.groups = cxl_decoder_root_attribute_groups,
 };
 
+static bool is_endpoint_decoder(struct device *dev)
+{
+	return dev->type == &cxl_decoder_endpoint_type;
+}
+
 bool is_root_decoder(struct device *dev)
 {
 	return dev->type == &cxl_decoder_root_type;
@@ -1088,7 +1115,9 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
  * cxl_decoder_alloc - Allocate a new CXL decoder
  * @port: owning port of this decoder
  * @nr_targets: downstream targets accessible by this decoder. All upstream
- *		ports and root ports must have at least 1 target.
+ *		ports and root ports must have at least 1 target. Endpoint
+ *		devices will have 0 targets. Callers wishing to register an
+ *		endpoint device should specify 0.
  *
  * A port should contain one or more decoders. Each of those decoders enable
  * some address space for CXL.mem utilization. A decoder is expected to be
@@ -1104,7 +1133,7 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	struct device *dev;
 	int rc = 0;
 
-	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
+	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
 		return ERR_PTR(-EINVAL);
 
 	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
@@ -1125,6 +1154,8 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
 	dev->bus = &cxl_bus_type;
 	if (is_cxl_root(port))
 		cxld->dev.type = &cxl_decoder_root_type;
+	else if (is_cxl_endpoint(port))
+		cxld->dev.type = &cxl_decoder_endpoint_type;
 	else
 		cxld->dev.type = &cxl_decoder_switch_type;
 
@@ -1169,13 +1200,28 @@ EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
 struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 					     unsigned int nr_targets)
 {
-	if (is_cxl_root(port))
+	if (is_cxl_root(port) || is_cxl_endpoint(port))
 		return ERR_PTR(-EINVAL);
 
 	return cxl_decoder_alloc(port, nr_targets);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
 
+/**
+ * cxl_endpoint_decoder_alloc - Allocate an endpoint decoder
+ * @port: owning port of this decoder
+ *
+ * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ */
+struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
+{
+	if (!is_cxl_endpoint(port))
+		return ERR_PTR(-EINVAL);
+
+	return cxl_decoder_alloc(port, 0);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_alloc, CXL);
+
 /**
  * cxl_decoder_add_locked - Add a decoder with targets
  * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
@@ -1210,12 +1256,15 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
 	if (cxld->interleave_ways < 1)
 		return -EINVAL;
 
+	dev = &cxld->dev;
+
 	port = to_cxl_port(cxld->dev.parent);
-	rc = decoder_populate_targets(cxld, port, target_map);
-	if (rc)
-		return rc;
+	if (!is_endpoint_decoder(dev)) {
+		rc = decoder_populate_targets(cxld, port, target_map);
+		if (rc)
+			return rc;
+	}
 
-	dev = &cxld->dev;
 	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 0bbe394f2f26..962629c5775f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -340,6 +340,7 @@ struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
 struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
 					     unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
+struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
 int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 27ab7f8d122e..fea94f4afd24 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -40,15 +40,17 @@ static int cxl_port_probe(struct device *dev)
 		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
 
 		get_device(&cxlmd->dev);
-		return devm_add_action_or_reset(dev, schedule_detach, cxlmd);
+		rc = devm_add_action_or_reset(dev, schedule_detach, cxlmd);
+		if (rc)
+			return rc;
+	} else {
+		rc = devm_cxl_port_enumerate_dports(port);
+		if (rc < 0)
+			return rc;
+		if (rc == 1)
+			return devm_cxl_add_passthrough_decoder(port);
 	}
 
-	rc = devm_cxl_port_enumerate_dports(port);
-	if (rc < 0)
-		return rc;
-	if (rc == 1)
-		return devm_cxl_add_passthrough_decoder(port);
-
 	cxlhdm = devm_cxl_setup_hdm(port);
 	if (IS_ERR(cxlhdm))
 		return PTR_ERR(cxlhdm);

