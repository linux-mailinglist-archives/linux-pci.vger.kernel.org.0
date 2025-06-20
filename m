Return-Path: <linux-pci+bounces-30228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27512AE11A2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 05:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B78204A352C
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jun 2025 03:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BDEC1DE8B5;
	Fri, 20 Jun 2025 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NUAfG1Pq"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013024.outbound.protection.outlook.com [40.107.162.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102261E5207;
	Fri, 20 Jun 2025 03:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750389374; cv=fail; b=dDfLRZy3UtovnlwTuzkbFyCHfbLQ+kuKeF7T3cF+oNReGOhVkG2Ke9/3vLqmz2iYv9BGRNPJvu/q9qYIoSCowFSrcWyjViKZcWkHvscXJYL4ej1DoH/NWlXbNkfwRHftHdXNpNTcAjEpA9A0l2ByJSCt84ypNfhi7gt+oo2eMHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750389374; c=relaxed/simple;
	bh=5zxyQk8sBsHit1j+VFOjhWGiRO0vGHPG8DFw9Q61nQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YkUW15HmnJz5WHQUKiJe9CRWogSCF9OgsQ1/74ruc3gLArLdnj2Lesn56JdwRP2IAoRX0TlEKNxU7+gIkwTAZNuuOcNO9uRh1l1UJilr+pFqXQ6KrYKc+9RXKEKq8ovvw6+ao2DZYJsoWDWvTdRy+NcC9VMqTlCcOohb34AQLMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NUAfG1Pq; arc=fail smtp.client-ip=40.107.162.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBAescOFW3Y+igYuiKzIIUXZxKLVyr/dWD1L7cyWPhPPNEJ4NPGKZKJcHLFAT9K8seQsUfvW1tVkNVv52LMZT6CS133f9RUlfTEvhZpxVUfE/rt0HVR7W9o6r/1kBlVHjYr82EVV03y+F8H6bjlFzmF68+vSOhb57YzQKNc1vFpnOyWPzsVheuYifJso8otmsbBhcUh80iBOMRSHHY3VeUnHz9xbRl/jtqjmxl5hKYqzmg+N5X90kzf/+WJmhZx7za+Qvx4l6gAgAOhRrqcSqtQ51ZdztdyCXpunbz2C/1cKsR5tRTyjRcSKAcy0D3Zo9ii+SSzL7qQ45gLxk7YD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=taXVF/P+T6UOGAxWwW2qLlDfpmZ0Syy5dXbz0TslR+4=;
 b=SbpABnLoAK6vliE1T0//+hXIoXpbH7/aowW+hC1AuzuAs0Vh3V9S/fclMYbUe1xW5Jo1KHd2F+MJpMeWabKLrnTYEgsEtBhdyu4W2+CYZXpzBZv33VTUXNpyXvaYQtRrFsopXSiSNyiHN8mqmnuI8NnUUXuiWRn6HZfQXuv3tD05FeIq8yDPkq0uLOfN28D/4EqceTJcQ2rq5kfsCoy7HjkywIzUG4fZs2RTBQe2nUYQfEzNuwNs2HS3O14dwTohQw7EAor5Vo+qof2muzbY9LAAiTFm1TFV8pyF6qIKsySnUyG9ibTSsiG9BTDtJEmL36PqUVw0AOGlrpXPO1Sgag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=taXVF/P+T6UOGAxWwW2qLlDfpmZ0Syy5dXbz0TslR+4=;
 b=NUAfG1PqgFpWf6wfWvGlUb5j2QMI+xc6QupZln0q4UdNiLmFiEmnsTsbLb7v6Ti3CzZMyBdiZjpJe67rXr1eq8aGu5cOBgUUuwzJ+DZyeY4cIUcBQuWG8XxD7/Spj6FQm6Y7WEkhM8cPD9XqwxN4c1EhtLglG1sCjW+aSUo/ZQZ1WZjH1BzLOhlTVdek1k4c7Dib/dtg+kzlvsgCp8/rxONiV4gKBs47rVGt7OjZzxP7TgpRYZCt6by2SciSN+j/Bnk4G2FXe51o7SlKcqy4hf/aWJ9voGWQuG27v0ugzPl4clfPKo7yhysTxQUKGrLlucSKO9aJgYJ2Sc95t15JWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM8PR04MB7875.eurprd04.prod.outlook.com (2603:10a6:20b:236::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Fri, 20 Jun
 2025 03:16:09 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 03:16:09 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3 2/2] PCI: imx6: Add external reference clock mode support
