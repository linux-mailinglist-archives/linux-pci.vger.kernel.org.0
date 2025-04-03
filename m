Return-Path: <linux-pci+bounces-25210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0011EA79B78
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 07:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A88C174D94
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 05:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829D01A2387;
	Thu,  3 Apr 2025 05:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EgImKrp6"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B6A1AF4C1;
	Thu,  3 Apr 2025 05:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743658892; cv=fail; b=q6K+awyl9TkXlmJ9MG4aEzsl6l9ABDXBq1RtdIIsNAxKIBC2SQgogR/+NtY2cPKFe3gP+oJf5ydA7dkuOEncrD6Zg/hOAGMhTkjD9cff4BMiVmgJO37i3Ou8tEgk9+xOC6MDcaCkLwPpJ+ZXE03VlqdQkA5y62MNvLfX/2OXQ2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743658892; c=relaxed/simple;
	bh=6/N6AhsIKKVX/EzQMuLog+bdR6tCLrQFPgzco7Q2IMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oLZMhJjk1JEBs4R26gpJv7ELb5zd7OM9g3G2RIFwjf2YvVWytoB8iDePbLhOPpstEifGHlYb5cJRPsXuVHoAJ6PjIdz0CMlC5IHujg0Vj3H8x2pNF2DQ3otALEPnOhG+rY36kNaQPwE4E72z1Qv5i0rP4ljm7YLZy7o66Ub44wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EgImKrp6; arc=fail smtp.client-ip=40.107.21.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DL38sZ9igxdf+w2tLPIo9XXxpR7H79QlbHqixIoJlrw7ED5i50yAE3VjOH3EMFWRlbUjJ6bPismf52sCeyBT6w3DJRgra/1b5R/A342MCtRFdQS5XorQRoGrze2fsQsQh3D05xXcnj5GJTZdmXD5Rb+mb3gzwK4Kc7KFqmmhqxQ0wRr+XCrBVwPdfeRA0+LeP7mn3qN9FSu/oilrXUbhycuX8T7BPjOHv3lM53mvX5BmG05/lCQ9GvfXPyzjUxJpa613qLb9nvli7hqr77Royp3dQxwTYapMwHDzCMcwNFfZ8vF9pHIiDjCx4gAMpXprum0/rvdtoMlz0GtDpUa8/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6km6k9oS29LQGkAaLwbPEhh+BnLATYwBngW26Xo4IQ=;
 b=A383SDn/fNIwMqEBBG6v5COml1USggHVcKRttxdqDIvVQ+vk66afuCFKtmJE0OI4GZj7g4u6Ec5CtvdNOgRoUcFy9l5CXHFaztkyufEx1hEekmVxndHqSmFEJGHL3weXa47931rupMaDYI2qTIjzZ/TrvnaK75FbfnQvaEPhTQQX4QNlq3WcIraKd4DFyHsPgozEF1xtln0hpolR74czXqTTap4ohnPtfm3LFMtmcgJWNGiX+NeBk6nsY65Z7hxdPv9bfBR/A/YkiTiMrEMbzwl3QsJOQ0xPqVlT4O7NcZrX/Xw4UyuZcu/neGVemlGkrC60alUL/Se8rhjmtLVcXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6km6k9oS29LQGkAaLwbPEhh+BnLATYwBngW26Xo4IQ=;
 b=EgImKrp6/G+YRR6ajMKI7W+HKZFs+lTpa5+S2MRbWuaxt2nYNQciDK1AQdcAZWldiS6/Mf63MMXtRu4qnhknNTGyV8609p97pSAzlgJiec5BXxDGNf2dVsiVqrMvXgsedOg6llLz1b5SY4jQXKmL15e9Ms31cH0vS0rP8fmXn0cCA4jTMhZC/RIKWWyZKWrAer2LaYZKGJ9TrzYsuP2o+SC7EaZ0CeVbKyfRbAeGGBo0dwpAM/BhiAoVjtWyxvIA+b1zTDuNVT87mTP4QRbMaDK4QuFhfYjR2YMqLPIHBccCSmqkMblGTDW3gnQ3i3RcJEsMT4y8GfHG3Fb171LAbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Thu, 3 Apr
 2025 05:41:28 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 05:41:27 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 6/7] PCI: imx6: Add PLL clock lock check for i.MX95 PCIe
