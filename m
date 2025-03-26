Return-Path: <linux-pci+bounces-24738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0E3A711F3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 09:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACA2717762E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 08:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E9A1ACEAF;
	Wed, 26 Mar 2025 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kFc3BxLm"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013071.outbound.protection.outlook.com [52.101.67.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5951A9B58;
	Wed, 26 Mar 2025 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976066; cv=fail; b=G1FXUZ0KJaLUKsjX7IPV7T7Vzh71abHMRgGvRGYggQ0N9bNlFRSHxclC3R5YHy7/6sNgkHpGQS5HlFS0K9Pba7Rpn8mmNS30Bycn/I4s+alVbWrZGJqY/KzI8h+RKbyzV8tEP1PrycJMIZXHgO/o52b6NDJ7kztX7rDBXqzTnK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976066; c=relaxed/simple;
	bh=3eviTWzrNlm2iTAF/OaMuuMiJ+Wfaz2umpj6PBtc4bw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kKCri6hD806vM7PkWRKDofQC3suuo2B0+f8JL97UQXf4oNl0mjrgV+IoE1PbLz+DSpjhK8D4Sq4DnNRYFPEnl+gVjByyWC8HFgLYArWCzodsKK979eezAX9T8ExMcS87H1rIDKSNJYtaXmgkfXLH+xhTWDXTc9vTBDIH5uuUDfw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kFc3BxLm; arc=fail smtp.client-ip=52.101.67.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=et2QpMkTyN8krg1GA5L2XKEfOV4ZPXGhk7vYlntBBFxJs0EpVfAsAV+N6vxtDrPscXXPdApsqu7aa+Yx2otpi3SJG8S6l/MOEJX+nvkOON5BX09sZSn6AYZr9V5Be4Wi3SfNqfdeB7uVKHbIkUcm2ad0ocEeeVJJc+/kgtREHml/L2c3JLoXLtLyDdy4kFsLHe+y0GS3uScLh+81TtAlX4fQXmA5Ndp3P0B9AeFKS3+kfWU1V8O3udFEONhC6Yp++EZSn5zOL4nEEIzKOOB0xKOB7MDdLcLqtKE/FLO8D03BQJ1yeDEHrQSmi+k81DF3HWpMLmpnE11KghnbFHKEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aazKa7WvXL7W6TtYURQGWacmQzOuIbNdKacMXiHgkwA=;
 b=Gc7jxenLaKC/YWlOZGYk0pFFHgXQPffOZPS+uz1f83D+cINkZTFrUmic+9CqKPd8e2WfOMJx+czlnHYbBIK1Vg2WU8mS6hNSmS+2jZOPUr4HPI5EdSdDMd0TgNFW85xWeubQ8AeKc1g3PxcUpUefLiilcjhyY2GMSxKTX/BXjRbNIFVKi/4SzZ8BI/YLji09gpHTKyEFHlVWe4Yg8zEvLrjoNYY87MSMOY9ZRKbJFuNovdwzKfT3uz8yZ8+GQimyNVW/8UFDK7ULxDyJRudmikc12mZw1RLOolNlEMef3eMPaic0kl8KqjgzoGZwZCGiYlSyhCEmAfk6wrK1F0yNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aazKa7WvXL7W6TtYURQGWacmQzOuIbNdKacMXiHgkwA=;
 b=kFc3BxLmEdjtutVZRiBwz111+DQ+yTUuEFZ++Xf7Ln5ehodSfTgNFT8byZSRaVxTaWDaPfi0/lHjWiON+DhoUCbTs4kmqRhSAwB9eQdHDHTfHDl910IlDC9KoGyBfs+/rGz3psEQEBbHNAC6jgzzTSyxGbg3UoozqQuFUffogFiHGGKd+UEbNOYVEuDIruSTSXDQiAe4iVfiyjpin46t/1uZoz3Rq4koyfl95/GPrB61OmL7bbbQRINfY66+I6jFxIuXcZwyO1bHyB7PPetZZRUVfS9u39D9sdAH2psBZv2evGpoFIIR3Ex4G3h72XvhFANgPJYI2cE15LryeSqS6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM9PR04MB8828.eurprd04.prod.outlook.com (2603:10a6:20b:40b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Wed, 26 Mar
 2025 08:01:02 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 08:01:02 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v2 6/6] PCI: imx6: Save and restore the LUT setting for i.MX95 PCIe
