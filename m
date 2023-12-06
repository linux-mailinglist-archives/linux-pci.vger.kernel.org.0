Return-Path: <linux-pci+bounces-581-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F63E80744D
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 17:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7271F216DE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482CA45C07;
	Wed,  6 Dec 2023 15:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bT3BUJHL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C835110C3;
	Wed,  6 Dec 2023 07:59:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7AxGVTKVR0pjpfF/ZM4gTbUPdwlK9ZA0Twa1OjTRu3RWJXOjLtVWROiZ/ajtiUDDnrXTkmDxRTDUOE9VtS4JUlzmhAGDGg53faW5jE1QLzfxo2wO3lon648woHvFK9NFu80jkdIAmCwwbRqzrNvFveEJZwa8ZzW76f994+M5O5BJ50f90WlSOwCNn4JKo2Slk+QfmoW/JgPl+vt+EnKEnhr12Vg9EiKmBemuqin0GnWi391yZiXk+EyRQt7bvuADlWzZZ2G5ESw6kAfp/f7jBvmYsp50yWr6Q+oWYecIVtuQWRbWjf0py6aIRNi8H7Yh8XVhwLnVsbUCbxbvfmH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UbSzpiXuG5FYP7fd5ONqzOID+nLthrOouWqAEacFA1s=;
 b=kN1vB5HEVas/IRfCId+yaKW0Y1RDZ1L7vovzvthWFObX9gnMl0FmCrLFgHLgXOaKxVkF6yU+LcPfi/T7ruQHrBfhVviSUPnbXOntAxdLhn+OeAHdGEasdUcp1c5eAUSSHv3fyd41TArWdS14n2uyd7p18vxcUYD+0soPU7KKtc44YhgdXPc5iPueGGMLOw0/iHFAPE0hPHz365YMX2iHdySZDhhARSQqt1aKsS1aXlr2dZIQtM/IySEnUIXrG6vepwxQzNW8PXB+k9WP54H+qoWq384UuH6dPjEOHd0sK81g6k6HvKeCN5BGhFt2ju/NCCuvm4akcm4t9hWWHHQFKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UbSzpiXuG5FYP7fd5ONqzOID+nLthrOouWqAEacFA1s=;
 b=bT3BUJHLMCHIO50S6mMWmijA350H+PEM5VmJnZBBD7X4st/m/i46cDt2xBNNWXr7ttYm7MqYfrYLRiuKn38LlOfs8rYxOjEZgTLtvi5nI3yYni4ZqwQL5iE2Ocv0+TQRQPVQCIM+vfE0I3JMrOO7uz3N//3kliq81SWV/2mKt44=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8123.eurprd04.prod.outlook.com (2603:10a6:10:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 15:59:47 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 15:59:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR IMX6),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR IMX6),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/9] PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