Date: Fri, 20 Jun 2025 11:13:50 +0800
Message-Id: <20250620031350.674442-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250620031350.674442-1-hongxing.zhu@nxp.com>
References: <20250620031350.674442-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0175.apcprd04.prod.outlook.com
 (2603:1096:4:14::13) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM8PR04MB7875:EE_
X-MS-Office365-Filtering-Correlation-Id: c2db2707-090d-4bc3-881f-08ddafa8cd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZhLYBIFT1kRAxOhNSfpgeFXTn0KDKVimaJX2Pn21a/McPk4i8sFkyAQfOWFO?=
 =?us-ascii?Q?JBWMy7JZIIeSpy54gzIqXJ+N0qGrTCTu7qpqtYZ4VwjjdzbrfoIvrVxyTvx2?=
 =?us-ascii?Q?/P2AGiwZRgXvE6pJ5Qquw+MXaF1L1BqfvqrK+KUScZmnnjMZpGNklNENwKZp?=
 =?us-ascii?Q?rwPT7dHjmBjG4jh+MereezVUtIAcZPISX28RUxIQIiCNwOi7j92z0tXNrDur?=
 =?us-ascii?Q?z7zYZW3VwKNuQPDmGTh97HjmV7VtT0qRbFlLHU4xVdyK8EoFpkCMHOMsoWBT?=
 =?us-ascii?Q?cAiaY0QYhq/rHRGD9S2hc4DXqjCYEMv5Ca/SCOd7JKmZ6y0i6BeW+m6AYqb/?=
 =?us-ascii?Q?2dlZEI2jI7KEuc9Et3/sH9yTS47TikyIVrOpG/3dP9m5KD2H1vnSNhF45zbX?=
 =?us-ascii?Q?tA0pVG3vxO5fyUwPzHRCxUyixt65fnmNx16i+rPewqLRElTVwSWVujpOwYX9?=
 =?us-ascii?Q?k/yb1s0LVJrFQFEAJVZ/DFy+yo5dk3ce9BySIa0kLVrBaUH4LWQF7idE1maY?=
 =?us-ascii?Q?F0y3GUa7BIfDhJVXNQyElSpHcylAF0awmlRv6emS/uBrdGrSZE34QegUWYhC?=
 =?us-ascii?Q?W/rGyEhlCeZ0Rm/xi7Ho4jOEscx0XhOnuO9AvbZ/N+SJQ2kaSRC/+nCQNBJx?=
 =?us-ascii?Q?Fa8yIwQHu1pFKM98Q+ZozgWP5urluuff+rpoVAulRHbfxaShIZdOa4oSpSAD?=
 =?us-ascii?Q?VnNAw/PpabWztp2duarBGxbsLjpFLizDT0Wv6koMkGj3xMeotN9MJyjUGWnM?=
 =?us-ascii?Q?D/mr1iOC1GpLgvz0PGRLxQH9GiVxdfZVby34zGQst3peYGGjXp/hUUOHl/oT?=
 =?us-ascii?Q?yw8UgC0XBmCgO0Wc+JXAVk1pUwJYsBmJTohBQ8ny8KuAzV6XGrERXLGncdbQ?=
 =?us-ascii?Q?6U/Q/sQe4k3omdogFk9AAKf287k5IRKTDxwQOM//TIG7JY3A3CqScLf+FkkL?=
 =?us-ascii?Q?wwP6OrJ/j5i7XHbIw1pYtkvkObAV+VOOxd5Y5vj6OivAok7H66qsxshdMXwV?=
 =?us-ascii?Q?MrD1S1rW1WD9bSN04EUeKRMq0KKFhkVGDY+FT5CLd1N62HUrPu5uBCCJosuy?=
 =?us-ascii?Q?SFpifEBpPVgXrh6r6Fl0NxUO80uqSuMTvaS4xpz6CW5Y17Y7Tid5L/9itVF4?=
 =?us-ascii?Q?w6NeipGyufDeJOzS1gWKxj4acBL6sSjN+6C+pTOpBqjvPkXRSd+d9CnTz9E6?=
 =?us-ascii?Q?TzeZaviyvnWzNd1Ny7LHb4g79z42C3hL+fbwfFiQH8YNg8umSWKIop5cNNXa?=
 =?us-ascii?Q?selUKE1czXmsAFhcqqa4CBb0wcUAgl7qsphSxfIkB/7NwOY5h59RJmkBnmQN?=
 =?us-ascii?Q?C2WyuuzsXrDNMywZDXJlq7yi8W+6NRdDpEwkwsRm5T9vHfijtotqUMi1Pqor?=
 =?us-ascii?Q?ViGEhrL0eMsUjhpz/95WF1y12xFxHyoiaWzZqpdxxGTbr+FYoDUbxMDXhTxv?=
 =?us-ascii?Q?o62dZhOBStyiFBlaS3oHhwn3m1ppvR7NhUcSUxS1/QxbSArKQT74rMksHwRH?=
 =?us-ascii?Q?CDA14lOxgNC9ubg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WOW0TuECnT9U6c9seWSaIsDy7qoWYWvO2rckYnwhbL+Tr1UeHxIpd7FRIrPk?=
 =?us-ascii?Q?8DahRo0sRNbZ3UdhBOAv+CHYQA9ag8ui9gRVxEkUojdmw0uSgiCfD/JUsCMI?=
 =?us-ascii?Q?V9RQM9+6vdAzE68HTraJ9V7bfoakMoxj9NVwTH/gr071sa0d57WFaA8AlQWg?=
 =?us-ascii?Q?ekzikDgpftIAFAWjuqs/PElavj34vI/BwY0f+PLHz1WuAlsT13yAexXbtNGp?=
 =?us-ascii?Q?SRm7wmtBGxHVpF4zJcN+ZtaeUway8rIER06WgYP2BCDjLp2f1Ohb3Y0VjfkE?=
 =?us-ascii?Q?FfAMIdPXUdNZTcKblRsfHFXWKX6fIFd8aMEw70UcAaASiw12UMaWqOtitp5j?=
 =?us-ascii?Q?/RvXPXO1qfcCXEcVCYOcLKOpynPMPy3OaTeTv5BiYlyF7w1vl1eS84rkMtol?=
 =?us-ascii?Q?y4AX8VxQnYv3tsbiKfDFygwUseu5aFyrBy1HuFr4qMaw5HnBcuMUUQh4sEdS?=
 =?us-ascii?Q?PdRNNFfaTW6T3OR9kvs8PdxLloyEUJsrQ6kllzKGCx2v9UNFd01DABn5cXna?=
 =?us-ascii?Q?lLGgPaLP6qWgPDJHFoi4OckqnTZM5Ynd7ghP6MioygZ3tV/2KbU7fDwnNSne?=
 =?us-ascii?Q?IZif97fu0G/lOwdw0jPKeZCDG10JAIqchxUhrj5v78phBT4KKXIPo08mE8fH?=
 =?us-ascii?Q?kcEz5IKbQo5nrdMCKCvf4XHX5qNhmEbPTj72DndzJQkkpXtpl691+D42NqIw?=
 =?us-ascii?Q?5lY0wyRZzAEc3rxrxdU/Vjdu7P4UkMXJRj/Lr/UdOtLQrI0P0pUSvm4wZ4RW?=
 =?us-ascii?Q?9DPh8Ww2vrrs+JIUcOlgrImwMdL3TWZH9HGRgDj499vEvMap/TXBdqbb47Pe?=
 =?us-ascii?Q?OBeGjTQwSx9foXlpqR//pfFR4StWIAsP3k2X/etOVFAgoZVPTG54Jyj+UMfo?=
 =?us-ascii?Q?o1gjnxHefw+hy14AyiAR5m063yjI+UUr9Z1I1jn1nWRwu5yh4juh2Po/I8Nn?=
 =?us-ascii?Q?63HJrngc6B4nZhfw+im6snTXLo7mjf/wIcs0HpFugxhdGFFOzqMuWOFDA+qu?=
 =?us-ascii?Q?ZfxbS97ouFwJ3h2OjZjLTRBUXAve9MkhYjHtMexYGpEqoUh8VYnjNxE4FWTy?=
 =?us-ascii?Q?D2o/IW8fvoR8QDwl700pR28N64TkvdpQ1PoCOBJucl4LvwUfEr7K5rpp+o8D?=
 =?us-ascii?Q?uaLxvJrl/CPXnl150vQc3/0qWol4a1TX7nQlXCb5XU0r62oI2MGWZkr/RtJR?=
 =?us-ascii?Q?1UFjhKnw0lK2ul7tI2oW8IGqdAXY6Fp114DJytAihLN+7IlDLAl8q9tUKTVV?=
 =?us-ascii?Q?gaRCcQBhy7yXK5ycCGVdQAFSWNff/AhMd3/YWs6fQGKAvoSGAnm47sVrhM/Z?=
 =?us-ascii?Q?5rYK+AoGAwfR6LReFSBZ6sFx75LnaUTl6taOXi40QnXPQonXmLieUFy0IZyD?=
 =?us-ascii?Q?Vnzm6kvgeJjx6Mmuc6YCJh5eSsX4tMhZOtZq+w3P14HmyGwPC8uLh89rfmfc?=
 =?us-ascii?Q?q9tRfi1xUY5cQm3z0ERy1QHNb+gWfWw/I+CN5NCdZRpNnP/FJVFjsgqi1hG1?=
 =?us-ascii?Q?owi+9wav6T2puD9Wp50MXMaTjtq9keSxFONGcYFOq1dUeHoAdvVRS80t7y5B?=
 =?us-ascii?Q?trDAI/t8K9QLOvmANMfTR03lrJFIxn3sSJjmNQ60?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2db2707-090d-4bc3-881f-08ddafa8cd7e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 03:16:09.6850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/1DbmSsMoX8+P7wpQCAp0Um0JNfELv5+VCOJ+hUC6f4J1qU6EZG+UJPTsLExBsh3lCCVTrEQode4NBD/JsBIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7875

