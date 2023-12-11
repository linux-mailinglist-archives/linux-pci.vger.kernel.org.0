Return-Path: <linux-pci+bounces-768-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A21680DDBE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 23:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE85282578
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A535754FB4;
	Mon, 11 Dec 2023 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YcLJ8U0f"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2059.outbound.protection.outlook.com [40.107.249.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3868C10B;
	Mon, 11 Dec 2023 14:00:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TN4czJmuf+2MEfoormb7Io2UVfFhzVL6u+y3j9gG+nGPYJQMlzWzTbrAuydt6Y4EYcahW76aIE5EVgxVsUQjghQnuT40kutwGuxqKhy/IevCr/lwkjwkCiGI6TIKR7/aVj3XnQCCVLq13aC5q8KdYI/aEgLZE17tIBra5ZrKPZ7HQchOCko6m6YJ4cdp//Amo1S0lgIUbGmhHr1y0NxenPCSARWs/Q9JNzPcIfWvVm41m6jU5CiFcqQ7ObVwy0fehzYA+Mt4Wya/s0rw/VJL/q9qQ5Eg0wA0xQrsB9Meiwj+P6vDOyD564bsZsEr/i1eUgOHGyMf+D511nFD5hnQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USVYs4/Ey2cQMssv3OIw9XzOwZ9t3+TOU2azctiZStw=;
 b=kIeBJ/yB30HaxfzsJAv6srBJhbj4M2EWXM3D2d4itTEctXHuped/N2LfyddUarEGTXf7jSIUvFdlUajbqOcrY05TSuw77PkBuuHBFLbgtf6ZQBna5ltCqWz+4V1I1uiLqwTAhPDI12immFHRu5NKJARxG+RezpgdnUhoo8pm3tEciEtFt5RGzpb+AdyXAYFVm8DgdOaoIjSvRRuYCQwWRtTi3qi86iPUih0YVbi7nc+ghTeKqAFNM4qnCatNyrnPBJw+ZZoWTcvyYwJmPJiSK6iYkwfRXO/JsfMjkKr0pEl4ByT/Yr5fuFcPZt7WCHMpFfZZiYP3ErX1HmiU6wTqng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USVYs4/Ey2cQMssv3OIw9XzOwZ9t3+TOU2azctiZStw=;
 b=YcLJ8U0fAZpdzwgApJ4RrNEiv+ZdSgFZV1bbc9lpQMbyfyfL2+1ppXEyT4s1lkuGfI4g2zFRTcAL7o92jlNoKmF9LusPAon0yIx4IA2WW4cmMcrvcL5mHEhJTcXnWAEJ/2E39uq/KFM8mHgAQVNVqPpV5reytHuwLZ9AeCxTK84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 21:59:58 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:59:58 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com
