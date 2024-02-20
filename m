Return-Path: <linux-pci+bounces-3782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E471085C127
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2A728358F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9F479DA6;
	Tue, 20 Feb 2024 16:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LPdIJ+Fw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596BE7993A;
	Tue, 20 Feb 2024 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446041; cv=fail; b=qL+GTx52sk+VkiQWTcMng+eZVWE0BFdR3C8WYJvlbgXk0Bo1yKZF5FE13PknMQnrd7uEcCKXu5IXuhhykmHnlPcM9HtWNoYzCeSAPDPOtrCn8kzDA1kUKpdnU7Uz5a0Nq3aDV7TDu9GfUdhjppU4yGRaoLrjXOKLcxK6iur5rmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446041; c=relaxed/simple;
	bh=xhaQDt1dH8mbJFbnLJjes8GhgtIg+cmj/FFsIwVBgAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+l0rLv5b5Oec0HAHNqmG3QquxE1UEfzR0zbFJfq4H4G7SNpjpP9y3lE8fI2srrCKOCEGOxV6byTTSSjyFQ4h02kYvsTjNGOaceVfg3odwm1KIf3nvkY8z7bmud9MK00cwMeTy+vYF6xOmuH1UzGuipYeorQh32zOSiXN3ckwfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LPdIJ+Fw; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hSf9I/bn9o3a4F175jAhDj6FWcwl6uQk/H0w1lWLzQPE+FeO+TChvyt6QQGVndT10cTytKdGrPVeUvMR7z3hsmZdIjo52LDnQnO/4jUN/ddTxKtbtne6qFfiANqatfdqwg/Jbi8uLI/cRXyJzjIHkA9x2URb+cJa3DAa3zFj8jKUJWVJpv1FBr2Aqhg1utU3OkLiMtDDXaGaPbqAXFYyy1XV/4m5mddLoQA/Bj94Xjm4fBN8y0SdTllvaxOq75fYUhy5WSiCPxsZjCSv59VHKKQvf0uYgEtOQZqvIH8EybQPgcX22SzASynqSK//46g2oNQGA5qYQf8spqEQ2/I3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQ78U91x1+bTEXalAnKotjIZ9NoPv5QhfHAtYdw+5+Y=;
 b=MdpxqZ3JJ5wCb19QJHkIc7wdd+EgjvO8NFadt7ZvS+Bf1buf/rokh562X3cMJyQKbXaFV5RH4V8oEA7Jf4vQoxyYHWfcJqTZTLGr+yfeoqND6j0ZhSsIX6eCC6/A14xkNhVxfDfk0oznaxBEbq6zALcoDSGm0JILVRP9sobnhtoLWvfBFRSLgMB3pif0AmIbAtvKXNtBrEkySYubAnAoUEirPmegOKoGMY+mA+OGZSqfbzQ2x8wXExjs29qb7Kg2baEnbOWD2dpHqk4q6JrguPXAVTDYzQvGYF1lcGBwKERIwV6zY8WRk1UjUdhpjIhppEc648NnUJrrNATU8/B7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQ78U91x1+bTEXalAnKotjIZ9NoPv5QhfHAtYdw+5+Y=;
 b=LPdIJ+Fwx2+DTf3X2XuVBZVlEU2IJhLSEm/ITHqvr+zKlLAQUA6euq59Si4Z683hWn+v6rNbtwn1syny87/M6tlYGQZTlB4vg8tUhdz7WzpUFv4O+0WT+FF+sW4xe/vIKHaicm56J1/XqKaOjHuaLA/rE7e3oT05w+TU/hl34EE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7295.eurprd04.prod.outlook.com (2603:10a6:800:1ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 16:20:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:20:36 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	cassel@kernel.org,
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
Subject: [PATCH v11 10/14] PCI: imx6: Add iMX95 PCIe Root Complex support
Date: Tue, 20 Feb 2024 11:19:20 -0500
Message-Id: <20240220161924.3871774-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220161924.3871774-1-Frank.Li@nxp.com>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: aa727374-9860-4a13-6d4e-08dc322fdee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	an2l4e9UPKWvAZ2Q73eq4kKdck2/SjLUFlrRmg9QY1wAmb9QHxqEnJgLprrKgy3zgOEtG82YMC4SI7adRIDeB54eFlAmMcaRZRHohPeQxYbIpz2w9HitAc4iCqHTN3yN82VRZWl0bcbY/deLqbH0apiHlu9mhg/jHCG2Izy5YYX4PFPsMwvuxwV5hRnzVHfoD5Tlbi4GqXBnPvmhB5HRNxzZHv0SkLrEkWo/fsImi3Vzwn9y2UvTvQ7dc8y1kjP3f8ldHxEnCtUiLJSsYLXnsoYlDuVGu/NdMlrNuPo9mgYEyGFMbgaqZ/A9DXhmfXt2lAaTkpwzPO/sjiljFhHUz6vPztzVZ4TwooBo87vC/Hklq85D2H3Mi0avsHS/kOFO/PyGO5r3Kug07gz4vI4xewffxuMnMPkLmaWAP36Tli6E4fgw7MRfwDjTDq3ZxANEGaSmHZ0LASrl61KceLaxk7+G++e/82EX2OsXHwJzz88NkSKTm/eIaW1rIUfieITHTvI0aZgVyXUM2ncc2sJZbLMi5TAAOeXfP6h2lmhEJKBJcAu2wacgMddEs4QpNIRPjTgtyTH8CWYcSEp6V8A3mcUIC17uzoAEUS6eXuEx4dpyPrSblrdwMkPiglwbOTlr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YI0UJ/nZECsfOGAkC5y9Inh88Xa5dsB2bKeimluXnPOHTdddAJRlvHjYDhAv?=
 =?us-ascii?Q?daPUMnT8NtngyTizeIr+81It9rjsZlaCuArOWqk1UwaR3VjR06ffS/lpew7R?=
 =?us-ascii?Q?+aCoXddioCqK1NU37uF5EdqQb4Y3qYm8R0WeMG1vuEZFEKpQgmw5wps+jj7g?=
 =?us-ascii?Q?dcMq53ynpQuJtxZr4vkuhj7XYj0YGuY+3qYsL+MX4AhPjngLQ2RJQooFmEG7?=
 =?us-ascii?Q?//1A341y6RArNv+FBARaXWNPx4f6AG83XC5t8pEIEXQeaE9OZGpkPlPHHEXF?=
 =?us-ascii?Q?fmXsyXdVYjr3f9JdMyvd7mQwdu8dsCsT+uf0uLyONNxPECyTVKu0kYrTER2g?=
 =?us-ascii?Q?DERC9RTHqp3Bzp73J/vOQmByghpKRGUeepzoSjIi8Q7QCp4cQvldG93Mk8bp?=
 =?us-ascii?Q?EQrxGJW4rXTpHsXkctGZ18KHbokGO9qvLDOsY1wU7ZxO48oaTCZvImw2T0V+?=
 =?us-ascii?Q?qTMbdPuz49KWmWMus2enXTGCXq1UC1EyPrwdXGj1SSZlHhEdLqKe9sahxu0F?=
 =?us-ascii?Q?9jn6g8AxmOqHYM3fHu6/NnGkP006/Fp/0uCECl6BF8BA0r0HZkJ6B/ceNANV?=
 =?us-ascii?Q?Gk6BvPl+FcXTm88bxToLGMFbEHY8uUsXEACAtxkp5C6s5o+1L15f5U3YWEuL?=
 =?us-ascii?Q?vmjJR5ZSdtU/+0fFcxJ38LQEA3cVslzFDUbG36ln1eY5GSFPnDcQu+DA0+1V?=
 =?us-ascii?Q?oMXjoFw9ajHVi+IxCxgeOc+aklXc+v9NGn07iXtnWFl404NhcPPE61gqQGLB?=
 =?us-ascii?Q?CuS4Z8cIY3Qfo+Sje6+5BJ9E4Ik/MpbpmiJQe5iThQgkWR49Fgp6qrPQ5pdt?=
 =?us-ascii?Q?wQ+1H6jky6BCM4cGsA6ZVHzOXUPMYj1xCL/HYUfjbnWDP/K0V1sCTXw6QvwN?=
 =?us-ascii?Q?U1YzMY5HnV3mjg7ygzlBvhDjuKvvvpebcqRHuAhWfamDq8m4m1dvkRoy81vJ?=
 =?us-ascii?Q?C1H1VVFaA6/ACMpmnYCOIRrHNaoHoeeLpIj3me+KfG5T3+IhRZTEKVs2za1H?=
 =?us-ascii?Q?C7YY/pXOADkmeMmE8aGb1rqIFHx98ghuruk3L31SfP99g0YWjwI1l4SqEyXX?=
 =?us-ascii?Q?S5uBolOtoCsN9POwAGwVr6Jc7Y3WzUpFZIaemCLmeZ8wSjJJmxO4DAdNHQP8?=
 =?us-ascii?Q?cbrDaN5sWTfWECLyLUaG5pJn3mjIDPYAYoVpuk6AKHCMsmB1CW/kCB+skAYF?=
 =?us-ascii?Q?uQquCBGbo/08mHlFivKR6wqPyMYVVF29eMdXZLP7fIy403ViqP/1tr5zPaMj?=
 =?us-ascii?Q?nqnkKviTDH71QBtXyH2a8HpAljgMmkcpWIqWbme86SNsbt1D4CnJ+qQUvrf/?=
 =?us-ascii?Q?oLQdoGZH+KQEdKlmtx6MSzmzP394+A12TXbajQOq1S84CAyGa0o/MQgh5NEn?=
 =?us-ascii?Q?s/5+lUS2Jf8mgmN4TgOp5kOpOojNsJtBw0ibgDGYsU2CM5fA1itqHgk8MvRP?=
 =?us-ascii?Q?My/Yfrx720YqG0p11bLn0OrXXBeXPyse4d3k79odntOfWAGzb9RdFRqm2QS4?=
 =?us-ascii?Q?dt1TtaZP27cktLy4KbSf/w/W5FlPtledRod3mj+1e+22pg0RQrTtJoU4JjZ0?=
 =?us-ascii?Q?3/MYl2aHxKc71YW8MVUPW5m7VM/QnHQwALdSsPBK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa727374-9860-4a13-6d4e-08dc322fdee5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:20:36.5440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Z8rTCEl2kz6QKczF+FlPcI/DTV4a6hP+0wpsML6XJOwDQ65XdoirwEhKloGese0Nqwtmjh4ojXQwyyP+nApwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7295

Add iMX95 PCIe Root Complex support.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9
    - Add mani's review tag
    
    Change from v7 to v8
    - Update commit subject
    - add const from regmap
    - remove unnessary logic in imx6_pcie_deassert_core_reset()
    
    Change from v4 to v7
    - none
    Change from v1 to v3
    - none

 drivers/pci/controller/dwc/pci-imx6.c | 82 +++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 71ce6b7ac1de0..582ba00d628a1 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -42,6 +42,25 @@
 #define IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE	GENMASK(11, 8)
 #define IMX8MQ_PCIE2_BASE_ADDR			0x33c00000
 
+#define IMX95_PCIE_PHY_GEN_CTRL			0x0
+#define IMX95_PCIE_REF_USE_PAD			BIT(17)
+
+#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
+#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
+
+#define IMX95_PCIE_SS_RW_REG_0			0xf0
+#define IMX95_PCIE_REF_CLKEN			BIT(23)
+#define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+
+#define IMX95_PE0_GEN_CTRL_1			0x1050
+#define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
+
+#define IMX95_PE0_GEN_CTRL_3			0x1058
+#define IMX95_PCIE_LTSSM_EN			BIT(0)
+
+#define IMX95_PE0_PM_STS			0x1064
+#define IMX95_PCIE_PM_LINKST_IN_L2		BIT(14)
+
 #define to_imx6_pcie(x)	dev_get_drvdata((x)->dev)
 
 enum imx6_pcie_variants {
@@ -52,6 +71,7 @@ enum imx6_pcie_variants {
 	IMX8MQ,
 	IMX8MM,
 	IMX8MP,
+	IMX95,
 	IMX8MQ_EP,
 	IMX8MM_EP,
 	IMX8MP_EP,
@@ -63,6 +83,7 @@ enum imx6_pcie_variants {
 #define IMX6_PCIE_FLAG_HAS_PHYDRV			BIT(3)
 #define IMX6_PCIE_FLAG_HAS_APP_RESET		BIT(4)
 #define IMX6_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
+#define IMX6_PCIE_FLAG_HAS_SERDES		BIT(6)
 
 #define imx6_check_flag(pci, val)     (pci->drvdata->flags & val)
 
@@ -179,6 +200,24 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 	return imx6_pcie->controller_id == 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
 }
 
+static int imx95_pcie_init_phy(struct imx6_pcie *imx6_pcie)
+{
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			IMX95_PCIE_SS_RW_REG_0,
+			IMX95_PCIE_PHY_CR_PARA_SEL,
+			IMX95_PCIE_PHY_CR_PARA_SEL);
+
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			   IMX95_PCIE_PHY_GEN_CTRL,
+			   IMX95_PCIE_REF_USE_PAD, 0);
+	regmap_update_bits(imx6_pcie->iomuxc_gpr,
+			   IMX95_PCIE_SS_RW_REG_0,
+			   IMX95_PCIE_REF_CLKEN,
+			   IMX95_PCIE_REF_CLKEN);
+
+	return 0;
+}
+
 static void imx6_pcie_configure_type(struct imx6_pcie *imx6_pcie)
 {
 	const struct imx6_pcie_drvdata *drvdata = imx6_pcie->drvdata;
@@ -575,6 +614,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
 		break;
 	case IMX7D:
+	case IMX95:
 		break;
 	case IMX8MM:
 	case IMX8MM_EP:
@@ -1279,12 +1319,32 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(imx6_pcie->turnoff_reset);
 	}
 
+	if (imx6_pcie->drvdata->gpr) {
 	/* Grab GPR config register range */
-	imx6_pcie->iomuxc_gpr =
-		 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
-	if (IS_ERR(imx6_pcie->iomuxc_gpr)) {
-		dev_err(dev, "unable to find iomuxc registers\n");
-		return PTR_ERR(imx6_pcie->iomuxc_gpr);
+		imx6_pcie->iomuxc_gpr =
+			 syscon_regmap_lookup_by_compatible(imx6_pcie->drvdata->gpr);
+		if (IS_ERR(imx6_pcie->iomuxc_gpr))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
+					     "unable to find iomuxc registers\n");
+	}
+
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_SERDES)) {
+		void __iomem *off = devm_platform_ioremap_resource_byname(pdev, "app");
+
+		if (IS_ERR(off))
+			return dev_err_probe(dev, PTR_ERR(off),
+					     "unable to find serdes registers\n");
+
+		static const struct regmap_config regmap_config = {
+			.reg_bits = 32,
+			.val_bits = 32,
+			.reg_stride = 4,
+		};
+
+		imx6_pcie->iomuxc_gpr = devm_regmap_init_mmio(dev, off, &regmap_config);
+		if (IS_ERR(imx6_pcie->iomuxc_gpr))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->iomuxc_gpr),
+					     "unable to find iomuxc registers\n");
 	}
 
 	/* Grab PCIe PHY Tx Settings */