Date: Wed,  6 Dec 2023 10:58:59 -0500
Message-Id: <20231206155903.566194-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206155903.566194-1-Frank.Li@nxp.com>
References: <20231206155903.566194-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 63313520-f9f3-4fa1-5872-08dbf6745f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YefGQEIwXTJw5uN17HNXaazK2cAC3fhNcbBZV65GLMRH83k7FUiAUzA7zn9FIxZPMy6u+AUSGVeqytE46PQVhlojIUBbcxntZqP4APp4coukaAEYRw11RLjzscV5UaqW3i3XJDNAw43+TMIieMsGYsnIfB1x3LlW3WUDNaJTdQgOuyuP4l2U5Gavg7oIRGTdP1DhnJSl+QVuYGE87Z1h15/6QpWlEIIQgkHIwZSaoZy9pP6QznJ8NDiRwvLtGSCn41JX/vRZ3CoCj0E/Cs7faRrqIhKDraAieeiFCxrtYHi++FY2BbZVKId0I0ffXH6vJJoaa5ZHvZFubAnlxck+z4qGn1sgsTPLpdbRho3Of4OAeaAotWJbysrofsK3JRZY0nZGhwPGQ36sOyfhFyfqOjTZ3dLD9SW90gOb4DsTPoK5Y8km9TlqcVugOJa7dC5p44L/cAtY59Yu4eDtWW5ZGNiDbqpC6UhUYicPTnu4cjeovn3FhTMqi8IbU0hDP+IL+NzN4BeIoup2Bo5S+BhTCpjr4VAhUkvoQdPw6EOXswWIDg7S2jm4dLWvRo7cEyPGC6bOs1SXTXC14Lg2B6DxlNtMgtAy5+dBUbw+W8EgUs8sRMr3jzSkbPkg+nVBEVXlz2f/NQvyPxdTFEfYiV3OaA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(41300700001)(83380400001)(36756003)(6666004)(52116002)(6506007)(2616005)(26005)(6512007)(478600001)(921008)(38350700005)(6486002)(7416002)(316002)(66946007)(66556008)(66476007)(86362001)(38100700002)(110136005)(2906002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GqeT8WLElbOiIwjb1MnOUkWcG4C8jFBcGQYNAYKvuX3c8uXu1tmq9GokB/xS?=
 =?us-ascii?Q?An9n0hwS+AZ+PocolGAM0XJe/hVHw1uCUbJfIEJeHJRMExmB9Hydl35x+vD0?=
 =?us-ascii?Q?yYMaZJIG54G/Rmt6MCj/a+sEYujyHRcqqd4PbcgcJRnm/I6Tj1Sgy9o7Tylg?=
 =?us-ascii?Q?Lmw/pzeaA63qmiVHX7yNxp4DY6DSa22VixwpFP89AYjQsvsohgfgb3N5vgDf?=
 =?us-ascii?Q?GeZZV3qMzLG87UHWSMwqyBW10zjonwyzACaaK1d5d8bJxzfn2ZcXyN6meiis?=
 =?us-ascii?Q?wn3vRKhmuCCvpyeL/jj3qzSNNv711eZkCcm075+BntbeLW0H1VShi78fmVa8?=
 =?us-ascii?Q?S94ERYSelXoEd8IusUV7I/2p9mUX4omuIHkIGuSLtnqmHgS35BKZLOmEG6Lh?=
 =?us-ascii?Q?lSckni9HUxpMtYZ5+z2fewiSHbYGuMUWQmciNHM2ENN1gkH+nDYVB2bP5Rbt?=
 =?us-ascii?Q?yEW/nnc8Fl8yhrnMW9wqtIN6XXXrsDeLTEQzBipWado2I7pkxmvckrm0Hmb+?=
 =?us-ascii?Q?tm6wQsJfbFIk8YkBdciC1zUvs4+ZBr3HZQNTGbLtyi9wWPHgSZ8LAIn67zHG?=
 =?us-ascii?Q?4v7DDFav+B756EPT4dclttWJUhNapKyPe4pyf7Mxk17LIgEVQpfzJ4Sx8ika?=
 =?us-ascii?Q?p2nY4HYfY769Fh/i/1sFrAQeKMLTR5FKLkAlTjPK5yh0MtcBx6W1ZJb8k814?=
 =?us-ascii?Q?0fjd1k9a3itJ0aYi+Lv7o8WmLiXyZKiZY1XKyd2mXiJ/fWEpdrBLlkS+WAW2?=
 =?us-ascii?Q?2fXX8qz+CK2dLftHBGV1KnHF3ly20RV6jw0nh2GJhuuew4Fs7UTZgAK+ogOe?=
 =?us-ascii?Q?FBjOQ2quofzsCc68UM6JBCqf06EsTcrshQR1tc+jIR9KrZZwi8E7lyR2hXW4?=
 =?us-ascii?Q?6Uq81qBXECnHZ6UECqdOYehh0C9igvCwIIlT48AiWAAWdbyGdC0s9Iepg5BG?=
 =?us-ascii?Q?KK3P3syzSo+npyS59eQXO2xsQd5oiA3b9B0k66mwg0j2aeG7JcyHvJoIqvcB?=
 =?us-ascii?Q?nEadJ633YUKqcYVJnNMhkPSDNCkpYpjIhgB7wW+XtME8QSioXqgrA1VwZKyG?=
 =?us-ascii?Q?6H5VUuJ+OCGmvnBrLIt8l3hifcyjsIQB20vfKbgpg65OWn4KJCBpLbsg7Bfg?=
 =?us-ascii?Q?kbG8io6O9XFGll03wG6l7LXPnh2T97add1zAEscgavahyf2FNI8Xe7ZDe5Hf?=
 =?us-ascii?Q?TgbaPG0l56qoDv1dkvHqgkhPz2jWuS0c3o87qV1fOB2TplBBdpJ9Q/sj0Xck?=
 =?us-ascii?Q?k/apA901q74C/4J1XlAW+2tVfgZpW8PtolHJtl/o3xi7aQVbc2vzv1meHKg7?=
 =?us-ascii?Q?xQ+Aj2vxgZ0UmCl0vW15xVL3RK56Rmij9TEkqKzM8Als5MFCSMzhUQlPnUIp?=
 =?us-ascii?Q?PAFM8XYKERnk8BNU+3iKvIUOTAHsySaFnKb1omCMZxVScg7L/wEiZ2yKRXIS?=
 =?us-ascii?Q?YwTrXha/UVwOPhgbxzs+WGcQPbStBoWJbgvPmZVHfM7TYEN+EQcFu0xf1KDS?=
 =?us-ascii?Q?VhWhx7S78DgDM5u41MLilv2/zpgzb2JxEu+9lyhEe4gxC3VJDg5Wx4AqskYz?=
 =?us-ascii?Q?hiL3TEBMcyuEywUWcLU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63313520-f9f3-4fa1-5872-08dbf6745f26
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:59:47.7685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pL1d+c79vm7OIjg9LDLbpAaKlQD4QGHCqy3FM9Ey5MPccsULE1Jz3PjvwwK0Yil4qcI0xZZn/nCj/y4TyY13ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8123

Add drvdata::ltssm_off and drvdata::ltssm_mask to simple
imx6_pcie_ltssm_enable(disable)() logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++---------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 239ef439ba70..334e714a7e96 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -75,6 +75,8 @@ struct imx6_pcie_drvdata {
 	u32 flags;
 	int dbi_length;
 	const char *gpr;
+	const u32 ltssm_off;
+	const u32 ltssm_mask;
 };
 
 struct imx6_pcie {
@@ -815,18 +817,11 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6Q:
-	case IMX6SX:
-	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_PCIE_CTL_2,
-				   IMX6Q_GPR12_PCIE_CTL_2);
-		break;
-	default:
-		break;
-	}
+	if (drvdata->ltssm_mask)
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
+				   drvdata->ltssm_mask);
 
 	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET))
 		reset_control_deassert(imx6_pcie->apps_reset);
@@ -835,17 +830,11 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 static void imx6_pcie_ltssm_disable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6Q:
-	case IMX6SX:
-	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_PCIE_CTL_2, 0);
-		break;
-	default:
-		break;
-	}
+	if (drvdata->ltssm_mask)
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off,
+				   drvdata->ltssm_mask, 0);
 
 	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET))
 		reset_control_assert(imx6_pcie->apps_reset);
@@ -1451,6 +1440,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1459,6 +1450,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
 			 IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1467,6 +1460,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.34.1


