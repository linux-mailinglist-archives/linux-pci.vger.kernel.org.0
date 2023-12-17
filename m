Return-Path: <linux-pci+bounces-1105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8AB815D7B
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F364A1C21947
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E817F8;
	Sun, 17 Dec 2023 05:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JRHNoUAo"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2075.outbound.protection.outlook.com [40.107.247.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F0517EB;
	Sun, 17 Dec 2023 05:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YATzOA98h4BmpuYwv4w24BwfbLlaiAn862WgEcKdU1U2bE27YVr5LY7BMXiZ364X8D6fH5Krm2SC/sMvbJMS3I/J+NXVktL6kt7HWyfp3HcgWOc5oU/lmLy7cqyTN0tUAfo8vR8M3Td+pHFxXvyiqNsKXYnN7RXyhKEcX+X1cXoV+m2HtE1r5uAuM+YdVNMOtUTiNjUse7ZOUwhe0kWMjIlwl84VgnOqvg/IxldgIsek1x02Bq3qOwG2+nh9kY/2rV7IBYNxjmurH5K420dsTho2MCPFXs1DOpV8nEHhX0CSSNytLLTNW/Rodpa77W9oiRh1jihthc95Cw2lEkGCDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dCc1yfBlk9+ifAPTT3hvp+9Icvwv4GLYdp1MDbDbVfo=;
 b=BRt6uj+qZYXc6VIUn50hoLvDYNxASRVC1ByuFWk2RyGaiyBNGGc9U0GIoY2ykSBafvr2o7hfxiiTM/NUOHqV6/7t/0TDKR1K64a7UfvGHvx78Yc0J5CY0PwDRu999K6ZaRdja8SwAH1QO6fzO/Anr8Um7kvPKqZi8JN7Bx2FXS6JosJTTOekgM8G3+XWRkptzd23zuA4gjn8yObkdF+eOC39bFYW7P7rO7nsq+1R6DiCeEWDdi6wkBQ+AA0ddzKWOTP8NfWocBl9tyYeAPjV9OOrMTXKymmBqYVVmmmV3ZRb0iMipVmqaPV2BQ+gtq8yClDlq6ewNwdFWt54KMe45w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCc1yfBlk9+ifAPTT3hvp+9Icvwv4GLYdp1MDbDbVfo=;
 b=JRHNoUAoUXtcdoUFAxXRVGCHBThiK4kqIDZFJOEr/kmFQUbZ/93aY3r95w1Ar7rX4hF2VamkYAeuHBFDXTXek8nqa2iM9WIvCPv9XSM/t48JrgZZ4nadhtXKpt51eMWtGaMNcIy3J3LtF68cxJM90tKSqi92AoXhsCS3iyQM2aY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:12:50 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:12:50 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
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
Subject: [PATCH v4 03/15] PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET
Date: Sun, 17 Dec 2023 00:11:58 -0500
Message-Id: <20231217051210.754832-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217051210.754832-1-Frank.Li@nxp.com>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: b38736bc-4fd2-43b8-0d18-08dbfebed101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dCGiAuQj93IxrRT+jwuzq7zMTZIYedUDEGzGQWN/S5XaQWXq2HphJJR8qnTZKBxOSvUVm8KMvA941rPnYpdvr8BgqI+46uU+1h90qw0+5OYQRsHN7EgE6a0wOKPougWIk1RFoxcH4S9+yUyKIqRkYB09V0l6ur+M+G1W6w9qftN5MzibSYoU73zr3Ezy+sGB9/nh/eBjQQOHr/3UojZsRxe3g4UMBYXSPWBOezviv4mR6lJFBsZ3wwSq1JNt0h5dYkL4H5Ya2qA3th+jdlb11evQaFWTyqdVnyg9JdlFDibArk8JOQg/mIFI2nG/o3gBPyNIYnuflMeqNQ8jUg0fdCTfrRz0tKxRZDAl6yYjpfKexLvqYRvp1bw0VhhCF26JoEHhVc6O49QRAfeVcnPCU8+59eExY3lrw5WR9Wjj0nXWG7J/9rWLS8OlLFJ9GB8diWkfoNXiwfp8YRxUfMUT/BNLHq7ciyDk28UCediTdvTcgT2iKknK4gXZa7JtCohmlFh4cImKi8nat0iz+wbV6HMB+VczHAoKTQG+707Z9sqC86iw+VYOCQMIHfHfm0F+SWlzPpXiGcgFoVLihO/5V5dRgjMQ9DAfRLvkvF7XuxxY3gpfSNyFSr8z33Al9/yE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bjj4qTPeITTMaGgX5UufndUxXpo5VUuKyzsWQ3A2sxgklRVqSS9i2aBvyHUg?=
 =?us-ascii?Q?MmScQcsSV63gosbjmF6WWMuA/PMBHxAKn969xfijwftgce8vgOffX9nYj8X0?=
 =?us-ascii?Q?hGRy0LHy0AeNTegf09uMw7J9XneAGH1JnJRm72LrFJqcO4iWXtOuHvekAVJQ?=
 =?us-ascii?Q?X9WSlrAje/T9ROx7e73rRI06dffFDp5AmLpGCCtEdbJ08ANS04gEnsT+3lG6?=
 =?us-ascii?Q?Bw194qax8InRilv9Gn3/2eb6UVbDdI7zHLCuIcKBvd7Ygefht3aPErnNBoKL?=
 =?us-ascii?Q?8KV7YUrZ5x3S5qdWgHDNtXQlQ2UqqutQLTBmtzjGXNugWZ1AU1Pq/fj1JvnL?=
 =?us-ascii?Q?fsfqdLtwkDlO3eprpnLMSAm+wbnr/dpZEgcWXT34AYshLscxGBwjI/vBptt+?=
 =?us-ascii?Q?NBYUlZR6l96uCdwWUcUoxNvMgssGbOu/6VHVUQiRxiSCHOY3j75ysBe6RZN2?=
 =?us-ascii?Q?TPdCazuDH6bpHfDFnrtD0ELnFYz2NtXOACL9+Qj6rlZxV77eXeJ4LNqjGBqd?=
 =?us-ascii?Q?qsiCfPiJTZeAGsH0SE/WpcVSr2XsaLB5o6Q8ktfK9mUpm8FNwyL8gq6j5Fgv?=
 =?us-ascii?Q?c85AAacIGWVMtBvkwz4wQm3ttXBiM1cius5hxUXj6ug5vpbnIkX36GfoiWyx?=
 =?us-ascii?Q?PRXCmBKcStpS7JMLFpLqRijn7TgZF1spOoHG4qpP/CL+cR8RXXBBBdtL+H/M?=
 =?us-ascii?Q?xj6sAMdE+ZvRM7lQ1QWnXGv0M59xRGlr/8YWSueG9b8zQG9mMTC6r2mcQDxn?=
 =?us-ascii?Q?sQ5BjMvdq+TBb3PKJ6jtBSCf6gTZGn34uouqV8s2qaLdkVu7fdSAIvcplg9O?=
 =?us-ascii?Q?wQrTu2jmJ0j266MwV4pGJT6RkaF5Nh/i/n6UpY4s9opxNGP2IFFC7IMuySKu?=
 =?us-ascii?Q?IA65joUlKtKVpAN2upk+AHamKdS3cxyCOmKgKH9j7p8+lXIGVHNv8h7K6O2W?=
 =?us-ascii?Q?Afi1pyBbgQ4mFsz0cxG+CXWWpOQHRM3x0xL/LPGYcHvDGIvg9u1eIqLPFgrb?=
 =?us-ascii?Q?t9Bnhar7jwliygKgoPCTMc1R9H2WeSl5Ag9hEM/st/so2eIdcUDUsqBhJApY?=
 =?us-ascii?Q?PwTRn/MYMpX19x/89T306w54syWZu/34/aN0uZiH3HLFoPBIYIruJJOcydzB?=
 =?us-ascii?Q?lwBxtoOQoMBNsCn3EA1xjKf2TJQhnLDW03zaWWOiaG76ZQ0nai7BxQBEpalZ?=
 =?us-ascii?Q?RoeOzHmBhdfX1jxGCIFdFNXmNdKoxZhr59d1THE1VstWqXXJ4hNUMUiwLZQb?=
 =?us-ascii?Q?FJdN0phjm/eB+UmTqCG/qHlaUd2z16752selIBZEsSCE5ioMm6DRXoOEh5CB?=
 =?us-ascii?Q?gssLvkfkK41Am8uNtXVay6386dXifkwPZMVaGfNvhHewH1J8zJoWfg6eQrHM?=
 =?us-ascii?Q?chcLdy0No6tHfvm5F5/VaoNcfskKnEEJ+yAh9VZE/5KTfLkpOTE4Ve74Mj5v?=
 =?us-ascii?Q?6yoGP2BhZGL21ZxJAROw5A1voKMfq8Eh4JUWv1R8EiC+FWkLx610FAj8ftt6?=
 =?us-ascii?Q?yGchmtTdXNp+SQeDg4DcLK36u8Jb6uPYkooG87w6dxgekugKWNqDQg4sFbhE?=
 =?us-ascii?Q?u7GQwR2uZSgAd/0q2TQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38736bc-4fd2-43b8-0d18-08dbfebed101
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:12:50.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +X+aGZ9RU/8LX1luRRGbhitDUAsDR9q1/IdUH34+OT5pjddZ26KIRmu6DsjMu1zeMVK8JcYlNuZFkRNNKRHiCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

Refactors the reset handling logic in the imx6 PCI driver by adding
IMX6_PCIE_FLAG_HAS_*_RESET bitmask define for drvdata::flags.

The drvdata::flags and a bitmask ensures a cleaner and more scalable
switch-case structure for handling reset.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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
index 91ba26a4b4c3d..c1fb38a2ebeb6 100644
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
@@ -1441,31 +1407,39 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_NO_PHYDRV},
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_NO_PHYDRV, "pcie_aux"},
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_PHY,
+			 IMX6_PCIE_FLAG_HAS_PHY |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_PHY,
+			 IMX6_PCIE_FLAG_HAS_PHY |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHY |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_NO_PHYDRV, "pcie_aux"},
-- 
2.34.1


