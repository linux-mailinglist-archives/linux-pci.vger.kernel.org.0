Return-Path: <linux-pci+bounces-578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD443807443
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20F20281AB7
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8949A4642A;
	Wed,  6 Dec 2023 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nJJbw/NP"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ECBAD41;
	Wed,  6 Dec 2023 07:59:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I/T8mUNo83tCoYhgZB+Q+VZykaBxLQMY3wD9r9/zJsWTfMgDcP82lwq+I6KJ4SPid61HSQTHLBCoJ4s2RpiYmVeH1MfVg0p+Xr8s4L9JCDVyzv7cQw/6ebsdJz3VwHAKsKX9iJXiGkjch1gXeSSXiGrtda8gXqpRHJIqm9cr3LTci5DFnmCONa75Mx7hkHxLAKhv5NDoYYvZWHQPugC1vEDSDJCApT3U35/bk+wqaO3X93or7p/vqlCS8Fm9oDMJBM+nRlQ6mt86pDifYdoJDPy6Sh3zH44P8ekIAaH0XTJXA/lrkYFFUVu8+JjTlkcGh8ODKeeh/8iAwwwv5hJxxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdwnF8nD+iVT9P6KoVN3sYpmM4aevPILZj1Kh5yTZTE=;
 b=n6oLrQPkIicMcQ/C8RIO4ybxxxQmKU7aC8leJLisLyxNauQhaI4r9AcZk+pCm8opGF4WtckspruWYjNRmWjvZnyY13YkEGeAw+2ou628r6VcPbirHoskeBxOA9TmQp+WOuMdHpCjq5e99bQujDEdZ3hgKT9f5uhGfVjBH+QIVGVeXJupiMI11WNyqAWZSipzNj0+XuN/eqPEsT2z5zGmTAUnGfMC5cYbfAxlZjuBlWZAZOZ0Ab+TnaT+Jh2ZeZPt0Et3FH3AJTQEqO+duJM3MMctM6n1d/FDfw+pk0C1bDUQJircg/XdKF19yYkJqDuQyV2CQneW/LVP36Nwa1TkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdwnF8nD+iVT9P6KoVN3sYpmM4aevPILZj1Kh5yTZTE=;
 b=nJJbw/NPdb2U5zYkwKZ3m+685rFbQ1g1UDbLJuPLee/1zWv45FUXmAnwkmL29r1vCwhPplAJWrP2e3O/jAC7+gTKqhS2NhiyAVCYIQg/wQXDkviYfreE7rlsqhrvaN3ENgqc3or7W4BXe4U02sfLVlt6oWMMp6gfmY6ygfDsgWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8123.eurprd04.prod.outlook.com (2603:10a6:10:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 15:59:33 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 15:59:33 +0000
From: Frank Li <Frank.Li@nxp.com>
To: imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR IMX6),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR IMX6),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/9] PCI: imx6: Simplify phy handling by using by using IMX6_PCIE_FLAG_HAS_PHY
Date: Wed,  6 Dec 2023 10:58:56 -0500
Message-Id: <20231206155903.566194-3-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206155903.566194-1-Frank.Li@nxp.com>
References: <20231206155903.566194-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: e4313d05-6fbe-4469-3727-08dbf6745684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P3bzDJAPckyfVPYRS3FUe1wo2+3htvVdLQMLs7IbMDLnUgQvPFp3B/l+pU+ov9SJm3yvc1KgK+JHc/gP/SualuXW7JY9+goOpFsIstnmBVqKlHeKzdHgtZy+7CSQ0hvm0lHZepy2eRpXxnws3dMcKyQEyz6w5aKsKzwxWFHYqEApiwQQgLSqcVXJ7W52c+qM6RbBNsLzPwo8Z0BJI2YzUrUGnehOQleLqWfG5RGxgeyxaLLqB0F9CWDHWm6ligBaxhuW5BuOErlGHIhsPPGQEAIVhcu++80UEsgzcQJ3pFkAiPAh1X3iXs9l6U2D9nmKi9DwVEWQyQlsZ+UThgaOTM3Ct1f6w3rD7XCqmlMvRPz9y9I58rZ4p7ZTfqjEjZ1iGbJd0/S39yfCW8vxDYGS73TfKmdLLtyD7It/4nDQUbSYStZ1sA8Ar5HAbyzESMra2fOgpRy7GgSyoOMbwQd+RMJMq2TlNVArDm/zl9y6BoIwUmWqmUPMnNPfcC4MapTpT4UqHCGbp61t6z4NvqHzrqwvnOT8T5X9N/T3EjQnBrWW04eOxqL/w6TsK8EwGUQiY6tioLM33kEeSDEroUbYTPPKkF1eE9ZmJM+XY401Sc/q+6cK+gL8ItbbKg11wkseUvLg6dfp4PNWbEwuCRb2CA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(41300700001)(83380400001)(36756003)(6666004)(52116002)(6506007)(2616005)(26005)(6512007)(478600001)(921008)(38350700005)(6486002)(7416002)(316002)(66946007)(66556008)(66476007)(86362001)(38100700002)(110136005)(2906002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YrKeC2gHT3uIprgJkzHG6cDdXHBeQeCXyPWqEQVndPNuNGA1UhlBCi2mjWNw?=
 =?us-ascii?Q?i6RWcNj6iANvhlyJJvTOT7GyxsUOPp3rDcpZTv6BWCHzK1HEYh7okrQPuDME?=
 =?us-ascii?Q?fYTLf5l8fD2Z6SCd3PL/Z8ZArBZsnIATuYIYk02juiK5Q98zivuYaCnUZ1C3?=
 =?us-ascii?Q?xVnbXHsaa1lsOAX8pDQxDBicM5S65Ueg/LnFl6UPCx3l+lvJ95PMu9PMxJtL?=
 =?us-ascii?Q?LHdwhj2mz9WSNhU5he8WFHFNoTOCUUo4RorrjCq0hDMIfk/C44J8qXjlhuGO?=
 =?us-ascii?Q?4Cs9ptNa05ZSwjNz3XrweRN3S6XdrffrzKtFmI8oyhRaRqyMvtZo9A7eiqHT?=
 =?us-ascii?Q?qvqNB1piF2QPJLMWMwTeaL09mc0mC+xuAI/HufV3bZ/OlL0nYJv6DGYl4KvW?=
 =?us-ascii?Q?Fwmljs9UhjB2RmLfmytn7toG1oQbtDdzlaKrq/59AJcVl3esmvnKVS8BQfkI?=
 =?us-ascii?Q?1Hy8nLm/1MVL6h862fAL/ftAJrhmiVhpBZT3A8GUv48p2vRjpH1oyM2qdG4t?=
 =?us-ascii?Q?eJLB1GrUE+mxnWabTbyw1Uf0agg7aPUyNlRyt/RT1oygO80LVjIPrdHM2aQA?=
 =?us-ascii?Q?ofqYjousk8WVlKhN3u1xuk3seSIQzRbnY8bVfQe0NC9752j48KSrPzB+ekub?=
 =?us-ascii?Q?PLRCvFWY7ILYlO/cCAT8qWfr6TU2siwKtzQCBojzxmQcVwjWxReEQq/PFHLh?=
 =?us-ascii?Q?c1HY6Q5zI8hvQavRFgjyHv/+z6qT1WtY4+JrvITsv9BlI+w/QfZdbAaqmICe?=
 =?us-ascii?Q?bKSHfyCIUlLNEAVqDOBWz38fKfwFVcjEfZaP/4ZOeBIaZ35jpiQsj+cIIyFT?=
 =?us-ascii?Q?HnIHqX0Qs0IriUbh7Xx6pUrEpi9B5Gj7mIuUifuDwvdaXufPIDxkjgjJWvsm?=
 =?us-ascii?Q?a3Er50EsSpRea8Mgg2zNPNLKfZj9zwiGDZykVmsYQANtB1nEs6/nIpy87vxI?=
 =?us-ascii?Q?eVjwuxWBSibFNtZESI/FMdpaj7OQWvtgYReh91px5I20SxmIm4QwDfx/obAR?=
 =?us-ascii?Q?iDY34HSFdDwbHAPRldNi57SUFuKxHnckVHjDmBob/aX/iOJLndT/UXoxJJl7?=
 =?us-ascii?Q?GHU/6o5AYTKcZtsNRD5VcPb6UTAKzhCXmzQKmfSJpQZp17DtjgI6vJZrpvrE?=
 =?us-ascii?Q?x3xJavY0CKOG+0iEeiZZWh9OnSXZktz6XQnrBYCruC+l3ns96LPnL771y8nE?=
 =?us-ascii?Q?pA7RSmrJiuGhQTLLWBjsSQfHEpq18oNeb74cKfTV26MBCXzLSf5qrXl+7ABe?=
 =?us-ascii?Q?ym0NM6xbMx5IIcPqt0iZq54ogCbEbyeRqKmPsP8u4lubn/fSJtHlDbNEPJHB?=
 =?us-ascii?Q?RJBi5NJodFq2o096F5v+AYude7j161PXE5EI5ZK2r676dxcjHDMi51iLjQSc?=
 =?us-ascii?Q?krlgBSj1ExCK6GlxZWeURGi2mHyBLF3jFLLtyPm3KiP6eV3kJrhMDXfoKggt?=
 =?us-ascii?Q?iEIkFOOY/qBDGai/9JxHw4ZS8gE7imVTVJ4aKfOl526tnIfOP0jhEJ21aVKt?=
 =?us-ascii?Q?7kLxf/+S2OjsrTf7bzTWfXRZC3XxV+lcb9aiWJwyLa06Muk6lZ1vbDnOLPlp?=
 =?us-ascii?Q?ixgGUqMKJRsPDATKg6A=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4313d05-6fbe-4469-3727-08dbf6745684
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:59:33.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGNYtr20AZ/DcpUHHMGQKHbFDSewKHud+nVzzhWOOEMZIXgRCQUY7sBNAWf6RYLXLK5GxT/S6yddLg4BDS+cvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8123

Refactors the phy handling logic in the imx6 PCI driver by adding
IMX6_PCIE_FLAG_HAS_PHY bitmask define for drvdata::flags.

The drvdata::flags and a bitmask ensures a cleaner and more scalable
switch-case structure for handling phy.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8a9b527934f8..bcf52aa86462 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -62,6 +62,7 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 #define IMX6_PCIE_FLAG_HAS_CLK_INBOUND_AXI	BIT(3)
 #define IMX6_PCIE_FLAG_HAS_CLK_AUX		BIT(4)
+#define IMX6_PCIE_FLAG_HAS_PHY			BIT(5)
 
 #define imx6_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1327,6 +1328,13 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "pcie_aux clock source missing or invalid\n");
 	}
 
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
@@ -1356,11 +1364,6 @@ static int imx6_pcie_probe(struct platform_device *pdev)
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
@@ -1500,24 +1503,28 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX8MM] = {
 		.variant = IMX8MM,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_CLK_AUX,
+			 IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_CLK_AUX,
+			 IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX,
+		.flags = IMX6_PCIE_FLAG_HAS_CLK_AUX |
+			 IMX6_PCIE_FLAG_HAS_PHY,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 	},
-- 
2.34.1


