Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C41725F2BC
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 07:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgIGFqI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 01:46:08 -0400
Received: from inva020.nxp.com ([92.121.34.13]:44130 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgIGFqD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 01:46:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 28F5A1A0FB8;
        Mon,  7 Sep 2020 07:46:01 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C00C31A0F84;
        Mon,  7 Sep 2020 07:45:55 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E9160402D9;
        Mon,  7 Sep 2020 07:45:48 +0200 (CEST)
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, shawnguo@kernel.org, leoyang.li@nxp.com,
        lorenzo.pieralisi@arm.com, gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 2/7] PCI: layerscape: Change to use the DWC common link-up check function
Date:   Mon,  7 Sep 2020 13:37:56 +0800
Message-Id: <20200907053801.22149-3-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
References: <20200907053801.22149-1-Zhiqiang.Hou@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The current Layerscape PCIe driver directly uses the physical layer
LTSSM code to check the link-up state, which treats the > L0 states
as link-up. This is not correct, since there is not explicit map
between link-up state and LTSSM. So this patch changes to use the
DWC common link-up check function.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 141 ++------------------
 1 file changed, 10 insertions(+), 131 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index f24f79a70d9a..be404c16bcbe 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -22,12 +22,6 @@
 
 #include "pcie-designware.h"
 
-/* PEX1/2 Misc Ports Status Register */
-#define SCFG_PEXMSCPORTSR(pex_idx)	(0x94 + (pex_idx) * 4)
-#define LTSSM_STATE_SHIFT	20
-#define LTSSM_STATE_MASK	0x3f
-#define LTSSM_PCIE_L0		0x11 /* L0 state */
-
 /* PEX Internal Configuration Registers */
 #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
 #define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
@@ -36,19 +30,12 @@
 #define PCIE_IATU_NUM		6
 
 struct ls_pcie_drvdata {
-	u32 lut_offset;
-	u32 ltssm_shift;
-	u32 lut_dbg;
 	const struct dw_pcie_host_ops *ops;
-	const struct dw_pcie_ops *dw_pcie_ops;
 };
 
 struct ls_pcie {
 	struct dw_pcie *pci;
-	void __iomem *lut;
-	struct regmap *scfg;
 	const struct ls_pcie_drvdata *drvdata;
-	int index;
 };
 
 #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
@@ -91,38 +78,6 @@ static void ls_pcie_disable_outbound_atus(struct ls_pcie *pcie)
 		dw_pcie_disable_atu(pcie->pci, i, DW_PCIE_REGION_OUTBOUND);
 }
 
-static int ls1021_pcie_link_up(struct dw_pcie *pci)
-{
-	u32 state;
-	struct ls_pcie *pcie = to_ls_pcie(pci);
-
-	if (!pcie->scfg)
-		return 0;
-
-	regmap_read(pcie->scfg, SCFG_PEXMSCPORTSR(pcie->index), &state);
-	state = (state >> LTSSM_STATE_SHIFT) & LTSSM_STATE_MASK;
-
-	if (state < LTSSM_PCIE_L0)
-		return 0;
-
-	return 1;
-}
-
-static int ls_pcie_link_up(struct dw_pcie *pci)
-{
-	struct ls_pcie *pcie = to_ls_pcie(pci);
-	u32 state;
-
-	state = (ioread32(pcie->lut + pcie->drvdata->lut_dbg) >>
-		 pcie->drvdata->ltssm_shift) &
-		 LTSSM_STATE_MASK;
-
-	if (state < LTSSM_PCIE_L0)
-		return 0;
-
-	return 1;
-}
-
 /* Forward error response of outbound non-posted requests */
 static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
 {
@@ -155,33 +110,6 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static int ls1021_pcie_host_init(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct ls_pcie *pcie = to_ls_pcie(pci);
-	struct device *dev = pci->dev;
-	u32 index[2];
-	int ret;
-
-	pcie->scfg = syscon_regmap_lookup_by_phandle(dev->of_node,
-						     "fsl,pcie-scfg");
-	if (IS_ERR(pcie->scfg)) {
-		ret = PTR_ERR(pcie->scfg);
-		dev_err(dev, "No syscfg phandle specified\n");
-		pcie->scfg = NULL;
-		return ret;
-	}
-
-	if (of_property_read_u32_array(dev->of_node,
-				       "fsl,pcie-scfg", index, 2)) {
-		pcie->scfg = NULL;
-		return -EINVAL;
-	}
-	pcie->index = index[1];
-
-	return ls_pcie_host_init(pp);
-}
-
 static int ls_pcie_msi_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -205,71 +133,25 @@ static int ls_pcie_msi_host_init(struct pcie_port *pp)
 	return 0;
 }
 
-static const struct dw_pcie_host_ops ls1021_pcie_host_ops = {
-	.host_init = ls1021_pcie_host_init,
-	.msi_host_init = ls_pcie_msi_host_init,
-};
-
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
 	.msi_host_init = ls_pcie_msi_host_init,
 };
 
-static const struct dw_pcie_ops dw_ls1021_pcie_ops = {
-	.link_up = ls1021_pcie_link_up,
-};
-
-static const struct dw_pcie_ops dw_ls_pcie_ops = {
-	.link_up = ls_pcie_link_up,
-};
-
-static const struct ls_pcie_drvdata ls1021_drvdata = {
-	.ops = &ls1021_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls1021_pcie_ops,
-};
-
-static const struct ls_pcie_drvdata ls1043_drvdata = {
-	.lut_offset = 0x10000,
-	.ltssm_shift = 24,
-	.lut_dbg = 0x7fc,
-	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
-};
-
-static const struct ls_pcie_drvdata ls1046_drvdata = {
-	.lut_offset = 0x80000,
-	.ltssm_shift = 24,
-	.lut_dbg = 0x407fc,
-	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
-};
-
-static const struct ls_pcie_drvdata ls2080_drvdata = {
-	.lut_offset = 0x80000,
-	.ltssm_shift = 0,
-	.lut_dbg = 0x7fc,
-	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
-};
-
-static const struct ls_pcie_drvdata ls2088_drvdata = {
-	.lut_offset = 0x80000,
-	.ltssm_shift = 0,
-	.lut_dbg = 0x407fc,
+static const struct ls_pcie_drvdata layerscape_drvdata = {
 	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
 };
 
 static const struct of_device_id ls_pcie_of_match[] = {
-	{ .compatible = "fsl,ls1012a-pcie", .data = &ls1046_drvdata },
-	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
-	{ .compatible = "fsl,ls1028a-pcie", .data = &ls2088_drvdata },
-	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
-	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
-	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
-	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
-	{ .compatible = "fsl,ls2088a-pcie", .data = &ls2088_drvdata },
-	{ .compatible = "fsl,ls1088a-pcie", .data = &ls2088_drvdata },
+	{ .compatible = "fsl,ls1012a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1021a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1028a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1043a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1046a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2080a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2085a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls2088a-pcie", .data = &layerscape_drvdata },
+	{ .compatible = "fsl,ls1088a-pcie", .data = &layerscape_drvdata },
 	{ },
 };
 
@@ -310,7 +192,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	pcie->drvdata = of_device_get_match_data(dev);
 
 	pci->dev = dev;
-	pci->ops = pcie->drvdata->dw_pcie_ops;
 
 	pcie->pci = pci;
 
@@ -319,8 +200,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
-	pcie->lut = pci->dbi_base + pcie->drvdata->lut_offset;
-
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
-- 
2.17.1

