Return-Path: <linux-pci+bounces-2375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1FC832DB8
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5AC1F2506A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083BF55E5C;
	Fri, 19 Jan 2024 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ofCqe6Id"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B5243ABC;
	Fri, 19 Jan 2024 17:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684314; cv=fail; b=gq+MaH5RdMopSrdlqKsY8uB06t5iKXO2Q0++HDd74zExICFXtBwampEDQ9MqauXZ7d/bwGc9oExJrLoUyxoOmQC4G7EOddFvQAhvTOXnft4QYPEQmPiH6EhkeFU1ZeO8zDhpr1LXwOW9ja3d1IoAJLl9+KxEcdvRnWcQZstLOJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684314; c=relaxed/simple;
	bh=7Bg1aeS6e8HAzNXIUNOmviXfjwm5EPN3eyCeZhDffps=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rD07wYDjYb5JNwHP8ue3uKds0Japvev03YjaUmou6mIWXyeEPNsx1mCIODmTnyLpLj8axT2XOX1ZI/s4qpyOncluzo/b78TC3z30Q6V6YpJK76A6VSikROmH7fXgkRistB0VwWfdeDJmraqa+FpxOsIXJJzNxP5sCeSN1OeiWaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ofCqe6Id; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRJULRAzniMvNEunWl3XdoQbne6rkbmFdX6uKR3U7IQRxZjJBJU9+XndoIr5RYqmZqpAN7aVh9MOmn1Taw8m+rKc63xaHmzJCwuKwTi2nTWDjQfXStF47HPJFfzTduq6h82p+yRaU9vmFaFkxOlkExdIZjHZRS+SJICicj7IiFGjPoYzEmjS88dE3LpsnMmvGO4WUCo/GCWiancUAlqdlwoAM6P1gLiNYAOdxIwJjzWKkZ/X2Y3c58TCyqRUnez35hreTVprZsl/EbFcgvJ9t8AM1GNnPzGitQWyLId7Lo+pHUOuyb0obolHPRfmVZKSPolyGckszCFaydVrVLVZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr7XTXpX1v3wRL8OEuZrVLOd9tGwreVS0m0WZGupT9M=;
 b=WBKY8pl5ngOz46rObew8QNVj7teG/L75uS+58wdzfdg0f/tdkGzyDmb/R7ZTrBkQFT9OBueZwFjJWwaHhnMB9GCSZG9RDwv0sJnrc8fx91P83D4O0CSDDTqecwAp6sH9NpZ5ImHp96kV1ZUEFaGe5jeQ2rr9IRuwDHmYPDzrjucNI8usgvrrrrlsSzuwc1fa6CKkhpTtA4cYZPHP7MRmFYXeHpuA3ZWoeUWzvWqj3T5utOesT8nkYjCS6MJ/bbXZ+8VmHfUZkcdI3Hw+6I+OkplO1eHWDy+00ZtYyp6f6qdqikBAo2+X7v876DaiEPmv+xZJdBJjvQyUBlSSdDHW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr7XTXpX1v3wRL8OEuZrVLOd9tGwreVS0m0WZGupT9M=;
 b=ofCqe6Id08BdzPTIsGiW2LpbDFGXg9MTrYxLwN+ov8cBsSsx8zy9XzA4N36MedPttYVnBSEMKsCOMc1f4VRcGqtEaSILUaqfVVQfjFORmo/mHvOTJpEERYChD7icPWhMdb6wRYGikC/Dl5sPWhEm2bU2aLjPcs3+jQcoqNLIwVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:11:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:11:49 +0000
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
Subject: [PATCH v9 01/16] PCI: imx6: Simplify clock handling by using clk_bulk*() function
Date: Fri, 19 Jan 2024 12:11:07 -0500
Message-Id: <20240119171122.3057511-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119171122.3057511-1-Frank.Li@nxp.com>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bf45ef9-b3e9-4e02-c3d1-08dc1911b910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5IwSZfDqnRTeyEh0/e2nVcPPXYpx098E21/0l8gS8PmJ8jfbKvh3ZbWUPDF3Jp7Mz7+mIulbcDe3AdSIfqx43AHuB5N+cbzTAIFvHPizkgX6nTdzSetJdmKD5tICe5NiYRUZjw7dro5bHwcqB9ju4kO/G5UqLHImLqRQ77pURoVFP4WBUt5QjXYg0sZ6DcpS1UB+TeY26HBKQOFf9Z1r6smi/ykt/mOHWrH7vMR8+ek8I3HjoTnH6OCFShWn0CSoWJQayVpf2clBm6/bol7xIAtNkaEacmtOUbMV0U6zbvvxROSLemvQaddfTVSlBnQ8GxuPJp9hGCiNRsVjJLzFLq5FHU4XA6N5J6a0cAe4i/SZTf6teQfNqUxSaagL9wd9Ti2XqpxhTqFoc1d5w+FuMqTtVuM7BoWwJ2huScGx4/hhzCiHMIS8uDMTS151nVmq36uliVSYlxn81qTcvBOCd8ImJO7+bMeC773u1pDVHNM9lFkRBkV+w/ZuM5KCaD+JudSxh2DMPCsP3DXjcNLRQqkmEWMr7L9C86UcPJmM0cLB00bq4BMZ/Ml8olx9KZbP7riS/DBiCaZkL1Js2zl524Cv/rJ7oI9MvTnq3+zFhPsWnaVPjs4AZ9S6BnRG25uR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(30864003)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mzfqRg008uVNMOdwGlMTJPS3Jx2xeHM5TcGBzzo4+CRrh33W0xrbq70BKj3h?=
 =?us-ascii?Q?TvQXpxbkcf0flli7jFfYS97tDtGm4zQY9ZNJiqHI+ACe6s12IQ7AVvoA+B6f?=
 =?us-ascii?Q?+/5uGlnJR3nfORWTr8SQwZrnWZGRP21qKTOonO4Mku2XWt76p5zw/h/RViNA?=
 =?us-ascii?Q?CE/sNsZR7+BeMOUaAwZCaS2I4DyxMOj8QFr++OokwcBlTePbqD0Vk14semw9?=
 =?us-ascii?Q?f2ApDpdFFpSUDlYfAzY7fUPSYx0p3QmnhHMvUk2AocDl/6dl7Iq0svj1zBTB?=
 =?us-ascii?Q?5n+doEKtXYf2dxLoWODHa/gk8ShKNyVUMsUhv+rSaml/nP9K+z6i0BXI8x8L?=
 =?us-ascii?Q?a3CFn1KQCB4YlOanZ12fk8qlGgZPVdoyoNaVAmti3mxQsuDhw4vWlQCpnbon?=
 =?us-ascii?Q?swLuBpI/Sqlo3FMNc1aKuWpRJc4bKJcG7imAnYpJufkUbHn2xWx5B/KXsPaQ?=
 =?us-ascii?Q?80Qqivm8LuIXaJay/ekxhXEmy41xC25IE6nSUVI0FgU8j2hgb6vRw6SuKHZh?=
 =?us-ascii?Q?Z0yfw8UCE/WD17k+Z2cpKLtu1AJSnYTiDehL8ehWLLeuCF+u5IZ3kedmRSRy?=
 =?us-ascii?Q?nxN59NFwLSTW7O1T1Fr4ATN+JA35XV7R3vUrxSbU7822HLmvQ17wE8oyGSgP?=
 =?us-ascii?Q?XRIKzysNlayp0tcM/L5e2zSKTpRQlBIWSFdruX/RmsH89TGicmNwagbwIGRe?=
 =?us-ascii?Q?Tk/QEKQwGGgmTCdb47uNMsNTqeZSVp7XFLxotoYeJ64b4CQnM/NL9PXJ6RjG?=
 =?us-ascii?Q?837k9iDv6EkYLwG9/ZM6v0et9YHVfqHQBiQpUOk7sV+bzf8SydWHO8Xr2HQp?=
 =?us-ascii?Q?7Py1kGNUf0FMeuJoaKAPHy0KDze1n3lMbbv/zX3ybGxzevTdFX0UZqoyDpgM?=
 =?us-ascii?Q?qUN6WXaUMBYArUqX2ygIvXGdOeWnkGLFbjFQN3sFbfEneEtJ6CWGQY+qRdVZ?=
 =?us-ascii?Q?D0i5U5ucYCHFO4+MkeFfcbrxuwsjL2zFpJWBZUh5MwSs6AAOq1K4rcWg3loT?=
 =?us-ascii?Q?jdsTPFWtCwKyNDj5xb30VwGGx/jg/1leW2HYsV1zCO5F8iE7orL6DUIP4k6P?=
 =?us-ascii?Q?pQ4hYvBv+N4cW7rAEq6jPLbVAHeq+cGps7J9L2tzqUvS417uDLnmiqhb67Gg?=
 =?us-ascii?Q?aSF1Q2FpQ4aFaPoOXODcrwgIaGiOz1+tqY1AjMOjwajvSkvpyuj/RPMJmDgF?=
 =?us-ascii?Q?rhWFspnvId+jE1TSyRWM7wyS6iUY1IbVTp/GeldHS/h81pL+x+CkTOesMiYS?=
 =?us-ascii?Q?ytq9vysKnd94jw9Dgjw9djWzpFAAmeO4MtkefOqOPKDrxKM/Dsohdym8bzeE?=
 =?us-ascii?Q?15B4UWcVp61IYmzHoBzFv8xMhAHNhe/sCAXNJVCbXsGgdofrRQZyItkgg0xU?=
 =?us-ascii?Q?Wvs781g3WwgwM5s1/kAWhlsZTH06YNLIxci+BHVfVJL4sh9hXYM7HgzEz/lW?=
 =?us-ascii?Q?4vULTzfy0bFM8l2PsJpOa72zBiMfYFPAhzSdBqcBObuUeilQHS17smxHi7ag?=
 =?us-ascii?Q?QwWusmTjjtZkMwneD8S4VTC0U8r1FximFweZI9oa+fnAjBL20jsH2IcQ6zOw?=
 =?us-ascii?Q?P6zktD0ZxAkoog+Q3OY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf45ef9-b3e9-4e02-c3d1-08dc1911b910
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:11:49.2578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vpcig/nGpXMCI3dqsWMnTVRQ/WL/dhGhOnqb48YvS7R6hgWad7sAOyTUteYWgvUe22F/zOm9bhuu34cHi9hh/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

Refector the clock handling logic. Add 'clk_names' define in drvdata. Use
clk_bulk*() api simplify the code.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9
    - change clks names
    - Add Manivannan's review tag
    
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

 drivers/pci/controller/dwc/pci-imx6.c | 140 +++++++++-----------------
 1 file changed, 50 insertions(+), 90 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 74703362aeec7..0997dd7d901a4 100644
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
@@ -1470,6 +1405,11 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
 	imx6_pcie_assert_core_reset(imx6_pcie);
 }
 
+static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
+static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
+static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
+static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
+
 static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
@@ -1477,6 +1417,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = imx6q_clks,
+		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1484,6 +1426,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = imx6sx_clks,
+		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1492,40 +1436,56 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = imx6q_clks,
+		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
+		.clk_names = imx6q_clks,
+		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.clk_names = imx8mq_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.clk_names = imx8mm_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.clk_names = imx8mm_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
+		.clk_names = imx8mq_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
+		.clk_names = imx8mm_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
+		.clk_names = imx8mm_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 	},
 };
 
-- 
2.34.1


