Return-Path: <linux-pci+bounces-35380-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA12B41F94
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 308FD1BA068C
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 12:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD593009F0;
	Wed,  3 Sep 2025 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lu8QFZOq"
X-Original-To: linux-pci@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647A3009F6;
	Wed,  3 Sep 2025 12:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756903607; cv=none; b=OyqDxE0gpEfXC6fx+zr0704PfojnOPWKYcPY2ebDGFa3T36ARsae8DqcS523fIb8kLU5gI+YNbcG4Cw4IBx8aEUUW7S6dyyVXoIBW294p5Ku4C1Vdu2qdRvR8EgwcitV9JY5nEGD2yIIEjL1uBdhtaR1lU4rw+/8ryqu1jsSlPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756903607; c=relaxed/simple;
	bh=rHdN20Z7v5RdwfYiFVdz1M2P//lEvL3AeWX2YnWW1dI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qb+YbXFkcLvhPeYazGXyWvxeFqfVGvlWP7BpR1ZgBpUYKpDT/ucC2QEuHtzWYakSY4zbHaAq2QT6VAhPpXp9qIXuALIuUBAVuYmR8gVR18qS5yRH7cTO0Y8gosVRTKhhndqSrcKZS0LY+8qP/vDWQWwQt0q/4bjFy2tjQRBE+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lu8QFZOq; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 583CkQOg2770254;
	Wed, 3 Sep 2025 07:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1756903586;
	bh=OkP7TTKiElQOLd+SowOImk0xgxSLg9GSlZ1Kn2yvf34=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lu8QFZOq0GHhlc4pg8xuXfh+rDajawczMPBhzeODcLlUGrflN8aT2q1hu+TRFuEf3
	 hpCW1t7heWchbukP3ihr753FtCrvq3QvaGv8ODZI/SMgw5pJzYNEmG89w429Vrw2bD
	 qO1np7XB/eGIrjjoR5R3ZNEQ07D1M7CimjPo7n3w=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 583CkQdW084587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 3 Sep 2025 07:46:26 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 3
 Sep 2025 07:46:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 3 Sep 2025 07:46:26 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 583Cj5wc1576150;
	Wed, 3 Sep 2025 07:46:20 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <fan.ni@samsung.com>, <quic_wenbyao@quicinc.com>,
        <namcao@linutronix.de>, <mayank.rana@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <quic_schintav@quicinc.com>,
        <shradha.t@samsung.com>, <inochiama@gmail.com>, <cassel@kernel.org>,
        <kishon@kernel.org>, <18255117159@163.com>, <rongqianfeng@vivo.com>,
        <jirislaby@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 11/11] PCI: keystone: Add support to build as a loadable module
Date: Wed, 3 Sep 2025 18:14:52 +0530
Message-ID: <20250903124505.365913-12-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250903124505.365913-1-s-vadapalli@ti.com>
References: <20250903124505.365913-1-s-vadapalli@ti.com>
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

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/pci/controller/dwc/Kconfig        |  6 ++---
 drivers/pci/controller/dwc/pci-keystone.c | 28 ++++++++++++++++++++---
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index deafc512b079..33f3dab7b385 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -458,10 +458,10 @@ config PCI_DRA7XX_EP
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
@@ -473,7 +473,7 @@ config PCI_KEYSTONE_HOST
 	  DesignWare core functions to implement the driver.
 
 config PCI_KEYSTONE_EP
-	bool "TI Keystone PCIe controller (endpoint mode)"
+	tristate "TI Keystone PCIe controller (endpoint mode)"
 	depends on ARCH_KEYSTONE || ARCH_K3 || COMPILE_TEST
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 4ed6eab0a2f0..eabe7e9ed44b 100644
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
@@ -132,6 +133,7 @@ struct keystone_pcie {
 	struct			device_node *msi_intc_np;
 	struct irq_domain	*intx_irq_domain;
 	struct device_node	*np;
+	struct gpio_desc	*reset_gpio;
 
 	/* Application register space */
 	void __iomem		*va_app_base;	/* DT 1st resource */
@@ -862,7 +864,7 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 }
 #endif
 
-static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
+static int ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 {
 	int ret;
 	unsigned int id;
@@ -906,7 +908,7 @@ static void ks_pcie_host_deinit(struct dw_pcie_rp *pp)
 		dw_pcie_free_domains(pp);
 }
 
-static int __init ks_pcie_host_init(struct dw_pcie_rp *pp)
+static int ks_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
@@ -1211,6 +1213,7 @@ static const struct of_device_id ks_pcie_of_match[] = {
 	},
 	{ },
 };
+MODULE_DEVICE_TABLE(of, ks_pcie_of_match);
 
 static int ks_pcie_probe(struct platform_device *pdev)
 {
@@ -1329,6 +1332,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "Failed to get reset GPIO\n");
 		goto err_link;
 	}
+	ks_pcie->reset_gpio = gpiod;
 
 	/* Obtain references to the PHYs */
 	for (i = 0; i < num_lanes; i++)
@@ -1440,9 +1444,23 @@ static void ks_pcie_remove(struct platform_device *pdev)
 {
 	struct keystone_pcie *ks_pcie = platform_get_drvdata(pdev);
 	struct device_link **link = ks_pcie->link;
+	struct dw_pcie *pci = ks_pcie->pci;
 	int num_lanes = ks_pcie->num_lanes;
+	const struct ks_pcie_of_data *data;
 	struct device *dev = &pdev->dev;
+	enum dw_pcie_device_mode mode;
+
+	ks_pcie_disable_error_irq(ks_pcie);
+	data = of_device_get_match_data(dev);
+	mode = data->mode;
+	if (mode == DW_PCIE_RC_TYPE) {
+		dw_pcie_host_deinit(&pci->pp);
+	} else {
+		pci_epc_deinit_notify(pci->ep.epc);
+		dw_pcie_ep_deinit(&pci->ep);
+	}
 
+	gpiod_set_value_cansleep(ks_pcie->reset_gpio, 0);
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	ks_pcie_disable_phy(ks_pcie);
@@ -1458,4 +1476,8 @@ static struct platform_driver ks_pcie_driver = {
 		.of_match_table = ks_pcie_of_match,
 	},
 };
-builtin_platform_driver(ks_pcie_driver);
+module_platform_driver(ks_pcie_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("PCIe host controller driver for Texas Instruments Keystone SoCs");
+MODULE_AUTHOR("Murali Karicheri <m-karicheri2@ti.com>");
-- 
2.43.0


