Return-Path: <linux-pci+bounces-1240-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 315DF81A838
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B889B231AA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53793495C7;
	Wed, 20 Dec 2023 21:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ULuMalkg"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E57F4C3BD;
	Wed, 20 Dec 2023 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeH1x6HcLYeTAQsPBC9uME9Mli91OJlbDSc1minNb84QqKwigeo3dAyseJfJptVcMpCGtDYydNgkTbUT6efI8JGRqrOy5gWSaOCIVnu4gkWnqDui9E32RskrOy/eIFHxEXzO02syPNkkn8vs8JhAcMMZqDRhWiGlFsyowMZtGEwHv6bvXgbVVUurHEz63UffaUc4/Es+4qKnGKbqzHvyrhDw4ooFelMb1BvRlQQy328klySqOTI25NYF18vODkOPXzwC1rlZcuAcy5IJURaMmQK1fqPN6LFBUEeHGZsgWew9CNhnWYvwfBwyqDz9jFNP//mVBqRzdQ6v5pDCTXMyjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfBQoavpwzUAjcM4KwLeAI4dwVXf+6SQBsdUZVKowR4=;
 b=DGFCxjqJxKrbGpxVhtHQMVMV3/sEG0WlWfJvBFiJL9/bDuJZUyzKBHEhb0L1h5S7l13apR+XqMaXeWCN0tZCtng5EMaKPLqzrqVE2osC7tc44qLyF4TcPdteVA0QY9IXot5RiZntaTkvRSgPc+DQafrxzXQr+/SNP/ahxrmuDOmRQjNkDUNcqIMvuwllyf8BhNpom9SAPuMC+z+10gTx4EdlHy0LF6cjMJCfAxCzyMe7FbipjRwpDoX73+lJz6Q+NPwv8YYQJAYCmDc9FTg0q+vUC3vnGNm9MGlkYcxboFUN4wGB+RFkgk7YGPK/H21laqQRkSNUV2Vpmuqtvdn+Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfBQoavpwzUAjcM4KwLeAI4dwVXf+6SQBsdUZVKowR4=;
 b=ULuMalkghjMc0GCB/j6739vRA46x98mBXviuxtdxVsOaYwpkis2/Kr7p0uZpHDfkUDIKJ+FH+dAnXUzsDkZ15TQ3+W4CXqFMH9GPSxe+y7Dh5xuKY+H5lXQ8/YPnsdx1JvVt64NHMMhNxYjiO99Vx/V+qNV6dEmGPEg6RUnbHSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:37:23 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:37:23 +0000
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
Subject: [PATCH v5 08/16] PCI: imx6: Simplify switch-case logic by involve init_phy callback
Date: Wed, 20 Dec 2023 16:36:07 -0500
Message-Id: <20231220213615.1561528-9-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: de4f1b5e-885b-47c9-6421-08dc01a3da58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FKa7Ib/MysSv0ScVHvBcQFWsSXgSiiB1s5OsIydDQN0L5/nt4tTMAFcSdOEjzXaSTGGXAFgO0dHCB0W/LrEJJ0G4QB5EZF4FJBBPPckai8zfWdNX+xjSoDIiQdqcFHPdv8ZlV7F9CI8AWvCd+cugh2beqLKnI5X4xty4DGoccI6pm6/8HpH8iQZiJrAFkdlRLzmf+SfP76V40XQqM+uml21AD3jo2aquy/4Mt37vXaACsJS8s6P3hdnvaIu6fwYsrCOZM37A1tvD9a1HCrKrtlac1bQu9bZ039/GSj/TJfNy3kuTY5yMzUn4PBaF4rIKXk8tWFXUdLzJqWNoUyWSO7tj7CJUtYsFkDWbg2zL6VhGSBnza/wZUelVIWKaJyujxLSxF3Z/0/E1AKVU08XSxuj49zsdnj5LqfFsz9Y0lHuoCgmr6BfdfMtEmlomV1dI3izyQgxl1b7vr6/Iq4tQaJAigbvw++aNnu2cIrJwd9FWKRqzj4ki0mrc0GpFfBYF9MJP/G9IVA+P1UYFf2+3E/TFH4B/sWuKtzmtACXdTptvtWtkg/j2cup2WghfBq5xCgkC2RxoKqKBJTpSYznUMymaZvLIJE28PHcO+bhRq8XJpZxka/PHqMa8zb5zGtXtbKaNLjMA5B3OnIyzDniYKMqQq4oi8UpswGPXDgcnaeA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230273577357003)(230922051799003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y0aFqo5lFdiXckIQLkQF4cEX71udWGyhqc24g0oRkc6joNbZfn3RNVE4+OGh?=
 =?us-ascii?Q?lZxcbViJ0i6T0TdzJGIOD6b5QJ8wBrlLKwFKKfuZ7lVlyDuPazcp5OWcf6nQ?=
 =?us-ascii?Q?TAXU7ILI/sYbbngT4BY27jWKvB5Y2dHyG2Mze2XtZbX4YD5UVFSwhMIA4BY9?=
 =?us-ascii?Q?49Fvjwhl+QZDLdSTg+C+4gkesDBUg8D1T4Hbl36wRMzy/QtBXfvBWhEEQRTu?=
 =?us-ascii?Q?F5itH+QpOWFUalyMs9jELX6pFW8rz70tqs6AyOQo+Mh2wDxZzFqcurWwL9UT?=
 =?us-ascii?Q?VGiPBvRP5pIQYXnGTItdyIpQGnTJoBY3kbhW7koh5hAvM1iYu+UhWTfBQaBi?=
 =?us-ascii?Q?Z8XNBmMuJbJ9oQlhv8ShHHCEbEzZVVJqqiF5QGCDkOPf9L4ht+pK2/chf3Nq?=
 =?us-ascii?Q?KU49UTVDHEl84B5kYMdI1oqgnjjU65mT4qJ2k24Q1PH2ejaDsnmGGDqDuN6Q?=
 =?us-ascii?Q?AtE5HgJJFHMGGdYHrEdEc5q3NLrFCUyPiqPJgS+D6PQpeDa+BVLj3FE/oO1W?=
 =?us-ascii?Q?ZGfrPrSlxHD0ZgBGYaU2S2IRYOx851l8r3jhQoUIrutciiLuprDZbdmwOSgD?=
 =?us-ascii?Q?TVv11Mh3aU32Bl0E7kdVV/IU1NMBcqJiA2pxx3qTn31Ncqxp2cSSuPD+306B?=
 =?us-ascii?Q?v+w4KzFXsdmgoGywnkfDbEB5yxsLRGZNlhCMBtAjq/YghZVjVSu1wBalfiWu?=
 =?us-ascii?Q?N1mOljPxOYoa3rZkSzlE7vcY8xFjCnCYwIPKIl783jCaomCTMN1tf5Qwi/BF?=
 =?us-ascii?Q?txAGrMiA244hrBdROx/CIMaXv/qy9LYHbwVmGbcAOnLo9PmJrkD4+y6LO/4v?=
 =?us-ascii?Q?8JETeW6jodkJEVaqbRxf1fGk8kjVkx3K9QwWgz+g6/44Lzwkq9a9rSUSVXHz?=
 =?us-ascii?Q?+7ImAjgh2K9v8SIPjgKwu5Kz7NA3MqvlDX/R7LXcyvFPDW8pO/Ye1SlVvWjj?=
 =?us-ascii?Q?ipfSaDQ8O4h42lzwAolx3ymkov3gQaSA/NQvIdcACI7+If4fRVUwQ57Grwbz?=
 =?us-ascii?Q?KKGGyMtsd14/XDKWv42PhsEGRN2t0PDVCrpYMYFY/kALg6spopXynZoR1ums?=
 =?us-ascii?Q?FiBNMDHQpIgCYSK/RkM7LcBjGJI+r1EIBrlhRHrAxQR2JZWxAA97kc50++3J?=
 =?us-ascii?Q?twWY84yFWWlP8+1HZTN/zNEichfMvKS5pnABCDVmV4OG92g0VLaxmjwgLmai?=
 =?us-ascii?Q?+8Y03arbradLgCJInjno/TV9ONSMLQweEPjftEPF+XsF6LQ8NAenLj/8bgN7?=
 =?us-ascii?Q?n2OezvwYea/stO3iIjqSyeMsxAHkL+5ogAjOsZtDeJIOpuYYbZEC2LIeuvt7?=
 =?us-ascii?Q?LAgtapywwF9SfL/tx1UyGur3N5VXBLoRv/HtWEfkL7DltRR0bay9IjitOc+p?=
 =?us-ascii?Q?99FyPj/jQzn/ZE443X5AkVKteFMytn5LEdWx7gqkrPvMIY8AyDEp0S06viq5?=
 =?us-ascii?Q?qUXrWzg+IA7P48TdaRJJgwNDPy3GFVsrliTzzB5MlQs/ytySUkdF92il47E8?=
 =?us-ascii?Q?KRiPVUseibSAn7SXBGiTM0y5xO+v6fpwjmorD6uFRTbl6PxdpusKjOzRyiGY?=
 =?us-ascii?Q?j2HLADdZWe0MI2YwpsI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4f1b5e-885b-47c9-6421-08dc01a3da58
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:37:23.7120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UXvuJIkbMt57SctbOrFxmLKA617Tnm7qozya7hmPoWDDCDapIfE5JxyZwyZFGOdSjF+LJ115JcqurSpT34jbSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

Add drvdata::init_phy() callback function, so difference SOC choose
difference callback function to simple switch-case logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    change from v1 to v4:
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 135 ++++++++++++++------------
 1 file changed, 71 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 717e8fa030deb..d66a2db53bdb7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -69,6 +69,9 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_MAX_CLKS       6
 
 #define IMX6_PCIE_MAX_INSTANCES			2
+
+struct imx6_pcie;
+
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
@@ -80,6 +83,7 @@ struct imx6_pcie_drvdata {
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	int (*init_phy)(struct imx6_pcie *pcie);
 };
 
 struct imx6_pcie {
@@ -323,76 +327,69 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	return 0;
 }
 
-static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx8mq_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		/*
-		 * The PHY initialization had been done in the PHY
-		 * driver, break here directly.
-		 */
-		break;
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		/*
-		 * TODO: Currently this code assumes external
-		 * oscillator is being used
-		 */
+	/*
+	 * TODO: Currently this code assumes external
+	 * oscillator is being used
+	 */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			   imx6_pcie_grp_offset(imx6_pcie),
+			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
+			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
+	/*
+	 * Regarding the datasheet, the PCIE_VPH is suggested
+	 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
+	 * VREG_BYPASS should be cleared to zero.
+	 */
+	if (imx6_pcie->vph && regulator_get_voltage(imx6_pcie->vph) > 3000000)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr,
 				   imx6_pcie_grp_offset(imx6_pcie),
-				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
-				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
-		/*
-		 * Regarding the datasheet, the PCIE_VPH is suggested
-		 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
-		 * VREG_BYPASS should be cleared to zero.
-		 */
-		if (imx6_pcie->vph &&
-		    regulator_get_voltage(imx6_pcie->vph) > 3000000)
-			regmap_update_bits(imx6_pcie->iomuxc_gpr,
-					   imx6_pcie_grp_offset(imx6_pcie),
-					   IMX8MQ_GPR_PCIE_VREG_BYPASS,
-					   0);
-		break;
-	case IMX7D:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX8MQ_GPR_PCIE_VREG_BYPASS,
+				   0);
+
+	return 0;
+}
+
+static int imx7d_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	return	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
-		break;
-	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
-				   IMX6SX_GPR12_PCIE_RX_EQ_2);
-		fallthrough;
-	default:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+}
+
+static int imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
 
