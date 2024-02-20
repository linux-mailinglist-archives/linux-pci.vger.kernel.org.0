Return-Path: <linux-pci+bounces-3778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BEF085C116
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7584B22F68
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1865C768FD;
	Tue, 20 Feb 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZJSBhsTD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601477A05;
	Tue, 20 Feb 2024 16:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446024; cv=fail; b=K4nXeyA86xcVmu5G2wBG3i6b01tj81gyXqqdzb0/DnPEYRjkYqn9pLIoZCVGUfrNUYU7ZiUTNWuC6M5plQZqLQvQnAA5hs+4C5rnhGce7jWKELPtPV4onOM8xQKTSmkPopqGFii4dO2nNUd4mnpRf4+3t64kTMPNvYYaGQYFImo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446024; c=relaxed/simple;
	bh=FfrWfRcY/pOBgFORDJmedYBh7bQVG+cRLMpqCBdacKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VAP4gC1OE8wSF+tT4RusmhWlv0GnSw7m/puVjbIKuO+ZQIOld1dnEVArY+1DiTx8TcVUwPIm7CiB40BPTF7N/0Z9sdkPoGw3lNTMN2VNNqxD4VXfXvEDDgTtpG0m0JquD5UXfsrw7Fi6JP/o1xhuFfMMlSbH0p/CzHqEbiw003Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZJSBhsTD; arc=fail smtp.client-ip=40.107.14.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV7jIaSZm0wtQMqRq7cEEQElPq8amdKorrD9ntbg+7DoDj/WPEb4pMhfPliddRUQtS+jISV3v1vPO+6Gp0Y4gmXQUfb+OW5JaQM5gFN1Ewsxyvl1mtUZORJlXNgOVq9d1AwCRHvv5itzfZ46yjxjD0x1kgPYJlrYFq3m9l4xhRxjk6S8Awv/SKrlrt55pcOUTLE90Nl1q13+6dTZXZd1FSH1ITwnIGt0/ZyysBkMReJHM1qzjNq8rjy0KQAGIksKk5BnXGJqVHR93nBUscdXWe9XhLfAeuyEgufI/zKqBFwZPR/L6HKoiSFYIyi9gk0xNtEXDa1Q/j1o6AuyJMtkkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O98JVAPS63GFVIgr7820vsH3cmjI9rQ/ShNngcs8344=;
 b=WACQ8u0SRMzfwcjB3VEvFzPgEAWGcGHGqe4RlBp8J6zZ5o0TtQIrjF8ZH8W9fx1x3GlWRA/xInqJtcauzicF9XmewucLpe6N4VLWlQhWKYineByjbW5kjHNuwBneThp5T+WW+6AVGgKKc8XnFuxZKq3qFxJlz+W0nP4Wd0yTnWSNMYsRWV7clxo1D/JkoB2V69EGZGir2kD38k6oPekgOffykyap+nx95//8S3LtAeFtojQ7oaBiS+V6Kq4Ewp9aCp4LuN5mIY78l0urGYUf3tMyz4/gpH2CEw1ggY3c7TOf0nxo8HYnXhPHuQJ+8RQZite4fiCsVe9nydbB/RA9Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O98JVAPS63GFVIgr7820vsH3cmjI9rQ/ShNngcs8344=;
 b=ZJSBhsTDCST8vA8WVr/bqM97AsNJg/79+Ad04gBNIx2tTtJ8xI+bfGN47zGs7kAEnme871Fw7etljU/UaOQY4zriZilZm0Rsn7QqoXez6VtFVyID90WpH10dTT6Qma6qkBeB3PGwUZMZJU81NjFqLlhcfMRGWde4W61Xmwd6dB0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 16:20:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:20:15 +0000
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
Subject: [PATCH v11 06/14] PCI: imx6: Simplify switch-case logic by involve init_phy callback
Date: Tue, 20 Feb 2024 11:19:16 -0500
Message-Id: <20240220161924.3871774-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2cfd2fa9-89b6-42fe-dc61-08dc322fd25e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jr4xGBS3a6yITN2LIeCWN1Qab9wHc2Q+zScyC+akmai+6TbLVOs07nPzsmKEbPT1joCED2MRlEEkt8LwiYfGIuBbQxkkBv69v+aLOaNMsbFLAm4I+Bl1/yPxrCto0ArqOHJNu5B+EfkgTmAOgo/RhtJqzppnpTRHt6aMzmcFIES+X9R9SmFOK6rANRhvLixAF0BeLOdoUVOG0TGvf5w3aPavpjJvoPVSka6uhIF38HlLpEpoCNuH3f4wWxyrY5XPrkywisETxMT4XiePgwn4ScJ3MWv+FtL63mNQeusVCr2NU4ltL0ZtfLkLfRE1u6B2zXm9fBnzsulaqIteJ4VDL/ZexoVo6nHZSTszQGERvIzn/4R7NTLnFlCFZ/Kg8a623MRB/AlJkDs8D4F0rbjrhrIE2Xfb93pP4TEWzwvoA11Po1OJBEKU9okCSarLNKZFfoj5GQNngzn4S992aXyVxNtWRh3SJkK1+7x7Qj5NZxP0jqZQqn3dhtDjJXlq/cRQGzIcU1YZZn1jX47i27F04knCODim1dqHeNoaf1kKrOgTmCQ2XD2pfGs3DQJD10TM0IqF5XleNiP5PwLEiI3659v6OSmq1Twne9Ew9PVIvnghbcyPd6pRfBu/EmfF+0IX
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DT5s/EL4TJmLufhAuvXng67J9+uJ6DU3Y2F48fNea9DKatc8xlDcNE2qHXZt?=
 =?us-ascii?Q?rzZoMMlawop6TDnb+0PiY/vg7kMXibWRclIa6zgyywqO/q77UiRX8NwSZ709?=
 =?us-ascii?Q?OAam74K3LvYg6/wH30JYFWaKr/DTmUIuYQe54x7fLkFAk0D1/MeP49XqVxhO?=
 =?us-ascii?Q?VJNbJ3ShYKSth4wc1NVm8hERVAIU2pKpt5jCsO7G4+flQOu7KyVB7U5l/F31?=
 =?us-ascii?Q?2fuepDPbxIPYiKcU2NXWxYRLEEY8V3Pvs+dYhAsYtx1Au3Xh5E9bLzFh7/B+?=
 =?us-ascii?Q?2lA7mbL9/G1AgCj22BatJMiz2S8XPinI2OJRhuszT9WJrh0TzCW4jmBpc0M9?=
 =?us-ascii?Q?QHFHsF/LjvMuvixRZEHVtYgH4jjlH/LDKFJkYVCCGfM4HVd0313jHzS2siKj?=
 =?us-ascii?Q?WMW0atQAa70tQ/5G5B28ePNpptUzdV0oLt4y42Bwf7/0yst5vCjKpWZvUUkx?=
 =?us-ascii?Q?iaSPgzyHcXFo0tq8p/TaD2RQDs5QBOOxOy/esMF7CoSBs+NU/5MB87IgEuM5?=
 =?us-ascii?Q?j6/+W2KPLlNPE0UUZofDDHmdRTkSrQomCgPly79L8LoOdZhPEnUODyTINJJR?=
 =?us-ascii?Q?l5zHurx/Gdjqlx5SNSCclRiUA2xGRclVFSMMNf3kZrCHU1iRlZlBDH1y9fCZ?=
 =?us-ascii?Q?J4XQi8NjDlunqojcYZXkFdKo5RfNp3N8hPyGn8OOY2VglhHBOMlmMEW9ITf9?=
 =?us-ascii?Q?qnMUgjqPZzm4xCVTuiUVlVFfoT4m8bpDMzoNvKGz/66X0QnpJh+UCc8jVLmI?=
 =?us-ascii?Q?kzWb1Bop1JH72eHGha5L7f1K1iOi1aPR1IBZ5VrEU+6/kdraDgm912TY1ZJJ?=
 =?us-ascii?Q?i1u/YhX85CH9+5vZgk8zuhlx7G4MmSmAKS3Ua+jQZ5FqOeDm2jOqsrUVLO03?=
 =?us-ascii?Q?jvGf/z8S23EvGSlDEYFr2bWklHTzUqH86Xyn3luTqhcifAt0knJ0zdoyubhz?=
 =?us-ascii?Q?uWRdikxDXgELkQhroXgTerfN1vEZzkdqR5xUd9qaGdF66DABHK8qNDC8iYZY?=
 =?us-ascii?Q?yGCojmem0Vj4VdZzdf4Ra4U0MIpe3SQrZiAMkQxWOWmwjqqH0R4XQTgeWbyB?=
 =?us-ascii?Q?UVw12dN47gdA+H5dNRNieSncMDc5ONTyRHj7tCc6iGHaSKqUOie7zM+ckR1E?=
 =?us-ascii?Q?WwadK5g2rGU9KoJbX3PScOs5yT/1WV8l98D3Z3k64lVdybx/cd0WiWXt1qr+?=
 =?us-ascii?Q?d82qX1sbKXMlKymmnVshh6xB43KIxReRVub/U5kh9NgnWIt8YLCK8YWLAaEU?=
 =?us-ascii?Q?UXCKKYsLOMabpA7VZihlvVskH7czBmwn9Gilis7SpOwHO/sY9KLvpdG8PZQ6?=
 =?us-ascii?Q?PeiyIK+hzhd3J6znMGImaIu7kXtGXShbl6UqCUNRkbfkP9ZdnYb+1ER9zkGt?=
 =?us-ascii?Q?AL2GtZUpJ94QwqAqbcIuX+AwqlTE9xzeDoz0t9U9eu7dlLMP3meKzkA7dgst?=
 =?us-ascii?Q?r48UNMSbGlk6lZFCQMR1klz5TWqaVvm+d8rZAJV4WE3N3hZ2nIVLv4maZN6s?=
 =?us-ascii?Q?f5w5ti2kjzXU3pTdnRJrNlxoXGxEWJeXvKBFIC6tyOIiC6H2IB66pFC/YA0/?=
 =?us-ascii?Q?fY7Hpu8bOLPWGEWC/ZGorAhi6sv/WslUqap4el5b?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cfd2fa9-89b6-42fe-dc61-08dc322fd25e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:20:15.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoYZhLjWBEWLlaI9ZBdIkTWYkuDmt3HMNK3PJscH/0wcjqyVptd7qnAQg58Ywukx5fne7kLJM+Gz95pbuVvdWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682

