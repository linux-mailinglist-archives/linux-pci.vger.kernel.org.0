Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1849829A5A7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 08:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507932AbgJ0Hlk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 03:41:40 -0400
Received: from mail-vi1eur05on2073.outbound.protection.outlook.com ([40.107.21.73]:52062
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2507917AbgJ0Hlj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 03:41:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i0NV9uj/TvpYJRlqa+oOiAxGVEXGuGo/DAw543SxmdxFz6qq42xTA4Zfz05/ZpJNN5qCtAM9rlsRJk+iKlQdYt48SqGQGNYHuHdO9MelU21iCMBC0YcH6OpoNytZqPeYjq9ixRIaEU7WBC5J59suhlUwtoiHgl4rf+zaQAHyg2GNma/pDEYA48hY0NcGmvKzdawukr4TEOipsNBBolrzh643nOXQGpE1RnV7Pg6p/FaM2Xg5ZM1AZK0w3rOBjQEEjVnd0o+JQpohTlUefSWkJp6Nk/8D+aEIhk0Uaf8GUtLFtjPpto0i7ghmhXg/5IbSARWNfVSA2iVy/u7AzNhxNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HWFnbpm3lNxRVHZhaOrIDDULzGG9/ubtiVg+c3NDEE=;
 b=himzGNgcggoCCdwR2+TdNPAS2dAkepAZ5kVrqvFCMqIZGxHH+Wq2WJqs2wKt+h+eIIa2DJl3ifrLYLy0KKqsgCq35+JaThSgKbQimdKNSX+WkfyuA/dAMbXBg1B2Ws05PajemQSY9vrebm9nlLcq4C/sbpu8wPZGZqbRQlz+npgLdoMZ63ANAv0b5w17qgW9F1Jpd0cTc0lmSb+7VuKT5c3NuuT+LRVJ1JmzrbEE8I11Wo5RcSN2AFwr+sLl7giaCS7y6V8PJFd/6w9wBYALn6BEMf7g/oV2NGJswx6OgoaEgWbizcXFstVWg21E6DRyl7T5r0Gw39s4Oxd1OTeigQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HWFnbpm3lNxRVHZhaOrIDDULzGG9/ubtiVg+c3NDEE=;
 b=SzF82xoLZZBdeQTJ8gvfhi6/njyS7sGtNBplIpbGxinpV+VEcI+OxVyNDo6VoulgrI62dTSEK80h4UFyTT9RzMBX5BPslsQCvYFJq95U2gaDbAY/1ueCyydV7XXsiZhIIMMIR61cN46WJBvueSoifk+f/wBuMjWWidEB9Rp0fak=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 27 Oct
 2020 07:40:45 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 07:40:45 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 2/7] PCI: layerscape: Change to use the DWC common link-up check function
Date:   Tue, 27 Oct 2020 15:29:56 +0800
Message-Id: <20201027073001.41808-3-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
References: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 07:39:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4ca8f199-4cd8-4a0d-3775-08d87a4b7645
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB33716DD4E1D7A1C6CFF788C784160@HE1PR0402MB3371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: np507AMo7cQ4wHapQbBO6LckgHVj7bDJ+azryxnwFfQZMSkLCrPNyGVKCbMuG1SjuU3e9lfbC/Zq3KRRGiBqpaUU+qDek7C7OwaxTHej/XFY2kki/IHJ27CtKyEn8+q11wuGGhRv0RTsUZOd145VclEelVdsaD11oRHjW1Ep6Qv1XvLua4ev4eC0g4wzbcrxb4zvTNQJzdBA4b5ylqIYWrLU9SFxvbKpjMKpdnYbjvbHFikFCqkvD61kCEhxBDEfrpzaNf4myPLAfMnVn73BiKWu59PF5HSg1P4Ljb8I7u1+U0NFwUSHOwb9yCP72tNaMxeQbUDiOxq0F/hSW3iQY200Dd9PbTqhkU14WYy0zOZK41OVRwSCTZckJYKiea9ws+iSg+DALLe+0dxeybAvng==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(1076003)(8676002)(5660300002)(86362001)(2906002)(186003)(8936002)(6666004)(4326008)(16526019)(6506007)(26005)(316002)(52116002)(2616005)(36756003)(956004)(69590400008)(6486002)(6512007)(478600001)(83380400001)(66556008)(66476007)(66946007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WP4U8K6hQly6wYMspwox+imRTd6DciglRBHl9Rd6cRS8+5rW0k9lxXBwLnRmeNzGe778KgOFe9GIMAs9EHQ2UB0jsjzXABsZumtXnOny1erDdv3Gg1kUNO3nbvhJNzZRtGvYP5+AgMIspjhTTqk3olB6EtnXmH4wAy/BkScbV0lpke0sKYQ5F/hvZPbfkUuK3nymiCYSLnh6e/y8amm+qJGynpp9HgUeHAOJUoaaWGKVfL0OyvSCaqJtypemAMX5IcANc6e0nGH8+3Ksti6HDgKKpFhZTEBGb203xMXAnCvlkyni+z+O2mPeMTkgRxjQJqQVfmUQs/lAF0piH4Ej3xbQRBy6hVF2zsPfZ4qagAhpB5cI0IuVn1lP6F5z55GI3uUs/n8xLwM+96oQRjc0Ulu8/ExsWNTT3oU4Q5aK1WmwPf6iTYUIrSFduLkMKP2PCJno9mfkHtLru9aPTz75/+OpxODTqlipeDsnrXafc4yi2Lzn8axFeJVqxVnIVxd+KKV3y09BOSOIvfvfAaktw4+FjlXm97Zf5hj0KFXPfOGvVmYUhnQPVeKxXc8R/x+D7i400PisYezuc6XWwBwV7OmZ8KtcrkDMeLzFMXR0VZH3rtNQERtZ+uF8KKHwwB215GZ8NQiCuLoo90+URhrbUQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ca8f199-4cd8-4a0d-3775-08d87a4b7645
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 07:39:40.3056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEr3RK6f6r8SrOEHPAijghGt02oFNjtAnS8T8PjDE5S4F39kkqGbbzpzphlFE3JDzv8LBwE4VeJVr79LAuLi5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371
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
Reviewed-by: Rob Herring <robh@kernel.org>
---
V2:
 - No change.

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

