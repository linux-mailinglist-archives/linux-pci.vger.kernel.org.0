Return-Path: <linux-pci+bounces-1344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB8481DBD2
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A171F21721
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AE9D267;
	Sun, 24 Dec 2023 18:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cf687BAh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6896DFBEB;
	Sun, 24 Dec 2023 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDRsJoWIaQ9+hyuQHyJz9U7p/YCXruxKSIu7l1dg2kGZVcWqQ1ZRLVcebWzNoOpdOdRAL27WeTsrnYoWnvf2iynnSXuHkS8WgOCSARCsoflfxYYJNqoA6JzTCWVdMSRk6DrdomtIXiRWqNjFHkKHtyfCJ48LLBWALRLbMwkSCVRTzHjqaO5Sv2/fcaALQcFReXp6Ke6uY/6/onKW33FhFJkiigrqYTUraUcLEDS4BvCx2sn0UnCQ7De7fhfC1Ti1IoSidEpmpvNNxongsMnXBUcDua/OJXdvpbzKDpHnJ3XwlWivw8woMLQPkHY171hFxYABHwnaJRhvj0kAtye90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qx01HvuG0xZ04g5Qs1emA81XcCk2ClpOFDJT/IqUaUE=;
 b=WlvJ5kf3TTZmNI7IJu7bqm5BIPzBLE49I2npWUMOmtpaaxMPryUbgLeBpMW740HrRRbbWf1h3fa4RdwT9kseCNyZVm3Dm41ZqivoEp63CmpJPwf335IiH8k/2oDOf+22ag6ImB56f36bgu0H7XM5R7VM14CdT1E+mssQs030VjVYfYGsheSfYp75tP8+Gy5TJ0U9e0jlWMIUGICWROWUEW3bTFhtyWK8ObsK9qLoRfbIX3oF81AEQ36hq1zMjTlZ1tXpDo9JZj7dT3Qsj8LWkmyXNDNLY9sqqEdd54hi/ekjYHwE6ZWsfMfqNpbaJt9xzKpGemZycfKqRF/BRBmDcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qx01HvuG0xZ04g5Qs1emA81XcCk2ClpOFDJT/IqUaUE=;
 b=Cf687BAhoSIexO2hZaSJVHmtaS6/acaq3q3VCf4rfz2AhZNIPlLJUeNxxN1wAA0g3Od/eJSND4i21WlSJ/Mm+dSyoaYOEDU8xeSyYtRYSgqpwMzKkgnnCqJYYeVmD/GYTSf84LLgU8c8lGv5814GDfgvNQxEusav8X5D+vHGG4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:33:17 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:33:17 +0000
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
Subject: [PATCH v6 03/16] PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET
Date: Sun, 24 Dec 2023 13:32:29 -0500
Message-Id: <20231224183242.1675372-4-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224183242.1675372-1-Frank.Li@nxp.com>
References: <20231224183242.1675372-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c3fa283-5594-45e0-475f-08dc04aecba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KI3RmmbickV5X9Lgg0qQlircqnfVDvoxG2XuiKEQ8VwyFlkQhF7OLS/LSOouMTZnIxaW0ilnm4QTzi7520NkhuCD7qqtqAsAp5gggttod4qe1a7l9ZNh+csDbUIul4+3I2q0W20WZQbhyESrWbGJQLRZl9Qj0egl9plgjHrpFcBiqH5JKCUKaXteKE2lZb8vIxTLp5KRzCeSJX4PfTa2SbQkkad+WK5I71ogzHxobmdGr9PhcL1T6xeBdqzTKmrAT9MHWODnp55HEOYh4kw4YY3SVfz5sZSNRc6voXwBaKdry6tS/EUxK/rAc4CAvRuDl0WcauOIMk92bILhJWmY/S9uMDJ58n6gvspZk0wJZMmsg1yYRi+7bUxyz/HKRRwdbYry4wWpyQMoOFO0S/X8ND7BONBY+AqKi7GLjRxN18u9c6jP6F1DYNZADEZRmN4mSw6rRXw7g4hR7iJ7HHftgxT6es5aUUkXcowZ7iKYKVj70oE6gqHJXFENKu5fax/wqlr3EU7SKPjNF2quVMRY5tF0oJmnungDYYuI44Cnerg02ix9spntZ3ZZScJWnnabsgefzU7MqYmbB1YYOCK74BPaAbJg/6gpFx7MROPmUXaDiV8FulCLsDaauCvOvavN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+62e2MobEIdJ2BJp8DppPTmzdsnjhx4PGi+Ic5ouTr8ozRilx21tBPZtPR4Q?=
 =?us-ascii?Q?oeYojLrrnyG0c1amkQ2egkuA8TdhfahdNHT+XvK6g/Km2NdEIm6nrHUUsxt5?=
 =?us-ascii?Q?qA2oCzT3Ts8rnoW5jFmM6gQmiMYoE96+tbGmvmdhDU0BKnsK0M415ZAF8qHC?=
 =?us-ascii?Q?X13Xv55HPcrGz6jwCVNDG2q6IeGu69hGy/XaO8AWGGSbqahWRUYLHGHMvZF+?=
 =?us-ascii?Q?cv7bDxKrIH3iJ2bsPILAKbeiOCF1r7edYg7wdCbyS9zf1ZeQO7vZp4sGgTcX?=
 =?us-ascii?Q?KnVAdsh3ANd5DJZL2QAnyaPr7mvkWnqY2mTtM4/uJdDruuKjKcGMgJ/bzpCf?=
 =?us-ascii?Q?GFtgyuU2EKBYbWcg2c1FZ1FYrdI5CrNqd8nZLZf0VrEPItxDPUFNZYx8zbkV?=
 =?us-ascii?Q?fbWbb5oESf7qRlu9mF3dCnjLdL0EAKAZOqyCf5NzqrUHsDfAwIIzA0ca1m2X?=
 =?us-ascii?Q?uAEnH5lui4xZdAnlSJaj+uvByKO6/OGeeUfdopsGbjLVMmuA+7zvheQV2R67?=
 =?us-ascii?Q?HUSELF6k8goyRkJb0+btOiJYvJ7n/LLaFbxaPBfMYNxSSqc4XaULzpSf/EKO?=
 =?us-ascii?Q?z3WTqszZjJc/CDDlGiNxdKnvbtpE6jlifIIhnrFmZjSM2LUkfQ3e25dgiKvy?=
 =?us-ascii?Q?d9csn2PAjP2tDAkRt+0AOcc0SuFCz05QjozF6OeXZfk/9/3DWbFRkeXHjfM7?=
 =?us-ascii?Q?eLKb25N5mlEUDOOL9VOUEmexRkn+8MaRXQwK0brqLq8KmL5n0ov1QTmaj8uR?=
 =?us-ascii?Q?EN+ftBOmtodkJmldBrJu8Fm1c1DkG0euRzqwJwYLdlFa7Bz/RCsDNE2EdbCN?=
 =?us-ascii?Q?IHyn7T+5cFaABDIgk4Aq7U7/vYPQpw65njFby5may2XwCMDUtkCQmeOid+OY?=
 =?us-ascii?Q?Jh9cMoiZf+/sQXLL2MdEEi5sX6b+NiecF6E2mCEyuWD48KGBhH/7/bL0nnNB?=
 =?us-ascii?Q?LILeU7h0ELC97J5K6tjF90TnZFY6M5i+saup7hCShiepSwJ/G5wBTMRtEqQ5?=
 =?us-ascii?Q?49nBhz74zzOmOO23Gnjr8HcC1Y0ks6DWt0Ht1b0/dkBDAo+et2ggbzwsIPyb?=
 =?us-ascii?Q?0dc5KXX7Yo8BS5ckwq9MVB2pMUbVAnXICYHVY78oVaNLRZiQdidS3Ncygf+A?=
 =?us-ascii?Q?6m1sCBarQbbZprynKyd0A1oYS1zh+6EOxlB2SjwkjZ6fABSUOQjAMsYD2g1+?=
 =?us-ascii?Q?ifFZf4d/ZQ5dsz5F7pfv9ombccmyPJNyT49ykM4mcH9rSmrzcbCCVxlEibI5?=
 =?us-ascii?Q?btN8AvrDt4jatKQLiEOHqZzYRjyNqf9DAuo8TuQowtM3v4O1ecbIfVtwXuwm?=
 =?us-ascii?Q?tsZM7X1659/ZqOkwkIxcL1TDT2+q8fIuikDDVUmXKvQdoImlNMT5k6zlgBCz?=
 =?us-ascii?Q?AaUUvWWLnoMNB9CkV66kYNrC2IA/Kzd8xeWN0quurvv9iXT7uIQfBC6BnONG?=
 =?us-ascii?Q?xUVJTumJP+uG2R+8VUmx3BYLgmqJlgZ5RvSsVgvGBB3gfbnBoouuG1YlCQ42?=
 =?us-ascii?Q?9GqC0i2lkHxmtE1uvot4rTYXFTIYTHvpIdlMZ6OToSHqcheGx+navOWwnA5u?=
 =?us-ascii?Q?DaasjmI/1HQiyjAK3EM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3fa283-5594-45e0-475f-08dc04aecba6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:33:17.0140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozbaC3sEt90Tuv9vKgDZlfDzzzqTWDj63L2SJC8W4hgQHzDGEVothUwGdN963i9id1XngaVsrhkbsP7hUED5FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

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


