Return-Path: <linux-pci+bounces-583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BE5807452
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 17:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35862282001
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED546423;
	Wed,  6 Dec 2023 16:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gt9xtppj"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FE4D46;
	Wed,  6 Dec 2023 08:00:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LswJC8B72gjTapvaXk7f3Zwkvpj692K7JYvPw/rlzIGKDxRunmmoL+1/vX7r6zWlwpkI6SeL0w9OjOh7R66WgCuEP4bFcLRNzl9msbnhizf0gaQk8hzsQpQu2qix4N9o/hX++RQbJ8/RnNIz2b6Rn4VZ9/1r84cWyVi77gVvHOaUK0bFfrDPwyjbCjUPzJ43pOS9yq7+E3JPR0ZWXn1CPpT49Ia1U90K02oQF8mUatKTOxgfPMyY9j0CdUWYfyA+p3cme66oeq9Pa3zx74wAsaTu1+TbhXYF+NkFmi1260BOosurE8+KWOI3jZNVu+7Le9U439m3k2vxy6MqU83Q1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Qpi9xQf8IYz44173pK3sVs/JxLMLTOTW2WmtSsdfdc=;
 b=Po4ZIWOld16NxMOgb3v/3xxO+Z4JeWwj3vxH7Zb2f6cYP6BekkF2IlhC3mATCGd6tV82d6EFeTNVuENbxhejZzhOKT51jS3hMrH6OXDCMKjSg4s3GXgKBxcvvGP1oUsP0mNGzUHhHd51+RqmPXnkIU3P4tGDtklL6t8iXC0A8J9T87bMAKgk3HAYeFSoLtI+hGXUjhRDb3x/5fKvYjy3Bi86kski80NfkaISlus9jZKduj/Al4ises4SZdePh9dfYEUx4aRC0nVGhTmYzmyWPh75jbuO23LQuDO+VdVbuRvZPcytgq41Qrdi/KfoWeZSCR8+1hZV9hYq4vZ1bRg/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Qpi9xQf8IYz44173pK3sVs/JxLMLTOTW2WmtSsdfdc=;
 b=gt9xtppjhIlyrjr8UnyO3sQ4OOMGKknyq+3v8BNndiJVRhoDJ/Gy+pf7rmO+DbQrGslQ3y3CucM4KqafMwx2p/RuM+TK9Y4kD/pAUx/zq377Ez5JgT1k2JjpsxbVN2IyUpZyjaC0DdYigFnEPl56T9n4aMvQzXRx3c/fbiCpeMM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8123.eurprd04.prod.outlook.com (2603:10a6:10:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 15:59:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 15:59:57 +0000
From: Frank Li <Frank.Li@nxp.com>
To: imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
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
Subject: [PATCH 7/9] PCI: imx6: Simplify switch-case logic by involve init_phy callback
Date: Wed,  6 Dec 2023 10:59:01 -0500
Message-Id: <20231206155903.566194-8-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 59c01656-5227-40e1-8a1e-08dbf67464cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cpKIs/IKQiKOp7+7Bd/04U1X9C3uwM4+Evpdeuy0cgFUF0nQ8gxV+6MhRZIsunSclcF7R9GIvepnlcZfF0gr8uuFqUk5UjREerLsH/yCjCgzLA07O1ix8YphBwiQ3iMcS8oPTxiIz8IbbZjHsTaUx+x3WeFVm9278Xq42evrA7ull8rHfrxf+hzkTw9283nKQkNxUGtcwsL4lUUSj2XkpTeBPDGgJrtzLzIFf9QsRFBcSD9USQWVkjBK/WbcMKCbfb9pIWRZJ3VAcF4u9QfhXUf/SrltQZ+yxXjUtW1N2MwXP+EaU38hAcwevJ8HRziOuRYZ6zerQAF98NUj7/YDuIIci4hx48BDn4n1GNz69WmCtbZgoMokI89AXey70ZicDVqLlOt7yiVYa1w/UTT0gl5ui0b8KmKkyT+zlefZGs2tuzGm9mGBXsjrE2tJrVTafDne415sj9OBC3pK1sBf10q5pAHaR1c+zq6XPqEPmJHs1O/+FGqwy6+Qdypd1iaYrnW1vUgkzbbnRiyr1AmvxgjuejlULe7l695pHuUd+QWTpW/IRvOudIOUl1qA6aP1Lxj9txmPx/lh8EhTQXECpxSBMBW7+g+Ef/cAvUfb7DxNrv83HsXx/rrIKWTq3tLKWrzNLiaoZ+m9bGBpIohiR7LGerFJjhXoo+l678bDBfc/ZCW7Icwf/Tdzn1AcSAgY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(1076003)(41300700001)(83380400001)(36756003)(6666004)(52116002)(6506007)(2616005)(26005)(6512007)(478600001)(921008)(38350700005)(6486002)(7416002)(316002)(66946007)(66556008)(66476007)(86362001)(38100700002)(110136005)(2906002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0K5aVJtEhnlEATtR7EGbHaUk44S815CGyx/PfrLaLV5jUrXkUALwU9niiKHB?=
 =?us-ascii?Q?2y2Xy6UNVMTu1FkRSKA5zdPw6vfcanrLjlJIcSH65rYLlN5WFit2cUVAwk4f?=
 =?us-ascii?Q?e1NJRQlNt3w0EkgrzR719zjU1Uh+4CtUCEB/LCmBd+CvPLdUSNNhcu3/5lUX?=
 =?us-ascii?Q?WKHKs0kFc9SD5VqGqs5D1/bt/agdXoR5vNHKLEB8yzdPiarYBJkUReHyUINI?=
 =?us-ascii?Q?T4ZRm3ecJDbL7MaLrang/P1CnU2IrykN2ODjQ2lX1oNN6R1EWZ5nh0SyKYeO?=
 =?us-ascii?Q?YUgF9pA/T+wKEgBI7PCEzxOhtnDcyzD7yblFNIjiUi3mpMSoDjo7cd2/csSE?=
 =?us-ascii?Q?otN1FhrM/T70kzNWJdbw1bMAG3XZLw3+YCVP9zjWV3w7EFTNBysMBhIzhnFm?=
 =?us-ascii?Q?lOuO4G9QjbHek4yxJIB/p89t23LQQ9WRNMLCLmBT0bS8JaME/PigSsqEM0iq?=
 =?us-ascii?Q?0pIUNJHVfgOyqqUMujhae+AnHYvokS8OSTeDNP/W+voYDBCwJQVLS2eB7/z1?=
 =?us-ascii?Q?/EAe71RZETCM8luMTjoKqcOjRpzUt0941lDV92tQiy6pHHtvJx1RaxNcFLah?=
 =?us-ascii?Q?U46P1Smd7DACYT5WLoPTaEr4FiH4Vvc69WsFEONxG2leotXQI9UYy7iSNJNN?=
 =?us-ascii?Q?2O6qFZX1grfYlOmc4P2UBJgqEmBR0MWceatmRgQE+1w+JZGIsIkojHITQ1Go?=
 =?us-ascii?Q?an1DwQkfTmvDa5DrJuNSVwLuNq5GzTFUAGkooDG01wFqyfOEb11deEpf00c7?=
 =?us-ascii?Q?9Q/YxcQMAMGTd9jN8uigDAxwMZZkWrrZwbomg5fPMGsXPIl9Gr/IjjEMjCfj?=
 =?us-ascii?Q?rZXkCwJYwzwI0pGk8+oVGFaZrxBQOCauPN/CoUDfunUXMhzPw81YxVBsC/fT?=
 =?us-ascii?Q?Xe4RCZGlc6nU5eDA/47NqTd7NH8e+qjrs8SSmpF/d2/eeEXt6K9O6GvRVcjW?=
 =?us-ascii?Q?pWjU04pEGsNZD6lf080uaOpw2xLkMpFAAH+KNyxt4KQkokS7qlg0SrkH2pPW?=
 =?us-ascii?Q?sQwWNGMAYr9KkLXjjIE88P/zGAYLGnPUO+1CyVKGDH/NMgtyW2wgPbmePun2?=
 =?us-ascii?Q?D20PIjLcPk1OZlNw6LjpJqhO0mOy6EKQi2v9w5sAtFb1BK6lC4zql1DCvgDd?=
 =?us-ascii?Q?rPgn5QZUGgezwF8hk9VHOWfHxfqdkBMgrlRGooJ9h5DF8BduEqpm/tAQAXPR?=
 =?us-ascii?Q?zGviRPB4f71/GxXaNcEqkYPUuq1ScVC///boRad34KrgVL7A8EZajf+1GCBx?=
 =?us-ascii?Q?wuBdC91Jue/DOvRfEI3sh5kywwrvPutiNTc0kMecVf4klJiK1/Xp3al9dbrM?=
 =?us-ascii?Q?7Z9fCtHSpQ5xfjnmM/CDH5yV6i16E6aUcqxidtNMCK4gUdS476x/haYZJSwI?=
 =?us-ascii?Q?hGfH1P5vDcITIKh69JzkQSCJVvNy59TBPEQrwXw1pSLnFb5RhKkCTHcvdFQz?=
 =?us-ascii?Q?PxaYsE3js5hz90YSSuDn3wCH07kpABlULxarD64ydiiGG4OmmioRn3lyBrRD?=
 =?us-ascii?Q?vtF5pjBm7K1FZEAcCIl+23qrLOlvtzUj+MO824xBEnHF9sSrBOyOnFl81I42?=
 =?us-ascii?Q?U0ythXqJpUCbrxH+OHA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c01656-5227-40e1-8a1e-08dbf67464cd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:59:57.2416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wmKN1jVlF/6JnDIGr/T6ZoIbiUb8nQ6aQcXm9oMABz9S2BgZIN96uyr6fVXAcV+JNbS3Iy2SGdsANxHB0AMNjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8123

Add drvdata::init_phy() callback function, so difference SOC choose
difference callback function to simple switch-case logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 135 ++++++++++++++------------
 1 file changed, 71 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a2a3496fe8a0..990b91534ea9 100644
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
@@ -945,7 +942,11 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -1440,6 +1441,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1452,6 +1454,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6sx_pcie_init_phy,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1464,6 +1467,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1473,6 +1477,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx7d_pcie_init_phy,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1484,6 +1489,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1516,6 +1522,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-- 
2.34.1


