Return-Path: <linux-pci+bounces-36635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8FCB8F7D0
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 10:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC3418A06CF
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76A92FF171;
	Mon, 22 Sep 2025 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T1rur31L"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011019.outbound.protection.outlook.com [52.101.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8912FDC4F;
	Mon, 22 Sep 2025 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529524; cv=fail; b=HB96JJxfbVIaiJzevQs5YSVIH9WN6JUWTHvSX/nT0+D6nLtzo4Fxwjhcvwh/lHeRntzpZZIZQNLr4i72kOReWrMCDPHCHmHoaiyM5v0hTbhfC0e33vEiB4/f4R/8wwDNQMl+DPCLrQxYUJtGJSHG8EAtI56viwW7x218NypHebg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529524; c=relaxed/simple;
	bh=Xu5eNBY1tQ209NnwF40QEDJ23s78M7FPuij6Gh7i/2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HZG42drQrsIx7+85xX71Xuxx7DRO5Jop559cGYF7buNNlj+mbIZf+Y/OIiDjW4GprAOVk7UOPWA7/T57Lns8j6uaq5+pZE2pEDxW93+klNplGIfAUoRSfw4OiQcCxHGbE7nqyBixO1U5+J3l+L2LJi5Pv5I4MnXUUCRr0wf5jjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T1rur31L; arc=fail smtp.client-ip=52.101.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXBOsnUDbUoVqKO5iMmiQ7+8xEEJXBgrL6QrNIfurJXv3IXBiSLusnfM77m3s3qHfzrDes4eO2su7n4UsqAt8i/QPR3cED0ci6kL/sw/ASzLEh+MolgWr5TNcpGQWpD8grGMQCf/HdJExYXjKowdeho5rBmBlYpqN4+hX9eZTDuxx6UT4Esk7jdp2tjU5kGHIWVYITXsGkLPO8L51UmuAupjLhmFu6AjZVTTXigHuvxWPTSbcvKeWlSPUwm7unARlbtkAg3bcxbG9v0Uz7gwtRtcZjUdWd6I8+xeqjHVjWInUagKF0pA0mtp7Pj2LFz5FtMySxzB6MGWzayQAbO9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pluyvPGxdZ8If4o84LDxhRD9bHisilWAdShOOGotwxs=;
 b=PQuWe0CNqUMUopmbYSiOopUIs/2g6RYmTkXmwYgplEwGCL1fk19/dOXSojiLJq7k0b2S7BBLDINz9KNCSsTQ1uYeuYzVavV3k60by8QF3SLUgB9udX9L0IvC0G0SlEre5MnOmhoovH6ALlOqML0lwnXCWemYea2E5p/xwlxFJC9kPZfnsHy/UIqeVV0L7OCbSZDRRSqm8T6G7yc004sq+LwISWl2gZ5JRLnAG5UP27rWMXMweetzlnhn4TeRUQld4vrAY3rL/iJpe2dU67tuejTkpmRPTyJBHsEfu+fpKibHL/9lgPKaERJCUb6eSq43CiPGYxvBRZbnVX4o0ColZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pluyvPGxdZ8If4o84LDxhRD9bHisilWAdShOOGotwxs=;
 b=T1rur31LVlQVh9W3R+S8g4wsEttqW7dWrBJ9+Pw+Fnfpm9UoRzRXMjEWiJgCX81RjxFPB6jiZfXJ2HGqbMyHKZasiFM8LAJ5mxidVfT4Q8yEoM/hoNPbzjXgbYaL5uvDXAAJ1r01/2mdYUzQzEGicigivUuwLL87nJkqtcfKK/TptQKMrN8iMncBx72tpD+oR5tvBRq1Ysqbm10v8jxXL7NnrXlow0U71lgJMnvisV4VrvFrZqSLFJmEwzG/Y7IRQASCMsjiRMSkGVi8ofI1rautqMXdfTworrephSgmYWVDqYVuGAvwse1CUxtbEYeGCekCmXtVAG/tQ6SbvJe2SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 08:25:19 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 08:25:18 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 2/3] PCI: imx6: Rename imx8mm_pcie_enable_ref_clk() as imx8mm_pcie_clkreq_override()
