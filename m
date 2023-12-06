Return-Path: <linux-pci+bounces-585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AE8807457
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 17:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C131C20A06
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11AA64642A;
	Wed,  6 Dec 2023 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gegk0YPq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2065.outbound.protection.outlook.com [40.107.21.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4D3D59;
	Wed,  6 Dec 2023 08:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xri7HlEhnvNb/2CywYC64V0IvubE2f82MILHR/pGSNsYIjXc0yUEGR6bTHvto3EN1LW0njARS7bCPd9anknqjNB+HEiwV3FiB2YIsmpQ95wf8sj581JqYXIXTpKOmTN75i/NSNO95Rjgw1nd/jQY7kLQl/c008fKaIK5GfzyPDhFtxoYNHwyeAThAiob2qG9vAyM86WpHnXiZBLOTvMq62wLj9UvTwpWB+LTGLCX9091CsYRDHuh3FuJGMjo5R0w7ZmLSDpUO/FewsMOknkZfulL5VMObZBZeSJAnMjRIeR+c2BzRbArR/9xR1W1McpwzIhm4C9iXmwIYW/8hrVvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyP010kXK2Q48Jra5YCr2LdwY148bnkQ5ya58KRUb0Y=;
 b=f4qA0EL5S5YlPcct5COjFETqhXFS3RKnY6k+CkS2dQidKrCW7jSUNR2Hp7A6A7iaEhdc6IOuI7yQQTUa28CgLJGGwDvqve43vnfVOnn2P3yKUb1JkyPNqfvK+LwlcoOYiCRZMxvSXkstALV5WSP7bB92/F4dmJ2gu1bhS64QO3HZJ/Ai8DYyqoGOVDk68yplXTQ8xsoLRRTrdsriDmjPnnVsCXJu9ft32FJdhWa9905+tF9+3g7PNADkIKcYR3xev/fAh7jREC4WdPvXTbWszNJPPgnrvOktABl/CHnXOppjOwfl2vntxGJiTlzaV23zA/2+76m/hUPn2vtpaMwn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyP010kXK2Q48Jra5YCr2LdwY148bnkQ5ya58KRUb0Y=;
 b=Gegk0YPqfmgXTCKfwplI7+2SYU0Unc5BWfiPILhIRbJg275Kre7ZRpDTQ2LF0RdAqHnEnqdW6e/SPbquSsPjsrCPqoPLcbOZhZc/3ohtDCREExccasNMN4G/TjTbsFNJFLT60ovP43cdBvVDvkIhW3deHz+sK8Tr9beym8G3vM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8123.eurprd04.prod.outlook.com (2603:10a6:10:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 16:00:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 16:00:06 +0000
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
Subject: [PATCH 9/9] PCI: imx6: Add iMX95 PCIe support
Date: Wed,  6 Dec 2023 10:59:03 -0500
Message-Id: <20231206155903.566194-10-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 58d81113-a9ea-4f1c-f763-08dbf6746a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	maR7HrBCtYefQTTTSN6XT+pENMQ39kHFCoUYqyt0UW5JzzzNdNJjCEdbsD4Qasbp7InCISGuvTg6Za998tM08LuTva5n3Xn9eapZes8y8hWF/nB8DuS/PU3PWAu2Ti6Qmx5a7wpgcvX0bSdt4LTA7LBAAjlboSfeQ4Lf8u1L+S80Iic879fp0XzLSvmUiLx8NEw5kmaUvUiN72InbKbTJ6sm/Ndfj+taN+43IlVvNW5faTd8AjMRXcEZyfJVbNmmakpYUtlyzPglQnFhJs8Vaa2TMm695cF2wtMCE3w3TZeKkrSz5D2AiG4zyOUG4qd6ZRfmwMtBqbAAD4eUSl0woxZOW5TYpwIqxfdz3Jh4kvXYTQJlW1Zjz9oS6uk1aAFQWhW5m4Mibos6QJ6S5C+Cvs2Jh69lQopLk7xW7ctXruBkopLX1sH63iXa1TwwIoZdrn6H/20YZTemPpn/OMVABXs9IMzPStUpa6UyI5EB20rm2lCacDWkPGQ0osmg8g/tlQnLKT9qOv4QLmt4g2dVft2M4i1LRMpAJK9lvD7UUQjX86Lgm3XDuU9dXl+FEXpBxef5oXltYjbKe8y/dFaIJho84OySmCHgosMDDLisVCZ3behlzZgX+vNjWpV12T35
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(41300700001)(83380400001)(36756003)(6666004)(52116002)(6506007)(2616005)(26005)(6512007)(478600001)(921008)(38350700005)(6486002)(7416002)(316002)(66946007)(66556008)(66476007)(86362001)(38100700002)(110136005)(2906002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tm2ddBB9sfWgmEaLHgZ/VoY3wDEEBhTeUK9edbw/vu8cRp1NHTiVC4GdQz5h?=
 =?us-ascii?Q?jZ09ijNiylO2N8jU2quNydTMHEbHAiXs7v+T4eYGXnGm1MPDQpidxKCKrGIi?=
 =?us-ascii?Q?FdljjUHc6LJb/zMGcHB8I6pQUDoMQZsaPtHIsg2zf3RDMk4ibxa3i/oho8Ma?=
 =?us-ascii?Q?EMnJBMiDUL+ofZHcePnqRcHa01whyhFjB2qztAGx7E+435RAIQG9dITX8q8s?=
 =?us-ascii?Q?o2EYbBBEdbkJhJxfnK2fGGbmT5DWJ26unm0i3zFjMwEJFSKaHa1OmM5vsZJU?=
 =?us-ascii?Q?GwY1jJnAWFgkKttQLKTD6sqoI0ITO9q7jCWkOIvNeY1EGyBmK4GaYmYmnXFc?=
 =?us-ascii?Q?VZtjw313pKhCH7k9PbI7W0W/kBDMJElolx4rQlkH4PFrKFzrTu08EkieiXWk?=
 =?us-ascii?Q?TlNbBk455W9l337YM+cEtFWhHx6Mwx3mmicoB5UoUj9xClVYj4mvjsLmyAbf?=
 =?us-ascii?Q?8i9SVfl77BVqXUQTBJ639x05LKrZ4E8XlbG7socPBK5hjmdpJyQbNMjW0L3+?=
 =?us-ascii?Q?IZ/ZmDXMxy3+2AaoBni9tMJ3mKMChOl8Sfnt5RQ3Qra4NUJ9BgOwElclV4Sj?=
 =?us-ascii?Q?x4N6kWjbKYqIl1Y7nQVAcbmTthptqwtSZAorgZSa+SClaylA3aWp97diQqoR?=
 =?us-ascii?Q?8MY5ugUYRyouIFuaCbiz0ZyUPFjCN0DSVkPRN1qNKi+MkGkQAFnC8MqB6HRE?=
 =?us-ascii?Q?RBxRInOxxXzVC1fbKmsGYkvrOsHpcZHehK6aF7F2n6o6zbc1mv7LeRZvScys?=
 =?us-ascii?Q?hAJnVS6hnJAG5BX4zBhEdxsujYckRzI0MpcpVSZ0+bCUk6qa9sXlW8xilU0t?=
 =?us-ascii?Q?0t4jaRthtjZOnlRmsheBkZK8py55sfXNgmWHg8EU8SeDeaO0ub5JedupRCXM?=
 =?us-ascii?Q?IBwzVLZDPfKS5cGZWmXYHC/CMfdspeaxVq9yN32PCdYjg2t58muPqBgoYaFs?=
 =?us-ascii?Q?c3uWonMpL+v/SGFBiNtm8TGdwBwqeVItW27fXiZr9NGxVZZ40Axh2sUSNHEG?=
 =?us-ascii?Q?+seha+eVjZDDZjzJQd8vkcNPZUC/RaK9l2ECEvsO1MobA4ZG2rXXdVL7fx7V?=
 =?us-ascii?Q?TedeiZIq/VNYzK07gkhMvzcYSd8gYh3Qjnw2ePGV8vhmmmyXUYH2p94IEhhN?=
 =?us-ascii?Q?C18Pas3yKFFM1a+UFgN8siuO8QYroTZSAd1cAfa4bZ1GvJn4rqnTDrXxJCsG?=
 =?us-ascii?Q?Dgfnd7KLohmbgY2yDWPrK8V6NcshOw3653bOM2Gx4UcO95/lFs5v3XmL+fyF?=
 =?us-ascii?Q?BQnxAvxnKPt2BRgfR9bzqCleTjNxo7hiaVLKgaOV3qC+W4qCKk5aUk+G2n4V?=
 =?us-ascii?Q?k0iIIkUMC9VRTHorEQMZlsYpszKcG5XqJ+SOfEPCwbpW1pBxH+/EGj1+Y9K6?=
 =?us-ascii?Q?o1JgwcpgOf7YoAa0f0WoHALVwMfgghTpylkkOrrQB2MIUrbiP/fFFfZxeQQ1?=
 =?us-ascii?Q?h3mcjhqcwStso7aUHdf7fXivWudLYUfoOkNqHlCC511pvfNTpVxky9avikvS?=
 =?us-ascii?Q?+38tqn2v7pjO7kogY5LANVY70WP6MQd+3MntgpxoRiSTyk9aRNIyz0e7W0sk?=
 =?us-ascii?Q?6oFbjrwFB+NQh7uqcSk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d81113-a9ea-4f1c-f763-08dbf6746a6f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 16:00:06.7073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUqbyAFkMKc6oV5cg5br/mcZe1PmsgMyFkZ64L9KWR2bwWlmdH3/B272TPxDFQNcSJ2uAJSj0fM7/SOGns7zbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8123

Add iMX95 PCIe basic root complex function support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 85 +++++++++++++++++++++++++--
 1 file changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 990b91534ea9..7e51aef97baa 100644
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
@@ -735,11 +775,20 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
+	u32 val;
 
 	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET))
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
@@ -1348,12 +1397,27 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1511,6 +1575,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
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
@@ -1551,6 +1625,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
-- 
2.34.1


