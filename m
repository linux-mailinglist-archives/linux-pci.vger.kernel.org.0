Return-Path: <linux-pci+bounces-1234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE3F81A826
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15968B22EC4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91806495C2;
	Wed, 20 Dec 2023 21:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XH5Cpych"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8D4A999;
	Wed, 20 Dec 2023 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4Beo1If6PDJaUUpQ046xdWU6twkXYI0SfoeFQnXCtln0f5VKrDpsiNZACxBriFiRXWX9eyG8TKwuQ+HaJkzn9ZGweoeOLqwwMGYKIjr6jqcczVBJ2MB3PNpIXES1hvKNhSJDV+68qXHsC/JwKe1ALf5hvae3By9mVGlljRB0qmzDki5agNVM14WUDCi/K/aj1cClmS6vIUy5nSCSbQdpN/U2lPCl7yf0zAxNEbF7fu4RqVnRqqCs9Q7dCLpBKlSMKjiAIFYMsefuwtj63GQNg9X+d2ES322d6glVB1ldiNq5cvonmvFO2O6vOPUn/RDaF0u4wTrhmc9nLHNEJAL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mwdd+DiAZ3s7dB+tmBXPZ8hiA83HBFxwkXxyNbl3QHM=;
 b=S+++sYVEPVcV2v/EW4otVOE5JfNMPpkGXkeNj05N5Sy8u/yzxsg0JzJ14oqXHrhgixN6Mai8VZH9qwEdiGQtZTeXm4c4z7Jbgjmm4zJ7zf31yO2B7NaGrLiDcKZxr5dFcz43EpaRMNWeS30fZjV2itQV/j49ew1wtp056jzQ0fdwz1c7tpBFTeUvcP9OwzpDZItKgDoltGwOimHgB8WyKRxAXrHkHGaXvUI/augrPp0Ukqe8ITA+P1F7EOhzS3QHDMkTJqcviuyJNRSd1hRwN9g1U95UQKpe1s4+yUnOs9YDGPZaBWDgg9qM+iYY1uaRoZwLzt4aU2q/4cugRbWSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mwdd+DiAZ3s7dB+tmBXPZ8hiA83HBFxwkXxyNbl3QHM=;
 b=XH5CpychsxRwx73sVPzgMQZ8wDQXXKRN0wiDNFLA0Q6VSq1nKo3OG1AZiCMyPgaxH/t2zkmfhW+x2IMrFX4rCn+ON47hIWxeWPI6YiK53RsRekzQO69U2P3Zv//HPcA84cw/DVlkFWon3mw3HDv/+Q2C4RpEY30C8LvzgIdyv2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:36:53 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:36:53 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v5 02/16] PCI: imx6: Simplify phy handling by using by using IMX6_PCIE_FLAG_HAS_PHY
