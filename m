Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7497F17CAC6
	for <lists+linux-pci@lfdr.de>; Sat,  7 Mar 2020 03:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCGC2e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 21:28:34 -0500
Received: from inva021.nxp.com ([92.121.34.21]:48682 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCGC2d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 21:28:33 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E7364200DCE;
        Sat,  7 Mar 2020 03:28:31 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5B43A200119;
        Sat,  7 Mar 2020 03:28:22 +0100 (CET)
Received: from titan.ap.freescale.net (titan.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 69C71402FA;
        Sat,  7 Mar 2020 10:28:11 +0800 (SGT)
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
Subject: [PATCH v5 07/11] PCI: layerscape: Modify the way of getting capability with different PEX
Date:   Sat,  7 Mar 2020 10:14:26 +0800
Message-Id: <20200307021430.36826-8-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200307021430.36826-1-xiaowei.bao@nxp.com>
References: <20200307021430.36826-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The different PCIe controller in one board may be have different
capability of MSI or MSIX, so change the way of getting the MSI
capability, make it more flexible.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2:
 - Remove the repeated assignment code.
v3:
 - Use ep_func msi_cap and msix_cap to decide the msi_capable and
   msix_capable of pci_epc_features struct.
v4:
 - No change.
v5:
 - No change.

 drivers/pci/controller/dwc/pci-layerscape-ep.c | 31 +++++++++++++++++++-------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 0691d9a..9601f9c 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -22,6 +22,7 @@
 
 struct ls_pcie_ep {
 	struct dw_pcie		*pci;
+	struct pci_epc_features	*ls_epc;
 };
 
 #define to_ls_pcie_ep(x)	dev_get_drvdata((x)->dev)
@@ -40,26 +41,31 @@ static const struct of_device_id ls_pcie_ep_of_match[] = {
 	{ },
 };
 
-static const struct pci_epc_features ls_pcie_epc_features = {
-	.linkup_notifier = false,
-	.msi_capable = true,
-	.msix_capable = false,
-	.bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
-};
-
 static const struct pci_epc_features*
 ls_pcie_ep_get_features(struct dw_pcie_ep *ep)
 {
-	return &ls_pcie_epc_features;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct ls_pcie_ep *pcie = to_ls_pcie_ep(pci);
+
+	return pcie->ls_epc;
 }
 
 static void ls_pcie_ep_init(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct ls_pcie_ep *pcie = to_ls_pcie_ep(pci);
+	struct dw_pcie_ep_func *ep_func;
 	enum pci_barno bar;
 
+	ep_func = dw_pcie_ep_get_func_from_ep(ep, 0);
+	if (!ep_func)
+		return;
+
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
+
+	pcie->ls_epc->msi_capable = ep_func->msi_cap ? true : false;
+	pcie->ls_epc->msix_capable = ep_func->msix_cap ? true : false;
 }
 
 static int ls_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
@@ -119,6 +125,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
 	struct ls_pcie_ep *pcie;
+	struct pci_epc_features *ls_epc;
 	struct resource *dbi_base;
 	int ret;
 
@@ -130,6 +137,10 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
+	ls_epc = devm_kzalloc(dev, sizeof(*ls_epc), GFP_KERNEL);
+	if (!ls_epc)
+		return -ENOMEM;
+
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
 	if (IS_ERR(pci->dbi_base))
@@ -140,6 +151,10 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	pci->ops = &ls_pcie_ep_ops;
 	pcie->pci = pci;
 
+	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
+
+	pcie->ls_epc = ls_epc;
+
 	platform_set_drvdata(pdev, pcie);
 
 	ret = ls_add_pcie_ep(pcie, pdev);
-- 
2.9.5

