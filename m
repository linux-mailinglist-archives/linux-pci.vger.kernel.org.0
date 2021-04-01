Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D57351A07
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbhDAR5l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 13:57:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:34705 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236369AbhDARyR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Apr 2021 13:54:17 -0400
IronPort-SDR: UnMUne0xLMr5lhy0REfGPXdAlaLJmBC/IZ7bJjlQ5e8V21YHdTj6vPK0Y/qdjT0UlbxbJJV7PI
 ccFKJyU5Zagg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="179387826"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="179387826"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:31:26 -0700
IronPort-SDR: wa6hs9oGtoxrHuvyQg19fYNaeBrJU6JaiVXyUtqlV3gT9q4lxonpLVTVr0CtnWZqLbk9E8NpZ9
 zMmOBtKt+aDw==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="412711168"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:31:26 -0700
Subject: [PATCH v2 8/8] cxl/acpi: Add module parameters to stand in for ACPI
 tables
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ben.widawsky@intel.com,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Apr 2021 07:31:26 -0700
Message-ID: <161728748604.2474040.9352867415899369103.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161728744224.2474040.12854720917440712854.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[debug / to-be-replaced / not-for-upstream]

Given ACPICA support is needed before drivers can integrate ACPI
functionality add some module parameters as proxies.
---
 drivers/cxl/acpi.c |   81 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index bc2a35ae880b..2a48a728f3e0 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -4,10 +4,84 @@
 #include <linux/module.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/range.h>
 #include <linux/acpi.h>
 #include <linux/pci.h>
 #include "cxl.h"
 
+/*
+ * TODO: Replace all of the below module parameters with ACPI CXL
+ * resource descriptions once ACPICA makes them available.
+ */
+static unsigned long chbcr[4];
+module_param_named(chbcr0, chbcr[0], ulong, 0400);
+module_param_named(chbcr1, chbcr[1], ulong, 0400);
+module_param_named(chbcr2, chbcr[2], ulong, 0400);
+module_param_named(chbcr3, chbcr[3], ulong, 0400);
+
+/* TODO: cross-bridge interleave */
+static struct cxl_address_space cxl_space[] = {
+	[0] = { .range = { 0, -1 }, .targets = 0x1, },
+	[1] = { .range = { 0, -1 }, .targets = 0x1, },
+	[2] = { .range = { 0, -1 }, .targets = 0x1, },
+	[3] = { .range = { 0, -1 }, .targets = 0x1, },
+};
+
+static int set_range(const char *val, const struct kernel_param *kp)
+{
+	unsigned long long size, base;
+	struct cxl_address_space *space;
+	unsigned long flags;
+	char *p;
+	int rc;
+
+	size = memparse(val, &p);
+	if (*p != '@')
+		return -EINVAL;
+
+	base = memparse(p + 1, &p);
+	if (*p != ':')
+		return -EINVAL;
+
+	rc = kstrtoul(p + 1, 0, &flags);
+	if (rc)
+		return rc;
+	if (!flags || flags > CXL_ADDRSPACE_MASK)
+		return rc;
+
+	space = kp->arg;
+	*space = (struct cxl_address_space) {
+		.range = {
+			.start = base,
+			.end = base + size - 1,
+		},
+		.flags = flags,
+	};
+
+	return 0;
+}
+
+static int get_range(char *buf, const struct kernel_param *kp)
+{
+	struct cxl_address_space *space = kp->arg;
+
+	if (!range_len(&space->range))
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%#llx@%#llx :%s%s%s%s\n",
+			  (unsigned long long)range_len(&space->range),
+			  (unsigned long long)space->range.start,
+			  space->flags & CXL_ADDRSPACE_RAM ? " ram" : "",
+			  space->flags & CXL_ADDRSPACE_PMEM ? " pmem" : "",
+			  space->flags & CXL_ADDRSPACE_TYPE2 ? " type2" : "",
+			  space->flags & CXL_ADDRSPACE_TYPE3 ? " type3" : "");
+}
+
+module_param_call(range0, set_range, get_range, &cxl_space[0], 0400);
+module_param_call(range1, set_range, get_range, &cxl_space[1], 0400);
+module_param_call(range2, set_range, get_range, &cxl_space[2], 0400);
+module_param_call(range3, set_range, get_range, &cxl_space[3], 0400);
+
 static int match_ACPI0016(struct device *dev, const void *host)
 {
 	struct acpi_device *adev = to_acpi_device(dev);
@@ -67,13 +141,16 @@ static int cxl_acpi_register_ports(struct device *dev, struct acpi_device *root,
 				   struct cxl_port *port, int idx)
 {
 	struct acpi_pci_root *pci_root = acpi_pci_find_root(root->handle);
+	resource_size_t chbcr_base = ~0ULL;
 	struct cxl_walk_context ctx;
 
 	if (!pci_root)
 		return -ENXIO;
 
 	/* TODO: fold in CEDT.CHBS retrieval */
-	port = devm_cxl_add_port(dev, port, &root->dev, idx, ~0ULL);
+	if (idx < ARRAY_SIZE(chbcr))
+		chbcr_base = chbcr[idx];
+	port = devm_cxl_add_port(dev, port, &root->dev, idx, chbcr_base);
 	if (IS_ERR(port))
 		return PTR_ERR(port);
 	dev_dbg(dev, "%s: register: %s\n", dev_name(&root->dev),
@@ -99,7 +176,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	struct cxl_root *cxl_root;
 	int rc, i = 0;
 
-	cxl_root = devm_cxl_add_root(dev, NULL, 0);
+	cxl_root = devm_cxl_add_root(dev, cxl_space, ARRAY_SIZE(cxl_space));
 	if (IS_ERR(cxl_root))
 		return PTR_ERR(cxl_root);
 	dev_dbg(dev, "register: %s\n", dev_name(&cxl_root->port.dev));

