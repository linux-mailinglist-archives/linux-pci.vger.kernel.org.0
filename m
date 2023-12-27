Return-Path: <linux-pci+bounces-1455-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B51081F13D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05D64B22675
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA33947F72;
	Wed, 27 Dec 2023 18:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fgO6asKJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2089.outbound.protection.outlook.com [40.107.7.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A214A47771;
	Wed, 27 Dec 2023 18:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1N9rD/QYhGQq0LiiPJDtAScB/31lrsSqjWVKZqdBtuRHvzaABBPyy/ja9TLUDuslWXV8DGfdQY6Kce2AkeJJK/tPMxd5HP8CcAsqfDmnYci8y/f4kmFF67eodaBWW8qsgDRJ/EGONr8zmnPOHOj4A6crTLxgMgLfYZGu804LNJRsiCfjXh3LTDHMbkz4FuHo8c2bQx4nNoJJRuEzGLufJb25H7aSxruQlcO6afXDPNL5o8lrg97lcvr0gN8JxDY5KCfYrDLJEbbOrNu/k0ewbuxT4y6hEqJ064mCpH25I4BHEYI3DjL3FcF8FnUIh7jpBC36L7iuseDv10lDmZW8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx01HvuG0xZ04g5Qs1emA81XcCk2ClpOFDJT/IqUaUE=;
 b=FDsoJpjkkkVnXMY8E2wuz3GMzmFuJF4wV0DhL0655leXFt6KiU1g/7D2D3NRJtLyWPjg4hqXPCKwCtKm3NiJVl1oebEsnEB3bNoouYFzsBml9y1gc9Mm00OGn08PNf8wi9Mhzz/fjo1K2xhSPeKc7vMOma+flzi/6nbrPpLpzRJWYlJZ63NKXlrFKrTQDeM/oRb6LxtInNLc+hAh9zcC3r5AY5CTE4YjbFeplpddKahDXykmAqkOU5ncX9cDSTx8Mrxq7aEO38gqyBPYTp5Zkg/wCgyWY50QeNkuK5iE0JxfVFJ8I3xoxssHfZZcRhOCR/YDQa6rqIByHnwRkhwfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx01HvuG0xZ04g5Qs1emA81XcCk2ClpOFDJT/IqUaUE=;
 b=fgO6asKJ67uEFxYYXUVxzmsou9sp7JmdpAYsLl2vhOWiOgx0k/AVDzVtXdq3ar1QCI9aEq5h4xa1gY+7lfeucosH4M8VM65shLEEWIPKo3jRngJ3AFMZiCawSA800uTg3A1UpE/gRP8vAbscjRPNd42vIOw++GpTiavCDP5tk6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:28:05 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:28:05 +0000
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
Subject: [PATCH v7 03/16] PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET
Date: Wed, 27 Dec 2023 13:27:14 -0500
Message-Id: <20231227182727.1747435-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6e641f5-cfe8-485b-120b-08dc07099146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zAnA8Gj3TRLWmnqsrOeteb2KDzFslKmLtO9jo3umbneI+poGkbCc5I2PW5ikNQqaJtDYXLQCNUAlXBJKB1ijBf1PfTuNwgZRc3QsHL1OwvqZH4J7bfGJC/+Kf5h0vto3R85VviVSSKcmSsqzj8EuIhjBWu0xOh2zWRDg51PDA4BqM75W6TxA7vTUTNrsB+4li3vBx4F8RA1+w7QKgBPK2e44R3jWgF2PaeGIcAjGKlKNoIyjX1nbTSg0xSPpSyMuY3z7ee444Q3PgRQno9h39mdGvqTb0/2R976Hd7EQOgE2/auQbn0j/1WzGiDCGQqUk2pneLgUPnIW0gSF9dwrgbqRIqOQ4xvUCwYTlNfjOOYo3pZ0JQiKckG8AP589Ckoy4P5bZja2tT4gWjxnLlC874W9UIeK+6qfSX4JsQP1kf9pwH9u2p0ZgCPEzTMBwmSx3MJquqrayQfkWr0LOwgkavVLZW6giw2Wytn+oPpiPESSCyPwDU4WwFf2bvEES5chYVtMARXgVZXKOH5owq2XPRD8gde6cELYeDdZibHXaKqMj6eEF2p3Z9Jc2TP7xES0FINXt4kC9q54VGETcDzc5ScQQlizKJl7bWzB4C66gcm8/M5/VkIOqxs3fYnsRVx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jqoyXje/A5JaC0aqxXtpNBaxc/EpE23a8eyMnDeHQTAWIkh/X0BmO0F1VIcj?=
 =?us-ascii?Q?cGpHXcs8xYjcF6OeHyqoyQ/HpHOax5rvogLgx9IAWETID/8HQGlsI/mkq5M9?=
 =?us-ascii?Q?b6dE+duKF+N3ADyB/tBrpFdj8S72c8BBi7Wg65+k5Xlv8sxZkZZzi1cOC8v2?=
 =?us-ascii?Q?LVtY5Hi+SCzO6Kt/NQcaAzjWzmCQX8GsuY0cB8txvzBKJFQm45E52osAv5pu?=
 =?us-ascii?Q?FBjEo1E8D7kvrjALtWPTxVtqvYEBdPS8AEI5BKtsCNIxQOSLZfzhmAm5pmMI?=
 =?us-ascii?Q?pIlY7auAlaNbPUFoAzpqPVmTktwD1BP2FUiyp+M2K+mpsnTEBrVU3Suck1V7?=
 =?us-ascii?Q?2P6xlyx1SFj5zGDoMwqzKkdDvyQACNJJ3bfDKvnTRlv2dl0fK1MeY0m6ZO51?=
 =?us-ascii?Q?R9E3woP7GsJLXEPICSqGu6DJkO4Pn+ICtllYgHZa/ThEqgaRdDnU2b7YQMB/?=
 =?us-ascii?Q?UhCTFz2C+p1laEs6xzo+ia7WoCT/Kv8sqb/3bKmjORCkeZiXMx7WY/piWz+r?=
 =?us-ascii?Q?/7ZG1kuSro5KcVHVZjP/L6E9cnXBtV9ypyh2/D06RaRp0uwGxl5YmyPj9e/S?=
 =?us-ascii?Q?skCaL1Fw0xK8NhBJE7finAh44MYQQA0+DkiiVmbXX0p2MFi7l4mg3KZ66laD?=
 =?us-ascii?Q?4WzOlodfZZ5dfIsOYIhbFz9eY4bONX4TYHfkiQiEP3bdq0V/kyjCs0lfFFb/?=
 =?us-ascii?Q?Oaxjcmh6ybIcM3EThcFj+VSFTOa/RIeYtcjDAR7JAr6byKjSWoqzONk23U5O?=
 =?us-ascii?Q?m7Og0L0p77W0THErByAmX6WWhLdclHYduLS5/EeFUZgxisYck2D6T9itDZxS?=
 =?us-ascii?Q?22nmosHBG8Bj40F7Xt6XMRdBApUSshildCFoUizGAsoq2xO4dZVSt0ta9qiS?=
 =?us-ascii?Q?P2coC/X4DjSaebru7PDYw+OAzsyui0DSrQnjtS/XVt1Ay4XyesQRdQastFC6?=
 =?us-ascii?Q?XHPRsHnBsq6XFmxM0pPOpTiTQZhAbB7D547xnGn3F2/rRNCODA04YlETY3/X?=
 =?us-ascii?Q?q6RwouWyZHuOIcPGcKkHwDtBigEVqM96M9tceKG3bwpQSLb33stmFs33bw9/?=
 =?us-ascii?Q?3wUpQhWjt1gSFoUVosof0opbkZJm/gi08a5YcQAHHSvbzY0pouJ8aTyRpg+3?=
 =?us-ascii?Q?p/1NWHV+LKlXlGALvobFcLeYY+YS8bvj2SSxJq3QblVx0nmf9FJy/lqNSkj1?=
 =?us-ascii?Q?t+G+53GEaxPh2t4n3GslHZ3LPc4ekfEw0Uy2TM9ZbLmHWeiF4aao2+66pMPi?=
 =?us-ascii?Q?5YU4geyXtscIzyg9P7QYjvGFQyL4whUiGnfSy04Z/+H9xy4fBnVDp0NqSWSA?=
 =?us-ascii?Q?Hm/TCe6C/tKa1Xfw2oDj/GiEpsYZSd6QY4NXQIgiPjBejZ4h4TVvpoJBjjOO?=
 =?us-ascii?Q?J8QZbZCFzH1X2gttKSEhYiVVQIjJiXBTVnkuAbyEQELKB+pLUcjKhhRYvi7v?=
 =?us-ascii?Q?+QpY4G0JSJtdnPCCmy8cJEB7wlZYGJR+0ndOvnDnAoXp/N7+27xKqHfafOq2?=
 =?us-ascii?Q?R5Esx3ANtNXlT9FZmBlYGMRxoznl6TNPmOk1gVnAw1rULzX7f+ePt37f5ZdN?=
 =?us-ascii?Q?bZShME6nxn3OLBPe5jg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6e641f5-cfe8-485b-120b-08dc07099146
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:28:05.5804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMypvFw7fA8q4e15XNrcUVIa5D+NSh67h7MnhkYmfavPbS33IGRR2HXvsIMtJwBbPQ7ogU88gDKHchPPwtBmUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

Refactors the reset handling logic in the imx6 PCI driver by adding
IMX6_PCIE_FLAG_HAS_*_RESET bitmask define for drvdata::flags.

The drvdata::flags and a bitmask ensures a cleaner and more scalable
switch-case structure for handling reset.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v4 to v5:
    - Add Mani's Reviewed-by tag
    - Fixed MQ_EP's flags
    
    Chagne from v3 to v4:
    - none
    Change from v2 to v3:
    - add Philipp's Reviewed-by tag
    Change from v1 to v2:
    - remove condition check before reset_control_(de)assert() because it is
      none ops if a NULL pointer pass down.
    - still keep condition check at probe to help identify dts file mismatch
      problem.
    
    Change from v1 to v2:
    - remove condition check before reset_control_(de)assert() because it is
      none ops if a NULL pointer pass down.
    - still keep condition check at probe to help identify dts file mismatch
      problem.

 drivers/pci/controller/dwc/pci-imx6.c | 108 ++++++++++----------------
 1 file changed, 41 insertions(+), 67 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4d620249f3d52..294f61a9c6fd9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -61,6 +61,8 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 #define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
+#define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
+#define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 
 #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -661,18 +663,10 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
+	reset_control_assert(imx6_pcie->pciephy_reset);
+	reset_control_assert(imx6_pcie->apps_reset);
+
 	switch (imx6_pcie->drvdata->variant) {
-	case IMX7D:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		reset_control_assert(imx6_pcie->pciephy_reset);
-		fallthrough;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		reset_control_assert(imx6_pcie->apps_reset);
-		break;
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
@@ -693,6 +687,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
 		break;
+	default:
+		break;
 	}
 
 	/* Some boards don't have PCIe reset GPIO. */
@@ -706,14 +702,10 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
 
+	reset_control_deassert(imx6_pcie->pciephy_reset);
+
 	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		reset_control_deassert(imx6_pcie->pciephy_reset);
-		break;
 	case IMX7D:
-		reset_control_deassert(imx6_pcie->pciephy_reset);
-
 		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
 		 * oscillate, especially when cold.  This turns off "Duty-cycle
 		 * Corrector" and other mysterious undocumented things.
@@ -745,11 +737,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
 		usleep_range(200, 500);
 		break;
-	case IMX6Q:		/* Nothing to do */
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
+	default:
 		break;
 	}
 
