Return-Path: <linux-pci+bounces-36633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E20B8F7C1
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 10:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A127A901F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D1A522F;
	Mon, 22 Sep 2025 08:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y5SfcPvH"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011025.outbound.protection.outlook.com [52.101.65.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FCD274B51;
	Mon, 22 Sep 2025 08:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529511; cv=fail; b=jBh4Ts3WcIZmJO5Yavfiw7scn+H44J0HR+vqHdKdL0RQmz7z/9vdSYbn/gHHNY9pGpHD7Xsoa3zFVU2efn229m3EKEhs2ROvofI0PjsHhmQPXC9EQ8GuRJhmas+rZdAwxM9zdmHkfy/dKeAfNZ3O5ENf3q+7rZTfcxOIh6RD5SY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529511; c=relaxed/simple;
	bh=5Tm4LQxrA/ArekP3Xx189SxnUB2uiC7pLdHmtR3L258=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YxnuaFxRkciy5aFl5AOw4vbg35x3wnGW4fd8dnQ+gCVzChdWN6tDoLkGVw0G7jatRhicGBsQfeCj3fFVBhmQKYP8FGM5ZZyv8ck9Davu5/l+PZA+iNlGMWyFYdQLaDU6MZFM2j1bT9xWNE2vXLFIhAy50wo6DFlPC7soVSv8Ogs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y5SfcPvH; arc=fail smtp.client-ip=52.101.65.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpVAD1Cr0lYq+kJV2lLFPzTrIpI7rzt8iyY0lS2B9RkNvTQH5IB9YyH/CUXq25U82154p2OyP8U400RrfEgpwa4V7IfH1o9UO7v5BsUzSE1LuZyFlZCazCpoX1TZrq1bhSXAcSGPByuoiNeBZ7wU/76Ydg/Cbd1yxm56RoXcGxXeAN5wsVDEWl6u/BVJQjoQd/3MluB67r4HHqwAkYvZYquZTPY1OUeWpl2UGpqKtII5QyswTnqAg42pxniyYRTXJkT8zLSsv+LhHK2YSM+ZxBMV1iZIzVhm6CblYfMyypON471BeWIOHCI2TEUmp603SyQkBuI/TaD8YdEhtgW6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1j0leQ0NtQtXricpxf9GO8TNtNoPNVQtwgt5jUyOhw=;
 b=yOaj7ABvYxruCcIwvuCNtdGzZQKGu/kUJPHGdOVp/fnRmgb0wU3O2DwhbswSuhbGpUjCwnFbMaVmSrYpJT/E8doGD8KZ8S59PkvDkQcRKOqbgGt8TkGEN7ZBW4qXggnxHDE6FE0I+cPsHjl0b56Xqhd+3Uth9Pdd1LWhMPAOA8zveVq1PIIE6Hr/56DsSYtHRi6WuvMy4g0tdKm4S1OdJB9N3Dl2mMeSLrE8CrN6P67NKH/hE3ZfRNa6UhmTZzuT0GOyvUFH6UYpY9hUNLOXuR/Ucvt6fN/XF/McA+pxP+RXhEEIiUvgmafhhdZceDEBDMInmwPpemLwa/qFB4GkEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1j0leQ0NtQtXricpxf9GO8TNtNoPNVQtwgt5jUyOhw=;
 b=Y5SfcPvHv6Q3CyqCTSNN7IXINXdVqVuM9iGNETDB5BWgo2oSH+3OLVG2d7g/bmUWsQ5fuP//qlujPh6/Qtg9KBDMcfe7RUbfgwOnYveX2ihi7XrcAkiALgDZH8uaXLUVGmh3rS0p7AxQNB0pqQS7EQmCkAVIyHS26KsuwBHDsgWu4Wkk8elIH1/8pQPwETVbxwwLvDfbB5Sd464Y6aCA5gDp7mpsy5XwRGC0W2fa1HhwWhTPzBs4QVk5vgnbtDELq7esq16B3kGCpehPwNAN1Xpyuq7HDFfMPnFy0Tve2gRfKQ3y9kYU58ovq5DWvgjkYJjaNeXL23b5kDHXUjDOsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 08:25:06 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 08:25:06 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] PCI: imx6: Add a method to handle CLKREQ# override
