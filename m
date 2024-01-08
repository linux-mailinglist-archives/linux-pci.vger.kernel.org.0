Return-Path: <linux-pci+bounces-1846-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3825B827B77
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7B642821F5
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622605676E;
	Mon,  8 Jan 2024 23:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="huWoye28"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D6C5787D;
	Mon,  8 Jan 2024 23:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUwxrW9lGeLQOZ9pS4WtM0jVcnZAiv3joFjDnHgtrJGgf2kgG3oII6Oju2ss6HMEuYr56rs9BlaTvz2g8W4iegno6tLn1T4ZWAiypbLV8MD7hrw88hLkSqhp1vDQM3Yqa9i7o5Qg3AhO+NYMSD4tkv9G1MyGZaTPu8p69QuIVnTnz08wIY7K84fzWjjatVZvzZqHT6OpuGYlaBULcpSQn7kt2VfajIldHkcRz8f/TVS/tJXqext7rQYVvLvqN9mCAvtaOe0uI5WSfQaX4ReQfDkBbg2IVIC7sx5At4m/8SuiVrbn2MvGJ0Z5e5/GF2OD6BjBOcCLqTIWEbD5uminYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXE707XeBQjXalsNVVxh+UpXuEecTt2NAkDr4BSPf3w=;
 b=ifjEM1rgEKx4iOSHOBqfVHp6xf82w78HX+DX/0/78uD6KSlwNXTBqI0fsDRPJpXH6cBnsGExEbe7obbN6lP97KQ6B+xv7ngGyiA4ElK4YLfp1Jc1nVZd6qUksf/WR+sR9G4PjTgMkS0biVZeIAuoLfDs7YkBp2/zcMlj8Wj02/aofw8JnM9oaQjZnDjDRzgX4b4gsG+hKhD8T9eaLAkvcQn+E6OhOZjbrVaLwwczo0rzASDy/VJz7pJjK1bj+krzQ34NS6vEGm0JrLGAF0pAn9kLFatc9pD3lA3xYZmBQqoa+aU+u3NKVDLqr1miOExv249nGY/GKLQiYyENK8O3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXE707XeBQjXalsNVVxh+UpXuEecTt2NAkDr4BSPf3w=;
 b=huWoye28jHBWI8x7QOQaSsrJkZUP2Yd71CQ3u34GkR3tVVELKYRKDQYaNPmQ+p6gcaD9LAI3eJciBwKdnorN/d7+depJ/3GGKKLnPmYmJ56uph/5D3iMibDox3En7hwLZpB1cb//8Akk0z0/AMxrC2aBfKenY6tIYGBobWBHsds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:22:49 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:22:49 +0000
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
Subject: [PATCH v8 08/16] PCI: imx6: Simplify switch-case logic by involve init_phy callback
Date: Mon,  8 Jan 2024 18:21:37 -0500
Message-Id: <20240108232145.2116455-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108232145.2116455-1-Frank.Li@nxp.com>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: 280a0842-eca6-4481-113b-08dc10a0bab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VOhr5GZoncRi4GzVk9J2L9YNfL9L3LVVvJjxOdclFV0MRmduL3Z88tvSt0vNysQSuPi30nmprjPmUSlRgYirIA5Wiq0WF/DJW8FfKIM9yctxVTQyBsuMEbhxmmkb2o4EbW9N7hQLlDCngCF0chUHIkrZVg+IjUfi9Sg1ep4xT/l1+SZhnAW7zncDQsu7nGxYWhvT4grN5k+pPX3Ok4PHlcrZ59f1lzZX61LQo06yv7J8Vi2UWDwg17piTLf+HSUwM+WMQzeT4NXHTgWVvqRFqrAUxLKsZzd2GaaLDGJOjtnl4TkVgvvVUgzmWGssV5ohvt+BNcKHIHJy4yHoHlFCEP1bCCPj1IF6IX1A5AWB6nSLC2LkNFxMTS8eWqxuVeDc8WJn02QVTuZEB8Wcapr0s8Z2X5RDCrSbk7xPY2KT17qmmIS4Yveo2KZY1InBWgQ9xeqwMT5tdQryLJu/qExtGuKaPbwGNL7odNBNl5q62jDiqmoq70kD37FCEulMvz4BRvuQq02v2k9tJZ+e8p8Mhg+RlRI8/GoVTmc7+eSHVoG8TZot/eMJS3pvmJziTLBoyCeMzvnorW2/9uyCzy8hMifn1ChtJATyE3AUaXUl4xPLRXjAo4HOqmvNjFY04UB7K8lQWXuZNe1TNiZPE0+IlP8ouTREwbq6upOWBMk0LDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FcyHl2RYZd1qpNSEb4wRIqJPaI8iw1BBHMVwxjI5rEtgi6UR6vShuQyXYSQU?=
 =?us-ascii?Q?ZpkZey2dzEPkmThi2ayZJlf0kj8AKMLFUquYM3Cbe3Z1Uwsf0HlxX5/tn9gG?=
 =?us-ascii?Q?GJlP6WMJcsYNjUTtnx/6lq+yjr0VpxmNHAqz8yZdHeo6lMaBpZlhE0tQ1QYE?=
 =?us-ascii?Q?iyb76JBON2lfQTj75tZfBu1hT/nmYOIjCDzwtM1R17V6F2tsFO+Gh/BZbiOZ?=
 =?us-ascii?Q?taNkOiGB5uuRGgaLB8DIQkaJLj1s6pht2jt8z9gNxCzOLiGv3df+AKPQgaUI?=
 =?us-ascii?Q?u3MQZqwJS0ghppADXhvJLHA7b06Hl7Qlx3sWLNNnqPsvzqpUHDV9+hnmeOtx?=
 =?us-ascii?Q?wRTvXWs3+BbuNTRpTDtNGJN6lnAmNEquF5TrVe6kprks1ylek+2es9m10ttr?=
 =?us-ascii?Q?WFlFhLQivCIZHXSMz3SBTvsT8r3Q3HR2exKt71uaUR3P6TU2IkIJ6BKPLAr7?=
 =?us-ascii?Q?al11UgFDXm2o7SKM4MPDndFv0mKknz91zdJ4cen+rfYy/ZPvXBO8YzNSoIhw?=
 =?us-ascii?Q?lUZY0DbFyndB0zARBReRpJaQepomsYc+opHcvQW/RclgLsAGcYYeYB+A+pAN?=
 =?us-ascii?Q?n9ldid99+8Q5XA2gemH65Th/LSUvf5vzQlh1fr9w6KXqqdSai28XRJ6oJ0uC?=
 =?us-ascii?Q?0UXEV5PYvZA9b11pZjjBgNmPTSTPqkg75diPnIPwG/3lyhkSdP7PtPHNUU4u?=
 =?us-ascii?Q?jouDvktvsnGo0OgOcu45/ktGGWPOJPOnaZwP1n5vN+Rr2bOOBp+D0zg0TkAB?=
 =?us-ascii?Q?iEEvJyI0nhkNFj3SYeg92YOnT2R2wGZXV5dkJro4RiifxPVYSGa5KZ0Pjt8P?=
 =?us-ascii?Q?+3PQxGPxeU0gcQG8c8NFYg4ZPoxYe4FB0x7CWGi0YdJaHJ/MXLxIryEK4wWd?=
 =?us-ascii?Q?CjeGmLRHbpJyMOq8RnM0PYRGnbwpR1Qvh6h/ozn9y6CbljUKzu9l326Dt0kD?=
 =?us-ascii?Q?zJjctyX5mBEi0SlgvVwo0UzZT5O1k6s9jHsjfixIwHydUelsQln4c/T879Cb?=
 =?us-ascii?Q?e5qH9W8EGelrFxXDgNn00bKL+yTgKiZPxMbUOiQXjKptLwCa/LHvRuIbqCKV?=
 =?us-ascii?Q?jAtTLtonCzUtN8fHR21gLQzPFovWuUVGbp8SGdXczQQWPRjfGC1mPSlQN7Rq?=
 =?us-ascii?Q?bLSSHLQw4qTUm6rFeBBJ7Jd3CM1QZMOcsz8PyI1b7/zd1ZpipSz4HGaypJcy?=
 =?us-ascii?Q?IsshhAQVVrHyY1+faVqCOTRmadkUkoK5YMWNOWvFUqVQrV9mUss0g8zTKFWB?=
 =?us-ascii?Q?/8wOdb+F1bgtNBTILQFx85h835N7716hiSGrCf36qw1T42ZdMVpEbne4wDzY?=
 =?us-ascii?Q?iMc6DhTm6B3p/gQz71XL2c7P7Q9tOG6rTg76ZA9ZDKQEF2LeSrVgtqUfZc87?=
 =?us-ascii?Q?LlHU7qE4tc51bEP0O4wcgtP+bIKB2gFA3U512WrKV19ScSfhfpI8GvBE20jC?=
 =?us-ascii?Q?bVVNYnaVmhKNTLgr5eoE27sCC7ST9lPivwNSyCz+gQH/C5qr63QPYKZMMRp/?=
 =?us-ascii?Q?w7x0++pjlBhvDYvrB5iptmwZ5HolBpkgzV6Uy9oqPJbRmP30648klnSTVM3T?=
 =?us-ascii?Q?OaKLeW9LYiQz7XoOEujB0Cmz66gbu2Mba+rHMDrW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280a0842-eca6-4481-113b-08dc10a0bab8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:22:49.4936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+9ETk0IBiVQQn6tMARulnMptZ343XtcHOXgVxxOLz4zsV/NRQ6I4JCEsLsgX/DvXzL0En6X73cqHjrO1dPaXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

Simplify switch-case logic by involve init_phy callback.

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
index fd83af238fa60..ac338a88fe21e 100644
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
@@ -1386,6 +1384,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1399,6 +1398,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6sx_pcie_init_phy,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1413,6 +1413,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1424,6 +1425,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx7d_pcie_init_phy,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1436,6 +1438,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1471,6 +1474,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-- 
2.34.1


