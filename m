Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F412EEF9F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 10:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbhAHJ2l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 04:28:41 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:61006
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727696AbhAHJ2j (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 04:28:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzhHOHqB4wLdh5MKHLkXm1lJHG9vpq+7Q6hO+HwCEvvJzMkLCtrQn7nurqV2bf0pFvUY3USDWkY4MPBLX0BRC0uZdnBFNuzOuFpYyom4sLbjZot01n5D7YdmQuQulf34Nt5+SIob/Y+1xY4bU6nQFHmrUu6lm5RVN2+dF0Wr0L8szRzJVfqAEYSeSH72m7MCmAqVRkbB1hA222rDJgQCze4gdjkQ60392Bx7yFecRk2hJhT54vcROPMorga/jk6tj24niiaqaJcR3YFVICDg2ww7E9dqjl5z0cgy2WhthLS1kuSLCF1KEwhrEe2jLCuanY7SpVL4EI7mIQxEi/+5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH2phU8c1mdo0cklfd+5X1N8lkAVlDjDaSHPMYihdmY=;
 b=UnYI6QztaXJVlreqDZ2hw/gXLDDrXkd1lrdQmbMCduh194SoWQISrF+pCecRk9Jmch6pQD0ujVUearv70u4NAPomC9XV6S7DAYvhMDpKukGctilQ73ZZzDDTLoJUKWAbANfPuGJnjajvScIKTfbq5qENIvn8ysngG9bH+xkc0TVOA6auFAdggOErsJFHqOffNp7j2Uoo7OkkZjoePt+PQG8Z5MhQkRgUgCn86YVkRzkp4tsn9OiFk6g/3gsnxwIyaO4gQ5rfnmn7q+lBlyecWDeYwTzpol3b3bh1jvmis1oaagDntFndd4EgFKl1PqoHkVH+3CKvTSnSctPhHUE8Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH2phU8c1mdo0cklfd+5X1N8lkAVlDjDaSHPMYihdmY=;
 b=DU33YuNuRLsal44DtN3DivS/gzxzEb6s45bxh6UwkKrO8I6TMJu3p39Jj+elEJIV+xJgNHGFrLiBf3DeZ4mKwQ/QuTCF07QZYeFWrWF2ZgfVzObGwI36dVoLaEnuHU0fz+JQor9DmOPSX/ZYidtAIloWOcwGQ6tt3W5qfbvO924=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 09:27:34 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 09:27:34 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 2/7] PCI: layerscape: Change to use the DWC common link-up check function
