Return-Path: <linux-pci+bounces-1839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 334CA827B61
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB0A028523D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C1456750;
	Mon,  8 Jan 2024 23:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hTR03Cro"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E468656444;
	Mon,  8 Jan 2024 23:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjsPSSEntPgvoqZB25uPtadcv1hWU9k7sultpDazUCiXS6Bz8j0HlkK+NqWjKDraLYoUXxYRcL/yenghSCMWbzT9QC2g5rf3YrRzQXq44zFK1VIgJxdcGQWu/l/LHMmm79XEk/kf8fOmYTouJZ7hFSxZpwRAo5mciJTW/52rpOww5ADox0FXZgU6408hY52v9c7e00+csh8qf9u+p3ZaXZj/vg9+TpTzr22lYgwbuC1XFSzhYfeivH/G6fqO8Zz9CKlxsfa29ti4qM0crs78wiy1BxHTWmePsMbtUiK+1xMf7HJzagNuveAfXtrFBi1eD+kMW05zrK/xx31CAUBMfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBcTNeb64Y2C6qeLiHaPYSgSynlsN0QXpmk1IGbVxLI=;
 b=D7T6h3DJvrMSKTVws2DMng/Nvw+Epj9gBcQyVkEvW8ol848o9U2EWccrCldWWUOBUUhpAYvKc73j1083h0D4luviSJyKfxr0XRxe0B66dZXUpQEhVY5tzZAuVy9kIhku8Syebn07zszZDNkUwxKCdZA5CwmgSqWgV86E/XvSCJ4lxM92b0jorBn7TVZyav04rwGF7E3DGo2qlFjImROUjA8j2lispSlgkrQXSdwl0Hdsd78uRLF/UzsyMLSAUTrpAsEtQZ/gvoNvmsm3AJs+g0w1I2wSV3xCI5CYaT8A35bTw3xKKRZ3V08fBLCGN1iIZkuzzpBdjjd8qwTXaDaQQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBcTNeb64Y2C6qeLiHaPYSgSynlsN0QXpmk1IGbVxLI=;
 b=hTR03CroR0Y+5HzNjjH7QJ1CdyYVV2zL80bNyPCNd4uR75kV+FQiNNfKVioP2PvKQ9TRTcBSbhq8m5CR8D6IqeCK6McJ02P52Xo05VJXmXLU1l5YhTSlUwAmwSQ6IwTkK7Fyevn+StPgb9Uxtb5kpQEmTL7Mjm5WGdcM4ayFRkU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:22:11 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:22:11 +0000
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
Subject: [PATCH v8 01/16] PCI: imx6: Simplify clock handling by using clk_bulk*() function
Date: Mon,  8 Jan 2024 18:21:30 -0500
Message-Id: <20240108232145.2116455-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 27349c58-539d-4978-9c5a-08dc10a0a3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pyrcgw/0kYhs3LoKRy2a9KpGJTty0Y7mtv12K7uKibyuP0Pu5LsflUFGNZzV4KGrmhhaIGM6QpVu+HsH/QLzE1rXAZ5lgn6OQt1dlCPpcvwOw40f3zv8STwzNj9qnCI43JC9Xy++HeKnmvHMxFmv4L3JgqheXfR5+DDE+gizIDIJqHdq/AX/z1UrRVCL/khj4Jnru8G6iN9F3St+/mZ2jZztwx2zqFsN/nbMUUBmmQKrT1GO0ZoiRZ3FlgewKF5YCd6du90fw2fhqVZsdRHtdC3uGSqh4hqQbny0ACc2obVoSzHBsYfuvG7qAm43oGn3hi/mVt28JC/lLi7EZYhmmCNrYPASSkQkyPztgl5Q45s1MZT1HVj53YJY5DQ9zatW4lU4+7nJPR+PphE6iJaXs2mQENH+kl1hGbunMlDy1wobaM9/asKm4BIZSMN7VyOr2Fd7ySbaAZj+ys2xwLuHzpdqCcfRML03OBxxob4VFvGGKBMgOKwhEmM/xUIllZO9BKK3OU/ie9uFT4V66sdCZI44550CwLTrfn5RBpiJUos4asxPooGu5rmfKAOGBLafeMyhmPqB015dwTL1VApCmT60wwzFGBOAjDCr3H0RAre8n+fUeiaF62zWoDCXMM5P
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(30864003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4wkGGCcDa3/04mPcTcSNR0q6O5FPRYhHpL1n/QwHuaLaE4F6hW+WsqFASgkf?=
 =?us-ascii?Q?KazGhbCY9H55K/qGz8Y3TEZ0ejJvXMwvkq3dtaZ28vHs7AJbVAt9eMD2pOOC?=
 =?us-ascii?Q?EqSqH+6eSHs9cQ3ruAMBgH/1pca12XgKrfrtqZ5BO53BWOmcM71u5JYs36Im?=
 =?us-ascii?Q?1sxJvE0RKnmjZ4H584UtKWjioudW3JYQXXzziUcUR1ngS688zE9Hou8GaWyj?=
 =?us-ascii?Q?qkay9fUffue5ZF3p9sPVteUhL0cSppIg779VXI+6/gEyb2r4kTEc/xvDJqrS?=
 =?us-ascii?Q?ioq7jPDZshaZ4uRYaaRi47HLuQIn3YACCu5IWUxF/GbPe+NlMOQXH/PCUXh1?=
 =?us-ascii?Q?0SSGbdpxOxA6tUAfrQYNe93WhjiaNpKGhZla644CiAaw8nt6QH6j7fTk2TtY?=
 =?us-ascii?Q?pqPhh6cvCTqxQuoOdKi6h2HyhdIktDqLax2WQcie2i41u9zRTyaU2dlOQfIr?=
 =?us-ascii?Q?ugz0GCg9HxuAIrJKgmSAqfLV9+SwTTlCIIPiRmIBmREggTsld1Nxlc7DEX3v?=
 =?us-ascii?Q?/lIF2mzY/aw9ITiPJ1IrBWf+3yKiaZKYpiWg+pj2l1zmtVDL+vPffZiHj8a7?=
 =?us-ascii?Q?K0+D1gTIMQwKjZZDDy3gz8xRemOvXyMPEfnRoo35ylY3507ojqGklOkRR3Nv?=
 =?us-ascii?Q?kq7sNm6YcA/mNPhiUmF97Jz00QcnwpqndGUTCR9698snA0Z/XaDceeezsY+C?=
 =?us-ascii?Q?du/M6Kpb7P8Q09AN0hRnFRE9hkK5kYZUrA1BRrAafGBFS0e5TkEZafbIcYOw?=
 =?us-ascii?Q?hCZMNFSFCTmWTzMadhXVc0SZJfbCIpyp2bZy4FeCI41GtNde3hBwhh+xsvTB?=
 =?us-ascii?Q?/B9YCC+cWd9WVytO9FeunW38+l/VaPEKVrcS+ZRyoATN9QY50GmzdS3nY28O?=
 =?us-ascii?Q?+51d9xjO6tNkJgVXP1cGD/ZlWRUgS0u5d0OX5TXrn4ha2WpUVJJ5Ifnh7SZU?=
 =?us-ascii?Q?/osOfrXAk7v8c3xQ5yWUwLBinaW6z6F3ZZ/eQ3imqWMvKfUl0sDP0tGKL1Z+?=
 =?us-ascii?Q?uympOdvz48jZ9eRZvzGisNjMXT2mzcA0B9zC6G2/6TugPOhmHNgkix0wlZZ5?=
 =?us-ascii?Q?JCB9fr+DYorE1VEYERYZrJr8dnUXpidFDYqQ35co36FI2dX3K7OIYPVkdZKE?=
 =?us-ascii?Q?mv8dEXG4roZeFlgvV311xHXDF//dyl0c1XfnW1vrU5kF7Ys3YM1rMlijo0ES?=
 =?us-ascii?Q?HuglbaqUp+o06TGjCcEwRpBnzS31S9mKCqEwJzn27V0iG9ewqFKUcUQa64Kz?=
 =?us-ascii?Q?rshwWuUFG0mJm8vlLKrChq5tlTo+XsE/shJDggQMkovUVspY/313G/y9sKxQ?=
 =?us-ascii?Q?+zK9Hv39SoGZ07ex/nZj5BDaD8DZ1RS5mtXOqNg1g6JDysXJuUU5iFbVJnig?=
 =?us-ascii?Q?IDU4bR4gxlORlHjLYvMuObiUe5kFsQLfUVUiPUopM+DajB7mpgRh+GoahFnE?=
 =?us-ascii?Q?2y2YM9XNgKmnPUkFRjrbWwXFhvnSFPEAPZSFjjR1TAzCV2LBD5Ge9x4Yldcc?=
 =?us-ascii?Q?JCPhbsOvJLwYvayyHoIhRiYfXvuGWubDaV4q7sv/ZcVLqXvs9tKCS/mH3Gqs?=
 =?us-ascii?Q?RNQMKf7bwO5Rs84YdRrbrl+rNKyelZEyjwd9AXqr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27349c58-539d-4978-9c5a-08dc10a0a3d3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:22:11.1720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RD3LrkCsO6/sxBItK23BTEAloPMdv1ZeYnqMQmnb19TAqiXy1id+nSSiZiQNXEQbFsSJwUHzsnbs4RXC5njIkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

Refector the clock handling logic. Add 'clk_names' define in drvdata. Use
clk_bulk*() api simplify the code.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - update comment message
    - using ARRAY_SIZE to count clk_names.
    Change from v6 to v7
    - none
    Change from v4 to v5
    - update commit message
    - direct using clk name list, instead of macro
    - still keep caculate clk list count because sizeof return pre allocated
    array size.
    
    Change from v3 to v4
    - using clk_bulk_*() API
    Change from v1 to v3
    - none
    
    Change from v4 to v5
    - update commit message
    - direct using clk name list, instead of macro
    - still keep caculate clk list count because sizeof return pre allocated
    array size.
    
    Change from v3 to v4
    - using clk_bulk_*() API
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 144 ++++++++++----------------
 1 file changed, 54 insertions(+), 90 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 74703362aeec7..4912c6b08ecf8 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -61,12 +61,16 @@ enum imx6_pcie_variants {
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
+	const char * const *clk_names;
+	const u32 clks_cnt;
 };
 
 struct imx6_pcie {
@@ -74,11 +78,7 @@ struct imx6_pcie {
 	int			reset_gpio;
 	bool			gpio_active_high;
 	bool			link_is_up;
-	struct clk		*pcie_bus;
-	struct clk		*pcie_phy;
-	struct clk		*pcie_inbound_axi;
-	struct clk		*pcie;
-	struct clk		*pcie_aux;
+	struct clk_bulk_data	clks[IMX6_PCIE_MAX_CLKS];
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
 
+	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
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
+	ret = clk_bulk_prepare_enable(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
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
+	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
 
 	return ret;
 }
@@ -691,9 +653,7 @@ static int imx6_pcie_clk_enable(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 {
 	imx6_pcie_disable_ref_clk(imx6_pcie);
-	clk_disable_unprepare(imx6_pcie->pcie);
-	clk_disable_unprepare(imx6_pcie->pcie_bus);
-	clk_disable_unprepare(imx6_pcie->pcie_phy);
+	clk_bulk_disable_unprepare(imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
 }
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
@@ -1252,6 +1212,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	int ret;
 	u16 val;
+	int i;
 
 	imx6_pcie = devm_kzalloc(dev, sizeof(*imx6_pcie), GFP_KERNEL);
 	if (!imx6_pcie)
@@ -1305,32 +1266,18 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return imx6_pcie->reset_gpio;
 	}
 
-	/* Fetch clocks */
-	imx6_pcie->pcie_bus = devm_clk_get(dev, "pcie_bus");
-	if (IS_ERR(imx6_pcie->pcie_bus))
-		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_bus),
-				     "pcie_bus clock source missing or invalid\n");
+	if (imx6_pcie->drvdata->clks_cnt >= IMX6_PCIE_MAX_CLKS)
+		return dev_err_probe(dev, -ENOMEM, "clks_cnt is too big\n");
 
-	imx6_pcie->pcie = devm_clk_get(dev, "pcie");
-	if (IS_ERR(imx6_pcie->pcie))
-		return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie),
-				     "pcie clock source missing or invalid\n");
+	for (i = 0; i < imx6_pcie->drvdata->clks_cnt; i++)
+		imx6_pcie->clks[i].id = imx6_pcie->drvdata->clk_names[i];
+
+	/* Fetch clocks */
+	ret = devm_clk_bulk_get(dev, imx6_pcie->drvdata->clks_cnt, imx6_pcie->clks);
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
@@ -1470,6 +1405,15 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 	imx6_pcie_assert_core_reset(imx6_pcie);
 }
 
