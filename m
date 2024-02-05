Return-Path: <linux-pci+bounces-3096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 815CE84A0DC
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B6D51F231E2
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71011481B1;
	Mon,  5 Feb 2024 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hi/e9Gpq"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108D844C8D;
	Mon,  5 Feb 2024 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154455; cv=fail; b=WVdn04Q9IQFxiSIx2sVvpWllWgunxpXlIgV2w0KVIP7pxPN1P0+xl4ZP1uMbW+E0vue4I0NZvX2F6hdOkiSC9L9hdTSlJnICVMtwAjK/kf3GvaL7eg1bqi5VIjQ+ctXMsyiBIfs8ThORd+ozjxrf1ooXy/fY/JIJMXcfapDg6fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154455; c=relaxed/simple;
	bh=maVpXdEKXP1/rHgD6HwoMgc3SltzWJXCWX3DJ9jlYe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KaamXTkGZmcMcinQHu+lM6RpvAshzdAGP2gBSQkWkcNKSvdmjnH40XQy6Y/lT7enRxjBdM7xtHIq++m19hqxvSto71DsURy6TKEe0NPnwYV6XrP8cmuT45bGMaTyVdFRcR5vtHJK3mMieFBFoznjde6aUvG0YgXTmUZ0WQ4MeJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hi/e9Gpq; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oa5cManJIjGNk/eioyweWnXM+mHlNPcjmhHUAcEj5O/3RFwwLs4nYOcyfxr9da3BFsviveV3Nf/i7EFGLBcj2nE5mvIAIJbBUffa7VCTMdGSni9J/Qc/IEJ7XarPKoM+dCDcvm2fFDq7E/NeMa0UqO2vEJs5ZaS7FgHiJPOH8mVT4aI4Dz1rsGlLNgDysPMKaAST82eqva7MyKCrGTUQF+AwejOtFdV4u5zxKasPXdk38hrvIolxziAnOH5a2C+rRyDEYo1wmDC27MbqEwuqoxyfeFWd3R6/uSKK5LYF2lxXNa2Xs3RyQl18RTTvq1dlsdFc6h7QaJpVtSsfXyvGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj7K+8gdShMGp2Z8Wc3euRHjW7FgBWxkTi6eGFSYoBI=;
 b=VKNnYrnjrVJnvUmYJIQAcjdMbc1e16EOI40O/yFNx09JpcVoUsqS6qAMjf55UbAKH0vShsbDaz7rKEQif5VNRrt1/KHIwjK5G2+0yqNR46elPI2u/be3x5FVknZzQIzsKgsWI8ovYlcx/HQ7ryoo9r/wrdKZ9nRz83vhpZt9Aup4Qohw7YQfprXsByY6aSZMixw34odoV08zWTBHmTfHza+MlDabmdEqAYMkzceCS0z5A+lywGEWaW5HGcvemyDqUb5n8yL724BOXOcIYR/XRIhk12C8CBoHfP1aXFP/G1JsoYBHJl57WZkEy+M9yVQKQN7QMay7urBdKNa5jv40jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj7K+8gdShMGp2Z8Wc3euRHjW7FgBWxkTi6eGFSYoBI=;
 b=Hi/e9GpqaJoRHKPDE863OqAYYtTfZJC1UeSgWp0cAC8Rclcwd3th01JgLc12z/WGCChhy6u8Kk87OQ9827ESjQxR+IZx17OSxqSf8m9JgasUxBRDqcPoZaHmyrD/BmUeXDCznmwXX+G9cSJxwfIHw5jzFirUcCudRy2Ssdco7To=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:34:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:34:09 +0000
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
Subject: [PATCH v10 03/14] PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET
Date: Mon,  5 Feb 2024 12:33:24 -0500
Message-Id: <20240205173335.1120469-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 68a1de59-6d2e-4ac2-1182-08dc2670a934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3kZ40N3ycA3ie0vVnyngid6qW5MyLGRk5AdGXs+huUHYG0ihN3iAxos+WnHj/nPkZM+/jmRQlx9WsWyV0pheldiT523CJoVPAISNBZgtEd6s+RGHwgI8Zlf2eCxu8WZszf5AbMvyuj0nyDXkcdqkkkge/jchq7RBl/lgqAHfk43GY5WBxRDGjLA8KMErT0ZFoTXw9/nOOWGfA+gzc54N7d2ghhtIALRC0z/zeFjmPzf+ZHuCuh8F5r1l5ToAyUGN5Om+hXLJt/jwMrsmgGrJLvyGHWQ9+MS6F52/sEmKAQx9BTUWVkeeYFRi+226uC48/pc2eVUya/gG1KpskP7CCrLwi67t4io2IOI+AOexRFoLevOrnAQBYNEBm8eEc96zPkH0IphFXg7ORCGx37Zz1TzTEu0dNQNIcc14mcybUV1823PMfKNH0CWVSAyo6WlWqa3srkeDab7Lc8Y0peRbfVnXZTtiS97zDJGPdPRlOsMDqE5s8VL1Qw1/6kNORYF+xSNcxgv8J6jqMKwqOlzSQnquuPxbEWj2VOCfux6H/FAgGHJfzc3XDHi+NYpYVuFo9Ens1Av5pxOj+W4hRJ36lGCpj7K8KdJW/CHYZ3wVbcsTWlo+k01xeo5V7eaEmpVF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(41300700001)(66556008)(66946007)(6666004)(1076003)(478600001)(6486002)(6512007)(52116002)(6506007)(2616005)(2906002)(26005)(4326008)(8676002)(6916009)(316002)(8936002)(86362001)(7416002)(66476007)(5660300002)(83380400001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5qYdLSb2oim0Zf/l/dp+SpBAZQVrqAHbkFcPbETkZ0/4u95h8k/rZW1/JJRH?=
 =?us-ascii?Q?i3GZtwDQIOungTrIok4VQbvn4rb1VCZDAIj+hwC0feL61NTooiV9bFFkWETm?=
 =?us-ascii?Q?JH1IC1TWBkpTpb902VNXN0C3jfMJVASAy3XttmgHZb+h/oDRBgtpGz7Cof1X?=
 =?us-ascii?Q?ja+whM3tEiXDLomjH3RyhI/AdUyNjrE+kbUarPOQ2nIhvA2GCCjOUxAuagPt?=
 =?us-ascii?Q?6e4ExmpOdwiSetBZRcE5Imut/pw/09o9f/xKSHKwayJOT1N2oFOpZtEyfKYG?=
 =?us-ascii?Q?QSGHNyMiXs4ay84jc/c0Of2+4jfByjPCcNZ6hUJBP6fJ9AKGLRsA6UjZSMOl?=
 =?us-ascii?Q?oRNxlBou8WvpAD5ur8nSJ65Xxd3qIcH5qoT4X6QPQ8bqn2sR2TgSRVB2cA6C?=
 =?us-ascii?Q?BntWH+kBL/6avH3lh9m5EGnnmN+G5CdrOqlz46w5W5h+a+cwF4WV7CjE8sYx?=
 =?us-ascii?Q?HZF/HvjtMF/lQBNYYvQ5+ab8GbENCDB0+QiOWe+axshYD64VwbYKjKxoNj1N?=
 =?us-ascii?Q?t0cD29uaf3Le9dRkYGa6kCJksF+w3pwLXNwxez1ZpVOwQUP2QmgzPmstl1mH?=
 =?us-ascii?Q?eYak8RpCxZMOycSt5iBWjB7Pr28BnUuka3/lppIAgpxHGhhKTMbn+JggHyJL?=
 =?us-ascii?Q?sgQN/XGZutjEhRs2oCw+wCnjrHfdIXtzjNwT4Plr7AkXtNfSblSihFiEN7ld?=
 =?us-ascii?Q?A2914yByZErO9aBPGPCtuUIJYpr/nYPtus0WeSs0OXDbSVGeMNp6yUGhkRlx?=
 =?us-ascii?Q?zP+v1HGMMAJvEyvO+orsD9pNBO/GKUn3Q/dSHqXjy+NbEDRw1Tt183H/QsZ4?=
 =?us-ascii?Q?J3q27iPnIurJnMTRwZ1V9nP0xLi27TxvHogI2AYAeEOcbwPKGvZCk4L67jlJ?=
 =?us-ascii?Q?ODytMnTecPh+lf2BVj5V+QWm/Yr5BblmA6viPs4ANUKh2AlCzVDndyS7FGEg?=
 =?us-ascii?Q?ggT3w1ZGiuoBA/bkcrrh/tBeG+NA+7MeAuN4cxQO/SCNBToeRDmnKBLiE4aZ?=
 =?us-ascii?Q?u9say9YMkQrGlC9A8Kr7i2rnjCmyH+13OfEDRkUU5PIETWX+DXQ6DcqSDBQM?=
 =?us-ascii?Q?KoyIqGUTLG4173OMmNadeww902u6SvNrMmKOnp4M2tJ+abhIPVHZDtkVD4Eo?=
 =?us-ascii?Q?ttkyFheC8nxP+0iAM2dRVv7ZG32tSrsMJDpC1ICBlrFOZLJp80zwmOU62tmP?=
 =?us-ascii?Q?Jn5rP/F1MBenBAaPiF7GqaIyorV0q7LmZWTa2Gu7L9SkDkZfs71NxQBf7CbY?=
 =?us-ascii?Q?a/doL55Fg8WKdsGe1vBf0JIA00PC3MRa2MlYpAXFFAWCs4mWpJblOgrgceoo?=
 =?us-ascii?Q?q+4CAp2IABsq5Xv6lRo4rU1bbZaxLrOS1/pmCt1wXIvB1VUyjQ1B2//jRx67?=
 =?us-ascii?Q?oHYPqvBxucUlAj+wn0RbY205XZhFJ5j5XoHPyZ2e7Oi4Y/NhTRra+7BWUC5w?=
 =?us-ascii?Q?CWwjqdHvphrwkTPljoRqbU7SPRF8eOWso4ik7egeUc9DA3KkkU5gfm+j/qiC?=
 =?us-ascii?Q?8VOhmArjLXalrqYFAzazYRUEmQBT+E2I1GWJeyt5kbDnft7+ZVOlpbQWq4C1?=
 =?us-ascii?Q?R03Rk28hLCnob9HdfhPS/F/6j+eXcISPpuKcPsR2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a1de59-6d2e-4ac2-1182-08dc2670a934
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:34:09.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 78gQCe85BnBUImLPRj1sYYGcwnbWPiAXzEWVzM6KN4uTzwoTrO2a1wmpeTGg3sBNuSoEPpwfwzuyDlkGebFXBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

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
index 59f117f855c26..a1653b58051b7 100644
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
@@ -1287,38 +1265,26 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "failed to get pcie phy\n");
 	}
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET)) {
+		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
+		if (IS_ERR(imx6_pcie->apps_reset))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
+					     "failed to get pcie apps reset control\n");
+	}
+
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET)) {
+		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev, "pciephy");
+		if (IS_ERR(imx6_pcie->pciephy_reset))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pciephy_reset),
+					     "Failed to get PCIEPHY reset control\n");
+	}
+
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
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
-		if (IS_ERR(imx6_pcie->apps_reset))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
-					     "failed to get pcie apps reset control\n");
-
-		break;
 	default:
 		break;
 	}
@@ -1448,13 +1414,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
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
@@ -1471,13 +1441,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
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