Cc: bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v3 07/13] PCI: imx6: Simplify switch-case logic by involve init_phy callback
Date: Mon, 11 Dec 2023 16:58:36 -0500
Message-Id: <20231211215842.134823-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231211215842.134823-1-Frank.Li@nxp.com>
References: <20231211215842.134823-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB4845:EE_|AM9PR04MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: f2bf809f-f7ab-4d65-96b1-08dbfa9483fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V8XovyCmuoaGKrc/EEtFoJgWZaa/vcvoSSGvM/9+ql02F/sFCGhIbvfEEzfonJmjRw5NCRQzrLKHik6H8669JXnmzU3EhHxZ7yFlZ0N7IiC4wy+46HLdvZSS+Vx0TjoCeR5anAZ54YbjHkV2RYo5bkboyBMRjFbmXJ3fpqPLEVaIKkTaNDpIIKl5ZgmcNKoOreUw0FHGuELetHAa/gAecpepZolpz6InWsu5z06mOxZ7l+s/zeOnne3gvAYyE5EPmRa9FKNIfGkrc+54pbjZ2iNhWkS1YAKks6w5G8MiJQjjotZM63Gw4NgobDwCiGXGS3CbHUN/VOa80JSkOMgtXqpp0eLvVy8A9FgNpn87Ssa9mKYOovw1dd4XsF8mdg765881qBxpmCQKFT6EFdpRPaKZtt9Pd5TcAxUnlfDt0aXRXF/C+9ed63mayNFZ1UAKmVgsexh0l6uPtMTxnpgBc5jf0bNHldXcOcJTSNncDkxR5pL7E3tfsjUw1oLd8pmM6dOlLTaW03qEhGFQusiYcnj/w2Oo5lBwLtXHfYDQ6Ya/mGFlwnarmMb7W/Qbz8Wsmmsi8usPGOP/X7EAmfGvN0lhMViX/vHbGFTAjzITl3iFLxXGMLXsK+P53nKTmvRxQTFOx6VjMjcWZsP1xuMCzCxCULHw0ZfgbBt0ZIx5z/o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6666004)(6506007)(6512007)(52116002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6zqmGAZGHCVeJ5HJlu4q8BaRbyExUzbsJ/aeTb+ptDFytVBiFfFYyW3cuazV?=
 =?us-ascii?Q?nMgtCFvmK0J5GLiuj5j9n6zfJMbPkKAAaw0nvEK9MdTSzGomwHE6kC4a20ES?=
 =?us-ascii?Q?FDpUCCrxh28KEHIGCSCD9FP9qwU3zZrvAhM+tAU4Bx/2aEl4P8J21gEFXdnq?=
 =?us-ascii?Q?Lekhafubut9qkZuk8H/Fq29D7nCAl2k47ikyFWbie79NVwum/2mjHN4Kf69V?=
 =?us-ascii?Q?tpxs35G5dCDhMZL5a2LakyOzA3HpZqA4iVT5rukz2ExNo8ESugLtbQsmNXxC?=
 =?us-ascii?Q?n9+QtjCigcwPBPMoCwiPQqcwXQ9dDeaEPg4ixzLbHssSbbAVpQ8VVEQT65v9?=
 =?us-ascii?Q?ChewVWLw3s/ZpXKSa5yHJ8Xaf+wfD/AV0hJlva7iTMBiDW0Kh7rfIKNslUjn?=
 =?us-ascii?Q?qMvz7niU/o2Y1NB99cOlHUQcwu1q9WQB/K4c1C2cMTvXkLjquajaCTU5hSHq?=
 =?us-ascii?Q?AMdhg6DsOBy3tdALHycet+oQh65H9l0giD0PdAPV15n8F8/293aH3kC/ZLoK?=
 =?us-ascii?Q?gXAwEy4N8KfnM1E8bOds7ywGU2zcCbDvaYw3IidCBBug8grJ0mbMp1hg1w2R?=
 =?us-ascii?Q?5bwlhYkXFBjoANcndt37qQZjXi5nmMn047C3HJVJM+x0QO8Bb5f/NYIBsf1T?=
 =?us-ascii?Q?YLUcxXKOKRgYZBPhKwxH8wXTLgPTCkXwNI6wmNK0YfZqvkUvVBN+RFKjoiZN?=
 =?us-ascii?Q?Aoi74fM3LQuzpnaPJ+aEKtXqtxFy+K2/kxDdKAM+ID1spQik/j8pGLqMFBEr?=
 =?us-ascii?Q?uU9/TrNgq+05V4E6EA880So1RgMp9eKRrUjGu7nxuEpqzwe7tZQ6rUGomGWV?=
 =?us-ascii?Q?t/LXPUz+lL2mxFMJwmvbF7HlgYEi0F3iTHnUtnyO+48Wob32ndf55KiX+0rI?=
 =?us-ascii?Q?fqLpJeeJXSt1FPJcsYBgALzjqkFE/7up6csPQk1uKAetHpLmRXEJ3iahoM1z?=
 =?us-ascii?Q?hB9IxBtqmKjv+uo3VbtRv3GbPaFuHHoszaAbQjhnGNLmIXUgckcvrNP8n4AG?=
 =?us-ascii?Q?i64wk7PHCdfsmnVw4mwVJ+LU2Eci/2XZIao65uNA2OuNrOQ8Bmw3yJqx4T+6?=
 =?us-ascii?Q?8uKhKsYkv9xL0ZFVmRtNTXOLuBkuN3wI1iVkmA81vZV+6rZBfQyU01XuWxOS?=
 =?us-ascii?Q?KOLvYpZ+2LcR0vGuV7u662tFwPdoSxyhG3Zt5ANgZq268nC945+6QEk9dpUs?=
 =?us-ascii?Q?lmNxjhXNRLgkBNBKfNX0qkNjc87Yt35AmXRqGRLFVTfCKtviPcCXzMd/nUAJ?=
 =?us-ascii?Q?EOz5MXzC7Zr1oMg4m0jYJct1MG7LJFwUTS+hB4LI5dHclxcWzecpXvwcNSDt?=
 =?us-ascii?Q?f/4aDeSWIikYeq84EsHgjAjAX9/SZEPkCFg831umGWfzHkPM/VQDt7WrPo6e?=
 =?us-ascii?Q?PdRB4DLX3xzE8hsQVQQ3Gd3OXBY/h72IGFEqO432XfVOHS/JS57PREIP/1eT?=
 =?us-ascii?Q?vp5LyhrCztSSmVxDfuSVN2S+wmWJzsHci/S+05qy8hyA5WV5+rCk40cHyHnc?=
 =?us-ascii?Q?SWLFGjw5GnvWV2Jvu4/mormIPF3klJAlOpVKvQyDVAS1JC0Y3Kz0V1CtmKkV?=
 =?us-ascii?Q?626S22FopHOdAt3yk6EMBt/15zerP4EuNUnor4mx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2bf809f-f7ab-4d65-96b1-08dbfa9483fa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:59:58.3183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mF6th5KShC/1yKy56LmQiNhje1KnwWjwFv2ZdCObz5wrmblDVhz7XkOitKqN7q3e8BiKarTgX0ODnQ2U3f0k5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

Add drvdata::init_phy() callback function, so difference SOC choose
difference callback function to simple switch-case logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 135 ++++++++++++++------------
 1 file changed, 71 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1fac6129eeb5f..4e55b629d4efb 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -70,6 +70,9 @@ enum imx6_pcie_variants {
 #define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
 
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
@@ -326,76 +330,69 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
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
@@ -939,7 +936,11 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -1435,6 +1436,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1447,6 +1449,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6sx_pcie_init_phy,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1459,6 +1462,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1468,6 +1472,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx7d_pcie_init_phy,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1479,6 +1484,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1511,6 +1517,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-- 
2.34.1


