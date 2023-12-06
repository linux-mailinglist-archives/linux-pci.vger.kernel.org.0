Return-Path: <linux-pci+bounces-577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAE1807440
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4A51C20B22
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 15:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B154345C09;
	Wed,  6 Dec 2023 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rT0lRgEC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DEDDC;
	Wed,  6 Dec 2023 07:59:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyCd5O3wAjdULY9wTEVcbw9Y+LWr6Lgyfc6bOV+vjE5tHe2PBf3YxFJGvYEXu89BDi8dY58zvtQVkjMkeTAC08EnTWeWr71YhZuJcw+PkrfkT/OidfaDsKBjehOzLmh4+j90ZBNR02qzNELcz39aktWzhUZ7HZ7N9BuflWcltlQdcK7FQd8rIcgEZdmW3TbXAcfWLEHLxyi1kt190IOKlmr+2lKyoWWZF3zMsp/ZSlH5Ra8vwQz6pF5kSB/gHCNjyXoHOOuHbzQn4cqxfN2Kl+k+E52tb2gEUKi60OluGcfQ9fi1D1aFbpp85x7vfcaClbWk3WwY+st23alLwqZ8ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yl+P2vynjICwTZ9VPekPVgFlODQdtDC6Cz80GXK7NrI=;
 b=ajlNU/Y1Oh+C+6Iz/vPCo8NMdFwyqrcwMUR1N1GOl7iZMK503h6xP7JzRJW4jD+XT2PC89kJ8PPGCEuIX2k2uACb+x9Z1Iq7bqWY83dulwyDv2IqZLhPxS7P1x2MwSz2G/81AV8j83N8qb31WwodNRmix1jqRF3F+7ooI9STT//nb6fZubYNYQqKuiWE2HSU4PpaCLgC9ApCf9pT6O26ngGGDRJ2eJB/Apuz92OmVStY0MB34Gp6+ABf0NXcPRIYg4EG/mLq74fA/Jzwy6cPfURzHlWkKzHyHym4HdZ4mBaJUHWfd+8mthg+PQXCK2ztRVxua2UxQkCdcyOgXozv1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yl+P2vynjICwTZ9VPekPVgFlODQdtDC6Cz80GXK7NrI=;
 b=rT0lRgECIveSrMlwvarTlPBqZq4NaKV2rpIpDZxYBbpozLPuQ26eQLULxhZ3DwzfDyJkI9IQtZed+7tfe/K/LgGzCdLVH+3AuD8zJ2pEpyfnKVmPlU+9K/29eEf/L7Nspyq4pVHAsax1wRozCdc/DbqabBF4ARiLiSEKG9WZvJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8123.eurprd04.prod.outlook.com (2603:10a6:10:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 15:59:28 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 15:59:28 +0000
From: Frank Li <Frank.Li@nxp.com>
To: imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR IMX6),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR IMX6),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/9] PCI: imx6: Simplify clock handling by using HAS_CLK_* bitmask
Date: Wed,  6 Dec 2023 10:58:55 -0500
Message-Id: <20231206155903.566194-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206155903.566194-1-Frank.Li@nxp.com>
References: <20231206155903.566194-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f28c69-4ed3-4096-cf69-08dbf67453b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5jvDl1lFCWjXTPrxauBg+xJJlQoyv06ke6PSieJZBnLFs/lKp6RUa+O/nnbwQaPPOUNqkX9+ND5+U/ErqWKT6YKX0rzExU2TVuDwmnZF1xjS7s+NuFPOOyf8Be7M3JlIZIqWliBwc+ihy9mGdt+pQUfRWl9CL8PpWDhbzfIr1VOBpZflRfwSdri6l4Rjq2SJFHclllT3jjaApUnZig4hedQ8ToQ4MSNj9Yk3P+KFA2xc8Dh3sEtLZfSKFn55EcYYtn6qY4i4nUwwxQXa3eHoUbjWeanpXT2Ks3OvQ0QAEdqpn4Se0ve8VU1HjOG1K71hRvRu+egsZ79PHUPMwre+Yfwpg5YlshUwuuQrs+F/4fNaFiYdjX4dhmBr3qUtwMe6jYc9pYXjcA+rdeitFrkHo+1EpGifwTNvHHKrLWQ3Jyz8BTb8HT+faRUIALJ7xb6fMmEfaHRYjhfb36L0Ws/gfv0qextneQxGrL11kvDP4BfkFioBJaEc0BUi/YiBjBrhmxfaDmRToN+dUj7TM+2DY45DC9j/5ZU7NIFIp6AsV4Ub5iNZMVe5YS/L0mSRLtc/N/Ac1mxSwHLAd7Z4AZMtB1H0XmxcJDpunmUe0v6XTw8Sqew8RMM/H5ej++/elplrThXlmnpdxRhReo8hitsUmQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(41300700001)(83380400001)(36756003)(6666004)(52116002)(6506007)(2616005)(26005)(6512007)(478600001)(921008)(38350700005)(6486002)(7416002)(316002)(66946007)(66556008)(66476007)(86362001)(38100700002)(110136005)(2906002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MjIcGtm9sAfA9XPV4/4Mk8+zIueYM5GlkeBtEdv+A+FULFVuobFYbiF1c0j6?=
 =?us-ascii?Q?L9EgP/NKE5tdgyiPIX9SxTPtfNZ/o1AcdOmAWYdCRM8xHc5h2YxjvoPvPuCg?=
 =?us-ascii?Q?kmRnfwjlL+Mnw9altLCO0hKVkt5j+OurNmTE/J1oq0HcRz7DVw0XBnNHeY+i?=
 =?us-ascii?Q?TI7W53tURCk/fOfaqb9WJy5KSqGB0DCy71KpO3IVZH5tHWxpkag0phR9ePdy?=
 =?us-ascii?Q?u2nD9ApnJ8V2kHjqTDstrK4oigDIdE34j4iVflVflLrUjbhRgC57IP4vFn26?=
 =?us-ascii?Q?AAZmPwbFjC2YSJG9+sxfo0IrGHHUWVnLfLr9C1EfRQj89/LwfDL71qZGI5QI?=
 =?us-ascii?Q?foQ0f5wepdl9qjQxbEiqpKL/Yx0UcljYY5gzaiy61RXXYox1wBwMB7x6/vPr?=
 =?us-ascii?Q?v+xW5mXWL5Vw4IRd6HdQvUWGc9E4iS/WRJ41yIUsGYKfFFOX1SjnzhqAGB4H?=
 =?us-ascii?Q?67RbtpoZgyURVAZGgqc8kMghNaNV0dMXGRMzX8CvTAbGEOfrrr5tf2pqcYg2?=
 =?us-ascii?Q?7UxHnIAE7DEFcdeXepRmN7+dDc/9arrPsaf8Vzv/Jkjqq+ztMAb0059D4q3z?=
 =?us-ascii?Q?qef+wPOC09he5UX/Yq5l+nEsCnFHIOa4l+3gd2sBOnYJQ8uV8TqzQGJ/ZHeT?=
 =?us-ascii?Q?nirUA+VA3KKMVz2lIYMDfiU0x/kBOS3LZxAbYf/KwOcjYsB/ycYlKKNMffZc?=
 =?us-ascii?Q?u5IESc5NqizUSJhbFVwX1jbl5m7CTybQvAi1NJrplD+7zphbGGd3R9NvXEmC?=
 =?us-ascii?Q?EykdGsoLH/x0CTjNdlpTl6Tx9VTCEVTQdPpo9axELGANAolmrCtxfKI02AB9?=
 =?us-ascii?Q?q1mxW9aZbaExPeuUf/ZXotzNUo0i95+IjCCLirINQHlMyjozQ46LqiDE2bvJ?=
 =?us-ascii?Q?65dYf1ErG7PsuU3xLw6wR/stfdet7hi/QecUswKenSrx8LATXPRB0AOVuOSv?=
 =?us-ascii?Q?Y8wzJY8fyz20nOrulFW08cAO9G1xXsR33EszWNAJeLXZd0GvOh8pGc1Wfa/M?=
 =?us-ascii?Q?0EDsUfIpHLXQ8b6gZxMw46bkDhPyM7DAX51u7Ww7diXlTvOJGqhMJKatzAu5?=
 =?us-ascii?Q?KEdXlSmr79gqpNzF9hA3vmZt9OS3V1pUh62CCIEvBzGoruo16RjPbIgMxfmP?=
 =?us-ascii?Q?JM+8lcObJAFVNvy1Yl28oTHxRrL2RFcYWjxZvZ4LGPLUIJNjdjpLvtDevM4r?=
 =?us-ascii?Q?3JxDGBNASDqgnOi6DmMvzYtbv0dvxGDmpsxhUbyUDtT5bPVS32jlItocKCba?=
 =?us-ascii?Q?GN1I7o5ORdRNH2CndqKw5lwgqsKAMySSEDigQe/PUkTwVpOp1igqbph8p6wu?=
 =?us-ascii?Q?WoTf7zufhRfZhmJ5VuzG4DyyU5XYPLYLId69Q1yV8TNTvzgiCey9t11axp4b?=
 =?us-ascii?Q?YuyLazBSqM6+onHdvTnH4hutp5oR2tbfQHr5QjF1pjgTGH+vykcWoIJJBQe2?=
 =?us-ascii?Q?1GCafumMGY48OqnxD+1SzC1Jmic/n2A5wRMH9ZxyOjhHpKqHO6jg1uI8pETJ?=
 =?us-ascii?Q?EoOYZ9Xn3nopZiypUkI3eEbYD/QiisQuJEymomfqCWVgjzwPQncjqtTWr/ry?=
 =?us-ascii?Q?3tq0OOqQ12Xhy+4M+kE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f28c69-4ed3-4096-cf69-08dbf67453b1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:59:28.5782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcXWS8+cUIPFvR1r0KRUoQPi6risbl9K8/N6VMuihjSvc49udP9HXPWfU76qvlI4wr26SDY4VkFwq4uKPydXHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8123

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
index 74703362aeec..8a9b527934f8 100644
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


