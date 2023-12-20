Return-Path: <linux-pci+bounces-1233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750A81A823
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFB81C21C1F
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD91948CF4;
	Wed, 20 Dec 2023 21:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="abIzieNZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7741495EB;
	Wed, 20 Dec 2023 21:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KT+peuwJBVoJkdLR0/YeHyhLXSdlseHbLlJOqPygT2L7zK0X8cjf0AA8SWelcc+UJCKCotlE72iO2ZnNwb43VIJcW4QkGofJ1J4GWTRX0ycRkkP8BjH6Xe2qyumZ4TyboiBcGuPF6/ppANnqW+5fTDgmxEUQ3cq0kkRZJfEKUQIlqoUk7vNCj5Sn6wYlWVdyl/wL6skBFp3jH/QDzGKzScgO4+Vm8NApwA+FLhVn4ajaNvT63CZ8HVXFAauUbGwcIFUo7FVYXA6lZYXnSvwfWEXIT+BAZHmwe8t2qp1fxf2udeNFF3BmJowHgRfJMDGDA2/1NsjKdtXakr8GDnX3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LAXOsM+n+ieruYA80YmPJNWaLohdzjp04MJ2htd6vM=;
 b=GdVcYppU4ZgZ8oK8funL8g23bntFSefkTw+UfOcGLMkM14cUUafxwO/7+ztHqS7utNzH5CpRjk5AlbwD5TTmVRzx2YcwshsvmO9S7d8q0m+Uy1+CAHPrTfF/2nyIr2I+OeOZFnWHHBuP64X45x5v0nt4rBzmF2airGcHiLFhNy/s1cZVac+BndZY0bVAp6OPfSIp9zG38hbuStfUdCHAs2RZuk6DZJb+5FjcX8Z1+AnFc7rWXdwjdKR4UJ5zhK1gyrXsO4Ey8gFm8r9kfUCuilQVQAYFvOLlNrcM/QBYGGqPvepVjKgz24sLdZFXzSjH5oOyae/TNzrlD38VWgSdBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LAXOsM+n+ieruYA80YmPJNWaLohdzjp04MJ2htd6vM=;
 b=abIzieNZ9ggYrYNbZOJGOl80zVwxZd0mXx32cGjYBa5+KMMqkigw+fbD6IMgfDNoqIP0tZs4IU+LymY35k4TzjLMAMXRVNsVsoXTLncwtsT0ehQHrs4lbmE622kv/tZwz6VMvHQQJDp0bv8nVtWK/eUJJt0BuWVOk8XKpdI6MJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:36:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:36:48 +0000
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
Subject: [PATCH v5 01/16] PCI: imx6: Simplify clock handling by using bulk_clk_*() function
Date: Wed, 20 Dec 2023 16:36:00 -0500
Message-Id: <20231220213615.1561528-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 786af379-aa54-4fe7-ebef-08dc01a3c531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2iH5uJ7hRlK0TT7aPlpc1stvHUoSSUWxbEqaQau/3CN8LAew0fEH7nk14fCiGGm5dEnKTrUisZ99Yb6BTPLmxAOLBggy5rOw6+9jMxLtEMhO/KW/x99spVTtgC8wd44k0dMY8Ygx2BJplELDHQP/IfGk0a+a4EnKzP6dsEHbspamCTofFnBO7XcPFCQOe0vd0ac7da0E8O7n6hC/J9WEct3rP1wzMY5Pw93olAEvKlrgV6jbD98zseCIM210qWjQTeqQ1p/xRZcpN4bxpQOZ91zrhhLEtmzNibwFJwZ9VTcwAsuBzjjAY+8/Z+eTNLVeir/6iHL0fJhTYs2fF5kUcEje55VZSJQG/cTbD6V1ziMHJl9rNzY8iS9WsKeEoPOmsUvYCC+ziW9QdzkIAYYxgCFruDKvR5uhYdhi79v2HZjh/R/jdcAD4mw27+VXeqVpeRgUZ95GhNTJaSPXSTD6cHhP0iH4+sViNAmr5BFrLa3M73Eqn75WZw/uXH6XTErdOqCLeVJ2dFjub9EsBgSvBDQcnI+hfhkzSt0qZpMvUnOUuvkxCAmWy3lRrejKrtQxMLha32uChkx6GNEte9CwrNk9oGT1zvsDnKjo27ZeUgabjRA9Ck8mRAOewtfERIed
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7cRr2S4DIwqQHCpPYNNH/YGiqpl4sQULi8wN/pMevvg3wvnQ38p6jemJxjsu?=
 =?us-ascii?Q?Yus8vOPg2x7lIb53FtPk1hQbKXnSKnvXGF4DQFSMOj66V7lwSc9vo+CGOBDv?=
 =?us-ascii?Q?j4jLVbT017JN6bQQbqvKKj4fLr2wG0kfyI0Ztp+N28DemhS1x3uG7Y9Mjkcj?=
 =?us-ascii?Q?anh8vYhiEp/m80sy89OxEtzSb8aPPBTV9+u0XYcDITMyvsAsSwrdYv53QNS+?=
 =?us-ascii?Q?ms+P3Ra+r9o4loey9/baS/D5SydNMbNJywuj/9EkOiEoXUF+jUJlX9wRFuVr?=
 =?us-ascii?Q?Lr/24n7ml+AQAfZgDjhf5tFV2GLjournaEywrZfG03THPI7vWvXDRCkGGOrI?=
 =?us-ascii?Q?GeHSl2sqetdGhx4Pe/vnVAh5S33pFRkiqOZnQtbxkxBb1UYIi9hw83lifdFt?=
 =?us-ascii?Q?36iAh6N02mpw56/Iudv506prsAZyX07odEPAxffCl/zN7fUCoF+xVLagBaz/?=
 =?us-ascii?Q?s7bkAARUBEtS50hkFOrLllcP9uzNs2zTaySDY3IPvg06dtl46Q7iWWdo+3W7?=
 =?us-ascii?Q?/BVDZVVkESUQBEmt3v+3WAJkY9r1neSSWSvD2RuuJePFnbGtrmYvgSB31Uuq?=
 =?us-ascii?Q?h1+VzTnjWzP7N5szlYdrGR9P1mpQbVA11q/E7euJlOU2wRPGiKoYr7bFs7xv?=
 =?us-ascii?Q?5PX4cZD8QwU8CHcuruXNQ6l6DEabqMiVWA0rhIYK/MTJNxSrBCvHLm/bFtMT?=
 =?us-ascii?Q?xrMt7Odm/fbZjqj1TibmSjqU+HEkmlvCJWHVDMBcKcfkPdg16r7KFvKUFkGw?=
 =?us-ascii?Q?6/+FcVh9eSc7d3hiFfDsXzb9e7ZTfFJbz5VngbZBoKa9T6UD5hA4cH8RIUaN?=
 =?us-ascii?Q?qQiEqu82qqp0lR9WDB6jM2a2lavCGU5An8rFpzdatqxQEfHCLlrn4bD6zwfu?=
 =?us-ascii?Q?aDQMK0Kdxbt8InQCA4UZSTR60Ozu3T8Txp8AjFyNHffR06rPJOGupG4L2ZPW?=
 =?us-ascii?Q?ckTfG8njwgvVU0Gmp80kyTFizEti5sRVggqR2wThYm2Vqr+8T3MC+/diKVFL?=
 =?us-ascii?Q?YrYLicRJyXYZcYapGArVyjwvkaguCcpiH1PgRIiAUPAD6s5opVbrCamkU0+K?=
 =?us-ascii?Q?xJn0R/PmYkvD5L6ixeXRwoYa7LtcFPcak+zh5+6II5v7oaqMBRBCKQ8aUdKz?=
 =?us-ascii?Q?bESRCCcaE10FJ75SfO+Mcq4ARZAGTHAOinSJ7x4D5EKHMQ8WGs9HgsrDM48D?=
 =?us-ascii?Q?8zfwUcJCTzsMSstKnTIIZqi99wYDnEGdgyZUnIH8+wJaqpd6yjoi1iGlZKY2?=
 =?us-ascii?Q?2FEFCoWCsvW3+3EbaKUAMB2k+aVsisXVYFlR6/kcQBRVJfR3TJrlHKi2o8/j?=
 =?us-ascii?Q?YPEOAv/XiEIePacOc6yBXf3eC5oN7W9iQ+afyoQMVDFl70iq4xhcOUxE85L4?=
 =?us-ascii?Q?YZATaOgviVzNdGE7C2O9khp3i6xBe3/iKmdWQSEiWk7yZC/Fnd6QkgoQTx37?=
 =?us-ascii?Q?Rn1/8pP0XmSqkKpRLWosuiQMnNfj2IUbT9W0kq924te4BZVvq82qTz/7Kc3P?=
 =?us-ascii?Q?YcSBMydkVQ9TSTkRtWyEByOl53zdnHudjwtVTMQUNmbklJAXd/NnGct7U+CW?=
 =?us-ascii?Q?QTCzPOXkhVUsy6FrVzY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786af379-aa54-4fe7-ebef-08dc01a3c531
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:36:48.2516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3yh6t7npPyxOL4j/vbKBMcw9BNqT1NPgq7S4a4R/258/pX82MCEweXBwJzk7wot6xWnnorssrl6dmPXaORDMBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