Instead of using the switch case statement to initialize the PHY handled by
this driver itself, let's introduce a new callback init_phy() and define it
for platforms that require it. This simplifies the code.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8:
    - rework commit message
    - wrap comments to 100 chars
    - return 0 at imx7d_pcie_init_phy()
    
    change from v1 to v4:
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 134 +++++++++++++-------------
 1 file changed, 69 insertions(+), 65 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 6dcff345939e9..71ce6b7ac1de0 100644
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
@@ -81,6 +84,7 @@ struct imx6_pcie_drvdata {
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX6_PCIE_MAX_INSTANCES];
 	const u32 mode_mask[IMX6_PCIE_MAX_INSTANCES];
+	int (*init_phy)(struct imx6_pcie *pcie);
 };
 
 struct imx6_pcie {
@@ -322,76 +326,66 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
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
+	/* TODO: Currently this code assumes external oscillator is being used */
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			   imx6_pcie_grp_offset(imx6_pcie),
+			   IMX8MQ_GPR_PCIE_REF_USE_PAD,
+			   IMX8MQ_GPR_PCIE_REF_USE_PAD);
+	/*
+	 * Regarding the datasheet, the PCIE_VPH is suggested to be 1.8V. If the PCIE_VPH is
+	 * supplied by 3.3V, the VREG_BYPASS should be cleared to zero.
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
-				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
-		break;
-	case IMX6SX:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
-				   IMX6SX_GPR12_PCIE_RX_EQ_2);
-		fallthrough;
-	default:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
+				   IMX8MQ_GPR_PCIE_VREG_BYPASS,
+				   0);
+
+	return 0;
+}
+
+static int imx7d_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
+
+	return 0;
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
@@ -902,7 +896,11 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -1381,6 +1379,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1394,6 +1393,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6sx_pcie_init_phy,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1408,6 +1408,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1419,6 +1420,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx7d_pcie_init_phy,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1431,6 +1433,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1466,6 +1469,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-- 
2.34.1