Date: Mon, 22 Sep 2025 16:24:30 +0800
Message-Id: <20250922082433.1090066-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
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
X-MS-Office365-Filtering-Correlation-Id: fd6d9bb5-6405-4da7-42ee-08ddf9b18916
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q5Cgnu6J4R8iGrWDfBZ/eEN9jN4QoObKSqHY6MIRrIq1/VTIqvhWcH9QFLkQ?=
 =?us-ascii?Q?Exy3G6/0luwdYXmTipYOJLX+Z+ylLBS9ihCAicYTn/5TC/nzhC3jZ4dTlgTS?=
 =?us-ascii?Q?LpRU9aVrsCvqjnxXgxDfitVlR/6vSoXiLLkRqkssVaL1AmGQaqQk90THOln/?=
 =?us-ascii?Q?xhKEYBlAPtWgJRJurKA7N4fwpAJfjbhzFfpB4ZJQ3aq8yqV61E90h65YHtXg?=
 =?us-ascii?Q?gF6WsE+32T7N54D8SrevrE3vOtaqBZOVi9BzlFjntCe5pKbqG9yV4fPaSCuQ?=
 =?us-ascii?Q?IZyN4pohi4pYn7ONBdi0YfkMy49ZqZguJ8L+PLIsSJMu3+b9o4RE6PMTqERb?=
 =?us-ascii?Q?jFvhOvqbEJEuKgLD1guC83nDlQi66L8cABmvoQRrwBA2CaAM4fzQmpVHhQc8?=
 =?us-ascii?Q?dqhsX9nvZU0Klmpx+VONAGOaVhYX2A+Rt8Y0I+JI1hbSG0d5FmDhu9kYy+xq?=
 =?us-ascii?Q?RjKuiosigLAES4X8aSgMqK5kUzqhOQaKE4en1ipW5W+9Wl4QMI9WulJ15vas?=
 =?us-ascii?Q?2n1hNOUJzPsR8jFuHQISRdV1PNFZiiQu0OEJ6RUog95mMvFLpmxXNeBg5hVl?=
 =?us-ascii?Q?TWNrL7vwjIzX64k2/wz61QBHmO9oboMMhqNj7YVZlY0vxXUmRZTKwxU40HsS?=
 =?us-ascii?Q?tnwsR8H0VD588LrbcyMAxn2oapDHwM5ozTfn6lyQaZVEyPQzPIMWNX9s62/f?=
 =?us-ascii?Q?5kp1cjMfXOnOM8qutg1Uhfd+poDJzGh6TH2493YS8vHP7v2+kLiXwrytzQkM?=
 =?us-ascii?Q?KPrn7obkTWmGsQlmx+6l43OYk6Y8+wcJsU3xiPG6oU+WN/1XW0zlqsDO8PnY?=
 =?us-ascii?Q?dfPJcWvXkMZ+5RR6Qcoby6Z6+dU384+ryOG993eldBcS0g+ETpEcb+jglvPW?=
 =?us-ascii?Q?0oZaVwncvGuNLTxfJJhPY5OiqwsvIC33Edeo3lrnvfeIWmsFtTiwWxA74dox?=
 =?us-ascii?Q?kTDvmqUECeWwdWMm6jU/g1CzVrGrtIUyxpSYVXdlzE0Mb9OPjC/pswNt3sQP?=
 =?us-ascii?Q?ZM1hdh5Mw+ZfsMjuZL96Ymus+eia0FpRt1bOoFCXQUjeHHlg9QQuCMinCwWK?=
 =?us-ascii?Q?+77V3XrYJTW9BtNVFuV0qVMEQqLUemfrS/TkYIlofR6UyiQk9JKU7WoKLWN3?=
 =?us-ascii?Q?Nyg+bHkQN2X1zygAZ0zfT16AQHmsDRC+hOVrSV8obiCCy3+rzAt3Om8jLNgZ?=
 =?us-ascii?Q?XHxo6VSPZCMUqWVwBE1M/HewjHaIOIox41DCcp6H/vzSLWdlcJj00Sqi/UzJ?=
 =?us-ascii?Q?weMtbAH3wjIGmaBHJcgzFJ8fMVFNlZIPVGDILWiP1VI77/3HUIhBQTGio34C?=
 =?us-ascii?Q?BbAxK03njo7apU0ynFAjGDljYczznwI35zqixRYG74QNDQHWlU9s/z16IAgn?=
 =?us-ascii?Q?Kas+z4VfYYlUXi2iukoU6eo3ZUAs9SNa0OQ4Dyf/mXMisBywYJy0RXRNMVRi?=
 =?us-ascii?Q?KXNKdDnBlogAa/YFSy3qkYHp4dDryVcKFStIf5zuSShY39yzJraY6nfQxyDb?=
 =?us-ascii?Q?V1vvNHgrl2cRjnc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aCiBKT+Do7Sc5hF2DK15fNjCHOx7N77GUscK8L0SHub0vgWil/8SQzSzMWvB?=
 =?us-ascii?Q?xdEYUMT/lx5yJOjO58zfFp9BYucO3IMACDXl2s8uMqBcCQLa76twSFE4nZWC?=
 =?us-ascii?Q?l0B7NlesFJx03+Y4sqqspAFHZEJWTdjcnizGclejLlHF91lTujT3S3XXft60?=
 =?us-ascii?Q?cyshypqmsDmkSQ/9g4DVK0LPh7Im00o+fUNNSH/eG8D5Rzk0aKwdYvn7X2rC?=
 =?us-ascii?Q?Hy4GAfmKdqobd52BvuiZ2R3BiyAEEKXY0bC2DYa8kCxq04i6iuc5eX7VYsP9?=
 =?us-ascii?Q?UqfBkO5jOdkpAY4i6W4/rC5EUZ4icfKIT3vFc+ryz3tCXAWAGRkX8zcurG2P?=
 =?us-ascii?Q?jrYU5eVo9lyLKMzYixomGuZI6pSfHAHAvJH1C3lvJhfEtvYTJTXP29mTwgfT?=
 =?us-ascii?Q?daKTHAOZ+7AG35dbvOvYuvjym9jeS+E+HdATUj6hvQjoVnxYT2rvpELyaC6L?=
 =?us-ascii?Q?RgW7iuv2mh2VP153eQd4+a+GHq6oV/PT9EFxtu9lQATgj9zAAqyQ8LZCgvjz?=
 =?us-ascii?Q?eHd5mzX9p0PmTLuylXCIL1zKL+azCv/HEjDNtvghbsEeA+uzEMItmehkf/GC?=
 =?us-ascii?Q?3itWBPYHpZfXHecDuFUN3O2RtkP13DFrUT/29IIgRIFVXKISC3zm1c1BG5IL?=
 =?us-ascii?Q?E8d2hH65fErf8mSmMyCECf9IhiGmrj5ppQCHpF4t+L6MlUQ9itgwL5GoZTf1?=
 =?us-ascii?Q?2Rwbzg/TbMOB7vIOIP7NHHJE0Qys+XDN1i7r8jd2bs9B+sZSYbozr/zgadZ/?=
 =?us-ascii?Q?Orexzu+fNP7AlY/t4e3hmaCUKFmjGlTclBVIsp7Q7X3zU+5m8Kcd4WAydPUN?=
 =?us-ascii?Q?kegvwh0/qORsv9IVhH+YRGFUWqXM/0uKh//b3yXGlh+bfdjKzDrMvqblY91G?=
 =?us-ascii?Q?qRZDSnuMzs7QCARaoz/Kb14M6Q8cjH3eiRhNk1915Q0bpQKYXuQ6ydQ7iHqi?=
 =?us-ascii?Q?YxGi0YbmiWdNJUJzThwLxOLfasXsdNDnnJJ0/ga8XlYKrHESt8SSzrMjwjSr?=
 =?us-ascii?Q?1bGHSfYabDR38JxNC3UEWkUqup6KkTYkSORvwXw0bP6AbB6MEnOL758hNcEQ?=
 =?us-ascii?Q?S1xulgceIaqMoV2u4+UTxf75BpcDb52ar3tsUL3b3vA/NE//qjB/G9xHir9B?=
 =?us-ascii?Q?7/oEXkYI6NRtLH2AVlLDdgPSSQ8E6IKjmKZlLgaRUPorlpioRJ9S3QsXUh1d?=
 =?us-ascii?Q?Dfk6C/YO+mkD3ucyjP7NRhG+4ZYnfhQiFCDFA+hBHGScADSd4nYjIYZGMJDK?=
 =?us-ascii?Q?jTIjwWvTTGAnUbYm8oucV3/4vrVZM4FMCG+++kO26QslY/2NyzV84JfH3oVv?=
 =?us-ascii?Q?M4ZYb70xeqk/7wdfNeWp7uXPxitAxAcLVP1Q8LDoSYGETSq1VcemPTv+dHLo?=
 =?us-ascii?Q?XISAh5COqoaxT3cLHt1LGxYypFVr6n+zr3Fyf/DK+HE/5TvofA3kZ5e/ulFg?=
 =?us-ascii?Q?NYLhSQiMvxThFVUslWmKJaexdEovV9U+O/q3Myf9ompSWnPlQrl3q2lW0vOi?=
 =?us-ascii?Q?doBpM8k2gvKPHGblB1iVY+w9kVzoSZ1irbv6WnCxjYl0SSGtVPpbBEUn8xxO?=
 =?us-ascii?Q?4JhNAJ4S2yQunLzN9CYg9F6DxnIjU/cs4qzYEVsX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6d9bb5-6405-4da7-42ee-08ddf9b18916
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:25:06.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17HoIcUYIRLISIMAuartf6U7jG9FhAALwSaLpQUWOouJ0rU2kxZT3lc6SAH/bqUkZBk7beZDuO4SyzHPH7kfCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

