Return-Path: <linux-pci+bounces-15680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493A9B75E6
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B88E5B23B09
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD2A186615;
	Thu, 31 Oct 2024 07:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SMoAf3FZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2059.outbound.protection.outlook.com [40.107.247.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1A5189B8E;
	Thu, 31 Oct 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361460; cv=fail; b=cbd8GDPITFzGsma03jzeUyHO+1VNpWojH9p5cA7Nm/Yt7Wzgazr/2e9WfXFvyghAWwCl6kEaWYXeNTJXDEFaju8cOfQfbCLif1Oei0bjGyGe5x3ggHiGTE+i+CRK++vWLpT4DBWqIxz3eG97ZJy5dXe3a3ChBh/cEdrgRo386PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361460; c=relaxed/simple;
	bh=6H1IcKkZ8HQn2jqLOVZwxXHJBZAWksViw52g43JCdn4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bgHLgp9kn1yNWzjIkzCHS+CIpm5JKpH5djTxqlaqBlj6jCqy3Jl43G4l8YCxkedTsWMijj3ChKIOeFTEUKrAdtcu/M5ZbmSFh/W8eDuD7PElml6er8nnxg51/Iq4XjW+YSOpmaVPGEPVrj3a7NDrey1p2fl5p9jzDOfESnyp0C8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SMoAf3FZ; arc=fail smtp.client-ip=40.107.247.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp5tb0uvvd99Ds0LkG1c5d0a5PSzQJ3zb9R8oWSiKCrZgyIGxVFLkKnkhD6wVicKzNokrZLGpKzkqnpMZDPm9f3ENZAKJMQt14fHA7vMNOYlu3u1g+dOnnJm9QvzgTK+wOF0L3jzWLnLG0NA3C1Ay4S2l0nLEaeuEwxAovjp4h0haORYFhRD2F70fxeoaacNoDsuKEhfRy41fzmE6HghT65Cc2mP8//EtmmIWYKiBQlhmjf10IbVHQ/QpYXWYWjtRLwgcrgJAWEtnvhjZ4UEWiTYBCngL/590b6a5GBshEKa1DmsyNziyalpYBv6YdEfj/1Jdb4pXusl8TU24HGaGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cm53bTy4F05Efkoub0PfGe5TKog53N+URySblXqbzdw=;
 b=Hp6BGvjOhkdlTEDsjWyUwpPS4vCM8EtOxtmfcsX27HSLpvs7mjtIuSCDQ5Dom9FXtOC9yIzLXbXnJB8F2uYt59Wn6UvZuDWekDjjWNnml0uOHg+xaYRVaxuGN97rPyF1DmDF+os43v/3PqAxUPqGWUr/9EhwM3IMfxRpu3j0gl4jiXNxVvcEKpbJWyLrt1FbvxosglQhCODFZS3YX+js125DN6QaZfgWBD2oGwtqM51Py6j6XOcXEQyytLJwdlpuyb7fm54PniqdV0beAW5xD8X1NNKuzAzTMZSVassuQsj+YctXT789OCnzPiTtt6c9nJb2lkdAFy5VuplWbVxTdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm53bTy4F05Efkoub0PfGe5TKog53N+URySblXqbzdw=;
 b=SMoAf3FZDigii/z07flBzot7uTDGdJCo/erOU3uvdkNKqV+WQdsU5+jTmkohj9sZ9g/dQksWLY9XVCUE92mbTWLgOpUmiImVtJ33EuyM66qCgUtyLM2xYa7V+f36rWFKRhC/sj7A48UUQElT2PqLxnORBor2dzS9EnLDyb+aoMKuulZYQzyCJvucLKTSn7ms4VIUVVsIg/NcCkkEbOWc/7uBKxESyRbL1Q2T35PFTWcdaOP+E7TEgXeobfxN9jGkawrglboimPdVmQxTtcUftNoSmWJUsMA0W2157D4VGWOf1VW1lwmEgYdj6pYsduHhPem6roZ05HZbpmzi5wkzJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:57:35 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 07:57:35 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 07/10] PCI: imx6: Clean up codes by removing imx7d_pcie_init_phy()
