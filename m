Return-Path: <linux-pci+bounces-3103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5AA184A0F4
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 169DC1C216EF
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEB247F52;
	Mon,  5 Feb 2024 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qNH/U4VN"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2D4D5BB;
	Mon,  5 Feb 2024 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154489; cv=fail; b=DcZmfwi6VNABTdYGmCIhe7iQ9YOtjc9UuJK8VnkYKZ3Dd8uEx7XvJYrDCjEwhnfn0IHgfBvW7npfM0S7RRARxNnQuRJmyEKOHpbL7U7GBwvcuzfsvloiqDwmjlaBk3GdBajOu/FuMrm1+xf/hR1WaWPO+WhY7FdEZDCVlFO8xIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154489; c=relaxed/simple;
	bh=AnLF/iIt4aIp3Z832eDCHDw9f9H1DL2muCo0M5ChUCU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=paxf3CvuI5cc0WhS6v8XKloL5iSP+/0N7jufhVMz0tpQ7ZpBGGkAvylFc1dLHYulwA468r1kw22UfAkAuPL9jMa8hWCPpgBIzm/raHL6gzdTZBRMFtkecUNRo/29sJAQenmb7PcQ8mG2D061wXRUdwnrX2RfqL1qz/u7/iLm4CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qNH/U4VN; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBJBURgJZctkt3nLOg0RwxG099WMgh535rsLkl8Wbf6XrayWUQqiFktZqxAOPv83p7wTPHGGafwz8MFHdXdJjHQHVjQgzwNzSP4TmBvevg/YaJBnh3UR9MwJAAt/IyzZ5hvHr0h8BPWoC9PjhmrufAxY5ZZI0QQwSMKwcYIhh7o7RDsGleXaj7q6b/kOGtdNVbIPxn1VgXSRElNgV5Mc7gVsJEuwWQEMwFRYhVuFWDgyqmIqiIAwo2WHzP2LWzFyznnR4+SIzj2B8EH4f180eBOvfQ3ai023Fxkz88nuIkYK/CU4bnLAgwKCARVi/9E2v+w1HsXg2ZEMsqOZyMrb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFPHzfDYru0eCCQHEcLnH+p516ui0qyFqGvUErouu/4=;
 b=dZvvW+56v3Gja5jSWCMep+SRPx30lVbK077tLNNd5wzza/q6wATod0FCgAiiLZom16taET0femH0U0Aza4Oj75IPGe8HlXY4ZSWMbQww9lsX+86oLcHr/ucQGPpNTUhWxohewdNVXnr4WJwolFKqlUhhLsEZuLxnZREOqj3M9X6bu5Ygz71/4hleGiG9ggfCccAZHAMtAsuLomtwXw0oSxuCJGeyKYTcSTvtrbeePaVfGfd805OElP8Owytqa8XBsmhbk6jD7I1F+kP+++9a3SJCyE0dx7+9MkfJlZjtU8eh9SLEa0tmr5xWBfMPR3yw7LFm2lCiKHPdf3kGY38Fvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFPHzfDYru0eCCQHEcLnH+p516ui0qyFqGvUErouu/4=;
 b=qNH/U4VNdDtoPLziUKWT7Yv3NbOfAT2ubWTN8wQ6NS01/Cima0eMK/LmdF/URLbz95Umi9QGsYzFc7zpwCCEGfRKYJeARro6221ZiGeo7b7E3dNJ+HtDE2i2lSkM4PjWjDbbaLunwnywkNfRGBFOoIaKSEN1jcVAgh2CuygEPFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7080.eurprd04.prod.outlook.com (2603:10a6:20b:11b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:34:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:34:44 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
Cc: Frank.li@nxp.com,
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
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v10 10/14] PCI: imx6: Add iMX95 PCIe Root Complex support
Date: Mon,  5 Feb 2024 12:33:31 -0500
Message-Id: <20240205173335.1120469-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205173335.1120469-1-Frank.Li@nxp.com>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: e391cde1-76b3-40b5-946a-08dc2670bde9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rrXT3rMsmXokls2Kq4PmVKR/J/DlSoR3ZmJtngkNihKsUy4xzDeDyCFd8iu74yiVCjFR9wT2IDlYJ25N5vujauTD4xUqtCfnJbT6OUzwndbwQikVRkPfsiIySyWo53FjMnk8PssL//OwVtD386NEWDwF3KuPDOIIOwLYJQyyKLLs+cI4ymOY6q/YE3Qg95Ri+QiWjCjZNavrSqw4r2Z1e4sor7aVfPc46biEYQ+ZPuQ7W2x4jGNVFwgsAEbSMfbm/nk2XXfBkrykecAvmxG1M9r49UcEZaN9FenBI7BiP7J9qi6RR2HQ6XODlVsNoTY5FYeh8f7V4tRDuq/ZiQjkK/QHXjMG1diGfrDM1ew73PUmOPoaPOb1pCig/QdyepOEeDBc7WVvqjN3c/nYes3VYLCGe3ts+Gv1ODRf3v+ppySwM2XsUdbcggt7T97pJb2kx2bpwby+ZOLnnCiE4IIv4EqCX9zFpWUv4Qa0Tuet5ffC334SzC3Flq5eWst1snNaKribsGCnJSRCKJLD1tK3PcmUiyRJfkEHgPLSi94mYSy6RSR0VM4j2jdgcPja7wVQXoNH95w1T8whoujKwMCZpj43E+5GGCToihH2hehAGsNjzy/ysWAMSHqXZeyPwSlQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8676002)(38100700002)(41300700001)(1076003)(2616005)(66946007)(478600001)(6666004)(6512007)(52116002)(6506007)(66476007)(2906002)(6486002)(4326008)(8936002)(6916009)(316002)(26005)(66556008)(7416002)(86362001)(5660300002)(83380400001)(38350700005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YGraCGU6gp3+YU7ipSvW/1iIByDX+Wt1hK2UoAm08D7JDgB9tj4rzv50uEaq?=
 =?us-ascii?Q?pwhw+3preY7Cx0as+zn+xivQ3OfTESxEPH6VDmWvV3plssESvlPBBBwV/OIF?=
 =?us-ascii?Q?s55cpT7iwsG7HrteLlNJvYdtAyZH1IYChLy5wuNVR/gzOMGV0OTD0biwfNIv?=
 =?us-ascii?Q?I2pefxCV+L9H/au3a83w56EIru2obxMbdSf8AAEbG2WKIbWzl5LCwyIWfMJF?=
 =?us-ascii?Q?fqWUYrn6v26CQGdgqfbr7ZNrdmmAx//e2yfueC0XkMEHLiBozeVa2eJ4BLBY?=
 =?us-ascii?Q?kCeVJMNjPMpQQHpU2fcw4hfITCFKAxUaT0AJgW/a2cueKFFC5NV1ZNJurw13?=
 =?us-ascii?Q?Q7gFIWufgYL2/jEowwG+BsaHevfpxJ3jHJsCTaAVeW4Q5iWdRn9mBxgJKYcb?=
 =?us-ascii?Q?m/uI4g86yJc9CBubOkagzxW5/fhDkHRAUz2zZpJd4iRHNIgry3kvmeDeq1xN?=
 =?us-ascii?Q?DqvybT00HSIcSZ8jeT52hpl5fnyGE+CCWKoDr0dBef059/nFrIfy8/ggGvE6?=
 =?us-ascii?Q?04yfMz26n5tzzGCYWf7YLOBAOYshEKeOP4euS1y21FyxPa9vVLcrt0Fcy0OD?=
 =?us-ascii?Q?b84ZmTw2q7OnQG3EOUwhT8E5iG2et0jX8evFjnZvhsKwva/QNkcokYsOLar7?=
 =?us-ascii?Q?MvJaUeFTyU0HULiV/dhmbkmoLCepuqJCHJTd7/TNMbjmHl2EUJgtBGwwijLz?=
 =?us-ascii?Q?2n15RCoZFtcnq+muLaPt/a9rSV4HLFDSzTZTIHQi+kh/dfa3M9vJ/HIMGat5?=
 =?us-ascii?Q?QpFlzmpH/JkvrTOstYGOqk+vYE6KVjC5StPU7UcMcYEIXXrXbbrZ5tAogd/Y?=
 =?us-ascii?Q?3WhaR9asV2bY2KzEty1fXVrVVjzPbNAqxyWUHy6EcNGxDCHuY8RgylVrQJD2?=
 =?us-ascii?Q?Vi4hWOnwhlG37Mu01rYd+rE5AEhQo3qidsA7PxBMjVDtTFOlIPEg9kUdEarK?=
 =?us-ascii?Q?btZF549LHQ8z10ys6OcqMRKcTdfpDYlvs1OFMZjCvZgSLd8drEOpjD0SIiYj?=
 =?us-ascii?Q?itQ9+g9+ctvkilHkdP6TewlpuPlB+f6ZcBhG9V+51ws8wmTvnKSrJqZ3fj27?=
 =?us-ascii?Q?MtfYykVT7dVONgSTjwfmzr9ZcfWoB2wBjEvB1UUgw3Ki1Qi89OLcICtUEafg?=
 =?us-ascii?Q?bCVN9VsZCKkLXcMp2jo6x+/ARExuvjG8p5yco8ebfiyycMhzMNDcjISDhWtM?=
 =?us-ascii?Q?/hHxzFWZnw/eQ1VaeEePkuMlTYBANj9lBPSA+z5+1d1sHLlBkZOgM7zkTjeZ?=
 =?us-ascii?Q?MB4/nhXYs9Q8T9B0fqYhC1tmDCxMEFWS8QTCUgZOHSzxFgMBdBjU7axKKJD6?=
 =?us-ascii?Q?HbI0BcWba0clO6TP7sGlUT3zD0u7I+s/XcXs7FAINcIxlsw7ReKW/oEOHSUR?=
 =?us-ascii?Q?vgLRhAj/dI3oJY3bTBXJOyVlTgHbLrgxChG+tGQ4y4E6zw6YgqNgk426jNQC?=
 =?us-ascii?Q?4+9RXeJUqs0qFoEfr3Hzi2avxo9vI3G0Ter8eDVGySEkkiezrvbD4yIMvF/K?=
 =?us-ascii?Q?J+eWpnA2gFbwaRsMWCbJWbBfZuYZ9dYtEo9fhuU9SLUb481pTHfZiM5C3/Y0?=
 =?us-ascii?Q?dSK2lNrUrNHRmJtDC83OZItBZw8X6+X32NY18EGR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e391cde1-76b3-40b5-946a-08dc2670bde9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:34:44.5618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7O5FhPCXaE0CgKUeh64GTOX2IuFZLxDnLvvdY5JvdhTZbNsTa79S717IdnLhw1F9Qlqj7LguSr0BBC90ACDDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7080

