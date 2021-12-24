Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E85A47EDC7
	for <lists+linux-pci@lfdr.de>; Fri, 24 Dec 2021 10:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352250AbhLXJ3F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Dec 2021 04:29:05 -0500
Received: from mail-eopbgr60043.outbound.protection.outlook.com ([40.107.6.43]:19783
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352232AbhLXJ3E (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Dec 2021 04:29:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OYY3Esz2BRUyg9Np7pTqpGe1ZkDGTv62aC8WJ8OVA6teyXR1HdyqA2g/NKmNh427IBqbZl4y1t1nG8zrr/QKVjpPOBH+p8jh/dyNPCnbpLE5wIXuZ0IVWIpgDVMu0TLGdTjic76Vt6j17td1Ytq0f0jcDRgU4Wsp3BQJ492J/nFPj4anerpMBYKlQXPgedeh7PIPS4caR2ocMKSlz6mTx25o1GibnpK+EXjZpeXntuLhAnJB0O3dphP0qrVFI47qqOno9PxvFBOfuOQiKV9gW6czwUD4z8lJmeF4SLWkdHE9jy/ZMY0uvH1vbOIRmgImL0KxY9KHendSrm5YfMWTGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ketAI+ddyZdSpwR2gPn5m+GSFRDQHGYmUPQdt4AzOAU=;
 b=jSao9ef2t+LUb/cz59Htki9tjimtF/0K2lzH3nGAXAHNgcoFeEovRH+7OYQpLEp0wcZ+h/AqYUMW81JheyWP/xDqcJDzoC93wZRGiDtwsG4OSZRDtihc4ZMQEMKXDoP6TQSBwo4cteg1MKWXBidQrEAQQCYjcSEJjgfsXjJDkM6iFC6ejtKFS0gndE4q0vLYWstvh3F5SVllOiFuKFEhtgVELz9X0uw5d9bMaVUlClm4JAIMMJRXEYuU0DDVoT3vFfyI+r10FT9RHuJwzshg2bitsx2cQLyeXkx4poD0gxUvIxipt7ZWYgBGYNwityNUs7TyHIEIfm3J/oG84lh4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ketAI+ddyZdSpwR2gPn5m+GSFRDQHGYmUPQdt4AzOAU=;
 b=aMBAVtA93FSQUHEOnW8a0ojt1f4/P1MRDnpdhn+085VT4CfjYaUvZAtNTI8atj2PgS+jYV9ZEENeDAWXr4bVTSbe2khrc3l3PstPaIWjUkno/ryTSdc34nrHbfSs48d5vzIxEId6hFy65Q4sGuZELPWUCqYgo0hopDukeBCi19I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB2974.eurprd04.prod.outlook.com (2603:10a6:802:a::24)
 by VI1PR04MB6142.eurprd04.prod.outlook.com (2603:10a6:803:fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Fri, 24 Dec
 2021 09:29:01 +0000
Received: from VI1PR04MB2974.eurprd04.prod.outlook.com
 ([fe80::2519:18e0:1cfb:f145]) by VI1PR04MB2974.eurprd04.prod.outlook.com
 ([fe80::2519:18e0:1cfb:f145%3]) with mapi id 15.20.4801.024; Fri, 24 Dec 2021
 09:29:01 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, minghuan.Lian@nxp.com,
        leoyang.li@nxp.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv6] PCI: layerscape: Change to use the DWC common link-up check function
Date:   Fri, 24 Dec 2021 17:40:00 +0800
Message-Id: <20211224094000.8513-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0126.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::30) To VI1PR04MB2974.eurprd04.prod.outlook.com
 (2603:10a6:802:a::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b6b7a72-7096-4043-b728-08d9c6bfd19a
X-MS-TrafficTypeDiagnostic: VI1PR04MB6142:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB614263BFF2F1754BF3A473D0847F9@VI1PR04MB6142.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qh3blit4mYYdQKHh2n3jsXSKcHnXPv8IZCkEca/mW9jrh62Q0W0WNQ5YrE3nomEeJpehHERkC9Zg+lp+7A6vPIix6apj7eBsR243N53EbPOPq7Z842D9y1KI05sI83ob4QlwDYvQjmhi2aQto+am1n4GmUcnZrQOLUt4fnlvlIFmgwoQ61lYo2/Md9aXCDjKov/cIkdTL+ttRdXz9aa9/QEmyVhbQ/Y7cPdwlXTEjZzvEIMeuyTAihrAYqHATDQcClNkeRfThK9m8nItMcnk+vRU5DsMnGbQLnmoRs1YLFdwyflZmsg7bbiIv5zYIe2pLpgfJRKzu9Uy4Dwovehws4KNRGrbn/Ur/q4+YhUdD8gyaLDcd6SIbbNIm26yQGM13QR3DBcKkL4XI3x0C/ejr1J3NR4HfH5Knjv1ByklzNKy2dFSROeMe0b+2ooEHBbXPLVvz90LGTfq9a2xBeMV1rZCXQvBXqgdH7+VMatzx6NB4c0iAmrRIQUir50loKMwz/03TlpJLNxRCLSab8+svxgynRVYNrxB+hFHO+JyqQztQU3Syh5aoMgahbmRq2PyML7FiESleu7W1OfxqDNJMI3z6WMs0oTuSYYDFnPLKUCL5Y1Ly5dHB0taVIpi2TzcU+HXGbFmi9ASf7puLPRes1bkcK2b3D/f4nq9XOpI0bKugK6NnaoZJyk1g5SXYzKJyhUWoEOU3z1FGZ+Q3Qukuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB2974.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(83380400001)(8676002)(186003)(6636002)(508600001)(6486002)(2906002)(6512007)(1076003)(38350700002)(5660300002)(6506007)(2616005)(66556008)(4326008)(36756003)(8936002)(38100700002)(26005)(52116002)(66476007)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/HL+wlRzh1J/W5cXqzbIKuMUaHOIlazxiAcHoD9qlPoJ5AIx2V802Nm/THzS?=
 =?us-ascii?Q?Ddm0pw2JfgCGJoq5Eh5qtHLqCuAzSDXoQAy62IZe03kn9u0/tCWBi8Z4wywF?=
 =?us-ascii?Q?++g3xF7oQjaopgpAVrOBtelhndT+SNr/fpUP556rzR0gwkarXwNB9/K4IREp?=
 =?us-ascii?Q?IN/x02CdYDq0iVwod1RUXi5KDP3xEBlLRWXMUwdC4FLidZcSMUCY9tURVrVZ?=
 =?us-ascii?Q?pjeid2AT2+Q2pRvaktQXUOU3H4hSadMArLhKi3Z0N25B7KXmPyTvYD4Twzmy?=
 =?us-ascii?Q?s5vZP9jncf6mEFwuwkGHsdGvhPtigFvFEOn6N6EXqu6lCIUNbJDO55q6ix9D?=
 =?us-ascii?Q?PpwoJKEhTe05yjnR1zGkU7nSpCxb9ekQO7CC10Mrh4xl3dK/ngmOgsVu+sgD?=
 =?us-ascii?Q?4S0KjNdIi2FS7CxfimdB1AAdTiEV1lpyLkiU4xr7+jdzNhxjLuy9Rjccue+6?=
 =?us-ascii?Q?bO1QKP6KDT+r0hst//FvHA9jsxxyjCm1zcpXdLA0gbE1GrJKPveuDiQRp7C8?=
 =?us-ascii?Q?xjeqfuOLonp98tskl3AQIW0aGexNMnu1hoiMZ1kvrSiJB8hjm808Yk8wupmH?=
 =?us-ascii?Q?ZHQ6WeDX7W8HRtBFAJTJ4SaXlz0oR6Xeizuw6SNsT6worQLjZq9RIi50HFRq?=
 =?us-ascii?Q?Eg39jZg1n00B6Pw0IqIZZdSlZbwjNdvVf/R7nhnxMfqlJlutcUsvmN6IoJOY?=
 =?us-ascii?Q?FemPTFl0STrL/Ij+T4pO4oIHcUP/FoxjFunvfYjIdTpFlS+t39nrNUJxgPBx?=
 =?us-ascii?Q?N7X8YB0VhdCm4sxp+dp/JnGBJEcsGwYqfFvA8lus5ysOgpT7QRD9eL6TW9Z6?=
 =?us-ascii?Q?ztWACxMKBeY0NuX/e60017g4nkN+AErHQCS+bx7meRM6MI6R1j+Qprw0/3sw?=
 =?us-ascii?Q?2h+t+ItzwFq+wac2yuUfi9w1iyotQ433X78SjlJOjzAC2MofpQs9+rv5ZvsE?=
 =?us-ascii?Q?0xJhNl4MFpE5jZun8jsgR5theQ1gdgSZ/Wn+y+WgWEM9fQmDHjaIkpkiF1tw?=
 =?us-ascii?Q?bZChg7F7AxJyLkZgS4vLh3G5HA6//sPlkGmBlEABoDCDFXQWpTm8fqnZcbNk?=
 =?us-ascii?Q?0jjs1t19sXoA4bNJxAo5wJyTX9R9tW45m6ypLqRAg4JMRRc/nmhzVXZ9EQY1?=
 =?us-ascii?Q?yivG3UZ6tqaADOZ6oIfgFJxD9DtPeUmtA6ve2UzD680X/kb/E2li9e8mfijT?=
 =?us-ascii?Q?g9J5SeDYdac8w42jnWmsRZkzO44IKE0HNfygwoLmtCbZoHH89IAxWlzzSaQu?=
 =?us-ascii?Q?t66PE4H1l4qaNSOHBa3hWG9WzQo6zEx3drV9pErYZxafd8JjbDjp3/w/xrhO?=
 =?us-ascii?Q?CMA3sRhoGBMBeQEbVu2QKByeXWRZs6YIOJDie3vLADScyt9zFtdOYpytQqeF?=
 =?us-ascii?Q?GO6SwRjuBYSWaKoegyY/i7WECtRnrebiffojEVRtOxJBUqV7g8FQ3RbYIyfR?=
 =?us-ascii?Q?J2xgGP0v5Dbl24sC/7H5Tvjt85CkmHY8tSSeJ6PZNKGSx6wzTS45bkani1Vq?=
 =?us-ascii?Q?UUf4j4ShS0Fk46yGXYe+mqLipxv48MaCIUXPyN3X3fJap+zLzPZ++KJ3K1sV?=
 =?us-ascii?Q?IS0Eq+bbg1GxeW/Z9kDzS9dhl8Yyxl/vDJKd/P5inHNsFazuwqAi/vWwDqVg?=
 =?us-ascii?Q?0FCfqp+LbqY4Rl/LVYqwQOc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b6b7a72-7096-4043-b728-08d9c6bfd19a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB2974.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 09:29:01.0860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MfReD4VjuNw2pzAdTPgRMrk9+vvJL7spxZO6GnyYCXWm416LoZo0xciSaJNq6/BUnrhbillOWBAzPIMTZsa3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6142
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
V6:
 - This patch is splited from the V5 version of Layerscape PCIe Power
   Management support series.
 - Removed the driver data structure.

 drivers/pci/controller/dwc/pci-layerscape.c | 152 ++------------------
 1 file changed, 11 insertions(+), 141 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 5b9c625df7b8..6a4f0619bb1c 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -3,6 +3,7 @@
  * PCIe host controller driver for Freescale Layerscape SoCs
  *
  * Copyright (C) 2014 Freescale Semiconductor.
+ * Copyright 2021 NXP
  *
  * Author: Minghuan Lian <Minghuan.Lian@freescale.com>
  */
@@ -22,12 +23,6 @@
 
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
@@ -35,20 +30,8 @@
 
 #define PCIE_IATU_NUM		6
 
-struct ls_pcie_drvdata {
-	u32 lut_offset;
-	u32 ltssm_shift;
-	u32 lut_dbg;
-	const struct dw_pcie_host_ops *ops;
-	const struct dw_pcie_ops *dw_pcie_ops;
-};
-
 struct ls_pcie {
 	struct dw_pcie *pci;
-	void __iomem *lut;
-	struct regmap *scfg;
-	const struct ls_pcie_drvdata *drvdata;
-	int index;
 };
 
 #define to_ls_pcie(x)	dev_get_drvdata((x)->dev)
@@ -83,38 +66,6 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
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
@@ -139,96 +90,20 @@ static int ls_pcie_host_init(struct pcie_port *pp)
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
-	.ops = &ls_pcie_host_ops,
-	.dw_pcie_ops = &dw_ls_pcie_ops,
-};
-
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
+	{ .compatible = "fsl,ls1012a-pcie", },
+	{ .compatible = "fsl,ls1021a-pcie", },
+	{ .compatible = "fsl,ls1028a-pcie", },
+	{ .compatible = "fsl,ls1043a-pcie", },
+	{ .compatible = "fsl,ls1046a-pcie", },
+	{ .compatible = "fsl,ls2080a-pcie", },
+	{ .compatible = "fsl,ls2085a-pcie", },
+	{ .compatible = "fsl,ls2088a-pcie", },
+	{ .compatible = "fsl,ls1088a-pcie", },
 	{ },
 };
 
@@ -247,11 +122,8 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (!pci)
 		return -ENOMEM;
 
-	pcie->drvdata = of_device_get_match_data(dev);
-
 	pci->dev = dev;
-	pci->ops = pcie->drvdata->dw_pcie_ops;
-	pci->pp.ops = pcie->drvdata->ops;
+	pci->pp.ops = &ls_pcie_host_ops;
 
 	pcie->pci = pci;
 
@@ -260,8 +132,6 @@ static int ls_pcie_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
-	pcie->lut = pci->dbi_base + pcie->drvdata->lut_offset;
-
 	if (!ls_pcie_is_bridge(pcie))
 		return -ENODEV;
 
-- 
2.17.1

