Return-Path: <linux-pci+bounces-3097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5610484A0E0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2571C22803
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6D84594B;
	Mon,  5 Feb 2024 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R1h8T2gR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2056.outbound.protection.outlook.com [40.107.21.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EB8482DF;
	Mon,  5 Feb 2024 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154459; cv=fail; b=gnS5dl0chmZwKMcVpbWUmJdhOPNQgQs1P68Q9+14Zbm+x9RjKJn476o8umKArU6WTdI83GvE3t+7I+w2H61O1UjlMSV8GK1fR7djz4vrDhrImGqiBwdZT1tqx2a2r9fryqSsh/ycVknCORkLPj21edS7A/i0SdRPIdnOyLOv4tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154459; c=relaxed/simple;
	bh=oUIGnmV2lWjsucFOMaIch/hxbaSJz55hIqudXEi2msU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uzif3zwY1p5tOBLBrGKO9GkmTdsE1uOK+SkLTLiDQnqAXQ51Angih5k1pi+oqvILZGGTXCWWWOW6TtzD2pzF+D+xL8vHVgxh+DmRF0H6Y3qlFbhswh+gROEmQ4rpuQ9h7Y8Y8PZc1nKrW0rVVL2adg05dU0pqvegDobbHn+2Yuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=R1h8T2gR; arc=fail smtp.client-ip=40.107.21.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEeeIOD9b+gdQBPll66p0ycjG2cIJcztFs/ZTN7nJkGlJHx1ccjV462PYr/koaD71YuV/+IWVciL+Gy4b6ZbmPQdtGlRz98ptdO8ydqh/crXnfePdRntjCPs8bT4QFO46T2jh4wAe7UiE6b+8SLlFlMXm1ZXibLzwGgBko0ybEhNvdjeM1GNzx8LZ09nxLvi0dX7ma6AODkpqEDkU8zl/s4svSLt3BndOSYDmrICVXcT6TXQ6IbEK5puzCvHoYuc01Sakyl8vzg2siZbM7+i5bVzIw2vGi+FMVmudHQyyPOT1a4Xwk719qyvzH3s5hRrDN+TDFW2FCErgT5FvGkddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+T9MBlOU/NcBmlihx/eofgh/QxmIQ1t26t50XO4ZyTg=;
 b=l1zEAAtuD6eXTEatVs6dwwNLksAW/7qDgPuWRoONlM6kDRjl4F6l12qmcXxDi8A9T7EaWK1OiLAeRI06IBdIEp6a7UWKOcCSm/wKuPj5Ro1XRimiaJ2LfGlDi5h7lHQ55oaiPzzpG+xyRAr/cPGqLPigjSZmRtIEk+sElp9tyhoSo9TVqeY116E44D++dRK3j/YdreXWHAuZ8KVT4Te/fghFSz+iyBuqXKVCzoIh1qJcHNbQdDNhdjg5SiCh1q+xaM9xBwR8YN9u/yzKQYsAJrWKKVRwqmDf1Z0WtZPhiMBKNGdp5+jB/RyNvqb0FA0ynT8T280tK93GYuij0zutCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+T9MBlOU/NcBmlihx/eofgh/QxmIQ1t26t50XO4ZyTg=;
 b=R1h8T2gRE0SR/hFRuI5zsa/vhi1Vdp2WrdXTHXsuzzvg/FTrWk5zmIKBbreEHNCtJYqADGtNQdtRm+LPAIbFkLOWty9TG0zxNHSMAIrK9zXBIs72I0uSvAjbgQFtTtuj6LVrz1fFJJ7wjY5sSSgkezd1Vso2y/b5eBhRmC/65wU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:34:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:34:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
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
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v10 04/14] PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
Date: Mon,  5 Feb 2024 12:33:25 -0500
Message-Id: <20240205173335.1120469-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205173335.1120469-1-Frank.Li@nxp.com>
References: <20240205173335.1120469-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:a03:60::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 01aa6d95-1799-412b-8f41-08dc2670ac40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	leaPW6aXfUFt15JBuaYvmPHhZssXTGIVdHmZVjWZBpNI8YU8oW7RLtCcZJ0B1IgbX0tr1z/tliGBAHVFDFOjPQWW+lgzLAyZXNEbRXvXk9Uuc6iJdq1x8WrR7yiaSlnYnzcGfe1BIhCb2m7xgzcckZ/Yk8INOiU2YZlzW4eanlJtQnRY5+Nsd5ahPgvy6TzTBJzdsT6ksY7w+AXv/ROn69XKmnDl6ZfngUrAUVgulLfIDW04HP92mHw3enuA/MoGk01xDOGHyvhVv6qUWs+1sTgiqZvxg/u1oDeTb/57Ty6O+BRjyAlM4Y1jRz/ZqhUpwVZqqTtRQtAUYGDGDmjgSOwrbsfTTLFe9Omqoh1+BnMfVhcZvuRQrZ8SEvj98ir5uJrX3wO+7hNPTZqXn/11GYEQGkZIIDyxXBYpAgA/fh6bhWLgcq/v9BwVcsj7VQ1UongvdlML5azWe5Y9MuXJl2pE1abHvbuqyGFoGd34YtHuiPes0WrjFvwL/tRytbCNflQO40TbiNBvzjIuhDh0PDUY9XLjI+DhojLF5Mscj5qZhqBgLrbBhAwNitX/o902wQ180H/TO+wYhbWK9NtH2i+giHhIO1JapzM/qAIogB6EUU28AjIiQrueHSyTFc34
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(41300700001)(66556008)(66946007)(6666004)(1076003)(478600001)(6486002)(6512007)(52116002)(6506007)(2616005)(2906002)(26005)(4326008)(8676002)(6916009)(316002)(8936002)(86362001)(7416002)(66476007)(5660300002)(83380400001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0CxDP9fq4GDBaaNOpv47xNzcFSuKHM8vNHxHAkGezDEE6c8i9BuD592+Dt6I?=
 =?us-ascii?Q?OzXs4u1VtJ1DhzCAac7VJz8l4DANqjI1mCR57qCMSdOFAC1xiggVA5WkxU1/?=
 =?us-ascii?Q?nXiLYRuleIwx8TEtrI0w8a1k+3eeZLnVdV+ufLuziF3Qk4U7NpzChQKv28rO?=
 =?us-ascii?Q?OECxPlI8Z5f67pu8Xg/bYG6YU3JI96yGaXrYnJp5tVQNpfbqAbbZZCELz4UA?=
 =?us-ascii?Q?mnewYCdQqFj/J5EOwcxGVGdKWs7lqFhGuHpYZK5WOKJSr3R00jGsP7OlEZZB?=
 =?us-ascii?Q?pGYlFEp//Wjqc/6TiTNuH7GnDt9lTojcxCgs5mb7YEI1FkuYMzTriE8YW6sn?=
 =?us-ascii?Q?CKpt73+7ziXaq0wEdcF7+TjFC99qJMWPDWWOnFS2ZLSFd+7Tg3zJXSLh9DA+?=
 =?us-ascii?Q?11VAdguiaYgfoTP83Av4oTV1bPLLquo+5TEn4/JYDDUfxhgX17LMmLsf8V+i?=
 =?us-ascii?Q?Kly4CmMDvcF0ckMY3IromWlVbO2QzvypSKoO9owapjReJYlA1+we8iNAmoqt?=
 =?us-ascii?Q?o/H9wb9S76HIM1NQwor/Su/m7kAqyk7lBIufrsRuOQhDnzE8/TOph1DjR7n9?=
 =?us-ascii?Q?xJmYuEEkaIUqeJLIgg4vSGSgELP/FvXuINutuPrZKnZIlet7t5Hf2t+0/pjX?=
 =?us-ascii?Q?q9Z2/+PQrjtVU+VEV8UuC0mgaH6hBBaOB6PpdF04NIpC5Ngo4ag1zlzeSFcQ?=
 =?us-ascii?Q?qzuDxkDzuKNXFpW6A6rT15CbYyEh7P1P2AULjXyFCu6Gvi6RzSsa1FW7p+ln?=
 =?us-ascii?Q?r6hPtQ8xBhPwyqsUQ1wJKfl0mLB+DOy5E/Eq81adaDLaXoZQckA1UJeP72PC?=
 =?us-ascii?Q?Eve4JMdR52e9kpM6SXaF4yyexIfMxzFOS/4m1NPTRytxjW6A+F1S384hUQba?=
 =?us-ascii?Q?peo78Rdivk9+16FSdsL2nvstn8bjmyFxEmpcZvZlt9GhJ1a0YFfSm5fOzm0l?=
 =?us-ascii?Q?HVZj3kqtk2Nq9JKoYtU52DnbcGtzFDn7VzeMxKsC0xgObmwRPcBXSXvViGkS?=
 =?us-ascii?Q?g5Ac5q92kJKFFk6BsH8Cua2Vn9/6ULkAzVqhGIXnGUc+fNy1VyOxJVDyQm3u?=
 =?us-ascii?Q?SKz5A6MAgBWaiJdG7eGKn2roftWsvCL1ANmHFTG//GYdgOvmGcZAZ4ZnI1HH?=
 =?us-ascii?Q?GtmttLwunQp27qpNkQL/aeYZw2oy2R78/T2fSxcFST87Jg/j8UVJQrni29oh?=
 =?us-ascii?Q?385WyEQqq1h2yTXcc48bXLBLeBZO2AE9SFeV0fX5LOWWQn8kIB1mqnGyOai9?=
 =?us-ascii?Q?JaIQTA9XOfxrd/gzq66zq6mrtqAprcckdkZEqOTt21Fv0Dlvv+4nx4MT5Pus?=
 =?us-ascii?Q?npoOg854+HCGFBoMBjs8NtOfCikqjxFS+UtUVgiWFstmmhBp5wCdPLXKfw7w?=
 =?us-ascii?Q?4w1kZhpmEJag6kdvqV+oEV0zh1PQIVPoIN6FKfYFlDKfh0cRASaMxJTx8DFn?=
 =?us-ascii?Q?U/BrgHpnrYmMceM4/sVSejzA0BEzK1BKe7OrZMxR/MTz+JkqAS8kKb4dFGVC?=
 =?us-ascii?Q?vq7JYsDB7Mg4Hit7RUhMc2zj4tb9xyF833clWH8dv8TswlQu5li9kstlcz5O?=
 =?us-ascii?Q?08nXEXvKEu0hVwKLQMIFjK6uhjs1iJFZqdDvCfrI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01aa6d95-1799-412b-8f41-08dc2670ac40
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:34:14.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wifWBDBfQryWkLu+yVgqWHDe4hdQ7fAGdhzt8vrydTb6eq80YrkPTa6KgEQYHFwl6Ogevfj3ipi/4GcKC0JH/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

Add drvdata::ltssm_off and drvdata::ltssm_mask to simple
imx6_pcie_ltssm_enable(disable)() logic.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - Add Manivannan Sadhasivam's review tag
    Change from v1 to v7
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++---------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a1653b58051b7..8c816ff159115 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -76,6 +76,8 @@ struct imx6_pcie_drvdata {
 	const char *gpr;
 	const char * const *clk_names;
 	const u32 clks_cnt;
+	const u32 ltssm_off;
+	const u32 ltssm_mask;
 };
 
 struct imx6_pcie {
@@ -775,18 +777,11 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6Q:
-	case IMX6SX:
-	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_PCIE_CTL_2,
-				   IMX6Q_GPR12_PCIE_CTL_2);
-		break;
-	default:
-		break;
-	}
+	if (drvdata->ltssm_mask)
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
+				   drvdata->ltssm_mask);
 
 	reset_control_deassert(imx6_pcie->apps_reset);
 }
@@ -794,17 +789,11 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 static void imx6_pcie_ltssm_disable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6Q:
-	case IMX6SX:
-	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_PCIE_CTL_2, 0);
-		break;
-	default:
-		break;
-	}
+	if (drvdata->ltssm_mask)
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off,
+				   drvdata->ltssm_mask, 0);
 
 	reset_control_assert(imx6_pcie->apps_reset);
 }
@@ -1392,6 +1381,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6q_clks,
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1401,6 +1392,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6sx_clks,
 		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1411,6 +1404,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6q_clks,
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.34.1