Add iMX95 PCIe Root Complex support.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9
    - Add mani's review tag
    
    Change from v7 to v8
    - Update commit subject
    - add const from regmap
    - remove unnessary logic in imx6_pcie_deassert_core_reset()
    
    Change from v4 to v7
    - none
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 82 +++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c266b9f098a5b..183bb3b31cf16 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -42,6 +42,25 @@
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
 #define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
 
+#define IMX95_PCIE_PHY_GEN_CTRL			0x0
+#define IMX95_PCIE_REF_USE_PAD			BIT(17)
+
+#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
+#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
+
+#define IMX95_PCIE_SS_RW_REG_0			0xf0
+#define IMX95_PCIE_REF_CLKEN			BIT(23)
+#define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+
+#define IMX95_PE0_GEN_CTRL_1			0x1050
+#define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
+
+#define IMX95_PE0_GEN_CTRL_3			0x1058
+#define IMX95_PCIE_LTSSM_EN			BIT(0)
+
+#define IMX95_PE0_PM_STS			0x1064
+#define IMX95_PCIE_PM_LINKST_IN_L2		BIT(14)
+
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx6_pcie_variants {
@@ -52,6 +71,7 @@ enum imx6_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MP,
+	IMX95,
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
@@ -63,6 +83,7 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
 #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
 #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
+#define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
 
 #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -179,6 +200,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
+static int imx95_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			IMX95_PCIE_SS_RW_REG_0,
+			IMX95_PCIE_PHY_CR_PARA_SEL,
+			IMX95_PCIE_PHY_CR_PARA_SEL);
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			   IMX95_PCIE_PHY_GEN_CTRL,
+			   IMX95_PCIE_REF_USE_PAD, 0);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			   IMX95_PCIE_SS_RW_REG_0,
+			   IMX95_PCIE_REF_CLKEN,
+			   IMX95_PCIE_REF_CLKEN);
+
+	return 0;
+}
+
 static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 {
 	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
@@ -575,6 +614,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
 	case IMX7D:
+	case IMX95:
 		break;
 	case IMX8MM:
 	case IMX8MM_EP:
@@ -1278,12 +1318,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->turnoff_reset);
 	}
 
