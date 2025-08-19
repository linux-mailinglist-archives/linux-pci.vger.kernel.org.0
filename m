Return-Path: <linux-pci+bounces-34277-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 117D7B2BE9A
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 12:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DB0188775F
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 10:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54514322751;
	Tue, 19 Aug 2025 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Yo6KG84e"
X-Original-To: linux-pci@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5CC322750;
	Tue, 19 Aug 2025 10:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598431; cv=none; b=EjXjxP0f8SCTSSMO6U4om97cjtlChnkmo/O3gwTILszUCKz4FGcpjnJ+Upo2qhz3AZ8aZ2DEIIFMHpGqef69sk11fL7JqExX9wyrKjLABPycbiCXpvezsRYPz2Eo/RYyJzZBmPktAXanhvp2WcFY7eyXLTkIVItfrQtnadrfm1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598431; c=relaxed/simple;
	bh=GgUtjlU7GKlKGSsT2tffpJz8lgcZnQ7hy+6eE55FUdA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pilG+8qNFRknG9LsB0IGbP/7dnezrPcml2Lnw38eF8UDsMjVs6eUtQZOjjjOlD/OzUDoRbGuPhPhqq6O0P+/qKHFqFfH/Z6c3cq4yTt94k3JpaMyux6WhkL4hwT3qD2HNy7d3n5ZyEOeeU7iLjqpdUlcfLyw9qCR6MA3LxtD3wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Yo6KG84e; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57JADf2T3378694;
	Tue, 19 Aug 2025 05:13:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755598421;
	bh=2O584Z+j5V3by0uprEGUNvPPpesRxlUyFD25VkAn+2E=;
	h=From:To:CC:Subject:Date;
	b=Yo6KG84eSFUPdT+6fxC0jzaQcoXnLoNJu/T0j3Yan7a6WoLyn5/0XwtdT+Tx4C8/q
	 PYH0IBBK7LAY6+Zte+2f5U0BGoJidpjiuZb9ygUKx6EQy4t22nv1l5nXxxpGysTcu1
	 8fKhSawMleihT9IrZdb+IHel8b0HVOlXVu4ObZnc=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57JADfig516954
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 19 Aug 2025 05:13:41 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 19
 Aug 2025 05:13:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 19 Aug 2025 05:13:41 -0500
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.231.84])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57JADaTT2840602;
	Tue, 19 Aug 2025 05:13:37 -0500
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <lpieralisi@kernel.org>, <kwilczynski@kernel.org>, <mani@kernel.org>,
        <robh@kernel.org>, <bhelgaas@google.com>, <kishon@kernel.org>,
        <vigneshr@ti.com>
CC: <stable@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH v2] PCI: j721e: Fix programming sequence of "strap" settings
Date: Tue, 19 Aug 2025 15:43:35 +0530
Message-ID: <20250819101336.292013-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The Cadence PCIe Controller integrated in the TI K3 SoCs supports both
Root-Complex and Endpoint modes of operation. The Glue Layer allows
"strapping" the mode of operation of the Controller, the Link Speed
and the Link Width. This is enabled by programming the "PCIEn_CTRL"
register (n corresponds to the PCIe instance) within the CTRL_MMR
memory-mapped register space.

In the PCIe Controller's register space, the same set of registers
that correspond to the Root-Port configuration space when the
Controller is configured for Root-Complex mode of operation, also
correspond to the Physical Function configuration space when the
Controller is configured for Endpoint mode of operation. As a result,
the "reset-value" of these set of registers _should_ vary depending
on the selected mode of operation. This is the expected behavior
according to the description of the registers and their reset values
in the Technical Reference Manual for the SoCs.