Date: Thu, 31 Oct 2024 16:06:52 +0800
Message-Id: <20241031080655.3879139-8-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
References: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DB9PR04MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: fdaf70c6-5e1f-46a5-df24-08dcf981ae68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P7HB2YxWU+nKbhY0ZnVns2YF4QMoZw+OKZKoGWiAXi2UatGH1yrINCl9ou3h?=
 =?us-ascii?Q?QvlY/NDTIGbdEaAacoJl9tkgXKb2WqU+hv/bgNpLM/RxpPInrJsPCBf8y0U6?=
 =?us-ascii?Q?oeUiUCSotnAm4Nc0V0B401ItxND0582JASRv0qNRJmciYWG6lQbKG72uXeA2?=
 =?us-ascii?Q?XBGeE+5H7AvF907Lx2JbtKYR4LzYERsb5XdoZ/CEgmQ4h+hR2sCvL4r40NNb?=
 =?us-ascii?Q?sxGqr0TWI66B6topup0gBJlFwc8/p5Ayd8EL1ba1XkMpO70mlIzOT1CxlPhS?=
 =?us-ascii?Q?biq/sv0+ZT7uvX2lFLzU1mpJEXHMUF37uJOsETC6lEKEx0ocS6S+JJDSlNPf?=
 =?us-ascii?Q?YZIR+OCVKQAnp6kyakjRJKk7cIuMsyzCp+A6iSIF/7o/nOUPLifXAuFukuaP?=
 =?us-ascii?Q?AZCD1bqHFeT95oZbsr4cycs5LvE0CUtMbUHayjoWym+DW1rbaLvlTF0xU6bx?=
 =?us-ascii?Q?mbTQCK2xhRS5kNqzXsM43ZwIPyE3YBOwWaivLGUgDuC7f1xIQQAdc2Luc3bh?=
 =?us-ascii?Q?CZBY8Ur4Y2q3Naw/Qu4gQJdBrequsVKBFjpPY2ay+Ho/WeYtKIVXJqNINTxM?=
 =?us-ascii?Q?rACwXLxP8Eo095xC0y2b87D93iPB6lCgVv7TzPzD2SmrdybKSY55uNYERJO7?=
 =?us-ascii?Q?51Wo6TnL6vzV6klCa7PveTndjuKYoHx4WjXYsnsNcNrGVyBSZ3oi07r1M1WT?=
 =?us-ascii?Q?oIhJuZCiaq8CPi34AS9mTMj0GVXZR796ewfbRtm6QhIXuU1ts6kqoUxyuPDC?=
 =?us-ascii?Q?q+/iY3p6xUM2lETWivleAmkOhdq14SgbPDqJ068wxtJu3LyMQuvR5MzN6Op3?=
 =?us-ascii?Q?A1CpTnywNMzN0orcdWvkHi7DDNj/XnL/ONsKPuSvXYsWCWGtkZHQVDi1NFxU?=
 =?us-ascii?Q?qDrwNeqw3HW2MOSySAqNnW3yTxP3U/0Y1tx7KTSNyxn04/JAwYoA04Z22mCL?=
 =?us-ascii?Q?UbvMwc1yVTJfapgHw44XgtKrmgVssuPeL4KpfS2Wh4mZtsixfV/YXGVKAY9m?=
 =?us-ascii?Q?It3cAZfzLlPknXFMc3QsUnLVNZUULkz1jVhdjr6Nz3KF7ydoTbqFCFQAdbn4?=
 =?us-ascii?Q?QpsiA7JfoBPxt97XqEhBUCMC/Uu7i/PH3pz76EVR0lHSn0Xeow1+93NSdxPO?=
 =?us-ascii?Q?/s2v++3/R/GaXuH3Ew/6b0rm1Y1oLtf1jw1aCTxqyNEgezLdyMbga8tFvv1H?=
 =?us-ascii?Q?+uI9FoKk2JvjxDrDdcbENNbYhIANR38kZBDlQkV5wGv5uFN2l+nn4FNYi/Cp?=
 =?us-ascii?Q?eKh0e2vR2yDYStC2aHks7uoqfLNgJc60RzBDImrMREXANPySM5x43c0a137T?=
 =?us-ascii?Q?7U22pChkb8Yi4BtbEe4uErTtSVe+2apjz9Nnhw+DQXVUmP28xOy6ClLkMseI?=
 =?us-ascii?Q?t8g1wRORmwsYzLcYBw01E2dkldZl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6tC76tzh/ac2O6/nxjWPCV+6cPJWCCPPuuMthrTZhnBOi+lSCgirAGVBsZph?=
 =?us-ascii?Q?gT5qS+HD49T51wmXXnzS4UK3//ymc6krIrjaO3GBzOcCnmQQFfppv5sAOwXj?=
 =?us-ascii?Q?/EdQckJm/2QCVTJFPsOH4aUESbKGxx8aWtwcVI8tQszcXManWWL+Xz0nHfMI?=
 =?us-ascii?Q?m/xzDmoanukTFfKbgAU9idybVGRgFAqnMIft534c1dSb7p3T800JdmAQ3tpX?=
 =?us-ascii?Q?ynmKsAfndG/hBWdWpDpdSlIWC6p6UR80lmgjqNcOcodJ1M/Hep8RGf/FlkDC?=
 =?us-ascii?Q?F1RxXcc6tEnjaNozJMA+dL1lv554+YkbtouWsXYCY8XPSrBgZjCNxfkpPqgy?=
 =?us-ascii?Q?xYEgFKmWvfb+PYA4X0cVYoNmtEAQ9ZxgLol9wkAPwbqzRG76jdER7mqqDuSY?=
 =?us-ascii?Q?241UCjiSparUzJqJf5FjYYoe0s1dEXcGFAAJrf6XOM81qUs/SPgquszxPz2d?=
 =?us-ascii?Q?WUQAcRHNrDa7sqnIatWGyMMSrNY4HnI2Z6CHyelHS52/LRfVzcGl6sFeOZ6m?=
 =?us-ascii?Q?jkobr3UV0A7gzLsffijLCVedkAqCCBGEEPwiFm7slmld2hKPxCGLNqDFUivg?=
 =?us-ascii?Q?3hPvhk07fHlGDICwx7J5TpCAvqRVACeahuF9EjxYolbdZOs/7P5WSlaysScg?=
 =?us-ascii?Q?XvWhwLsX6zHbaJpFqQmqPJEBLDIidyYDxyV2fntZqXpF9P17L+vOf8Um1uNm?=
 =?us-ascii?Q?l371REqYwXJ7Wh9BvnEQfs2iqFQ64+jMqXEAwPIQeeHm5Mv/NcMyGJV4hth/?=
 =?us-ascii?Q?3UOVpna0OkYC9my+I+S2SLsAeCOUQo5wBzxHYHTX7KmtV1Fclx9zuMDFREl6?=
 =?us-ascii?Q?ZVINwHFMctWH6wRgsfzsPx1nuJZiNTchclKbr+irnoLDfJS9ca1sCM/L+uUX?=
 =?us-ascii?Q?wx28704lQ3Zlx00l5UkHGDKrWtwRoPq8Ub0nSpgrl6MCmrwFj9yCc1UnjN9Q?=
 =?us-ascii?Q?aWvgKU9otULErvbM6AfZlsGxvvaELcTs1zUNI7JGlKo1uX+LLo7Im6r48rE9?=
 =?us-ascii?Q?UjolQUPXMSFuOvMhoYqsEXxHEN0oWtB7qxTQBKcZYCBm9kCqOdJN2DWH36v8?=
 =?us-ascii?Q?9RDU0Vp4FsyKWo9dJBC6gPRgh34j/Dwwn3or2AOyB+Vn17c3+Hs6SkXJl3qQ?=
 =?us-ascii?Q?sI5SoLwHniknOJCAEqnGMHAuCBdIsxM3rQsZAv4epUV1cfW7Vn4Ljsvraary?=
 =?us-ascii?Q?0wSKQM/2WxD1MAWZN6hwCjxteXjFXYEzY2DjOmSv6x40R/IzmqtzKel2blr2?=
 =?us-ascii?Q?82K3BiMioowjSx95l1UxnKd5N9R+QLwIgW+QCr+UHpzbye3yi95pMk7mfbaZ?=
 =?us-ascii?Q?lMBCYGP5obTHsL+1LIdIW8zlJsQUQ/A2HYd9ovbUDtU+JES3I1142VbeKp1z?=
 =?us-ascii?Q?P95YmESItuO3CB0CGmonkedxtpjZ4ZrCFyW7vuJ0LayrzzvQnDdgeRD8vrH1?=
 =?us-ascii?Q?hNrsTbBtJMNGUVv5/E9n4J8mJDJAdREIUeCq4Gsgo0xTgBiiGUhbbjMFi+uX?=
 =?us-ascii?Q?JVjLPX5VhtXPrEuHaQ8Vr9iey0BGA7GeeqWhKsH2beds8UP/5lR/YJjkaaYS?=
 =?us-ascii?Q?Oot7mAEKrAUCgz+LXPGQLJ1MYIFiJ5JTA2l2k3TB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdaf70c6-5e1f-46a5-df24-08dcf981ae68
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:57:35.4829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qr48JUOOEQ+PxflcjpJVpJjqoNW+fXN5/AacqhDx5GD/X8g4OKS+MCzg9c2/ChujlTyR+/qlosr2ORdHkHpKjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8139

Remove the duplicate imx7d_pcie_init_phy() function as it is the same as
imx7d_pcie_enable_ref_clk().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index e696dc9381cd..dbcf22e440e2 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -389,13 +389,6 @@ static int imx8mq_pcie_init_phy(struct imx_pcie *imx_pcie)
 	return 0;
 }
 
-static int imx7d_pcie_init_phy(struct imx_pcie *imx_pcie)
-{
-	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL, 0);
-
-	return 0;
-}
-
 static int imx_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
 	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
@@ -1529,7 +1522,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
-		.init_phy = imx7d_pcie_init_phy,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
 		.core_reset = imx7d_pcie_core_reset,
 	},
-- 
2.37.1