Date: Wed, 20 Dec 2023 16:36:01 -0500
Message-Id: <20231220213615.1561528-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220213615.1561528-1-Frank.Li@nxp.com>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0110.namprd07.prod.outlook.com
 (2603:10b6:510:4::25) To AM0PR04MB4834.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b04fff0-645b-4312-dcfa-08dc01a3c80d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ILTDGatUCp4qnfLVrYwEjwR7ojx28/1+cgoNVltycYuaWx1BpDsUaagwzWJSvtfMSkczz8DOSJ7JoWv/34k8ko5qC1m/oYH3uj4UVr/lg4C0vrfuePZvSEa+A0vnHZDUlNkhtgO7BykV4ZBJHXCkOBA6HTvUj2OHRvzLfN9bAwGKIz2CIJFVd1ktv4ujseu7Q7N7h1y2EKhqpuwpNskZ2eOFUztB07sOIzRgn6FZ+LonBRiRtiO0+hAMGtgvrGHs+ZxeTE9DvhdRttolDko6bEwoehbgHVpKsaK6iOhHFqly18F75e6CfEVpOSz1cCWXYtthYKSE+PtRwuDgV2eh7Us8ftiJpX7iPZ63HmhP/g441h/XsdArSDEUaF9SPEGZ5/AAvyOoXWUdMzcfOsO6rOKDT9F1qzdj6N2gnoFXkY9Z+GMvyejDr69sc9CWHwY4v0/aScuvXWpcXLTc2e3be8OvJKgI/+7rEh3oDywYZUKP3OC0Wyl0+Pi8cT+CHyv1RXK0YfjXtnAUAJtrCrlckaE0x3L7jRfmH2p7bLBVrK+5e+HXC7N412Gy/D/fEIAsBCnukhTyfNstzpk6g+ppqQNts1qQaOOBhSVxOFDU1ZK2RyBGDvW8H7Jp08WlbFd3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lnRCbQ0i0FZbXWLG/tlBuhc+kIDiLJ3O45kReaI55s4K2jmG0ht9rCtary1p?=
 =?us-ascii?Q?mc0G5QM6sx/7KH+NyS/NrJhUqt8C5j06ocpHi8yBO4MS8gLqnBKY3wW5NnUi?=
 =?us-ascii?Q?HydC3yXtIfo6oQY846I3B7v9X0GNPdOm8dvjUpRyo8FmnyoQ8ljFQCc5JBqY?=
 =?us-ascii?Q?zyzHEiQv5bgK+PHzFtN8xbg/W0sC+ABVl0DuZ5zfDC8Ijnb2HgqBI99RKFEc?=
 =?us-ascii?Q?VED2fpLg8WEG0flF/UweqMuywG7gwKo4n3fpXs/gyZ+cxXZ8jYa3SZJvkDiC?=
 =?us-ascii?Q?9HcslcoyNdPJsLNmOXQzHhOOB4x5wgW2k4fg9zqRifyRj3iwbrtkmM1RYCvi?=
 =?us-ascii?Q?fLEVqgxaURulobp0NLfZqeTPUlC9xDhH05ErKIeI1yABTQ3NDbfmP5kjUH71?=
 =?us-ascii?Q?8rRNlyFW8AIac/BPGNGrXenqDj1HUKtdPuw1iAu6u9tRkfuuEh4le99DTpQo?=
 =?us-ascii?Q?heGaI29PmpUIVkKZQfhL3OQDb0W43JnUTKrtItPQIt3ErBn2gPw8uEqEXfZ6?=
 =?us-ascii?Q?VVaInq9yp1IbL+3E18m7X4glk804uyR8XWKwsOLg0Hk/3pnUwtfiYFR4GoN9?=
 =?us-ascii?Q?GwMskRFn6mEDd50v5NDMaOJlXAHWakrqqccrk/llVT8YEuyieiZ97ItFqC3A?=
 =?us-ascii?Q?l4PzK0UbFU/7j7H1psrL5uIcZOqhGAj/4arKcemp5z0UGiK00NPmTimDWs0S?=
 =?us-ascii?Q?TSmbIi+7WV2yrtcesaDAgm8Qy4pVrZ2WRRJGFFaPaPhyaJ4vPO/J/Nu90KWm?=
 =?us-ascii?Q?X0sHuTB8jl+TScPx+qRQleg9K32DYZcgJZCUGX+GZtqP/QZ2hyrSf4fNzOu1?=
 =?us-ascii?Q?ToXzFNP32xulXQmOcDel3wXjX3WsmRL0Ikz5wOv4evVLafOry/WKgGuMaVGa?=
 =?us-ascii?Q?NOGT2wcXBG5hvd/WGob0SUepqmKvAT7GegJV0cQjevHozreqdOpD/USU/8HW?=
 =?us-ascii?Q?Bc1aSdnMiCOlvRJkuzTggcoF9MNVAa7x3gI0EofnYiCro2l2aPBYEn0LPczr?=
 =?us-ascii?Q?vykNvSJZljeVh0rosEOlYDkXopQbp7gS1kOxGSJ0b7hdEqNPojqxd1VuNp2I?=
 =?us-ascii?Q?099ZXhA3Hh0o+rNoSaUPEL8I80TMZJ8TLcx6lxHUsua617g3h6rAIGFxVVgV?=
 =?us-ascii?Q?FuExMSrOXpCVKt47u1qKf9pZwsPsRXCYtYLJDQndSed1TmEQ0cf3ISXxntj9?=
 =?us-ascii?Q?EwUKcW41/oUffUap+RsFwCg8TFRiq5GIuzdpZmHHg7V8jbppDj2rARN1EdLQ?=
 =?us-ascii?Q?ii3Q/iUwEhm9YcJvPqWrJLHfExDKaJtcLHbsrtd1Zx6TzeckNGLvpMI8aGhB?=
 =?us-ascii?Q?OQYsYFjOVFMnqFAfmNO0agYu7/IGa5UG871aIdcci/0h6wqx3opy4V7i0XQj?=
 =?us-ascii?Q?dC26oHYBwbiPKxF55TiHMDVGBM3YzNoAFuzQBPw8CQ5932L86QAOHP5bDdUp?=
 =?us-ascii?Q?noTjjMUusnOTVUO/0/H7jgVDUOi+VHE8nZsZBNmf2uw2AC3+zeUCG9axYdbT?=
 =?us-ascii?Q?O2i/hKgQzePOjYzM7WFIbSJd0eUFH0iNaNRfip0LVrPeqDVdKxeXvxqDowrI?=
 =?us-ascii?Q?ZE45kYO2Q3Md+jLV6eI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b04fff0-645b-4312-dcfa-08dc01a3c80d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:36:52.9986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o01V+wqDTfqMEvr9bE2o1zGA2gIdO3BrMh1IG4v3YM3Ty3KVkiBpqz2l05aZ5CegjowUKB+I2sFNG8UDIKMsEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

Refactors the phy handling logic in the imx6 PCI driver by adding
IMX6_PCIE_FLAG_HAS_PHY bitmask define for drvdata::flags.

The drvdata::flags and a bitmask ensures a cleaner and more scalable
switch-case structure for handling phy.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5:
    - none, Keep IMX6_PCIE_FLAG_HAS_PHY to indicate dts mismatch when platform
    require phy suppport.
    
    Change from v1 to v3:
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 50d9faaa17f71..4d620249f3d52 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -60,6 +60,9 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
+#define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
+
+#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
 
 #define IMX6_PCIE_MAX_CLKS       6
 
@@ -1277,6 +1280,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY)) {
+		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
+		if (IS_ERR(imx6_pcie->phy))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
+					     "failed to get pcie phy\n");
+	}
+
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
@@ -1306,11 +1316,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
 					     "failed to get pcie apps reset control\n");
 
-		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
-		if (IS_ERR(imx6_pcie->phy))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
-					     "failed to get pcie phy\n");
-
 		break;
 	default:
 		break;
@@ -1444,13 +1449,15 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
@@ -1462,12 +1469,14 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
-- 
2.34.1


