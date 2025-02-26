Return-Path: <linux-pci+bounces-22404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29370A45386
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 03:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10673A8E7E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Feb 2025 02:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8973D2AE7F;
	Wed, 26 Feb 2025 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uf8mlNAr"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013017.outbound.protection.outlook.com [52.101.67.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CEA21CC49;
	Wed, 26 Feb 2025 02:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538684; cv=fail; b=pscdsYN4IWl4HrEUbrIf9DPxu0uAA5Yne+jMpvhXKIyPy9/hsJzfbaeyzhwMq96v/EUTCF5JMrW01n3Khh0/8X/1YDYJYLfkoo1IxX+ZXu+3MKP/2ybZMMDecnqtf46t4FLAEX/wnCW31E2BvGw4agn08pISJ0Sb3vSTy/EvhRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538684; c=relaxed/simple;
	bh=l43dfnhrrBQxTo9Gbvq6Q6omDg61K6ZmkFz5iRizfl4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AXWlN2jtWoGFG+WLj3IbTqY8psYcrG7zMzus54C92vmxxFn5B2NnBKdPVcs69hsRleh52xo/MPZ4+jT+Fo4wnL7fMP+3X0oR3dKqIX7FaaC/UxYB5C2ylsNtv6yAINNu2V2uBiK0YhtpmCYFoBv61psV1zY7Le6sSzlcv9ugeCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uf8mlNAr; arc=fail smtp.client-ip=52.101.67.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPQbQBQ7VJZyEJo5nq/fK5W7GIuuyZrqiA32gdOIVklCkDV8n04x6Gqyi+H+nBffcpmPklVyIRmdkKRbkj7S9Tg2n4zb6YSzIz9kM42hmEO6fEMrPfW3p6DM6/xQp72626/fNbNs3BcfL7fEur3HruUxp+GHpeYVwbMwZ6YyqpJc7TDqpxcAj0zUG7ycCAYxCq23gVBNM77REyxK+luOVjcbCG4Wz+wwWi1YvX4RlJjPb1MZs/Nk9GFYGRJkGLLD+7SY5WlSYuAqMeQjHi3oq0AAA2FYmMF3llJDldPhQzuInxxKR6uZnFhWqQDokGpwEnqGyqlAF00tUoGSNrDZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LxuWSt7ZW3qZr5l7lXRsUtPO8082o42lNaEY45vK8U=;
 b=GvOrFC/oorwTGMtvK+fgym9qOI2tM6Xu0oL0F9+v56gJjDWdcUR/4iNADbtsNeGfAqVRgqwZ0W0JLk2sZSK0kZ5bl7kjEfv0G/j4gv3hKHu6Nrz3W6Dtnc/oIx6FCguzBpN6Ikd+kb3L+2lk0DgZQ8cMSaIb2MJL298LekdWYyBZVL4DwuxgwTkA994hlgMbjjjUgjnPz736ZDsxrF3EmT4Zx0lIE6lggGdFSp6p683Wwg6+xSSTtAn1iq5S+MhqaY8aw7l/7pGTxO6xcB2iGS8ZjiEq8hI0CrCh7aZOIIy0XHAeJmZ8GI2VSRnvJpk+8ZS65qwY0HVrZVgNfBAoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LxuWSt7ZW3qZr5l7lXRsUtPO8082o42lNaEY45vK8U=;
 b=Uf8mlNArfpIE5GeludQjDTq26VU44oEp36s94ff6c5+BJLvpSoxfMcPVnc9F7QGJ5jbQ9XQ8cZRU+TEhZDPQ8tMiaLB5j1jBVbMYH1vgARBk1mrfhtNy88Lb9qJhoWjgRC5oNrErKrkNbM1s7acSdRZrkXsdi0xBelsXoYgh+sUL3xF+kprftNm9dvgV9G74PrlxbrzPUi2SL9kGyDS+eqkEDfFzctNFQz7pgbat7jqsW9UBXljXJndvXBRoyjVzlYSfdQGig/rKUCKUJFtVIUHFrFiIM8Ar69aExM6/4rEY3mxi/00NrCgzJRajke/voKhtHDgwxYxsr7vQuWqfQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GV1PR04MB10893.eurprd04.prod.outlook.com (2603:10a6:150:209::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 02:57:58 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 02:57:58 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	lpieralisi@kernel.org,
	l.stach@pengutronix.de,
	shawnguo@kernel.org,
	kw@linux.com,
	bhelgaas@google.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	imx@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1] PCI: imx6: Use devm_clk_bulk_get_all to fetch clocks
