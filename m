Return-Path: <linux-pci+bounces-579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8906B807445
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E337CB20EDB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B633645BFF;
	Wed,  6 Dec 2023 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j5JbaDz0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4151112;
	Wed,  6 Dec 2023 07:59:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LoOCiGfM5zDpLcfBQAfSFttnjcFbatrAP7yEsJvXlUrFxUXBOSAcg1YmNqrsIlUaC8g8rFmcvbx9Bp4H+5hVJ7QpUbJ9aKQKanqb4lJEwwrhoISn3Cy8HuLiEPykYdpq+weyEFEv3rTVR9NlCWtRLnZBj8BtSXrmCAGUUaqRSQ2lEhjmjC7FEmM5zXJanyG9lwhw5H6qtU3Q3u8zs8U0ojoE81ig3Bre/gRQpyaBnDr83TClvcJ1HTzPSAMGeB4dHpNd2bfpPox38RjO8ZEen+XhzjNvu4ILnw5/QRF6gF49M4hD1VbVBwsmT2jDoJaU+h1XplkkmEIZWI0dyojw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLFrgFMTx88zjL0CQUkclXOg54v0L16aSWM4qx0DJl0=;
 b=EIkAi0E3J38W/r+U3QzGSgJEwBqbtMcpZaf8wq33iudUCrlP1q7lLXtYSCdvZV3xE7NnWMv69zEAb7rptayW9aeBnaGU/l8Us8BJ5tJmJYDUrVe6O23vDakiimz/b28N70KOpSXPYMZBjlkNmWuELR7m5ZcUFOogzoblcPiwmns/QhSZvF9/MnujR2dXGtgXZ7AfyH81D0UfUPC7FCrNi4UI27eYA2d9sMD845LcAVYDYYP3VFPQOZ+DpF5JKJVAjefNirdt8T11Lm8xW2gl/0k7EERINuaAIkqlwkN1QF4ICfq5o7cmc8Co/mRsPkTYYkJIoKu5yfkFWycES5tR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLFrgFMTx88zjL0CQUkclXOg54v0L16aSWM4qx0DJl0=;
 b=j5JbaDz0tGEXPdUuGtjJdMLh/QPivwNcDu0cUFZT9UFsYd/DzU9yAPA64R85+DhNUUXhZUfUQHs/7c0GXTxAuj0zd4anKiQimMjzPv6I4+fc5IenHa/qvtFJJUogRU7lhgyJVecZ2YXs2FR1LK19WdsV763xaKjDSi+pq2UdRKE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8123.eurprd04.prod.outlook.com (2603:10a6:10:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 15:59:38 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 15:59:38 +0000
From: Frank Li <Frank.Li@nxp.com>
To: imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR IMX6),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR IMX6),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/9] PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET
Date: Wed,  6 Dec 2023 10:58:57 -0500
Message-Id: <20231206155903.566194-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206155903.566194-1-Frank.Li@nxp.com>
References: <20231206155903.566194-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 317e8671-5f9f-463b-ffbb-08dbf6745977
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DhJg7MSulhAwIJmyODrqaq3BcBqkv3KM3SoFuCLdC7FNXu7Ld0kzaJguiwaJYAqNIKk02OvWFVC8nY2oFwHsSO/1MsLrPDrR89OApesv/gOvC9eRXolsn0uN4p+vPzSAqrJ3DApU7TX6NBrfLzzU4rivhWdGarkTLTJuN8b1meA0EHGZs8HX7xpuNScIA20PYbYsF++mIKFHDK7hX52k49Xa2uZ1w3mOhhSnl/Eb+4zkAKiwkwiEGOm3/p+Z2Szdi6wIgZKa4k0Ot42NaLS94lBVKnkFAAr9fuhtGDY7vLJdIhLO4PfQ+4v4OVTrNhprjkVB4cSfCCgHpEXje7OjYtWnsviz5ZxS92At8pGnRaT95Dpn5tMOQh2yrrJYOvwQVQYQ6tBawRS8TnEAAVcYm1kR7+Dw1fHp++shTCsO2o1iXhdFHc4ebJB1QpIeJXS+Y6z1GKTa7s+Laz/AvfNBbgDjA85KYy4dBXjuAFEFx11tsg0mRpfoEG8cSXP+rT8aZznlkaC1ZHzBgNk2b3/4RrnqYx7CIt8wdsg+QcEjGYaA6JFq7DXF0p04QhFPVY/p4JqaCa4NLWc084yypkXexGtc1g4XsQIE486x835jJTSIuOH9XFVtpk7LutCTpckFgoBYG09I67Qqma/pNgkR3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(41300700001)(83380400001)(36756003)(6666004)(52116002)(6506007)(2616005)(26005)(6512007)(478600001)(921008)(38350700005)(6486002)(7416002)(316002)(66946007)(66556008)(66476007)(86362001)(38100700002)(110136005)(2906002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QLBYNiMRniwrf2M2DG+NJrBTizBv+XxJ83zUfvWj9G6N8tslVAknPsDNGwoE?=
 =?us-ascii?Q?qu9ml2jUXoH1BMf5Vow97Ok6ylWEYi5qPCMAbRoNuzuMFJIB8NJfOzL5oLFU?=
 =?us-ascii?Q?dEu6vcZ5ZMeYPG0C+edLOkbKpp2wTvAlG5oNBkH+G4vFSKT647Iz9DFbB/yP?=
 =?us-ascii?Q?BUQ627wHM8qlyRNxdsO9BAn4Xbrrs69eLwXS4J588sjgzhS9yrA96Y9PuK0l?=
 =?us-ascii?Q?P8iOVChk1bpaTguxl5xzBh/c4j1CSl4e2EIbBNo7jDNMXTt63iGEqqBBfUzl?=
 =?us-ascii?Q?TrPoL7Y68MKitB/xg4DSw+l/dk/nBWWLHhMHJxxDtjWLfIC5aFwUeW9nq72y?=
 =?us-ascii?Q?31MUwnCoPiXDiLSRoD7xtWN0UHXTmy009Qu/y/lcE5mwzABcCLjdCyPd0cXF?=
 =?us-ascii?Q?vkDBJA6MNAmaKpHXgW1pZgYm11KcBptFwGwTzsr4hJKNb7kNi9kXJftyApbY?=
 =?us-ascii?Q?rROLY3Z6grSxPAQmFUt9uPq2UGB15qQECPZJufApT/1jpEyQpdrXwhHUI/Yx?=
 =?us-ascii?Q?tSskn8uu2vAXEbppKlzlJC8phK1zNqIsQQ8jojh63UK2vHc/JLVfCvY/MfnJ?=
 =?us-ascii?Q?xQQdlWT1dSSJoBmdw2rYJRBHbQEdOk2djbXRmQ59bScHCJ85ufpPyPfvgbJI?=
 =?us-ascii?Q?YJB3D+gYxzaBrW03VSkn8jwS8UKz1Gigt9TspORsTBivLkNOQfjW8kjFnNhG?=
 =?us-ascii?Q?412SbYHnOAtk5G21Ey99g5w1BBumyzpZNmdGKSziSyjTF00zAfVUoGauAapx?=
 =?us-ascii?Q?+FoNNEOEBv4Q33Oq7cmN4cqM4FzKmXv1wsM1Fy+iA4dZHz671RroPtB7ZpWA?=
 =?us-ascii?Q?MNaToQc6N7jj9es8tElzpOw3bWZHsqFphBrPfw1SWFwrGjKq8AZ9BwN5r3t6?=
 =?us-ascii?Q?qYqhUJeZUillmUAL1wxwaRsGhDigjjAibsPhxeAkKstZ+HPy5w5KOfs+wO0Z?=
 =?us-ascii?Q?0rxXN/hBYkeUpjG2jGS7Q9nAaMb3FqpK+gBAkQtCvVRgo+AxhHginzf7BQNN?=
 =?us-ascii?Q?DjLxaIvWhUFSQwjlcgAkJBNQnLsxHT0nh+1sfy+Yvowu9LQS6GA0fN5ioGcd?=
 =?us-ascii?Q?gt76Uo6yTKNYouOEZA90hEo4w8koN8jEBkLyLnnCK8bc6BjwgM10zGVMU9Jl?=
 =?us-ascii?Q?QzAT8L84Zau9HPn24X8/rDAljSshQqbpRkfkgtFD1+sTTWf8RRBIThCsgNuU?=
 =?us-ascii?Q?eidPxeZqEGo936hsp18ZfhjIhxOx3rCcQBkojCuFqnTwkgnJG1JgvU0JKsyl?=
 =?us-ascii?Q?+Vh4OCdb0W7DoQw50CO/TZYKx9hbxYNcvzANYXYsAJV6YyQZAb1nNtxibsl8?=
 =?us-ascii?Q?xi1rXXhfrY7REguA6gq8tuARpOZVXYojEPOlZoiEong3LNz751hWrFYcXQgY?=
 =?us-ascii?Q?Ijk4l/Lg2z26SApse7TzRQSmbWW+s+RWTfUBBi4LbNCc1vT5PqBMC05eVD+0?=
 =?us-ascii?Q?QWOxDarMvubKas3QFlC5gBSoBz89YGgd/5I+JJCUKk7f2pZRA/A8Br82fbOe?=
 =?us-ascii?Q?cJLkCZTFPLabZ+4sSUtaxWauBf25AUoghtlst+M66FZBjSwqTE7jtfkZ3V/G?=
 =?us-ascii?Q?Vg3wLzWRazgpRLg+MsQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317e8671-5f9f-463b-ffbb-08dbf6745977
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:59:38.2579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LzgIQoBLCGaoN008vJxYV7NXGYgkSRTjQ5vQRWkCabivXEc0DVA/duoEzXBql45fJ6gKq9DFkJ8FB5lUeN7cEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8123

Refactors the reset handling logic in the imx6 PCI driver by adding
IMX6_PCIE_FLAG_HAS_*_RESET bitmask define for drvdata::flags.

The drvdata::flags and a bitmask ensures a cleaner and more scalable
switch-case structure for handling reset.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 115 +++++++++++---------------
 1 file changed, 47 insertions(+), 68 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bcf52aa86462..62d77fabd82a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -63,6 +63,8 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI	BIT(3)
 #define IMX6_PCIE_FLAG_HAS_CLK_AUX		BIT(4)
 #define IMX6_PCIE_FLAG_HAS_PHY			BIT(5)
+#define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(6)
+#define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(7)
 
 #define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -696,18 +698,13 @@ static void imx6_pcie_clk_disable(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX7D:
-	case IMX8MQ:
-	case IMX8MQ_EP:
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET))
 		reset_control_assert(imx6_pcie->pciephy_reset);
