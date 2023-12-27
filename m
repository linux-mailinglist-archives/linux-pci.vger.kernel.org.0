Return-Path: <linux-pci+bounces-1454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F4881F139
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF381F2116C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0CA47761;
	Wed, 27 Dec 2023 18:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZbBE7JFV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521C547F59;
	Wed, 27 Dec 2023 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/wrnYWzBXWArttmvLKxi3yRDPvMvNmH6aFUMr/tuY8pGg5+fmamknEns2yn8xYVNdN42PZ4rRUfpDRdjjedqfvmtct6+IPhJ2uNj5TUBJc1yJ9JjPKFlSPO3AasLYm4C3p1TklRpk3musbsiX/RIxd5RIHoW5KaL2KziK3/wl5o54lJJU1WAI/sDxiJEFgNpSpwEdELtfZY5MlxL15/mlafSKMiuG2rdyCHcWROdojLswhEecdWJN+FLSOKftpITNxlxdE7TteBbduQq2TYj0dQMS2mgoW8z7PDNiUhKaBRVTcejEHK76j2Qw/0rsr7CGwRE/3tJekBsbH+qW60xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mwdd+DiAZ3s7dB+tmBXPZ8hiA83HBFxwkXxyNbl3QHM=;
 b=b5ChtR1ensu6ie9S2Rtxwls6LsbYghP6BPoJnGouwBu6zitLBT7H6AY+JI++rU+cC6zYyjXCsGA6QuNIwe2rA5W+UeW92kR2tR9ywXWhST9rzhQILbw+yep95fJdykJujv97S8Qh6TBn43wZEeRiaBfLVMgK7z1NdZ/AR+Q8qmstpN19ueJGpzccOHcoIrBz+V2UBwe++ZAfjZAaESX84ot2V0q3kZB5BItGGd22VO/x9khjOdPSez/QkSZypeelu2tjHVbCHsrUBJOif/XyDxzifpA5jKu5fMnapidpvHaut/RLb+3MXIPWvXXwN32bplHa1m3HAGntsmGvOY2mBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mwdd+DiAZ3s7dB+tmBXPZ8hiA83HBFxwkXxyNbl3QHM=;
 b=ZbBE7JFVhJO6wGoMxXxHklAOobo1bWHxn90SPuTnbIzYSt+AtpA0ydbzybcbKl6Vk5ZKlbaus3k4c+0cVRqsBoPfcFXfCPSIWukE1shUuTMbfdMwNFOTDKVkaOeuIs5vxVRgz/WCdEIrP/+iCGPY3vHO+PWtzxmRfk4UQn0uUb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:28:00 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:28:00 +0000
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
Subject: [PATCH v7 02/16] PCI: imx6: Simplify phy handling by using by using IMX6_PCIE_FLAG_HAS_PHY
Date: Wed, 27 Dec 2023 13:27:13 -0500
Message-Id: <20231227182727.1747435-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227182727.1747435-1-Frank.Li@nxp.com>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: 4433da78-0951-4cd1-87ad-08dc07098e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XLi/DPC1XElr3fbE0kfERG/bgWdJKYvwq8lBke83xcuAItwq9fg2h3QGHWNP3xBTW4yDTpRz35D11Qo0SuYDLH7L6dLOGT21pPf1TFgkiScMpAqNBiaqYyxe5ctSAGMA7ugHnrMOAZgnind4IDO4GAt24IxCCa/Ji1InFdg8Yul6gA4OIoBWZO7MUvBclpM+wjzmCLsoqoUW5EwjufEJ65MXw0Gx+wP9aCqT7TXj+vv7NB7BG3lZQHzaMMoaXgwgj2D8Tfm76muy2m+QK2YBmnic0LVUD/gHCY20DbtvgqzauAS4ohhuTksBRL9V3d2pBqw4F50rm+fCcJZ63pPPjWaMTT9qPfUDBGiCY3PyJp8pvp8ehZ5gwEhDF5YJKi22ePT1RzBrA4CeqdY35Hg/q7VJGGHSrmfO+eI1aIZ/kbPcovWiXTI0PHzPoNh5gnpNetMVPNORvuU/C+Trchax/Tf7iNsuPordq3xXqd2pehwU/aBp96IbRKW0+/fPBs/LYGppMGrTCgoxU+hc4sBrTCpS/falRil377PgS4Qyl/VLUpgtyQT02p8vL/uhseaQpsYP64n5oV++LJUFPY1UfxhC2da0J3xvVHERGMy1PYU9io8UImOKiH/URLwKNRr9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BtAvRiQxKoFsrNlmQVrWDWVlNRAghzmNOKZGha45FySnZUFBQuv0Nd6tElAU?=
 =?us-ascii?Q?2xGaNdQicM015Y4vEmkWCeq/YjWG3DU/1MDi/4gHBiy7R9TA3yjJ2qyPPDr+?=
 =?us-ascii?Q?AtHURqgh5M4JWaEF5/rZ9sLddhAGLQWxbBPzE4vlNbdn6Vk9uJ2YeHyPzBI9?=
 =?us-ascii?Q?wTB4uDvHLYkLPpPVHPnLCnLLgL8NVfa1SxS1tsVuDUnUm8AloPY5hyfikMea?=
 =?us-ascii?Q?RLkAGH4zDh2o1QIX+Yp3iU3A/f3mXZQOZcAbseO61bGE02OBuACKNQrfzjhs?=
 =?us-ascii?Q?q5AC7umR6pNPLuAbNXcr4kYITHIz9WKLkfW7nRJB7N/nSPkJffYftnpS5Sz9?=
 =?us-ascii?Q?86PpkLkrzfVopUukRWdhIzJWsE/MzZL7+lyAOIWL4wwGIalreOhK7LYCsy/Q?=
 =?us-ascii?Q?6bcbEMFssCjCZjFondSJeA888pYG+PFXdqP47qbBFtNLUFpyzb2l+3d/87EG?=
 =?us-ascii?Q?PTCh8FRdJOhsDwlnLS7jlTIThb94Ev4rn+ha+jrGJfW342T0iTwuzYy8S2HV?=
 =?us-ascii?Q?oF78Wkp9rFHDQf8isey/eJFLLnvGri7O5DczgS4yGnSHPVfhnYVSzaAgXfeE?=
 =?us-ascii?Q?/hYvoUIZ8EfEOkD531B0956v0Gn1SkgXanwCkUxExhs5Uk8rK3eX7q0QHxrT?=
 =?us-ascii?Q?8YduaKwojGRSmFvXlYykSSU+F3I6d8BIgPmTVD2tl9bqqTx5inJoH0uIjokf?=
 =?us-ascii?Q?6SIexbK1z6LBdu2gTN4K4tcQA7//52cOHNvQR3xoYKe/aba2cawFjo2yOsA6?=
 =?us-ascii?Q?/TzFazTzrQEMx8+9i95FDCscoAmpD4TytG+tlZwdVuW8dVJwzWbrHOIC6EQc?=
 =?us-ascii?Q?xAGjdyfPuX4fWDjQCecaGsBsSRGwtPg0wgFOsxG3Xl26nKeDH5Q+SwBnr8ww?=
 =?us-ascii?Q?Q7D5RYrGqnjHpG/gX3fLGkV/ypR+Khs2FX6U1fFuowfFjybAWrsDkt7JikNY?=
 =?us-ascii?Q?dWUevh4DO1QadllhiOvtvgV3gQzEtwjesXvkej5rp8jHuRKHcd72dlWOCOE6?=
 =?us-ascii?Q?l5skmGj8FW4P4YJla+S72mWjIArF29ljejdPkzccplUFQD9HOIZiEBZYenbe?=
 =?us-ascii?Q?Np/Qv9F+XJyJ9fVBIDy2w3pfsu1Klwx+4xXd2ChMqda+5itbYVY0u/OPKip2?=
 =?us-ascii?Q?g1qFJgYRuPJJDrDmlukoC+qUIcRZ0dDeqtyyK3YbE053Vy4RmZKlryIpyOtD?=
 =?us-ascii?Q?KnFCmLp2vrgXB+mZguE8nM2NAQislGg44yf0ySuczmdI+6iqV7DnadZ0Xmmf?=
 =?us-ascii?Q?KURciCIC0ziSGUdU9iZNe9hq85HpAlRJZ2WKwJXYStAITGZQEWTMDp6f9L2t?=
 =?us-ascii?Q?2fzhB+4qwgi2eMS5Izu9y8oMLG8RfB1054nFq/UTg6n8YRelNAsbBhyxZPRM?=
 =?us-ascii?Q?qCcd1zvsiXbGo25bykjX6ZYB0A5zu5LLwp/2uX/OnEVUQLHZcuryCZgCyWeG?=
 =?us-ascii?Q?8mBjtL9aLQvI1CsEX14HEhjCX2qVupQXYjT7MsF2KpV5O8ZrRRtlNk6a2VjC?=
 =?us-ascii?Q?HU+JXtVX6W7WYejkGMJUmOH87o4VX4C1SA+lLxeYhC6gmcsPQZ1bRRcTWpQd?=
 =?us-ascii?Q?4Cr9oQ//YfK03Eyu7Lc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4433da78-0951-4cd1-87ad-08dc07098e0f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:28:00.1915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0VLNrNOedlG1hJFrvsJ1sZxbdLxrn2ocsaeElti/S3dbI1734rtSJTspIG5AW7JE5l+49YqASU9V1LqLeMNSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

Refactors the phy handling logic in the imx6 PCI driver by adding
IMX6_PCIE_FLAG_HAS_PHY bitmask define for drvdata::flags.

The drvdata::flags and a bitmask ensures a cleaner and more scalable
switch-case structure for handling phy.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5:
    - none, Keep IMX6_PCIE_FLAG_HAS_PHY to indicate dts mismatch when platform
    require phy suppport.
    
    Change from v1 to v3:
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 50d9faaa17f71..4d620249f3d52 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -60,6 +60,9 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
+#define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
+
+#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
 
 #define IMX6_PCIE_MAX_CLKS       6
 
@@ -1277,6 +1280,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY)) {
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
@@ -1444,13 +1449,15 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
@@ -1462,12 +1469,14 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
-- 
2.34.1


