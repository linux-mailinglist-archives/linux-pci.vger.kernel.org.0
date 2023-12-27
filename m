Return-Path: <linux-pci+bounces-1460-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D87581F14C
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF20B227E2
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F4447761;
	Wed, 27 Dec 2023 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ajq+igAt"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D8D495CA;
	Wed, 27 Dec 2023 18:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChzPXeA4CorLw9BBFcP4u6BORwXRPD89Hh7rXGfK/8KItGcdAemnydVqXFwnMUUze1v/14wBy9awCpt8pi9q1LtMYymsxFeYUPxDO6gcBidwHCFMzlF5iwWHYRDEIQlOXMJDY2hECdQwodF/Z/7wQVSg6UeqlnB3PSPdeVistZkbOFXXKk006xyikYtoAYPseY+UpcWTxpsXQzD4kb0ZNtxNbxe3gWq+uE3opWaQFGBvk04Bj2n0wpCR5eiUdfayuXo+//e7Koka/4qUWPCX1zDDPYyoC8g8ZIzm56Z5FNTRd7HQHn89Bt4ra6ZNScp1m6tQ5uAz6TRl7g6esPPFGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfBQoavpwzUAjcM4KwLeAI4dwVXf+6SQBsdUZVKowR4=;
 b=P3Hx4Dk7vCHB8/zYwgJpur9Dm5rN+h8ueEvAoEyxiWeNLgmxqbxl3ApdhpSxleY2tmlbO+Xd/egPr3QMSd4qSQTrKMyhJoanKSFUzTsWbOvjss0S98r+wiy5g4LoOA5ZIwU9X2ce7Q1LYvJbHnZFU/nYHsulriDTQw0dlFQm3aVZCMFP5oB37soo2By9erTlD7jFAFmE4u9d7Yhy3xCLoHmXuBlFCtVTaHMlR9SjJw/WSq8VLZDYIJIfY7Xz63N46f1Goqs2DsdjtQ1u7DTRymQwmu51p5q68RiwyJFvQR3Lzp1/24N6OZyQOBSYdTQdr5MbVDYFg0rMmFlnc1tn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfBQoavpwzUAjcM4KwLeAI4dwVXf+6SQBsdUZVKowR4=;
 b=Ajq+igAtQLweR98V3Wr5soikvRCUCb08o/lJm830zZ+iqcEA2h7KVicHJghxHqLD4T76iAZkkFI81hkRnAqCHJbOtCZNeYHb4HUVKKib3PEK/XxxYuhRTq7S6XkHuYgCQZ/X9VESLEO4eSUrZZGPp/4GXxdEO3vc26bUe+nbjpY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:28:32 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:28:32 +0000
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
Subject: [PATCH v7 08/16] PCI: imx6: Simplify switch-case logic by involve init_phy callback
Date: Wed, 27 Dec 2023 13:27:19 -0500
Message-Id: <20231227182727.1747435-9-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ed89c456-39ce-47a5-7b77-08dc0709a10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mkl9GlonfLQC6z3+HCjBsO9khmUs2+plaVwbO5pbAuozrRlyjCCPBcItkqdhOMVmaplOwbVeOnkojnx9wOhgo6XwFaOZX1XACE3e/g5toaz/R80VYZFa1lSzpxwXcojgoBXslX3GZ6k/vJCWO0cOvk/nm0KuTAlDLTK1q18BeLaWFw2ZJM7iVivcONWYYOb0T3c78jMutsdshAxCFFfwYG6s4tYm3jihowilljqE1lixxlasNq09EPe+WG1jMSG5qOnYnJo5yurGuIZiyrgykgfXZ+gLuoDApMfiNX9H41oShNLzJ755Iu027yvAhS+kjRUUROn1OQgeGnLDxON0Z1vjKPeXRVKmeAMXBaqpEjNhVBb2Fiy0dUf07hpk35Ur5akC3+bb58wsA7sfpoyFI0/BpD0uF7VcU/aN830ifB5By51N9UI34RJWz51+SKTiATXDg20rM7T8jgjM8E1y+zsAH74Pv1nbS1hcQvFwh67is6HJuw/nbt75ggDZ3Fv6ci57yCJK8wb1VfFH7hOI4soJLPlUKYj3M0WSOdbkGYVfYeNnrQqBDZdjOsNxJolLNY9+zniCbdxn8ZYpcp8rZAF+AhiukIAMUvBLF7CgR+hrTKl/NDBR+N8GjIJdXfbwuDmo83KZedACQcUItSH1xsv1rmF7qbix+5lwCIGBYxI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mPlBwcsOK8siQFIowW95reUkAdsWiy7WFYuxTx/AjB4TG5NFDZpdjuosYVNA?=
 =?us-ascii?Q?JVCSrK7DtS3U6wBC3JBOtkvk+FljEcTjgCP0rttH1xPJ621SNJPYqIZJpaP4?=
 =?us-ascii?Q?HLA+0EgWGpigs17whjws3KMdj7WQco6VN5ZW/rLHqK7cEX2TXESjtzvrkkRO?=
 =?us-ascii?Q?MDjGflzHPH1hYGEGTttuC+t/kmj5KNO7FKWA67xyVDmYoboBHfN/MiS2jbk+?=
 =?us-ascii?Q?8Lub0vSTY6Ss5xxCJyp4cOhL7LxdKb8PFfH2IBm+zf7dPYIlPlgvXqcaXyQk?=
 =?us-ascii?Q?vXGVpBX+boqWpVGzsZkGvPpxk5tjab1TVZ9uubju98W6msn4UHTKcOxeqvEk?=
 =?us-ascii?Q?lF0iTQcnntqfHWuBA+yvS85efZNrw9AltMrZwGihdjhx9goEai5S8HLfNe3r?=
 =?us-ascii?Q?uh7XuOsl+QMqrcnHCBf7l6k26u9rx85FbpH76p0c2OmA2uO1BwYxABnuorLJ?=
 =?us-ascii?Q?sRCL0EHzd3wPZ4jhvrrATv8XOFC2Zmo0cUF3vNe3ZtNQOKAuZmFpS/4wZQSo?=
 =?us-ascii?Q?kIyUuyWQuYISGdl1eyhvEBryoE8vqbzEKuNwN9q1R5oZAKs18Xq0mQ4a3bKx?=
 =?us-ascii?Q?Bapo7B/jd0ThL90jiFK1CSXBY1L3Tx0xTVP4T2nrY7mCb3W1dFOF02gxvnlQ?=
 =?us-ascii?Q?pOVbFyKq5eUZ3jk3fOQCizQkjm1TFtXcO2lI+50ya4xDaPzm8KtYq3Loz+lu?=
 =?us-ascii?Q?XqByOEu7iLZL7yGE1qim0/uHDb1Tu3V5T9N1iqA/9pz1WWSEy+a/qW0S0t/A?=
 =?us-ascii?Q?VQc/GHYluap0HrI8PhIEbszW3PblUb/uBBZsoBzjZcOP9ZiSwgnn1Agx/9U1?=
 =?us-ascii?Q?bRCoXWmRTzkzPP6QXtIXVl1YJ0SInUbkfCfjxbkGMTuHUbDsw6Qe4cPN1kGv?=
 =?us-ascii?Q?TMe5/gMh6eNv83DrueRQUsyST/G+tZQFxAGjVubpqsA2VW5WCI/zEw1OztNA?=
 =?us-ascii?Q?13o6cxp/9dOHY4D+KHKgtd8E1m8knFzSqJk7MjvDHmZz4PY1RpkmFl0p15kJ?=
 =?us-ascii?Q?fsMgr6Nz/xzJ0ltEgPtjUtpXp1IaglfhlX8gAe92Io93sn8VffTbY8xz7H0g?=
 =?us-ascii?Q?zQ99oAPR/C2ZiWx7fMJ7PWmgwNfUsFia0Kims9HFV43fRoGVXmj3nXzjevlA?=
 =?us-ascii?Q?fzkgP4bEyp+96qIQbPmV/9oKSZLUMK+S9OMk92gx7L1/Ynwqmm6iq7o+22JP?=
 =?us-ascii?Q?xEqOrltNiy9Lt+zKrCE+7e4XL4QvSi+hr13yMD/ladnPZr58N4T+RA16QeqL?=
 =?us-ascii?Q?UPv4WW7WHXhtEAd156hwWqNndc6PJnrms9SPTi+LDEJ6h2jNsXO2Kd1lGiM6?=
 =?us-ascii?Q?eeP4jwUYC+hVHPq1ED2gZ2d33CLgUomHA+rOQiOgfC+IimF8CflcmQzLzaL3?=
 =?us-ascii?Q?g5+5DRMyUziI7/v1c1pT3fGyoL9WKLwvhoFvkAjkPRboGl5/m3xkM4gWUWd8?=
 =?us-ascii?Q?HtWRJokyKKmrq07IHvuALOm22AVXrsp+8hxyFG+DHV21WP4mBnvs1Sbinlkl?=
 =?us-ascii?Q?jSmx9jfE17/8ZgxEGLhFnnos0OCHk8u0eHf93K8mo7DO84R4TFRUQp/ynkeF?=
 =?us-ascii?Q?NvbddUax1BnyWt+jDDI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed89c456-39ce-47a5-7b77-08dc0709a10a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:28:31.9288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwXnZcFgzdLsGKJjqlEimLB+soT/GuNSFuYnkLPwnGGu9kPsbDIbTJJs31BllL6rUBXrU4CWhMXZTjTE9gOvKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

