Return-Path: <linux-pci+bounces-36107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94900B56F16
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 05:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECD018926A9
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 03:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096C6277030;
	Mon, 15 Sep 2025 03:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hphexUli"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290F1275B02;
	Mon, 15 Sep 2025 03:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757908473; cv=fail; b=O6l2GrVL6bY6C+1FtyqZ/gT/6T0ahIEqxPo/R1jfZanGFiFVewBMhcXzZT8aCJLc7czjS69hHs2YC1uafrxOdkZeNLj7k2WElK8bkJoRM6UMyhSP0e2IlHA5snHx5CoJvoEZ5ny0RcBqBGvHt2NFJIbBUVqh6TlJJjUmU0xMX2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757908473; c=relaxed/simple;
	bh=1bjpTbwrcev2D3DX82/LbDhA8xCb5FeS5FSa5QI9Ud8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h8MlysHm5EipSW7/zYShT+B18OpGAzDWSZ3738eXbtB1YM37xCBHNFS/1Fgq/RRgOXmAjdIjrG9wAXs0k8Lzs17/r+L5aI6OdvWxAhbmBYAsm3MBDmipxgHsvojbYg3hs+0nDyN5AKnXoXcI1Phltn8ro/gMdSGRq92CLeXDdKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hphexUli; arc=fail smtp.client-ip=52.101.65.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rRcJC9IozP2jlGRp2vQmejk+VPmX7fYOTDahPHFsvWVJI2EiYDS3e89mgapHGtr3+Ai16mCOoFaAph63DCjqMQZESNC/EkWsoO1qjmjsOH+i0TVeGNGqfDy3kUozX7nhLPY/YaegHi2PuniiMiAfN7CRVbdzdNiK2hS6rQZk8H8it8ITH13aICQ+8O/6B9a15S104QzPrnXVINamZW9ke7d6KYB8IoTr/qdmYZn14qd9o1sxcQpIvICEEir1R/IoYfzVXtexlkNCt9bIx3SlC1WTyGMGRUvkF1LHyEoRA9NZsxT37SsBRreK4AwmQqA2OFYx3gmRtySbsOdiqmkzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gH1VjB2JE89jtmRbjrltnmsJ1i0Bh8P4cHnafjLWwRA=;
 b=ql1sStCCRpUzeWaiBgbKy3euhm7hrzDyBgeDGghVyvK+EXRy7tSlCxl0RhdXoKGv5PS3i4AFX0yeW8gkNrIKp/dapwjnIZ9T/eGzw6sx9vd8Q1q3YvPsZzQ+IqVASP5Np5d0SoVKHDWgYm0Ja4PFt43BiGm+j6g97qDKk9pqhI0xri+zws94Mbo3VJXjYK3nD+4F06xCobr5/vBELKc71R2y3/BhKG+YvcW1fVh2c3aJ4igoBxCN6qiQ4Ew+PGETDVecBHsMlaPB1204hxp4HPO35RBujdoyFMwy16TUyI9T/ruqU03eJB2xAuUZd2w9MTnuVf4cKrDPulOsCF7QOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gH1VjB2JE89jtmRbjrltnmsJ1i0Bh8P4cHnafjLWwRA=;
 b=hphexUliPhUsX/HYwE3NDdzTwVdd74c7FCb3P/ez4HhbauLkM6ZnS+x5/FON0HNUbhelgRNobZ2Zr/JURXb/Cy7rjy1B9R/0eO6hyn+XfgPg5L21ETQFA0Zj2dpp7V//yLIypVRR/zI7GR66dclGMr0kHr0SFOwDH4tgrIkWy9V8iOj7lY59FcnhMHdu/2z3NwNU3/21Yv5l7EekyZFu/xvV5ww+pLKBt3p4t+23K0RDuvCmKfcXKP7/5cfu1SOt5L/Z6ZNgoqQm3Sy63i4reAs4vPEjTcVtlxL2fcsENyaslqyLuT4mqHU9dGehiXdJuvsepNjegjgVggP3nh8A7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU2PR04MB8693.eurprd04.prod.outlook.com (2603:10a6:10:2dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 03:54:29 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 03:54:29 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v5 3/3] PCI: imx6: Add external reference clock mode support
