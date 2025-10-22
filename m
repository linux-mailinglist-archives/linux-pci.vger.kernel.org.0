Return-Path: <linux-pci+bounces-38977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DAEBFB440
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 11:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA94434381E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 09:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA714321F43;
	Wed, 22 Oct 2025 09:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UoPOWqdB"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70375321F20;
	Wed, 22 Oct 2025 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127097; cv=none; b=MohGABuFmEV2Rvpu+NRjB7o3EzpHfCWFbGc1GGfoKQMu1YLU9hcgWsfdlGz1resPqSlOK0USMgC0khxq0f7Vc4Z/kQV9IIQpZQyplFUpsmJU+kCIS8aaMeLugofS3DE3aqwu0mGUEaJOwq/f8jzIzVF8oF2//MmmM/atkFpwlv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127097; c=relaxed/simple;
	bh=gtYjiNFtVt8U5a7O4szHCSUSWECRKX71byGeiRWlB80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aqvk5jT7op0K8pl+jT7bIyefMlX9EVKQ5kcydMzIkAs/JWrQHOHfx6OuJTYrUdmyOF/1oVGcBe+Cl+Lxw7p1rKP66IsiG6ndKjw+qY3zI5WL/jXXmEy+zBY3i3LCxv63iVPeCU66ovrVJt/coD9PwlHQNN3sKr7e9vPorSF4NU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=UoPOWqdB; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59M9vks71376573;
	Wed, 22 Oct 2025 04:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1761127066;
	bh=2nZIhLUJnaxN4ORe7PVQWsIjKw9srIsJK8ggW0ZR304=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=UoPOWqdB7sqfS6fnuIyWWlS5G7zRXF93fUQd5LWwGdTmTSOQZCg4aPyoQ3Le9DBy9
	 5jccxVyrm/pHxK6On6mWdSDYWVpBOjdDLSbl94Gf1pPoxC98QowAbJKPa0Trn8DzA6
	 sX87h/sPHTWtpMfeUbJzlsEB9IbIU0fx/ZtUpE1U=
Received: from DLEE202.ent.ti.com (dlee202.ent.ti.com [157.170.170.77])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59M9vkmK1511763
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Oct 2025 04:57:46 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 04:57:45 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 22 Oct 2025 04:57:45 -0500
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59M9vFcZ1029418;
	Wed, 22 Oct 2025 04:57:40 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <quic_wenbyao@quicinc.com>, <inochiama@gmail.com>,
        <mayank.rana@oss.qualcomm.com>, <thippeswamy.havalige@amd.com>,
        <shradha.t@samsung.com>, <cassel@kernel.org>, <kishon@kernel.org>,
        <sergio.paracuellos@gmail.com>, <18255117159@163.com>,
        <rongqianfeng@vivo.com>, <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v4 4/4] PCI: keystone: Add support to build as a loadable module
Date: Wed, 22 Oct 2025 15:27:12 +0530
Message-ID: <20251022095724.997218-5-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022095724.997218-1-s-vadapalli@ti.com>
References: <20251022095724.997218-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The 'pci-keystone.c' driver is the application/glue/wrapper driver for the
Designware PCIe Controllers on TI SoCs. Now that all of the helper APIs
that the 'pci-keystone.c' driver depends upon have been exported for use,
enable support to build the driver as a loadable module.

Additionally, the functions marked by the '__init' keyword may be invoked:
a) After a probe deferral
OR
b) During a delayed probe - Delay attributed to driver being built as a
   loadable module

In both of the cases mentioned above, the '__init' memory will be freed
before the functions are invoked. This results in an exception of the form:

	Unable to handle kernel paging request at virtual address ...
	Mem abort info:
	...
	pc : ks_pcie_host_init+0x0/0x540
	lr : dw_pcie_host_init+0x170/0x498
	...
	ks_pcie_host_init+0x0/0x540 (P)
	ks_pcie_probe+0x728/0x84c
	platform_probe+0x5c/0x98
	really_probe+0xbc/0x29c
	__driver_probe_device+0x78/0x12c
	driver_probe_device+0xd8/0x15c
	...

To address this, introduce a new function namely 'ks_pcie_init()' to
register the 'fault handler' while removing the '__init' keyword from
existing functions.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

v3:
https://lore.kernel.org/r/20250922071222.2814937-5-s-vadapalli@ti.com/
Changes since v3:
- Rebased patch on 6.18-rc1 tag of Mainline Linux.
- The '__init' keyword has been removed from functions to avoid triggering
  an exception due to '__init' memory being freed before functions are invoked.
  This is the equivalent of:
  https://lore.kernel.org/r/20250912100802.3136121-3-s-vadapalli@ti.com/
  while addressing Bjorn's feedback at:
  https://lore.kernel.org/r/20251002143627.GA267439@bhelgaas/
  by introducing 'ks_pcie_init()' function specifically for registering the
  fault handler while the rest of the driver remains the same.

Regards,
Siddharth.

 drivers/pci/controller/dwc/Kconfig        |  6 ++--
 drivers/pci/controller/dwc/pci-keystone.c | 36 +++++++++++++++--------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 349d4657393c..561a7266e21b 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -483,10 +483,10 @@ config PCI_DRA7XX_EP
 	  This uses the DesignWare core.
 
 config PCI_KEYSTONE
-	bool
+	tristate
 
 config PCI_KEYSTONE_HOST
-	bool "TI Keystone PCIe controller (host mode)"
+	tristate "TI Keystone PCIe controller (host mode)"
 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_MSI
 	select PCIE_DW_HOST
@@ -498,7 +498,7 @@ config PCI_KEYSTONE_HOST
 	  DesignWare core functions to implement the driver.
 
 config PCI_KEYSTONE_EP
-	bool "TI Keystone PCIe controller (endpoint mode)"
+	tristate "TI Keystone PCIe controller (endpoint mode)"
 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 25b8193ffbcf..8e53822a903f 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
+#include <linux/module.h>
 #include <linux/msi.h>
 #include <linux/of.h>
 #include <linux/of_irq.h>
@@ -799,7 +800,7 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 }
 #endif
 
-static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
+static int ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 {
 	int ret;
 	unsigned int id;
@@ -831,7 +832,7 @@ static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 	return 0;
 }
 
-static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
+static int ks_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
@@ -861,15 +862,6 @@ static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret < 0)
 		return ret;
 
-#ifdef CONFIG_ARM
-	/*
-	 * PCIe access errors that result into OCP errors are caught by ARM as
-	 * "External aborts"
-	 */
-	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
-			"Asynchronous external abort");
-#endif
-
 	return 0;
 }
 
@@ -1134,6 +1126,7 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(of, ks_pcie_of_match);
 
 static int ks_pcie_probe(struct platform_device *pdev)
 {
@@ -1381,4 +1374,23 @@ static struct platform_driver ks_pcie_driver = {
 		.of_match_table = ks_pcie_of_match,
 	},
 };
-builtin_platform_driver(ks_pcie_driver);
+
+static int __init ks_pcie_init(void)
+{
+#ifdef CONFIG_ARM
+	/*
+	 * PCIe access errors that result into OCP errors are caught by ARM as
+	 * "External aborts"
+	 */
+	if (of_find_matching_node(NULL, ks_pcie_of_match))
+		hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
+				"Asynchronous external abort");
+#endif
+
+	return platform_driver_register(&ks_pcie_driver);
+}
+device_initcall(ks_pcie_init);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PCIe host controller driver for Texas Instruments Keystone SoCs");
+MODULE_AUTHOR("Murali Karicheri <m-karicheri2@ti.com>");
-- 
2.51.0


