Return-Path: <linux-pci+bounces-1353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04AA881DBEE
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B3CCB203BA
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEE3FBE8;
	Sun, 24 Dec 2023 18:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CPpMUxKm"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF2A17747;
	Sun, 24 Dec 2023 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvbZIU9/WIZfnApUKyPAES64O6OYQmw96oP/fCRCa6rHqQrAEI0Wrp5YZGpGWFc5u6iyvgey51UwbAE8m9BBuEgH1SSRuPafl4PLKHy4sPQ2vE8/rTuLxgUtGJcy0g5Z5jN76wn37rmL4du18ZaMNt8lWjwX8lVcBHqN6P6+GAnVaGawJRGm/M5Bm/AZiB50mAiYuEIJkwizmS9GVSwADSVWkkkLhctXl3gwEvGB5mIgR3fYFFe3Dc8S96cskPkr3wNj87UjSmIw4acTNYjMVATC3dnOjTtvOdSd7MbEYJsJ+84JA/DGXnDrhBuqWu30/rNUwZnpswcH0QIoiYB84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4dgn8M+Jk4NmcR2dQdTU9AyWvLkmV12/ZAFatSQuWg=;
 b=VVxyreY7VgB+RPZP4neznghC/dPz3zR27guh3LV1JZm5H7r83TOscq6JB3/UED2N92klP4+847Vt7rhaTr2C9hrdTmqlQShe6gbL9JEUpHs6x3uZgpMVJZ7tuxu0vAJTh53ojnzI6p4UzYnqt0TksgkDF+euA95BNc7bvP+4iATfxwb4VQsIHPlNHHcDt8M/BQ/XZCf6qCnz1c3FvscPodxOF5WN/7fOd6SL/WPoRc0MgIgw48PS0+StXwsEqNHfs0U2Rc8IDtGQfBl/Hhd5DKD+435731AvWYHsANQFhG3spVOPr8KHho4YYieg68Mno0KXn19FqS+xmzEFFmkZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4dgn8M+Jk4NmcR2dQdTU9AyWvLkmV12/ZAFatSQuWg=;
 b=CPpMUxKmds3KrxoCAHut55XKIdP7+vcLay30OaZQ/eedtar9WfX+DM9rby2TyczaBr1ZiUgYr/QstLpiR5M5f7d4FVgVV56QeQaFxhl6aasQIXaOLxANQ7Oo2ebhlNmYH3XyHzYusHDjPRLxJ3YTqp4MLfVCAtfq0nM/4h65wXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:34:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:34:05 +0000
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
Subject: [PATCH v6 12/16] PCI: imx6: Add iMX95 PCIe support
Date: Sun, 24 Dec 2023 13:32:38 -0500
Message-Id: <20231224183242.1675372-13-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224183242.1675372-1-Frank.Li@nxp.com>
References: <20231224183242.1675372-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 764f5a64-6987-4f5b-ebc9-08dc04aee895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g1NFu/J70+1Nl1nyLljZIrbCC/HFWx8tS+5rrEVgoZgK7xDxu+fi6IdtYWJKAFz7TUtLmCA5EJcQMZr9DVZkVNe2rIqKnmq0PxUnFXorkA5YNWvHJb2DQan+6zRGY51z4Hehtl4dNUm+xjkvZrymip+aAeDncnKNAxdytMJHI3D2jZlrCHmKDdKqLPu3Atf9uhRP45OnLksQ4UDlRLHrLQov2EIKoSnIncDXoBwhnkMRCLOpCL0WD4ZwjNN89evy6d5oYvu7UVjTKR64oEAnxf9vtfBas9wpPw14cvfErbzbAYcO+6jw098DUWuUbYUQjbT9SSiEHT4yfwACxur7Jbpg7CWhNYaOKtz+LlBcwqYrqSP7m6UM17UJxMQRd7jrz2Bi2i2FtucWj7/tU149Q6WeMETQjVKhwCw1uGdY3qIlhcipv7pLyPNLyOe2vU3j35PAUVh+IinHEzxoWMA7Iwr9nSp3/TQ0oIUOUP44jRrb0ki+m/KpSDZgGnuIzxtwIVK89gtrEF/Wy7zQlyQv717DlXEVJbU9o/fC6yEo+tDqFarO46/5X4QLBpfkSEwwD70X2+wLlSxoKOupBdsyVOgtZQtA5OECcY7jyOI7ZYSKu58Zg+5fl/i3F32wmjwR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kJa4oCeDr9BrcMR8JAWfee8GUiQ1DnOFdB3rMRmACmLcaSBUBbVlvGbgtEm7?=
 =?us-ascii?Q?8KsXUq06ZsVY29bI7UcLdfxZxNQkAHMH7EAXha3E0nn0bxsRymnUp7bxqLq8?=
 =?us-ascii?Q?GuF2aLbAPoT+mRt+7nmNTwzOdfF7d4HwytgOl4FOHCEbX+hKB6tNsK75IxYq?=
 =?us-ascii?Q?4JyJGW13BWyVOSawzdmHwa1CnYoaChsa8SRUE5cfVXjh+UVcOXNn4gdqy+V9?=
 =?us-ascii?Q?MbbI5yNR0MDPVkQUQDsbQY9NyIr7b7Vt69e7BjtY3D/R6elbxG8uOWm3A+U6?=
 =?us-ascii?Q?hNF9USKhkEixCNSbaIsnSKJ2ArJIqIdFITXMteIh1GqZSyAmD0TlPqX1qwNu?=
 =?us-ascii?Q?kqqrT2J2KDBRW+O/a75+Z9UV0aaMY8WZrImmrlhphcAI7AD2cD6oeTRF5w3L?=
 =?us-ascii?Q?3mOhPhoQ6elEWHkLJqt76kFUwBlwv/vRPZBqngBNSY2HJ/6SAkliaVIMN6Kr?=
 =?us-ascii?Q?r7g8UUIB+vT5ejPlkI/z7eIW1dCuW8UlFfl4xf/0V3JfK7hsdgTe/YNYhNNS?=
 =?us-ascii?Q?eGBZZWrfX75pABdha3+KjpHqNWGlRwONibWG/n1ahDkoQlSX1pLsCoj2F1cg?=
 =?us-ascii?Q?EL60ZjLtsNo2HWQ5PKsdT5WXQvU4T2jkGpfLBlp0yQFFuy1gGsJUfDdPqEnx?=
 =?us-ascii?Q?RclKGBwDUcSWRYNRZs3vGd+2YZOXjXDEWbXMzLLgQRpvc3TVc9ayNMwGOoRq?=
 =?us-ascii?Q?gGRwjB0BwAKlHKuNtw1Co+UhmkWMhTttqiEJlQv0Vhkam8NrYk9suDIqJ2a1?=
 =?us-ascii?Q?L47Iensjfk3Hp6zy36ZC6PpJAKsUj1d2MRwn0aP2bfKXq4EbgTcFaGnOfDa7?=
 =?us-ascii?Q?SOQVda0CEF3RSIRHh2Y0VNGNgA6+m/9to5j881E/LSyotunwf/GkFsr277CD?=
 =?us-ascii?Q?y3f38P7uOgruwg7WNuJ/OoH93vUkImVpHOVPqy6sEsPFT7lSbyNqNnnd0ie5?=
 =?us-ascii?Q?zY/x4ntF0FigvDokP41hBAMfKcp7Z90o8B1Q+0wydO/vqCosOOa5xeJ0J1wC?=
 =?us-ascii?Q?/VLagkm4TFrInhrzECu+SvNfMeBA9u7fIhy4hof1tNHCniul0fWkdWeKtnfC?=
 =?us-ascii?Q?ki1zekECfNhuc3adq0BDhIuuMEDCLSxmoET2CMvjZwXN4libpw+BH6batR5b?=
 =?us-ascii?Q?EE8Jy0g85VUhEU7V5RQOnOkGtEmE4jq+L04yHFyMjzXkaQQbh1tZTA2xpt0f?=
 =?us-ascii?Q?a9hzRbHOROFs07PUdX4T2pgzJt9iCObp04d4aEGiO7pe99Tz8LLmP90mF0kf?=
 =?us-ascii?Q?hl9W6Btt4UJQSPd7Nj14dXD6pY4pBm8L15FoDlNtmU3FZ71srpl218KUV3lA?=
 =?us-ascii?Q?L7ksJOX3h2narqTIH5/svCAp5NsqNYVu4EoKRrHeUFCk6YycTjQXAe9B2krm?=
 =?us-ascii?Q?/x8NpgabWOeFgae0hljPxLkn7O9rbL0PGZyNf6fbvpQyWYqP2hBBZSK7R5/u?=
 =?us-ascii?Q?1Bg35bfUjIhPKrhU189ZBjwcdvB4knay+8Njxj5hF227JHAkxTzWoaW8s73J?=
 =?us-ascii?Q?ecOWup3up6PtDJyR+C/NoL/rO8VN8EaWCd3k8DRhCvDVN5YT1CyxQxsFv3fW?=
 =?us-ascii?Q?Foh2BVcmWWNb0Ajr4z8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764f5a64-6987-4f5b-ebc9-08dc04aee895
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:34:05.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/aPwQZQrurhoCF3VLTQhiVzD9wCtT4xvz8YK64f5R5dl3wecVlIUrRIC06MxMTBYgeTlforJnZDaEqoEbr3FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

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


