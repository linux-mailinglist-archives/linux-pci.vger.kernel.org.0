Return-Path: <linux-pci+bounces-15679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8914A9B75E3
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACFFC1C21C41
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 07:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE0814F9CC;
	Thu, 31 Oct 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GSCFxlUM"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2047.outbound.protection.outlook.com [40.107.241.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA037186615;
	Thu, 31 Oct 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361455; cv=fail; b=aPmIL6qTk65tlbPQHJpfjG8zmoiVUz8CnL28tO/a5GLZGAuByqIybRNv4I14iQfvbYF7HWq4I11BUP+l7e0aTd+FcxdB0jXLup7j53eBaZdURpyn9uyNepIBoJvY7NG/6lKE011zwQESBc/vYFJwe8x0yytHc7gSB/42BU4D4A4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361455; c=relaxed/simple;
	bh=wgh8MWnQ5WiLKbTXhZ0tm2fvsa1yO/xAJIzWe+B2o2U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZnNwsOKcgmG4xergSlJdDmLA9N2SsPoFKMy6jhGUO0UGVDc5F5Gvx5cri1u/UYIOCFMCt1R3MyMs5urBWFsM49/VnA/aizVYeKM/sUO/KGVexztm68nWh6jXBgqxGJCCGLqEtYbxA4YmboyN5v1Dsh7h7TiZDu1Vo2fNbY2ekCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GSCFxlUM; arc=fail smtp.client-ip=40.107.241.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVQqPhhFzzAD58Y2w24FEyJO9ykbP9iM1APcTaI1bSkjs81fHd/BDUs7qe3uqHmcr/IqkrhmYyoQhh0mQcRmjBl7FLaFsXyPNrrLGSDzhLSOXI9tfUkVan/5AK6n2PgnAfZuAD1HWQzzpQrbTPFkWhyoz2qHyw5ERuzXEcIY2OE9AlAQchPeR70f/Q1waCH2mU1LH1PZeY6bpi/+2jtdvfH22KicmCRHcswbCiLP7D5PupdwzJyrKKf/NI5L2NvPbKtoq43ExIy07L7L1vRrelMfWUH+QoqGgMG0/wAC1fbimX2ry396+1KkqcWvhoeRzSVXlMuDfFoGwJ1ChsuDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnSkLIV9obQZuA+bG5vyt9kpBfeeKXGJOSCwD4qlG5g=;
 b=s6QCwjLV8okhJuYJmT/PPzde2dhQ3IABL4rYCqnRKit5EZeRBC/lH77H0lWonSoYqZMKI0lr6+ufASZCX9Akoh9mrvl8g4NFfhRyk9Ursok4sPXpZ3qHTOmUVfceXZZM/xbZCP17Dxt9iEMUCJVwdPXhx2moOx564tsfCAAOPZjXJIP6MmV6MTl2HB9A2demI7U/KAFYGmiXIkzr39YSDBG5wY2yqWhFH1MNsGbJ8RMy9s2UZWxPzrGIMNCdi43OhobGZb8SniML9pI4a2gI6GbvkjPrS+R49WQYKNh0HLQSIfV4APdql8pqtnRmSV/eK3pr+9tIw1faNF+KqAInqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnSkLIV9obQZuA+bG5vyt9kpBfeeKXGJOSCwD4qlG5g=;
 b=GSCFxlUMWhm0dYTaPLf/x4NDgyY8fKc00hxK49BAbZ7HgFGqvLap0Q5jE1iGhp/1ULrLVDWRl76tGwBtdYdPZT9hJ4oagApG0LrTHmb6sj1bHrMyOo9S2d8pTt5EseMxKpO+BkylmA5tgsQcK2V24e0FO5bBXgZ6XMfTWDWfOXQHHHPCqrvik853lP3YhkK+4kLJU8iUKqpPzmlxTsctXgZQcJJVxNkr3rtk+ZC6uKozqaCU2G785oYCo7ickPKB4Jve4AqltZQNj37zmTMoF/9pRKTv3xViVV+FzdYkjORm7gANxM89Ipw5LNAkGUVLngAYhyU+h7UnHzY0LNnzSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:57:29 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 07:57:29 +0000
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
Subject: [PATCH v5 06/10] PCI: imx6: Fix the missing reference clock disable logic
Date: Thu, 31 Oct 2024 16:06:51 +0800
Message-Id: <20241031080655.3879139-7-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e0e5dc12-5005-41e7-65e5-08dcf981ab0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DK7YjFBLbdKU3dDTXkAg7EQj0Fx2B/FqZOwQ1ThReJ+liwIvnFMLaN+l1ABx?=
 =?us-ascii?Q?minGuO9aU1YjWmE0k73PoATCPimBsZMdN9a0w+WyXjA0rvi5HMsY3WYeTMI6?=
 =?us-ascii?Q?qewUj1epX5acv6HPWCp/IGu2RjdN1QcUTsrPxa1Jj0ACdfUl1xERpsi8zkf5?=
 =?us-ascii?Q?mL2nhV0iSiGUAzwoC/fMM15w8pTHidk15F5e3GwCRetdI9/sZyU1tGbpkpuM?=
 =?us-ascii?Q?3Rs0TUDXRU/+9V9l9sreYmFChGV2tJAstR7UA7+Uty/DGR+CbUVABh9D9sUo?=
 =?us-ascii?Q?X648DyxcgHqdPRpIWh3LZPyhkYCO8j0SavD7dZ81ltjIdwYZ+CxELZDd9R6D?=
 =?us-ascii?Q?dKBPn4QVoZQ4rpWcOYCcjuwDsLW/e2suHHz+nTAyH2N05ijM9VhvkEucr67Y?=
 =?us-ascii?Q?adXtdP2Aj3GuYdFxwwrpE1t1A4BRGlG7J/L+3S+BB+rTXcfnv2eCfGr4wtd5?=
 =?us-ascii?Q?nGX8bOmJ/NhKng/uiBurXuEvsK+zFWq++5NIw5JssLTYXX0Y+azloIAd74JA?=
 =?us-ascii?Q?/+lzdqsBsKdFlorxAEYZFBEdVSdu1qbA0GSKM3DDS6sqbbQando461WNYdFl?=
 =?us-ascii?Q?0HxjuF7hmUbgoVKuJ0jOjwgdqXhWmBc871T2feDCg36Nmcg4w4dUZolJuU/C?=
 =?us-ascii?Q?tegEbMHumYxlY8KKG487o1VwurvU4QlFgk3cqhX6S61KD/W3aFDsIKdDC5A1?=
 =?us-ascii?Q?XZmKGGEekp+jk4YQ7V48jrwemKcjdGftXiNXkLA/23noDc6z1ngvjXpOrD4H?=
 =?us-ascii?Q?N6me1mDCXob8bgWzeguNsvaW7oWKJ6Q9SufUWqive+KuYq+ichfcC4oiEzqz?=
 =?us-ascii?Q?kjGtTwisGozuqjNTnEo3Z8Y/lqS8LKctmQBLZ6IdHIWLZOuygbenzFl9lsNz?=
 =?us-ascii?Q?Sk6VTdKAfhVd4+2QXqsdHyxZnHuhSfemeaCNVFmlM0509Y6c25tGiUx0yVwC?=
 =?us-ascii?Q?jxb+lrdVv3QOZz/RZGNuua+gf4wTtNYmQKcK6GO0yln4pLtOVRgXiJrTdGgg?=
 =?us-ascii?Q?M8R/hGdJ7Yo4mFSV7B9qPag/i9+aGsMnpHpCoaPVzloIn93mWFQuqMY8rIXg?=
 =?us-ascii?Q?v2QuBLqAJv74rJpyBFtz/cfUWJF5AeFNG7PSDy/qIcdSprT4VjqyrT9pR6f7?=
 =?us-ascii?Q?N095jdX3Gs4Yw8ivhI61LsbCeFZsrfLGLOZQWH5ByJJS1wlUtDPHG3Lvh1xe?=
 =?us-ascii?Q?e18Q5dDHSSCG53k1o6kUCPE9+oetiisQmdanwWTg7rSNeTg3UZoaOEdZMIZy?=
 =?us-ascii?Q?NElQnJms8GNf5GlmiJTenYnNv7CMSyYgA7VVc1Ozg4GmLgszM+JVaV+YCEJM?=
 =?us-ascii?Q?cXez5iR2n05PZTVD3RkegM+ePTLEsiRj4NQPfekUD9SDmKcv5tpizjJlHWI8?=
 =?us-ascii?Q?8JeQf47rZgcoqzd0Rsmm2bOCbfGM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZyheOXLonZ6mxBDDXNe4Qr3MluvHbuqGFRTT/pMPmTKMUfPrNLfCWS0VVs+Y?=
 =?us-ascii?Q?39vCcu/+IJgGI5ipWZNsziGekatuQBNukpnIgGwxUJwkzY03UT8lsQwfE2yz?=
 =?us-ascii?Q?G9Opv6R+DuHvpx1KALJxVleBnpBhjGqan9HB2FU+qLTmi1Rim56qK1nmDnAb?=
 =?us-ascii?Q?6TMiAt6qY3ZZjTOj7vHhuubZZsg4VLBEzfLK3TNb0z7Enj/GCLfYjv+7TJZN?=
 =?us-ascii?Q?C/Yuz54PaNyBBuCO8BQ6GfOoPEl4r/M1vvVj8ebP21wnkaUY7l/hwScJTlTN?=
 =?us-ascii?Q?ox413sxXOkAP2raKtRhKlSzriGBGe1LV6xQ1hrP2uE1NjYel8sKP1iELQfrb?=
 =?us-ascii?Q?BoJo/9Tu3HsU1YCG2GWH6I2lbsd7dCaeNXxYdKOlMF3QY+oRunPUsd1wCxHt?=
 =?us-ascii?Q?HPOOGjheT6Pu9z8/U0IUhgkHbb2iiTfbvGYDQzqvaDrZZ/eu7J6hMOzEtMQN?=
 =?us-ascii?Q?YF0Kqjd+gNFE+E3pbdjNK7O7/kgvuZtpHJG4S2WaJZF/l1HNRH6w3la5TNjX?=
 =?us-ascii?Q?bpHuD5YDGd0P2aowWLVkRrs4pvfI9gXs5gNavpe4BpH+VczOx0p1xWsVOMrT?=
 =?us-ascii?Q?XvYuWRsjzKaTFV0qhtwQEzhg/anTAQya2Al2TeMxQI1ej+iOKHbplUvomM/5?=
 =?us-ascii?Q?S8BN5SHRw7H1Iau2xpJ/1/IlJLVCpJlcTzQuJOufI+9WWZthbaGTMwmGWpLC?=
 =?us-ascii?Q?qSwzNYMBoFF+jPtpMXSE9vD9xgQbvvjZHqrsR2F7622COUX6FukncNVDxYXb?=
 =?us-ascii?Q?r56G3jzZ0c5b4LgxoxbGuWWixRzH6fbwzHFpzQ7lBC/fDcBoPGACUR9wZhpu?=
 =?us-ascii?Q?Io65h9Q5WvABE3sYg9qIPNasTKlf0XpeBu3tt9e9CNLCPKB0/a2OSEjB3x5l?=
 =?us-ascii?Q?NFhrJDWVkQ/G5RjOo/4ED/EG+jc+XexJBz9kOszH6PAO27ukoptJMvFl7Wvh?=
 =?us-ascii?Q?uRYDjVT1mLRvocfDfpzwcqLSci8+ewNu7m3LTpE4b0dk81a7ZRjREKhVOtIN?=
 =?us-ascii?Q?Gfrl3in4KyzCO4gxeyEdCKS1DLd77yzko7BtoLpKEzf1olkeQLMU4o4m4sTx?=
 =?us-ascii?Q?CYGTbsQSbZzTMU+BcYRika5blhEzdkGnLaskk3pQcCSnyWJMSoUtHZGTkaPD?=
 =?us-ascii?Q?p3GKGacjnKe27PVJMxRGRQnLOnLPGPS2+taTIQNGgqP6NxkJwCFnFIkwriDh?=
 =?us-ascii?Q?kDzUgF0aBolbG6gLYUcjhu8EKVgPMTvK+yRZEFItSZamMnGuV4MMbWMTWLHu?=
 =?us-ascii?Q?NoL0J1rvCwR2lHUMvGOchJtJC0iktMYI0sjTjEoIcYcBgx5ic88/bYqsIw5o?=
 =?us-ascii?Q?kNtu5vQwlBtZmYqJCXXsUBKixXwC0Z19coe7hWG9Hip5QHDg9SuF9sE1fAVe?=
 =?us-ascii?Q?u/5E1thbmzze+pjNW+izD0a9BtufTkDLA0DOzBJTwcGnb0T7QBPIJoPb7PYu?=
 =?us-ascii?Q?9LjhL4LEY9Cl85s+n8RncCGNN3fVZprjJlo3h3x9RF/BKtgHfcz3lJ/AiIOh?=
 =?us-ascii?Q?UqBXb7OKuRZkEYYfcXoCoMDLz6J4S+Dvzh4TTL+BwkYYtjxJZfFOEQYbimof?=
 =?us-ascii?Q?O8kfVb6o57NWXRzDCkf97Euoa0Yy/XsY6oGJqFWX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0e5dc12-5005-41e7-65e5-08dcf981ab0a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:57:29.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZI/pP1JPUuIOqD0e0ofjIEb1mqpJFXW3NJ8XoNgLT+xVzM4egTAlGohJkP40rEHcau9u+7ppy2YKJ6u3tS9Z8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8139

Ensure the *_enable_ref_clk() function is symmetric by addressing missing
disable parts on some platforms.

Fixes: d0a75c791f98 ("PCI: imx6: Factor out ref clock disable to match enable")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 92f2d2536ffc..e696dc9381cd 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -594,10 +594,9 @@ static int imx_pcie_attach_pd(struct device *dev)
 
 static int imx6sx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (enable)
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				  IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
-
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
+			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
 	return 0;
 }
 
@@ -626,19 +625,20 @@ static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
 	int offset = imx_pcie_grp_offset(imx_pcie);
 
-	if (enable) {
-		regmap_clear_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
-		regmap_set_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
-	}
-
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
+			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
+			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
+			   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
+			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN : 0);
 	return 0;
 }
 
 static int imx7d_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 {
-	if (!enable)
-		regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
+			   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
+			   enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
 	return 0;
 }
 
-- 
2.37.1


