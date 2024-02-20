Return-Path: <linux-pci+bounces-3775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7BB85C107
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D56B247A5
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE92776C7A;
	Tue, 20 Feb 2024 16:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MM/JUnJr"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2080.outbound.protection.outlook.com [40.107.8.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD35576C61;
	Tue, 20 Feb 2024 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446004; cv=fail; b=h5glQ3RYRlUrHStjv+QzUHJdTBVTUphiCe/1t/zFvc1+UyItK+MbeH5nHJV2lscMMlnsvTUPU6wdB/580HpT8Y+bXmhQYKQP4CJ4/riZqjsC+/vegHigKTQkn0DjQ6Zrjruuj9F+9/aVoEHacTudReqKoskIy7MpQkSVrZFvoX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446004; c=relaxed/simple;
	bh=+EpVZDXo/0s6Hyj/rFU84Woybb++Y5nA5YuD551JAhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p1HTLejrOKE0+JgoWKA6MoAQWCwUzc54N4MvSG9oaOj3ASdPmYOHKopAt8yDmmpYD6JaRTvQ7U/yG7cV3cwWzr+KpJ4kpFJlK2TouRVteyTn+Akd/JczqS0FII7Ee2pZFcN+9hlkTg77gr3+h04qepmy/MaG12oJ7mLjfVMbU74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MM/JUnJr; arc=fail smtp.client-ip=40.107.8.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaIbS4yfYj3OSchlPYjDSKvLBFDp3PsJy8wsAXpok20DbuqUxsb7gDp6CnfGnCHjhYEtTbDMkd6vyknjCDe9/gSXGv50n13BWIkWJgbzVmpDKocskRGjgfsSrvOYAXATruUeInM+gVqdiEzZlgWseQZfRXElrpkaBvrf6xXSPXkv/6JuKkJEBZba6TEZOaLJVJf7tLkyHYohYh5UQVp8vO1cajN1guM9a+ezwJ+RXnEuIOocyoZXSrolE11oECboSwRxaC6UENW/EJVCGQtLTHUXUw3AhXxq7LTaXXwG7CtLEKpzddCld4KIccV5ntHQIAr06CdZA0zYQFrjAwt/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqzFJnTAEVcuV6BRzjyog/ErNzeCAxoaQRgtgL5jnnM=;
 b=f3PMPajTDq2BXhC82A9G7ed71qymn0J+28Cjq3qzhx8Ufbtb/0rWZ3pjZOU5H/aoUUFxyLLc+7b6L+qEvQ499ouTfi5faXcHtWGYHq8o51Z2We0iwuGjy0LYBY0UYitgB8JU6zPAR4s6s5j7epu64J11ap/lWzfTeJjQDwK6qj42AgLjPMZQX6dT5j1H1AwfUucYP35rETj4poTtTKkhaFAyfPKGzB+yI5DUW2zjmTKAg0GetenhgqF2SY0yGNDZDgH2LYHXmFC6M+GZqR2m3AqJC/ME7VgtqzFyQ29WItnrQ4QDaKB+4TZ0gcRnagssj83XBQriPIF/q9oJVfKtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqzFJnTAEVcuV6BRzjyog/ErNzeCAxoaQRgtgL5jnnM=;
 b=MM/JUnJrJsZWip16QVpuO0DQ0EjKz7QsmTTjlfjsCvUOMkQO00TImqR0wO3xbyYZL94KZKG9GyzzJNh19/raVy+DC3uYzLQewtG+ThFJDou+BR8SH6X1kHqXSY3jTSejrJQEG2Q/lqE7ChdQbQoaWR0MHYdi9egzdl5RcWkINTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 16:19:59 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:19:59 +0000
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
Subject: [PATCH v11 03/14] PCI: imx6: Simplify reset handling by using by using *_FLAG_HAS_*_RESET
Date: Tue, 20 Feb 2024 11:19:13 -0500
Message-Id: <20240220161924.3871774-4-Frank.Li@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: c2b28092-64e3-48c2-bfe1-08dc322fc8df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LoF+kkA57LFsGeopuYNfOy+fUJ1L52sePzXsVaZTtG44zWZ1rR57QgpnzLiZky2Y4zd7KLLSIT2+swn2h9kt4pJD3c8QTgPfhb2AhADsk667qMx4LG8BauWAoE3F/YHRvD5T08Zq133DMtEiNIks7GxiMVjJbrL1oclbz+FpTnzovPFd5XoRL2pMgSJ69IF6Q2oXU41TAxFLDrqzcXOu0eAIm806cmsJ8yXIltJasroVDnPE/HVteLd85gmhOg5USBRofD5sLH//4ALds/J3Sx7TEDndzPmgvvqSgVhQFwExdToyyUD5rqWE6ks+uxL/9ootBh4mi4Tu1EcGedgqjx1M8OcXJNp0ut43C01TEr5V9ZDZ7KC4lAtnEiYOna16mRqfzFWkfOjNTVTjy80didJRCjuI1plHYtbk7plyqo4ZOZ5k/OL3hcMGPm+qoZBM+Fk7+Ah1TaowPJwb3lPdKD41BU4wLfZOqKLeTi+e2HLfRdgXNMAS+8XCtk+H8VA8i7ai7m9hbxafWoMlVbWowz5VU/c4kYPDybQgt3jChD6nC/7tlYEIEV6cGj8/jv2CRzctyFVGZl9RYdxbedGCIKvWkY1zt9z1t2RMvArvE2BrBP4pGLY1G3DMbXRrahSm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IBckAOFcLk3Dnf6hGFGS8QzzxuRHQpIiwTNhM2xPjE10mtG/JJQdHjCfTRbY?=
 =?us-ascii?Q?uRbCnk3hgVX0ViGDEoaklWrEv1hKImAEVbr6VY0fCZhDM1bqdEiihNcQxpkk?=
 =?us-ascii?Q?d8vOWXMh8scuqjmEemBcHHB5HQiQ4sAxLHGZdYXnGSGj2Iwa7vopxq72jrgF?=
 =?us-ascii?Q?/qXwFTkPdK0kQd6BzW6pNs7V6iUQOyaICWvFZjQq2dztcNwHkWDe5ASDtCwY?=
 =?us-ascii?Q?qHLxcyTvmoBF5sktU8B8A8qfFldAeYvJJi+eBA54Jfzkj7OYQxBLpJ2tepcO?=
 =?us-ascii?Q?kXNGm1PD+SiknmV8iIqiEeCZGnLgV+3Rv4L4k0APvSllwgzXgF/tQQlyLQxH?=
 =?us-ascii?Q?EomNLxl1jjqc2DUZ8MQNjJUuun8OE3J0H4BhrgHZgTKtBaROInbyojepUkur?=
 =?us-ascii?Q?/RY3iLpHRBrdNXJxJQSPNW3Z8ddBg1hpixuWPbUZ+epAtNQAsI9ur/BzX9yG?=
 =?us-ascii?Q?aALk+6ZpiIgm0PjDu0O6u7FC9bAI8Y9Hd0eQl+FFES+vO9o1Rm6PpLKj0EL/?=
 =?us-ascii?Q?eWkjpYLDH67vCbwJmvIO4Xrh3ftpNcnmubUMOBkFXPWSn2tHuEyyPq4YHbiT?=
 =?us-ascii?Q?ekJJ1x/9FtvfJIxqqYCbOzeWfqmAl9rjN/+wE8jAj3lqtAyWlL806e7f8r5J?=
 =?us-ascii?Q?oWt9jYtiXVdpckhiqoz9HiR9YcFT7WzEdClgImqstm+4fV17eljQizI3u1tg?=
 =?us-ascii?Q?Mvba0qsVa0EPXwcC3b6tM4DagWOGcPsy/RmQWhqFUE+nD7CsZHbJuDNF2rCy?=
 =?us-ascii?Q?VSYUFrH/teaO5WfP3sqkqZgQPjmd0pdu6/S7L2ifDw1rZPXqS5fEccZ6xsva?=
 =?us-ascii?Q?uGUaZ2fqrkgXs7Jg2qIeL5UMrHPyT18a9nEwnhjSIthgCormxucGa0f7GHu+?=
 =?us-ascii?Q?KcB2vphgOFYXiGR9qcIgvhAKJP8osvU5ALrP8ccHNI5mM3iTMQdcGG3IeaRK?=
 =?us-ascii?Q?wvtROoIgGQ/m7umFwDGBHapi8hp8R5HaMsJt7hEE+4ggxL4YUAnbKunxG1lP?=
 =?us-ascii?Q?XnSIxAvCnZ7k2sXh8tDIUS63YsX424Kgxv4XqxCP1IPCGYu1tdPxZOJ+qNfW?=
 =?us-ascii?Q?TMo2pocBIkjUJv4JZi9CyOGzXoa0AWUI+1ueQmL1omDMQ2ZE2EWAqSX11Aai?=
 =?us-ascii?Q?fM9N36QnTJebraPNpmJszsQyshHyPCDzNLRWlXYaPTpOKjEjcbdceKPrCDRS?=
 =?us-ascii?Q?zMVbkPxcgN5rphgtQpjDbfmowL0uwZp1jhN/0QLiIL00woaBGct7lQXhLGMq?=
 =?us-ascii?Q?cyRJ2+4FLz+s6J90ErwUPiq7+7Q5Hp8AvssQpBUu6ZRoU1SntCF61XF0wqJq?=
 =?us-ascii?Q?wPPwSFLKXQHu0kROtUWKQpFVEeR1HxujuO/I243ITUaramVxK11fDReV+94g?=
 =?us-ascii?Q?EADn2CD2hvZNes6LwpkELD9o5JdmSMH+ZyyySeCSdUWCYaGcTbGm2oFGBKvv?=
 =?us-ascii?Q?qCsVznOiIArPHz07ofYfdrS2RRJt/uXZKSTBxeybGtUslmJhyYXcmlLNeo25?=
 =?us-ascii?Q?uVV4e2o/i0SnImNLY2V1OOMYlU+x6JYTQaTM6asO4HMEwBsoWEEwr58XhnOs?=
 =?us-ascii?Q?XotMNbDwjZIhnbOhYxELzLoAB4pwX6l6yprUH+IF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2b28092-64e3-48c2-bfe1-08dc322fc8df
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:19:59.5898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ht0Til53P0Yq84YQovZAFBaOUlxb5RP9nmeb9qDjsFtFsp7tLA4+4vVS7KrEEJKLlUgJsc3Ik78euL3pW+qwxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682

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
index 12a2bc76f0b39..072601591fb4e 100644
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
@@ -1288,38 +1266,26 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 					     "failed to get pcie phy\n");
 	}
 
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_APP_RESET)) {
+		imx6_pcie->apps_reset = devm_reset_control_get_exclusive(dev, "apps");
+		if (IS_ERR(imx6_pcie->apps_reset))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
+					     "failed to get pcie apps reset control\n");
+	}
+
+	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_HAS_PHY_RESET)) {
+		imx6_pcie->pciephy_reset = devm_reset_control_get_exclusive(dev, "pciephy");
+		if (IS_ERR(imx6_pcie->pciephy_reset))
+			return dev_err_probe(dev, PTR_ERR(imx6_pcie->pciephy_reset),
+					     "Failed to get PCIEPHY reset control\n");
+	}
+
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX8MQ:
 	case IMX8MQ_EP:
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
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
-		if (IS_ERR(imx6_pcie->apps_reset))
-			return dev_err_probe(dev, PTR_ERR(imx6_pcie->apps_reset),
-					     "failed to get pcie apps reset control\n");
-
-		break;
 	default:
 		break;
 	}
@@ -1449,13 +1415,17 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND,
+		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
 		.clk_names = imx6q_clks,
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
@@ -1472,13 +1442,16 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	[IMX8MP] = {
 		.variant = IMX8MP,
 		.flags = IMX6_PCIE_FLAG_SUPPORTS_SUSPEND |
-			 IMX6_PCIE_FLAG_HAS_PHYDRV,
+			 IMX6_PCIE_FLAG_HAS_PHYDRV |
+			 IMX6_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
 		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHY_RESET,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
 		.clk_names = imx8mq_clks,
-- 
2.34.1