Date:   Fri,  8 Jan 2021 17:36:05 +0800
Message-Id: <20210108093610.28595-3-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
References: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::29) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 09:27:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b9c519b0-2d56-49b5-0555-08d8b3b7a175
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2652D0BA214F0A60D386EF1784AE0@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +f1489CFxHer27oQdiKKxG2RyYmt0ttgkUWYYGDm1rQkUk/ni1CGo9xbVB9hNX7Qp/m6NLu+S5tLfcIlom39IyAjbKO/AXcL2Qve0Ja5FZsdNz4+UnvhetrQWb/+McI2o9RCDASIHMxSLuzKljMmeiOjv6ZvpgT//dovbsnhfHf5MZtsHw3OZtcLu/rKuGMM9gli8SLoDgW3JIipkiDYtlAub2KnCSczxkkGBhzSlwMB0KLrgVYDfeALGgfIWk4okm0BDRuZ/9YBtvjsPvWtR19xGrGMDK4i92u8VfBFgB4nTxl4kPVDXYAs1uOYx3emHY7P5sVxk/229pabYfVh+1dKfmQ3iwxulpQzGZAnF9izE8VS98wr6behsAaZGG79/k8KydoXwWxs3PqpM56oBQRApqupzo9OY2kLWEBuxzBwT8e/i1vqUeYZk/zJdglCmHn03ILgc37xE8adlJvqww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(316002)(478600001)(6506007)(6486002)(4326008)(52116002)(2616005)(36756003)(69590400011)(8936002)(66556008)(956004)(921005)(6512007)(1076003)(66476007)(5660300002)(66946007)(26005)(2906002)(6666004)(16526019)(8676002)(83380400001)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GG7xxbgOByS8CEPdGQwEpZz6jemUQ9Izom2UZhdGjA5kPsXZVC64Kq88nWAd?=
 =?us-ascii?Q?KkKnynPF7Uayrf10mpaUNIukdrdPPkcMenFOiVrP5nw0ho/n0pyAKIYGLTR7?=
 =?us-ascii?Q?ub762/HIpiJ+WiJu+I0O8goVhZwEzMsWhhh0sHFE4312ZqOVsUfWYqk5jLKJ?=
 =?us-ascii?Q?2msVTKyfQ9zWrsR66sHcZdJLmi3usxmoBe3KYvWtVhtpa5O75rpWrXOEM2iu?=
 =?us-ascii?Q?2EVyKOClY+B3CJcXNjJ7fprWbuO07MRaGyUuysRN5ms2CpScv0SKc+x0bniu?=
 =?us-ascii?Q?1IN9C2dEc2U/wgnQOjdztUvqezTGCHfBY23o4ndZZwfXikEWknYRX23Crwn/?=
 =?us-ascii?Q?ipAGyWLUEBJZMK+KamoOKODczA4jPX2Ua6VWtSiPoX62I5ITCh9sjStAmNsA?=
 =?us-ascii?Q?e35Z7PiyXxw5ZmHps2/y8G4V6NPBrcIqmDoy7+uXv3Vif3xh4aXHnO4VLuuz?=
 =?us-ascii?Q?AO19xPNP7J0uSrDxlt5gKXlxCPF64WWak7yfOd1lX1IY1uLR896buqakfReP?=
 =?us-ascii?Q?CRlRiOkClg8hxTzNzKQ7m94pLrkKWNMOTUuEf+jNGmHH1jzQCn5uONJj7ID+?=
 =?us-ascii?Q?2KvAEtAY4BPA//Lgi8mbGvj813FsgZTslA6qcMJfodSKtGJM/R24vVtfCxsO?=
 =?us-ascii?Q?m1fblwApUI4aYIB+ZRo5VxSOK1McA//59jhI3gVBeGiORKChQV54D5Z2oGoA?=
 =?us-ascii?Q?61eQGjLKnx3ElVIYqq3aMFzHbPP/F1A70FAjRRB/7FJolzOfTOysBaXGNqO/?=
 =?us-ascii?Q?FTY3FJdqNiABN9fr+JoXI3KA6XHhWaSZVdjhensi/l8bz2C09ReTJoC3Gts/?=
 =?us-ascii?Q?QQ/b0YH/WqUlHxYXxIz8WCnQwmbwJUU1Is9IVZmdRBsb/aKJzYYFYtSf7jqN?=
 =?us-ascii?Q?xCY7Wb7O+KfIhQoIujTjxBfyRmP47Gl6oKFEo/1kG7sPUmGt/1qulI1T1fXF?=
 =?us-ascii?Q?nXZhYzvSfW+Sx1Jp8na4cch/tIzv3QpI1zSy29za5hADrggNPZB8hQfXhfhp?=
 =?us-ascii?Q?52/n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 09:27:34.0374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c519b0-2d56-49b5-0555-08d8b3b7a175
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KRq4TknjBUnVZHwA4KEJ3M5MldPUCRWT7Rk/U0yOQhxinVkdp2whgdUeNT9gKkWOcF+eS/w9/DPfXJlnilGRIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652
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
V3:
 - Rebased against the latest code base

 drivers/pci/controller/dwc/pci-layerscape.c | 140 ++------------------
 1 file changed, 10 insertions(+), 130 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 44ad34cdc3bc..906fac676b6f 100644
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
@@ -83,38 +70,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 	iowrite32(val, pci->dbi_base + PCIE_STRFMR1);
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
@@ -139,96 +94,24 @@ static int ls_pcie_host_init(struct pcie_port *pp)
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
-static const struct dw_pcie_host_ops ls1021_pcie_host_ops = {
-	.host_init = ls1021_pcie_host_init,
-};
-
 static const struct dw_pcie_host_ops ls_pcie_host_ops = {
 	.host_init = ls_pcie_host_init,
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
+static const struct ls_pcie_drvdata layerscape_drvdata = {
 	.ops = &ls_pcie_host_ops,
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
-	.ops = &ls_pcie_host_ops,
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
 
@@ -250,7 +133,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	pcie->drvdata = of_device_get_match_data(dev);
 
 	pci->dev = dev;
-	pci->ops = pcie->drvdata->dw_pcie_ops;
 	pci->pp.ops = pcie->drvdata->ops;
 
 	pcie->pci = pci;
@@ -260,8 +142,6 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
-	pcie->lut = pci->dbi_base + pcie->drvdata->lut_offset;
-
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
-- 
2.17.1

