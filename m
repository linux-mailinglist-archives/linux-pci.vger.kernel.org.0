Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592F34976B9
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbiAXAcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:32:02 -0500
Received: from mga04.intel.com ([192.55.52.120]:42139 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240630AbiAXAcC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984322; x=1674520322;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kp9uk5c4GYS1zV8Q6+FmnuOJN0Vv5kVNinHqiy3TRc0=;
  b=G6GonUeEg0vJNNrT4upL/RH+8i7VC3BskUVoK4eSVNEnSp4PpoOyTK5l
   e9OtNORhsHFB04LXRKygp8tBZKQCmQdm9EJ3ykCBPML52S/OLTgVMnwTJ
   QPTd0YIWBhaQVlvJQRHLjcuhv9IOxsevRoUeYys6G7HHzdByyz8gULWti
   62ZAt1UZHLDNn0U1nYTtl6owAQ43rNktusHhkwjFe6glEuFQSrblXTaSR
   5UJf9ZSjIys8V6kuMySGpltCnDH92PZreYaNwkf6T3qyAlYhJPs1l3MjN
   vzq9urux+8WC12HPfFlLszYZxzVQqrdtQzhQeaTo6MCi3xeDJxZEkOTCj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244766809"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244766809"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:32:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="534000340"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:32:01 -0800
Subject: [PATCH v3 38/40] tools/testing/cxl: Mock one level of switches
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:32:01 -0800
Message-ID: <164298432189.3018233.13142151550113000967.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CXL port enumeration process adds intermediate CXL ports that are
discovered between "root" CXL ports enumerated by 'cxl_acpi' and
endpoints enumerated by 'cxl_pci + cxl_mem'. Test the dynamic discovery
of intermediate switch ports in a CXL topology.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/cxl/test/cxl.c |  138 ++++++++++++++++++++++++++++++------------
 1 file changed, 97 insertions(+), 41 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 7e4a0b1ee436..ea88fabc3198 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -11,14 +11,21 @@
 #include <cxlmem.h>
 #include "mock.h"
 
-#define NR_CXL_HOST_BRIDGES 4
+#define NR_CXL_HOST_BRIDGES 2
 #define NR_CXL_ROOT_PORTS 2
+#define NR_CXL_SWITCH_PORTS 2
 
 static struct platform_device *cxl_acpi;
 static struct platform_device *cxl_host_bridge[NR_CXL_HOST_BRIDGES];
 static struct platform_device
 	*cxl_root_port[NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS];
-struct platform_device *cxl_mem[NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS];
+static struct platform_device
+	*cxl_switch_uport[NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS];
+static struct platform_device
+	*cxl_switch_dport[NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS *
+			  NR_CXL_SWITCH_PORTS];
+struct platform_device
+	*cxl_mem[NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS * NR_CXL_SWITCH_PORTS];
 
 static struct acpi_device acpi0017_mock;
 static struct acpi_device host_bridge[NR_CXL_HOST_BRIDGES] = {
@@ -28,12 +35,6 @@ static struct acpi_device host_bridge[NR_CXL_HOST_BRIDGES] = {
 	[1] = {
 		.handle = &host_bridge[1],
 	},
-	[2] = {
-		.handle = &host_bridge[2],
-	},
-	[3] = {
-		.handle = &host_bridge[3],
-	},
 };
 
 static bool is_mock_dev(struct device *dev)
@@ -71,7 +72,7 @@ static struct {
 	} cfmws0;
 	struct {
 		struct acpi_cedt_cfmws cfmws;
-		u32 target[4];
+		u32 target[2];
 	} cfmws1;
 	struct {
 		struct acpi_cedt_cfmws cfmws;
@@ -79,7 +80,7 @@ static struct {
 	} cfmws2;
 	struct {
 		struct acpi_cedt_cfmws cfmws;
-		u32 target[4];
+		u32 target[2];
 	} cfmws3;
 } __packed mock_cedt = {
 	.cedt = {
@@ -105,22 +106,6 @@ static struct {
 		.uid = 1,
 		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
 	},
-	.chbs[2] = {
-		.header = {
-			.type = ACPI_CEDT_TYPE_CHBS,
-			.length = sizeof(mock_cedt.chbs[0]),
-		},
-		.uid = 2,
-		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
-	},
-	.chbs[3] = {
-		.header = {
-			.type = ACPI_CEDT_TYPE_CHBS,
-			.length = sizeof(mock_cedt.chbs[0]),
-		},
-		.uid = 3,
-		.cxl_version = ACPI_CEDT_CHBS_VERSION_CXL20,
-	},
 	.cfmws0 = {
 		.cfmws = {
 			.header = {
@@ -142,14 +127,14 @@ static struct {
 				.type = ACPI_CEDT_TYPE_CFMWS,
 				.length = sizeof(mock_cedt.cfmws1),
 			},
-			.interleave_ways = 2,
+			.interleave_ways = 1,
 			.granularity = 4,
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
 					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
 			.qtg_id = 1,
-			.window_size = SZ_256M * 4,
+			.window_size = SZ_256M * 2,
 		},
-		.target = { 0, 1, 2, 3 },
+		.target = { 0, 1, },
 	},
 	.cfmws2 = {
 		.cfmws = {
@@ -172,14 +157,14 @@ static struct {
 				.type = ACPI_CEDT_TYPE_CFMWS,
 				.length = sizeof(mock_cedt.cfmws3),
 			},
-			.interleave_ways = 2,
+			.interleave_ways = 1,
 			.granularity = 4,
 			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
 					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
 			.qtg_id = 3,
-			.window_size = SZ_256M * 4,
+			.window_size = SZ_256M * 2,
 		},
-		.target = { 0, 1, 2, 3 },
+		.target = { 0, 1, },
 	},
 };
 
@@ -332,6 +317,17 @@ static bool is_mock_port(struct device *dev)
 		if (dev == &cxl_root_port[i]->dev)
 			return true;
 
+	for (i = 0; i < ARRAY_SIZE(cxl_switch_uport); i++)
+		if (dev == &cxl_switch_uport[i]->dev)
+			return true;
+
+	for (i = 0; i < ARRAY_SIZE(cxl_switch_dport); i++)
+		if (dev == &cxl_switch_dport[i]->dev)
+			return true;
+
+	if (is_cxl_memdev(dev))
+		return is_mock_dev(dev->parent);
+
 	return false;
 }
 
@@ -372,12 +368,6 @@ static struct acpi_pci_root mock_pci_root[NR_CXL_HOST_BRIDGES] = {
 	[1] = {
 		.bus = &mock_pci_bus[1],
 	},
-	[2] = {
-		.bus = &mock_pci_bus[2],
-	},
-	[3] = {
-		.bus = &mock_pci_bus[3],
-	},
 };
 
 static bool is_mock_bus(struct pci_bus *bus)
@@ -446,6 +436,26 @@ static int mock_cxl_port_enumerate_dports(struct cxl_port *port)
 			dev_name(&pdev->dev));
 	}
 
+	for (i = 0; i < ARRAY_SIZE(cxl_switch_dport); i++) {
+		struct platform_device *pdev = cxl_switch_dport[i];
+		struct cxl_dport *dport;
+
+		if (pdev->dev.parent != port->uport)
+			continue;
+
+		dport = devm_cxl_add_dport(port, &pdev->dev, pdev->id,
+					   CXL_RESOURCE_NONE);
+
+		if (IS_ERR(dport)) {
+			dev_err(dev, "failed to add dport: %s (%ld)\n",
+				dev_name(&pdev->dev), PTR_ERR(dport));
+			return PTR_ERR(dport);
+		}
+
+		dev_dbg(dev, "add dport%d: %s\n", pdev->id,
+			dev_name(&pdev->dev));
+	}
+
 	return 0;
 }
 
