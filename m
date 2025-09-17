Return-Path: <linux-pci+bounces-36335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5C5B7C886
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 992C6582739
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18FE30F7FA;
	Wed, 17 Sep 2025 09:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WygEAJyS"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD030DD28;
	Wed, 17 Sep 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101915; cv=fail; b=kIQReSCV+jsnoqT89UZzTYj7sy4Hy0mHc2cqfMA7PLsRVOa6XYVKaGL336HTRRNU/5+C56+ht0/TPn7cFDozVHnGIaz07hV/UFhhYtvJbBJ38e0sVNRra5V9D+wjDvUvAtmDLoUNd9XaXIkNmC3LtSwcm7IaAzMlXiyY4IVIEyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101915; c=relaxed/simple;
	bh=jl0ejbB/3WHIb8IJJ7lQU9l9hw84iMIXPVLUiQZYDQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SIV696LK46zufUo/5eI2NZjmI2vJKuGcyVzNf+72oecJ+BiX8xQ+Fg/1tKR0kTmCxgaky5XSLLyt0dOne6aF32+DziA46RCBtP4R0T776Us5WjPnlOmQLmdTFiwCYUtCVMkYqB4kYpTlOcgtjV3Jlhb8rqgH8U35U1cuBPzTXCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WygEAJyS; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZXCVBlz6xANbGhNSXNSx9M8dP1RCwnSObYIO0BPrQVyJHEfAOPCu0Ir3i2bQHX7IPkTA6YFeAIaZmGg9F/ubpDPAvjaaYCziZEQYg9eHUSaYSJeE+R6zGwhLuphHGw4FJ6/+sGfL6xGtrF4jgpaS+9fH1fix1YFfFeuCQAoglJRxFwYmzkd8qybcNIVoyiRnQ0EgHM0erNK7MCBBkGvOPYbWJXiiC/0KfDcvnhMDGxwcWSoXV5S+foqab0ObH9Jr5v7CM/2oAjQuERwyRg0TJ57ebKJCf3jXSB95kYvcRq/408UzgYaX/9fonOuguB5erPupk9pJ/H+egQ2y6b/Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1J68fhB3luww5z5LAHChhRJGZ0ceyDULpuUS1jYVyM=;
 b=RV0qbUEdwmuiJrGoU4WLY0msW3oP0c/eVDH72vWIGTPx2hKXV63yCd1pXBdg0vroj3pJq1NU87BGkEnahmvZEi9pgBOYHQB15NIRiGTxWYuxUMOF7NpEfT0On6Jwzb2TRm0U8Rxl5CkklcidQ8MdLtboD/EXIUcEWLYLpnwvDJ3hLOBBzILlroBOkkufd643WFTnqQuJ0TzfRd7mN0nOd8q3Gy4yApTm5Z3Pbn7ft7CM6VE0I5NqTHm2NFXG9l1E+txWTjV9ah6q7uBDk2BV92CZBx8imXNCHPTmZYg34Z7KNIHOgS76egBHMg1AhfNAwhQ9O+92khW6lVoJRfBTsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1J68fhB3luww5z5LAHChhRJGZ0ceyDULpuUS1jYVyM=;
 b=WygEAJyS7hOC1tnCLCqMMz0uL7N6EHdrDBCUvffSE0A1bjA780XIuK1rx0JF1fHErNLaN7dtK1t+70nKUeWABqEb6CaYgwsI9QQpM5kPwVqYxqOuHG7ibSb5gqJnFitODkgioEWJu4ap20U4E/V3IslpYyGJcgHkZtDBEw8HynM60E+5lO7YgQpTd9vuFB8KN1CcuIKNVXCP7QIGbyPM4oRgyBiht7Nnanjd2gMf/vNFcz2boYxJDL+7IeD3Ru4LDRkzcmxVdwcIN2/NSoh9EoUzRRO6H5QlFlT4Vbz5HTg5KfKpVTuyoarlbbCZDpAMLNmUdBUw5diZSHkMJ9drSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by VI1PR04MB7102.eurprd04.prod.outlook.com (2603:10a6:800:124::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 17 Sep
 2025 09:38:30 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 09:38:30 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
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
Subject: [PATCH v2 2/2] PCI: imx6: Add a method to handle CLKREQ# override active low
Date: Wed, 17 Sep 2025 17:37:51 +0800
Message-Id: <20250917093751.1520050-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250917093751.1520050-1-hongxing.zhu@nxp.com>
References: <20250917093751.1520050-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0015.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|VI1PR04MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 16bf7caa-6f9e-4b3e-eab3-08ddf5cdf623
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RS85DmMGYjgoJg05r8yOIWoiVi5TSVGlp9ONR6Ou5AnJXWdNhzUMV4cAHuQn?=
 =?us-ascii?Q?JgbWPmq0S0gYaOL7cF7UWNQAWfz/D8URm83gSvtyGViThMh+TpgjAmUGjvsy?=
 =?us-ascii?Q?J/sYBTOzHlO1rfskpmwBlVLd7Y589jjLqjZW4n83ItxwwxbA0UHW1KZuyElz?=
 =?us-ascii?Q?cVMrBcQmYhsRLUJ7WP72crKwSo/1j/r2YRmuVHurhDxzAfYkUhpB+85Y6Z7G?=
 =?us-ascii?Q?Jl7DRSWsC+w+cJFzd8nOHR/EZilbyo14iz4IMDQM0QyNqzV+yfGktVMQqq+h?=
 =?us-ascii?Q?vBXfJDOe0qoTejPME3xN1yeftZhTXefiPMsXr1eQQGrT8hlxr8Ceify5zgJg?=
 =?us-ascii?Q?WUDEZzo7R9hyvidznxZUyeCiPwi+GaYLfbGuZCAIjmzcZy5qqYcbgMCaHfQX?=
 =?us-ascii?Q?B7q+1fP9MqsCn6/Joru+ce00w+srz7I65jqxBzmggU8PGvsKvSj+ulUci5Mj?=
 =?us-ascii?Q?IoW7f06lmkAl7rDDw2PlnKlYGt0yOPwZpGzTqmDgpYI0fuCDDCSpVM5TzjqP?=
 =?us-ascii?Q?YtOb3uFDqqRcmgTtds8hf9s1VDcC701uWDHVWNyb8Do3H8pDD/lGeIi+accw?=
 =?us-ascii?Q?cmB9q9VFPgvLZUtVMFccH1NNI+YGPcT43bJDhma9CQlHMQKQ0MXJ3ej/ne+C?=
 =?us-ascii?Q?gCBIAgHNq6eNCjvLULRAceH4qxs8QJ2cAOA3CpHksxokniWG7YcjyoJsPHvU?=
 =?us-ascii?Q?boX+3IOpfAghsBWT1XJEc2z25SwaTcgb8gSFoiZzJsO+d4J/BIB15F0QzBGH?=
 =?us-ascii?Q?32v9xb7rMXfB/NHeJ9z4V+qWWCmBEVZRkgkTHAZTpxznz8ge38pzZrSDENzK?=
 =?us-ascii?Q?rvaOZ2pZl94KEBDNtc63P9BgmsRPPvkELEd4qs352fUmCVzPbLJS95FpGnkK?=
 =?us-ascii?Q?5KDTCEEeCkDBMsYJ1LdwIC7Xq1wg4ENcwme0vYlyquNNYjfdTRXSSPTf1rDP?=
 =?us-ascii?Q?SPsqB+3U2alo/pL5z9SeZa0G46pP2za/PoTE/IF/RoWFObW3YVS3CzUYirUd?=
 =?us-ascii?Q?e2IDkwPggsVv5H/9Xc4PpBvwJnSpUHDak58AAJxb9pTRH2DnRPGsVHbUMCA0?=
 =?us-ascii?Q?DfygklmGS5sPo4MZege4rTm80v+T6b0Q1mgXUKv4nlPnX8+XRWR4s0XMfEyC?=
 =?us-ascii?Q?SIsYiUAzvYLGrRyt1gJs7eUQoPMDpFVBNMdC9p/i2Hd5/NPTEN/s5m0rBOzK?=
 =?us-ascii?Q?VFW44NUPTmP78Ic+l7CoPkH0GcTEZXxnUgJkw/L0RVlAkvOc9ht8p0+/XR62?=
 =?us-ascii?Q?X0ooc1Z7/QGBozpr2d+dBXa2A7OJ3Xgyn1JPdsTL/nxuhNj+5/5an9YD3kYp?=
 =?us-ascii?Q?LOdhp82hDQZ3smessxgrnvuiTwznduuZK4oE25SuLpzRZM48024alTMFfqvi?=
 =?us-ascii?Q?yzGjCRbRxIQB+BRctaPRKpfS99q0+weF/zyC/or5epmPkGS5zYOxavQYGeDx?=
 =?us-ascii?Q?G6t+aZe25I6u9W1dNjbw/dndzsU+GksGlNndT9diqB7KC802uKoPU7syCr2F?=
 =?us-ascii?Q?sXePdLLRKQorUB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ektuybGtTLG5rUSNfZCdUogJiwk3Zy9a+oCaBfWHmfII1/ZaNCjQsgqAJYyw?=
 =?us-ascii?Q?xQzhiqekW+BizeidJixm3q0uo9ecEQ30Zk+8+CLBU2xTUVJ8DyOWQnYluq0e?=
 =?us-ascii?Q?as7TYksbDRaarf6e1axxylMIvRgpPStOG1HzNz1WH93eLSyUQemc7XFjA9ce?=
 =?us-ascii?Q?DfXcl2bfX1Y8nghkiKuem28xlKPexnY0sfJxFGBhAGgBIRwdGutpi4VSGK/o?=
 =?us-ascii?Q?ciHXyPiPeWBpRkAttIe3QSu8rzK9A/k1S9pG58eycx323/1UXnzDtxN3pWKw?=
 =?us-ascii?Q?ZU5T2jxbGzlCRq71cl8KHBV2gDUWLtTXgcfoj8Z9KAFZLzjp5neaj+ZxX6UG?=
 =?us-ascii?Q?BRNbT9ZWLaZqa0BIsWzlSltpTqPxsHts9tohaXGImWwBl93fOOvt2Ns4PE8T?=
 =?us-ascii?Q?sxg7pcdSIdnWiBgaLT6n58ipI86F7F/Cb8fCKEHZu9YhCZnqvXnBYRhQDYaB?=
 =?us-ascii?Q?FkwpJqdN4IbPrCiM2fnBgY9zKSJcUbpABsxKTnEjDxvDB++SlMfN26g1DlZs?=
 =?us-ascii?Q?IFaPydqNWiVWmQKkayaLE5K/rekHspA6xCd08lZ7KzaE820UWdprt+KYXlf2?=
 =?us-ascii?Q?gv4ieo5a6BBWaoNJEUWlXrDjtAnW+JTubCPOPr4TyR7U8foj/TWzB7QoEiBz?=
 =?us-ascii?Q?+5HDo/LlZswdMlNJRzJvj6aPPgVgZ9c8+j9jTfKArYGJjbLPJgsE9g/1Jc7H?=
 =?us-ascii?Q?ADCX2AmvtahCVF6T5bjBDggdb8u05RId0XFDnxtRVLK53NC8a8fM22TgqWho?=
 =?us-ascii?Q?vzlSKtxmNmXXXN/HDsyYodM+su7bvR2d+BMPEB3G3hG2vCVfjgC/rpUiDCs/?=
 =?us-ascii?Q?bjYg+WV7uea13gzIxfZQMLbqRxmniRwWO3JoJ9sdxUNS5WlwC7/bmXY2dbDQ?=
 =?us-ascii?Q?kpTioqMRvmXKD26+AYQd8EQBN4LwaV3avjrNmhfjVDUqT7kqO/YIiq4DSlEA?=
 =?us-ascii?Q?6EFBQRq0gImiu9I7PAvs8kwHd+6y+k7DZ8QE6Hxd4qGQ0RvU4I7H9KcI21pw?=
 =?us-ascii?Q?6hfTad6PS9QSDmz8y1c9OQuHfcGBPMUao5mG9/4VGB2oINqAM+1TIqTCkMLi?=
 =?us-ascii?Q?ewVe+oUr4GJOVGBWVFZbPQ1yQrc26ZYRTmkWDLQb8mqKl3PKdrJaS5ldjDX0?=
 =?us-ascii?Q?wwFv60+cKP4IGVeO67MxdsMrKHEYsq8hqGzpjtps2/NiKkg/pSZ6IiJgAQS5?=
 =?us-ascii?Q?s/jIgfyKBp+eun+beXqXjY269a3nRU7Yfqqmb0MyNc7pGC1hoGrSkMJt6oM4?=
 =?us-ascii?Q?g2Q1217RDvtCMXnZ+/Wid5O6846S+UEE4Qdt0sXQu5TTTPNd77orVXwY+FNq?=
 =?us-ascii?Q?mP/cR0jC6WwnuatUahRroJk37mcYvcKOdfqZvwLrBjLsZGpzLD5zf/qGJguK?=
 =?us-ascii?Q?VwrNf9nzFAd5KR6rkkElBwBfYmiaI5mHav7pRR/ACFiYloQktlOSWLlgzNIp?=
 =?us-ascii?Q?qpqIHplvBRxg6k7XulzmiO/eI30cxVj5N1TLCdewM2FRHD1yWKLgGWIhu/EC?=
 =?us-ascii?Q?mwqZcHBj3cm2t0UJhb9XeCuqih189wxZioVnSTJmMFoR3tHU5u5OkK55CQ1z?=
 =?us-ascii?Q?W1J7957j6YBnB6bPcpNmdykWHjIhSYZgMwDEkMaB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bf7caa-6f9e-4b3e-eab3-08ddf5cdf623
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 09:38:30.5545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFjflwHYzyh+aPCQnA1S4ILyfJX2ArJGGndocXLDVjq41XVKjpIOBVjbT506b4V9n7wgpb4OKny6xhH1joltFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7102

The CLKREQ# is an open drain, active low signal that is driven low by
the card to request reference clock.

But the CLKREQ# maybe reserved on some old device, compliant with CEM
r3.0 or before. Thus, this signal wouldn't be driven low by these old
devices.

Since the reference clock controlled by CLKREQ# may be required by i.MX
PCIe host too. To make sure this clock is ready even when the CLKREQ#
isn't driven low by the card(e.x old cards described above), force
CLKREQ# override active low for i.MX PCIe host during initialization.

The CLKREQ# override can be cleared safely when supports-clkreq is
present and PCIe link is up later. Because the CLKREQ# would be driven
low by the card in this case.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf..a73632b47e2d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -52,6 +52,8 @@
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
 #define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
+#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
 #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
@@ -136,6 +138,7 @@ struct imx_pcie_drvdata {
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
 	int (*wait_pll_lock)(struct imx_pcie *pcie);
+	void (*clr_clkreq_override)(struct imx_pcie *pcie);
 	const struct dw_pcie_host_ops *ops;
 };
 
@@ -149,6 +152,7 @@ struct imx_pcie {
 	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
+	bool			supports_clkreq;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -267,6 +271,13 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			   IMX95_PCIE_REF_CLKEN,
 			   IMX95_PCIE_REF_CLKEN);
 
+	/* Force CLKREQ# low by override */
+	regmap_update_bits(imx_pcie->iomuxc_gpr,
+			   IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL);
 	return 0;
 }
 
@@ -1298,6 +1309,18 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
+{
+	imx8mm_pcie_enable_ref_clk(imx_pcie, false);
+}
+
+static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL, 0);
+}
+
 static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1322,6 +1345,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
+
+	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
+	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
+		if (imx_pcie->drvdata->clr_clkreq_override)
+			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
+	}
 }
 
 /*
@@ -1745,6 +1774,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	pci->max_link_speed = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
 
+	imx_pcie->supports_clkreq =
+		of_property_read_bool(node, "supports-clkreq");
 	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx_pcie->vpcie)) {
 		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
@@ -1873,6 +1904,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1883,6 +1915,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1893,6 +1926,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
@@ -1913,6 +1947,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
+		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
-- 
2.37.1