-		/* configure constant input signal to the pcie ctrl and phy */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
-
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_DEEMPH_GEN1,
-				   imx6_pcie->tx_deemph_gen1 << 0);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
-				   imx6_pcie->tx_deemph_gen2_3p5db << 6);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
-				   imx6_pcie->tx_deemph_gen2_6db << 12);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_SWING_FULL,
-				   imx6_pcie->tx_swing_full << 18);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_SWING_LOW,
-				   imx6_pcie->tx_swing_low << 25);
-		break;
-	}
+	/* configure constant input signal to the pcie ctrl and phy */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_DEEMPH_GEN1,
+			   imx6_pcie->tx_deemph_gen1 << 0);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
+			   imx6_pcie->tx_deemph_gen2_3p5db << 6);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
+			   imx6_pcie->tx_deemph_gen2_6db << 12);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_SWING_FULL,
+			   imx6_pcie->tx_swing_full << 18);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_SWING_LOW,
+			   imx6_pcie->tx_swing_low << 25);
+	return 0;
+}
 
-	imx6_pcie_configure_type(imx6_pcie);
+static int imx6sx_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX6SX_GPR12_PCIE_RX_EQ_MASK, IMX6SX_GPR12_PCIE_RX_EQ_2);
+
+	return imx6_pcie_init_phy(imx6_pcie);
 }
 
 static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
@@ -903,7 +900,11 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 	}
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
-	imx6_pcie_init_phy(imx6_pcie);
+
+	if (imx6_pcie->drvdata->init_phy)
+		imx6_pcie->drvdata->init_phy(imx6_pcie);
+
+	imx6_pcie_configure_type(imx6_pcie);
 
 	ret = imx6_pcie_clk_enable(imx6_pcie);
 	if (ret) {
@@ -1374,6 +1375,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1386,6 +1388,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6sx_pcie_init_phy,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1399,6 +1402,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1409,6 +1413,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx7d_pcie_init_phy,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1420,6 +1425,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1452,6 +1458,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-- 
2.34.1


