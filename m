Return-Path: <linux-pci+bounces-3774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62CEC85C103
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E881C23380
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B3876405;
	Tue, 20 Feb 2024 16:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="guC3oY6D"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E01763F9;
	Tue, 20 Feb 2024 16:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445999; cv=fail; b=beEiC+ZPaUS6JWiSAdk1Zkgnx8ZoLuXQCc4c2vzEr4On917fZEkKMdjWPPsCsVTsGF2iqvtgW4svBwTOw1Kg1PLkgLiE7zANMtPxAz0WtCoj2P2ISzVrNMnfM246Qeo020UOj2Ro8rhiQD+WpT8eqbrMG2oCFaRD8a+B5YVQmZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445999; c=relaxed/simple;
	bh=vMb2sWNFRJMLzjqJkh5wdqpnEYYbvQoQpd4VkbIK0/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Di7AEDsdTA47Sd7kL8GrmP7XSImy/98Hrkm0q7tg6ugrVuULOFFtGN+kg+9jas2+k2471rKDEUFShL5RRnGv6Wmz4nP1sRW0/vEeWzXdYYfaV3bmVqxldQReaxNfu5CXckcXF5h7tGQpi+Ue0ioIy+WGrc+iG461KAmwVKMWNXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=guC3oY6D; arc=fail smtp.client-ip=40.107.14.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAGpkKz45O/NdpffbguVKskfs+52WCSbLDywVIJ3J0ekT2qnkhYR09IVRyRRvAafG4d97o7Scwaukw9hfpHMLKyW7++OT+fgWpLDb4wJDFk3vlZN2jPSRDcsWNVboSU6yJFaP7cXQ0HepyPBKNfM4Co59IjnHes/WXHYFTYt07o1EAvAwqit6ZMSar3H7MXGATQ/aoAlb5j4t7AZ9N5rjQ2S1zZyd5up8s4IBu4yv8pje/YGfoDVFjfSvDcuewv73CHh5trddLkOKWTIv08qf6RRvWKuFOrtgxZhq+szJsx8B2u8GNkH3qt4g54592dWABReS6C6Te7fiajIhGqTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rS6wW61yn3kurDuZwq5QX/CloU3gxnrv196QV5S3B2Y=;
 b=Ei9IS6IOOXvDNiQQmFPDKJ9L3XN+0SIIRP7k2QAfFBaashx2nLPo58fsMFdSQgPfL22n5Qj8cHcTQQMya++Jpm4H2f/q5UEcxjOdOJehRz/m2G7Z1So8NJ8oqh30wlQ/Uk0hdszFMx+ECc0cilnTNz/zLYX3P+ZeNjdi63s1lAnczE8gog1Zyl3X0OAnCT2Qe3E97nf9kzhcfdftymgOy5SD03F41bmOCxnUcBxEt87OjrG5OfxP6Mkrj6TSUlBYz8+5mKERiOKfOUpGQtS4PqfThpj+EqRfUGfU3O+EJ8KcRe0E/p6JL/WxzHiJyzjQhs7g+hSbbfhQF8LWGxeOPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rS6wW61yn3kurDuZwq5QX/CloU3gxnrv196QV5S3B2Y=;
 b=guC3oY6DN/wlJFpJDMx/4yH+jD4Yn3i69270C6VzFVz2Whp4hqjGDX3h8uB+4MCJRVBkS4ihhyNAVzU+C/MX6vNtcYxcbeRCgd5Ys8KeDXr5XrYR1ukkOlDfSK5SMccOXlvI2aw0h6zcuF/wcYvrVThqbVz0QC9mZjEBX3n62Pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 16:19:54 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:19:54 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	cassel@kernel.org,
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
Subject: [PATCH v11 02/14] PCI: imx6: Simplify phy handling by using IMX6_PCIE_FLAG_HAS_PHYDRV
Date: Tue, 20 Feb 2024 11:19:12 -0500
Message-Id: <20240220161924.3871774-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220161924.3871774-1-Frank.Li@nxp.com>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: a428284f-994f-403e-7f1a-08dc322fc5c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+0AlcPw57tu7yBJp7dXvevwZKBeFvcz8SvwO9yjXWiO1asn0d5A7AufLwhKjg7oCPJrfhms4UVWAJLrmhd8rNHTyouJkK5OOtAGjgJHlqKFzrszMJqH+2hCz1Saw2x6xYVkUl9Mdx6cCEMxoD35JgWrmu1BY8FfNhcS3II0CVYNPsu25p98AH+xs6A4QkAWHqlwP9hYnS8u2tst2dMgjhfs7vxvpIdXC3MO/47JOBcm0k7GkeeBhbBLNU3t8zemUPITIV2EdK2IL1wTBlG3cOWE+TfqxnEz/1SRbtrdIGwUCj82E2qEQDA3cgVwA5DV0ejFTz5Z26u12JNbIig+j47z8Erp/0BQ3HwnDR4RLCaZ0ie8r4EQSVnKzs0HMr2bRLX9nSyIFy6rNVDY3D1rdlPNOTlWwIIg3gUHnKEj0NvSUNerDCZhnl9eAUSzbqhX3aSf8tyJHpywVlHy5tp1APtcnTwNzIrXwSfC7CAfQwkxn+WtP6jQJdfTR5mjctwxakweJH5DmiazBBawCN+WMV7yTZefqrA6w9kpevdS33//tup8SI087VWSMvKfsk2OcyCGJxnX3QBMbZJJxx5xNS0+g/XRBu+Jx9PdITihOTK2oy94EpaLRDh3gvVu2jOZM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fAc4jgRit4jFx7mbnG/Qix+z9kwRBm1Va7iVr9SjcwFs9NsXpwtTt8TEF0KB?=
 =?us-ascii?Q?D9puLlJC1mXRQmax/fJhczf4fZwPVWytRFOcUcekGXIIBdQJdvSS7SeUXKJ6?=
 =?us-ascii?Q?D8xZ00iM09l6k0H4GGJAq5ph/rjcj6be90Nv80UaY3Jc/xuSvLHonBdAyfqq?=
 =?us-ascii?Q?IUW5sIympkn0KMj8BCsAqNQc+1EjkvdI/SINEPZoxwil2kNrzVnCdaobfu6s?=
 =?us-ascii?Q?g+XVg+WNK+xNzgnjNe10UE0e0wrOhJ/0u2vdpmwXBA1gbIgszalaPbDTlLoS?=
 =?us-ascii?Q?iahuhKFFN1BPm6S/2x0yxRQHU43ken647sHGmyECQ1GDtCi6yK3Myqt0MW3t?=
 =?us-ascii?Q?H0CyRB/A6flVIwlfyC5gAnI9Xq03axX08molyrPga1KvbFjYeokSyjPWFfGL?=
 =?us-ascii?Q?o2kIYB3dWQGyf11aV6w6wybxhmYBgOlSFe8KstC6gTFYL0zF66Ysye5wbH6U?=
 =?us-ascii?Q?wZBoUMyGjBvNazlyg12wUQOW0Ey15/h15C5WYWa6rZKWIiq0Kp9bUWuGadp/?=
 =?us-ascii?Q?GdyU9E0kEd1s1N3tW8vHMkT/v9ED9RF/3c4Qu+Jp0QCzSumylSOxofS/P20O?=
 =?us-ascii?Q?QDr6mCImIPdeNFPRaIUn2cPp8VGpHNTU+hrwaYvch9ESeeD43c8tn6cJwQh3?=
 =?us-ascii?Q?1R+RKhu+HtsfIk/UJ3hon8Qzm4P3oDrN1TxP50AeXFpMS7DHu/2JoUOx70BM?=
 =?us-ascii?Q?uTz15XrjSBOVsTgBN1hJ2E+1LsQGnyipRffC/IbA69MEaUNy1Bl3kBXFIsRb?=
 =?us-ascii?Q?7Kdqjt7EEytNhaHegD9gYY0UAxe7g5mfgNxVd/O9Qbssafh/ep2MJBlpo2Qp?=
 =?us-ascii?Q?qni7RJ7dmIAXEV70N2pAYRJ8ENYHtjONBj6QPOUjj9ZWyRw6AuPOP9THrjLU?=
 =?us-ascii?Q?iBH9aOpFkUfMJlv1md44mmbUB26IlsOB1j3pzRmQtYFNYXjzm67YLFT32+9L?=
 =?us-ascii?Q?XQ0yR7iPm/igtkAPlXGx14Eu4+6yThU9bPhSCq2sG3hoc0DmizVEXdFPeDX8?=
 =?us-ascii?Q?heOxXXQ3yxE/Zq4LvvIhv/377z54esAy/DC3dDTUMSNzzBoC0hsWvNk9FBqJ?=
 =?us-ascii?Q?Z7IGPAxFIpjP+OSb9tRdVh2En8zGnvfg/kucaGkcJTYWvwfc8TY6VfV01yOi?=
 =?us-ascii?Q?61272VK7gzqDIUNl86U5XqZqAWE7uYyQAH1SYxoHpgpRoZLUO+votmFWeLbk?=
 =?us-ascii?Q?nMmchWGx7OdhAst+0T8VSwyn0rWh7s+m28Tp58HsFjGaHRzENYl8GIz0kO5U?=
 =?us-ascii?Q?L3xFz7bN2+HSC0qDTLoKRsJ7etkWCu2ka2Z1pfTn/QmQvLTWtIOzkXUIMNvP?=
 =?us-ascii?Q?w54lM34mYWZIJYR8fGetY0BbqIfNKi72t00pegg+ApliEiIZgu9yU3BpUZGE?=
 =?us-ascii?Q?V/KhmQ2f6ulimHTeFry1DZZJFXF4rIDWZ+J3aIwJFwqm/WX2ebmBYVJY8RSv?=
 =?us-ascii?Q?jyS5NuaP1y7L6iJMbykRXYdCWU8rZk86az2B+Uj6sNn7ccn1WU28XfPoIIwh?=
 =?us-ascii?Q?vXJVSvUePDx5Ms0v8VcDNHlXZwWGAHBbewEmtNnCOeuApjDOvrTnqMNroeWx?=
 =?us-ascii?Q?E5Mmi0sh/G8BivHwSqmoe1vawlK5iUSnK0AB0px6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a428284f-994f-403e-7f1a-08dc322fc5c6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:19:54.4103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcdpCD8yPGMJYjRkD14IPaBRds+x7UV53PmkgOeQ307sCQVqSrCL2Ygs2emvjxBJBGUnzP7ca5ywxACCu2qduQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682

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
index 93c304899bd6c..12a2bc76f0b39 100644
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
 
@@ -1278,6 +1281,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1309,11 +1319,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1457,14 +1462,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
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
@@ -1478,6 +1486,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1485,6 +1494,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
-- 
2.34.1