However, it is observed that the "reset-value" seen in practice
do not match the description. To be precise, when the Controller
is configured for Root-Complex mode of operation, the "reset-value"
of the Root-Port configuration space reflect the "reset-value"
corresponding to the Physical Function configuration space.
This can be attributed to the fact that the "strap" settings play
a role in "switching" the "reset-value" of the registers to match
the expected values as determined by the selected mode of operation.
Since the "strap" settings are sampled the moment the PCIe Controller
is powered ON, the "reset-value" of the registers are setup at that
point in time. As a result, if the "strap" settings are programmed
at a later point in time, it _will not_ update the "reset-value" of
the registers. This will cause the Physical Function configuration
space to be seen when the Root-Port configuration space is accessed
after programming the PCIe Controller for Root-Complex mode of
operation.

Fix this by powering off the PCIe Controller before programming the
"strap" settings and powering it on after that. This will ensure
that the "strap" settings that have been sampled convey the intended
mode of operation, thereby resulting in the "reset-value" of the
registers being accurate.

Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on commit
be48bcf004f9 Merge tag 'for-6.17-rc2-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
of Mainline Linux.

v1 of this patch is at:
https://lore.kernel.org/r/20250716102851.121742-1-s-vadapalli@ti.com/
Changes since v1:
- Rebased patch on latest Mainline Linux.

Regards,
Siddharth.

 drivers/pci/controller/cadence/pci-j721e.c | 82 ++++++++++++++--------
 1 file changed, 53 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 6c93f39d0288..d5e7cb7277dc 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 
@@ -173,10 +174,9 @@ static const struct cdns_pcie_ops j721e_pcie_ops = {
 	.link_up = j721e_pcie_link_up,
 };
 
-static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
-			       unsigned int offset)
+static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct device *dev,
+			       struct regmap *syscon, unsigned int offset)
 {
-	struct device *dev = pcie->cdns_pcie->dev;
 	u32 mask = J721E_MODE_RC;
 	u32 mode = pcie->mode;
 	u32 val = 0;
@@ -193,9 +193,9 @@ static int j721e_pcie_set_mode(struct j721e_pcie *pcie, struct regmap *syscon,
 }
 
 static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
+				     struct device *dev,
 				     struct regmap *syscon, unsigned int offset)
 {
-	struct device *dev = pcie->cdns_pcie->dev;
 	struct device_node *np = dev->of_node;
 	int link_speed;
 	u32 val = 0;
@@ -214,9 +214,9 @@ static int j721e_pcie_set_link_speed(struct j721e_pcie *pcie,
 }
 
 static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
+				     struct device *dev,
 				     struct regmap *syscon, unsigned int offset)
 {
-	struct device *dev = pcie->cdns_pcie->dev;
 	u32 lanes = pcie->num_lanes;
 	u32 mask = BIT(8);
 	u32 val = 0;
@@ -234,9 +234,9 @@ static int j721e_pcie_set_lane_count(struct j721e_pcie *pcie,
 }
 
 static int j721e_enable_acspcie_refclk(struct j721e_pcie *pcie,
+				       struct device *dev,
 				       struct regmap *syscon)
 {
-	struct device *dev = pcie->cdns_pcie->dev;
 	struct device_node *node = dev->of_node;
 	u32 mask = ACSPCIE_PAD_DISABLE_MASK;
 	struct of_phandle_args args;
@@ -263,9 +263,8 @@ static int j721e_enable_acspcie_refclk(struct j721e_pcie *pcie,
 	return 0;
 }
 
-static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
+static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie, struct device *dev)
 {
-	struct device *dev = pcie->cdns_pcie->dev;
 	struct device_node *node = dev->of_node;
 	struct of_phandle_args args;
 	unsigned int offset = 0;
@@ -284,19 +283,19 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 	if (!ret)
 		offset = args.args[0];
 
-	ret = j721e_pcie_set_mode(pcie, syscon, offset);
+	ret = j721e_pcie_set_mode(pcie, dev, syscon, offset);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set pci mode\n");
 		return ret;
 	}
 
-	ret = j721e_pcie_set_link_speed(pcie, syscon, offset);
+	ret = j721e_pcie_set_link_speed(pcie, dev, syscon, offset);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set link speed\n");
 		return ret;
 	}
 