Date: Wed, 26 Feb 2025 10:56:28 +0800
Message-Id: <20250226025628.1681206-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::29)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|GV1PR04MB10893:EE_
X-MS-Office365-Filtering-Correlation-Id: 925ff4e2-a8ae-4804-85dc-08dd56115fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gvWEXN0Eqykn79JJXZin5dTj2SrMMY+48/fdpjD3EC/Wz8K4RnH2wsPWIYjT?=
 =?us-ascii?Q?Yoe0kgDaNOC2ph43BEEMsRXqrZ5Vpi3NoW1NvhYc+BB3kJpo3l4CJ7bWfa7m?=
 =?us-ascii?Q?AcgqUwLysmpOcm/PVed5B39g0GdHwxg6G4n118HkMCpuY1KM1l4YLfTErJiy?=
 =?us-ascii?Q?I0E5E3QAozT1ZNIj3GLDONEf90qgBW5w4V8T3jx7uX1jugqr1AJ8dSjG75lz?=
 =?us-ascii?Q?q5k7O4obuq8OIqvtlOfQeTc3R2ILU///iu8+7u7WyrK6bTFLVq3B1K+OuRIa?=
 =?us-ascii?Q?sG6e1Ui+s+Vda+IfbUdKpDvTNTcV7iXLrVN+27BcWSyGuiO/VUnQJ0EkDgbZ?=
 =?us-ascii?Q?q8pLtz22GGaxnx6Eia3W2nrJBjWpl6b2csDzhyr9od0Om9AFRzjlFXL55BCK?=
 =?us-ascii?Q?qSNOLKLWGa33M6vp7b69vDhHfDE5lmvBtFY6Ffpc0a0N980bMooFafC7LPKZ?=
 =?us-ascii?Q?KCHDORoGXKeJmybKHYANslrphMPBHgdxuWWb4aSV5YUq1DsIiI7jnGt3imWe?=
 =?us-ascii?Q?MqwOu3MAXYIOazc9tu74gQByK5zmfBbq3upHWEsZPblARrd/MO+VsZCQRXEw?=
 =?us-ascii?Q?Pizx2XtLW9SAK+kN294xsmZK2bV4/aGw4D6b4Uj7ERBc2uBbM+dHKhOXSvV+?=
 =?us-ascii?Q?5g0jkN1QcBU6D1rY/qO/4oweiTt7CBWg+SRPEcDz/ERfsiiBTIncafbGcZ+j?=
 =?us-ascii?Q?bX1sRHdRXjgTjXSNGWOgCUXqAD3v2i4HOOYWFdBJDXc4Zex92a4GpVl30fLL?=
 =?us-ascii?Q?ldtH0eYkqHMwbOjwJMD0WB/EMq+l1UeJQc/9wk+q9/eZRXCbiCVQKIB6+O7f?=
 =?us-ascii?Q?xRD5K/cIwPHh+pz6K4wp11+2ONy0ytUODxdexhFsqYpFNIhKk6jd378tLRYT?=
 =?us-ascii?Q?NUJosscLM3FwEqqLzjxE6S53xp8fNF0l/jhJ36uOysp+TqHBUwCO5TvNJZNC?=
 =?us-ascii?Q?UZ/sCw6qMqssgqLwQeUICQCgPJCTKKEzmcQyd+ze3euiHHk9XokldK4hpbM1?=
 =?us-ascii?Q?xEr9+HGffvS+13Q/6PZcwhNp5ePZg5e1arATwnJzVp6qH1OMczYSUwTD7frj?=
 =?us-ascii?Q?3X4Nxvv2YUZ681gKOYKTVhbA622FX7P2Mrpx+QgkqOBmvS7uQyr/NtX7XA4K?=
 =?us-ascii?Q?HA225KLMkZrCGMJ4cqXizJonXS5DiDm6jcLWCJ3WLwJ0CdtRf47dwDo1YBxU?=
 =?us-ascii?Q?Z+TVAbj44oL1scmuKb04sXEFc5tD+iNHvjLmMrIoeteEYKZqdnrBlBULuT3E?=
 =?us-ascii?Q?pMY9+uaBrqmwiFbOTpNAaaCLYVtzVotUYRe9+0LfEc7jaLh1iI2wxVS9Rgqu?=
 =?us-ascii?Q?JyWHfpTl17nzS8O8Je2zSBRTxP/WSrdjDBdLeXqL3xDQ6cJaFQ/mOYlFX78I?=
 =?us-ascii?Q?x/Mt0KAShPMyE9ZRzBz6SYnnXyFoN3GFFo1DocNBi6uDFg+tjN3g3kNiqnYs?=
 =?us-ascii?Q?BCZjWNoFZyQ1g69wEddxPw1q8lBIVdjb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DJ8iFglHB9N5SQLtgMOYFsbLfSrH54I+QM9aKTpCKjhGKHqveb6DdoBJOZG9?=
 =?us-ascii?Q?pGDpphuJwxGF4UIJ1EmnQf7E5PfdieV1BaWc97aggjonNHS28yqOrGSGmMHE?=
 =?us-ascii?Q?DkaC/ZphwEc3OCrpSrKy0usddVud9RvqjdsG7v2xlYPcMJdKf1er+evSw9vw?=
 =?us-ascii?Q?Ne2PM7zzbPGLj03DA2rW34PccBhTGEKHbJjn2YhGYvZw1gW5PhQitX2eBWbI?=
 =?us-ascii?Q?PScOX/gkR4m1lCDvJzG0x3Sn8DPG62JdkaHIej40g07uNPBGnnlzGbQwZxEq?=
 =?us-ascii?Q?occixBFbjeL6duiJv2K/ze8NotLQLxY58/Md0AzFyWiKoo9WekQaDBfUXv2H?=
 =?us-ascii?Q?hQH/xvfTWMFYxBgEyK16zqD0+Wg+pHSSyxt1gATw9qAj4jZl4XKzyqQgGU2W?=
 =?us-ascii?Q?z7t8iHj/VB1++SjwsCWwFPSPKPLGLDV8Wpvtjem26lf9AJxQ3V4vZJTqtIRb?=
 =?us-ascii?Q?1TGlhhEg29OozvJ1GYMUUTJznEqZz7BhVcbHBA8zprLc01l1KotzfqbfIgzK?=
 =?us-ascii?Q?DwcqCB2RqnOehCsJ1oKPse25/ZnduiPmrYGFmWeAjQoJDWX4ZbxTXRVyVneA?=
 =?us-ascii?Q?Sm3GacU28qzYPXSAAgVAGyxiRrGrxEBkjkqrYDzWdzqWWOH9vnJJFqt0BGDH?=
 =?us-ascii?Q?v1WPKkilMB/IJ403v6lIOPPH0xZIrA4zaVgL4gTCBurgAyGwPzNjg96KTlfC?=
 =?us-ascii?Q?rS58Hkm3IW3EdiFb9PNk/AaRKXE38Z1ILacmG+w6fqbFNezSWrDnh/oCRjRo?=
 =?us-ascii?Q?dF/HaZrBybJB7NJi/rmEb7wRit+yYxoFXMkAQA28Xr2/rJyyE7qNAX1iDoKk?=
 =?us-ascii?Q?ZF8hmPpcgMHt4Wp1/5VJF1ibIWlBbYh0rwnxk4RGfoN3lkcM6Nf2fLMsSE+8?=
 =?us-ascii?Q?4fRk8G7U7n+E6lxeWlSaU7OIM1Xga+GJ8mLTD/jgKAWmOLFXkhCDjEqBDiZh?=
 =?us-ascii?Q?DfsBmo2SoMR3VNBiLqHfBaf0fYTfw0uztMHlfkiPOxPNNDZGPXdFAH01Z1oR?=
 =?us-ascii?Q?IYbIDFyHtq7FQf9fza2+bAOrxnqLyf8lBq9sRH8WIUF18B1D2YwBAYADSv6i?=
 =?us-ascii?Q?R86lU56sSa+6IO8v13FfT+xQ44poc9d1YPg/0G7rEV9HOHhq41nqIb/kAIS6?=
 =?us-ascii?Q?/VjoJRTXIhwWk/kZ+GFxuJyHM5SZ7qhdWSO5TbctRpabe3FZP1ou3Uwd3T5i?=
 =?us-ascii?Q?i89uPHya9ChxVuWuiw4SO/B0D0c0Y/gJZxil6j1/kMV1q0EOoWparglruSLt?=
 =?us-ascii?Q?zJc0BYIWDW6d+nOLWkJr1VljKxWq6f5sOEoU4bYV10b94TEU2S2UNttirvul?=
 =?us-ascii?Q?BlZcu0NJ0WVPaCT7uKfrxuzh7g40L06KBFGlp5+KX5ced60bg2PQX5qb4Zuw?=
 =?us-ascii?Q?rreBNCbzttvbTTsAt+rmjbGHA7WvO4xCAnebqQiT55hj5OzOUkrSHy76sMBs?=
 =?us-ascii?Q?fSv6sdLodFYH7GNIZg/iEXb+sQshUXaFf+1jbLaHugpEX5xrhqV54DF8oqQk?=
 =?us-ascii?Q?TkVI/BwFmuM8NxOpJoePTCmwRr+/XxTcAaF6GtllDy18ONYYdUdhbMbR+vHA?=
 =?us-ascii?Q?o4/XpEYH9Smx1CoC2xZ+mAR5hTeXQvcHUXux7FJ6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 925ff4e2-a8ae-4804-85dc-08dd56115fef
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 02:57:58.3081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tirAMgVcWiE7wvMiEdXeevy+CjU6l8Ym4uiolb3jJ2SGEJi0/N25kImVs3olg42DeMoFmpq9O+GVN/hYtlCJ1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10893