@@ -796,16 +784,11 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 				   IMX6Q_GPR12_PCIE_CTL_2,
 				   IMX6Q_GPR12_PCIE_CTL_2);
 		break;
-	case IMX7D:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		reset_control_deassert(imx6_pcie->apps_reset);
+	default:
 		break;
 	}
+
+	reset_control_deassert(imx6_pcie->apps_reset);
 }
 
 static void imx6_pcie_ltssm_disable(struct device *dev)
@@ -819,16 +802,11 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0);
 		break;
-	case IMX7D:
-	case IMX8MQ:
-	case IMX8MQ_EP:
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		reset_control_assert(imx6_pcie->apps_reset);
+	default:
 		break;
 	}
+
+	reset_control_assert(imx6_pcie->apps_reset);
 }
 
 static int imx6_pcie_start_link(struct dw_pcie *pci)
@@ -1287,36 +1265,24 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "failed to get pcie phy\n");
 	}
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX7D:
-		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
-			imx6_pcie->controller_id = 1;
-
-		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev,
-									    "pciephy");
-		if (IS_ERR(imx6_pcie->pciephy_reset)) {
-			dev_err(dev, "Failed to get PCIEPHY reset control\n");
-			return PTR_ERR(imx6_pcie->pciephy_reset);
-		}
-
-		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
-									 "apps");
-		if (IS_ERR(imx6_pcie->apps_reset)) {
-			dev_err(dev, "Failed to get PCIE APPS reset control\n");
-			return PTR_ERR(imx6_pcie->apps_reset);
-		}
-		break;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev,
-									 "apps");
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET)) {
+		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
 		if (IS_ERR(imx6_pcie->apps_reset))
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
 					     "failed to get pcie apps reset control\n");
+	}
 
-		break;
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET)) {
+		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev, "pciephy");
+		if (IS_ERR(imx6_pcie->pciephy_reset))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pciephy_reset),
+					     "Failed to get PCIEPHY reset control\n");
+	}
+
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX7D:
+		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
+			imx6_pcie->controller_id = 1;
 	default:
 		break;
 	}
@@ -1438,31 +1404,39 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_PHY,
+			 IMX6_PCIE_FLAG_HAS_PHY |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_PHY,
+			 IMX6_PCIE_FLAG_HAS_PHY |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_aux"},
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"},
-- 
2.34.1


