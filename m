Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412DB24193B
	for <lists+linux-pci@lfdr.de>; Tue, 11 Aug 2020 12:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgHKKCP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Aug 2020 06:02:15 -0400
Received: from inva021.nxp.com ([92.121.34.21]:42054 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbgHKKCO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Aug 2020 06:02:14 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B4792201F22;
        Tue, 11 Aug 2020 12:02:12 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 465F2201EEF;
        Tue, 11 Aug 2020 12:02:05 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 13636402A5;
        Tue, 11 Aug 2020 12:01:56 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, robh+dt@kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        gustavo.pimentel@synopsys.com, roy.zang@nxp.com,
        jingoohan1@gmail.com, andrew.murray@arm.com
Cc:     mingkai.hu@nxp.com, minghuan.Lian@nxp.com,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv7 07/12] PCI: layerscape: Modify the way of getting capability with different PEX
Date:   Tue, 11 Aug 2020 17:54:36 +0800
Message-Id: <20200811095441.7636-8-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
References: <20200811095441.7636-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

The different PCIe controller in one board may be have different
capability of MSI or MSIX, so change the way of getting the MSI
capability, make it more flexible.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V7:
 - Rebase the patch without functionality change.

 .../pci/controller/dwc/pci-layerscape-ep.c    | 31 ++++++++++++++-----
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 0691d9ad1356..9601f9c09cb1 100644
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
2.17.1

