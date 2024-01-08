Return-Path: <linux-pci+bounces-1844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B34827B72
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:24:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20DF11F23D39
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5B15675B;
	Mon,  8 Jan 2024 23:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oqIIBBsD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42BE5732B;
	Mon,  8 Jan 2024 23:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltnhsRaY2dnTi/y2abv69gjpdzVpoDIDsZm/2uK7L4TgBA6urg3kC8ul6P8/QCG3p18ctcN2M9IfhM0zIu3r+6Ty2FIMkmqP3IEbtJdx8s8tQ7nLXeWMBtn3CTmhelFT0tuXZvpC4pbYkyCF1EsKUKfFqVF+v6lSo5cGeB/WmXFoWtZiTNTd6Rv7m71NN0Hf0FI3ahscyBRInMw2oRIXSpJD/1IVSl+yptFDZMJStPmeinD8EtPs8CaefSBo+2IRN3SP0ZcgwwBQXNr0ARKSThf+cg5182DVAxndtujrdoQ1xCBD/a3pvMnHuuwX5sdgQuc95BlwuYOllKxF45qYSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsvNnu8SlEkTdDeClAfZIHbuLoehsz9bDSDrPJk5scU=;
 b=A/TgQb8CmuJR3jsOg7QwKEwkDgDQo1hJewVoPtq8i/a3HSw2TRDRI61kGbnFoJsul8PbwEdNKt+rlRgRsyprsPsn4H47U/Xt/mvJM9HUuXSgXXrjbbpeKJPVaK+tRX7E9M824LnC8qvuotOk1e8F6hYCjx6BDXaf2Gdj2MbLAwIv5QFey2xztpPvUBOXiY9r36jDPi2t1ZZzkSG3bfJPFZ37zeApQ876WNzze5XPB0350wVDaRFQ1FnRMvzQCkTrMsk4sO2y6/hbiLnR/PVVPU2vHL074vNKVndLmUF1OiFJJ6bD9766z3JoFqgeevA25lCgYymHlLLszdc0eK07Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsvNnu8SlEkTdDeClAfZIHbuLoehsz9bDSDrPJk5scU=;
 b=oqIIBBsDSYiPc2jwzA8h3ZwqeOFsHov/EnG5wuSb+mpdmJIPcm9VJ2cuZOI3p8Klu8tUpCJs3hmxievF0NF0IM5Z2tOwPSPkqc9r/41oMOglyBH+ICc+IT9nLhL+pZfgwuLIormMKXLa0yK1e6h6VyzIFsnYD342Q7U3Tpd+Fjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:22:39 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:22:39 +0000
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
Subject: [PATCH v8 06/16] PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
Date: Mon,  8 Jan 2024 18:21:35 -0500
Message-Id: <20240108232145.2116455-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 11a4b0db-a1d9-4905-515e-08dc10a0b48b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8yIvxKu+dGd0lJ+C80MYCakjw9kPZNYk8jBmINOhtBTu+bYz32Hstg3YIeUgnodZ9D6O8Na+knszqRtODUERBXFb8eZN6azHOOMLdLl5NWFU0jxwah1FODoZpUK7NCwFMIqZsRS9UBRn9F8cfUtkLlFfkMjKRgfibDAhS/DHrVsvqcm0APggYFzGtqJDzhTM15knKIiSY6AAZstppSabqqJ81u2Bgi5eQ35EEN+6eYsR6rVC+8/2xD+LVHijo2jHlh0H+udmMnPnYt1+m7jUiuALbBSQ4kUkMMbOWD+hICZygFAIm9To7fJTwxn9QSxrWg0I0XZhfscMsksAmU9hpz36YiJT5I8lQLH3gQXyfExHxkkCE0wJefm85sWcyGzMHbp/70JAuJD4vpYQRUFJaDeSRZbQZvL6x/7TNnjNloTYUg3sHn+i6vi5hV00PI8wnKKACLHtKkJfPv9EaKNCxe5rwqdcUlxN+Zg3MNHSPYNUKVEEYRIWQic9UcYdhdqPOWc3H0pdH3FKgfs36VI0T1VabxJeGZf/lSjRCDBuXSGJAJaTP2v4SVm5/J2aSzxfO2I85+Y75fuyxST1KtE6l2iroUQuMQk3NoeU1sZd9UsV+GKwm2XGRxwpQxeAuw7h
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mTycPkRSzcD2EW8h9Eku25Bbid34XHuowzGQ1wRAD1hAWiHq831BnUP/Ksmj?=
 =?us-ascii?Q?wtaKMVk3DUVSZKlBODvFqK0NdF+Rug8z7zHcusW77aAkQjHG/KBSWS84aXY7?=
 =?us-ascii?Q?WL01IobtDTXHzHKLD6L2ZDXQ7PCAOpP3tkepWCgN+xWBa7lOMBboYa5dqiRT?=
 =?us-ascii?Q?LjRG54fOVU+AL8+VSF2q9AwWMQd4c7v32FbL/vBSdDVUU0JYi+M0KvNFb0GB?=
 =?us-ascii?Q?LI8ErNpbOLJvORlq3G5yOtN74VhodlA9fFkiOT+lwzLIjqJdXJ+YML5Dek9y?=
 =?us-ascii?Q?1ejXeehrr9t4mDGNHYpBzdfkU1U3ECKQgO+nsA0QO9bMq6wu1/J/EIwuhdIu?=
 =?us-ascii?Q?PuxKye3PuUDQk2kPYE2iRm2YhC6Jv/UMT8m/RweLttCDht2CfgestYS9tPcc?=
 =?us-ascii?Q?qqyhKLEZMr/CdMkYEoBf8QKQO/2d9RJzjfVemr8OPtH2qV34OsAsEZso8o2m?=
 =?us-ascii?Q?0WKUEqUbgcErYrskhhhI7mn3HcfN7LsKF0GexXwYeZEaoITybhVX75eOByjM?=
 =?us-ascii?Q?RHevLQGH4n+SWIqWE4Bgc65ZBf597botGkG56qDIXtMBtkEgAdjwf2VcIYma?=
 =?us-ascii?Q?YswTq2Eq7xCgcBR/7x3ztSRU2DSYIEpkM7vdAawwzceKZD9R0g1jRcMP/3t8?=
 =?us-ascii?Q?AirbABQRRNuyqLeJqxq68CLdQ8jd1sgWPsOvsXQEIfphXb2m5YdKQWVBJjvT?=
 =?us-ascii?Q?2P0GyjKOnpjx6jZzjwHIbbPS8Oc8Qrwr/mjV9drxGf79KlwkeMSUNTWzdauB?=
 =?us-ascii?Q?S3hXv46HH/d4W40oXMoV08j2e3SCBwq0BQKi6uvlwvWMoG6aSdpdRaOqeljC?=
 =?us-ascii?Q?XaQu+k4SSncrVb03acShIO5Oo2NmDl5CEYbFcPD7l9q1Zbxy2v2ABQQh2Sfi?=
 =?us-ascii?Q?wsnt7Smai+vSa4+vOhtRRcaXcLpBNLixmJUhsUsMxJJlbC+e8T9ndXwjNF3c?=
 =?us-ascii?Q?1uImMqyZQjI45O9dxQMxo1/AxwF2FWfg9Uqm/WByb3I5KdbTpoScAHbJbibq?=
 =?us-ascii?Q?DPzEQyxPqqX8MofzQqB+D5n/EPZFbvxvZcxLW70kWbpoPw3rCdiNxMsXSlos?=
 =?us-ascii?Q?ZpdI23Q+OgcWdkEQwleN/eoRz6xF+llQsm4o53/CaXIOpkwrM1P05GFUj0Fi?=
 =?us-ascii?Q?UcN3tlpzZovcX1dydNDOkyPmZx4iCCFKLrLeBbchpzvofseMODPhwNHDrzyR?=
 =?us-ascii?Q?KbZd1UWuqPa3MAw2Tksk5ZvxftFB57PTWwdjLH7X5Hnkw/U/9Rrvon9PyROi?=
 =?us-ascii?Q?MCbn8BrxXNOO5J1ZJVa/zVZ4ev17kZ65pNbPJa6DP8MRHhtw4s0B7UOnc2sk?=
 =?us-ascii?Q?9uZKXkpx3dTAi59gKnsNHLu83QxKVmKUiNsFH3SE2mcS2HQkHG8aqL7r0zqA?=
 =?us-ascii?Q?eTtp1/v0Fb5XTJMpbfotHEwmSU+E9chl8coz6qDM/bBBfHvnnFdn3gLowdSi?=
 =?us-ascii?Q?lUA8Ij4su8U8BcQdDwJ/3dbvwUSolKC5VBRiPAPghsAmY5Efg4FC7b2yY0gV?=
 =?us-ascii?Q?4Mj/j4NTl+EXn+Or5a1ZapuM7dr3b7E01FQOKxY+z47ptJW9giMVrpq5u8cF?=
 =?us-ascii?Q?kWRt2Q1eBXfg0lWZdqoL3ftjgGDRrX4p2JFgYY/S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a4b0db-a1d9-4905-515e-08dc10a0b48b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:22:39.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brh+GJl0Hp1MJgcL+3IWGdmxuXuwWYmBhoIEHYCK9/zjPIGnJKP/AE/s/By3C5jf4EtKqRe+zAe9SNt5yvbMuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

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
index 06aa40a185283..818e73157e724 100644
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
@@ -1398,6 +1387,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_phy,
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1407,6 +1398,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6_4clks_bus_pcie_phy_axi,
 		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_axi),
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1417,6 +1410,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_phy,
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.34.1