Date: Thu,  3 Apr 2025 13:39:36 +0800
Message-Id: <20250403053937.765849-7-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250403053937.765849-1-hongxing.zhu@nxp.com>
References: <20250403053937.765849-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:81::13) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: f9f1062d-36fd-4216-5729-08dd72722dc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0KAK+ZAQaWmD3iJtJGPzfaQRlGRM2Cr/uGSW+GiaW1mkHdUct1IRlPmfbf+C?=
 =?us-ascii?Q?6YnNETx0TNPuaKN+/8WhTqNg16IDiXU9knEeihvoIyA6nicGzxyfpSBxBCc+?=
 =?us-ascii?Q?McXZ1H7RGdJW5AwOlFBDbdYrJ/aDbrceTkgC/A/q7DXBG2ZOyE/Jc1DxQGgN?=
 =?us-ascii?Q?ObMfmybq7+KinutLkkWDEKtxF5xmVzajR3CXQ0C6ybKLdTXDEmAw2a/BudZy?=
 =?us-ascii?Q?LmTOtiGg2d4hlq2rH9hSwlwxntGGCq5lOFu68VrulEmnFundOrd9uMCTOOyn?=
 =?us-ascii?Q?6naaY9c3djOwhVCEkci5WSMZFQQMk3Fgq1Stb0rWCfXtq/ETd2h4B1/J1M2D?=
 =?us-ascii?Q?ViG7iQPwiCGx6IBHjBAvvM99kwD7Ufl8s1ctb7K6iyHM7smNPBVs8axgjsPP?=
 =?us-ascii?Q?thg/Scvkvc+6VkhQ0S2zqBQba61epZA57r8hqphh/rYUY27ylhIVI25tF/4T?=
 =?us-ascii?Q?SDPqPzHBvn/wOh13DfuM3pSK5vS+hHFpK1rM9vfyA8WF7YlndT1OZK9jpPdU?=
 =?us-ascii?Q?1L7iEBIjY8PIVfw4UhkQfv8rLC4JG9rgyoI2BiDh4QjaY4KLXRtrbuiLoX7n?=
 =?us-ascii?Q?wHyC31FROD+Ra6p6YCAU1UgGLlkbwJJICD5qWBdnDFaZw5DP8wQ0B2lYkCXb?=
 =?us-ascii?Q?1e6OnQ7vMaom1V2wtEcHUwc5VSoL9UAnxuj5Ry8X003+VtClg7ZKf8UAIcX6?=
 =?us-ascii?Q?yhaYFCYtT77aJh1vlCXDQidFcdJBRCmUXiJ9/pnE44XdTauLwc0pP0N9vPfE?=
 =?us-ascii?Q?/ic6zVO7QhlPQrzyhnjuLC3DymhYtxOW1ZJ4/ydpOxFOGRr9cvbhrBil8HJW?=
 =?us-ascii?Q?macOVzgvLj7yF9k+ZJi8q071RaXeI78tRxbePH0Bb52fRx0Wiuq83zwa2WAs?=
 =?us-ascii?Q?uM44Auly6d5/T5fQiTMbTvW6JW6TO0vazoVUCljzpBUVgi/vuSjwUrm1dF+3?=
 =?us-ascii?Q?VxtrUEeFCewU8RyUZi7zyNRFOGtLlQ3Ms5nrus8AOKzywOSj5CEVYPrGXcwA?=
 =?us-ascii?Q?wQMMOsHSGaXwrhI5s/krCRoLwUHVA8AB2RUJ/3ggcDTP0q44BIDoUuDR2zBm?=
 =?us-ascii?Q?k8Rk/1Am0W2jJHXjApRQbTK/l2vYx9WCTFLFX7Eilxj+ILIGamQgCvMjpYVB?=
 =?us-ascii?Q?+gYUlnuAxoSGItTNFJArCcIefyXIxD2EBj87dThLuzz44D7YffkPrg6V98v3?=
 =?us-ascii?Q?ygYZDH/GBr3UEdkGLaP06YOR3dlZM6xDD65mj4V955hTee/LdpRsw+aTi5NI?=
 =?us-ascii?Q?UnHqvfT7pIzuKpzCUGPUK1BboB59fkFjU/qZrSTYMl/UpbT37NCWWST+dfva?=
 =?us-ascii?Q?k/FqGHW2qr8vU1nw1B0HcR7tljzCrixSV2tqBzBMDsIFdzZpTdRsBC2JuAe0?=
 =?us-ascii?Q?6/RgLccLtKzCF2NCvsQN35hWSciNL716K6/WZ5Ko4nCTyxiI8NzgynbJRAuo?=
 =?us-ascii?Q?Q2GMpWSSeySqpv+Ucu6ApDcJ9TE6POjG7d0c9mCgrdFuTIWVF4Yfhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KdZn0Y3IoevoeetaUjh1fL0QFvFyL6nNQrT5SSvb6Zcc7mna6SkwCI2YMA30?=
 =?us-ascii?Q?rYl6ATI6pJ6qwi1AC7auvGNRup8kXzu1fsxmlNDXrCBkUc3+OwN2tcLnuXSz?=
 =?us-ascii?Q?nXBaKz9Lqr0bqigNeSzsF7dQ5LrgqG46ImDTKlPmyg/8lsVG6x/thbuN5ywZ?=
 =?us-ascii?Q?8I+WvNW7D+03dhGR5xM1HM+xzrX7d8KI+jBDORJTSKjJg64MVJU75ZwMAk/o?=
 =?us-ascii?Q?PyrlaHDYOMGH9ymJH/9icD4uVxwucu+qhi7TP31ddc4imp0Tfe6eAJ5XjgR4?=
 =?us-ascii?Q?3WR+uVqo46D2FYzNcK+I+n5tAC5YsSoVIYpcamTPNl0SZwtYzVgDq/dwc1sR?=
 =?us-ascii?Q?TTkX0MO6t6f43zIPxuWoqo1I5rHekCZThcRncdb0CT7AbZFvXFAmHgrQntZz?=
 =?us-ascii?Q?6PXAjMwTzGqnZaCkPywwEkevwCESC+DsFv40xCl2/EAj8X8i2hHAKlIDzXDd?=
 =?us-ascii?Q?7Ebgi4/q+m7t8OYJcNQJPIJlErPNCkz7mDvc3/l0tjwIKQ3N/FOGuUUl+F53?=
 =?us-ascii?Q?rT/220znFiwUzzDJAmYcvSvpfSXsuXzWqXDNtzCtLI3LLORx9dTHeiZiwN5F?=
 =?us-ascii?Q?PTew7on6ZhZmgRFESP/XZ27DYY05X+e5gLLevtwlZYWfCVOLwqPTKkdlXiCM?=
 =?us-ascii?Q?4VZrSK4xul5eAsijWIneVO/DYPcdWn+/SwNu3B6GHtAk/jAS88MrYgeLa5sQ?=
 =?us-ascii?Q?MdxtcPn1H8mpyk8o55QIqBFiVu4TB3EPdXR6CoEaHmKZ57zcZc59WG0QA3N3?=
 =?us-ascii?Q?vgbfLEKpepqN7wC4A1BiSVOqDinzuVvSo8b7phR32YnDVT7eSOMeuYDLZ/Z7?=
 =?us-ascii?Q?/JQAw0WjT+Zex6kn55JzcqNyl8JpsA3cd042QcP2u/yQLbDjR1ZiadNimaTO?=
 =?us-ascii?Q?zhlevhr2VY5QUuvHou/dDw4/jfZhWItfZlmPXDwOUMGZ7yS84RrX+BhP4vPZ?=
 =?us-ascii?Q?X9gcTo81rCFO9q24uW9A1AgDqdw2y8q1c5KQ6VaaUkSEdfV/7gU1Tw/DB8cC?=
 =?us-ascii?Q?biGALnhzbiNdt+TSS2T4To3mBVayrYPjJSekeC5FpXDNm9qibfcHIXp8+Td7?=
 =?us-ascii?Q?PHsRBuzGLgYY+eAofAxEWvPYEvz9FZlO3KUIjNr3F6DFGy6tSxoBV9GVeDas?=
 =?us-ascii?Q?nQhcyLb+iUznblpZus6naBnwDo0WgI5HTFz6Pl20B5RFebcviKApeuS0hNfm?=
 =?us-ascii?Q?E3XeSZO7MuQluL8fS5KBZjHplnq2tfGmEWIEvoQHV0dWbdN3Cnz+OdgBD0aD?=
 =?us-ascii?Q?TvYLOBl1yIWoz8qMwqct7d3+XrYiBCEuZ8GXfBohiw1l0dgSkXxwcwv8/vFf?=
 =?us-ascii?Q?JDnhpsPPMLc8bYHFM2Dk64ubjK+RYuhXny1JB34i02LA3LeSl6EJ9QcMnaCA?=
 =?us-ascii?Q?FG8qOCfaVRHOSBdpFI77zg9SHw4qf+gqKAEKnVk8RYFuDxELiX8uTbvQL9qx?=
 =?us-ascii?Q?w3J0o19B5cyS53gRkQFwDbIcknfVhbLqs8SQtJ6U2U/dtOtvsTAPDw9TsnZC?=
 =?us-ascii?Q?4/1DMLBJUb/wNyJNkLVvJhAU5nuVRjy0w5QNUnzszp+zooOuzfeJWf7Rswoz?=
 =?us-ascii?Q?OhpVj+YlcmdvxzntaPv9dVpd099ccE9QBNqp8xxY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f1062d-36fd-4216-5729-08dd72722dc8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 05:41:27.8734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kAwjkD5DuTfPuCnmzrEZin+kloY9CYROYvIQ3qw85lRqprl19i1kVX2W0bcptWMVp+raC+ZvOP9I2SLuA3UfVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145