Refactors the clock handling logic. Adds clk_names[] define in drvdata.
Using clk_bulk*() api simplifies the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5
    - update commit message
    - direct using clk name list, instead of macro
    - still keep caculate clk list count because sizeof return pre allocated
    array size.
    
    Change from v3 to v4
    - using clk_bulk_*() API
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 125 ++++++++------------------
 1 file changed, 35 insertions(+), 90 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 74703362aeec7..50d9faaa17f71 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -61,12 +61,15 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 
+#define IMX6_PCIE_MAX_CLKS       6
+
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 flags;
 	int dbi_length;
 	const char *gpr;
+	const char *clk_names[IMX6_PCIE_MAX_CLKS];
 };
 
 struct imx6_pcie {
@@ -74,11 +77,8 @@ struct imx6_pcie {
 	int			reset_gpio;
 	bool			gpio_active_high;
 	bool			link_is_up;
-	struct clk		*pcie_bus;
-	struct clk		*pcie_phy;
-	struct clk		*pcie_inbound_axi;
-	struct clk		*pcie;
-	struct clk		*pcie_aux;
+	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
+	u32			clks_cnt;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -407,13 +407,18 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 
 static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 {
-	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
+	unsigned long phy_rate = 0;
 	int mult, div;
 	u16 val;
+	int i;
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_IMX6_PHY))
 		return 0;
 
+	for (i = 0; i < imx6_pcie->clks_cnt; i++)
+		if (strncmp(imx6_pcie->clks[i].id, "pcie_phy", 8) == 0)
+			phy_rate = clk_get_rate(imx6_pcie->clks[i].clk);
+
 	switch (phy_rate) {
 	case 125000000:
 		/*
@@ -550,19 +555,11 @@ static int imx6_pcie_attach_pd(struct device *dev)
 
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
-	struct device *dev = pci->dev;
 	unsigned int offset;
 	int ret = 0;
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
-		ret = clk_prepare_enable(imx6_pcie->pcie_inbound_axi);
-		if (ret) {
-			dev_err(dev, "unable to enable pcie_axi clock\n");
-			break;
-		}
-
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
@@ -589,12 +586,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
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
@@ -615,9 +606,6 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
 	switch (imx6_pcie->drvdata->variant) {
-	case IMX6SX:
-		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
-		break;
 	case IMX6QP:
 	case IMX6Q:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -631,14 +619,6 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
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
@@ -650,23 +630,9 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 	struct device *dev = pci->dev;
 	int ret;
 
-	ret = clk_prepare_enable(imx6_pcie->pcie_phy);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie_phy clock\n");
+	ret =  clk_bulk_prepare_enable(imx6_pcie->clks_cnt, imx6_pcie->clks);
+	if (ret)
 		return ret;
-	}
-
-	ret = clk_prepare_enable(imx6_pcie->pcie_bus);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie_bus clock\n");
-		goto err_pcie_bus;
-	}
-
-	ret = clk_prepare_enable(imx6_pcie->pcie);
-	if (ret) {
-		dev_err(dev, "unable to enable pcie clock\n");
-		goto err_pcie;
-	}
 
 	ret = imx6_pcie_enable_ref_clk(imx6_pcie);
 	if (ret) {
@@ -679,11 +645,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 	return 0;
 
 err_ref_clk:
-	clk_disable_unprepare(imx6_pcie->pcie);
-err_pcie:
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-err_pcie_bus:
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	clk_bulk_disable_unprepare(imx6_pcie->clks_cnt, imx6_pcie->clks);
 
 	return ret;
 }
@@ -691,9 +653,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
 	imx6_pcie_disable_ref_clk(imx6_pcie);
-	clk_disable_unprepare(imx6_pcie->pcie);
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	clk_bulk_disable_unprepare(imx6_pcie->clks_cnt, imx6_pcie->clks);
 }
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
@@ -1305,32 +1265,19 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return imx6_pcie->reset_gpio;
 	}
 
-	/* Fetch clocks */
-	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
-	if (IS_ERR(imx6_pcie->pcie_bus))
-		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
-				     "pcie_bus clock source missing or invalid\n");
+	while (imx6_pcie->drvdata->clk_names[imx6_pcie->clks_cnt]) {
+		int i = imx6_pcie->clks_cnt;
+
+		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
+		imx6_pcie->clks_cnt++;
+	}
 
-	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
-	if (IS_ERR(imx6_pcie->pcie))
-		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
-				     "pcie clock source missing or invalid\n");
+	/* Fetch clocks */
+	ret = devm_clk_bulk_get(dev, imx6_pcie->clks_cnt, imx6_pcie->clks);
+	if (ret)
+		return ret;
 
 	switch (imx6_pcie->drvdata->variant) {
-	case IMX6SX:
-		imx6_pcie->pcie_inbound_axi = devm_clk_get(dev,
-							   "pcie_inbound_axi");
-		if (IS_ERR(imx6_pcie->pcie_inbound_axi))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_inbound_axi),
-					     "pcie_inbound_axi clock missing or invalid\n");
-		break;
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
-		if (IS_ERR(imx6_pcie->pcie_aux))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
-					     "pcie_aux clock source missing or invalid\n");
-		fallthrough;
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
@@ -1353,10 +1300,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1372,14 +1315,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	default:
 		break;
 	}
-	/* Don't fetch the pcie_phy clock, if it has abstract PHY driver */
-	if (imx6_pcie->phy == NULL) {
-		imx6_pcie->pcie_phy = devm_clk_get(dev, "pcie_phy");
-		if (IS_ERR(imx6_pcie->pcie_phy))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_phy),
-					     "pcie_phy clock source missing or invalid\n");
-	}
-
 
 	/* Grab turnoff reset */
 	imx6_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
@@ -1477,6 +1412,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1484,6 +1420,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"},
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1492,40 +1429,48 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 };
 
-- 
2.34.1


