Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E349609CAE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Oct 2022 10:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiJXI3Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Oct 2022 04:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiJXI21 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 24 Oct 2022 04:28:27 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC88D65255;
        Mon, 24 Oct 2022 01:28:11 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2CCB2220EA8;
        Mon, 24 Oct 2022 10:27:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B4FE1220EAD;
        Mon, 24 Oct 2022 10:27:19 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5609C1820F58;
        Mon, 24 Oct 2022 16:27:18 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [RESEND v4 11/14] PCI: imx6: Add i.MX PCIe EP mode support
Date:   Mon, 24 Oct 2022 16:06:40 +0800
Message-Id: <1666598803-1912-12-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1666598803-1912-1-git-send-email-hongxing.zhu@nxp.com>
References: <1666598803-1912-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

i.MX PCIe is one dual mode PCIe controller.

Add i.MX PCIe EP mode support here, and split the PCIe modes to the Root
Complex mode and Endpoint mode.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/Kconfig    |  23 ++++-
 drivers/pci/controller/dwc/pci-imx6.c | 128 +++++++++++++++++++++++---
 2 files changed, 137 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 62ce3abf0f19..83580c92d216 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -92,10 +92,31 @@ config PCI_EXYNOS
 	  functions to implement the driver.
 
 config PCI_IMX6
-	bool "Freescale i.MX6/7/8 PCIe controller"
+	bool
+
+config PCI_IMX6_HOST
+	bool "Freescale i.MX6/7/8 PCIe controller host mode"
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
+	select PCI_IMX6
+	help
+	  Enables support for the PCIe controller in the i.MX SoCs to
+	  work in Root Complex mode. The PCI controller on i.MX is based
+	  on DesignWare hardware and therefore the driver re-uses the
+	  DesignWare core functions to implement the driver.
+
+config PCI_IMX6_EP
+	bool "Freescale i.MX6/7/8 PCIe controller endpoint mode"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	select PCI_IMX6
+	help
+	  Enables support for the PCIe controller in the i.MX SoCs to
+	  work in endpoint mode. The PCI controller on i.MX is based
+	  on DesignWare hardware and therefore the driver re-uses the
+	  DesignWare core functions to implement the driver.
 
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2616585ca5f8..31467a31128a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -60,6 +60,7 @@ enum imx6_pcie_variants {
 
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
+	enum dw_pcie_device_mode mode;
 	u32 flags;
 	int dbi_length;
 	const char *gpr;
@@ -159,17 +160,20 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 {
-	unsigned int mask, val;
+	unsigned int mask, val, mode;
+
+	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE)
+		mode = PCI_EXP_TYPE_ENDPOINT;
+	else
+		mode = PCI_EXP_TYPE_ROOT_PORT;
 
 	if (imx6_pcie->drvdata->variant == IMX8MQ &&
 	    imx6_pcie->controller_id == 1) {
 		mask = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE;
-		val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
-				  PCI_EXP_TYPE_ROOT_PORT);
+		val  = FIELD_PREP(IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE, mode);
 	} else {
 		mask = IMX6Q_GPR12_DEVICE_TYPE;
-		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE,
-				  PCI_EXP_TYPE_ROOT_PORT);
+		val  = FIELD_PREP(IMX6Q_GPR12_DEVICE_TYPE, mode);
 	}
 
 	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, mask, val);
@@ -1002,8 +1006,99 @@ static const struct dw_pcie_host_ops imx6_pcie_host_ops = {
 
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx6_pcie_start_link,
+	.stop_link = imx6_pcie_stop_link,
+};
+
+static void imx6_pcie_ep_init(struct dw_pcie_ep *ep)
+{
+	enum pci_barno bar;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	for (bar = BAR_0; bar <= BAR_5; bar++)
+		dw_pcie_ep_reset_bar(pci, bar);
+}
+
+static int imx6_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+				  enum pci_epc_irq_type type,
+				  u16 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		return dw_pcie_ep_raise_legacy_irq(ep, func_no);
+	case PCI_EPC_IRQ_MSI:
+		return dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
+	case PCI_EPC_IRQ_MSIX:
+		return dw_pcie_ep_raise_msix_irq(ep, func_no, interrupt_num);
+	default:
+		dev_err(pci->dev, "UNKNOWN IRQ type\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct pci_epc_features imx8m_pcie_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = false,
+	.reserved_bar = 1 << BAR_1 | 1 << BAR_3,
+	.align = SZ_64K,
+};
+
+static const struct pci_epc_features*
+imx6_pcie_ep_get_features(struct dw_pcie_ep *ep)
+{
+	return &imx8m_pcie_epc_features;
+}
+
+static const struct dw_pcie_ep_ops pcie_ep_ops = {
+	.ep_init = imx6_pcie_ep_init,
+	.raise_irq = imx6_pcie_ep_raise_irq,
+	.get_features = imx6_pcie_ep_get_features,
 };
 
+static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
+			   struct platform_device *pdev)
+{
+	int ret;
+	unsigned int pcie_dbi2_offset;
+	struct dw_pcie_ep *ep;
+	struct resource *res;
+	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie_rp *pp = &pci->pp;
+	struct device *dev = pci->dev;
+
+	imx6_pcie_host_init(pp);
+	ep = &pci->ep;
+	ep->ops = &pcie_ep_ops;
+
+	switch (imx6_pcie->drvdata->variant) {
+	default:
+		pcie_dbi2_offset = SZ_4K;
+		break;
+	}
+	pci->dbi_base2 = pci->dbi_base + pcie_dbi2_offset;
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
+	if (!res)
+		return -EINVAL;
+
+	ep->phys_base = res->start;
+	ep->addr_size = resource_size(res);
+	ep->page_size = SZ_64K;
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(dev, "failed to initialize endpoint\n");
+		return ret;
+	}
+	/* Start LTSSM. */
+	imx6_pcie_ltssm_enable(dev);
+
+	return 0;
+}
+
 static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 {
 	struct device *dev = imx6_pcie->pci->dev;
@@ -1278,15 +1373,22 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = dw_pcie_host_init(&pci->pp);
-	if (ret < 0)
-		return ret;
+	if (imx6_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
+		ret = imx6_add_pcie_ep(imx6_pcie, pdev);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = dw_pcie_host_init(&pci->pp);
+		if (ret < 0)
+			return ret;
+
+		if (pci_msi_enabled()) {
+			u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
 
-	if (pci_msi_enabled()) {
-		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_MSI);
-		val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
-		val |= PCI_MSI_FLAGS_ENABLE;
-		dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
+			val = dw_pcie_readw_dbi(pci, offset + PCI_MSI_FLAGS);
+			val |= PCI_MSI_FLAGS_ENABLE;
+			dw_pcie_writew_dbi(pci, offset + PCI_MSI_FLAGS, val);
+		}
 	}
 
 	return 0;
-- 
2.25.1