Add drvdata::init_phy() callback function, so difference SOC choose
difference callback function to simple switch-case logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    change from v1 to v4:
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 135 ++++++++++++++------------
 1 file changed, 71 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 717e8fa030deb..d66a2db53bdb7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -69,6 +69,9 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_MAX_CLKS       6
 
 #define IMX6_PCIE_MAX_INSTANCES			2
+
+struct imx6_pcie;
+
 struct imx6_pcie_drvdata {
 	enum imx6_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
@@ -80,6 +83,7 @@ struct imx6_pcie_drvdata {
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	int (*init_phy)(struct imx6_pcie *pcie);
 };
 
 struct imx6_pcie {
@@ -323,76 +327,69 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 	return 0;
 }
 
-static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+static int imx8mq_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 {
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX8MM:
-	case IMX8MM_EP:
-	case IMX8MP:
-	case IMX8MP_EP:
-		/*
-		 * The PHY initialization had been done in the PHY
-		 * driver, break here directly.
-		 */
-		break;
-	case IMX8MQ:
-	case IMX8MQ_EP:
-		/*
-		 * TODO: Currently this code assumes external
-		 * oscillator is being used
-		 */
+	/*
+	 * TODO: Currently this code assumes external
+	 * oscillator is being used
+	 */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			   imx6_pcie_grp_offset(imx6_pcie),
+			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
+			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
+	/*
+	 * Regarding the datasheet, the PCIE_VPH is suggested
+	 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
+	 * VREG_BYPASS should be cleared to zero.
+	 */
+	if (imx6_pcie->vph && regulator_get_voltage(imx6_pcie->vph) > 3000000)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr,
 				   imx6_pcie_grp_offset(imx6_pcie),
-				   IMX8MQ_GPR_PCIE_REF_USE_PAD,
-				   IMX8MQ_GPR_PCIE_REF_USE_PAD);
-		/*
-		 * Regarding the datasheet, the PCIE_VPH is suggested
-		 * to be 1.8V. If the PCIE_VPH is supplied by 3.3V, the
-		 * VREG_BYPASS should be cleared to zero.
-		 */
-		if (imx6_pcie->vph &&
-		    regulator_get_voltage(imx6_pcie->vph) > 3000000)
-			regmap_update_bits(imx6_pcie->iomuxc_gpr,
-					   imx6_pcie_grp_offset(imx6_pcie),
-					   IMX8MQ_GPR_PCIE_VREG_BYPASS,
-					   0);
-		break;
-	case IMX7D:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX8MQ_GPR_PCIE_VREG_BYPASS,
+				   0);
+
+	return 0;
+}
+
+static int imx7d_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	return	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
-		break;
-	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
-				   IMX6SX_GPR12_PCIE_RX_EQ_2);
-		fallthrough;
-	default:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+}
+
+static int imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
 
