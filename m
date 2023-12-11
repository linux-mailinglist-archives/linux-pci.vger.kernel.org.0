Return-Path: <linux-pci+bounces-762-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B26B80DDB1
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 22:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4EE2825AE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 21:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213545576F;
	Mon, 11 Dec 2023 21:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Lv9zjOsI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50F5A1;
	Mon, 11 Dec 2023 13:59:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewdttP33gEaLJkkGpEs30YRT+eLecclyVOVhLi8xvOk9SNUIJ7eGhf5USfNHpJH+khakobXN+R1By57cezvE4z2WAImaATt/BQNk6nHk0ix7NGEr71VZfCikyLHoIYiJSNcsrhdWkuFSnrZylMafBZUfKqPLdwsufGKp6axn6IG0uBxonHQXlACAROluATAAbtCb8tePyF+X3PU7BLUWRjYRXEB0xVDM1QWOKlmTxT4KpIwANUjbNlgshcq9Q1/Bj6B94U/8T19u8SlDik+L+3p2sW3fd9mK02EvITbmczmcUY7dKEedvIITBrytCTI/WI2PVcVROm7hD89WwoiXAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbBDDahxSHbHCrG7mS9eltoOKUQdf1aRukZRyyGFXdY=;
 b=AGJNwn8NSUvpSqTzP80/8mXNMHmVgOTNhXfuJamrh6a0718f1d0DY/nSK7ykIaQ3juRmIVzGrrl6JNpITIwmz6jNvj3AYT8Y6ZCPvbTsnmjPVV/VxV4R0op/pwmviAEPgbDdKjxXEYJRuCBziP2m5afeqod9Ih5AN1N5sXGgqcrNqnFPUR4+URzdRjeyIYzbNxlHGYmAa7uBixncyf2yArGpJ5/asGVn5q6N+4cytucv6WdQgxDb6zktwL6KCg1d4gRZ5eJhMCkwUi6fdhfvOB5AyAjS9e++FUqeuwFOEVjTU+lLOGfXYdUZTkb8cptFU8iqE90xVPnCweLXIIm6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbBDDahxSHbHCrG7mS9eltoOKUQdf1aRukZRyyGFXdY=;
 b=Lv9zjOsIyayVtWYKTIBW4eeJTkICTs0ITa6b4F7KN6QHBgl5WRcNWje1CK3d5mRNYI6LAt+or56nVEbjXkYzpBKXkz47JHbpQyi99vF5QSJzdTi2b3bxnaxDeKHRwbBmZcauGD5AJ7lJWFAPBwbhGu0j9Zlf//w+qAwhJfsitss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com (2603:10a6:803:51::30)
 by AM9PR04MB7569.eurprd04.prod.outlook.com (2603:10a6:20b:2d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 21:59:26 +0000
Received: from VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5]) by VI1PR04MB4845.eurprd04.prod.outlook.com
 ([fe80::dfaa:e869:45eb:76e5%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:59:26 +0000
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
Subject: [PATCH v3 01/13] PCI: imx6: Simplify clock handling by using HAS_CLK_* bitmask
Date: Mon, 11 Dec 2023 16:58:30 -0500
Message-Id: <20231211215842.134823-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2adae40c-1c7c-4529-64a0-08dbfa946fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oKAhGCcrRZwGo1uSBFrZ3mu6KMI6St9rxhQ96yI1jEipc8nLz2BiK+H472reOmDlDAQoOOaG7Hyv3jFiUBxTpV7l6SLkFwE/2GcpjTzBlniNJaah75kdXhknmB7ntnUbhPvrSBkh/WWaIxqKpEWWPuPGR6BDCiL4m3F2prHVD5KG9LPUkndm7yZEJ2F66spAKDFJDyf+A1hdvkyh2TsfkSLg+S/jBhX0MwxpYOOSiEgY3KScTwYR+oQvWRgiuROTltkBO03NW0qMcEgjz96A7UiWZMzN4uT0xB61STp8kHJPTRW1MrPiQfor1pvCHr1+5xwS+T1Vffx1nWJlSx5RkgLOQYiWd+w5IBOsY0okG2XSTwjkDPPE2ablhbvAIvUUi5i4EhkE618aVvWPuFiFp3/a8XkpaETeQbnm4eY6CSIOFvPccO6NQpo2aqWsmU6n4ebV8vIroPgqEufPgnwShqaz/UwgMKLlTJQO4uVxcTzUne99gFAfa1aZs5eMCXQzqMMiMZIIGOzf8zniro4FpyKT4JUAzFBOi43/4rKFN/weOwLnpVZOFlVhkdO1qiRiahWRmAl9SfYCVbXaHpK9jda6xSnNoXVtD3WdFHc+RdAmCisWAjbfw5fjc2lY6nNI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4845.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(346002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(1076003)(26005)(2616005)(6666004)(6506007)(6512007)(52116002)(83380400001)(5660300002)(7416002)(41300700001)(2906002)(478600001)(6486002)(8676002)(8936002)(4326008)(66946007)(66556008)(316002)(34206002)(37006003)(66476007)(86362001)(38100700002)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fz4ObZDupr6bmWGs3vQGzDTdcfkQ1sI/ATHShFPUe02Xll3uYg/KYa43qH0k?=
 =?us-ascii?Q?qQjcvLeDdVUx2dPARPzpLxMQUSi46freAhFy04stQdnX7kAUpHJR3s4LlUye?=
 =?us-ascii?Q?96YvzdL7LSPGBfblF3glNBeg/U4kV0ftsErbU/PSTZybmWH31e1dYz8+qiND?=
 =?us-ascii?Q?w/qWPynTDVubiYsaSD5ciLs/SD3ACeO/MMZZXOHaWluvd9rKlsCLYMj64J1Y?=
 =?us-ascii?Q?0THnvHBSnvx/nk07xa8vVvj8437NS2URNZJj2d0NO0nMXWnfhDZzLZF2usI0?=
 =?us-ascii?Q?5Vs3xfP+8LQRJp7ROPN7fZVC9wBeRJx1wI6QbIY5n3VBzNKaXvPp7wVkqxo/?=
 =?us-ascii?Q?UtuUonwB5wJ3JyHZOZnnL0VBRUbY+/vbS2GvFK1yPWVdPipPWOpi7rbkd5c7?=
 =?us-ascii?Q?vSulLms/aVwnC2Ti/4foApKWvsvMkoknNDrpGbe5peqqcdMwR4gDTMMbwAOa?=
 =?us-ascii?Q?x9TKgDJ1zwq8sQM7+4KfBUHk3tGbmpYa42E5FGXWhfmFfwM2oUMvtGY4DcUR?=
 =?us-ascii?Q?P5uZwPLJesRvkpn7r+yjrN7lW8pvOq5Ubv36MnqJtOFO4y0zxkxHFS4KOmVI?=
 =?us-ascii?Q?yWjPgSiJWXke7D0VHlXhHpSYdJQdqBXFX2BTmzOOdbllBBXXKgmGGz3bSDcu?=
 =?us-ascii?Q?w9h9mEycihRV4fzWQPnAzDwwmtwGZ7OmvSlMjkpmJtys1UZenmcGO40Rx+XE?=
 =?us-ascii?Q?uxdfrJrDmXd0ziKtZs8WMJVeoYufOPkcBqJB6kjry+1QjvevH9+vinSMc1O4?=
 =?us-ascii?Q?19gmEjcUjOgzEjFfavcHfqBa/qSjF+hLRG4qQgSO2ybAeoktIxksmN0X3l0R?=
 =?us-ascii?Q?GH+UGOseRkM8bPZ9eGA2v4aYnU1uHDYUOORvCNCwFY2k6DcwavHaUw8nIUGP?=
 =?us-ascii?Q?iIZjCHQOs3i0HhtWj6VuWBmAO+cd4spifcxyXrOWEHnorYmIQ/7D2zs1wvPI?=
 =?us-ascii?Q?S6QBYmFB3C7lukOcB3xyXy8PbjCr25s4h40Z6lJsOJsfZQTCOjbHyc5XBnrU?=
 =?us-ascii?Q?RBW7IK5GLrFStaGyJN54cEOrfWBs1wyDUeleCq9OqXwhI67IMiVOwgz4pglF?=
 =?us-ascii?Q?TreAULy2rZzdyzJCZAibhq0SIHREFYiML+ZqEsHxT7UO1DQoMFWofPOQJw0c?=
 =?us-ascii?Q?OuGzfcE87nbFUdeXbwL1uT7A69RkNx1eLlL6fz4J5/UKVRroJoiXrsfgd9WO?=
 =?us-ascii?Q?43zeUtLdEDsek+XwVT3c2tnoTIxRxz8V9cwA8+XOR2GUmFIKerdHdFQ1RpDr?=
 =?us-ascii?Q?9hYH/y/VfQ15p5Ec7f8PPHKgWaTLI9X42ad4U3TDtVLwqNUyREG5yCk8f6p2?=
 =?us-ascii?Q?qP18p1HkcY8vqQmKRZQ2Y4HELfmsImX+aEz5hW2OcMkzG8N8nBLBvG8hfZtL?=
 =?us-ascii?Q?hNykj33QRt9p16vRaHjK8gn1WMvaV2CWhadRwvH3GkC2QB3l7K87HIfDlj7H?=
 =?us-ascii?Q?fgSjJEXs0CbYqLcgfs2U0kx0WFyF5nuwsHImAVXkbXX5cZb9G2uFgN5w541J?=
 =?us-ascii?Q?UsFLVmyuYrsYBmOhPgilhEuXZoz0/i7cR6rLsaziuOgr5gFOtnZa6VsZwIiS?=
 =?us-ascii?Q?+oOt0hX+6k9rqFrzvBUHB5+3uxZEs11z1NpP2MUP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2adae40c-1c7c-4529-64a0-08dbfa946fda
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:59:24.4624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esMg3kXDvfd2onBLRwOYFSn2ukRUvV+yYD9g0JVyQr1no4AjX9h9H3liRjnir9rHy3VXTxxPpQhHpOMVfSdxAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7569

Refactors the clock handling logic in the imx6 PCI driver by adding
HAS_CLK_* bitmask define for drvdata::flags . Simplifies the code and makes
it more maintainable, as future additions of SOC support will only require
straightforward changes. The drvdata::flags and a bitmask ensures a cleaner
and more scalable switch-case structure for handling clocks.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 84 +++++++++++++--------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 74703362aeec7..8a9b527934f80 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -60,6 +60,10 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
+#define IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI	BIT(3)
+#define IMX6_PCIE_FLAG_HAS_CLK_AUX		BIT(4)
+
+#define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
 
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
@@ -550,19 +554,23 @@ static int imx6_pcie_attach_pd(struct device *dev)
 
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
-	struct device *dev = pci->dev;
 	unsigned int offset;
 	int ret = 0;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6SX:
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI)) {
 		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
-		if (ret) {
-			dev_err(dev, "unable to enable pcie_axi clock\n");
-			break;
-		}
+		if (ret)
+			return ret;
+	}
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_AUX)) {
+		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
+		if (ret)
+			return ret;
+	}
+
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
@@ -589,12 +597,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX8MQ_EP:
 	case IMX8MP:
 	case IMX8MP_EP:
-		ret = clk_prepare_enable(imx6_pcie->pcie_aux);
-		if (ret) {
-			dev_err(dev, "unable to enable pcie_aux clock\n");
-			break;
-		}
-
 		offset = imx6_pcie_grp_offset(imx6_pcie);
 		/*
 		 * Set the over ride low and enabled
@@ -614,10 +616,13 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6SX:
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI))
 		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
-		break;
+
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_AUX))
+		clk_disable_unprepare(imx6_pcie->pcie_aux);
+
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6QP:
 	case IMX6Q:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -631,14 +636,6 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 		break;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		clk_disable_unprepare(imx6_pcie->pcie_aux);
-		break;
 	default:
 		break;
 	}
@@ -1316,21 +1313,21 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
 				     "pcie clock source missing or invalid\n");
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6SX:
-		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
-							   "pcie_inbound_axi");
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI)) {
+		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev, "pcie_inbound_axi");
 		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
-					     "pcie_inbound_axi clock missing or invalid\n");
-		break;
-	case IMX8MQ:
-	case IMX8MQ_EP:
+			dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
+				      "pcie_inbound_axi clock missing or invalid\n");
+	}
+
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_CLK_AUX)) {
 		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
 		if (IS_ERR(imx6_pcie->pcie_aux))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
 					     "pcie_aux clock source missing or invalid\n");
-		fallthrough;
+	}
+
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
@@ -1353,10 +1350,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	case IMX8MM_EP:
 	case IMX8MP:
 	case IMX8MP_EP:
-		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
-		if (IS_ERR(imx6_pcie->pcie_aux))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
-					     "pcie_aux clock source missing or invalid\n");
 		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
 									 "apps");
 		if (IS_ERR(imx6_pcie->apps_reset))
@@ -1482,7 +1475,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.variant = IMX6SX,
 		.flags = IMX6_PCIE_FLAG_IMX6_PHY |
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
-			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 	},
 	[IMX6QP] = {
@@ -1500,30 +1494,36 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_CLK_AUX,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_CLK_AUX,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 	},
-- 
2.34.1