The PCI Express reference clock of i.MX9 PCIes might come from external
clock source. Add the external reference clock mode support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5a38cfaf989b..9309959874c0 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -149,6 +149,7 @@ struct imx_pcie {
 	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
+	bool			enable_ext_refclk;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -241,6 +242,8 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	bool ext = imx_pcie->enable_ext_refclk;
+
 	/*
 	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
 	 * Through Beacon or PERST# De-assertion
@@ -259,13 +262,12 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			IMX95_PCIE_PHY_CR_PARA_SEL,
 			IMX95_PCIE_PHY_CR_PARA_SEL);
 
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_PHY_GEN_CTRL,
-			   IMX95_PCIE_REF_USE_PAD, 0);
-	regmap_update_bits(imx_pcie->iomuxc_gpr,
-			   IMX95_PCIE_SS_RW_REG_0,
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
+			   ext ? IMX95_PCIE_REF_USE_PAD : 0,
+			   IMX95_PCIE_REF_USE_PAD);
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
 			   IMX95_PCIE_REF_CLKEN,
-			   IMX95_PCIE_REF_CLKEN);
+			   ext ? 0 : IMX95_PCIE_REF_CLKEN);
 
 	return 0;
 }
@@ -1600,7 +1602,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct imx_pcie *imx_pcie;
 	struct device_node *np;
 	struct device_node *node = dev->of_node;
-	int ret, domain;
+	int i, ret, domain;
 	u16 val;
 
 	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
@@ -1651,6 +1653,10 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (imx_pcie->num_clks < 0)
 		return dev_err_probe(dev, imx_pcie->num_clks,
 				     "failed to get clocks\n");
+	imx_pcie->enable_ext_refclk = true;
+	for (i = 0; i < imx_pcie->num_clks; i++)
+		if (strncmp(imx_pcie->clks[i].id, "ref", 3) == 0)
+			imx_pcie->enable_ext_refclk = false;
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
 		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
-- 
2.37.1