+static const char * const
+imx6_3clks_bus_pcie_phy[] = {"pcie_bus", "pcie", "pcie_phy"};
+static const char * const
+imx6_3clks_bus_pcie_aux[] = {"pcie_bus", "pcie", "pcie_aux"};
+static const char * const
+imx6_4clks_bus_pcie_phy_aux[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
+static const char * const
+imx6_4clks_bus_pcie_phy_axi[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
+
 static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
@@ -1477,6 +1421,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = imx6_3clks_bus_pcie_phy,
+		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1484,6 +1430,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = imx6_4clks_bus_pcie_phy_axi,
+		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_axi),
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1492,40 +1440,56 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = imx6_3clks_bus_pcie_phy,
+		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
+		.clk_names = imx6_3clks_bus_pcie_phy,
+		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.clk_names = imx6_4clks_bus_pcie_phy_aux,
+		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_aux),
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.clk_names = imx6_3clks_bus_pcie_aux,
+		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.clk_names = imx6_3clks_bus_pcie_aux,
+		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.clk_names = imx6_4clks_bus_pcie_phy_aux,
+		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_aux),
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.clk_names = imx6_3clks_bus_pcie_aux,
+		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.clk_names = imx6_3clks_bus_pcie_aux,
+		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
 	},
 };
 
-- 
2.34.1


