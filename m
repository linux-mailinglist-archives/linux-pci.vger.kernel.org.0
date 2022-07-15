Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5174575843
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241015AbiGOAB1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241013AbiGOAB0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:01:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F2571720;
        Thu, 14 Jul 2022 17:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843285; x=1689379285;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g7uYXQiu25oHGwZq+lig75MTaX/7ZFGMAsa2V42H71M=;
  b=P38Pz3VqMXXV4vycyMRhwnuGO1FiLICcI1eJY2jLgIXjHLVsH6b3P89P
   aqhnUUAGfCKyTzorlk0+TtosMLSBNPx/2HW8Lna0Zph03QbkRHoyWqE26
   z1sf4tnOPQWKUKlVhAECTAYMuzVifdhITHLqId0t19arjdgzvoFlLOxkb
   DHiO3G1jM1uvVjEeeJlzgPNFTEJyGys5n3DmkSBq0ZP2L5Ke74RjfNaT1
   5XBUWU2ooCiiFc6zSTicsS9OWJdWLa22eh1n6DbEe7FmDGPa6s0jFphLq
   BCYDYRFttQoDUR/65nubI7pCFl14i9hLfLOMIfBcE6fob1qeszgmgPb+C
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="311320087"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="311320087"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:01:00 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="842325380"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:00:59 -0700
Subject: [PATCH v2 03/28] cxl/acpi: Track CXL resources in iomem_resource
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Tony Luck <tony.luck@intel.com>,
        Christoph Hellwig <hch@lst.de>, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:00:59 -0700
Message-ID: <165784325943.1758207.5310344844375305118.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recall that CXL capable address ranges, on ACPI platforms, are published
in the CEDT.CFMWS (CXL Early Discovery Table: CXL Fixed Memory Window
Structures). These windows represent both the actively mapped capacity
and the potential address space that can be dynamically assigned to a
new CXL decode configuration (region / interleave-set).

CXL endpoints like DDR DIMMs can be mapped at any physical address
including 0 and legacy ranges.

There is an expectation and requirement that the /proc/iomem interface
and the iomem_resource tree in the kernel reflect the full set of
platform address ranges. I.e. that every address range that platform
firmware and bus drivers enumerate be reflected as an iomem_resource
entry. The hard requirement to do this for CXL arises from the fact that
facilities like CONFIG_DEVICE_PRIVATE expect to be able to treat empty
iomem_resource ranges as free for software to use as proxy address
space. Without CXL publishing its potential address ranges in
iomem_resource, the CONFIG_DEVICE_PRIVATE mechanism may inadvertently
steal capacity reserved for runtime provisioning of new CXL regions.

So, iomem_resource needs to know about both active and potential CXL
resource ranges. The active CXL resources might already be reflected in
iomem_resource as "System RAM". insert_resource_expand_to_fit() handles
re-parenting "System RAM" underneath a CXL window.

The "_expand_to_fit()" behavior handles cases where a CXL window is not
a strict superset of an existing entry in the iomem_resource tree. The
"_expand_to_fit()" behavior is acceptable from the perspective of
resource allocation. The expansion happens because a conflicting
resource range is already populated, which means the resource boundary
expansion does not result in any additional free CXL address space being
made available. CXL address space allocation is always bounded by the
orginal unexpanded address range.

However, the potential for expansion does mean that something like
walk_iomem_res_desc(IORES_DESC_CXL...) can only return fuzzy answers on
corner case platforms that cause the resource tree to expand a CXL
window resource over a range that is not decoded by CXL. This would be
an odd platform configuration, but if it becomes a problem in practice
the CXL subsytem could just publish an API that returns definitive
answers.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c     |  144 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/ioport.h |    1 
 kernel/resource.c      |    7 ++
 3 files changed, 149 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 62bf22ffb7aa..e2b6cbd04846 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -73,6 +73,8 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
 struct cxl_cfmws_context {
 	struct device *dev;
 	struct cxl_port *root_port;
+	struct resource *cxl_res;
+	int id;
 };
 
 static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
@@ -81,11 +83,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	int target_map[CXL_DECODER_MAX_INTERLEAVE];
 	struct cxl_cfmws_context *ctx = arg;
 	struct cxl_port *root_port = ctx->root_port;
+	struct resource *cxl_res = ctx->cxl_res;
 	struct cxl_switch_decoder *cxlsd;
 	struct device *dev = ctx->dev;
 	struct acpi_cedt_cfmws *cfmws;
 	struct cxl_decoder *cxld;
 	unsigned int ways, i, ig;
+	struct resource *res;
 	int rc;
 
 	cfmws = (struct acpi_cedt_cfmws *) header;
@@ -107,6 +111,23 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	for (i = 0; i < ways; i++)
 		target_map[i] = cfmws->interleave_targets[i];
 
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (!res)
+		return -ENOMEM;
+
+	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
+	if (!res->name)
+		goto err_name;
+
+	res->start = cfmws->base_hpa;
+	res->end = cfmws->base_hpa + cfmws->window_size - 1;
+	res->flags = IORESOURCE_MEM;
+
+	/* add to the local resource tracking to establish a sort order */
+	rc = insert_resource(cxl_res, res);
+	if (rc)
+		goto err_insert;
+
 	cxlsd = cxl_root_decoder_alloc(root_port, ways);
 	if (IS_ERR(cxld))
 		return 0;
@@ -115,8 +136,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
 	cxld->target_type = CXL_DECODER_EXPANDER;
 	cxld->hpa_range = (struct range) {
-		.start = cfmws->base_hpa,
-		.end = cfmws->base_hpa + cfmws->window_size - 1,
+		.start = res->start,
+		.end = res->end,
 	};
 	cxld->interleave_ways = ways;
 	cxld->interleave_granularity = ig;