Date: Wed, 26 Mar 2025 15:59:15 +0800
Message-Id: <20250326075915.4073725-7-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
References: <20250326075915.4073725-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AM9PR04MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: e60a1fee-1553-4a45-b9e5-08dd6c3c59ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G4mLA6Tx5MzkVDUFTWa8POY72U4XTBz7oN/2Zma1uf/q1ve1l6EhHiaHMC41?=
 =?us-ascii?Q?BsqMIy/GAI5W6Et5u5q+iobUvzp5tHnyjvJkq6Kah2V5nL/BTPC4rbWFjybQ?=
 =?us-ascii?Q?99iIfb3itrXQxnMjU99jIQKu5U4hKUaEdfFV0IM2lJ47rdIbyKQ+1UB7wSu2?=
 =?us-ascii?Q?jgmsL59EatRs+YRvoxJXs60bgb3onw5MoMPHgvtxnX8eAKEnUrgg9PWTmQFa?=
 =?us-ascii?Q?NBi69W6ajXeAH3vi/kZ6cur34EIhdI2k51sxosS3Q/mQ3TriMBS/8gRqmiRA?=
 =?us-ascii?Q?nU3Ce55DK0sRicYRAvPxYzklfe1Ki4ZIcymR17/G6n5f3JA0LzP9vzMtDtN9?=
 =?us-ascii?Q?iFu/J63H6efhQ0UCS0Fp4ZYB6zWT2RPuexCrdPHERg3VkeTewOZZZ8VAyBj+?=
 =?us-ascii?Q?RFNMGG2CqHsaMtuIenGikMskmlvgLmW5oWVHhAeWUrOmkz8zJt53Z0JXouNV?=
 =?us-ascii?Q?AXDsZojUJ36+8LHnsSSRAYzmZUII+MvmVLKQMPR4E378sIHr1HJ8SKdHFBSF?=
 =?us-ascii?Q?ripjVRph3whMwrdUsnRuXWcUBWEu3LvNOzDh6gaNKax8G6HUbCxK1ZlnGvFq?=
 =?us-ascii?Q?6M+tKdl0+0PQYLVpSRNVbn7auNJYbtDmiC0kV38Q61bzIsWrGmHGXuEnqNFA?=
 =?us-ascii?Q?Ma3Px6HyFVgch2Iu4HQXtuPO7kIK7yVK5xxw9A3KF3xalaTZemYp+6xi57kj?=
 =?us-ascii?Q?JTLDrbnMV/CqtYS7UxA6t/HaAskSwGJlreqm6/tXl6UaMZ8WOqTkmEoaon1b?=
 =?us-ascii?Q?EVWKqzpmeqUI/mJkRCTlEx6IydGKpTbp3b31LB9sTt4osCN5/2R4QOJH5Kg1?=
 =?us-ascii?Q?vnPADpnaIyyQsU7Fp5A7QLTrsxYH52z3WMCzaiGDVz33PFrHijhYV0W/th+A?=
 =?us-ascii?Q?7YRc7x5Oaj2Pcan0c3YHw1lnoYlVjbncps7A6RgsJlyjv+QdTHjuQHEZoiph?=
 =?us-ascii?Q?zduY5gkOM/hMc3yq7RsF5sl7cCuuIPAKAai6LKL/qDlP9jXr0fAd83YlnuyD?=
 =?us-ascii?Q?o4lNIEIH0uSG6qLGryFGTBf5VjXhmNVIqcEd4nY2gE0Qx9sMdb3a0zsHFImW?=
 =?us-ascii?Q?R6GnvR8sR+ATDusDcR9t9LD6ODglH+iSrJXDizshZnF6eySCrpDH5ov2p4J9?=
 =?us-ascii?Q?dB0g5oJxLXAIbLHb8edmgiebvhHRG48E/IpFRgiD6BIHFXJmPEjCDq8P6kdi?=
 =?us-ascii?Q?7iA9Bw1VtyEKsv4egTkjHVT/Ss/eTRUonIXyp9WVNbgMOoJnkgihp3vze6xs?=
 =?us-ascii?Q?syvCYg1WuP0DrFBzKDt/LSsbdxZ3eNBvNVeICCTOej4dZoDWXXhruatg5rfG?=
 =?us-ascii?Q?7v1VjYQy4MPNYkLQ39Q/4P+KKwIq5ZGGbboo9N7JO9vYcwbkSnJiptYE3ySx?=
 =?us-ascii?Q?rM8V6MWOkyeTlCTDoy/abpBUO4GbfPjKosx8xaVZtfA1Vtrr4m78JaPNRZrI?=
 =?us-ascii?Q?d/L7aZkMxkJ3GqOdhgC+7tDJNrCnmi2okOE2GH/hANU+R3bvE536ig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?czkQB123qlKQ7qxFCXoR2u6QDylvg1lrvXLnmcpzH438wLBwb/DNtSoy87iL?=
 =?us-ascii?Q?WkETmEctBqQsBddy5H0n5ih1bBExubUtfcOjQz7JMJY7Aa7/DFFNWfouQ+ye?=
 =?us-ascii?Q?UUwrwMS/bnplLhjnbdtNJ77gCIl1N7HLhhdOvZefDZvYwui3/n8Kd0CR2PU5?=
 =?us-ascii?Q?xRj0BMhuAvNedZZZj4Q0/FuVH60C4sKQvk1Joe0f4AnwcJSyrOgMtjWhBAi1?=
 =?us-ascii?Q?VEKIyO+vXcy8ssdNX35DMytG3w7O51Kk4rB/Hk0wqONMktibp8yq/0QnYPp8?=
 =?us-ascii?Q?I8aKv5Bel9ylGvAzveumt/fX5KgrYzVsC452v+ELqStzzRk6s+HYvGyM0EZu?=
 =?us-ascii?Q?LdQkR0AvnWQbilf+gkInYnZEP5HS8du1wr62Owj9GGg3m0wo2erJ5juCnvE2?=
 =?us-ascii?Q?y9n65tfrQn/WUWSILWzyP1W2eW1Iu+A7qxDsZi0mE/UBF3KhSY41x8aTS98i?=
 =?us-ascii?Q?0t77AqxbBWhai0WqtTizhnKuOrKwsH+zGKrW/mjQ5NS6mxZcG8NDKUKrFeGq?=
 =?us-ascii?Q?hhtPrVwuxQ3jXQ7Jjla57ZOj4YHI+swSLqjSZ5HmPylq7r5s9tN8YIdiO++S?=
 =?us-ascii?Q?5A5frGhi4l1271KpS3Cu7TWwMUjki8xjxRlK7bHaXtwm20PLpKl7XXZjDvbK?=
 =?us-ascii?Q?SZ/7RTvqBPPlTD6/1wFlM+mEYJ851tvo+z+arqDwUErjzsnuM/YBcd0toAf8?=
 =?us-ascii?Q?VfERL3Vu+9XAXAcG/8g9Px/9LMkUsw7U2r3irE4XL2GmyJhJQ/XSDuefCNb1?=
 =?us-ascii?Q?oyXNapaH49xWrmi5ISo8ZNot968HSvDBlRb8t/KOANsZWTC84rbAxtYyCP0g?=
 =?us-ascii?Q?96F3fgeniU2EYTUODC4BGXIGpmQmnROsC4cjFhQggUlV24hhjeoJBjdMLBFf?=
 =?us-ascii?Q?Ch492yaT7/C1qMV+vk1pJL+hGuybYSBa4UGFLYiLdKegqU1u8BSYu39VG/ro?=
 =?us-ascii?Q?F9xxR7cBAx9vSUOYHLTrHEdoZXsEkrSxBoiQRSKzfIU47RrWqlgxbT+sofGP?=
 =?us-ascii?Q?d5mhHwQNBrbRe91K2nYdH4fw3fz6Sc9TwGzaqRQPHARfJQ3hxRRaxjoPG5hi?=
 =?us-ascii?Q?smgtLU8MmgrSMjVp7iYHY5wZjw6ZHJT+kf2hb8HKcJ1rIZaHMw7O8SRvVmJw?=
 =?us-ascii?Q?M6opModz1c7/VW+CL+Oqp61fg/2vsAe2OuhmGrqusQch7v2a7ehSYnMVeeBT?=
 =?us-ascii?Q?03cvA4rW0b3uVuwDBQXzyR7bNiLsHZmUGjn7Deb4FhUHA9p2lLjHvyj35qt0?=
 =?us-ascii?Q?674aKZGowuPs8kYKAGHbeAJVkzr4w0acNuNRj/nFFrNZYqD2NPfGtTaPC2uT?=
 =?us-ascii?Q?cg4/B3QyB+nuspEx48XhPbH7G1UBQ5NvH1pf4vwV6+5KmUM4Poo2cDIcmBcF?=
 =?us-ascii?Q?4MKgvsP6guxPUODfZvUkPLLhzN12jmR1GvXRixbU9yufYT7j8UCr8PUF3VII?=
 =?us-ascii?Q?Cxqnmi9R1vpMtfD4X1ZUl1RgYlUYj+anPHSAoc3EMXXlaaefNRjTbDXxnckG?=
 =?us-ascii?Q?0JrcfUVNU5LknOB3NtpZ7pSeXdo5+GTcqdhMrdVn3HM1pH6QiJFm/rgezkPK?=
 =?us-ascii?Q?DsuX0IaGbvIP2fFFPg8cFlmXoa882MwQQ5kpvMp7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60a1fee-1553-4a45-b9e5-08dd6c3c59ec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 08:01:02.1235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7BeS26XUfTOyyM/VlNU2ouhlFiu5fnltwmyY4sQK4uGM5CvqiG3B/nMDrQu0FLN9QGyKcweY3+NNI5N/U83DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8828

