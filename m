Return-Path: <linux-pci+bounces-1342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DCB81DBCC
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9706281AAF
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881AFD2FE;
	Sun, 24 Dec 2023 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K5OhLWYe"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75424D27D;
	Sun, 24 Dec 2023 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egAEcy7WSst4vCAKj5UXpksY96PSLN2JyRQ3eDTWA+kk53LhgM3yBlwexjJg25YRT+PPlLMo7KQfD0wIHquzGLOU/uXnmIzGfZeABEmtV5nHTwu9uYd0HYEiRF3HLSbvOU2nIQYZGfxHuvH6ZZ3hJwUxy0/oVec3yNR1uVWiStvkPxc3AeuxANThxiEl9XJIEaSR3TP6qsocpwvxCx28kITNcelsRYh3UoPnLzBYj3V8Z037zzGCysW8T5AN0PqYs0XKPMK26fLGYc0+Jv4qoHX0fCI5IrIKTESabSR4wyAJDYNp6C90LURB9qjdtDNG+k5XdS3LJA+X4MSmA3T8ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LAXOsM+n+ieruYA80YmPJNWaLohdzjp04MJ2htd6vM=;
 b=bF+GmWzLQvuZcqpZCwGaEDyPvzkAZWUXivzrVM34pOnJmQi/oQtQ7vnr1zQsJ3+9TaY2yPlWagajj9G5qKqjQMK3Pq4WRFbGwtBVf57UUdUTzj2iNrVTiaguCnEzn8fX8r0Il3JGT5Tuspxp8IWjSST7vzmtbeEX/dxx5NeOoOj7G05VcTWWkEsrPUceetTRZCmxc1KzD+D1e+fojjoAKFy3Jfzdu67p9G9LpYkZ0ie9YPB9+F5pXVTmPNnUyecvpoI2SE77A9U/EWPiLkkJ0wk29StYPLjn4vzEaidvEZ/HeOXGn9IgLdIPwFUCsDTtGNF2/mCAeNDEwT9+wwFFfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LAXOsM+n+ieruYA80YmPJNWaLohdzjp04MJ2htd6vM=;
 b=K5OhLWYelcwgJF09hzTJ3QC2NoKztirxApHZ/7g94oR4CnpsifmxrrKOxA0Ht632zcH3Q9nNeE3jk6TGSZp7M1Y+wPEJJbgwJ5qSeA+1R12gUQi9fn/er22r8oT40MnrVdfPvgFpJv+x6F7DtN/fZwv8Vs7lKIYuC5YdfOQx0us=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:33:06 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:33:06 +0000
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
Subject: [PATCH v6 01/16] PCI: imx6: Simplify clock handling by using bulk_clk_*() function
Date: Sun, 24 Dec 2023 13:32:27 -0500
Message-Id: <20231224183242.1675372-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 62772701-a91d-4703-f834-08dc04aec51e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QK1CXcuan5bFmDBGfcuB2dq0Bil6ZwDaKL2U26TvBgeG32cwmgqquEEbYZuFLmUqhimxq7/CVkn56La8/QJtqDG4+Lt28TXqWqsOQ0kv5kcwzlfbmeaY8mZ+6j5u10iYcYyWYoOfO1CHJIjatb+gKn5xFV47LSrH2vBsDYjHXmgCtnJx84/lnkK53NdvE+/RiLo6z+dTZegKVarqYxyL9og8CWFl6sQAI2G9WosgliSm/qbnmpgHXtKL6IuLxKyblBaVs3cjDRB59EPXxygnK1YbVleDrWUuAakN3mN4lJrrycgPdvRuXvvCR07gjHQw62SYTp7AK8MVP9S1LeSgApxJEsKb1W+sLvSKAdj3hURN+WC1t+otJDoPcWicqLqbU3nonkJ+OkEd26YNrZx+8CWdSyJGMofkFe8JeZyZHbtIbOBCp6YQdp8Zzqe8MVohxdpPEeczBSz58H4sWDo/0AikjV68vOrECppMQ+uJzY6o2StN0qOoFS1Lx2PDnIeerIEgFUnFM/EmPDxAOIOOK+zIHwqq0S+7yIcIhrvtQzzZU47/I/p/zkhTa1jrtFj44MYg2A/jsFpCEoIhHtvD+A7ncGfHJKaPRGu/Z7Yd/q/S54DaXr/wJwGCAk49iW57
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ax9xzQB+Qs3dw6pgTcbltkdhFQ97+pvdaAX/T7NPsByRRzyPXI59x9KT0Qjr?=
 =?us-ascii?Q?947gkjmbQBKVYiIKMUoirMFwDojb3XM0CcsqvbrCk4WFE16g9qhwacA4CpPM?=
 =?us-ascii?Q?Sr3VwfXImhY9Wku8muX6aB1Y+YI859xsJesvqbkonx+XHov2VbI3LpKbKZY4?=
 =?us-ascii?Q?aXVJBjD0LO0dxSt/t4kyjGCSyTownY3gkhoA3Fx6kn6GEIiBhkr+6nehtAcr?=
 =?us-ascii?Q?3HH0zCfdSCa9rqSjfAJ9YqHX9UJQswYoUsxgHjfWknxnHz2tQF2qOWwtv3ne?=
 =?us-ascii?Q?Vg5U9oTMwxA9va0ipqzghQW67nVJdt+/ZS2lbS9VOUJoaMps95rGi2OJCnR2?=
 =?us-ascii?Q?sLNoqyjTU65LQ2gcTkzg6fHI45LB40162EOGKmN4UC2PshVad8eQtEvdfLwl?=
 =?us-ascii?Q?6WfHa2TegeIpK5E7n1jMqxOcHu7gsivy5wyS2N7wtpuRFb9obg9OJ3lEiLGR?=
 =?us-ascii?Q?7mI009C+kJQktNWhSbug1Cq7gbZt/zJwdhI6hkJIx123eM1W9YaGUkkVG/pM?=
 =?us-ascii?Q?DIs8pNhpYN6Zwju+KjDX0BYcsl9Iviy2ilpva6odU43mCLLY7TLZ0avEHoPS?=
 =?us-ascii?Q?L8SBrtghdD86zwoAZ+nMEP6n0z7gzfmRShIGjqhux14pTEPKDVY7Xu54yFJi?=
 =?us-ascii?Q?XQx/5EQGna/GfEo6YB2c/EYIq7pHZdKa+oSCHTxaJ29NfG7BiBCuLkeSyTKZ?=
 =?us-ascii?Q?0OyqwIZZlk4lzZ31oNN30QrcQdVghbLf6sShzXgs9FxSrk9txGXk2XQZgife?=
 =?us-ascii?Q?jOjGKuDw3Ij8lM5MHhgakYKj+w5VfMgZjEKs9M0RI1ddpe+No4hvyrphwd14?=
 =?us-ascii?Q?lKB/qHDTAknktNunH7V33SeD3DBvp45VCv2yjUjzoBjx39Ntli5ByQ/u5R7X?=
 =?us-ascii?Q?ZKYTjtxuZyla6/p2GQTTgAdLLbwDTT+wZZiGGNmZWKsUVyrZekgXsmJmcYzv?=
 =?us-ascii?Q?vMJGbSejUK+PS7eSuTGqvpeBC6d678NijB2XIClrQgTGfC9ymSbq5cJyVLhZ?=
 =?us-ascii?Q?iWLYFsaywSiiNOLt9ARBdBKvJ3ABXOjAAop4b9QMREznB55z2q7ayvnNSri1?=
 =?us-ascii?Q?38MNzu5du6LNXX1hIJCv/FOt3+eSHGPu0alHS3qU9s+c+ZXs+E+opVnu5cr0?=
 =?us-ascii?Q?Lp+zHlpUel7zQ2QWVJH4s9Ff6Wj+7+ySlP0T1NOUcrkSipIYs4I/4EF8iHqp?=
 =?us-ascii?Q?9CNXfjDEp1tLZpV7YoIdcNAeksbbIOt4hU31PJrXvksJxQR9dIrjpOB08Oia?=
 =?us-ascii?Q?CqJn08QmKftv+7TRQy3lHf93t350Ey1IS4Hia1nmYy4tCgyTXUHvL0VxxUYm?=
 =?us-ascii?Q?HAsLJPiUKHa5PnnA7hU761VTlOlqbS+OrgU80nWTiY+yfpjQzfdXWZL/21Ln?=
 =?us-ascii?Q?pneRsfrONGeHJm0BPpzTZ/7G7+XBJo0pN8kPEpGJPda7feofZyw5Z4Zrwrob?=
 =?us-ascii?Q?EWyZSX4vo+M4KnWA1u1mghQsyrYzk5H+ulHDlUBsTSLFmxssvkL0NaZlAegv?=
 =?us-ascii?Q?pY2nWEfRAzMrT3hCmAGFKun5/gAv6DhHxiOyQIvCHdGl5EXSi+hLywEShojn?=
 =?us-ascii?Q?wzQX1hV13mauJuBGpE+uYvnpsGY4nf2fyRKi8Q6K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62772701-a91d-4703-f834-08dc04aec51e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:33:06.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tGQ/+DHcJlrZYRmxw5E62aFJD46sftKmrSPTHeWLtX5H3PB6kyV5PZ4+P14/uayNrOp4Fxle9LXU205tKVO5qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

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


