Return-Path: <linux-pci+bounces-2377-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7063F832DC1
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B65B24BC9
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26DC55E53;
	Fri, 19 Jan 2024 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VHMI+8Nc"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C7A56456;
	Fri, 19 Jan 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684324; cv=fail; b=IJHSV4ZK728RgkK+7KHA3duY9R18fOpyexnEcvm7LOgJQa0xd7zPHDBsiRyi5CxsVnGCcl8r5wh9GLnd4iQUbKmEuc4yOrD0fRsRoGxHTv1hkXC6pDncqPCltdwrd90smMuchSWJltJbwfgObBzZgmSuj5eWdAeVVz4w2kFQoIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684324; c=relaxed/simple;
	bh=/K+umSyaDuMeeoR5ZVYhXf+ntQ9XDdoqSQ9j8Rnw1RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3krAbS2nmRYkF6Sm1y6VuxCiMGQjbrQd/dgkAQxKiv2qpTVkC9zL4LlhAtZ21qik2RA/NY9mytrocCqj57eJCbAIuapdD7e7tTOxnCdpQwfZ3I6FMZfSTaGso00VwjLJP8zpN3PQLGgaZ396CbiYV6JtZhhWQVAq1QXQlzJQH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VHMI+8Nc; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1/9vWR/PuHu9o5qIeygFYgaob6fwNi4Ml00eyPU/bz39H+4JIRO13a77/IoYD7pZfg5wrXVEkTihV2BPOpTjk/V2mK358NijAlv6pyHTeCD3HGVValMUvnTOEqozGYUifUXdALx6LSHWASDSEhb4OdHzV8wdoSG7y5lTL5LSKYGXk//GVLdkCIR7n/5+FZ6oDRkswVu0HxHo+wMSmUcF3d+1Sp+8h5ELTf9288mOiL3ECcEX+sjsjKbLwtL63Mh58JCQITKigLaDBeabWl9hkWV5fWDUWs9A3nNAhaKHvlqdNVwV1yyf2zpKArncoqlwqbcZxvZlHoSfDQRVILPPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UAqz1QDijfOU2wgMSfbq+ZQRvWPtiX7cCjXhCYScZY=;
 b=iGS5STAUuwBle3QN6+yflxOsTb+wJtVrQGRc/nBCk6inM+IFLL8kjULXtLiYs1yK+XNehwtovkINU3IpGLLcefcFTypB+wNjt+50ev/+gxMM+Yv8hAqvM3/9IlRMqQWidsc4nRuk3Vqw1DQlMqI0f/kh3JIVxy0FvSaZuYmSwgsfxgGG51yFXWDlKXowK82ElYzGALYeJ/TTf+flbCYx0xOO9o6A91RblpofaaN+Ew4QYejukU4qwTfLwEd7TXvauHSSbwNShlZY2jfD+K7t8zRtWAIaVRWB7dwbtQ6LMQeshR5FA7IkQYTr/GA97HnM6pBtu3YEsn+kIjHalgralw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UAqz1QDijfOU2wgMSfbq+ZQRvWPtiX7cCjXhCYScZY=;
 b=VHMI+8Nc/F+yNgBFokRvNLqoNJii7qUbreWDepZWMZukHyzWBZbpgvaIgZj4ebtbmPNQ7eiNxSaa/jd0R0Q2r8pRxApN9poTLB7dbdtwAAFgWdg32zQ1G4np8oLUgJjn2w25GGyIB1I3Q8Wl2dNUfuetvZRxexskGjptzXlATIc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:11:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:11:59 +0000
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
Subject: [PATCH v9 03/16] PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET
Date: Fri, 19 Jan 2024 12:11:09 -0500
Message-Id: <20240119171122.3057511-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 499abe61-e0e4-4fa8-6f98-08dc1911bf0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	o9+5H9mhgZIoaVSM52dpG7sVqSLMgmGjZbOOUtAl34Y3oljyyPFLdpb8nEqc8ZI3RX0qNK1C6cYg05A0I2tIqMAJfTqGog6c/SiOFk1O7lNdSqyF0dKDskTGJhd46R6uhFhiG6pNxECT1ea1Z4ux6iPDGeDGQHeV5Lb8NyTSACUkMglF9KG640O8Cf76wGR98LcEOJRc2b4cGfuf+d50CEZHlX84z0s/MRjKUSvTrZUsFdlxpZx6rPoSbal0r95a78Yuwa5nPAjZhR4uGfef23TFgSwJM+j1G9r/1MN3YAE3f45HG24oaXCL/3IByBCR2mNHWPXf6DPpP8L50kBCkGTBwiTaMTDj1BINamFU7Xi18oRY+plLuQYE6oPQuOZv2B0g9w9xxx2v0AxlvTotjdp6QE42gxGXLv1s2PwkN8yeilDNx9bQtMciccQRk5C/vcmHVefu4VGH0/4g6YXBFuMZiFfJewESiwyWsGBO0qF4+wy2J6/TIewnMyImgycUHjQoDU6B+PqW/e9WLdxH23wzTKGuR6Mpogdx322rE8Hs2dJ4iAfWf0dESEdkRzhjzAoXy1Jfg8AkNXISCn5j+nJvstvPzElwVFBKUZ2jGZnyn2sGtj4VOCtybtIPEdL3
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sjhbNHTDHEHoV3iDwDrTraJsf1Df8mqirYYkRZrhHlg1N0icNmRpxHPyEUsa?=
 =?us-ascii?Q?A8QTKmU2qwaZNXhlclWazAdd9BRpze9B1YF50lIU8gAF1aZWtmSU32WvsD/g?=
 =?us-ascii?Q?ICeU6F4Yl4H0juJWEBRWL74UQNZPMxOD3MjJutmUyU9HPUj4gCzXBtN+RzXU?=
 =?us-ascii?Q?NOrFPI4r/BVZd9K94NXFiUkf23lBeeQIie0IoVfXRXAgXhxEcCyjj5GoDCsQ?=
 =?us-ascii?Q?pno71wmEWDg7a43UKPwA0dque9EvHH/6eQwPEfGsANIeTKpHskIIcumpdRDg?=
 =?us-ascii?Q?fnScFEE+SmWAUX4mjdPR4ns/dY6dGoqhOtD+pT4V3gWZRsk/fFYNTfLrz3B9?=
 =?us-ascii?Q?n1Rk0z2BuzZ6mUrwDwOsUZ0636sFi3Zk5MYTOfV0ZyX/eFCvGiQkV7vVWhu1?=
 =?us-ascii?Q?moZrgOTdDKfFyjGdJiZISPBYmw/Ic68g8wX3hCM36YqC0Qi7qKkzDht0Xp6o?=
 =?us-ascii?Q?5hKyAJ2sK9ooCXU6u57MLVIAdkpwcuYhmmpOFKZVw8N/fNU3LoDugKmw1EW9?=
 =?us-ascii?Q?eVO2rFkvRzNoTyYeHO9bFqZpNRXFFiTpQZxqOx1t+cnpf2tXjNenmHLwhUiB?=
 =?us-ascii?Q?yY+z9Kt7fd/G88lRKCk6tiRbNGRniLwOnrqs8tS2aHr/z9NWVmArd9G3x26Z?=
 =?us-ascii?Q?1ZDnJwB84eqig9/WETRiVxT8Av8mtWwIEfCs1yLzLvNULe6d/6ctEd0kTo4s?=
 =?us-ascii?Q?Wwh2TgEv61Icv6qW9CFBDFTfBrizwb1f9jkqjAT5PNNfgKXBt8mUI4qQQ/M4?=
 =?us-ascii?Q?LAaZwbxlhmr7/08BXlUoSLDGKbz4npSwdl0Xn6CdtL8A1b8xd1IRhYLVSm54?=
 =?us-ascii?Q?vTnInjvKDzVZUc5vMeTFWCRT/gLnjcvVsniq5XVpyVm7WG5048Vdc0SQcQif?=
 =?us-ascii?Q?ZSYH2Fnwz7xJo9JnBIxdgFmv9CodyrR4u+z64MRqaDkEVHrqFNrNEEJ48sr5?=
 =?us-ascii?Q?SQLIAOoyoaFuN/0YcUBLVqASEgfXM8dm+Bzn09+frmRT7i/BQu+wB9hB+SAU?=
 =?us-ascii?Q?MW+ycoHLjITifCGQ8LVWHHObc628xzswnWURQTE6USQB39XbtzknBkUb61FJ?=
 =?us-ascii?Q?8oCUgBApVh/1+uZ8I3z9tBIOimeRrKJIYjrgSw0D311Yq93Fjwm22ft/3gBx?=
 =?us-ascii?Q?9/X8unTq/nUeNET9mWr7IE0Atd+PYdhqQKK5EKiTsxKlKIq8iOsFte9bZYpM?=
 =?us-ascii?Q?8toMmXifus3mbsP5wDq7Ob6AYxx735+6co85MsCL7wk/N4B2TMpsP3Aojdml?=
 =?us-ascii?Q?aW33ApyyoeZt2wjmyBweka3Ft6DR06Neagp2eoKoffEUN1MXJXeCxO4a2TPU?=
 =?us-ascii?Q?16p0j29gjs0ScxdtjNG4rae4uKYG9MWH8x8khuj8NpAUrXVWmRhj/XbW95C9?=
 =?us-ascii?Q?eyNZt/6uTRxIpiPQVgeQEEwKSZV2accPHWfEg7png8bMdL4qmZHuWM5WjlqH?=
 =?us-ascii?Q?m2D/GHMczWFJMmxytRxE+5h/jB3oK51OyXcHEYk4TPYeXtUUv8POis+dQGrl?=
 =?us-ascii?Q?ALcN5MX4F/hGh5ksgCwwIxxfaZx/HgnUmOSzfq9tnzKfpz797C1vjvjvtCfr?=
 =?us-ascii?Q?xKKj73WPXdnSXZ3Cux8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499abe61-e0e4-4fa8-6f98-08dc1911bf0b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:11:59.1810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVvjuzmlUhH1mcYPYtobDxDYdYctLhm373XnlKZA0EnpoI3N8GUrknE0MfBHv//M2nnCLPdExlpu7MAwx16ENg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

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

 drivers/pci/controller/dwc/pci-imx6.c | 105 ++++++++++----------------
 1 file changed, 39 insertions(+), 66 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a33ec006660c8..eda6bc6ef80ee 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -61,6 +61,8 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 #define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
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
@@ -1446,13 +1412,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.clk_names = imx6q_clks,
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
@@ -1469,13 +1439,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_PHYDRV,
+			 IMX6_PCIE_FLAG_HAS_PHYDRV |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
-- 
2.34.1


