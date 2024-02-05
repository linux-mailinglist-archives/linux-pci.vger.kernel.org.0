Return-Path: <linux-pci+bounces-3095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8557C84A0D6
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 103EE1F22C5F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F5B4594E;
	Mon,  5 Feb 2024 17:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nqbV8WE/"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36BD44C92;
	Mon,  5 Feb 2024 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154448; cv=fail; b=ODBa031CtxCIbiqi5nw4vwiUuzbirG8HceZfYxZEWNLTY5aKLNQm3yoHA4WMcloD9Cwls3r2mIDTHfSjcOq54MSQnsnS1xyT7yycmecmGC41LkfFFXFKwCMEJLMvRI0E0Tm+LD/cJfvCacsVVUFp0RD7f9WF5C1hJADpESbIr9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154448; c=relaxed/simple;
	bh=/WCajtZqymnhw5/V0jYK5q9cbn990u0e+H0VswsPavM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NjARC6JNs3qT06DJVWkFKsXbscNJuKNwWaPwk39EtmMVc7XRIxBoA8iAtRxq+pEewHtjrmNVIS4RsVtum7HjDhSLl9myYkuOmivyqbq00CS9PKhhASCD9KfF3UyTtPJ49DNlYdbrjKh/tDOj13yH4dRHnBoKfphJTa8VUHObGpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nqbV8WE/; arc=fail smtp.client-ip=40.107.21.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8QwNSy3SDEiyql6iOVUzXR9wV4u7zoIAVsKi1pW9F3/c5lm7ISKRsHHByqZHDIABomMxcYOR7j3p/o82etB0b4YhCTdsGEwtYlRxM7lV5Ed66z71ZEVX0GVQqr9cEQrvcD/wNtJoWRWcgNIZgWRU28Wg84MiRbAW9mxgLascpken92g4f3U7utEHF8geDfHUwP8z+DJJZ66YxP5OlaIdOdBmUB0CbUba45PHIQNJ01vjpw5LatNCu/0qxfUT9QXhsQ2Q71Bq5O0krnVfxXp2b1ZjJpcpnPrtZZt4/aFfsCIQ/s+IhGSd3nYcE+qI7MceG1LXdAy6MD5WHpVfszihg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT3AoHObLkRwV59mO/YDd50SmsQ9RzzhD20yoNCcbLE=;
 b=Y9rqFRe/3IM020R19YL6fXHlF98BUPWGixCdar9GD9BBamLFzQqfR4u6XqC83TifagDm+6MNQoa0TwFZlqWW+Wi9EcUZqaiw6Ppfyo62LhuixT3lsBXejd17CMSvF8fO479vlQe7w2kHksv6YvTuPuNRLF5/b2RXgEc+eijyfEacS1R6jXNTZwk4hee9DoGAFDb03vrAAA0Pl7AsjzeJEWzrmi6HEWDj/Vgg4TOxDxOj7JSznJYfXLpHIP0B/hUDGR9bnp+AlwYZTh8MHPaMQQltkwLTec+CM1UGPr15Vun6hDILBfnU+z2VhqvC4JJhVoV5etxKY5PibdHG/EBQ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT3AoHObLkRwV59mO/YDd50SmsQ9RzzhD20yoNCcbLE=;
 b=nqbV8WE/lQmguaXFfILPeXV4f62rmQFZ8BFAR3PeHiWm0EynZzvHsEKXRv5ZCC+hxFSV7n7esiFZza93P1fdsFx1o6Q8FX1GHe8nL1fFsxh2M0saBqMcQIZ7mNPTRZH25h6FbEKBjxsM6gNVTpLVa7NehvKuE2L82O4+RmOc00M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:34:05 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:34:05 +0000
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
Subject: [PATCH v10 02/14] PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
Date: Mon,  5 Feb 2024 12:33:23 -0500
Message-Id: <20240205173335.1120469-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c260421b-44df-49d0-d697-08dc2670a648
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iOmTjZUHuB4JAJuG1MkRtZINvXtgZOH6aMatamXka5O02445bPU6cTwt41V2uwtO7BIRFuYrSlu/R9974d4KxfjkotXfWv3t6yEABGbgzeKaq4ieYFvmd/FMI8iYLAPBjGHe66cH83Dzws4DJJp1Yoc65+DlnbAPfCPUJbgIHutjPTYDoCrKKhHA0K0VMFQQuJyV3caSko0RhpxaZR/rptP6Nx4ENt4cbqDcejP6/kkjDWCUEafeqIDWFWezPINtK37W9z+6MAIF2Ou7Ikbj7fAb5doqeTID4Z8LEUem1EKvgQMHg5l1kulMSklekz7tYuZUKA7bAKXeQ59UIIK7sB4NM9F4DJoxiSRsOGHzoEn7byjtc4f/bkkxnfkIVufQkppKBQcljaS4Ro5i8vcWxocotu3owOsNuh7q8GBvv8YLTKZBUOFpN5k+cpp6c872kK4oeroTOk2JfyqncMQEPyV2lUEVcRnXwc5IbnEeA4eRLUqRx3OPsS7cLTYi3sx43utgmzfN3CBJYOohgS1ArRRx3DcaUCLJcKYx9bgmy0NmxG554NHwCivLxxLt/lLoZrBsr6nKz/FvZ6Arpqn13zDBK5YtvwqVd6BSP5A6jtpD9yjpPt14Jkzov3vOGI3X
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(41300700001)(66556008)(66946007)(6666004)(1076003)(478600001)(6486002)(6512007)(52116002)(6506007)(2616005)(2906002)(26005)(4326008)(8676002)(6916009)(316002)(8936002)(86362001)(7416002)(66476007)(5660300002)(83380400001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dtYLTzzABipgRgH+0SBW0SYy75oF6uyD/Ld4n9P8wQi2XWBvvdkq/64STsX7?=
 =?us-ascii?Q?DRiBsR0M2G6hIj/ZLgKqAofFUWj+ATLAfJspcU9Dkr8R9U91DB/rsh2prUdx?=
 =?us-ascii?Q?95ivHbFKN2O/hSlqsGiITd+1ruSfSnnaRPEi9wzdTuU2DEL7LDattQM/XXOu?=
 =?us-ascii?Q?ERLKxzlVz1gxYK6Y4yHZoQd5LUCH3dI05zb2Wy97V4g7moQ0E7shI72dYrGe?=
 =?us-ascii?Q?8mRbeceky5EfW9jWIE0rCep4vsBvMJlUFYljgXg87S61L9jk6QHCKeQNT6gQ?=
 =?us-ascii?Q?d/+MPhapECxfM5ZuBh24D1XZXQ8E0dDU8uKYgpMYUzkHRnTpCpfEI9J25/N2?=
 =?us-ascii?Q?mRRA/RNXjXsPxfrqLWIgx5YGFKRhZfNpkrxyyFmOrwZwRv1sIFliyUo1QTfj?=
 =?us-ascii?Q?4if3QhIGlQ6cD1HF4XlakA7Yum2Lpnhl0Aev4QRIN97O4kvc964tNkly+CZE?=
 =?us-ascii?Q?vZ6SV91QRWn9FMfLOtz9AtcjS6zk4nyXqBp5NQywjJr9jyIVrZSfUTB8P/AU?=
 =?us-ascii?Q?/OgwgXAV9n5hE7l0d4eUNgVwf1pAzouvcPM8FoJ8kRXsx2Ei/iu5XemtA1E3?=
 =?us-ascii?Q?FqKYh/QCxEFhVxzyYllBkTibCOGrwxRLGdWWMyau8gwwX+iy8T3toPXdRM/X?=
 =?us-ascii?Q?2eRijtAFQtnsfV4fc4qk+ljp8ycROWhSJqZxGBQNwGsQ/d7M5EuCtC7NBjwk?=
 =?us-ascii?Q?zSYun/0Qg6CBq5vX8Dbr2n7avPMHVDVnoa6eo7w97fNQg1HbUf/M7umu7iB8?=
 =?us-ascii?Q?dPj2oVwxSQGvCjUSf5uPyWJFnhKn1zZAO4YNhTHYYpHq1taR6JQIlbfT5/Ss?=
 =?us-ascii?Q?eglTMpdE2OZRkYnA97KsK2sLEBM0twxdYXl9nhNO7mX+sBO+cTpd5biSsj6G?=
 =?us-ascii?Q?lkxLpoySCx+BrqmuJZDFpnTasnQJVzjXCuXR4RGRV2H9yPq+mJNK2pz1O5q2?=
 =?us-ascii?Q?2CDLKwqT+MMhspGJx9UmWVDDc/yTCNOZPaAABRJgWlgXGHZ7TnZAjabVNzrk?=
 =?us-ascii?Q?r4xBb3e+7kHFKG3zJ9BayQVvEO3de1QFWPtiDd3N8tGX9Cnep5SN+yS4f8bU?=
 =?us-ascii?Q?UGYiZKezDLtBfNr+A5AorUyrcVrSYVbfbNgrhuLIuso1K4XI3u5ExHP3uAGj?=
 =?us-ascii?Q?KfEx+0Ekx0HntIYSKvcl4OlzH2LlkChIbfDwZCN6lUndy/onK0SksZ2EG1YG?=
 =?us-ascii?Q?Lq/uViGCZmc3eNLIxxb47GFTqVF04W8eN+pmrI2PC5p4HiUkKMnN1G1OmlPT?=
 =?us-ascii?Q?VLSdQDX0FUVkdpEl9Ak8a3t/ap5uoNa/OGTngQ2JQlIDtOORqpk6kSiTU9fh?=
 =?us-ascii?Q?vjyu//Vy6SddBCfuvjO4UA47Us4diELnqEWydmR1cDSIGb+PLGM5w6PXExFT?=
 =?us-ascii?Q?aw7Gk2bcSZWYyU6iW3wHHelBFps5s+jTdIj4YJUn5iWKx78jPXHuR5ojy7G8?=
 =?us-ascii?Q?AqUiZ1iss1LhOQp1oJmKryH8Shy29sdxooTbPgPwrRoT4GISdHwEEb36Nk1P?=
 =?us-ascii?Q?m15d5nVgMVEmIUvNqolVV4IMlsGuCQUWrZRVP79FBXlUA5vOl5FxQNdCSyao?=
 =?us-ascii?Q?I4Z/fVkIGB3f3hV0EgN3H7a/LBvuPc/m1o4Qx3o+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c260421b-44df-49d0-d697-08dc2670a648
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:34:04.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyOsE/c34/mfb0LT58HqPDLRecYIaip9xvGiiJnrMO6hQubwYxB4CQCW+bRfi1Riw4l7terqRC/c8gT//LttNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

Since some i.MX platforms make use of the separate PHY driver, use
IMX6_PCIE_FLAG_HAS_PHYDRV flag to identify them and get the reference to
PHY from DT. This simplifies the code.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9:
    - change commit message according Manivannan's suggestion
    - Add Manivannan's review tag
    Change from v7 to v8:
    - renmae IMX6_PCIE_FLAG_HAS_PHY to IMX6_PCIE_FLAG_HAS_PHYDRV
    Change from v6 to v7:
    - none
    Change from v4 to v5:
    - none, Keep IMX6_PCIE_FLAG_HAS_PHY to indicate dts mismatch when platform
    require phy suppport.
    
    Change from v1 to v3:
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 82854e94c5621..59f117f855c26 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -60,6 +60,9 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
+#define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
+
+#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
 
 #define IMX6_PCIE_MAX_CLKS       6
 
@@ -1277,6 +1280,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHYDRV)) {
+		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
+		if (IS_ERR(imx6_pcie->phy))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
+					     "failed to get pcie phy\n");
+	}
+
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
@@ -1308,11 +1318,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
 					     "failed to get pcie apps reset control\n");
 
-		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
-		if (IS_ERR(imx6_pcie->phy))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
-					     "failed to get pcie phy\n");
-
 		break;
 	default:
 		break;
@@ -1456,14 +1461,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
@@ -1477,6 +1485,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1484,6 +1493,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
-- 
2.34.1