@@ -137,6 +158,12 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 		cxld->hpa_range.start, cxld->hpa_range.end);
 
 	return 0;
+
+err_insert:
+	kfree(res->name);
+err_name:
+	kfree(res);
+	return -ENOMEM;
 }
 
 __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
@@ -291,9 +318,101 @@ static void cxl_acpi_lock_reset_class(void *dev)
 	device_lock_reset_class(dev);
 }
 
+static void del_cxl_resource(struct resource *res)
+{
+	kfree(res->name);
+	kfree(res);
+}
+
+static void cxl_set_public_resource(struct resource *priv, struct resource *pub)
+{
+	priv->desc = (unsigned long) pub;
+}
+
+static struct resource *cxl_get_public_resource(struct resource *priv)
+{
+	return (struct resource *) priv->desc;
+}
+
+static void remove_cxl_resources(void *data)
+{
+	struct resource *res, *next, *cxl = data;
+
+	for (res = cxl->child; res; res = next) {
+		struct resource *victim = cxl_get_public_resource(res);
+
+		next = res->sibling;
+		remove_resource(res);
+
+		if (victim) {
+			remove_resource(victim);
+			kfree(victim);
+		}
+
+		del_cxl_resource(res);
+	}
+}
+
+/**
+ * add_cxl_resources() - reflect CXL fixed memory windows in iomem_resource
+ * @cxl_res: A standalone resource tree where each CXL window is a sibling
+ *
+ * Walk each CXL window in @cxl_res and add it to iomem_resource potentially
+ * expanding its boundaries to ensure that any conflicting resources become
+ * children. If a window is expanded it may then conflict with a another window
+ * entry and require the window to be truncated or trimmed. Consider this
+ * situation:
+ *
+ * |-- "CXL Window 0" --||----- "CXL Window 1" -----|
+ * |--------------- "System RAM" -------------|
+ *
+ * ...where platform firmware has established as System RAM resource across 2
+ * windows, but has left some portion of window 1 for dynamic CXL region
+ * provisioning. In this case "Window 0" will span the entirety of the "System
+ * RAM" span, and "CXL Window 1" is truncated to the remaining tail past the end
+ * of that "System RAM" resource.
+ */
+static int add_cxl_resources(struct resource *cxl_res)
+{
+	struct resource *res, *new, *next;
+
+	for (res = cxl_res->child; res; res = next) {
+		new = kzalloc(sizeof(*new), GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+		new->name = res->name;
+		new->start = res->start;
+		new->end = res->end;
+		new->flags = IORESOURCE_MEM;
+		new->desc = IORES_DESC_CXL;
+
+		/*
+		 * Record the public resource in the private cxl_res tree for
+		 * later removal.
+		 */
+		cxl_set_public_resource(res, new);
+
+		insert_resource_expand_to_fit(&iomem_resource, new);
+
+		next = res->sibling;
+		while (next && resource_overlaps(new, next)) {
+			if (resource_contains(new, next)) {
+				struct resource *_next = next->sibling;
+
+				remove_resource(next);
+				del_cxl_resource(next);
+				next = _next;
+			} else
+				next->start = new->end + 1;
+		}
+	}
+	return 0;
+}
+
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
 	int rc;
+	struct resource *cxl_res;
 	struct cxl_port *root_port;
 	struct device *host = &pdev->dev;
 	struct acpi_device *adev = ACPI_COMPANION(host);
@@ -305,6 +424,14 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	cxl_res = devm_kzalloc(host, sizeof(*cxl_res), GFP_KERNEL);
+	if (!cxl_res)
+		return -ENOMEM;
+	cxl_res->name = "CXL mem";
+	cxl_res->start = 0;
+	cxl_res->end = -1;
+	cxl_res->flags = IORESOURCE_MEM;
+
 	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
 	if (IS_ERR(root_port))
 		return PTR_ERR(root_port);
@@ -315,11 +442,22 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	if (rc < 0)
 		return rc;
 
+	rc = devm_add_action_or_reset(host, remove_cxl_resources, cxl_res);
+	if (rc)
+		return rc;
+
 	ctx = (struct cxl_cfmws_context) {
 		.dev = host,
 		.root_port = root_port,
+		.cxl_res = cxl_res,
 	};
-	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, cxl_parse_cfmws, &ctx);
+	rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, cxl_parse_cfmws, &ctx);
+	if (rc < 0)
+		return -ENXIO;
+
+	rc = add_cxl_resources(cxl_res);
+	if (rc)
+		return rc;
 
 	/*
 	 * Root level scanned with host-bridge as dports, now scan host-bridges
diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index ec5f71f7135b..79d1ad6d6275 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -141,6 +141,7 @@ enum {
 	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
 	IORES_DESC_RESERVED			= 7,
 	IORES_DESC_SOFT_RESERVED		= 8,
+	IORES_DESC_CXL				= 9,
 };
 
 /*
diff --git a/kernel/resource.c b/kernel/resource.c
index 34eaee179689..53a534db350e 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -891,6 +891,13 @@ void insert_resource_expand_to_fit(struct resource *root, struct resource *new)
 	}
 	write_unlock(&resource_lock);
 }
+/*
+ * Not for general consumption, only early boot memory map parsing, PCI
+ * resource discovery, and late discovery of CXL resources are expected
+ * to use this interface. The former are built-in and only the latter,
+ * CXL, is a module.
+ */
+EXPORT_SYMBOL_NS_GPL(insert_resource_expand_to_fit, CXL);
 
 /**
  * remove_resource - Remove a resource in the resource tree

