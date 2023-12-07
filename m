Return-Path: <linux-pci+bounces-629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2693180917D
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 20:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6DA1C2093C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 19:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FA44F88E;
	Thu,  7 Dec 2023 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sb2tVrUT"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2057.outbound.protection.outlook.com [40.107.104.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5841708;
	Thu,  7 Dec 2023 11:35:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRQ0brQVFuS/GcEa+SVzDj5az/NQehAwqVtQZUjH9g1oKfCZbNeAfIiGcOQP9aIdk0dPb3mDq5ShEanEhG1pVaowsA+HiCPslCW/gKnC/WZ5b8z7fQmqRhMjha1hmKwm0XXt2rXKJlyePSmF67NeeNE1nLyH8jJmENymazVDpP0dAlr1txojhYbUJrRz0qH8VReCChtX7ZIsQS6kw/efTWorEUxI5GTHPRB/cC4yeAK0SyBlIL1dt95Dp3MGqWnmbvHW+WP8iOA7ZDTaWKQGjhk4LP5pV4R44fnPsK52h2PF6/Jr8OCjBr17MoLmk3pZfuopr9pT5nhfTC5+BE1cow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XARXGLgZ6aVhHDWK19/XaNahMdf+FyADYmEydfD1Mgs=;
 b=UO1MSWzfL3szbOo1N6mFgtF3H/kfDa8LJi24bS1Ej/9iPb3pX59SyH/h76hNXw8dTHpeU1aerl5xyGkzBFDvIKIcHxPo40I6rVp+0Ik1SW9x0CSnb3PUVgMZE6iiduPLy9arRfVHKBhMRQfEyFcvQex09GOfVQLZ+9mR6RYgVtWlq7fMgzWmhghZ+fXYLp1QJGRlb0NOuSdK6A/RHTwUjDYkXRkHXsfh3R7QURJPbPGfVVTVDGVkOn4UEZJNar4muxXTSAo0QsNS4h3QQZ2RK6DB+9o2EqVQYs53sLXFv60Av/LeVRUWdlGfqObTpLgXh/sYzZi6+/iT1ybEoF/2vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XARXGLgZ6aVhHDWK19/XaNahMdf+FyADYmEydfD1Mgs=;
 b=sb2tVrUThMvBbX/xRuhhpFqJSXOc9grC0wo0D5v/A7tvOKCcl7+qwkA7PkToEIxFxgthxfZ3SS0nw4GZfDQTuyTuRrma+q8ikr+LxJpDhbYmExAyBJB+OSW/xvxr68h7AMWYM6mWjF80jfjCaGB42O/qCE0WHI9b71TdEOXB+6U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:35:16 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 19:35:16 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org,
	manivannan.sadhasivam@linaro.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
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
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v2 5/9] PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
Date: Thu,  7 Dec 2023 14:34:26 -0500
Message-Id: <20231207193430.431994-6-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207193430.431994-1-Frank.Li@nxp.com>
References: <20231207193430.431994-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f8da61-a6d9-40b2-2593-08dbf75ba3c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JbnhgXCI9EvM13AK3kWeSHckIJn4bme8SY+jim1UXz7QcMhZnKtzujSyD1B1ItToDv8Wxtv561CT8UO3FLQM2bEVLxv9yEkY2ZQYertqZPUT9EqUXlWVYjGsBYD5SsUdKDE5U3HZriOeZe0S6t8U870xniuZgmt2oP0jw8R2Gm3+T9mpkFvzFrBeolQF5l9rHzNZLwx4bEP9momHRNaEmQTXa3l9cQG7BNMCe2/7PPFIiKVzbeG8gN2wc5kRQsX+m1rcCGGogoH+hJOWLxhxk3PzL+9+eFKbwQH75uYbOgaxOLLiH0H+/Zj4/Wsf9Xr2L2RS3PrVqODTRv0BQ4A70iRM5AZxhV4mlmQ8+p+oj8eJ7bKLnKI0U9JcGJaqvheBksWvv8wswhM7twrEdrcArl29SElkAHj+Uw6pd+aX3W+EnprzflVPYaQYV+IWBaFBuhc9KGD1YZjlxm/9PVvJRzdMF0bj2FA8GE1p66uQCr3SQakQlHsLrPqPG5aUyZTJY6qrae10SMW1OSTb0Fp+auGPIHBOZkRiO9T9cVnUmsv46gqvciEFyARttM04Bqx4GTEZsTO2WfEx96aR74J++zfeFcJdWsKslHcDXfd4AtMZilCxqvzJMky/B4tAGbNx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(52116002)(6512007)(38100700002)(66556008)(66476007)(66946007)(316002)(6666004)(6486002)(1076003)(2616005)(26005)(6506007)(83380400001)(478600001)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(86362001)(41300700001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JwyJNOGGzvB/LzzxM3Ro9Gc8jk+p8mA6XEdJDo89ZxznOyUSfqMD13xx7X+J?=
 =?us-ascii?Q?0pXoPYacLhhAHqXlzy3wpa9czPyFjHDShxcrUC1vApyySLz10t8bnBretNrw?=
 =?us-ascii?Q?8izmUc8jJ/MHLEaGRj6VwErOAeyf/VWKbM/SzNASHH/F7kb+t81ooPdcbLIK?=
 =?us-ascii?Q?UdgLElrtzLylg437AyXikoFvroof4s2U7lKFor0YPFUWQCcv8dx/9UAWoJiW?=
 =?us-ascii?Q?42TZ0kX1GimE4B5wh+n1f93lz8Be3Bb5jZUY1QOO6sMgOxLY6DN3Rq6qLF0w?=
 =?us-ascii?Q?vV5CiDZ5fvxE1QmWtOS9u2Li//+/ODJkO2TFr3QRso+5sVvc6DFF3ZEEUtYr?=
 =?us-ascii?Q?3ZcBoCCwhC08DwHnAmxIjt7nMjuKQ1bEJ8lTA5p8tSoKr3arj6r+KJhbFjL6?=
 =?us-ascii?Q?X5QcLVrafcrWUsy83syJhQG0zkpzsSyHMZ0qJevGr9Xb0YPfDDXfUx5aCyEn?=
 =?us-ascii?Q?YaBNwrFdz0wYNbtE2mLzsOOXliuYB8SGZvq2qYZISZxcMagADN91kNG5F9fN?=
 =?us-ascii?Q?OOyYHTagCfW2ntbMf5/TweKFYYwoqgvIwdGnZQ1jJsqr3DH3vW1AU/Om/M6v?=
 =?us-ascii?Q?VeiO/3tzUalL8VHhQmZJIyHuFi0C7h7lvndn7YXWQ9etmsy0/AmLMGZLjpK7?=
 =?us-ascii?Q?ywAzffzknaVfPKypQeBsfO6is2BPYZdX1AXZdwa6UzszFvJjwJJ47nFqZQPb?=
 =?us-ascii?Q?jqZYdPGwxlRN2Mur/yit6n6jhO8/CDNofDZ/tYIRwjIK0b8gJBC0zgRgpBaD?=
 =?us-ascii?Q?e3j3kt4ObvBVik3PWAQSIHMu5c1bNRCE+/5bYj1M458Psx9vix29QfpQZIuc?=
 =?us-ascii?Q?abexhi2iwoXz7NxuNmBJDc3xW1GjZpYd41fswX5SnebLbGNxjc9E4vxj47Oh?=
 =?us-ascii?Q?nV6z0k4aRAbvl8tBi8ScUXsUPiKjv96MpbRQmFVeBg9MrHcHwtSnOeHywg9B?=
 =?us-ascii?Q?q3SoGnevBDfEs1crckCK6bnV+ycFsqYqKJt6Vd/GE/tZ65x1Du/k9jHqJYF6?=
 =?us-ascii?Q?j26rfGql0u7oVTxEdIVcUhYVH6dEA+mYSWE845599hKeugRhLVicKBs670Nd?=
 =?us-ascii?Q?2VsvCaM/+Nr5AiMER5ux8+4EpKkDZLXJsom0MKv0882PeGexwAfjSbBw5IvO?=
 =?us-ascii?Q?YmXkX7gGV0PWg7jT0IVVVhBDXoR0hELkZ/O4GqYyznr81LxQwBhc2ThD3nV8?=
 =?us-ascii?Q?AHic/zg66f0y0XJaxVV3aTOXGt22wavMT0GRrI4OoU1WWVWlJ86eYqJ+VS5N?=
 =?us-ascii?Q?Jk7IOrcC8SObENCsQO4WLsgY4kFOWjcrqsSdOPA/4G+tXsGvk1wg2V4sTfA0?=
 =?us-ascii?Q?1CUTRIspaNWMgIZHTmbG+cZGp24jeLfaMmwMfm37r8sczejTsbZXFVKhQFyy?=
 =?us-ascii?Q?ohCZ7us0CdQANqTrLjTLj/DHnUz85SN/8d/7zz5PKpvpDdi4rfHpFrtCtw07?=
 =?us-ascii?Q?6ZwghrvGeb61wGLGav+kJBTb65k1SoCy/3lF7okcvzpCaK+hXM1HuOTwazDh?=
 =?us-ascii?Q?s6XRNBvmzK/AxMQB6pcOPPA00c5mErJJvMBeHoiPx3HWVQ3bzxHlaksHcd/1?=
 =?us-ascii?Q?LH/zCnzZiWeg1jqQ+Bw=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f8da61-a6d9-40b2-2593-08dbf75ba3c8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:35:16.6602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyA1qa29jbC1+0rVj3bjt7qb6I18iy61gnQx1vvVWUFJ/hP3AKEJYurgvMfcDifP0VPqYx8wyf/YduPsiyNEFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

Add drvdata::ltssm_off and drvdata::ltssm_mask to simple
imx6_pcie_ltssm_enable(disable)() logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++---------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 548034151ee1a..5bfb780e441fd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -75,6 +75,8 @@ struct imx6_pcie_drvdata {
 	u32 flags;
 	int dbi_length;
 	const char *gpr;
+	const u32 ltssm_off;
+	const u32 ltssm_mask;
 };
 
 struct imx6_pcie {
@@ -811,18 +813,11 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
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
@@ -830,17 +825,11 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
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
@@ -1446,6 +1435,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1454,6 +1445,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
 			 IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1462,6 +1455,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.34.1