Use devm_clk_bulk_get_all() to simple clock handle codes. No function
changes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 76 ++++++---------------------
 1 file changed, 15 insertions(+), 61 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 90ace941090f..35bfd46225c9 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -109,7 +109,6 @@ enum imx_pcie_variants {
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
-#define IMX_PCIE_MAX_CLKS	6
 #define IMX_PCIE_MAX_INSTANCES	2
 
 struct imx_pcie;
@@ -120,9 +119,6 @@ struct imx_pcie_drvdata {
 	u32 flags;
 	int dbi_length;
 	const char *gpr;
-	const char * const *clk_names;
-	const u32 clks_cnt;
-	const u32 clks_optional_cnt;
 	const u32 ltssm_off;
 	const u32 ltssm_mask;
 	const u32 mode_off[IMX_PCIE_MAX_INSTANCES];
@@ -137,7 +133,8 @@ struct imx_pcie_drvdata {
 struct imx_pcie {
 	struct dw_pcie		*pci;
 	struct gpio_desc	*reset_gpiod;
-	struct clk_bulk_data	clks[IMX_PCIE_MAX_CLKS];
+	struct clk_bulk_data	*clks;
+	int			num_clks;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -470,13 +467,14 @@ static int imx_setup_phy_mpll(struct imx_pcie *imx_pcie)
 	int mult, div;
 	u16 val;
 	int i;
+	struct clk_bulk_data *clks = imx_pcie->clks;
 
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_IMX_PHY))
 		return 0;
 
-	for (i = 0; i < imx_pcie->drvdata->clks_cnt; i++)
-		if (strncmp(imx_pcie->clks[i].id, "pcie_phy", 8) == 0)
-			phy_rate = clk_get_rate(imx_pcie->clks[i].clk);
+	for (i = 0; i < imx_pcie->num_clks; i++)
+		if (strncmp(clks[i].id, "pcie_phy", 8) == 0)
+			phy_rate = clk_get_rate(clks[i].clk);
 
 	switch (phy_rate) {
 	case 125000000:
@@ -668,7 +666,7 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 	struct device *dev = pci->dev;
 	int ret;
 
-	ret = clk_bulk_prepare_enable(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
+	ret = clk_bulk_prepare_enable(imx_pcie->num_clks, imx_pcie->clks);
 	if (ret)
 		return ret;
 
@@ -685,7 +683,7 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
 	return 0;
 
 err_ref_clk:
-	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
+	clk_bulk_disable_unprepare(imx_pcie->num_clks, imx_pcie->clks);
 
 	return ret;
 }
@@ -694,7 +692,7 @@ static void imx_pcie_clk_disable(struct imx_pcie *imx_pcie)
 {
 	if (imx_pcie->drvdata->enable_ref_clk)
 		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
-	clk_bulk_disable_unprepare(imx_pcie->drvdata->clks_cnt, imx_pcie->clks);
+	clk_bulk_disable_unprepare(imx_pcie->num_clks, imx_pcie->clks);
 }
 
 static int imx6sx_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
@@ -1476,7 +1474,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct device_node *np;
 	struct resource *dbi_base;
 	struct device_node *node = dev->of_node;
-	int i, ret, req_cnt;
+	int ret;
 	u16 val;
 
 	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
@@ -1526,20 +1524,12 @@ static int imx_pcie_probe(struct platform_device *pdev)
 				     "unable to get reset gpio\n");
 	gpiod_set_consumer_name(imx_pcie->reset_gpiod, "PCIe reset");
 
-	if (imx_pcie->drvdata->clks_cnt >= IMX_PCIE_MAX_CLKS)
-		return dev_err_probe(dev, -ENOMEM, "clks_cnt is too big\n");
-
-	for (i = 0; i < imx_pcie->drvdata->clks_cnt; i++)
-		imx_pcie->clks[i].id = imx_pcie->drvdata->clk_names[i];
-
 	/* Fetch clocks */
-	req_cnt = imx_pcie->drvdata->clks_cnt - imx_pcie->drvdata->clks_optional_cnt;
-	ret = devm_clk_bulk_get(dev, req_cnt, imx_pcie->clks);
-	if (ret)
-		return ret;
-	imx_pcie->clks[req_cnt].clk = devm_clk_get_optional(dev, "ref");
-	if (IS_ERR(imx_pcie->clks[req_cnt].clk))
-		return PTR_ERR(imx_pcie->clks[req_cnt].clk);
+	imx_pcie->num_clks = devm_clk_bulk_get_all(dev, &imx_pcie->clks);
+	if (imx_pcie->num_clks < 0) {
+		dev_err(dev, "failed to get clocks\n");
+		return imx_pcie->num_clks;
+	}
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
 		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
@@ -1675,13 +1665,6 @@ static void imx_pcie_shutdown(struct platform_device *pdev)
 	imx_pcie_assert_core_reset(imx_pcie);
 }
 
-static const char * const imx6q_clks[] = {"pcie_bus", "pcie", "pcie_phy"};
-static const char * const imx8mm_clks[] = {"pcie_bus", "pcie", "pcie_aux"};
-static const char * const imx8mq_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux"};
-static const char * const imx6sx_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_inbound_axi"};
-static const char * const imx8q_clks[] = {"mstr", "slv", "dbi"};
-static const char * const imx95_clks[] = {"pcie_bus", "pcie", "pcie_phy", "pcie_aux", "ref"};
-
 static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
@@ -1691,8 +1674,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
-		.clk_names = imx6q_clks,
-		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
@@ -1707,8 +1688,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
-		.clk_names = imx6sx_clks,
-		.clks_cnt = ARRAY_SIZE(imx6sx_clks),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
@@ -1725,8 +1704,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
-		.clk_names = imx6q_clks,
-		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.ltssm_off = IOMUXC_GPR12,
 		.ltssm_mask = IMX6Q_GPR12_PCIE_CTL_2,
 		.mode_off[0] = IOMUXC_GPR12,
@@ -1742,8 +1719,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 			 IMX_PCIE_FLAG_HAS_APP_RESET |
 			 IMX_PCIE_FLAG_HAS_PHY_RESET,
 		.gpr = "fsl,imx7d-iomuxc-gpr",
-		.clk_names = imx6q_clks,
-		.clks_cnt = ARRAY_SIZE(imx6q_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
@@ -1755,8 +1730,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 			 IMX_PCIE_FLAG_HAS_PHY_RESET |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
-		.clk_names = imx8mq_clks,
-		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
@@ -1770,8 +1743,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 			 IMX_PCIE_FLAG_HAS_PHYDRV |
 			 IMX_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
-		.clk_names = imx8mm_clks,
-		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
@@ -1782,8 +1753,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 			 IMX_PCIE_FLAG_HAS_PHYDRV |
 			 IMX_PCIE_FLAG_HAS_APP_RESET,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
-		.clk_names = imx8mm_clks,
-		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
@@ -1793,17 +1762,12 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
 			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
-		.clk_names = imx8q_clks,
-		.clks_cnt = ARRAY_SIZE(imx8q_clks),
 	},
 	[IMX95] = {
 		.variant = IMX95,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
 			 IMX_PCIE_FLAG_HAS_LUT |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
-		.clk_names = imx95_clks,
-		.clks_cnt = ARRAY_SIZE(imx95_clks),
-		.clks_optional_cnt = 1,
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
@@ -1816,8 +1780,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 			 IMX_PCIE_FLAG_HAS_PHY_RESET,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mq-iomuxc-gpr",
-		.clk_names = imx8mq_clks,
-		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.mode_off[1] = IOMUXC_GPR12,
@@ -1832,8 +1794,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 			 IMX_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
-		.clk_names = imx8mm_clks,
-		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
@@ -1845,8 +1805,6 @@ static const struct imx_pcie_drvdata drvdata[] = {
 			 IMX_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
-		.clk_names = imx8mm_clks,
-		.clks_cnt = ARRAY_SIZE(imx8mm_clks),
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
@@ -1857,15 +1815,11 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.epc_features = &imx8q_pcie_epc_features,
-		.clk_names = imx8q_clks,
-		.clks_cnt = ARRAY_SIZE(imx8q_clks),
 	},
 	[IMX95_EP] = {
 		.variant = IMX95_EP,
 		.flags = IMX_PCIE_FLAG_HAS_SERDES |
 			 IMX_PCIE_FLAG_SUPPORT_64BIT,
-		.clk_names = imx8mq_clks,
-		.clks_cnt = ARRAY_SIZE(imx8mq_clks),
 		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
 		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
 		.mode_off[0]  = IMX95_PE0_GEN_CTRL_1,
-- 
2.37.1


