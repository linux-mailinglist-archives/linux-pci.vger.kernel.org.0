Return-Path: <linux-pci+bounces-633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA99809185
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 20:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12591C208DE
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 19:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D171F4F899;
	Thu,  7 Dec 2023 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m3ApS3NN"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2052.outbound.protection.outlook.com [40.107.104.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048E310E3;
	Thu,  7 Dec 2023 11:35:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZ5xrWo8Ziy4xNaBrJ0WMycyKU8P2pshvJHTX7fUzxT0TOBNmkarZrcx/PE1GlVn0F1K5Zb/SjZH44sqeUapc73ED4veOHjI8e6Cbluv0TjlMijbi/wruzG8lKahV4U1q583jFU6SZnPaGjJpinFq4+teR3WaWIZ52qXIo0tJs6/RdVgntyvuAXdNTxsXttXAq4r4OTELbuekwM/kjFYZvuPQQwPRp1iKU6McdjTmc5hYkVe2SqIYpAnJWYJv7Y3VDFGNNgdqnaWxNNB/itH96VERYvQEd9NmmQFcFvKQek1Ok7uwRMJulThAEcCvsukEP+8fxO0QIylYtHMX49Tfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w0xFwXv5Kh/M+ZbnE7nYkzJC8jEbr5oxENekrjRIHA=;
 b=AcdMDOChK3AIFAUm6uNnLNcHsnhqnyOz0DNEN20CWg9i46i2s0O++8Saquof7svvscHKkfYViGnnsfpUHT8JG9J190A+Hwj/6YpBf8rZfVOLLkG1M8Pd6ilp3eTVf6XOG82ConHpcR8a7Qc5LAkHb2Vp8rR4CbxRNBzduMieZ/sE9ML5zIVLfAt2JuxABHwDGeY/fNUvcZic+QgyQmFY34wVsXi+3sMSmyI9Y7QGm/PUfCSFDZgHg7ROkgwtpF6mwiEimYI4ZcaxdpbP8lJfFh0hSAkRetPJbPhy4uPswi3jDM3XinpSvDK5VDOjMdQFDHC/sYP3SEnCXLdDOUnM1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w0xFwXv5Kh/M+ZbnE7nYkzJC8jEbr5oxENekrjRIHA=;
 b=m3ApS3NNardYmknrQ4IOwolU9SOtgC5Da7CyRrSGVZ4BFP3jZaYtnIX+X0EtULzvTdl9KN3Sio4y77ECccQpgXKfGnLugfNhy/ez1T0n6gQIQI+s2vbaWfpZVA+HcX3dlpSbADm91qa7X/uRTjZZXitNYE/vQcPdPXa67PfsULo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:35:38 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 19:35:38 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org,
	manivannan.sadhasivam@linaro.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
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
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v2 9/9] PCI: imx6: Add iMX95 PCIe support
Date: Thu,  7 Dec 2023 14:34:30 -0500
Message-Id: <20231207193430.431994-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207193430.431994-1-Frank.Li@nxp.com>
References: <20231207193430.431994-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f11c98-16a9-403a-c433-08dbf75bb0b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BQ4kC5XRf/tJUL/+BnsGdBmRU6jtePjV6SLzHm+iTl4bibz7C8cgfawxYMuV+3EOzR+kcdqtZTs5Qv87zdXzwEI1N4OsOj1UG24m7I3XhNvSCk02r8HSZPW2EMepFZelxWK9ipaJGqPhbhJ+6NZoO19hFQZA79JW9UaDA5hTP9CuYVSxP2804jrTChY7tfF7zmj9Vsg9vjDyWgHx/gNo4rxJRvN2Yp+ZUJw3cZhypdqGyGxf7GuchkPHKF9KCerN3MGOV2wu0mDZ7tQiiWxh0BAo0XS3XEmunsyhJVF9w/7MM7ERzPrSi/EdH4rzEVxlMI7D1uPAZCqHwYVT/JqakdplbwILkGE1fC8m7WZQ9DKA0Pj+Gk97oG6YYljC2CsqoKRc2ID0vbVM3zI4vGt0wboIvBfgVSu5tlmI+X+1fyUDSd9uGPtYowDhqGFkT+tLJ2p/i43UcHju5RADMCF7JBk2ofr7PF9hlldIWfBbdaVX1F9Nurq/BHf3gFf0fTkTfoCzvEdNpZkihDbicrPnOtd8rWJVfe+nb5VRI87Pt6yLVg1d0jD6yfy0uv9YA0Dux6wrsHR+gmnATtqXc9ZJ6v9FJ32TmYZLMUHa57MgPygDdDgPJU4tkJGSUtNc0oRp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(52116002)(6512007)(38100700002)(66556008)(66476007)(66946007)(316002)(6666004)(6486002)(1076003)(2616005)(26005)(6506007)(83380400001)(478600001)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(86362001)(41300700001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z50KeWAXX/MnVvabhbxc5DVaxEqUz3qtC4xNu8CnpxSvRx/Jzk7N4lbZP7DA?=
 =?us-ascii?Q?bzpesEHfz31Z8HvqFT2BCKaJmnZ01DeSTNLOYozRCqV4XnL9FwAfPpTo6kbb?=
 =?us-ascii?Q?e9fBElqbyqmtI7I9qBV8WLNdHe4LIe55TctajxVa0OBN6+++24HSSO8fWvaz?=
 =?us-ascii?Q?hDVEtm1VJiyIULaIiWIK9jm+nYFXSBtBT99PZKylb/SA65FhJk96EC4VtgL4?=
 =?us-ascii?Q?kVVuIn/ZmqzTPCvVIqVG38k3hscFw6RRr6Ni99/nHU1WXs2o+m6kyp5HJbme?=
 =?us-ascii?Q?qP5VQtwmNTI0+kXWbt5MsPBkAan8iXRM67pnqO5C3vuxi/gE/AEtSY8jbBvE?=
 =?us-ascii?Q?VHcxY8FVHUX/p/CcdzUbVM5cXjXLm19IwNtEjc9lCvPnmz/+FZVHDo8lDfGL?=
 =?us-ascii?Q?2Lnq5LyutDmWI8NsCqt+XH3zsGlWNCSpiI2uXTBCDmK0EKNRoLSb9bY8fT6I?=
 =?us-ascii?Q?6MP1+jYj85Ji1+e0RGWub+NbCvHZ18515TJouiV+LrBIkQ3E5QfgrcX8SzH5?=
 =?us-ascii?Q?mC5jRTQUw++RCKtcBnKtxOyPJP93szJXkgb/3TDCSqX5C4/y1JaC9O6DqR84?=
 =?us-ascii?Q?+AzMF4waoaRMIZ3uENN3qRiK8ojRda1/RWvTJKcnB0BhoPmMn+mBbajE865e?=
 =?us-ascii?Q?dOGzCiCVIZROJ02S+NyWZry8hSetroIAbNno9kEnizU4ftUXsPpXWHRpJCzy?=
 =?us-ascii?Q?+EM21xmmGLCN3/M2yS6McOD7rlU/0l4qlZs14bvHyxsqYrAKfAE29TRgxxNp?=
 =?us-ascii?Q?R1PLzXHIrH5PgCcjdSQl+9jSCk/rNKkiFv/2mFgBOYoYwMcaBcrLxFt9NNMh?=
 =?us-ascii?Q?U7Pf2klsDOv7RPr5MZASMT88k2dlPX4m/3oVDnuResQcM9SvWvS9xfT07Wyz?=
 =?us-ascii?Q?eFS9BXW0qQlhaRmeYGoPsPhB0Fy6180PZjv+z3subwHUq5CLumySMjszAz0I?=
 =?us-ascii?Q?RpxSJ7hop9p5rbtW/AVsKL+IVaAoZNRlDzTIVIBMc+XXNph6qlG6fsJ1ARW2?=
 =?us-ascii?Q?6bi6Ku6OT2gjYRk8Wn8ow6xoLbenx2acBS2+yi84S6fVA3cZSz5Nl8XOO6vV?=
 =?us-ascii?Q?oJtYjbJNetbKdRMpduZdUL9FjNBcr+D263pRP/kEkk4MJfR1uEUZTfjis0fT?=
 =?us-ascii?Q?taOowNahOHm53al9WxepFDhloBMrI0pKFi0H84bQ9ruMsjrkGFWuBVfKGp7q?=
 =?us-ascii?Q?HmGuL2Y7Ug9qMnykjAOLyAqkH3nGoSSrF6wougGD1d8NjA59zwv6ahJLl2Vt?=
 =?us-ascii?Q?sSOh8PDJimS0iLjHG5ZkiPZxp2ttqJz++TZBkfaidOnLSfYgK+26nETwex3U?=
 =?us-ascii?Q?cTTYXn6+OFW8k0JxCSGcDGytZPjI4p5vdHkLOTHIruYRTXJfc8exZhyv/3DE?=
 =?us-ascii?Q?RXaaQSx9zxRXbnR4yKJu1E/9LQawKDQOBgOZ17V0u5ATFhmgTM+wUxOyzahk?=
 =?us-ascii?Q?u7802zWCMjW73Qw60HlHv/fdzPACrIKECPWq72nbAnYdqvwbl45aXBLqLyaj?=
 =?us-ascii?Q?B4fv+IrMgaQVzGieDs5avDAg1iRnkXxuhuR5GOGNGl0hZ45F6NjqVMdf6YCU?=
 =?us-ascii?Q?mCJLCZd9mJaLe+JWIBA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f11c98-16a9-403a-c433-08dbf75bb0b7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:35:38.4565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CWW7inJO+s28Ekan1E1hmJC5o5WqSKgJpBB7OVUerhTSih3hGUJAi/HWTVm248thmAdOUCceGGCPt6bUKIm5sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

Add iMX95 PCIe basic root complex function support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 85 +++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4e55b629d4efb..670d8d410febf 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -43,6 +43,25 @@
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
@@ -53,6 +72,7 @@ enum imx6_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MP,
+	IMX95,
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
@@ -79,6 +99,7 @@ struct imx6_pcie_drvdata {
 	u32 flags;
 	int dbi_length;
 	const char *gpr;
+	u32 pf_lut_offset;
 	const u32 ltssm_off;
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
@@ -182,6 +203,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
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
@@ -589,6 +628,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
 	case IMX7D:
+	case IMX95:
 		break;
 	case IMX8MM:
 	case IMX8MM_EP:
@@ -732,10 +772,19 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
+	u32 val;
 
 	reset_control_deassert(imx6_pcie->pciephy_reset);
 
 	switch (imx6_pcie->drvdata->variant) {
+	case IMX95:
+		/* Polling the MPLL_STATE */
+		if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
+					IMX95_PCIE_PHY_MPLLA_CTRL, val,
+					val & IMX95_PCIE_PHY_MPLL_STATE,
+					10, 10000))
+			dev_err(dev, "PCIe PLL lock timeout\n");
+		break;
 	case IMX7D:
 		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
 		 * oscillate, especially when cold.  This turns off "Duty-cycle
@@ -1343,12 +1392,27 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
+	if (imx6_pcie->drvdata->pf_lut_offset) {
+		void __iomem *off = pci->dbi_base + imx6_pcie->drvdata->pf_lut_offset;
+		static struct regmap_config regmap_config = {
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
@@ -1506,6 +1570,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
+	[IMX95] = {
+		.variant = IMX8MP,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
+		.pf_lut_offset = 0x40000,
+		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_phy = imx95_pcie_init_phy,
+	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX |
@@ -1546,6 +1620,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
-- 
2.34.1


