Return-Path: <linux-pci+bounces-3099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9551D84A0E6
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 18:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D4028372F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52748CD5;
	Mon,  5 Feb 2024 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KSfjjgz+"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D67548CCC;
	Mon,  5 Feb 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154469; cv=fail; b=W9k2GOISoZHrCAoL3EDKyWI+jZ4QKIWL+P+Kc4gLNPIstnvPMrBwBtka3bQEdsHBusgOfVJ4c2tZqs9AfTB05bXkGSGxMmgZWgi5cbTFA46IlxkhtwoIxnt3JoyZEtyLwB2MgoXNz0JZduTN7DO26ZVvUOj0GtRkMVhplNNYfx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154469; c=relaxed/simple;
	bh=Uj95WmDYAKQSvTN4FukLWBG4SG99KCWmDjQsd3+a0gk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DXJC00YHTKVGqOciYPJ0+iFtfhQOcYsVMKwuOS3p9uHVOl4jkqIADDsc8axlBJIvEKCtaodfRH3zgSUFQb6zDcgdEi5ca04ch/h3ze6Anq1lW3mD8fDymnLawzoYcOULEGTZ1wPaEOnC3HyTB47vRC12bck+ivNcBPzRBLhn4AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KSfjjgz+; arc=fail smtp.client-ip=40.107.105.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAeZVd0FigGshJyoRDd9o24CoobRvlmnNkmUMLoDhP4dqLlzRyGjGkPfrzu4dEYHAltpjRj1vQpEF1EW58mXPbL2Dea9GgD9tZp3SyEjX0TEfIpG8KTof5s9BAazJQog9+BpXZq8GWQiuOndkITdmYg5nNd+8ZqJTsNdY7t79x2TeJj69BDNmNLAouJMl1M4/3m3kUE5HdONRpXH7nSm51zNRvj84aX2oB8LWVDPUhynj+k69vpIDetHIVbVdGA2Nz4Ax9pvdrv+HYBd7T9AtDQwsn3UkKb7PQtRDp27V9++r/E901vQipXoHzARxqEcfgehNo6cc8hr0ZnkdS/sjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AD6ZdKpakiYIduHOoUtJrJ+Zmy/RiZjjT7qDEiSCXJ4=;
 b=kY/xKfpDlcYgdS6jv3JAQdJv8z1KsPkV+Um4376scs+qFKh1yKyHX469f+Gw2FK61KbmHil5T7t9qs4HlymTb7xYystQ6sWxMYHwuJCOPpVN/1uHvRP7o0gSmvuOky8ayRuGah+UM46BUHIrSYfJF94KlHE1AxyFId9EqDuMa/o4Oz1cdx7drRFsKgsULAaxAfJ4zEXSnzJY/2T4GumFwSpDA1f8Fy+KLrH+xoNn/GYDSXiirjfawI4aHfsbXUzyX2JBI9UiwdiDGRqGLa9HPtPdYLkasBQZWV6Va3NExxxzN4WJ7lhbCrZdQp6jkfnbrTcNMykLYhvicIeYb4goiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AD6ZdKpakiYIduHOoUtJrJ+Zmy/RiZjjT7qDEiSCXJ4=;
 b=KSfjjgz+z0069q36l8u/m1PzTO4WNXg8WAkNbfVBydH2j22NRQiEE8QvLudI60NKEyqPjYyJ35RNToEEB0H8Mz8c46ms5aEPU4twgzuCzS732e5bhU2Tv/UfhYw1XNR6LG37Mwbl0ba8P0BxfT/rp/gL08YCv7s4kjFZgFllgXU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7733.eurprd04.prod.outlook.com (2603:10a6:20b:288::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 17:34:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 17:34:24 +0000
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
Subject: [PATCH v10 06/14] PCI: imx6: Simplify switch-case logic by involve init_phy callback
Date: Mon,  5 Feb 2024 12:33:27 -0500
Message-Id: <20240205173335.1120469-7-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 14f18c82-0551-44f6-1966-08dc2670b208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1DfUZnZo+ddOF9oYlLv9P7S1A2Jif6FDPLPohBGc+jXBO5qwiGpzZcXtz1XXK/3n9EgKKQZ+VNQzA5XW/OOAp/9SE2kxoBd/+d+FTMxIy3M62ZvUKiLSxLAcu6fSV8+gNAfapKAZ6G7asM9Sg+QDPGdN35TNYdbavbLZJFRfe+0Y76BO3Ec81xvDM4pChSx6+TFNcGbyaFySI0B82Zq0YLOClX6FGtJn9HBJaUuPFEdILANXLh1eeiDu3BlOC/H0xbVg5JIuOuA57oKBR3WPMBRRM6Qqb1UVU3rJdH9CJ/noPP2LDha1hj96pmVy6raS81gg2JjyVTb55l2VFDV+TnBM7mTTd4G2DhZaG9vT0UtsIMVHlZMnOOG9R/jKkfp9pfel4I8CLGc37axSQOrSdmYC6A54R7RSwFnLx1ls/eRCv1HXqY2hcMsuZEWZH4YxsNRGWb152HohwCZL6VzPEDggTwDQX7mR2vKno0q2ULFacWbk+wI3RI0vhh4SUrh/KOS6N8rw2hGE5E5tXIRoTblgVEAZjcCWBpylmMDc4UNQQdydkZ28Jix+sEIgg9iKl7RJ6fSQkXUn5S0INh5Po2DmyKdvT8zg6leElat6mUoMXFw6wPLg84dSDFwDqxuK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(346002)(366004)(230922051799003)(230273577357003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(41300700001)(66556008)(66946007)(1076003)(478600001)(6486002)(6512007)(52116002)(6506007)(2616005)(2906002)(26005)(4326008)(8676002)(6916009)(316002)(8936002)(86362001)(7416002)(66476007)(5660300002)(83380400001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gwDU2TVMyajwssEw+d9yx885TcPxUdJfYRzM1tjr1815ZIE8aBHlu33Et+L5?=
 =?us-ascii?Q?/ANVRLdtlG8QRmBvFEGHX6l8X/CvDeqHJ6tucJbXqdoaE6ITXpHOb8FljItC?=
 =?us-ascii?Q?00oD01xmKdg123+PlaLe2Q4GHMEl0gXGSbJcz0rVJ2nqlDJHWgzfS8pt2PPD?=
 =?us-ascii?Q?R4MsgsCOQdIuLJE9RQZtoPShiceGc3DOiTi0A3Y1DM2YueScSDU74OVcmu6P?=
 =?us-ascii?Q?8sKdyvUMJ1Rbh9A5aQRpt7UJ5vYlKfenYAr4O6IMSmRsYntXzUZ01+g3iDY4?=
 =?us-ascii?Q?nMzRw6VApzHhRu9pAGeIDMHMJY/sg/rllq1OtJv7ZTdnUa9ewpvhKiXivu+j?=
 =?us-ascii?Q?dToi1KOnjI+OZSDviSVBYXeQhsKptso2rnCvWos33JaaCW5iUbhUHa/11iLF?=
 =?us-ascii?Q?r+MeJGyFJvN7MDzNXF4HSPl1uVmBrnh430Ngw4W2Vy5dusuc97kfmQiU68Uf?=
 =?us-ascii?Q?g2r3A2enj2KEAbQWFCH0dCxoBdt/XGCdovGmjSg2s2DJfQEmHww5CpDQ+5YB?=
 =?us-ascii?Q?a6ZyxpFKnj0TOjkxwjXnZx4Es5yaKPQaegBcsscWLbwyhGMryIiLEumXEEjD?=
 =?us-ascii?Q?xpBD8sz87bodpKxHkNNApqKqlwpGGGrZqIb3AdYT2mbRNZYOU75ZXeCN64O3?=
 =?us-ascii?Q?V+2JiUgmAegD0bSRwvgE1NJWiGRrcr39sqHt9+gCDDBwNMdKm8ExTtvfF2fu?=
 =?us-ascii?Q?aKNECfxAc22NGKWfz+SION5NAiPiz30ogHpD3lqsew3zzweAFn7x2odAq8XQ?=
 =?us-ascii?Q?J8WaEYk+vU9V2TvdktkrRWaw2u94QX8A/n2X0xrE+Zr0+94k1tR9sMLNxB+/?=
 =?us-ascii?Q?jUKC9KK4+92V1yJvgDjCcviEtUYkM/k2jJG8m9GGbah9TgkiSqFEtu7Lt3Sv?=
 =?us-ascii?Q?AkQ2MxooJQ3BIJd5sTvRdZNbvS37Os1X11rayfUSAIKe/oDnP9cuKCbJtnNW?=
 =?us-ascii?Q?pueacGnFVeYGPBtgdMJsMtW3xTIdf6h2GAhv0o9u80OZeKVIBxgGMRddnyD1?=
 =?us-ascii?Q?0dg+i/Xl/1pHG3pyfd2JjrzEnShmaekET3ckkOMVwaiVkFwQEOVilXinI/Y/?=
 =?us-ascii?Q?sGe5fcmg9TsmROGonZAskKRw4Oq9GIN7hxk2qY84LR7/qPC07Gj8N3bpvRlx?=
 =?us-ascii?Q?weCSXM/e/DpX/Dfh/h3nipwTx9aJ+Uryt8WRGb7GitPWPP1gAK2v5nryyK1a?=
 =?us-ascii?Q?H0Ll+dFC/cKP81tP/c1+Luu3PiclfAedrIPNHWiiG0lPi7qRaR1Kq8MxHIs5?=
 =?us-ascii?Q?1apyMcuyo39qPj4cR9ix3lY1JpO461vAvWdC6pOphYydCwg+o79pt7soEoDi?=
 =?us-ascii?Q?AwdywtODc0vMpFtbzsq+rPdCOdl7TNOQjHQzrKrhc33ZmjJ2EpIKl+0+PPBf?=
 =?us-ascii?Q?yTU1C1qd9xbv5sC2AojulhS5HLC5KeRY7TKxN/AkjEbO5H15Jvsia8Mej8ox?=
 =?us-ascii?Q?bGv+TQ5uirX5J/otzKDDIJ1bE6bDTUX9e3WDXjKOwiTa+04O8TMExKPvCmDI?=
 =?us-ascii?Q?Sm5Hk6SAdPveJmqfuEFEBAH3EBVb0kdmoe2ZK2OZ/JmWs2eo+pq8Ffc57Hu1?=
 =?us-ascii?Q?Yp1iB/jkMwRFzU4paAj10Or160gxSJg8+VYvRfLd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f18c82-0551-44f6-1966-08dc2670b208
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 17:34:24.6093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u9MrdHfUS+BvOlwiPCmooewOzbhRW9Z2eQuDa2iOLwi3MKaX/od8iUT9ksFiTKPV+QXidneHFZ1N3q/p75+p4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7733

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
index 4eeaf54709afd..c266b9f098a5b 100644
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
@@ -1380,6 +1378,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1393,6 +1392,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6sx_pcie_init_phy,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1407,6 +1407,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1418,6 +1419,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx7d_pcie_init_phy,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1430,6 +1432,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1465,6 +1468,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-- 
2.34.1


