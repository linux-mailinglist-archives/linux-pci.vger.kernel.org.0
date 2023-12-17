Return-Path: <linux-pci+bounces-1104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4067E815D78
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:13:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7D141F222CF
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD8BA40;
	Sun, 17 Dec 2023 05:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g/ade2iC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2084.outbound.protection.outlook.com [40.107.247.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA6623C2;
	Sun, 17 Dec 2023 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aFV1MOWVd+o7AW21bOepRF2zDI1UgIVnaNpGoY12+NWxS7ioMQGWbWHloz/W6Mp3h4Cvxa11Zl9+nrEAwoevJfTb6FGHSTjFXM4IYABeGP8ApcsHOk0bWH8R/v1p02fWzwbJ0u31SFE4a7ZcdvEHyRfJtVow2JTkDpxllOhZm0unaOT4/goWv9y7ReIIDhLM33tVvDwChnaPL8SYPap9j0bKkjxs5KGyFM9QRfOuHGBPOe6S89jLMgtfc0tuWjDHmwzTRmfzalGw9L63jF29mfaZkks1V0VHHPJWaOlaXtNA28eMjTN4RTkusLSdOVUfxsg1I+w8R06e5ZoUt492uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RihIXivSmGuSTmPuPKrGg7/Iy6cYq+hMDfd4TZX4boU=;
 b=X6S+aKB0TFWMRMkMgPsoSoT0HeTAuYFxN9aMOiORa+2nESuXSM5jI24pBex4xChkosGhkd6zysQw30jHVEObVHt5LHDV/yhV3O9SaxyVKaZOol/1KqSjGL9Y7+FiGKr1ivkgDW0mV0h5BSzkif7xJQCGXarsBS9XmiV762ZktTlixfnCnzZawjq9ij44fMVm3LRFeWWeNAC1okV7xrq/yJ+iPIeqamMj2r6afdN47EKI2MZHFoZXWpHqQeuJW/C9PwjYFFx0N6c5BAKm/1Nm0wCweCzR0aTs62Pm6H83mAKAOKB/NfBlOavbI3TyrPaIHf3oaK3mAprJELWbR9cCrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RihIXivSmGuSTmPuPKrGg7/Iy6cYq+hMDfd4TZX4boU=;
 b=g/ade2iCpOFtMD7tSdwk4YsyTZJZGmRPokke0B2+Tqh1akIbJxNdo03doAjyqYhEV5uQSM8omMaNsyCbo0WEcXEWLIyh+cD91Jc1W53aiXvY8RfaU5lBSOGStkrs88YwXjxvtcaUTXOuN5PFzCJxRW5kQtLPs7yyCVs3vOoHB9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:12:45 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:12:45 +0000
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
Subject: [PATCH v4 02/15] PCI: imx6: Simplify phy handling by using by using IMX6_PCIE_FLAG_HAS_PHY
Date: Sun, 17 Dec 2023 00:11:57 -0500
Message-Id: <20231217051210.754832-3-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d75b788b-a14b-47e4-1db0-08dbfebece06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vozx2Xk8psWxW7cFd03uAZeibEI8zk6AUBTmntFAJi0ym2Y40eAfe6EhrcNlscWT6cH2ymFaQTsIm/i2OMMqI1cn5WkB7LacU7fOtDk3Cx5dH0J8ynF9Jkycu/LgFbdLamnvjxliRwO+x/pm+HihZxAZwueCAkIyqVJ38XS3F0kE5p5FWUMSGj4JIKEyTnvLybH2ozsaCTwZt4ooSgqzFOYo4DPhzKfkdKHq3CPQEb6kcQCYVsnf/TMpTZGr1RCCq70W64XuzC833pN+vLtnudrMXpzu3UAWRHslRusHNLtGKYCQCy2CBrOLDcsMh2DwWmIZ4zfE5yRKVIQryPJ1tCBGiUU+Ngr2SYW3wABtnClXWP+kBEZ15xOfZ8kuniMYgb+FtYJsmu01KSWUfmcAZYlUxgdQnNgIn1FNGSdOidId+RSL1lK8QNmaWoC72BqB968+KqQjhYRCrLbLcWZtPtlU5m1A4RXOzyjJQfNOsTfO18ZMHG9osv5MGsQ1VZtyQvSSBKKFIhKVc4RZ4g8vuUzaJdJMR/GqLQYZSPiYaE7tiA7568WV0wEgXrXPlIdJlCpmB1oZHCOjP1N0mm9uaBhwgy4BQQgPPshV+xzXx5/8TRLM4EOQIGuG5o7WA66A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6666004)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DI28Cqy3Ybo+22MIEJspsy3yZalrjMbH8L8ObhV9VOdbXiO2irnZx3ukAfX8?=
 =?us-ascii?Q?yxoRJOWLo9oKg0d/MweLlk49VB/aNmZ59edmP+rn/iBA2BgAHi9Sbu2XBGfY?=
 =?us-ascii?Q?/kFueqQ4Qch7LahAqHGklL04aRGYHrr/C0RjlbX/5ayPOwGonKCMxCwYRMT2?=
 =?us-ascii?Q?YCAAu6u/GBRMIUFql9MXTF+mp2ejTjyi23FU3fGjJN6e7nMXwPq2LA3fTwCD?=
 =?us-ascii?Q?se9Hzfz8+D13clzZXWN9jg1EjtMYuBCB2yKMkMCNeWvTs5OANeLo/waHGh/z?=
 =?us-ascii?Q?ahCdWahMOJFxpA4bTNpV21Djz7lJnhsocq5x4K0gpl1ltxtdOG1FZW5GYlwK?=
 =?us-ascii?Q?W8lEHevgZUI7aiMMgkQbE87eqmMGbDso08TKEVJdc4J+Zgq4btAAOfXa5zvl?=
 =?us-ascii?Q?OFJC7ETAnbNi3Zw4dBNeqvcccJTDYcBDC5okMcH8ugzbAiesj0AGLGEVoE28?=
 =?us-ascii?Q?KDBjP2K3bhJeFOTvygs2om6uR9kytQqFGQn75Ec0SakFM+4uxvu3ZNqql2Cw?=
 =?us-ascii?Q?mxHRDt3ZA3pYddId8yEf3E18TuS79xP4Vc6v+qHHuqTon2sB9llA6rNretBv?=
 =?us-ascii?Q?nrIKSmU/9DfKXdwWYT03K/LwgkN2sqeddXcsvaE9CDIHLGutPUZg7CoJYue1?=
 =?us-ascii?Q?NRsMlmlEBSB1pbniJNrJ4DNFxHk3sp6zrW5nSEb79XzL20VY/0bXa7Ozr39E?=
 =?us-ascii?Q?rsMdxNnelSkYzUkfsiUj8Y+H6be8PnOCHAciqAU+0m0us8M5PX1T+6Jv+sWz?=
 =?us-ascii?Q?+rxlLHBMx1Rt24y3KxZvBaP0TCMP6fQMfcO7UDigEhBb+6P/gksfcXOXyrWc?=
 =?us-ascii?Q?bqnqv8SainxyDtFsJ+HW4k614bbJsofFzZnRd/UvMKiiHIh9Ha5ap++lIQF5?=
 =?us-ascii?Q?79yYB+E9Pl1bcCtHMMmhSh91tlsre9q2yqClqrUrISNVI1RIMq8+ExX7Qfum?=
 =?us-ascii?Q?arla3SVh5Wb592bsiXnALyg03LAHYCG9guGBbKKcywh0hP1GqEms9a8HRmoC?=
 =?us-ascii?Q?lAVH6DBGWGRVsBX7QHpwH3H09+fjt8zrdT4SuXcmSo3l+Akh5Qc/pruRG4k6?=
 =?us-ascii?Q?fy4qmqPInlORvvxBx1/AiWmjxp9loAffB+ObZOollSmDVML/UgaemW7p7od2?=
 =?us-ascii?Q?aVh2pLhOKMBGvJxf3/+O2lN2WWJ6UitPiWHrvXWhf713O29HREQJRUR0IhRD?=
 =?us-ascii?Q?+KS3QEZWM9GYq75Gst/ScqRF9lq/aGBisQOg//44WEXqq0BQJHff+XCqNy3N?=
 =?us-ascii?Q?qLm3EJ39P1uwv5HelKLZM2XJw0/UXTkRh0TBaVyIs2Qk3+dVcxjtRZFRupna?=
 =?us-ascii?Q?ViQNzhYCl2k2lPyC+3wAjJAgljon+O0AIrWTMdBb3j82TAfuY7RV3d2C0Zrb?=
 =?us-ascii?Q?QhEyBrwt262sHhsDT3l5s80lqQbpMus5t1/z13nG1BTYR7PdKcpHWtvpkr14?=
 =?us-ascii?Q?DsOwFhgXGTapEFM2XkS3yBobnD09TQIx2ZgoBWbOuHfO8m9vf0P6U7QqaJ/p?=
 =?us-ascii?Q?NHyQvg3fSk+C9Dw2O84Dg0JmgPsnYt4N6QcKn9WWYdSY4JoOP47Z6C13FNQ1?=
 =?us-ascii?Q?aaGqJhJMR5zLJyEtf/w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d75b788b-a14b-47e4-1db0-08dbfebece06
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:12:45.8472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sEZgPxl2h3y91tcIZUMPDx6P3XS/gg2kTGa2SIfyIQbA0WVT3f4IvlXaT95cbmlIWzJlubXFan/sdD6MM4C1iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

