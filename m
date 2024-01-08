Return-Path: <linux-pci+bounces-1850-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB43827B84
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E401D1F2107A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17265821D;
	Mon,  8 Jan 2024 23:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RYV971yz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEF656B6D;
	Mon,  8 Jan 2024 23:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buzasgj9RScfTZstEexqLRK2EPu8XwHuP4f5rWX6zz8OE8+0Oq9714cSnkjssulsfyp0uGJoMLrxPQLScS701WjROO+LznSmuJDlfWWTGB3rKhC/WLlxTiZP1BoegWc05SeQXMS4OvczA8hneyR4icx6eeCIeKd3efpi7UvsSxAp0E0fRWVRmkJP46cW2gkm4hybq6CHq3mBScKcN+M91CmQ8KwdamEvouBCJaX9S+pBcygpXLtzyLBWI63bhdqSSE7sYbR4PqPAQJ11Ob2evg8kvwB27rPo56vTnWvOTbXHdZ4IMOa4BgoNic+p3HlxvpFwiDcqM0S+BMF5tDpZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdD8uaHjaK8xfe3amqxin92H1r7qx0tEe4Ql+H8eJ6o=;
 b=FpkoSiyVk7d/Q1ckU7nvvJ5WbXtxCBiBAZyiFLidT1MLmWHPF8YJdZW3eH9f4tAYAimIIXb0cccecIbfBgfitR2xDaoenK/CivakG2/mRrFTjNRVsJpM4fjcWwmYh8dZxAzOh7BoCSPuWjpEoSw2FX9XUhkaMKd2nEs2G45kvxx51pIb4b1s+4kvvhrRK5vsJmljXFrqHveSZJjIVqk7sIX7Ch07mBRbcbhKaP0uQpCt91N9WYfj3hVKKiT6QIoYaZlvO7H7pI8MTqiUuHf5rSdrC3kmlJlux869vDk9uMSvNAUWyhc1IY2hvodxAYlsAkXBKjkMHaNpaIaSgi++Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdD8uaHjaK8xfe3amqxin92H1r7qx0tEe4Ql+H8eJ6o=;
 b=RYV971yzLbSD/u/ESKbWR9zGCJS/suovUq7tc3o7yoTZm1JVO3I15x/DLH2S+QpHAqwIzj0uVvmck9hJPO/dBdV/20CNzQ3sOOVjlF1wMvm+gZMFKlXxPCQgV8mqrJGz+m2OgHgimPvMRmI3mvuigUV4cPkvPEGzkUlm5ebXB+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:23:10 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:23:10 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
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
Subject: [PATCH v8 12/16] PCI: imx6: Add iMX95 PCIe Root Complex support
Date: Mon,  8 Jan 2024 18:21:41 -0500
Message-Id: <20240108232145.2116455-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108232145.2116455-1-Frank.Li@nxp.com>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4d1fd0-f6e1-4924-7d64-08dc10a0c6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	T/aW018NafQukXTrgZXYgDlFyxvSau3cahCzwUa+i5fK0Uy1C5VcON84SouHb1uFIU/ZIZDgRH//yM4ZYBISuphQZbr2tAvCSVup/O+vJ5a8wCmNSrA3fY7SDcmdRXYB7wrp41jI0Ee2CqINfgBoQsQY0HeXmaYcfFx6p52sQs4RL6vamrJJ1RPY0KlB2hiJLwKMNT+KLUkF/qv1ig3KLCDkY0ra3xUSJJMCFm7B4pUdoKGSgFt7qE9t23z4Z+/KRRMWtXLauBMN4hooQngZuIZFQYHr3sQLePcOSm75nClxJkkdbjCK8FZz8dPWiqh87P2qL6ksBLSCI64UrnDxzLCpab2Kc7x8Ar7LzbINul9X2ZHU/UTRV3Ul50MHgwHJP1GRnlrINnMNdlUKsfQJ3k39ZXy71xNrhPMQ9aFP5CNkDNaTDZ3o25+WP4iAnyYG5pMWVvd/14f2+78GeFO6OPqfXCyCYEfr9wP04fqCR3HilWo4k/hOv1oMywEumuch0e+uq1FimRUrsce3xUKw/QyolaeogIZsyG/5OWyPrQcL/yqPrq+tgbrcJNftccdXOzcxB4qQsZEQNdg9VAJF2gtR6HpINiKzFVEW3wFXUlA4MJSdQferlE3ftBK9xdA5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DoCM2deA0j4TxzsmGy+MR22sgfZIGjFRtq2R1Ffdk0FJ6W+kHjh21bRKaKyP?=
 =?us-ascii?Q?uhAQIBcWrWNyvqUSZcXCVO67hUmMbfrO6wg8f8qayREpmR155J9jmcoGPLNV?=
 =?us-ascii?Q?Oco/4bnX5F+FB803bEZe1a5Owdsh+HzlG2wXtwCSVC9N876iU0S3vCeweYCF?=
 =?us-ascii?Q?aa/YtwcH00KyIVXDUlaQl2rx4XyFD/gAIdBY8cpFtfhcv7fAqNH13pxADy4J?=
 =?us-ascii?Q?NwUC25BQby0oNZcDl0ruHn0dmPeabxymZEfmzWkO17gSPMfGnWSoK98APr1r?=
 =?us-ascii?Q?gwGZElCxXmDPL7O7oLeJ36jE5hI+wbpOF5i1prBCQE6JksZwLrebATGVNTa4?=
 =?us-ascii?Q?foOQB323Pfi80m2W0GcZzP4frDbCOskklTLP3OUlC24oR5nL2z+1N5tYjN3D?=
 =?us-ascii?Q?5RQwDewF43xbGSXKEBsUNRi/u8uEDFZM+gkN0PEs+jWqbOEEYB+nkXkpUeUg?=
 =?us-ascii?Q?oID6oNvcVNQrzulFHgLV8q7mH6NcQ8RTmaLF3MQU6E+rpnD5i3aEYqaHvlon?=
 =?us-ascii?Q?I7CGcKgwwnyLhh2gv2Ig8YqVdlIVyocn1xakSS9nPldxAcFGxncXStSi9/OQ?=
 =?us-ascii?Q?f7v2yclABWmEj8cQrqX6uJM17b8jvdq/4O6RiStyr03Ec6S8WL+Jat9WeIPR?=
 =?us-ascii?Q?OH12ZyNMUpAHRHrYtimS1gwUr1XWqSR8PdLY76FS+ille1YqmhwMpbvC4UsX?=
 =?us-ascii?Q?G51HukjKtC8DBKN60Zm4AhPB46VyoeC5qkpbgKT2hDso8hy4zoCRNcjTf1RP?=
 =?us-ascii?Q?prRB0oWq6ALq4DJdlaaZniVONP9oO8Mhc1s4Wyxjhb0G2X/Gb/cWJr5QTABR?=
 =?us-ascii?Q?/thh8uW/q+sSYZVf/AKjnK7G0s80juB90CMdkzLHp3LFSV0O+EjqGwZttM7j?=
 =?us-ascii?Q?zXDZJCQqXNULUdJs1yWHGrrXIBb8doBEdza2uYoel2sF6HGFAAInhncIbJDg?=
 =?us-ascii?Q?rEFR3mjv+aUDvu9u4gQ7OeMaCobU16b0Nb4XyuZ6/I3JiPS5UFl0RDtHPOlR?=
 =?us-ascii?Q?q70zEgDbaPtTwsXrcPLLFl9V0ES+i4z6QfbuH/rgfaC5ylLh3k7yCGG2fG5B?=
 =?us-ascii?Q?FXi1lr5kSX+49fQ4H9Q472Mxu95gHoSthoXGbrRB+MWftwgeDVTHk51cEHu9?=
 =?us-ascii?Q?cZntB/KLy/oyUoZyPDn0sNuL3P2QSDM/Y6/ssvdcxCyuVROnt5r/d8+RJhFs?=
 =?us-ascii?Q?9328FzZukWAWBvBM83dkqsrORkH3Ncmfw2U8Q+9126GiPV1L2WJ7sSXc3kzP?=
 =?us-ascii?Q?/F+i0qMnFvlL3f8HY3Oq+cbKkhV1G76iaHf5BZVdTo1eK8o0+UxEwSdWLU10?=
 =?us-ascii?Q?N9/lXhRJons33BcUhFxBLJqfamzVIUUGF2EIWtDGycN/Jz5sJIKq0gC73GcI?=
 =?us-ascii?Q?Rcd86mIUKJsRy2HmzzqWq656OmdvizgMgHNTPJKaA2+e0XrnjXH/v6Vvj+x8?=
 =?us-ascii?Q?rDzoTxskErGGlsp9xD2AjFD/Xmy6tf0hbkrbdyag89PpL6l/8sC81q/GynP6?=
 =?us-ascii?Q?ZpNwQQPHJJlOzQvpjkO7afZ4rD7po+doWOjnX8j+cWEuDQXPQLSz2u4etSTV?=
 =?us-ascii?Q?/Unv15NZi+mw5cr0MK9S/B3zGZkTMftAPqRXJIXK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4d1fd0-f6e1-4924-7d64-08dc10a0c6fe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:23:10.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XErCRRB4Ky9U84DYNYhGSMTqe7PsZaiQK25Q5Ai4IA4zlDmd1ePvzb4KIQKp6EIvxxAKmc2FplGEfVvnQU0Cfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

Add iMX95 PCIe Root Complex support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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
index ac338a88fe21e..c0d08cd55d681 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -42,6 +42,25 @@
 #define IMX8MQ_GPR_PCIE_VREG_BYPASS		BIT(12)
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
 
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
@@ -1280,12 +1320,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1462,6 +1522,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
+	[IMX95] = {
+		.variant = IMX95,
+		.flags = IMX6_PCIE_FLAG_HAS_SERDES,
+		.clk_names = imx6_4clks_bus_pcie_phy_aux,
+		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_aux),
+		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_phy = imx95_pcie_init_phy,
+	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
@@ -1506,6 +1577,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
-- 
2.34.1


