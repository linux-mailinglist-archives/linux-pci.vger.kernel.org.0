Return-Path: <linux-pci+bounces-1107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA51815D81
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DB6281AB1
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3001C10;
	Sun, 17 Dec 2023 05:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W1zS8xXV"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2074.outbound.protection.outlook.com [40.107.247.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4615CB5;
	Sun, 17 Dec 2023 05:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAzyNm6I6fRLjfn/d4/cMjmc83VW01oQZ0jG5d+gdgaSx35UXtV8ztCZ8MX5RaQABTAPTeKo97tzQzzduS34WRkPotyx5K7gDWocgE8uj21UXF7U25d+SdE8TabE9Vtv3SXBUlhYaP6LL6gcyz7/5K2br+tcQw20JlrNZ9N0fgFJOlA8KWA4ojmdk6jMiUA8SO9pPmLx7KSVPDYLrSF1H//yJdPq4VVlJYJoE89Yjw15Q0mBqqKeu2xkUVF3aqkl94CEGICw5igF8x7P9K721ih8JcLNmzJl5cRlAd6/3SogwxoLGwEn9ljsrxWYAETzSTmmrOhDak+0CSiKLxtpxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1CpsWVIAA8RLlbctTciyTq1qYk8tHuA+opMjAr6h4E=;
 b=WbAX7Bq2JL78dd7EfZAbvkRYGdTgloSerKEZAU+muA8ZJTEIBqf0hL9M62kQn+DBx3AkYlDKzaTSgpXwGkvAuWl03/irCxRnKJh6pp32jiIsdZIkiXBmokq6HaiYZA3HNfjaFi7IJR0dCcpQhPzK2neEzYimdtRVDTLFc+oANK8QTMrNYW1PfEMpa9k7elNrmKtrrV/QZ4COztnhEazkEwGQy8skqZnYM8f38IMN3Bisk45MT/5E3R9f4Cvr8M/m55+D6CTwmBjYbCtN6r2bLBzaLiVdDeP3UpteHpurm9JwkHo9ls+X2EpSn2Kh4/s+lbNcwHjiuALV7r2Xl4bGVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1CpsWVIAA8RLlbctTciyTq1qYk8tHuA+opMjAr6h4E=;
 b=W1zS8xXVqnCxJcMYRYfE+Z+E8GeLDr37F+sAaBqmeCACaWXSVKIf5ayc95ArbDLMnF1/MYxD6ZBhnh9sQLUt7aS1zVBYpjQg2uXYwoCg2IM099oKw9cDXxZoHUi+1Is08kTvbuwezJj0vRUjMYWWwSnfp8QnnFFoOgOYmrt7Ghw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:13:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:13:01 +0000
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
Subject: [PATCH v4 05/15] PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
Date: Sun, 17 Dec 2023 00:12:00 -0500
Message-Id: <20231217051210.754832-6-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: fd9dc01f-d1b1-4ea6-c3cf-08dbfebed70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X9RXp3nJDl6MHc+NFxCavKX3sdX11vQXwG3sgUVUkfFt/O2v+L3+e/mM6KpiKIdQk3va5eEYnl9gZ6NpCQVEcZbDSgkPEwpcLMre4b2XD8Q1bJE0Ea/x0iXa6HSv6RDYro+yORygOvaXST1JlFq/WV7+DUuPdnw0X0IalqIhRauFpHKJXzNjs28zvWpPWrPcwLsJouE3Eta4obTAyC3jcsGFzOyOw9VKsQa/hs2ubJuFxKZLaOmokiFhyecfUVvP+1pvBcTcTQjQKGKH8/y+Caf05kVIhY2RPDDjqOCWyfrW69RmZWTVux2QGIILjl6yOCDOoXr2KcNiHLJWfEU/9i1u2ODG7M75sQHT4kZ6nRzwK+buFBsVf7skTCQca1EQyueKSanX8v2Ea41qx6cq2hbHkJqoHZ655jCEfDZndHwPXfmOPUFEKF0ubhMjuuEiuBuJFUYZYssrM6vccfbh8U9St3BaoyTdRlW9HHxcsdva0URkNQD8HQyVIqj6mkchVsZ8k6w+cK9miPZlRUwprwzkcsRuO/JZixXwfxAd1y0+o65UPWlVfu8MSYMXVYc2cvWedgwhcmrbm15oyDCXRd0MyR7NKTkuY1tGup+1cPyRXxk2ahzzkB55GyR8A148
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ISI61kaIXUiBdve1vPOh9g47lHUb3BKjyeq/VeJ19Ioiv+CGWbYkcoQtgDom?=
 =?us-ascii?Q?c7JA5NSlPMCRBy6kXZ/PCTld578NlPTl+4BRkxNNOKvYJQzM4ldyjj5NIRGO?=
 =?us-ascii?Q?UyMcBAKXsN+UE7UwYMy5zyL5wEE93iHVEnnW74ccnRM1+U+a4cK0IBYQccHS?=
 =?us-ascii?Q?MrnLhPxKcFv9fFWIzz+SMVn7YXT8wpopXa/sZ6h8aC7vsjde9gECRjU7uGm2?=
 =?us-ascii?Q?kF4apJCHPlsgs12Ys9vNO2iw+HnLPzoUlq9sRPNVoUUIXRNiTg6AgEevzVq6?=
 =?us-ascii?Q?3mRExhjxERt3LELfK/yFHNaoyc5dAKobQ3yKYYCimga1CltiUj7wF6qMyGcF?=
 =?us-ascii?Q?59bXqL9kL9NAXwqya7shI10RM5jw6putYxIPX4c5HVZ6rgwMSuhALNsSzTq5?=
 =?us-ascii?Q?reOPie3O9Nx+Pb0LbxAqkh0/pZd9DrVZtp6gOXMx9SidK/BWI6PR5UcYDyEJ?=
 =?us-ascii?Q?IOL+MVfBhv316cnHWVTsfhamyF6CyBogzwIg2Xl+Uay4rkKtvIY3F3PXRoWD?=
 =?us-ascii?Q?NK5y+zIN0PsjcAiBuE0JyFLNxK8rbpZYIA7EyAWzE90qoeMLSqTGhRRPPQHa?=
 =?us-ascii?Q?EZ+h05yHy1vEXc4+56oc4xfecZD58cuy2jlmL2GQro4yZTRDZTIpzKyFatmc?=
 =?us-ascii?Q?A3EiaXAcEqirI1/H8iDb4JFmrBVhcBm+zu/ilZ64RBe15iNP16vqA95GaMUl?=
 =?us-ascii?Q?tRimqqCzT8xKwmfy/BBcWP5y/SqzkJHgpYSeXzCuspmHg0TQkVccvcL/bLy8?=
 =?us-ascii?Q?GSC8y7Gz+M58p8BKW2fTa650cqv3FiUOj54Cf7I72yJo6qkQSHPcBPqHsLUt?=
 =?us-ascii?Q?OFkJWtdhVr9j5TOFTZffheF6koXjPh4x2v/WIIgLDtcNPAabUlfnwEq/0jAa?=
 =?us-ascii?Q?iWqrZidHX3cUCNMVhAMuTw5YDR6GQR4KT4V99Rg13mYG4o9inWLxC347aGAA?=
 =?us-ascii?Q?36w8pZ0jZ3qPqvrXeSz5Vz/3Q+sjwavH0iCVkYva+23oAqkzrCVxvi0A7RP6?=
 =?us-ascii?Q?s9x5fDm3s3MsZf/vyD5Ygh438FXZtG76qO43mAy4glb7FEPB2jXzlOnW6joE?=
 =?us-ascii?Q?SEQOzKuLLIyBxcMumo1200ZfVGkOiNzIof0+K3pzi7kKT8EYIevVpeMMsZTQ?=
 =?us-ascii?Q?3YT7Uiz6sE3AefTLRiI3puERWT1gGJvBAfnn82/X4S4Z1pKzNOoHW8KH+X4m?=
 =?us-ascii?Q?0aZVU5DOyDf/r+ohdR/c0HO57NbcSrtE9a3rl3EUaCClebVe8I+jG5ztXDsY?=
 =?us-ascii?Q?JtW+r8ZmcaRXd6VmzZeYhQ0S0ZNcBrHPtZypCjprLW+dxNGYLkJa2lhzl9Nm?=
 =?us-ascii?Q?ZYuec896/EUjHuSDS/p9Y0CQrFIk15kF7dSh3x2k4Oll+nSDGPh1Wc7nPlMk?=
 =?us-ascii?Q?JCnq2Y43WwrQ/vonpnSsE9z0+BfQgTvNIXfZOyDQ6xEg40eIl96tQJ/pv14d?=
 =?us-ascii?Q?G6dwyzOtf6ZxHGP8ckez9cw0acr+QiTKn+M+biGOo5R645N1iGmw3+F6MfMh?=
 =?us-ascii?Q?HgUGupe4RqfmQC23xMcSfqQrOiT6upRx+TFg/wlxha6Ft/8gjIgynQiHaKnf?=
 =?us-ascii?Q?rNdwLNEKO+V0kt8tSN4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd9dc01f-d1b1-4ea6-c3cf-08dbfebed70e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:13:00.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fWR5JdLsV9uk/vegjqUzcdyyC4Rm7QPYOoM3UN4RYOwlBGIcJzres/jY2lht3Im1gxZHU/IZhQF3FGJhh3ddqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

