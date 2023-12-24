Return-Path: <linux-pci+bounces-1349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE49D81DBE2
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82890281DE2
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD4CD266;
	Sun, 24 Dec 2023 18:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HCLF0jIE"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95F134D1;
	Sun, 24 Dec 2023 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuLXfPNvp1s5QrfrTlrRANF52/+aw5qG+3iwkqKC2xzuglNX3UnSLiCBGzFfUWNh4lOkWqb32HY4FVabHX/KkvnFuCF7f7iMROjJi3hzGod+Eu1x3pgpIYzLIbpNHOoy8aClOzTx9FHbyWyJ8HviewRHQ5+yP1+v5/oe8YPdGhRJo1dkHFlVUoQgyDK4ZnO5A6L1JfyJyQA8KMlJ3ynA96HoRxWboSnzWO39pexEs5/DB3A0kHoBPNpcls5TQJuivGA2nKP3V69gg0LV+kuT0MGZ+dxBasYJwXrWMM1T85szSbyTBpzv4BAG7jdtJ7zAXlTgn53PKsxeK4NHFlYSgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfBQoavpwzUAjcM4KwLeAI4dwVXf+6SQBsdUZVKowR4=;
 b=jX6VpIg6Ftr3SYiGwfMZAQVdmjLs/Zh5k9ns5LbgyChUsGsrzos/rVwf/wa08g9hULvHszc8Ovib2VM73fyb5fWBJF9YMFfG5NDG+PuEVc/cGDSa/3q15G5cz+rlG7/N90rQIEIMOvHwEei/erVXOp9gb50XMksesCV80p+qYybtDJFGR/Tlydj4KPGUzBOzVkIJdFLAPmRlVnJKKISx+FFogAeWI4lNpBGvzu2XPW9O+vZxfFxKEV6NNc2+GNAAk6ZoMVqjqnIg0IsALtb89IPGGGxDEwwS22ypCO6pL9VwEo3yq/YtVncqlLS48HZc5g84e1Wa2Lr7zwQoQ1KqYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfBQoavpwzUAjcM4KwLeAI4dwVXf+6SQBsdUZVKowR4=;
 b=HCLF0jIEopvvo/0fQS0gNwVIv0otFc4xzNHnXEx6Z4XsIkF8SU10QWoMgm2dAOsmLW1/oJqa+b2nhedicY+TOrbVoInhxYpguwbcfjeBYG4PjjIqouFz/bn7kBmbjym+hOoYpAkHIHHxKzTXnUcWrD8Kf94eTqKzfVPvtSJdrEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:33:44 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:33:44 +0000
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
Subject: [PATCH v6 08/16] PCI: imx6: Simplify switch-case logic by involve init_phy callback
Date: Sun, 24 Dec 2023 13:32:34 -0500
Message-Id: <20231224183242.1675372-9-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a9bc201a-13c5-4798-85f9-08dc04aedbc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pvSc4ACCUZW8bhnPxogKM4gNSKmAP/5nThRD2/zZMau1ydE/DPxbLgcCyd9gyUy8llyuK6tVQyZTVLoeggvengCdGTR+sDezz+9uOnKLe6JiaE2DeB+m/pp9hZ57ipKlCppaAjQO/xCPCy4nKHjNg1b3bltXs6g3Ro8SAd7AxDII3pow9ktLnUv8AVjYnQ1aBxvZtua/k+aKbumEbEtwAj/saPKvuK2oupIQuWE19z7tSRmPpgxGINQXIzJaSLDMgmQxdZB5DarsUWuLU9Z+XdK42RJmKWFzVp4UJJCZPc8TADLTYs6CVoHJiArbBlE8g9ILLb7fjH5Zcp3k4w1y7EyUJPBYLXuE9TnpZ33J96Kb9axz83eEhPaD5DYnuE1bQnrY8yCTNJNNHS6AzQM+3lsxDwbinp9Fb4ItHbxvSaEhWH5pRJRU8NFMuaBExb1kxfzL2onhuWhr1uiKLzwPbHgjTz/9T0ULBcWDiN+KryjiqjO7SZtsps4Dp/59xLO/6p6iPm0WYnoli8b05HwHQ8entd1EvgK0oojCYnjgkNaOToWa+MeK+CsrTGCLqpt0IgBhRTK0txrVnMWgVJPafS8Xybtnnob5OyweY1q549Z6RHsMzN5csonRD3UrEhYD1CbFJnh3WnVCO+SIbKHMwJIqzH28taUuHbSaOC5UjYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230273577357003)(230922051799003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iljX0nTp5gXqvXfivtPAEz76csZmPaVSScOaYB7GdR6/JNHhqmyGU4bcnXBb?=
 =?us-ascii?Q?oyheofM45pGC63+gyZUtMthUTpxnW3nrJ6NMVDvrxkhoYlWh82v0O/U2axO1?=
 =?us-ascii?Q?IhysKKWWc8NlvhRHl46vs+cHyB7EhFlnZuWUR/eZbsCOM/nnzYeKCBAVuFs4?=
 =?us-ascii?Q?mBfyjINoCVRRMDN9bWV2VIkkaRXNxZrkN0meSXbZeMQlVKMc7CA/iBKubJIE?=
 =?us-ascii?Q?Zqm/7HP1PTKE/WTppAGxorCsFET1MX821mslamV/WCahCQl1+qjfsvVzYa3e?=
 =?us-ascii?Q?qlAucXoyVA7klVOgazNYJ4YC3h6lvRGcXhgJ6SCUNteyecPGmFKxgP4NnihU?=
 =?us-ascii?Q?3+cJQt6WYqqPGLk/Ifpqrl5BVE4q/E+VYT1/ZKfLK/rpsPFp69M5zPB6fsf/?=
 =?us-ascii?Q?+CbW6p82E6evTGN03/XQ+BymUSv0VOVv+oAtSARSM5SuHi5FWpG4m4YLt21e?=
 =?us-ascii?Q?iehnbVvSLHqYAvcNxA/Ehne30Cmu354goe0gGifXNMO9BfBa/9GH6+piePFR?=
 =?us-ascii?Q?M2YDZs0jONjTBtk7MyPie7g8cFJSkhY0Y0iglH0h7RQSA0RAnDCFCnjba28D?=
 =?us-ascii?Q?MxKfYIVA+I6oZkB3932zAPPsOaTSjX5PmGIjfNiC+NCQtkpfeAjS/xLAE0Gu?=
 =?us-ascii?Q?HP5RhAfUDay5O8bCsWYS8VgGudRrKk4ymxg7VLfUK+d0g+6lgLN0lu06231m?=
 =?us-ascii?Q?ORXJE3FNSu3IoyxOnkYtXtphorkliDF2CjnHmSnloRtz9gpCbMxXwFekrdfb?=
 =?us-ascii?Q?5i+ifDix+uY0d6qEKizpZrwgtoBsho87FRHwdqZRT/dOd5/cVazzhphdX6Je?=
 =?us-ascii?Q?UBYwxY4XcY4qj066OakpgfJw5MbJFFwI5OjbgKy9NXwJHdJxFMlRIX7HrlId?=
 =?us-ascii?Q?bJ3uPFFDMpF74HrCDTjXtTxZ0FRDBT9OY/Yyj3BAjdwIsA41HEiPG4i2Ucyl?=
 =?us-ascii?Q?Y1T+ssGyt8Z88G2zWrZ0JYI/sefvvRNtwtACkyjKhereth4Ts+U3hAFCvxLM?=
 =?us-ascii?Q?tKU4wGrNWowQZ5J+r+nD8vuaSS5DiUiq5A4bnCGmOWcxM265Ztbb5oPm019d?=
 =?us-ascii?Q?0hfcf75pkrg+jQySci9efooeEXA4/f84djqw94ZKB90M2jmPfs/rK34oyuSY?=
 =?us-ascii?Q?3E/wkNuqDlhEdaAeCeNHxZ2DFl6xGCyZb95zrAlOipKx6+BilxwvVlMXa6iy?=
 =?us-ascii?Q?G2xiC+MXKRPT4tLfb60bv6IT9vNW6jt4jycqxSSTz1e9odOIy17o98pmrSzx?=
 =?us-ascii?Q?3R3ysqWT4xsitXnx7zS+6sSqIv4rEguR46smjEt0HbdI/BlD10FJRpjz7Xsh?=
 =?us-ascii?Q?ftnNgVndzw558jhEtxmHrgmBiTfUXSUPLhMyvmoxq3uO/1AXDJcsBzvU/KZr?=
 =?us-ascii?Q?4v7QtSlysUcThepDw3ztQ6AzwckttzexZO7fSXQ6hS9inwQw4GjzuE8pOx/v?=
 =?us-ascii?Q?dzOI24uuWclpe8uGn+1q4fO2VKtmHqcEhbOuJknzfUrHArZYxx2BNDrUeN0G?=
 =?us-ascii?Q?/XZE6YSvUcEhmtKPPOaLqkO56jYTSyZo2rNXcBTzkq6jRdwT9C8Nf7jsMOoJ?=
 =?us-ascii?Q?snJJ16vu41R1hvDzflE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9bc201a-13c5-4798-85f9-08dc04aedbc0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:33:43.9321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJHp3GLZDaB8PuhQyGaOwpnfOv8z6JufzPGXOk4ulEubkZIpPCFOBP//XPQ/kHKWxHXUn8UtmnUC8KHPJXf3wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

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