Date: Mon, 22 Sep 2025 16:24:32 +0800
Message-Id: <20250922082433.1090066-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250922082433.1090066-1-hongxing.zhu@nxp.com>
References: <20250922082433.1090066-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a68147-4aee-4e43-530a-08ddf9b19095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3dXjyolGrBpyJHVbvtQWrjbpvXfBSBkuFFPSWDecKHEXPCZwAU+UOKqxTuD+?=
 =?us-ascii?Q?uqpPX8Of3IMjZo9aV3f6qzcKTiIPhtNp175rA4WAM6aWakHcZGbeCTymjJ0b?=
 =?us-ascii?Q?lL+QUPC2MSy+9XTzjMvNteetN7TcC8cax4WS+Bha7IR6fhuT6xalohFmU7IZ?=
 =?us-ascii?Q?KyVTohzG5/yYsf+TomV9i4Lil37qzgXD/wVqjAJO5yALns9DpDRh9Qd3ygLy?=
 =?us-ascii?Q?+gp9UMYM86o9SJH0J3oi4u4ipDT4i7shQYK4OxkFqdq1HMut53HLdaJyQXB/?=
 =?us-ascii?Q?Tw2wm2wy3rJn9vXigNDDDd235fgJfSE21ZQVyhyu5OaWOWh/x2FMhNily3N3?=
 =?us-ascii?Q?wVJZCIoykFET2a27hR0JxmK8R1lLmGOo0IrZYKQoff+zUE7tJ+3+B/vaOUr2?=
 =?us-ascii?Q?Etlv6fnuTatlxAul7TDSwnX+aVXOQUOchmZ49F4mJmJv7Rd2XXTJq59ZQLC5?=
 =?us-ascii?Q?v2zbYmNCuNKHWhUsBrfNGF6ZouJ/Q29SC69qrmNp9gKoDqKyLJulE7VA1vct?=
 =?us-ascii?Q?+QTPO+Ul2pNHz2ogTAkLgrqtNoIgRD8f/R6Xi5yUrrLnoBbyxQkeN9hDpPDZ?=
 =?us-ascii?Q?qZc34GxWUBem+3Gs6PzPDnYSvp3MtX8Ba4qTwX60A+FJH4ZSAHUd7pNoUyhC?=
 =?us-ascii?Q?g4yWYKkMyJR5OyU1wk45phGUIcxgf/QeQ99uKdX92QrgnuHO6+GgSimBQvLA?=
 =?us-ascii?Q?gs4gPlL8N3M9OerlZhuY3uT+0IRI63gi9YOKj3EK9vZ8Mv7NxP+9QpNbV5xq?=
 =?us-ascii?Q?4Co25M8Q/PV/WqX8yglVY+Vs6hbdfvwIb329Ny1Tf5lgBc22XulUpcz8kDU5?=
 =?us-ascii?Q?g54wka9UEuU7o/Db4YQhPFEzPegkiaetgoSS1t9vQ9nVxgxkt04+mZy4Axg4?=
 =?us-ascii?Q?C/KXFXQaC3m5GqQtcR0brNI07EWJsWXJ6/yo8m/mV13yJwZmdwcDheMtXepq?=
 =?us-ascii?Q?MpTUbH3zARbQhAUNPLcrDua57qlbhHSEl8TIjLXyM3VT97H1g4EXtjxr8RU0?=
 =?us-ascii?Q?Ii5ednWWaHBf5GBW+fiG7s6f8faBKApZXNUJRAFPVv2vT+rnaqTwyBgqkPp9?=
 =?us-ascii?Q?bm//IFX2KChC812yDgBn04GAE+/Oqk9v6bWTpTH8G6G74r3llI/MtUvgfC0d?=
 =?us-ascii?Q?vVIN5C4dizc9eUZckzYLhqMfsW43GZPkPNVIihu9FnnUGaQpa1Qneyu/EryT?=
 =?us-ascii?Q?CYiX9FCM4eRuJZ1imYovfQQs9xVLWDWnxzcP4nBeVIPWbb4GwKwY1HsY/hwd?=
 =?us-ascii?Q?tOwCJ/JoBKobNWR3h72PK71vDALyUhANSc/8UoXNcpp8brICwS32W5qZ++Lx?=
 =?us-ascii?Q?ZqM50cwhGq4ap4fNu1twh1c2IjfaX7DFM8FWtjcTn3WNH8mL4cse2IkuN8uN?=
 =?us-ascii?Q?TQUeNW+Jyc1Khsayk1kr1xZBAxYGL/Gkuz41BI2WZmczshd0zl66mMD84LRY?=
 =?us-ascii?Q?rIK+YDUDyQmgqVdKj6KSspMgit/BUuUPEh/F72x2heRlsM867U8jAcneZJgv?=
 =?us-ascii?Q?NM7SkXZEMMA2wII=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkrJaxBKs5LxYO5xKkDHE0XcfrmMJS5gx+3DspNGyjCMyxXAdRkUK/mCddyt?=
 =?us-ascii?Q?PlFapdo3DjCAeLu9dka68XfI0oBMapbZ9a6pUhcLToSiyDv95+VP0w+kJBai?=
 =?us-ascii?Q?XzDs663bjtrt8x3V6yZUpfZpkw0d/3SVlzez0xCRz8ubA02hjDehwZ38jzop?=
 =?us-ascii?Q?cEdtZMkDmho4ERwCqJuhXnFyORfEKpnKWFdLcchWS9QrNN33xxeqNEfnDU8p?=
 =?us-ascii?Q?d8LCUsr0L0FUWepKVdCOsto56GGdxRG7WHWuA51BJ10z0iLMi+vYDv99ZsSt?=
 =?us-ascii?Q?j35L6MP8XBuZD34I7FyidwdFKl9tluKDkIaeXlukcTMWiAdf4vb6fuCGzJv8?=
 =?us-ascii?Q?zVn2eARAMkVL2bIfSkxu3f+CMcirM0Ijv6LPlJ+etxLbndJItCU7Jr4GYsWm?=
 =?us-ascii?Q?oKGu5E5EasouVxXrAFuAIbRYZdAgb45ZdIIn3M84vFo2zuuxwUqviTYu8zxV?=
 =?us-ascii?Q?HDjn7mLrtnaug/DQpmuAMTXXxe0VCxHDmhaTpO/jaXYkS9YMUNDuSp7NurML?=
 =?us-ascii?Q?BYVO27PFrGP+bKhk38/YnuTgJK69C9KD4F4FcmnysDcQu23fJph8U/dQ1vdR?=
 =?us-ascii?Q?BiYGLU1BfXbyZy8HQ1HjYT1Tf8OVX5/2SpUeValoJEjg/lSht6xwVZTziSt7?=
 =?us-ascii?Q?vgg+EiiEGfulPwm8TAgsgwqFECMKuJVQosm7uqxG1bqnFYjot9qA0KnrXgd1?=
 =?us-ascii?Q?+DveW4VNeQaDcbNOgN7a6RREJVRiGXr3U9tTPprzxD3wGFm5NnNO62X9FkQi?=
 =?us-ascii?Q?93EOX178btSwP4hLa8DQ5xVqa9xT+kZF+QG1acRXKOGCnvayztIhf/oFj0mr?=
 =?us-ascii?Q?JnABSfdb+aULpcvx34/qLfbl9wvtYnLaVUuUtd4woLqx4by3DKaBfja2WbVh?=
 =?us-ascii?Q?672YbI8/b+q9mQ7ewj0uf0vZ1TjdQXt7rkwEMC67JVkUmSVF070773uqLZxM?=
 =?us-ascii?Q?qkFKsaYRf7Gv4a0JbNUvE4VEhmsr2GmOOZpIDYFyihPXo8rX0enMQ8iSAFe4?=
 =?us-ascii?Q?RI8k11e/Uzy5YoavOkBL2u1YD4CD/PyUuHjUutLz2FWZK46PXCk/ERrqdBqU?=
 =?us-ascii?Q?0UagSAp1PjH2oFnayusK1N2eN4IlCB2GhkTykvAjR32HH/yI6dsa7O8EMIDa?=
 =?us-ascii?Q?5ooRoDrJrQua9/FOu23nMyc1fIZWAoOf9m6SBQFZwqJvdQvY2rtFDnmFB2D+?=
 =?us-ascii?Q?Iy2zUGhYHjeaoC09DXAV8mmqX2Qh3K0dCWiwPdjeZr5BHf9+93nvtmCAOVLd?=
 =?us-ascii?Q?GG+2mBwsQYtEHXFI/WjnlnEOGDGSLJTnFsUgbxbyJiKc2EZ2x8H2vPP+kr/Y?=
 =?us-ascii?Q?lc/WKWgj4cTjVI43nNMe3z63owLDFTHcEc5kONQApGmU14zhlZwLHTnKx+Xn?=
 =?us-ascii?Q?JgrFYtnGqkc/o0VJSIG8cMenAOtM7aUOaxutwGLbz/r9usHL3rVEr5eaH0/u?=
 =?us-ascii?Q?qrcxT86eugLoHiwfPkGf+JxxBIfdlZOpqQ/7cVDv2d8W2BrIVmwHbqituBf3?=
 =?us-ascii?Q?tktSPZTY74sO2ja0Z0+XM9Hs5Axr2uzaQRsRC4Dxzz3a0HQcTXAaWKnBRboT?=
 =?us-ascii?Q?qg3rwTZsDmC17SViEHkgL9Z7ZgEk6KzGpuj/3Cf5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a68147-4aee-4e43-530a-08ddf9b19095
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:25:18.7987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zuO20/D6YzE0FCokfniBZKDyrWUAsncuyX4EFN6bY24UD/h4WUwc6okw7O3DpWk1NRb54sb056x/F+jKnkEnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

