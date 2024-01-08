Return-Path: <linux-pci+bounces-1841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB72827B69
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1DA1F23D39
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA4956479;
	Mon,  8 Jan 2024 23:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iHTJak4B"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1727A56B79;
	Mon,  8 Jan 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jY4nIksURdePg/9rfAYQ34VeQ3JhZ+X5xKzMgkvhdC5l2YRwsYEaB4xOXSDyFPE1Z7WMB1Gm8rYbj4OUKcUhjLcjx1NNQe7tTdPJpFmaPXLUQlok2hQ+duXiqKFO9ZSTr3m34s3VGKBicJWZlpd51qh54IiRU0QMtTPoLTwnbT0EteoPAv0s+h4fp5W7HXHuIh0oduPU+/+KPOFDA7FjNpTYtxd6Puyn/B4tnef5HpnA7obEzXtgElvWzsfsRAwoFuwATnil/E6DaqfcOmpRNEq2i7p04BWn2mCJnJ8NUQBbkiWGN7ucyXzJ8VNczJUZuix0v3GLP+yY1biKtajHpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWzgstPYPrejbNDrFYjERu/16QgbVlwDCGfmZWRM9yU=;
 b=KExYyZHIvp/2DEKYSVWdA//z+z0A1M9zltCumCIpklELryAwawlx2BqstF6GlfkqSwNSuXSbM7G6dGZr1uoKQIsBjkll8Ox5expu/5Yfr8eJzHot/KulgdwANV7BdQ+1P4Ziwonhud4AzNere0sR0zR0vQPSvdYhAsKwlHbv6z+yKDB8fCKw25qXfVMl3dfz3+DHCFgIAxDcizdmwMRYbsj3zbl9hhxKeYASilbB2vFsYrHT0fRcUgtVwTIx1jxu8O75MDYFw2ccFLJrzPgIzfc0uYEhuhuQ4Y2gv1TnQcoYV7JT0GFUaZm/X3mfslZrw2sti619FdIUxANTiytFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWzgstPYPrejbNDrFYjERu/16QgbVlwDCGfmZWRM9yU=;
 b=iHTJak4BsYQjmz81abSpePwgg5EBfsudXmeHL84dSeeG/XXzTEn24IHGdCe0+h163vUDWogdFVuqoFx8i1srmivgiG2G5ihCDUQNDE4B4SHtcW0WRq+5HF/ulK4as5hTR57L/ffxeK88F18w4femE+HIRm7cIqvpZYXJoK+HZ1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:22:22 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:22:22 +0000
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
Subject: [PATCH v8 03/16] PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET
Date: Mon,  8 Jan 2024 18:21:32 -0500
Message-Id: <20240108232145.2116455-4-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d4fa8340-0f75-47b1-b71e-08dc10a0aabc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	inced0+LshkMElb85lcWKXp+V75zDgGboxWVd/lGN2X7OxilGZ86USTnbxVOOlBKx8iJEX7t35Rsi6SR7NUNdMIGwL4f21nghStX03lxkI8YQwhF3SBNzUBfTjY36RrSRgyH59DTU4dLxqrQWXy7suAckkgKizf5QRigaqAuAJWRVuExCJ3AN1l2F/R/UhGN8PAI96uoqkanrhwaHE5/WeIEaHZrE/0Bekm1k6SKwUtQJWCy9hZn236HlwTH3/WMdkbiz6O0fuZJ+HPHVAeBclf+4gVEZPwwIko92uIB5ppqOH9Uei9+tz4o6Rwm2b2Xm0a0Op1YmtxdRCMQQDlofngRdXKsyv7NACkCehxUeUeBv41XFCsICm1A134vaXwZaghvl2Skhf6itx3ajOansyTwTiqwfV5QRSKOoz6Ale2shu0MFZckGqoy2QElgP6w759bPWTSgjkSyMKj8yqr32Af+GRt3RrOQRc2XEJGnLJxjFwzT7rm8Y4E9L1BPMj1uX1LURqfc2o6D+iNPvQw+CJ57S7vSA/xIU3VALkrA99ajMPodPjvm8ZWZUQB+e23w6eIjx6wdUywbmYRmXh8DF7rxPCCGXbJeW8gh4b3U4Vp2uk545eSdbA/WeapvC+/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?55dAt5sd4uwoIb5ekSMs8PSh6zHzDyv3UOF9EVRuRk6S2+BZzEe9fx3i0J8J?=
 =?us-ascii?Q?zi5WddC2hpQZc2HPUd8B25QpISzbs1y73Znizquz1Eo0p+2nC724Tkvm2KbE?=
 =?us-ascii?Q?cszv0G/vnWYw6IrJQJ+sPrqjNQU/Kt+d31gF3lqgX0xaez5Gt8RdYUG3dKhz?=
 =?us-ascii?Q?KhI6sc9kTs0Y69lHOS4wFO+WCcbcIXVFu/dBzZJHd/GEGKShKAdeN6OsNgCH?=
 =?us-ascii?Q?afSNUhwsWehX1JCL74j+gAb1BU7IRHpC1HhgBaeFfRFg5FOY/9/J2HEZhlfU?=
 =?us-ascii?Q?E8Ypm0nCQhxM2w07PLtTBjVW6MWf60txgILvXy1i+SnjFtxnTqONNrxpoWd4?=
 =?us-ascii?Q?QLULUhr+LKZH7J5kc18gxawCDQfVV3QEq5rFFc42iIzRxp61uOAeizw57oJE?=
 =?us-ascii?Q?MEsUii+MWV8JlHeamwNjPdtgsb+G3hNZ0qa3QMAf0QE57OJ1ebDExdIWxR9U?=
 =?us-ascii?Q?V68VXHro7StKjrnIAW0JGYcCNSfjy3moz+2ht9mqvjxQIGIbPCDvUOKt7ANL?=
 =?us-ascii?Q?q+6OtIKTcUN3vy4NGCGi6QhkoTdzy4Jnf83sIgdKMiFBV2vHtz9/RSVIx1LZ?=
 =?us-ascii?Q?u4adjnAwL7cB3ZiwiVVWwrMtTVDQlA44MJ16bXaZHrhDXQIsSYFSLMNULJTj?=
 =?us-ascii?Q?FTO4Y1L56hpQUVSHrAiu4zNI1u7dqip1mfC8KffdkU7fmWtVcm4rXZRRsER0?=
 =?us-ascii?Q?E43jp2oEt4lb4iJZB4VCAFbP+3Qz+mfB4uRSsvObiLCO5KDEwE0dDsevSieg?=
 =?us-ascii?Q?0NJBqHG58LRHW4Yr89+goM/Q2Lg0N+/YXTcsGDZyhafGTSF4BpIyLvz5K0O4?=
 =?us-ascii?Q?IyBEonHufoDKH72BPNW+5i90lANFRlMiPkuqB59UTeuSxJILeByH+GRNasqj?=
 =?us-ascii?Q?6Zj7OvM+EZSdcrIXRXyylnzQ1fcqt74qZXkKeXQlghawlvN+8aYs5xMSBjCu?=
 =?us-ascii?Q?uuZc/s7k2OxzWcw8YR3ZeIs0mlSFQuSx3RNihHA+u6NwF/trqIPSyTd2GYRo?=
 =?us-ascii?Q?YMEvu2ax/+54WO4G015/PxM5ahJp8+vY2Xm4FOcuW/O7LZ6f+umvsWXzdpWl?=
 =?us-ascii?Q?aMipS17sAP8EIOcJ9NwN8nxk7q5p9viePqabvrpIQtu5NZ0ccqCwx356cmXj?=
 =?us-ascii?Q?EaIVzSiNSTJkrU/JkiHfplCywzzEZ+AQU7KUDCyJb+rjDUclhQ/o5h2fhcl9?=
 =?us-ascii?Q?lx2JdylAFlXOmSDhcVgyapQEivx2HhIIKXBVD4X8O9e80xs3tGK7qmBPCCDM?=
 =?us-ascii?Q?R5eakemw9M+I/oU+SwmyWSRkrd+x57z0Gr5zTAHukHuXgS9Qi1E413XQ0zSl?=
 =?us-ascii?Q?HIgFDvJ/EB6sEqPyTreYqQh1E9fcweS3PzfMvDkcNpoNTubBmKs3Vmh3zUyC?=
 =?us-ascii?Q?6ZCEKpRBqtf44g9BlRh2NB6x6hFPasqEXo8aibnnlci5PYkC5FxO1GgwmoV7?=
 =?us-ascii?Q?xDyHYecd2kOr2Fk4V6jUTdXW3gYSBPBj0tn1BIpWymY6dUu18bFAG6gB7Fei?=
 =?us-ascii?Q?/SzyoskCmLTLgJUiCBr7WnurYYWauXSQcHBhm6yLfGnvarmAfJkpAmVNn8Mz?=
 =?us-ascii?Q?DvOWS3fP33sw1s1eVe+8jZxvHm1Sf3y8STSVIoy/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fa8340-0f75-47b1-b71e-08dc10a0aabc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:22:22.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8DWkAYR9kcCTKhP7+jQU2+nT3IViHOlDh52IaTeWn7z9FjI8E20nGwyViN0aThgpsPbVLJuuat+r4jUTPt6VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

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
index adc90099ec7f8..a1194f0a4c084 100644
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
@@ -1450,13 +1416,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_phy,
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_phy),
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx6_4clks_bus_pcie_phy_aux,
 		.clks_cnt = ARRAY_SIZE(imx6_4clks_bus_pcie_phy_aux),
@@ -1473,13 +1443,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_PHYDRV,
+			 IMX6_PCIE_FLAG_HAS_PHYDRV |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx6_3clks_bus_pcie_aux,
 		.clks_cnt = ARRAY_SIZE(imx6_3clks_bus_pcie_aux),
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx6_4clks_bus_pcie_phy_aux,
-- 
2.34.1