Add drvdata::ltssm_off and drvdata::ltssm_mask to simple
imx6_pcie_ltssm_enable(disable)() logic.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 37 ++++++++++++---------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7145947e21d92..79d892836a24d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -75,6 +75,8 @@ struct imx6_pcie_drvdata {
 	int dbi_length;
 	const char *gpr;
 	const char *clk_names[IMX6_PCIE_MAX_CLKS];
+	const u32 ltssm_off;
+	const u32 ltssm_mask;
 };
 
 struct imx6_pcie {
@@ -775,18 +777,11 @@ static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 static void imx6_pcie_ltssm_enable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6Q:
-	case IMX6SX:
-	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_PCIE_CTL_2,
-				   IMX6Q_GPR12_PCIE_CTL_2);
-		break;
-	default:
-		break;
-	}
+	if (drvdata->ltssm_mask)
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off, drvdata->ltssm_mask,
+				   drvdata->ltssm_mask);
 
 	reset_control_deassert(imx6_pcie->apps_reset);
 }
@@ -794,17 +789,11 @@ static void imx6_pcie_ltssm_enable(struct device *dev)
 static void imx6_pcie_ltssm_disable(struct device *dev)
 {
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
+	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
 
-	switch (imx6_pcie->drvdata->variant) {
-	case IMX6Q:
-	case IMX6SX:
-	case IMX6QP:
-		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				   IMX6Q_GPR12_PCIE_CTL_2, 0);
-		break;
-	default:
-		break;
-	}
+	if (drvdata->ltssm_mask)
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, drvdata->ltssm_off,
+				   drvdata->ltssm_mask, 0);
 
 	reset_control_assert(imx6_pcie->apps_reset);
 }
@@ -1385,6 +1374,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_NO_PHYDRV},
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6SX] = {
 		.variant = IMX6SX,
@@ -1393,6 +1384,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 			 IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_NO_PHYDRV, "pcie_inbound_axi"},
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1402,6 +1395,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.clk_names = {IMX6_CLKS_NO_PHYDRV},
+		.ltssm_off = IOMUXC_GPR12,
+		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.34.1