To align the function name when add the CLKREQ# override clear function
later. Rename imx8mm_pcie_enable_ref_clk() as
imx8mm_pcie_clkreq_override(). No function changes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf..41f971693697 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -685,7 +685,7 @@ static int imx6q_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
 	return 0;
 }
 
-static int imx8mm_pcie_enable_ref_clk(struct imx_pcie *imx_pcie, bool enable)
+static int imx8mm_pcie_clkreq_override(struct imx_pcie *imx_pcie, bool enable)
 {
 	int offset = imx_pcie_grp_offset(imx_pcie);
 
@@ -1872,7 +1872,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[1] = IOMUXC_GPR12,
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
-		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.enable_ref_clk = imx8mm_pcie_clkreq_override,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1882,7 +1882,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
-		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.enable_ref_clk = imx8mm_pcie_clkreq_override,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1892,7 +1892,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
-		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.enable_ref_clk = imx8mm_pcie_clkreq_override,
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
@@ -1926,7 +1926,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.epc_features = &imx8q_pcie_epc_features,
 		.init_phy = imx8mq_pcie_init_phy,
-		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.enable_ref_clk = imx8mm_pcie_clkreq_override,
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
@@ -1937,7 +1937,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
-		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.enable_ref_clk = imx8mm_pcie_clkreq_override,
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
@@ -1948,7 +1948,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.epc_features = &imx8m_pcie_epc_features,
-		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.enable_ref_clk = imx8mm_pcie_clkreq_override,
 	},
 	[IMX8Q_EP] = {
 		.variant = IMX8Q_EP,
-- 
2.37.1