The CLKREQ# is an open drain, active low signal that is driven low by
the card to request reference clock. It's an optional signal added in
PCIe CEM r4.0, sec 2. Thus, this signal wouldn't be driven low if it's
reserved.

Since the reference clock controlled by CLKREQ# may be required by i.MX
PCIe host too. To make sure this clock is ready even when the CLKREQ#
isn't driven low by the card(e.x the scenario described above), force
CLKREQ# override active low for i.MX PCIe host during initialization.

The CLKREQ# override can be cleared safely when supports-clkreq is
present and PCIe link is up later. Because the CLKREQ# would be driven
low by the card at this time.

Main changes in v4:
- To align the function name when add the CLKREQ# override clear, rename
imx8mm_pcie_enable_ref_clk(), clean up codes refer to Mani' suggestions.

Main changes in v3:
- Rebase to v6.17-rc1.
- Update the commit message refer to Bjorn's suggestions.

Main changes in v2:
- Update the commit message, and collect the reviewed-by tag.


[PATCH v4 1/3] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
[PATCH v4 2/3] PCI: imx6: Rename imx8mm_pcie_enable_ref_clk() as
[PATCH v4 3/3] PCI: imx6: Add a method to handle CLKREQ# override

drivers/pci/controller/dwc/pci-imx6.c             | 50 +++++++++++++++++++++++++++++++++++++++++++-------
drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
2 files changed, 46 insertions(+), 7 deletions(-)