+	if (imx6_pcie->drvdata->gpr) {
 	/* Grab GPR config register range */
-	imx6_pcie->iomuxc_gpr =
-		 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
-	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
-		dev_err(dev, "unable to find iomuxc registers\n");
-		return PTR_ERR(imx6_pcie->iomuxc_gpr);
+		imx6_pcie->iomuxc_gpr =
+			 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
+		if (IS_ERR(imx6_pcie->iomuxc_gpr))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
+					     "unable to find iomuxc registers\n");
+	}
+
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_SERDES)) {
+		void __iomem *off = devm_platform_ioremap_resource_byname(pdev, "app");
+
+		if (IS_ERR(off))
+			return dev_err_probe(dev, PTR_ERR(off),
+					     "unable to find serdes registers\n");
+
+		static const struct regmap_config regmap_config = {
+			.reg_bits = 32,
+			.val_bits = 32,
+			.reg_stride = 4,
+		};
+
+		imx6_pcie->iomuxc_gpr = devm_regmap_init_mmio(dev, off, &regmap_config);
+		if (IS_ERR(imx6_pcie->iomuxc_gpr))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
+					     "unable to find iomuxc registers\n");
 	}
 
 	/* Grab PCIe PHY Tx Settings */
@@ -1456,6 +1516,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
+	[IMX95] = {
+		.variant = IMX95,
+		.flags = IMX6_PCIE_FLAG_HAS_SERDES,
+		.clk_names = imx8mq_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
+		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_phy = imx95_pcie_init_phy,
+	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
@@ -1500,6 +1571,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
-- 
2.34.1


