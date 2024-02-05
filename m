Return-Path: <linux-pci+bounces-3094-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD79984A0D3
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F9E11F22C0B
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917FB40BEB;
	Mon,  5 Feb 2024 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dcR4yecO"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EE04503F;
	Mon,  5 Feb 2024 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154446; cv=fail; b=GPKq+b8yYjfSd2rvtp0E0OwL/dg8F2Lfu1SDstgN4kHJIFCEPP34mCSWpOkSyoOA7LLlUTAB2JaV9p02RAm/otUiispwpLpLGA8BTkrXGWm94WD+vsTZNRsEwKmktnU3gErnKpUU1gvvUQA+etpo45+Vsy9BBMwqiH66fwBztJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154446; c=relaxed/simple;
	bh=KHEV46pU2O23mAXqTV32RHVy1jI+xhwlroL85Ku5sVA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t2r+RUprDviAHLSvo0FWTT/wg7FGcDvyon1CkypDtz/hiSgHNEfMB2RJg+rx+hHAH0tPqLE3kzF7MSV2+fGkGi/a2hGgn2YCbj5UW28CpOnx0D2k7c8s/3oCBaXMGkzyaKHgta7Zw42cRzM/yruO8SNNpKWD8ELObkveTNtg0E4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dcR4yecO; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=odceMloT4ow3WIoMybe+z2Izbkr2ExXbh3shH4Om34B/Qp+sWFy9r5ITKfZOTl5vpMMH7VXifXS8Oy0CE6qowfsjyI+eOVK9hj8gA71TxhEWJOk3phcPv5Zc72vOWSSPndspOncoJ4xX4NhBpO10H4n/XDq15jXAUEPPCFN6jcc6dHTwvRxC87UU4e3ip/VcndDHjk7hZl9rT8sB5LqULx0QQ65FfxMLcBHTXbN9Pc4Jvdn5qxKuzXaOhRj6SS3A6tm4DhPVFtJUb0m8XmLEsytKHVbPSacIVuYuDvbJFYvsUodvDFb/nI1JDRyq1/NEugz55fRJUFfA2d2e7G16qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nylFn1HAKkHlBcB1uZSDqMmpvNVDMHjzbaUJBbajYPs=;
 b=OepDRRHgCtHIWFNyNvl/hU6sqsA0nvPxXFU5hdq+WjCC+nMsmMGdeNYhCJuMmkrZPEkUDbqlk8ebN2HtBj4+xMJfZXC0KNJlhkkdQyvNGzwl/vOr0HpYE0i7ISH+UUkAQZhaj3I99TUHkmBcj6JtgdZXMXZrMtluSQiTyCAIYsH3WV3Gg4rcmO1sT6SiiK9omYPqVMwJkxApjNyxdNLogBAdbV5dDSk73SybMN0WumJUBB/P6G4Y+84F1UD+iQcq349luuduyPzA3YpVOCuyVu2YlMAIfTIUdZV2JZBrQyArSOi9NNWPpUIvqvv4qy5OjGpl7/IMZ7aQFAzPc+Fa1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nylFn1HAKkHlBcB1uZSDqMmpvNVDMHjzbaUJBbajYPs=;
 b=dcR4yecOuNIL8BpuGsCaAJniguUMEHZjMhvngKbT9uxzavX20CRAHmFcH7G5ZpK6lX/S9rbHRKa2rHil3/dcH+SS2wGYcFq3FFHIt/UHK57tEtvycsQqSNfJfque1BdBSTCaYWan1aO/j5MSTQL2F8g5k/HZZ8JTFU/RSYGibaQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:33:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:33:59 +0000
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
Subject: [PATCH v10 01/14] PCI: imx6: Simplify clock handling by using clk_bulk*() function
Date: Mon,  5 Feb 2024 12:33:22 -0500
Message-Id: <20240205173335.1120469-2-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3b0cdfa8-ca14-487f-e731-08dc2670a33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xiGObmFXTRKIJyjypAJ6MC+Sx2w2MU5zbY0GldC9h+cKIlW95qWrrHKm/KIrC9NI5DQWhg2cqSaISgUaQJaWQjZw1o5SnIoLpF5nA0yMCvAZzfCFhYRjIm3AW85dCi/hdmD/RcU7kDMDNKUurTjrU/KdZ73qk04n63COTKauZj+MjyyU2S1ThzWeAzkMD76lf+s2BhauVtZy3gNqj/1mAO6i3hZOKht42D3APm38PeiWXVPyonYoYUlvnITjxU5eISURszp3zYZZOqJQ8ZbSWG72wlHluG/sI1bhbup6yr4o0NTtkszd7Z4UkIzKU+D2tBCDqVsKK2c7zoa+7zEX8vLIotLQ0cuYNCnygE8M2bqxUwxbXwyaF1vpuMKk6rG18I8WwIMbejJvv9exAevNY/nkazR3Lj5R7huiiet6/ADkVD/tuUTpmYEDtXQ2L/3Ze1Yz/OBxP7y27/U313ix36EGgYDR7RLoGJlauVV9BrYaAgt+8FAYwJfbDFq8UO5wkp76DOKkeDNgUKmdIOy2K70JA3ptk7NtaCJUH6lLANrdd9fQEPACZb3fablyTE/szPa7Q/gpdMhtNpIIoQZiYmBso7TffQ2Tlsb80AqWH8M/Yof0cScwJSC36msg04qs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(41300700001)(66556008)(66946007)(6666004)(1076003)(478600001)(6486002)(6512007)(52116002)(6506007)(2616005)(2906002)(26005)(4326008)(8676002)(6916009)(316002)(8936002)(86362001)(7416002)(66476007)(5660300002)(83380400001)(30864003)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PwY1wI6VnnmD3is2PvcZY7Lw8s1nM6TjD6wSFT0B2BBtpXV4TRFMtTCPzPQB?=
 =?us-ascii?Q?9OZJ93VZsm1iQhxRkPDnuU9zOC67EECrHEkhxSwW6fyspuywEGAbk5Q6BAdZ?=
 =?us-ascii?Q?2KitWaJztwYSpXbsRNofduylvxDb8srBlLa1eUAs9ARQyzCUpJcq1HYb3Z/t?=
 =?us-ascii?Q?CnbTjo1EnivdAB1a4xXnU3BBfViChSIb21k74cj0WmPwoZ3WQwfJQehde6p9?=
 =?us-ascii?Q?BxtKUJT7/Fz1BISKFS12+KIQ68HfqjqAxcuBg1a/d2Ic+jOQXMEmQPGWiGXN?=
 =?us-ascii?Q?xeLaNf5EznWrrQ/hmd4INsX67RK02ixATp5298G5bI56NazYx0rQtZTLhCJS?=
 =?us-ascii?Q?5xFcmeUmQEPsqUYKqxOElHrPspK3thek2ZkJvZp61iqsHkUCXV4Ks41Smy/f?=
 =?us-ascii?Q?IF2GGCJHWxvlZqNUpcM8KLiOj1U/zyAq16ZCnkfUs74jxDu7cBCzUpURmLm3?=
 =?us-ascii?Q?axiw3LC4vyp9ZekrJhG/kYs3WxxanGY4sgbQRdajyN3QUvTDNqgt5jzNoCjr?=
 =?us-ascii?Q?YP+9+SRnXaWHUPYdMOUXojvre4eDctirx5ceylFlk0pSjQSjGdE81w1Kn2L+?=
 =?us-ascii?Q?nRHdpNwPGC85QS+CEm/3TpX8c1rgbhCT50gxVye6ybRXQmBqMaEPuOXb6crx?=
 =?us-ascii?Q?3wyyl8t4OVHI4TWt8QgTJHKomoIajRTc9af+AYcHhHe0WUFaP8A++m+hjwVu?=
 =?us-ascii?Q?qtzqeQgSg0rq2yvbdhMLCs0ailuGHoQcOLlD6Dy8Xd9zgEY03/vJ1hKD5XUk?=
 =?us-ascii?Q?mhx3lss3iUX2GAphjGIaLGgDZwYrQtJcWZwE6Sx7a+KOSBZC3V+qJKUypjwQ?=
 =?us-ascii?Q?7ahuINPrhyky+qF+V8tr74bkO5m5ISuiFvoLse4YTH2jWokX5NPILPGkD+Y1?=
 =?us-ascii?Q?zhjc+yWCeJRBvjSGACHpC2+g17Iv5ZbgmseQu4v+usAVkiAmxWfJ1keo/cHc?=
 =?us-ascii?Q?dqrOC28R4+CNnELeZ8FYWbWU16ZBj72SHtaW5rRvrHeNb5XWRjqv3F0GmJxu?=
 =?us-ascii?Q?cQDUeop4j0uSf5wYz59AljOS0E1RD8fy4j0xtUshPzwUi+uQ6titViuvhGBF?=
 =?us-ascii?Q?Rz5zskBOU5muEieVGXwSF059gg3zsvVVrqhSJfDKYcQSjoF0RNsa5sP2ITII?=
 =?us-ascii?Q?0Ndvv2oyEPA5kmrt5v10j5uqnVERxQhP/B2q1ACRM7DNQ43zsfF3a9P2AbKi?=
 =?us-ascii?Q?sC8kSgd6KlZbaxgam7LnYPupe3PBsfth/FzE8AkhSo5SJicTHiKZG8lC36Ys?=
 =?us-ascii?Q?H/ZGc3xqZ7TrW5KCuGQUFgmj2q0YqMalYacNt4jifbHJu+Ka+oaGIV0kUFO8?=
 =?us-ascii?Q?8/V5TIgT1yAegWOyPQTLU1E5t1DNal6FPKvzxuGRDwb8aJ59OEdAYK7p9E8j?=
 =?us-ascii?Q?+vNCWw1Dgx1TXa09BmUsatVmZFeuPcsRGmLcEfUNkEhwcIBgsvalNE5TP7Jh?=
 =?us-ascii?Q?zd8P/wzpSK43HmOncsKLTxWOTntBWJ/FE6IQxxiMeqTYFzQuFdV37GjwzRS2?=
 =?us-ascii?Q?Rce4NzASFDU2NKRp6ql56kZNkcLVMppfjP40j5PyMhZ+nXQhW0RkWbYKGJBP?=
 =?us-ascii?Q?gYAtBESLp4j3VGy9TYE2tH7U54aA/y7593bd+arM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0cdfa8-ca14-487f-e731-08dc2670a33f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:33:59.8058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rruidd3kktDX3xxQAIzrr2tFQRLNSLAuqYbbYVCQPRptG52MpknssbUmzfpGfp1YwA4NXNeHFYpqN/voe1W9DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

Refector the clock handling logic. Add 'clk_names' define in drvdata. Use
clk_bulk*() api simplify the code.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v9 to v10
    - fixed missed delete a case, which need failthrough to next one.
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

 drivers/pci/controller/dwc/pci-imx6.c | 138 ++++++++++----------------
 1 file changed, 50 insertions(+), 88 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 74703362aeec7..82854e94c5621 100644
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
@@ -1305,32 +1266,20 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
 	case IMX8MQ:
 	case IMX8MQ_EP:
-		imx6_pcie->pcie_aux = devm_clk_get(dev, "pcie_aux");
-		if (IS_ERR(imx6_pcie->pcie_aux))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pcie_aux),
-					     "pcie_aux clock source missing or invalid\n");
-		fallthrough;
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
@@ -1353,10 +1302,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1372,14 +1317,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1470,6 +1407,11 @@ static void imx6_pcie_shutdown(struct platform_device *pdev)
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
@@ -1477,6 +1419,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = imx6q_clks,
+		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1484,6 +1428,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE |
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
+		.clk_names = imx6sx_clks,
+		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1492,40 +1438,56 @@ static const struct imx6_pcie_drvdata drvdata[] = {
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