@@ -574,15 +584,51 @@ static __init int cxl_test_init(void)
 		cxl_root_port[i] = pdev;
 	}
 
-	BUILD_BUG_ON(ARRAY_SIZE(cxl_mem) != ARRAY_SIZE(cxl_root_port));
+	BUILD_BUG_ON(ARRAY_SIZE(cxl_switch_uport) != ARRAY_SIZE(cxl_root_port));
+	for (i = 0; i < ARRAY_SIZE(cxl_switch_uport); i++) {
+		struct platform_device *root_port = cxl_root_port[i];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_switch_uport", i);
+		if (!pdev)
+			goto err_port;
+		pdev->dev.parent = &root_port->dev;
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_uport;
+		}
+		cxl_switch_uport[i] = pdev;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cxl_switch_dport); i++) {
+		struct platform_device *uport =
+			cxl_switch_uport[i % ARRAY_SIZE(cxl_switch_uport)];
+		struct platform_device *pdev;
+
+		pdev = platform_device_alloc("cxl_switch_dport", i);
+		if (!pdev)
+			goto err_port;
+		pdev->dev.parent = &uport->dev;
+
+		rc = platform_device_add(pdev);
+		if (rc) {
+			platform_device_put(pdev);
+			goto err_dport;
+		}
+		cxl_switch_dport[i] = pdev;
+	}
+
+	BUILD_BUG_ON(ARRAY_SIZE(cxl_mem) != ARRAY_SIZE(cxl_switch_dport));
 	for (i = 0; i < ARRAY_SIZE(cxl_mem); i++) {
-		struct platform_device *port = cxl_root_port[i];
+		struct platform_device *dport = cxl_switch_dport[i];
 		struct platform_device *pdev;
 
 		pdev = alloc_memdev(i);
 		if (!pdev)
 			goto err_mem;
-		pdev->dev.parent = &port->dev;
+		pdev->dev.parent = &dport->dev;
 		set_dev_node(&pdev->dev, i % 2);
 
 		rc = platform_device_add(pdev);
@@ -611,6 +657,12 @@ static __init int cxl_test_init(void)
 err_mem:
 	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_mem[i]);
+err_dport:
+	for (i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_switch_dport[i]);
+err_uport:
+	for (i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_switch_uport[i]);
 err_port:
 	for (i = ARRAY_SIZE(cxl_root_port) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_root_port[i]);
@@ -633,6 +685,10 @@ static __exit void cxl_test_exit(void)
 	platform_device_unregister(cxl_acpi);
 	for (i = ARRAY_SIZE(cxl_mem) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_mem[i]);
+	for (i = ARRAY_SIZE(cxl_switch_dport) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_switch_dport[i]);
+	for (i = ARRAY_SIZE(cxl_switch_uport) - 1; i >= 0; i--)
+		platform_device_unregister(cxl_switch_uport[i]);
 	for (i = ARRAY_SIZE(cxl_root_port) - 1; i >= 0; i--)
 		platform_device_unregister(cxl_root_port[i]);
 	for (i = ARRAY_SIZE(cxl_host_bridge) - 1; i >= 0; i--)