-		fallthrough;
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
+
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET))
 		reset_control_assert(imx6_pcie->apps_reset);
-		break;
+
+	switch (imx6_pcie->drvdata->variant) {
 	case IMX6SX:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
@@ -728,6 +725,8 @@ static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0 << 16);
 		break;
+	default:
+		break;
 	}
 
 	/* Some boards don't have PCIe reset GPIO. */
@@ -741,14 +740,11 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 	struct dw_pcie *pci = imx6_pcie->pci;
 	struct device *dev = pci->dev;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		reset_control_deassert(imx6_pcie->pciephy_reset);
-		break;
-	case IMX7D:
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET))
 		reset_control_deassert(imx6_pcie->pciephy_reset);
 
+	switch (imx6_pcie->drvdata->variant) {
+	case IMX7D:
 		/* Workaround for ERR010728, failure of PCI-e PLL VCO to
 		 * oscillate, especially when cold.  This turns off "Duty-cycle
 		 * Corrector" and other mysterious undocumented things.
@@ -780,11 +776,7 @@ static int imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 
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
 
@@ -831,16 +823,12 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
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
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET))
+		reset_control_deassert(imx6_pcie->apps_reset);
 }
 
 static void imx6_pcie_ltssm_disable(struct device *dev)
@@ -854,16 +842,12 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
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
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET))
+		reset_control_assert(imx6_pcie->apps_reset);
 }
 
 static int imx6_pcie_start_link(struct dw_pcie *pci)
@@ -1335,36 +1319,24 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1492,32 +1464,39 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
-		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
 			 IMX6_PCIE_FLAG_HAS_CLK_AUX |
-			 IMX6_PCIE_FLAG_HAS_PHY,
+			 IMX6_PCIE_FLAG_HAS_PHY |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
 			 IMX6_PCIE_FLAG_HAS_CLK_AUX |
-			 IMX6_PCIE_FLAG_HAS_PHY,
+			 IMX6_PCIE_FLAG_HAS_PHY |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX |
-			 IMX6_PCIE_FLAG_HAS_PHY,
+			 IMX6_PCIE_FLAG_HAS_PHY |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 	},
-- 
2.34.1