LUT(look up table) setting would be lost during PCIe suspend on i.MX95.

To let i.MX95 PCIe PM work fine, save and restore the LUT setting in
suspend and resume operations.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 47 +++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 1c8834fbcfd5..dc98a04c2956 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -137,6 +137,11 @@ struct imx_pcie_drvdata {
 	const struct dw_pcie_host_ops *ops;
 };
 
+struct imx_lut_data {
+	u32 data1;
+	u32 data2;
+};
+
 struct imx_pcie {
 	struct dw_pcie		*pci;
 	struct gpio_desc	*reset_gpiod;
@@ -156,6 +161,8 @@ struct imx_pcie {
 	struct regulator	*vph;
 	void __iomem		*phy_base;
 
+	/* LUT data for pcie */
+	struct imx_lut_data	luts[IMX95_MAX_LUT];
 	/* power domain for pcie */
 	struct device		*pd_pcie;
 	/* power domain for pcie phy */
@@ -1507,6 +1514,42 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 	}
 }
 
+static void imx_pcie_lut_save(struct imx_pcie *imx_pcie)
+{
+	u32 data1, data2;
+	int i;
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL,
+			     IMX95_PEO_LUT_RWA | i);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1, &data1);
+		regmap_read(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2, &data2);
+		if (data1 & IMX95_PE0_LUT_VLD) {
+			imx_pcie->luts[i].data1 = data1;
+			imx_pcie->luts[i].data2 = data2;
+		} else {
+			imx_pcie->luts[i].data1 = 0;
+			imx_pcie->luts[i].data2 = 0;
+		}
+	}
+}
+
+static void imx_pcie_lut_restore(struct imx_pcie *imx_pcie)
+{
+	int i;
+
+	for (i = 0; i < IMX95_MAX_LUT; i++) {
+		if ((imx_pcie->luts[i].data1 & IMX95_PE0_LUT_VLD) == 0)
+			continue;
+
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA1,
+			     imx_pcie->luts[i].data1);
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_DATA2,
+			     imx_pcie->luts[i].data2);
+		regmap_write(imx_pcie->iomuxc_gpr, IMX95_PE0_LUT_ACSCTRL, i);
+	}
+}
+
 static int imx_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
@@ -1515,6 +1558,8 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 		return 0;
 
 	imx_pcie_msi_save_restore(imx_pcie, true);
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_save(imx_pcie);
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_BROKEN_SUSPEND)) {
 		/*
 		 * The minimum for a workaround would be to set PERST# and to
@@ -1559,6 +1604,8 @@ static int imx_pcie_resume_noirq(struct device *dev)
 		if (ret)
 			return ret;
 	}
+	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_LUT))
+		imx_pcie_lut_restore(imx_pcie);
 	imx_pcie_msi_save_restore(imx_pcie, false);
 
 	return 0;
-- 
2.37.1


