Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9715517CACF
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 03:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCGC2p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 21:28:45 -0500
Received: from inva021.nxp.com ([92.121.34.21]:48782 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgCGC2h (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 21:28:37 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5A1B7200119;
        Sat,  7 Mar 2020 03:28:35 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id CA8AD200DB8;
        Sat,  7 Mar 2020 03:28:25 +0100 (CET)
Received: from titan.ap.freescale.net (titan.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D9A4840320;
        Sat,  7 Mar 2020 10:28:14 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Zhiqiang.Hou@nxp.com, Minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        bhelgaas@google.com, robh+dt@kernel.org, shawnguo@kernel.org,
        leoyang.li@nxp.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        roy.zang@nxp.com, amurray@thegoodpenguin.co.uk,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH v5 09/11] PCI: layerscape: Add EP mode support for ls1088a and ls2088a
Date:   Sat,  7 Mar 2020 10:14:28 +0800
Message-Id: <20200307021430.36826-10-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200307021430.36826-1-xiaowei.bao@nxp.com>
References: <20200307021430.36826-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe EP mode support for ls1088a and ls2088a, there are some
difference between LS1 and LS2 platform, so refactor the code of
the EP driver.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2: 
 - This is a new patch for supporting the ls1088a and ls2088a platform.
v3:
 - Adjust the some struct assignment order in probe function.
v4:
 - No change.
v5:
 - No change.

 drivers/pci/controller/dwc/pci-layerscape-ep.c | 72 +++++++++++++++++++-------
 1 file changed, 53 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index bfab1c6..84206f2 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -20,27 +20,29 @@
 
 #define PCIE_DBI2_OFFSET		0x1000	/* DBI2 base address*/
 
-struct ls_pcie_ep {
-	struct dw_pcie		*pci;
-	struct pci_epc_features	*ls_epc;
+#define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
+
+struct ls_pcie_ep_drvdata {
+	u32				func_offset;
+	const struct dw_pcie_ep_ops	*ops;
+	const struct dw_pcie_ops	*dw_pcie_ops;
 };
 
-#define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
+struct ls_pcie_ep {
+	struct dw_pcie			*pci;
+	struct pci_epc_features		*ls_epc;
+	const struct ls_pcie_ep_drvdata *drvdata;
+};
 
 static int ls_pcie_establish_link(struct dw_pcie *pci)
 {
 	return 0;
 }
 
-static const struct dw_pcie_ops ls_pcie_ep_ops = {
+static const struct dw_pcie_ops dw_ls_pcie_ep_ops = {
 	.start_link = ls_pcie_establish_link,
 };
 
-static const struct of_device_id ls_pcie_ep_of_match[] = {
-	{ .compatible = "fsl,ls-pcie-ep",},
-	{ },
-};
-
 static const struct pci_epc_features*
 ls_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
@@ -87,10 +89,39 @@ static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 	}
 }
 
-static const struct dw_pcie_ep_ops pcie_ep_ops = {
+static unsigned int ls_pcie_ep_func_conf_select(struct dw_pcie_ep *ep,
+						u8 func_no)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct ls_pcie_ep *pcie = to_ls_pcie_ep(pci);
+
+	WARN_ON(func_no && !pcie->drvdata->func_offset);
+	return pcie->drvdata->func_offset * func_no;
+}
+
+static const struct dw_pcie_ep_ops ls_pcie_ep_ops = {
 	.ep_init = ls_pcie_ep_init,
 	.raise_irq = ls_pcie_ep_raise_irq,
 	.get_features = ls_pcie_ep_get_features,
+	.func_conf_select = ls_pcie_ep_func_conf_select,
+};
+
+static const struct ls_pcie_ep_drvdata ls1_ep_drvdata = {
+	.ops = &ls_pcie_ep_ops,
+	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
+};
+
+static const struct ls_pcie_ep_drvdata ls2_ep_drvdata = {
+	.func_offset = 0x20000,
+	.ops = &ls_pcie_ep_ops,
+	.dw_pcie_ops = &dw_ls_pcie_ep_ops,
+};
+
+static const struct of_device_id ls_pcie_ep_of_match[] = {
+	{ .compatible = "fsl,ls1046a-pcie-ep", .data = &ls1_ep_drvdata },
+	{ .compatible = "fsl,ls1088a-pcie-ep", .data = &ls2_ep_drvdata },
+	{ .compatible = "fsl,ls2088a-pcie-ep", .data = &ls2_ep_drvdata },
+	{ },
 };
 
 static int __init ls_add_pcie_ep(struct ls_pcie_ep *pcie,
@@ -103,7 +134,7 @@ static int __init ls_add_pcie_ep(struct ls_pcie_ep *pcie,
 	int ret;
 
 	ep = &pci->ep;
-	ep->ops = &pcie_ep_ops;
+	ep->ops = pcie->drvdata->ops;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
 	if (!res)
@@ -142,20 +173,23 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	if (!ls_epc)
 		return -ENOMEM;
 
-	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
-	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
-	if (IS_ERR(pci->dbi_base))
-		return PTR_ERR(pci->dbi_base);
+	pcie->drvdata = of_device_get_match_data(dev);
 
-	pci->dbi_base2 = pci->dbi_base + PCIE_DBI2_OFFSET;
 	pci->dev = dev;
-	pci->ops = &ls_pcie_ep_ops;
-	pcie->pci = pci;
+	pci->ops = pcie->drvdata->dw_pcie_ops;
 
 	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
 
+	pcie->pci = pci;
 	pcie->ls_epc = ls_epc;
 
+	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
+	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	pci->dbi_base2 = pci->dbi_base + PCIE_DBI2_OFFSET;
+
 	platform_set_drvdata(pdev, pcie);
 
 	ret = ls_add_pcie_ep(pcie, pdev);
-- 
2.9.5