Add PLL clock lock check for i.MX95 PCIe.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 28 +++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 2232436709f5..614ec3c79f9c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -45,6 +45,9 @@
 #define IMX95_PCIE_PHY_GEN_CTRL			0x0
 #define IMX95_PCIE_REF_USE_PAD			BIT(17)
 
+#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
+#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
+
 #define IMX95_PCIE_SS_RW_REG_0			0xf0
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
@@ -479,6 +482,23 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
 		dev_err(dev, "PCIe PLL lock timeout\n");
 }
 
+static int imx95_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
+{
+	u32 val;
+	struct device *dev = imx_pcie->pci->dev;
+
+	if (regmap_read_poll_timeout(imx_pcie->iomuxc_gpr,
+				     IMX95_PCIE_PHY_MPLLA_CTRL, val,
+				     val & IMX95_PCIE_PHY_MPLL_STATE,
+				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
+				     PHY_PLL_LOCK_WAIT_TIMEOUT)) {
+		dev_err(dev, "PCIe PLL lock timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int imx_setup_phy_mpll(struct imx_pcie *imx_pcie)
 {
 	unsigned long phy_rate = 0;
@@ -824,6 +844,8 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
 				     &val);
 		udelay(10);
+	} else {
+		return imx95_pcie_wait_for_phy_pll_lock(imx_pcie);
 	}
 
 	return 0;
@@ -843,11 +865,13 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
+	int ret = 0;
+
 	reset_control_deassert(imx_pcie->pciephy_reset);
 	reset_control_deassert(imx_pcie->apps_reset);
 
 	if (imx_pcie->drvdata->core_reset)
-		imx_pcie->drvdata->core_reset(imx_pcie, false);
+		ret = imx_pcie->drvdata->core_reset(imx_pcie, false);
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (imx_pcie->reset_gpiod) {
@@ -857,7 +881,7 @@ static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 		msleep(100);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int imx_pcie_wait_for_speed_change(struct imx_pcie *imx_pcie)
-- 
2.37.1


