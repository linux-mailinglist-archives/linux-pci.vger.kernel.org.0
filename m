Return-Path: <linux-pci+bounces-625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A08809170
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 20:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58BD91C20992
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 19:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CED84F88D;
	Thu,  7 Dec 2023 19:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rANmVIP9"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2067.outbound.protection.outlook.com [40.107.104.67])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781A710EF;
	Thu,  7 Dec 2023 11:34:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vgozex5EmF8nrGBZqh8hRjS7IDgwzudBiORZNWYMXXu1lEoe8pvlsKMcsMk3EZLQqhytkp6JUAl6QI18C+fIY7CWpRTPsRQozfhaeNfPB2xM7AvAMTyYaI8ZWXhJ/Dd4VmQ6w3pUorYG8YXDNiyjTWm6XEjLR4t7xinExAqnf3txgBmTHXpP5GoO/aDIyn9zXXe4I3qFX2KUHyFYDReviMmn2vYiIvBHa1sldLYXByyIhqn86gIqMT1qcjs9zxWXyTTtOQE/Y+T1TlvKw33DyrAe5BaHMgHnoJLV5jnUzVe1CU9REBsqNZ/k6rIAmcU7IwKLwUDka3/GcMapsMSUvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DojZRXzpRZWfWnlDBAAcF49Bdzfvx2oxVLlW8/nmYCU=;
 b=lNMyZrdKrJtlpQs+pH4i9FCdJhDbduKsAugwNUEgxBbRzOvaIdHT4ZIg0s4EEQyAPTnRowhpVA8mKsyu2kjzZ77W+haIElAn1t8N2i4BH25Ty5Kz6Vxc5nCEzdM0mXEzl/s6LZMVxnEXaFwKVAXrooNBR5+giob+9bdSYZOc9mHvh7wbNIgMz14n84BdI16uZ2tk3fpH+UC446NnlSZ6/dk3a2tckK1G6qvjVSQOONfmz9UGNk18Cm6j8Lrw392Pt4ctEYYXfd0PgZVo9keXZtDonHuHTE1ZmBn/+tDwlxN7tS83+HIp/1NYiORiOt/hFGl/oG3j5xBltB3bJ5brww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DojZRXzpRZWfWnlDBAAcF49Bdzfvx2oxVLlW8/nmYCU=;
 b=rANmVIP9H9py4GgL+8JuHyTwvd3jcMhNprNv8Iken9M4MRx3Gb/XR2YI9TPAOkU0vfC5M3Ucs8RKaVTW0a1/4AWd96bzrrmcK5KnmwsdQZEy90A4SQc/IFhWp5K4Oh/o8PBfkvCBPuSdZqD1GrsW02+pkcIEWp/jknc3ocPv7fI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:34:55 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 19:34:55 +0000
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
Subject: [PATCH v2 1/9] PCI: imx6: Simplify clock handling by using HAS_CLK_* bitmask
Date: Thu,  7 Dec 2023 14:34:22 -0500
Message-Id: <20231207193430.431994-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a7555e79-986e-43bd-0a8c-08dbf75b975e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8BVnX6C6eM6NkWa/rUZLtnRd8QqceJMkeSfasMUSH0hjJv2zYI95kNSLT9KqMECYxszD8OY9azKpc41J/6aNtSmQuM2acbVT2Y8YYGW+CU0M0qRyVUc/3EDD869lCa6zSKHXySiOEZcrNcpwTFCZcvLbzZiEOYjM1cgJC0PgYgXj7K2FW3DiMlYU2INe2pC/jIpGEGJnHgrHgmfdhX/256jziszaWzfaaSBo9UXrbgWGWAvM7PmoT2JbnC0G2O1dxGKh0rkxozKuMvs4fXub1pseSRpUgEnSoNR9zgbKyHWdtMI9809IFpnTcJIvaT4HtwVtGgzSSjQoZbthrunXuyo3Tup5uWi9JqXLZPwEF+kK+eafhJYAeA4t6gBhGZd7g0ST5rFTg9W3Cw0/YWsz47JoDlnr6fakt3jSDbBSl1rRiRuegc7pzg1jrK1AHpxueACmkE0GTA0unlBMdY3XzqFKSY22SXQ4pe2bmHTVrScMCyvuaOU31MXZRtviZmrwA9CcLtmRYWCoZlOqkt1tyEpN6rrc/FaAEPqpMSNOd4LlEYamQNbPmyRLb/D0tzIWR0/5wrJkjBWHSBq79QsfQhuymj94GChQgdSP/kEdkoPMx18Hl8z+spuNvbgPaRit
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(52116002)(6512007)(38100700002)(66556008)(66476007)(66946007)(316002)(6666004)(6486002)(1076003)(2616005)(26005)(6506007)(83380400001)(478600001)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(86362001)(41300700001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9L/wq+bDUWsjJxUZ0ICG8dhLZoDBA9+h+Kcz2ZPSUMfrRC5ouj4RHPEUyEqn?=
 =?us-ascii?Q?GYe9PYFnVHnO4nS+wdU+rqrEUMV2uXTUvtIE/orJmRkEMddzRrGD6nQNpLp3?=
 =?us-ascii?Q?+1VaJ/dWqYssPzRP8D8InnjAIGRvJBhXmxbX9DAZwexa6l3L46ByBbUelN65?=
 =?us-ascii?Q?jzhlPo6x0h4EC7pjbncoilVfDBrlsuCYZmNd9t3KLJ6DFv92ZDeIX6u8X9Gd?=
 =?us-ascii?Q?+hIgwRB9GTgeZVVvFpcrwSdG3GcR2k68afeeUlnQj/2yMqwxnPkXFBGrPhz6?=
 =?us-ascii?Q?zTP54Wite2yv+2YSBhJ2wQoIlXPT/MqNfBDdvHNlFRLbIpgghfscZe3/YU0w?=
 =?us-ascii?Q?mFD7e+w/L88uhA54jRsKn2tbzz6x/ruPfWgJs7c14z11ryE4H+qWyOZrKZDm?=
 =?us-ascii?Q?/GlijOqeWoycgVZHjk1uuten4wZE2YcNVzPj5ni2f0g3YOkDsPkwx3lo+otX?=
 =?us-ascii?Q?YUabbe1p9AX4p3XXipcAqg/hmitiM2r6z6G+Sz5LqLwRaTWGmgOwBQD98YpR?=
 =?us-ascii?Q?9SrbQ+Z7nbUX4i3HPjHJa9bgj+nGdauE6XEl6fuAGC5sXMA2SY0cD454HZml?=
 =?us-ascii?Q?wycZaRelasbTuyS++TW8mQp5J/68PdFgp/Yg/TaGgRLeRlswQsWty+oE8GXx?=
 =?us-ascii?Q?f3Sowcl6l91UHSKDOejwan2Mc9bmM3Nl3IojIzWSNf8JKpmfGmxb5c+BNf5R?=
 =?us-ascii?Q?aOy4rq1sz0l0AbujHWKYFtTMCbPCtBKizM+8SK6232c7gd+e2A+N4NpmJpoy?=
 =?us-ascii?Q?qO+EN0mFP+Iuo1BqYYoXt9Xp+qhuUF+cNpL50xNr7y9+GQ2LGECHXY9vIlld?=
 =?us-ascii?Q?Yybc8rrCFfeIWDqMoOMKqi7VcLHsBsMe9KI9Rsh5bthFLJZeYgQ8UmIB+u5T?=
 =?us-ascii?Q?6yawh+ZGEBzraxJHFYfiBW4ofAjoSOOXiO4pjL6c29CplKIxCa8XBpDOMeAD?=
 =?us-ascii?Q?9P7JF8NE3CMGIWzAvoJXIWP4XyDW/tHy/VY6kwe9idfqdhsXlnTpItBFkD2S?=
 =?us-ascii?Q?7DLsMwZsrio5blhMJHfqsOQK5WYmWz40eV6XbG2nfRrZ9NN3AxH/EzMJWlVg?=
 =?us-ascii?Q?oMSw0lZZtUbW78It/l5rIVafddx9CvFMMCSSv3dXtBM//bcShmFLEixoTFfu?=
 =?us-ascii?Q?8jEWxZ4PhqBkc8P9laiM4mZQVBglOiM8cTPqgqleZTAAhxFiuPtLojDHrBgV?=
 =?us-ascii?Q?n+qlttgLkHVWygvCeue5GiTnoV5M20RwhZrsXzquLQevWizsO16jcAawnkJk?=
 =?us-ascii?Q?zQqW7dFWVLHx3nMvbnhhxrnEir0EB4exVznbXEnpVW4q8M//70Kt0GCZW/t5?=
 =?us-ascii?Q?2jNBQkFzITpGH5KvBAa1lI2feQtswRzdOfnelmtfu3SdCBg+AviqzHphTvmH?=
 =?us-ascii?Q?l4E9bwT1jTyy9XIF32U5lcI5Z2D6xplbFpvPqUVWJAhKCpCuRlJyApbrjAZR?=
 =?us-ascii?Q?GbkkZ0sBEXvXqHBNK4iI8eXhx9Cqxr2OkhH3U8qwpzUImSdIsVnJXLSCDPOv?=
 =?us-ascii?Q?zOpOgaxcmSygz9u2P3f23TEA7LBq2AWBx1kkzNdvl2+ohz/bfy9qU9ZW6Zoz?=
 =?us-ascii?Q?Ogico7Z/YCrUpsUf8dM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7555e79-986e-43bd-0a8c-08dbf75b975e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:34:55.8291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I60skOHlFAz/6xk0PcXx1eixaze695IF22+r3zcIQDGJJ+EUTlYp20NMVHxSCUol0qx7G8voiuT5ZjS1IznkkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

Refactors the clock handling logic in the imx6 PCI driver by adding
HAS_CLK_* bitmask define for drvdata::flags . Simplifies the code and makes
it more maintainable, as future additions of SOC support will only require
straightforward changes. The drvdata::flags and a bitmask ensures a cleaner
and more scalable switch-case structure for handling clocks.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
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