Refactors the phy handling logic in the imx6 PCI driver by adding
IMX6_PCIE_FLAG_HAS_PHY bitmask define for drvdata::flags.

The drvdata::flags and a bitmask ensures a cleaner and more scalable
switch-case structure for handling phy.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3:
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2086214345e9a..91ba26a4b4c3d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -60,6 +60,9 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_IMX6_PHY			BIT(0)
 #define IMX6_PCIE_FLAG_IMX6_SPEED_CHANGE	BIT(1)
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
+#define IMX6_PCIE_FLAG_HAS_PHY			BIT(3)
+
+#define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
 
 #define IMX6_PCIE_MAX_CLKS       6
 
@@ -1277,6 +1280,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY)) {
+		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
+		if (IS_ERR(imx6_pcie->phy))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
+					     "failed to get pcie phy\n");
+	}
+
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
@@ -1306,11 +1316,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
 					     "failed to get pcie apps reset control\n");
 
-		imx6_pcie->phy = devm_phy_get(dev, "pcie-phy");
-		if (IS_ERR(imx6_pcie->phy))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->phy),
-					     "failed to get pcie phy\n");
-
 		break;
 	default:
 		break;
@@ -1447,13 +1452,15 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
 	},
@@ -1465,12 +1472,14 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_COMMON, "pcie_aux"},
-- 
2.34.1