@@ -1457,6 +1517,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 	},
+	[IMX95] = {
+		.variant = IMX95,
+		.flags = IMX6_PCIE_FLAG_HAS_SERDES,
+		.clk_names = imx8mq_clks,
+		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
+		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
+		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
+		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
+		.mode_mask[0] = IMX95_PCIE_DEVICE_TYPE,
+		.init_phy = imx95_pcie_init_phy,
+	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
 		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
@@ -1501,6 +1572,7 @@ static const struct of_device_id imx6_pcie_of_match[] = {
 	{ .compatible = "fsl,imx8mq-pcie", .data = &drvdata[IMX8MQ], },
 	{ .compatible = "fsl,imx8mm-pcie", .data = &drvdata[IMX8MM], },
 	{ .compatible = "fsl,imx8mp-pcie", .data = &drvdata[IMX8MP], },
+	{ .compatible = "fsl,imx95-pcie", .data = &drvdata[IMX95], },
 	{ .compatible = "fsl,imx8mq-pcie-ep", .data = &drvdata[IMX8MQ_EP], },
 	{ .compatible = "fsl,imx8mm-pcie-ep", .data = &drvdata[IMX8MM_EP], },
 	{ .compatible = "fsl,imx8mp-pcie-ep", .data = &drvdata[IMX8MP_EP], },
-- 
2.34.1


