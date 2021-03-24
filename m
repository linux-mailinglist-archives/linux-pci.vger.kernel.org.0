Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784FA3483C0
	for <lists+linux-pci@lfdr.de>; Wed, 24 Mar 2021 22:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbhCXVbj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Mar 2021 17:31:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:40195 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238425AbhCXVbJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Mar 2021 17:31:09 -0400
IronPort-SDR: E0ki/7qIbGPOgdkKJH8tgBvDu5QlowOejCnL7Axz213RahWQ30xr6QiyyWnRY5K7dB+HX001Ar
 8k/ZkPEhiVCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="275915669"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="275915669"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:31:07 -0700
IronPort-SDR: UiqiTq0h9Rx3ezRrb3TUYKTsDocGhk2W+N2YAhGdc8BZ3B4ltUrKmDcpnRQEHq3U9oOFpKBcTY
 0Q+FHZS4HJCQ==
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; 
   d="scan'208";a="608245303"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 14:31:07 -0700
Subject: [PATCH 8/8] cxl/acpi: Add module parameters to stand in for ACPI
 tables
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, ben.widawsky@intel.com,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Mar 2021 14:31:07 -0700
Message-ID: <161662146724.1723715.10554067294730837889.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161662142382.1723715.5934723983022398253.stgit@dwillia2-desk3.amr.corp.intel.com>
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

