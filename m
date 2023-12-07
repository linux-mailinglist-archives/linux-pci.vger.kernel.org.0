Return-Path: <linux-pci+bounces-631-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11185809181
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 20:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994141F21206
	for <lists+linux-pci@lfdr.de>; Thu,  7 Dec 2023 19:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41AE4F880;
	Thu,  7 Dec 2023 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cbi2qICh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CAA10E3;
	Thu,  7 Dec 2023 11:35:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWOVr4va6qS7LYlh5wEsyBG6d66GRfalTC+5Lw45SsGvI0lZFSJ2MASxVuZc0yEt1OJ6w7XmhMJtDYF0e7TpxFKAZImAovPw0gcNf1eFTOtDnhSZXyeLrM5Msz3e8Uw/xc7Uk/PIJ344Qr1WhjVidnECKV95t3IIsoa3HgQ0jBE4r46Fo/DisktgLXhm8t4DJpFEsOLn/cIigatOj/d2SgXwMAZ9MbuwR9uID/INfdheML4hKhtg8wvjZBpr/aOffvPYcRRL2Hjm938AkVxwLog5aqMJzsLK/boiL1vJ7VQtyFujHv3TACqUwG3yexRN599CrxsNT2ywvc6Il92SHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USVYs4/Ey2cQMssv3OIw9XzOwZ9t3+TOU2azctiZStw=;
 b=V0icdqcyc5lJda3CAReNvNlTl7Se5jCH8KVOB7vppxHtpNdD9BVG2KyzeFi54fpoEi6b7O8nyS0t6yHRraqan7hHY3FLNVF/Hrnw8V2azmxp2b7hUhQE5UcbQdjR6Spqw/3VC5h30jVR52LAMKCb+qdHL8c4yo8Cjx9O0Oj/t3QD5ZWu60EleAkP/q3wnk6oGclrbeEv2biEji1vBmXHeb+qgCKaTauSua3MKGAz8Ap4F+x5p5SqDY+98Wiq19MG/JT7LTmN59q3tKpKuYWRGOXiR0us8+vahbSj4JzbA9OI+IMBvOT7aiVCMG8uwD0paLCRJj9kWoEWfcaArVcsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USVYs4/Ey2cQMssv3OIw9XzOwZ9t3+TOU2azctiZStw=;
 b=cbi2qIChM268jZt3jKucaezhGh1X6Px8NaSLj8aYVgivT00sVqiVKgQuvoFZLLj94GIvQdkylqqh7TX1TfDGUde33JPfBb8zyJV9+7E2EZv923FUgHgPbq7+Rc+lezlV0LvH2I6i48xoYSiEuCH8/YrNFykgojVaHFYZZ4lf2no=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU0PR04MB9635.eurprd04.prod.outlook.com (2603:10a6:10:31f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 19:35:27 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.026; Thu, 7 Dec 2023
 19:35:27 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org,
	manivannan.sadhasivam@linaro.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
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
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v2 7/9] PCI: imx6: Simplify switch-case logic by involve init_phy callback
Date: Thu,  7 Dec 2023 14:34:28 -0500
Message-Id: <20231207193430.431994-8-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207193430.431994-1-Frank.Li@nxp.com>
References: <20231207193430.431994-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0348.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU0PR04MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d1c14e9-64be-4bba-d96d-08dbf75baa13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gxe+qtRv+VTD04KI9BNPqC6Jxyte/IMN92kBNrk9wDk1hqRuc+E35DrQQfJ8HopZoG2JnsS1orJwOIBupQg39i8jqo+9DktWPGSi9ivmWu0TrxqME2MPptLJDglGiIl1+8oHGnqOsQmGyTz0U1406HLFbXv4R1iGpW0O+ejiUXc5QdXKj+sl73AtjiPSkRvnpkz4DbHemSVZf1RQ7ZnoG9AUllGyojGWCvjWyh48ftLB5D/U0STPoLHhQP1mQPxzfD8bvoxfKvc8ilTCg5XtfkZIIOcDG9gRQOdiHoDx7l5rd1MROYBeU0wDCzwYh4NKEbhyxsERm8lflC3yOTLlPt4pD85idlJE1Nc4SLLMfMfkOMuXNFys6tw3m4kHgh5+dfBa2yEfClxqVZYNnWJrfLiaG+v+573yzW7qLeJt9yI8e1330FBLYzZ6y6nqJkjVKPa1/qV+wwispBmoGyFqyAAbvX0YcZDhRCSW5Nqj6LqqDHO8CbyzqdSU+u8Qh59HkEBOK2HZDH64BVKjFEX3jTPpKvtWpY6zrngqmxxZEbyP14axMJ/eCCVpfyNOt9S2YbhXB+OHz5TCirouE3deAzhVCCmPXP+aOWiUhjSzF8xd5zfzGfot0cverXj66q/c1aK2QiRrYOI9XkTEeoGpIAeK6ZzUaDzG2Of6KpBE9k0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799012)(52116002)(6512007)(38100700002)(66556008)(66476007)(66946007)(316002)(6486002)(1076003)(2616005)(26005)(6506007)(83380400001)(478600001)(8936002)(8676002)(4326008)(2906002)(7416002)(5660300002)(86362001)(41300700001)(36756003)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CxRucTMphaivV0vTLUklXABOTfBmr7aY5SmVBTEt/DV0b36ZMzwUXK7MOWWp?=
 =?us-ascii?Q?9jFIv6b3WaYpZm0p3TUgx5xSY3liZMi+brFJVC62qbbZbEY3qZw1S6ZdVuem?=
 =?us-ascii?Q?cxUTnpwe6fjCwUpD0PsKf9J2vsZn2yXr1Ta4GQZyKy2N3Gr89tvqeM60EadH?=
 =?us-ascii?Q?lqf6/7TBms/nKKdCd0tgz5BNevGNmPeVW+/roj0R/fjs7szUSsP/YOmXIzkC?=
 =?us-ascii?Q?E3gKtdgPS7hI8Ci26jmPs+vpnebw3bWL8G+Ct5+gJhZtUZyViqfpXMc5Gaej?=
 =?us-ascii?Q?3Rlh76Odvsq4s8kLZu7EB/vxn/xDur1pCFJZCIZVRbUvYhQtOcZw5vYxCJKz?=
 =?us-ascii?Q?8AtgfzkcqXndw98+4AY0ZFtJO5iB66abi5RKQMrnXxdYFcIvxe2weWemDPeg?=
 =?us-ascii?Q?Q3PfP9Yz19ch65/pDqepdo56cz/mQ+VdM3Ecfenwku+TVsg9IErCSLNyCbmI?=
 =?us-ascii?Q?IMrvLT9ESHYotvyDZYTWNYxNpiiZqT392twox65hMxXGeNXbwZnL5ALdz80u?=
 =?us-ascii?Q?X5cf4H2Rk/dBUpFZIHhh6RwPGn3Fmg2Y961lYttMv9upM8bofk5QZ3RMPMw6?=
 =?us-ascii?Q?DF0qyZ0uOKwl6mvDIqjORk+xYT3Xx4kocUgHzamUQHWWUh/UYSyR3h+d9UX0?=
 =?us-ascii?Q?xMCL+QYpmu4UdqfhiEdHZKfvA9ZDgQ9TmpgOXPvvgaeq7K/c8PZ01cq+NJ6G?=
 =?us-ascii?Q?Gd8SV+/mxDBvcixhsgdHFm3ByAUOCfs2pbAdJTHnZF+vHBy8ve++/9+lUZAL?=
 =?us-ascii?Q?l0d7RbOZLZlVeeWNOv01lKpJ9SPkO0Djx9iMXPXQerzNbXJNlaRhVX5L6hn1?=
 =?us-ascii?Q?7/hU8b56XgRvglkMQB7GxOyLIlcabvxbeShBCkCs0GqS4bBUFG3LsXv5VchN?=
 =?us-ascii?Q?mfOdWSBOaDy2HRN1nbx5EIOh1g9aMmx2B71851zwq/40kJAAO6/VRGFuOU+W?=
 =?us-ascii?Q?3qcVgB/4UE4IWaHbE++x4QM7ISIXPb/MyXEsfgA/dlZFcHV7dfyCGoKUVJlG?=
 =?us-ascii?Q?Zu+/LGH5sEyltQww/grAKDBccVFlwYu6ad3FWLEx3rMTVbK57Oe/8kjKwty4?=
 =?us-ascii?Q?YOSr/cuksuvy/Z1LWpAcfkycU8qTGMzJ1ZRNz5Iz+F9RLeAfjAVx7JesRWL1?=
 =?us-ascii?Q?xVilYnLUrwUpYphtOUJA6j/Zr/4h+6OO2OI4wJFiC8GoF+cuCqTla3zn0isN?=
 =?us-ascii?Q?qMf2NGFkNT4jSBEBhElfgxxsDL6+YSkVFgTskxhQbIETyIbjIp3I8hsHZN4B?=
 =?us-ascii?Q?MCC0sXDsoHnAP5ZEch/8oPpn1iKVCuADOVDgkZ7nggHVJ/bXubmLXN8FTNgD?=
 =?us-ascii?Q?2QWQCwd5L/k6rVrCVgmKVEsDg/5C89lvNNxgbfvKWdhdbd85e9Kd5kx7cw/P?=
 =?us-ascii?Q?JarNmHyXLdT+g3KsU08H0LX1YGmCXM98S7N5qhbeXB09vZKJrGOQlwLdVvID?=
 =?us-ascii?Q?rJdFwmeTfVYVsJVC7b+dj2ND0P2HTw3YlD9ONluXRdU7ImAiyKTuYtqtlltr?=
 =?us-ascii?Q?TAHVVBtIds3EueEJMYehYylTLRC0ClA79pw7wNGx79gIooOUkqkAxqLLZTWg?=
 =?us-ascii?Q?SX4jEwnNcymavzWN634=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1c14e9-64be-4bba-d96d-08dbf75baa13
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 19:35:27.3368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpBJmowdDDX3bfX4znCmkrvc5/fiuoUU930qgcfV58JWzdp141hFhygdn2HRRnS/ayLqEnr+hD4lCHKFD/kUpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9635

Add drvdata::init_phy() callback function, so difference SOC choose
difference callback function to simple switch-case logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 135 ++++++++++++++------------
 1 file changed, 71 insertions(+), 64 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1fac6129eeb5f..4e55b629d4efb 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -70,6 +70,9 @@ enum imx6_pcie_variants {
 #define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
 
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
@@ -326,76 +330,69 @@ static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
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
@@ -939,7 +936,11 @@ static int imx6_pcie_host_init(struct dw_pcie_rp *pp)
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
@@ -1435,6 +1436,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1447,6 +1449,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6sx_pcie_init_phy,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1459,6 +1462,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx6_pcie_init_phy,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1468,6 +1472,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
+		.init_phy = imx7d_pcie_init_phy,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
@@ -1479,6 +1484,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1511,6 +1517,7 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
+		.init_phy = imx8mq_pcie_init_phy,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-- 
2.34.1


