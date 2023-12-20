Return-Path: <linux-pci+bounces-1235-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D98D81A828
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACE61B22E85
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076F948CD0;
	Wed, 20 Dec 2023 21:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KdPdtcJv"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D284AF9C;
	Wed, 20 Dec 2023 21:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYPgy+eflfsXHmJAwya/E4JPrbqgAjbJsn6xEpvV5zh3Tra3NkwqoWv/U93ZGGXdvU9AA6a/NKdmF0HUgOdmZVNvI4MDLQwlDbSVFRgo0OoshbRosr6Ieu/OxSHQKETvV02GdGTLTXQ60SosARNmfD0J4GpapgLCe86zfhiqVxdFAKyjbFMqJreDS8XNMPuQhOdNoe9aIruE2/GoH7Iz95jXyGLLHrX8SrEVd4Peny6EPY+Z8YbRL1BKJaOq2UL6FzP/YoIX8qR1/VfsTtjTLQK+UdWy0XuapwW3OWjvL/qp90L4t4mcx1OFlja/iupih6mclzUGPFXFq/4b4OvH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx01HvuG0xZ04g5Qs1emA81XcCk2ClpOFDJT/IqUaUE=;
 b=jA58riXabgxko6h0IhNRaPDUMhhGCrdVbxkAANfW/ur5F5cXmCP4DDZBYDeZ8bRxyaR7f3MtBzF+sGQt79YkSzN9cjoIDA0fDSzQ1k2zQX9cSMWUT/fSS6DwL2xFOpgEIrUQWEKXZ6SVJKXGSU28D7LjcGCMVmbn+tVCb0tYHHL8OfOwDA5WZ1Nn0zUMXpHZhqRESHTVKMlQ+Ofdy2IHeBrUvB4RNPGX5a4vbfpXZCUZxvbHE0P4TDqEdZZE2bWI4GS0Eq5koeh6yctnxwdGgeMzJ9m4OHkb1xWrxiRrC2lK0FPBYs2Zoj/ez3v7sMa3LzcbB54/eSkaOfwCxik0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx01HvuG0xZ04g5Qs1emA81XcCk2ClpOFDJT/IqUaUE=;
 b=KdPdtcJvXbYWoEkrVfIJkDu0ABjvUZ1rVfTXG5EElmtb+H45AuXs/RbF/gZUD8ECKa5AcBlju0hv4KKQSH0OZ7fMb7Gx0iakvkvlkt0GE9GQea/sFg23nDfy1LYzQ/0kEobyD3viU78cD+nDnuDzc0i1gvzTuabgGlMlVOOn1no=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:36:58 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:36:58 +0000
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
Subject: [PATCH v5 03/16] PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET
Date: Wed, 20 Dec 2023 16:36:02 -0500
Message-Id: <20231220213615.1561528-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220213615.1561528-1-Frank.Li@nxp.com>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0110.namprd07.prod.outlook.com
 (2603:10b6:510:4::25) To AM0PR04MB4834.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a43af9-6485-44db-b75f-08dc01a3cb33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uqRtAXETtns5YJbnmqbSI9ZveRpECxEkiY971dg23KbFLWfEJ6Ye1qPoNfJgRTB5sdxLZsTlBSmWVHsWpCVXsoQaYmBsNUy85WAu9G16csTDIVyC67BmMz7mHIAMMbl+PRmNe4bZEtpV0YUpU3RbJsDRCJLEN36smDwh5RJTbsRMXxwtSAm/y27rCINwGARtsh0xxuWFfK3x+JWgpqcz+ChQtAlns8MU1agGTj+5Bw12Fik1pATkl4xhxFDVTDabIozT8ToYwMh6+KfJdFjmZQb7OYetNj1MPCaIyyB+SXNm4BqlHfliLtb7yefkkJKekajYiL/tsiEHyzTJEd8k36VxUSr96pFTKr46qxryaa7q+DmOrvL8uE/f5m5IkmtTrMkmezYbAMog2WKbr2/0WXYPwvYaQikBk7vXOsBqFRkKtYPrGqyKF65y53LDlB1cEItr7PCbEuor4bEQzgv8E/ITb1PakGH/vWm/7LnRKpvGLKpoedOlsMXe1dp4xKaqGzszMp+B8EeuBKUtGkXyDxpaBDpFem2ZRfEcoS1WMgQ5hIuQuplPsV/cTw2yEalWZ0fFFjfLwD3dmQKY3VLX1Jez5ns8ZTiyVUoU5hWel+/LWicTaofOjhZOuXn/+H2z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KNwpvjb558lGYY5syqwxrfXqzYEsyyjWqDISoBlP0hEOJjlava+R89IiQuNH?=
 =?us-ascii?Q?c+5tn5Df+tB56D7l/zcQ582tHguteKJhcTH0VOr97SiAP3Lf1QqacNp5vDP5?=
 =?us-ascii?Q?/mG9N15a69wsksDbTpwKYaaafGNswyn66ZYzG4MhEww3AVbAPhRGIDV0Q7ZD?=
 =?us-ascii?Q?9jzID3x7Z03KOqGEoprKBW0Paezys6acYw+HkVr55CAbuQj7vpopqh+DvhzF?=
 =?us-ascii?Q?YQzxByQgqQgSbDCuAsXLMDJZRPQxBhQ9NwimmkAchA5NUUtzevCxIv6/1OdW?=
 =?us-ascii?Q?6lnxrTov86A88QeN+XpVoxSQTU+RV1Brrx7MqxoEsWC2lCn1uf/eqM0p8pzz?=
 =?us-ascii?Q?9iI7o12Lpb0yBuKx3N/Daqp1VZbz3rf4Eafl51XXvzfjqj0m7krJEl3bZHOJ?=
 =?us-ascii?Q?N5EwRZ9dIPKS27f1/dtnEiI3VZuf2V8xNVnnfq0VSJU+iYrELvhgKDy9p3LH?=
 =?us-ascii?Q?uzOYUFXejJGp9Fx4s/+Bhox/4mhhIYDYCVK+62jQtC7MXgJcAO4skQj2nIz6?=
 =?us-ascii?Q?99FbbsR2antHaONtCahB36UTQxk4aPhZaDREQE3JVGBL/j7dhi+AqYtv1e15?=
 =?us-ascii?Q?g6o1NjxgCTI8V3ps+x1ZmVX9T3uMxiqpII8oMHSBBmT/txiC6ZG3ErmK7VSn?=
 =?us-ascii?Q?gUiLaLiFHNN38aCPaSZlCgA7vwvR01tx/VEGN7t+6sANLHRb7/uviXBDMeTT?=
 =?us-ascii?Q?CWKoXGS2rBuCDrfQ7NX7QauDBrb/oqNwmC0DQoVDcAJWfR/6CcRI3oSjSJx0?=
 =?us-ascii?Q?1mlj7xR9I3pvJF4iXepIxWuHkyK9l2Ko/1cxjnsYfHZUtgmscNHOE6qSN0tJ?=
 =?us-ascii?Q?IW6BMMImO1mofu57nYhKsK+T+0bSejh0Otr4/wTXxf1eq7bBZ7G5jcEosyqM?=
 =?us-ascii?Q?dA9Tx510hZQcmHxMtLZbK4H28BgfD7i4U239GLTJLCacVgTj4RcP1VHI7ZVp?=
 =?us-ascii?Q?eCW96nzljKq3Jcoq4gwu3hAKsjwbeaqhBCGdEP3Q6x1mCxttxOGgvWAgj8A+?=
 =?us-ascii?Q?YVXTyOhW//N/54z/luqlk1am1yRHKvozykmuL7IOMjiqrgESZH/GotNdVvOI?=
 =?us-ascii?Q?wYC+VNl00bk1Afr1UjpilZ4H9BWVV+97Yh/SYs/NwbiIjDmscGDyOk8BYrxN?=
 =?us-ascii?Q?/4Xo2fZoqNdGJyEiG5AKNAKN157h1796ZLCSUWcaRgXNN9AdiqAsdB4U34jq?=
 =?us-ascii?Q?os+6n8MUDlT1aQQ3fhiuJ3Utsqe7qLYWD42f2cddHhLvkUNdoRbArtbz4hXx?=
 =?us-ascii?Q?Ob2CdS5jQZui0JGuC90ZhHHsJIJAEEDIGZ1sH/W46v6TR1yeaib5D9LU4a3w?=
 =?us-ascii?Q?ss61qLoknhhAuA8+uDwV1lAlr/2uKaXQxYJ0ThbAwlYLjS7kQgM5E60M8gcx?=
 =?us-ascii?Q?XUr+rmSO7bzpYe/xP9C8ZzM1Wd4eETX+Lnmc4PeL31hnu9PNikABAfbS3lxu?=
 =?us-ascii?Q?RXdugxELt5iNxr4Y5tP0FquXanUZgneQWGNxfuIoDCzhcIfMFBuosfHVPloH?=
 =?us-ascii?Q?CLSopV4eGqx6yDNUexBhEIs898t7aTWYMArSDnV8XYOckcGyzZJtnkxX9Sqg?=
 =?us-ascii?Q?pXVa/RSpoqY7wccX3hg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a43af9-6485-44db-b75f-08dc01a3cb33
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:36:58.3357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IIrgFNwtTg2rsubBLO2NuOkoYvptWS/9X+WOrhmKQgvVeAt8e6WuO4vXsdJdPaYMzr9Z4nH0gjYJcM2XoW1WCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

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