Date: Mon, 15 Sep 2025 11:53:48 +0800
Message-Id: <20250915035348.3252353-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250915035348.3252353-1-hongxing.zhu@nxp.com>
References: <20250915035348.3252353-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:196::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DU2PR04MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 50e2917c-44eb-4582-e152-08ddf40b9241
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LGEyTZnjjeaAAfqNnzn3p1WIx/w+Z7yQUwU8Pr6rh02zYZQvAWrmnRsmcBfr?=
 =?us-ascii?Q?zq1HsYtz7n33Dwvs9m3fvYMnzjVGsVd5h1vllCnJMY4w299YZKKPF0zg39Ag?=
 =?us-ascii?Q?/OyQyJUdwyY4ZIoTh2IzVFZQwWmU2u6L7RfeVomAzlvMY+SdYLqimHzmJPDt?=
 =?us-ascii?Q?pVvrOSAim76s2YI6dLToMefohoLHvtVgE9mneqaz6lYQSKrbS54mVdN2m3kG?=
 =?us-ascii?Q?JULpxSk7d4UohBWuxwjKnsAwTVbIVBaTALbpg5bnegp7TlxC1bP/5eLXoH8x?=
 =?us-ascii?Q?Scb6DqVI0v4Zo/8QR87esnEajmhs5j/H/sUG26gMW4sZ5OjGVow3+8+S9LR3?=
 =?us-ascii?Q?XnhS5aOdddKKnjPshiqieGt71CmFMYVfs2Pua8VEHRPhcyYImd8tBpkm4F1P?=
 =?us-ascii?Q?NvumNsHibau/j3zuwT1px98iQDpunz1hv56CRBJ6oK88aoymUp0UaoG4eGEi?=
 =?us-ascii?Q?v7hFWWABjI9Nalzb+aFd0Z3Y2i6U4LGd4k2wzNRLUubETfWeAZx2EsAe8HKN?=
 =?us-ascii?Q?MM/uIJu2SyreSeh/7BBLzbGYlSjObqxyj+wn3ZoiU/JdKs9lHfq37M9jBRAB?=
 =?us-ascii?Q?blNCgV61me4kcGGfJ8stc6I97STsszBTsx7bM0cSp/G35T4Slfgas+NmR4Jo?=
 =?us-ascii?Q?ldENqBZqqsd30PHW4EwK4GCQKZ2vPKtsjGiUNUdU/04vrP97+g4RVRpiPS3k?=
 =?us-ascii?Q?yH3yC9XuzT1deXgC/FrSYtk0qiOZ4ffoBzpEvdAoGJ4GjjHs8fyp3ImMhQql?=
 =?us-ascii?Q?PKWDACmI1AdqPoP2P6+lMzNlKxAQXkp2mWCbFhJ6gw02xmw1FfNp9s7V3pFQ?=
 =?us-ascii?Q?gmJMSQpHYrRkPTYwAkKFAvuKwJgVUOPh1qNK89Th3385Xsyczt0K/6sn89ID?=
 =?us-ascii?Q?fDAP9foSP2Rgl5AlN51kh3dTHhREofejYpDYN8BrSoqckQQvBgjzzQStoVIQ?=
 =?us-ascii?Q?sXlcX78ZNxQYgQkMlySoI+W1uvrliJlQ6wZ6RxcWmEFJWMUESietRVKTXswH?=
 =?us-ascii?Q?cQ3ShRFB7hHa4770ZSjnPvg8BujCRNVXMi1w1GCJORc1LN7QNFbRjO0z3sIp?=
 =?us-ascii?Q?uDZlxACUd9Skpms38bGINtJJEM4tG1qU4DKOH87dVxfSVhvis1Z6ofTiTsdg?=
 =?us-ascii?Q?3cHiPuwcozzWhWeCOto9Fg2P3c3fuUA5gGH123oI1pRSe+5Nk2pK1xpFcLIq?=
 =?us-ascii?Q?hbo6rjtj3mqjVlxcnHjhEapJQKvpYtosMZzHU1l3f7KhOqzy2rC3sAuhs3Nd?=
 =?us-ascii?Q?7h1oOu4G5vXokDsZ/qjJbkDH2ZnYbSDvqL7mtmlE+UUTiPG1OegpL/Pay/ou?=
 =?us-ascii?Q?98uSH9JBO0fyqoZZClElgLre1lBcVcFqziLWgsOJzTxDp2lpX9wNxA9oz35n?=
 =?us-ascii?Q?Oa3xf3J+cYacaRuEluGodC3I4FwvhKcy6fwPWLtL5cHR24jgxfFM1nBMW0SS?=
 =?us-ascii?Q?dZuazunbMonKrl4q5id/WqOQ3ZLb5JBSt8X+SRkuzlDzFMM3eaYgTalah2ZG?=
 =?us-ascii?Q?PeN2cFv/7H5Y/aE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QHslPXy8ADdqJsR98zgBW5E4I6kDiMiGDdGRShwPbGB1ksVi8wkN4GhapiXD?=
 =?us-ascii?Q?SCKHJn5RsQ2npnu0ww2EnKY29v7Hd1P42S+76LWVrCKSZ46FJw5I3xcFpf20?=
 =?us-ascii?Q?6gV/kC5YCNaUOupXCd6wDUc2dSeonoCnTzVEhEi9Uu1wnzKAXglfICjCpk+Z?=
 =?us-ascii?Q?7haQjqhydwNh9qkv24xm0IPSehAFMMYyJAZQ++hRRajn5AmaKQfGTGhAmaIz?=
 =?us-ascii?Q?/iLRZEdFdnbLUQbBwtNJ7+S0sanslgkQrpr20sS5SJyOc4VQ/UiXI5e38/hX?=
 =?us-ascii?Q?8Kp3iTHyEUeWlLTkZ5ibEZKH18lGDlXmhCzD2uJokPYt+eV9V0wtiOrYg/cG?=
 =?us-ascii?Q?8frOIkhnG2zzdOR/uJU93bHCg5hBsyLo2NonI9b9tWlDbK6Qr5ETvAvqYyPH?=
 =?us-ascii?Q?+QmmTzUMr/buABmP04Cf8YTzE0R4Z41PlefF7KlUH7DlmvkxIC/kz9Rr0nxd?=
 =?us-ascii?Q?k73oyEmcLNNUrdvV//FAqUxwBwZCLlIDcqC++pVx8+oZimgm6KjiRcDaQIJt?=
 =?us-ascii?Q?lcO5gcgqNaUA4X6zZkmPTSM3qJW3dZtNwzknEUqwDL4DxtExse3Sdjd7BeDL?=
 =?us-ascii?Q?+cn8rBSOau4Kctxuo9drw5fRbVSc4bYwF83W+3+UPCNLBfuOGuRGU+a48+g/?=
 =?us-ascii?Q?v5ur4ctIpFCK4MuWxSiisxczJ6rai0Zx6abQpD9QgWWPdi2fULDLytIbowRx?=
 =?us-ascii?Q?NXB5ec191Xi0KqO7KJd0yKfbQfs0IDxvdIG2KFkCjjqvUiMoEr8KgwXBW7qU?=
 =?us-ascii?Q?MVw1zgdu5ZoudhNs0HyYCyumDI6KDkQAIKksd7ok2HAnuIyDVz0Egj61jJuI?=
 =?us-ascii?Q?y6JhqDSXPkBPhwq//4sniOZAbuswm1XfdRm9NWsT1WhnyFHuzsig4pDoxU1t?=
 =?us-ascii?Q?4+cprNrFRxLwmTg0vNCChHtXCB9RQQMt99wAdRlYq8P6xLlBpd6krQ0SZN2W?=
 =?us-ascii?Q?Ua+9dN2fsww06vkLJXs7F0N/7T0p2IWWj5vjDCOvpJF+BAyyjC3hVK/O/UVI?=
 =?us-ascii?Q?Na/UU9dhMrGMSPJNGDm9qtXzWlyXeMiG0bVeuMmMp/S7TQ/rVPp30PdmMRbM?=
 =?us-ascii?Q?BEtvgw4nMX2AETGN9HhX5/pINiGFdn0VOl0+VVIcJ/YwWdD3ES6Knqg1ameX?=
 =?us-ascii?Q?1R2wr8WGwemqM1WsfStV9Km0fFWJ0sjsZulqVSU9ls6dX17iIbJEdVVpaDnC?=
 =?us-ascii?Q?Gvrgmuw1imO6tdhJKBAjcj2k3wB2qd5KkDCVrnf1oJIj9Kn3U8jaI9+ZFpW0?=
 =?us-ascii?Q?t9pUx7aAAyMYTAhs/13FWNiYv5osW0GK5wtTReBr8Bxw1/VCnaoZH93r0KBq?=
 =?us-ascii?Q?4mjTiyzyx/UMlCrENYHH8wlNhxCEDipGg8OyhJsJuYjZYaXEBnmCqfeqKSDO?=
 =?us-ascii?Q?rlFoLYwistwjD3YQBerAip1B3rK1TCmvwGuhBOI4gpaO+VIHDLT8OVOLTfX8?=
 =?us-ascii?Q?g2ukupJVqGr8i/1Jk5zENY4LbS4Te8zVMoDepwqCnK5WCvynd04lCRvUr0y8?=
 =?us-ascii?Q?Rpo9ALKJoHnHmKubgYrwXkxxVezp2GnZuByERVd9sOQKZQNpxXvcFfXOGuPM?=
 =?us-ascii?Q?+ER2PThiyMLS0Jfwhx49HAHSByb0GBa5aRR/mpww?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e2917c-44eb-4582-e152-08ddf40b9241
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 03:54:29.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8uTaRR0wmiDma1mU3Lt/r8z0bVByLIjvDjaIQ96OCs/N51yYZyOp9aZszKSalJ4LV6h+v4u0zGh8MAhppvTFtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8693

The PCI Express reference clock of i.MX9 PCIes might come from external
clock source. Add the external reference clock mode support.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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


