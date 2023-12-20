Return-Path: <linux-pci+bounces-1244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A6D81A844
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6781F24073
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0894C634;
	Wed, 20 Dec 2023 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GCb1n0QQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75764C614;
	Wed, 20 Dec 2023 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVpbj5qijJTQJ3p+ES2TVDn18OsaT7zoLPJ2E7LFWqgjY0glDio8vfLsg3sBy5eCu+lwRl7UgJh6Z5Q2DpMv/rRy/9a6gQ4/Vjrgdm+ZDvf4fQgn4KyjQbJFvmQDO7XL6xT5uAMA5mAcSKmK71+r9Qt+kn5VIzFkZWoQM3S1Pv2XX1HrAWIBDOCaEabtLe96KjKnN41YbUKRohQKGqxLqdQSrn9yIHqHjHPq8qSK/Nlp66GzsvT7wTmf+CFcEUUPJu3/vzY6P6Qi8S+EOs2PRrARkcM1EI8t9oQqf1lR0Q2S+veKGZi7VeC8ijx30JFCogGxiP2Iu/zdf4gy5uIkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4dgn8M+Jk4NmcR2dQdTU9AyWvLkmV12/ZAFatSQuWg=;
 b=Uq+8iEig6R5mLN15y71Zu3MZviWkS+ryqFSd6fyQLpnuJfrTPD10zLIKBUOmxRvNLuc8hhfRvUrDKxkYQsWh6+xgagPXPjPyfDzc1i1UnAFdlyC9KYs4HmQDiB0q4qi/JoWZYiILqyDK36wgEaKk7PVj6mf3Pex1MwIcke4u3swQMAwFOIMWocTDBEsj1KxZDUml0v7vjQvrhkxGs/KyeSOU1M61NtXH2Qu02OnE0zpjfgpEJ59tWaI04GWPeNcuMvlKu44N/U5MBTcUI+zcFOTGZcdfxuW/0XKhkPuTND9l9MUeo4E/lSTSf6hWT8p1KaTxKD6zA5nb1f8qq55D3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4dgn8M+Jk4NmcR2dQdTU9AyWvLkmV12/ZAFatSQuWg=;
 b=GCb1n0QQIxkEyG3zveHmVpdC09F0WjOx9KUQnAinHa6ew4XqdPbgVAUbZ9IyrcQeyIV9WDOgnJRf3kibmod4AoLn0QCZNUDbTsoIE7jwBbLE2gpQSY94MjpgEDYlNsbskIN3/sGvrF0wlpB1RIgJUfeAU+cDaS2upBxVT6SZULo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:37:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:37:44 +0000
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
Subject: [PATCH v5 12/16] PCI: imx6: Add iMX95 PCIe support
Date: Wed, 20 Dec 2023 16:36:11 -0500
Message-Id: <20231220213615.1561528-13-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c319ab7-dafb-449e-71dc-08dc01a3e652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5LqXx6vPU5y5V3s55b626AFwaO2mp3pRiSyNhW6fbTRysh8Qy/P9I74cYu8Gdpqeau2KFd03tTBMUy3z+LtPEhuQXaGZRp+Df/vKrOvoPd1/o4LJNPFvJbvqX4dSG/IdCv5FqXLpzC9YwWzYVxAoEXyuc50uA7G/4Xo1DVXumo089nKEZwSy/fXSlmLq0KCp71d595BiiUUW4e9u3DuIIIpeXcYkI+xjwaG//Q/ip03HVCihjFOHtvNZxgFo1qoGxsFrvKlUmLtB2Uwh30ttzZDRT05RsRoNRGrUwdCCvwqdQsxAANvnyfqmnt76dC977JdjE7PE/P6/y7SnNPueNUnpf4eK5+v7eSy+zPqrXZ0bNP/zQOaguumikVuxwAMDB+9cYItw/WAFyDS9+YUMwAutgqv8TCPfBNtD+xEht03EkM7IU7TpIqRa0niNkTst4vxU5TR0/2sgNpCN/kGpNOqpoa4o8D7CgK7tueIlGrrfgYlQjw0hFlihc4HlaDncdNgu5oxAme+UzEumlVPowF2lhnH3Zl9XJT8uxb+cjtK+rzgLSJxji4xPEXVHaiP8NHUjmxB0umjZtEg8ifK3Le7xmMwRj8dY+RftcNdJCpLhbbJT8FWCMu+xfanO4XOk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eRGuqUktcRxbfCBdtCoCYxhUPvAQ8c9GRtRAKcYY4b6S6zx7e9mAjDuGldTb?=
 =?us-ascii?Q?gwesuRXdK6Hm5Rtw1gBa2NB24BIfDB8Rit31I12SHSDLCUG3cxr1qTxkxrAr?=
 =?us-ascii?Q?jJkZcqDJKLfDJtjS9Y3Q7Pr7HAwck9QzX10nJRCvC6T4WxXkC+ZeaZ/G748f?=
 =?us-ascii?Q?IYhDJSPfK7qPyfpePC1GUJByUnHq2NSuXLm62NdYGR4iFs/6+t9gTfdh2w/r?=
 =?us-ascii?Q?+ZLyLrygioWFt3Eu9rJPOIllDmgteWdPuoNqi5kTG2ActHU7YKRURNaBZeBA?=
 =?us-ascii?Q?F+4fXmUI0kFftlL/hPrFOt9LjuByJs5kBst2W87zmc3APXrQWMzL9PcLqmdn?=
 =?us-ascii?Q?Vnf+KtGDQ8ohfA3JsTsqUvqusNIK7blsdG07uW9fzI4oqQCOrtBs3amQJr5v?=
 =?us-ascii?Q?0n5gwklBDZQfLB2EfvQtJ0AgpTSStw5fyEUz72DXeoy++PRkAtIWmkbqLwuJ?=
 =?us-ascii?Q?c+iamkvSIl6Y7Nd6U7lcGSHjxxd/ydcBb/1EioqJ4+BQITOfho2pHFdLJiVy?=
 =?us-ascii?Q?1vrnSaIZ6CxlGvtr+o1t9l9G0QgMDBOA/p2LWgUrwiPefqt64wl4GKBnfCpu?=
 =?us-ascii?Q?rhn8H8XsSqFPPgR3etW+PVULUraYAZtsI7OYK3XV6KMl5e/SnjHLseFkeLBP?=
 =?us-ascii?Q?eCsA/blQh1VTT5XjpkZkz7lMyk6WMelRKzthsO9uaV1aRoZqUZHA1knyDIYb?=
 =?us-ascii?Q?bMriGHPDtUxI1NwfwnQGJo3pcX3iJv6w3i1wFS5W7li/TUmlIhqH42alkgm/?=
 =?us-ascii?Q?VuRzgBGqi1/9vsoKZ5rBJp+dfBoVmKcOkZAvqeD43JAXoO+FRFe2LKRavwUU?=
 =?us-ascii?Q?69FoqZcJ9J1rZN548WhTNC/jxdbnqSYnChLaGdBZX0+1qjDRYrYrfMNKd4Sp?=
 =?us-ascii?Q?dg21yp1Tl27Un9i43ka4DEWE8pqlwsAZCOZcK/NqYyJVi09IO3ourYVGfy9p?=
 =?us-ascii?Q?aMI+QgAqco/G1JXHyAXhTwl+xhfJTyFMEmb9I4AZ1hYjjlNz0NOuQvei1kaa?=
 =?us-ascii?Q?t+GMr+z+84B3J5U6SJWT1dx91huvpIajaBvyMx3CVygJMK3ywM1LwAGdhUZA?=
 =?us-ascii?Q?GfyMOQ756n1L2Awi9yxgK7bI0pAA5mc58WH6Vi/i9LmqAhhT9GLJHiL5HAar?=
 =?us-ascii?Q?twLPlZxz3BGxbjZF5E9YpfnLNkkn2KPsq3C7wTiEhTRlTDpr0zC6m40geOCn?=
 =?us-ascii?Q?iSBY7lvfgHJMbZcP03UC05qb8xlMvjRnYnJrWFNYNdncouOe4YhX9asDPZ/g?=
 =?us-ascii?Q?3EdoUi1r8Co8uHo4xMA5HyW6qBuDapQbcekzjoSVlq3WpJB4qMdapvof98GK?=
 =?us-ascii?Q?egBNBsNqpwXLHR+yz007Sl1KNySdKRRGvRVRiHsPJ1h8arzfhqBOkRXVxsPv?=
 =?us-ascii?Q?Ms6M9ZIH6ObjJa7V0ui522vVEAP9H0GihT92YumjeVhxjqd7ysT8e6IHoqBp?=
 =?us-ascii?Q?Yl2RblzBm1qUZ5yQ9RZaTJeCY2RBXlPTbdBmTE4CAlp4WUYfjflZ2QpP22Fb?=
 =?us-ascii?Q?qJjp+D6N4ah+NEazshGuYJWquCl7b8Ek+dIwVleFjTgkgxHbQDNQpDGUdL1j?=
 =?us-ascii?Q?sMOiGo/1O5UFzwaDkNI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c319ab7-dafb-449e-71dc-08dc01a3e652
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:37:43.8398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6tmOjHV1BN1CtPMlGtEbo3Gj6+7UclZ7qL/S7NqAqFgK8tAlJFPI9XFRpHvmzKtGfDENt5nPQmH2X1esln8aGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

Add iMX95 PCIe basic root complex function support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 90 +++++++++++++++++++++++++--
 1 file changed, 85 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index d66a2db53bdb7..9e60ab6f1885a 100644
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
 #define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
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
@@ -579,6 +618,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
 	case IMX7D:
+	case IMX95:
 		break;
 	case IMX8MM:
 	case IMX8MM_EP:
@@ -696,10 +736,19 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
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
@@ -1281,12 +1330,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1447,6 +1516,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
+	[IMX95] = {
+		.variant = IMX95,
+		.flags = IMX6_PCIE_FLAG_HAS_SERDES,
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
+		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_phy = imx95_pcie_init_phy,
+	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
@@ -1488,6 +1567,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
-- 
2.34.1


