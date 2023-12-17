Return-Path: <linux-pci+bounces-1109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B0815D88
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:14:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8FE1F2247B
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8C61FC2;
	Sun, 17 Dec 2023 05:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eI/m5Mbz"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2074.outbound.protection.outlook.com [40.107.247.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1E96FD5;
	Sun, 17 Dec 2023 05:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lo2X/SUrKWLS//E4vRZNoFsxz0FSakjf4eqSqUmq1CH9gALJSPXWIpnTApSUHdR8MXy97rOtWb6e0gtBPs3V6NHXnpeL7C6c95iIkpCfs8by6+zznkIrycPEYWEduxlamB1WnWl2LqHX3uWhVRnkOsYEbchQfBcL8HPLinZ6TQkeu+yaYTuW96MHwLX7uesZ9ht+PDnrjX8Yj83z8OrmhttFOtzTdy0HNt3Spo6rXZykGxhv0nv5AwYQSRXXPkfbik0oT4mWAt3h3Av/FYXEKr6iO6BX9g67VPWKJ1Yp9xSLIbg1/jSsjw42Bx5DFxziJPkbNxT6DZn5kqUjLdFYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRxDg/NAomMTqlX4Z6UfbpXvvgHB9ysSIKqAg9Pte2Y=;
 b=U9Z050JFCcU+acMnmWmIiYGPle/74JXxqOJNoAmfInesVJ8ANswj/N7+TZVgtzDE/8GqacJmkOVq1qI/KMcAB237ZgbyfUKqMZ8d9mlbbs9yeTMmOY7Sg5+qMTnZTyp0CRJn/ZuPvic64bAp/6IkL/i2K/ijPCve1kqxBHQjOPHqC9F56ZqT7XWq7w3ibADdEtT64iu0YJJuEIqRTps3i7LNoK1RXWcz/7tKaCiedVzMCzlBFXJ4H4lP1OLJIt1OH5l2iYwVTCV5pQ4i0u/ScTAL3vAfz1/VD3kQ1vMZsYyc8Gdd9+45E43AVxoIvJ3PcUb2TWmQlgdu2sW+sCPprQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRxDg/NAomMTqlX4Z6UfbpXvvgHB9ysSIKqAg9Pte2Y=;
 b=eI/m5MbzQmCzi02F9vgWQgG67Qo7KyVkQb2+cwwPICIEew9JKVcJZ4tZwc52FayplAL5LEckYMTP+fWthHt51TWB7LzHM/kZM+4qbfmkHe1brtQS1peGXG/WLtrN5nZdXYaid5leJSf+AIFFj70uVPkBQxZrQG9kZxnF+2elNYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:13:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:13:11 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
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
Subject: [PATCH v4 07/15] PCI: imx6: Simplify switch-case logic by involve init_phy callback
Date: Sun, 17 Dec 2023 00:12:02 -0500
Message-Id: <20231217051210.754832-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217051210.754832-1-Frank.Li@nxp.com>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: efcce15b-430d-46a3-053d-08dbfebedd07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	49PPkxHTp+bvX5SIWIR2U6RqtHtr2MFnWEtSJcbDwguXUjI5rgQRyXkB/VcM8BOzUpiJazjonxkV01V02O7XMhtEgs8XZtprY0YPTyg4VaMk8D9lJW8GpLGMW5gOEQIbs6+6QC7Akmk+xqxTg5MhwvQm3SRFiYLnIPM+yqwrRo7oOeXmLBJGmVvAJ9g7kqmJH1HI0527P3tA9UGxrR536iSyJOZNVqGA26AwzsgfM1dfP4krZmWLZWONP6L2hzIYUtOFVqIt6mWU345VITAgNa+hh9IhW/UQZGOLLoJudUYIhj75G/KBK4cQKq+i8KsZ8eHSBeuiLHhoY2AHFHqo4I9heRo0O/zME6LuHjuMBXZp9j2/QzI/2fQ0JgDmmtBNvxIaYoegJH4wVMMk3mlenxtVduAvenggu1yDZQLOvcbM68DiMLexObU1q1meDUW68p9HkXeG85xW9X3xRHkPLGIapgo+GdorzTsfulif0xSdHPFzq1ed5KeKieDsm1GMN9DsCjZBtFu4x98cevktjkeTvmGKryoCPhgIQ4L6Xmy4JzeFdkG5JgASUIbCFords5ieOQxj2+UvZAwaiOxdMIbV+ugTg4qiFnuSkZ6/BctiqdQICSC8hF2fGxX9mDMLwr19yMnAm5dcJdyDx+uaQfkNo6dd3O5uv2gbpWyjdtA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6666004)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UmyZkS2l+H6Zu4eSXx8SujlHoXHC3ERbcEtmMc3P6Qepk4nTodcdVUc+QFvp?=
 =?us-ascii?Q?Ip5yvG+fDuG62fzZI6XPCvR4+W8Y8h/aFs9SjJd3zex2NzWYRUr9KGJFSoXn?=
 =?us-ascii?Q?QGfj8vOG8T34PmB6IkQAbpa0dQhIqhx4F4FZ/r8i/4smRi6+35KgN6UpsRsP?=
 =?us-ascii?Q?/LK5zwagIoeQ7XVMyiwJ7YiUSHBZ2aUUPJpbHl7Oo9+tIfI1eXiY+o/gITr7?=
 =?us-ascii?Q?l7TL/JlPRrsP2gAUkDM99g6G5r2fqusSjF9+rg/haOENAgBDXiN44bqQSTuY?=
 =?us-ascii?Q?RQS/hY3gPPqIquVawDywJfM4/erT/UWwmMsRFT3+mNIJ9NhvGHHc1OLofNrs?=
 =?us-ascii?Q?D9IcMRTRc+6k15D3HgYC4G5E8c05DHitF31f0Va2ESk5Y4K4faSVtN9kuGs+?=
 =?us-ascii?Q?dovdC4di8Ax1oC+HK44hePkP4ji+yia8FWqJlwkQHy+yjnHA/Ywy8mYbBcu+?=
 =?us-ascii?Q?UBgFdtI6osJg1r3/2weyv7geEFrngWJxW7YB4mKHj23xOpGHZfMxtWvIATUu?=
 =?us-ascii?Q?0q8eB8C4DT3m57ib2zT9P2PFPke7/llbo85pXUbUUT2z/jSrBQCx0YYyBhqD?=
 =?us-ascii?Q?7M7kqwMvnNbRHc+CUd2YfwdfU5cL3DZyrwiIKuHsG7nC7XZneNLRzKAKG1Hq?=
 =?us-ascii?Q?iF7HAZEo0gs8mjpZolkIBQiph2Uq1cZ/jrs81NKdQznbpl2hCVzf+iL5fblA?=
 =?us-ascii?Q?u5SVqFwd3tJXJmfXSPKD3p8C1329GBffPMoIRhG+GHRApsC+p0v9HiDE+xsP?=
 =?us-ascii?Q?26T3sEgzv7gg6ryNjSjbMBWz48xcMEFwy/8GW5S9crqi2DxtV1V0IVxY+PER?=
 =?us-ascii?Q?p6g5TO2PJfC/HPVIKH2bxo6EUsW6O41tPqu7WP4YQdDsWNM+zh+JDsMmkGuP?=
 =?us-ascii?Q?aNs8nrCtyvU7MaSTHW3OJvY0/Ryeg91kzLnykK0dtyQkIFQNzl4NS1RoTUNA?=
 =?us-ascii?Q?WtI7US3NP8AFFTrk3uhfCDJ0lgCf/Gz/OKFOykevPAwYrDvCI/zz256pHu3z?=
 =?us-ascii?Q?jJlxql9ymcLOWwCscoT6J/cXFb0E2PDQPqjHu/z1X0sikmi2YkYdu4Cxtq0h?=
 =?us-ascii?Q?Ns6y1jI6LgMjgSJCreg9mhms/TveO6iCbXiUeGM5bdEPZxjNgjqeD06SDLep?=
 =?us-ascii?Q?pUjupFNRQ/h0TXx/aBxNPXC+yOo/8FmPlQ3x+vCWUw1luYeD3UqDdezRko8S?=
 =?us-ascii?Q?PB68cHqSKEmssyfazPV7M7U/kdy/sYzHeoudcqwfLpOYvk2qpoemAxv290O1?=
 =?us-ascii?Q?TMTXh7Re6V4BoqmKpxtf/Qqd1evtAEM8V8m7er87+MDn1i/AW/jqz+OmZ0ug?=
 =?us-ascii?Q?eYHwzjBXZ6sPYuCItob1gSDhfPnhEgdMMw+f6ib1OAM5NmSqSj1u066bKYgv?=
 =?us-ascii?Q?xjq6HODtb1tdoPHN+x5swJHprnRoWi5QlrQFfwipNULpzpAYTGBpUKk9MwkQ?=
 =?us-ascii?Q?iDGZAqfcLfXWNvVmHDuAeGigAXb5FEo3ta+zeAf+HPJwCq4cxE3ctgQHYfJw?=
 =?us-ascii?Q?IFXCFumAcVlGWSQXG5iUdJD8CAts43A3yE88z12mULMtqdQ0EvkM7j6vrdGU?=
 =?us-ascii?Q?EwCDfuvpo53Yj1e1C8k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efcce15b-430d-46a3-053d-08dbfebedd07
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:13:11.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19QJKApGx6fo0H/s9qg9FWGNW1JzQkOvdxyhSAuvqhO1FLPO/8u59s7ZIaoMxsH4ibWAHH44AXBPlEtTGUA4Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

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
index 49b98593326f9..02da650aa55ee 100644
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
 		.clk_names = {IMX6_CLKS_NO_PHYDRV},
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


