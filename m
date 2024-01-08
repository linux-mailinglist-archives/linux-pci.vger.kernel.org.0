Return-Path: <linux-pci+bounces-1840-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72705827B65
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB902B22B5F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B46A1DDDC;
	Mon,  8 Jan 2024 23:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="il7FVr9O"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A29556B62;
	Mon,  8 Jan 2024 23:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7PC2mPRZX7onW85meibs4yCDulraaWBIp/j4feVs1lo8/5rek7uqNEOc2NngLZh8IF6Q4xeDvQ72f0EqNmjWopGJKHY4cDpe38IuETeQIBH+platrWbBPkSnK7mJkSTpvde9VAQHqRgXNBlyvU3TUQvTgsTfqp5bEb1Tg9fRLN8He6JbsZ24nEJa62U8ev7nyHCQmhjXdFXia0XlXGndRM+lXqx62avgW26w+2+ILP6Q01uf076Bs7FDTtWoH7qWSFxP+fwvGTwtjXYYL9Fl0RBJV4J7jGQYNDMYzAbDjTIOpBiqwJUcZ4cI+UgAJl6yD7srRL1UEl8Ux1Zv2c1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A1CrNRT5ctZHxCjcDQCzV3x7HL/s9hzwMWdep+KVbg8=;
 b=lzpjze1gvLr0TLsyNQW0kH4//5GsZw92gAlL8gL9Pd4fPtL6IJvWlV3thCSX1RSCLGXPJf9rHfIC4QbbtM/tidc9jGOLU1Ra0Ssfdm4dwOYdRBFtszWjIQ+gAn90Heii/knOoJImIOC2+nICV9D0MCnelqQdapIqpMQ+FmqKDYJFgJEt9HkoHxfm6+lBR9i8fsLsaupBG7GK+V9WlPnJkG3G9RvC58J/1AE+mOzP8JCJWriCrpRX3AVXzA0CvpC/W8BYV3X4YmZtvcDPM4TzFaK/au+Ek5TaRVMffWjmQjEQvUvnYA/0CwAJ9lvmObcCD0i4NRNKGLt38IOC0S8OMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A1CrNRT5ctZHxCjcDQCzV3x7HL/s9hzwMWdep+KVbg8=;
 b=il7FVr9O4/KnemcOXtoOPjfEm0ogs8cVxLnFkuKMRHPT70hCIDMklVXbPF2BAFpyk2X3JoheH67yHpihBSIdDNZAMgNv+0yP3+jmP3fTesps7MFt3R5OOskfxPG6mYze9yl+tu0OnjkAgqzKfwGruZMKcY8yBP8F6Exsvf1sQAI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:22:17 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:22:17 +0000
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
Subject: [PATCH v8 02/16] PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
Date: Mon,  8 Jan 2024 18:21:31 -0500
Message-Id: <20240108232145.2116455-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e04d9f69-f39d-4d90-067c-08dc10a0a6e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iu10UdCgxHFVQGu5saVR4g56XVj10Ax1N9EHFghALJPJKFbzjQTQSUUa0pF+Ra3xFoJ4Z96ajSCMJBFqHVX3CkFMn2+t/r55IA4NZLBYHFS4q+J4QH94WzTP+GVv8nam28tm6Bsj8cW288hhRNgfz21kDmOH3JifFRB7U9mvvAu+e2/K3RoZyaijrR3S9JwCUcrcSPh0QKhzwJyvZniSdb11DxebOEdLe90ozu8TbfuJY0qazLF2WQPG6oDmwZsHzVrlVDbwzthmPYHhGfU9RqpS/SrGQvQum61u99BlfRndF/QLHkmy5rju8y6Qz2Nukk/lJpV2JUQTtyk12ISRdBqgerbQ3feRnJRIvixQ03bplW443Pu3ViCif1QGIUiqaE/6AWWmAMPOb7RUpGIcsA2xspmtX2BIcJ20hZLNujJsCs2ydM4FC9UrTx2jZnaE5dhpgWTgIR6joQOSTEfGETjayxO6MJgdmhmS1Tm//AJIVAo/UuGUEwpYtcURFUPXOKIaBYi8HtVvwvU2CIQEfnRt3kN/bBPl0gGF7tCF5YcKZqMKQvPptSzGoSz7Gl3t2smpR6dbEWO9e8A9gze1i6Prs2hpiSYHlKai0zXUvjyxRISVfORcgooHO0QYWRG/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z4oKPe+0lXs3PsY82DGNjeLGGtpGO4xcZwuWrkbnnVYs1n7QPhER7TLoX2Gs?=
 =?us-ascii?Q?iP1JTnfsu/mibegsYTf6A8azNqKgw4qv0c3TTb3giY4ukO9/UCdOyiRHyk8N?=
 =?us-ascii?Q?i7DARdRNqRJ16Y7gUc1NzNeYPiWtb97/mdRJ6cTqQVFpQgPKzsRB/SxV4+1y?=
 =?us-ascii?Q?4qYXthmKWHFzviU086y8rvrNK5K46/S1r4dNy4tqdCZU8sjUg755kOAJEJK6?=
 =?us-ascii?Q?mfBppfe+OaUn4ihOaBnXexkrH3Mn3Aey7ExC4uoX3gnxZcFO47s4Vjz8SPaz?=
 =?us-ascii?Q?GJBG17bCRowjZrhQ5pcj1J0zq6ozKrZFOmKIWdZe/wzGOvJx8cgHNj0ZV58E?=
 =?us-ascii?Q?yG3HV8iMqU1mlftj2zZvuOcDjm92z7C0G4ljXvyZ5hIvtlKO47rXj8v1KWTS?=
 =?us-ascii?Q?+Koayq+pl2+esU5GlfSwg34/YkmSGuNIXeb4lOExLDsy36H6AHItboVCysVb?=
 =?us-ascii?Q?q/U9yZW3xN2SI4Tf7Qp52cHfPISfmwX3oVDTvPSuVHMO3wRwKjaAOUUI9L7w?=
 =?us-ascii?Q?AAEs1ptZWleKjzrA4HBF5UEER3tp3pD88UwAogk74u5RTkCUxUHMyKuIcTFr?=
 =?us-ascii?Q?SgaJMNkxG+bOU726C+jUTX03qZAxJGw/FgZx+8LDUi0q1xb2SdhHA//hE1Fk?=
 =?us-ascii?Q?ebodoGUNVyhKBzbUtIv1yGZbu0JiUFix0A8BVS/nQlTYoBTcggrcJ5aKxBt3?=
 =?us-ascii?Q?GEAVbqxFjQDu9IWJC+24bcLHjzHEriFlDyZrjoEzy5dSje4YVTbw66FQVAkr?=
 =?us-ascii?Q?BX59ZSIEbX8LPsTEqwNXKAEjPjxv2PN/bWxRwY7FRC/rSemj6gpG//969P+z?=
 =?us-ascii?Q?2CuSZcDRjj5FxJ/gFs7h3587G74pD60SPFOSgBhBn/hc8iPxVcKiDfadBaGt?=
 =?us-ascii?Q?yIh118X78X8n25dH8OMJYqyaYyR7D0s/lwmm7Ip5NqedTAn2wfHOawPCsXAD?=
 =?us-ascii?Q?kfet8iJjpu9PFiWI4aKX61hfwN8eg5qYbzkXcb0vSkGFcjiPOaQQfeeRbP0i?=
 =?us-ascii?Q?ZASt6tfRydnzKhbf/HJV7FSN47f8p6+ku/AgU5P0mdN6PMBTAjazNNc6WxXA?=
 =?us-ascii?Q?SI4gLL8BVVd49tER7xF0pKuZEty67HCCzXymzXrHhD1J6zp2UVXHgX0y6L6v?=
 =?us-ascii?Q?8PDct9Cn0TqQ5pFLBQTAXBqzslMuO6WLmeS+Ka6lym3gw7RUa3c6vw0dyRS2?=
 =?us-ascii?Q?ok0D0+UR5wpIIbraHWUfQkzzot7WyLokTtZCBQWU8xqcehRGcKAFi/fymnT9?=
 =?us-ascii?Q?IC9hnx/ZuyK+CNzhEG+HVSs2TLM/PNSQ3rjFfHkVtttStmAy6onj4P68QeNa?=
 =?us-ascii?Q?gshxV3nQsPehgsBZfSRQX/aeRM8vPK/SgI/sVnI8yZBGIIZCN5W+//AWtAb5?=
 =?us-ascii?Q?ljmrkEiqNV7mj+E07z1UaVTh4yoqQDjgynlH5JaZSn9J9J4KOuAa0JzSXJp1?=
 =?us-ascii?Q?4CEDoYsQQ9LJfaPiyIafc5Wz8UBeQtLtY2ezFxaNuecsv7fnRGbbI8latGmc?=
 =?us-ascii?Q?tJ+UtigBtr7o69EkELr9u16uHhF1virGzLQU7YC2xLg5/HJcNFlqFzfh9Lf5?=
 =?us-ascii?Q?QNSpRihHI2JRxjSG1Mn4tVgZAmogdqXYHwRR/Trn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04d9f69-f39d-4d90-067c-08dc10a0a6e4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:22:17.5591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RSOTKagLjGSEaHLXPOwKz4dqPkwYiaMGISxmkEtb3/zHFPkqX2/1BafsoICOBKT3N0F/XkrJQf0vmdZllEZBSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

Add IMX6_PCIE_FLAG_HAS_PHYDRV bitmask define for drvdata::flags. Reduce
switch-case structure for handling phy.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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
index 4912c6b08ecf8..adc90099ec7f8 100644
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
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
@@ -1306,11 +1316,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1458,14 +1463,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_aux,
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_aux,
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
@@ -1479,6 +1487,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_aux,
@@ -1486,6 +1495,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_aux,
-- 
2.34.1