-		/* configure constant input signal to the pcie ctrl and phy */
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
-
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_DEEMPH_GEN1,
-				   imx6_pcie->tx_deemph_gen1 << 0);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
-				   imx6_pcie->tx_deemph_gen2_3p5db << 6);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
-				   imx6_pcie->tx_deemph_gen2_6db << 12);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_SWING_FULL,
-				   imx6_pcie->tx_swing_full << 18);
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
-				   IMX6Q_GPR8_TX_SWING_LOW,
-				   imx6_pcie->tx_swing_low << 25);
-		break;
-	}
+	/* configure constant input signal to the pcie ctrl and phy */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX6Q_GPR12_LOS_LEVEL, 9 << 4);
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_DEEMPH_GEN1,
+			   imx6_pcie->tx_deemph_gen1 << 0);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_DEEMPH_GEN2_3P5DB,
+			   imx6_pcie->tx_deemph_gen2_3p5db << 6);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_DEEMPH_GEN2_6DB,
+			   imx6_pcie->tx_deemph_gen2_6db << 12);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_SWING_FULL,
+			   imx6_pcie->tx_swing_full << 18);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR8,
+			   IMX6Q_GPR8_TX_SWING_LOW,
+			   imx6_pcie->tx_swing_low << 25);
+	return 0;
+}
 
-	imx6_pcie_configure_type(imx6_pcie);
+static int imx6sx_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX6SX_GPR12_PCIE_RX_EQ_MASK, IMX6SX_GPR12_PCIE_RX_EQ_2);
+
+	return imx6_pcie_init_phy(imx6_pcie);
 }
 
 static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
@@ -903,7 +900,11 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
 	}
 
 	imx6_pcie_assert_core_reset(imx6_pcie);
-	imx6_pcie_init_phy(imx6_pcie);
+
+	if (imx6_pcie->drvdata->init_phy)
+		imx6_pcie->drvdata->init_phy(imx6_pcie);
+
+	imx6_pcie_configure_type(imx6_pcie);
 
 	ret = imx6_pcie_clk_enable(imx6_pcie);
 	if (ret) {
@@ -1374,6 +1375,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1386,6 +1388,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6sx_pcie_init_phy,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1399,6 +1402,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1409,6 +1413,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clk_names = {"pcie_bus", "pcie", "pcie_phy"},
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx7d_pcie_init_phy,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1420,6 +1425,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1452,6 +1458,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-- 
2.34.1


