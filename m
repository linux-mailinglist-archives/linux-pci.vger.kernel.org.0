Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94831497685
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiAXA3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:29:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:22183 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240573AbiAXA3i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984178; x=1674520178;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zt4OnuTzPLuh3s7iSKmQ6vnZ4e8R6IFJmKVnPkyn9Ls=;
  b=b+peTd0wbV27q/gCBST4JVhvaiVaCQR1BzZHa/+Efa272BdLXBTi3DrC
   b17296VxDa7eZBXs3+P+iTrTtVX75bvl9Rmvbbf+05OKmMa5oiFTA3d44
   xFiihDlNI0621rulN38WgbWejsnT2/JPp94LWV7sceZV0FS6DB0bJz8Vn
   +nhjZz2/FVoYV4Q+ji/aR28nK6KpEahTz94x8mxKOBfR/tHxW0K03P+Jf
   jXbIPf4bR8Te1VDkFoo91tfiE+V6bficm0k7jdr/wpH0SIqVsNSc8J4Oz
   mgyT5B/OYNWUKM1RL1QkKNEPTqz38OdMn7mRCzHIV/IUisDHQx4oUvA8v
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="226608025"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="226608025"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="562473218"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:37 -0800
Subject: [PATCH v3 11/40] cxl/core/port: Clarify decoder creation
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:29:37 -0800
Message-ID: <164298417755.3018233.850001481653928773.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Add wrappers for the creation of decoder objects at the root level and
switch level, and keep the core helper private to cxl/core/port.c. Root
decoders are static descriptors conveyed from platform firmware (e.g.
ACPI CFMWS). Switch decoders are CXL standard decoders enumerated via
the HDM decoder capability structure. The base address for the HDM
decoder capability structure may be conveyed either by PCIe or platform
firmware (ACPI CEDT.CHBS).

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
[djbw: fixup changelog]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      |    4 +-
 drivers/cxl/core/port.c |   78 ++++++++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxl.h       |   10 +++++-
 3 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index da70f1836db6..0b267eabb15e 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -102,7 +102,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	for (i = 0; i < CFMWS_INTERLEAVE_WAYS(cfmws); i++)
 		target_map[i] = cfmws->interleave_targets[i];
 
-	cxld = cxl_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
+	cxld = cxl_root_decoder_alloc(root_port, CFMWS_INTERLEAVE_WAYS(cfmws));
 	if (IS_ERR(cxld))
 		return 0;
 
@@ -260,7 +260,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
 	 * dport. Disable the range until the first CXL region is enumerated /
 	 * activated.
 	 */
-	cxld = cxl_decoder_alloc(port, 1);
+	cxld = cxl_switch_decoder_alloc(port, 1);
 	if (IS_ERR(cxld))
 		return PTR_ERR(cxld);
 
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 63c76cb2a2ec..2910c36a0e58 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -495,13 +495,26 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
 	return rc;
 }
 
-struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
+/**
+ * cxl_decoder_alloc - Allocate a new CXL decoder
+ * @port: owning port of this decoder
+ * @nr_targets: downstream targets accessible by this decoder. All upstream
+ *		ports and root ports must have at least 1 target.
+ *
+ * A port should contain one or more decoders. Each of those decoders enable
+ * some address space for CXL.mem utilization. A decoder is expected to be
+ * configured by the caller before registering.
+ *
+ * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ */
+static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
+					     unsigned int nr_targets)
 {
 	struct cxl_decoder *cxld;
 	struct device *dev;
 	int rc = 0;
 
-	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
+	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
 		return ERR_PTR(-EINVAL);
 
 	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
@@ -519,20 +532,69 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
 	device_set_pm_not_required(dev);
 	dev->parent = &port->dev;
 	dev->bus = &cxl_bus_type;
-
-	/* root ports do not have a cxl_port_type parent */
-	if (port->dev.parent->type == &cxl_port_type)
-		dev->type = &cxl_decoder_switch_type;
+	if (is_cxl_root(port))
+		cxld->dev.type = &cxl_decoder_root_type;
 	else
-		dev->type = &cxl_decoder_root_type;
+		cxld->dev.type = &cxl_decoder_switch_type;
 
 	return cxld;
 err:
 	kfree(cxld);
 	return ERR_PTR(rc);
 }
-EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
 
+/**
+ * cxl_root_decoder_alloc - Allocate a root level decoder
+ * @port: owning CXL root port of this decoder
+ * @nr_targets: number of downstream targets. The number of downstream targets
+ *		is determined with a platform specific mechanism.
+ *
+ * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ */
+struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
+					   unsigned int nr_targets)
+{
+	if (!is_cxl_root(port))
+		return ERR_PTR(-EINVAL);
+
+	return cxl_decoder_alloc(port, nr_targets);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
+
+/**
+ * cxl_switch_decoder_alloc - Allocate a switch level decoder
+ * @port: owning CXL switch port of this decoder
+ * @nr_targets: number of downstream targets. The number of downstream targets
+ *		is determined via CXL capability registers.
+ *
+ * Return: A new cxl decoder to be registered by cxl_decoder_add()
+ */
+struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
+					     unsigned int nr_targets)
+{
+	if (is_cxl_root(port))
+		return ERR_PTR(-EINVAL);
+
+	return cxl_decoder_alloc(port, nr_targets);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
+
+/**
+ * cxl_decoder_add - Add a decoder with targets
+ * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
+ * @target_map: A list of downstream ports that this decoder can direct memory
+ *              traffic to. These numbers should correspond with the port number
+ *              in the PCIe Link Capabilities structure.
+ *
+ * Certain types of decoders may not have any targets. The main example of this
+ * is an endpoint device. A more awkward example is a hostbridge whose root
+ * ports get hot added (technically possible, though unlikely).
+ *
+ * Context: Process context. Takes and releases the cxld's device lock.
+ *
+ * Return: Negative error code if the decoder wasn't properly configured; else
+ *	   returns 0.
+ */
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
 {
 	struct cxl_port *port;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index bfd95acea66c..e60878ab4569 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -278,6 +278,11 @@ struct cxl_dport {
 	struct list_head list;
 };
 
+static inline bool is_cxl_root(struct cxl_port *port)
+{
+	return port->uport == port->dev.parent;
+}
+
 struct cxl_port *to_cxl_port(struct device *dev);
 struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
 				   resource_size_t component_reg_phys,
@@ -288,7 +293,10 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
 
 struct cxl_decoder *to_cxl_decoder(struct device *dev);
 bool is_root_decoder(struct device *dev);
-struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
+struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
+					   unsigned int nr_targets);
+struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
+					     unsigned int nr_targets);
 int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
 int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
 