-	ret = j721e_pcie_set_lane_count(pcie, syscon, offset);
+	ret = j721e_pcie_set_lane_count(pcie, dev, syscon, offset);
 	if (ret < 0) {
 		dev_err(dev, "Failed to set num-lanes\n");
 		return ret;
@@ -308,7 +307,7 @@ static int j721e_pcie_ctrl_init(struct j721e_pcie *pcie)
 	if (!syscon)
 		return 0;
 
-	return j721e_enable_acspcie_refclk(pcie, syscon);
+	return j721e_enable_acspcie_refclk(pcie, dev, syscon);
 }
 
 static int cdns_ti_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
@@ -469,6 +468,47 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
+	pcie->mode = mode;
+
+	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
+	if (ret || num_lanes > data->max_lanes) {
+		dev_warn(dev, "num-lanes property not provided or invalid, setting num-lanes to 1\n");
+		num_lanes = 1;
+	}
+
+	pcie->num_lanes = num_lanes;
+	pcie->max_lanes = data->max_lanes;
+
+	/*
+	 * The PCIe Controller's registers have different "reset-values" depending
+	 * on the "strap" settings programmed into the Controller's Glue Layer.
+	 * This is because the same set of registers are used for representing the
+	 * Physical Function configuration space in Endpoint mode and for
+	 * representing the Root-Port configuration space in Root-Complex mode.
+	 *
+	 * The registers latch onto a "reset-value" based on the "strap" settings
+	 * sampled after the Controller is powered on. Therefore, for the
+	 * "reset-value" to be accurate, it is necessary to program the "strap"
+	 * settings when the Controller is powered off, and power on the Controller
+	 * after the "strap" settings have been programmed.
+	 *
+	 * The "strap" settings are programmed by "j721e_pcie_ctrl_init()".
+	 * Therefore, power off the Controller before invoking "j721e_pcie_ctrl_init()",
+	 * program the "strap" settings, and then power on the Controller. This ensures
+	 * that the reset values are accurate and reflect the "strap" settings.
+	 */
+	dev_pm_domain_detach(dev, true);
+
+	ret = j721e_pcie_ctrl_init(pcie, dev);
+	if (ret < 0)
+		return ret;
+
+	ret = dev_pm_domain_attach(dev, true);
+	if (ret < 0) {
+		dev_err(dev, "failed to power on device\n");
+		return ret;
+	}
+
 	switch (mode) {
 	case PCI_MODE_RC:
 		if (!IS_ENABLED(CONFIG_PCI_J721E_HOST))
@@ -510,7 +550,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		return 0;
 	}
 
-	pcie->mode = mode;
 	pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
 
 	base = devm_platform_ioremap_resource_byname(pdev, "intd_cfg");
@@ -523,15 +562,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 	pcie->user_cfg_base = base;
 
-	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
-	if (ret || num_lanes > data->max_lanes) {
-		dev_warn(dev, "num-lanes property not provided or invalid, setting num-lanes to 1\n");
-		num_lanes = 1;
-	}
-
-	pcie->num_lanes = num_lanes;
-	pcie->max_lanes = data->max_lanes;
-
 	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
 		return -EINVAL;
 
@@ -547,12 +577,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	ret = j721e_pcie_ctrl_init(pcie);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "pm_runtime_get_sync failed\n");
-		goto err_get_sync;
-	}
-
 	ret = devm_request_irq(dev, irq, j721e_pcie_link_irq_handler, 0,
 			       "j721e-pcie-link-down-irq", pcie);
 	if (ret < 0) {
@@ -680,7 +704,7 @@ static int j721e_pcie_resume_noirq(struct device *dev)
 	struct cdns_pcie *cdns_pcie = pcie->cdns_pcie;
 	int ret;
 
-	ret = j721e_pcie_ctrl_init(pcie);
+	ret = j721e_pcie_ctrl_init(pcie, dev);
 	if (ret < 0)
 		return ret;
 
-- 
2.43.0


