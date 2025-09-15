Return-Path: <linux-pci+bounces-36104-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF76CB56F0C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 05:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27FA61899747
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 03:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6257B26CE23;
	Mon, 15 Sep 2025 03:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ylk15ZXz"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE725C818;
	Mon, 15 Sep 2025 03:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757908461; cv=fail; b=JtSNoGaz/ijTW/3E4xfnCm9FyPlT1krdDiITqUYuXzAoDKOjOnEDNhyoXfnpRIkv/V/0Qpy3KmfgczojvygIMhHbHqK3fLN4EhgW9pIY24CjmbeWhOSQk/RUvYIfZdPPqxC+fq/KkY4ch9IAW5h7J8FhDYnsEX8SEc6XAQBAjR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757908461; c=relaxed/simple;
	bh=M+exUdhavVU4t9GbZlSysy35meTq58TTTPztueqjmAU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z7p8W8gFsb2sQ9JopqpxjHW2FfYWfU3tSj/5fJ7u2RwELdM3Dsudh1sFg0/Y0F6e6iHWpXfjPho9mWG9LlAugTGvfwJ8LJ/Oz1IT5Lq/kLnngSUJmz1j4S4rJN7bPjLU7SJgoo1EOcMBzW9s0w68UpAP6VB28yNL29Mh07PV1SY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ylk15ZXz; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItUrVT7wRGevrlrn7xci64dH5y+SABnEoXmSMb2FPq09v5ujUIiuzItOtNZgd4UU8cBoG4X5PSD2MdpbCsvMIMvy3QtamnLCdmYqae0N/KrFvtbb/vTaSM0d6z6AcX3l30XxhTLSWXMZXOe6sYbuml7+7YgQJ5Ic84Auh897BuidnXKghzsR6bde++RRFjEHgsoQ9FrS5Z1gdOkBPJM11oukFS7vmSdLuy74ZjTwx4IpY6/mIJiQ4foSqVKBOmTFUKn+BfmANmkIGhGqtMN2qk6APTiwKgWAOdcFisfNfUjBTRRsIbFOSWy4ECtmQghIzy2PD9r+DEctK6P0D19yrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEVwoKLeDLayMVRg7smcj/ucN0+o04uVyRJA2pmPSq8=;
 b=xC2jPHC+DXX0BefbeGi1guCupNDhNvkqP88RfVuVdnbpRIK0h+cbV21wS0s8s0XRTA967OlAblGtpATMEAtWv5A9rulIt17FYfehmKh+79PlyMm13f5nDUpBaK0cQYyM33tAFR9jhXZff9bor+p/by5oRpxt1kVLWkoVX4fpNo2b/QMKj78gc6l7lljg7hNGqHv4ZW+dl710KLdyHO3Npkg7xPNA1JQgzL4KWXVettsHV56dgemX9Hvv6nXJJ92xS375mAGjCzcscOX6qQw/ElkTupLcK9KdU0pOfqNRuR875m3K5qi5R7RPj8EQjXklNKP0ZP6TLNlBgmzzOk5MTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEVwoKLeDLayMVRg7smcj/ucN0+o04uVyRJA2pmPSq8=;
 b=Ylk15ZXz7eGJAqIJAiwFLZkKY8GYyEnXE3WR5sz9O2THb8ZIur4w5md+hp4L5jLbghR8OOjEk8Y8fZt0+itgfjRVe1HsYqtzq8+7CJudUOYbOvn3ifCKuftkgMLcBAqBOMmxEs34p197ccnPHz4BMld4W5xdZKWTi0leh+swvuSWUpQcFu6VEhw2OLJ5V+pii+Knlqyi04JHLsYFd6owjilZXG3Ibg2gSf2GdxtPLEKYQfRNAZ/7ScfQBQWMKV13gG2GJBS9k0jQl+7ocmMF/yCJzG496+dNKvT7a5dTK+OrA1TsT3Q/cHd0h6J6zi5vg1iGJrBDuWVBUnP3fDm0fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU2PR04MB8693.eurprd04.prod.outlook.com (2603:10a6:10:2dc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 03:54:12 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.010; Mon, 15 Sep 2025
 03:54:12 +0000
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] PCI: imx6: Add external reference clock mode support
Date: Mon, 15 Sep 2025 11:53:45 +0800
Message-Id: <20250915035348.3252353-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
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
X-MS-Office365-Filtering-Correlation-Id: 9a6be1d3-c609-42f0-4792-08ddf40b8815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|7416014|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bqXyR9cfq/xgo8htSS5v7pRCKYEsbr4TnD2CcpnuWZsVDd77+OynX7ngNUJH?=
 =?us-ascii?Q?Iaks1a/2X3mgx8XeNPrWlcYBFsrkYYY6bRQsERnG7QYjx8linNRc+ZZju4Ih?=
 =?us-ascii?Q?c2B86iUi6PrCDmhDQ/P8YcPmeXSf8Coe/cQmREPtcCbtSraeX/ZMa0aLSM/W?=
 =?us-ascii?Q?F8bHu4vzd/UuMFUcFMJC5ar7SYe3J2qb79q3zy6UStr/s2rHJ+YA2L9IPt3Q?=
 =?us-ascii?Q?EFeRz8JdAVd8XVdV0yBuJ1BpTuWWX1nJHkZ+KpFJNs59cF8b8NMOACxTDeay?=
 =?us-ascii?Q?ElWzzp7JYEDfZu3shzeZ5QLmLigvBsBDh9nLDlrOgcElEu4mWJMCNhAFxWN0?=
 =?us-ascii?Q?7ZsZ2lWgaO0cQwbd9U+JhRRarbpqXisX13hjGIl8B1uk0ZFXR2ZVyhWYkFmO?=
 =?us-ascii?Q?i1uKPSQVjdABeb6PZTxjjDlA7qLE1RSxhbiRTRXjw5ZOtMVh/kBBodH31G8s?=
 =?us-ascii?Q?TLAPBJ3qL3p0yjbIdIO5iUofvapiPiNYb6wAUSiwuGSi7u4Rtunt68+0r43c?=
 =?us-ascii?Q?DqomhpLzfO70sVLQWNgOT+gc5VITccT9HtFjvRuIeDUHWPI9YAR1q3n0l+A1?=
 =?us-ascii?Q?Qh3NDWcrMh4FsoQ3xBKS0OtvZA+s6agzaqqv6H2QdcH6AKsAoAyE4Qk0Z7q+?=
 =?us-ascii?Q?RoKunkybI8/+d/mBYoQDOpqOAQ+fF+cUcG+QqXewxtSA0UAI/tjpOx0vEWXl?=
 =?us-ascii?Q?W9DsudGvG7lzp/zN0XaU64b1FMdIzan49zL54F4b2adNLGNAbJ1EPcxq1m9B?=
 =?us-ascii?Q?ZKyngyJfktigi1vvBLcOvBpKEPZsp80TrMrqoebyeDnBJj96CC6cq6UfCpH8?=
 =?us-ascii?Q?/K7NeKYsUikOdY8t8g54xoWywZIAuh20pG5u/Mt9iht3zNYcwfFkMX963Cgb?=
 =?us-ascii?Q?KCsw2kvHVKuQAR1HselcAmZW7P61GRay+S5dhA1xlv2Z8UTvLeK31HbTfTBB?=
 =?us-ascii?Q?TfgefrzNANnbRD4BKiXQ+ur1T2TWKXUmBL5+z/PT/fdqWbQMsOxRip2qIiBR?=
 =?us-ascii?Q?geX1l5nmKAsZNajtMGC4WQOEVAMUYQGXc/Th2i6Uz784OHqq2t9SnJ2z+Ye8?=
 =?us-ascii?Q?qQcMYSRemWFleYm5nufO4RJU9m68wyb42GWq7kiFUtY3sCj3usPixcPljcgF?=
 =?us-ascii?Q?lJCbSznTz1wLmQT4LZY/VomfGhfPSTElTvceFufP16fBl+pMLmpzi5gKxCP7?=
 =?us-ascii?Q?JV8x5BFRDttfYut0oQcNg9uR5lTMJtgGKYuB7wgVcX/RlsrZlX7gFp139k8y?=
 =?us-ascii?Q?rgDaUfwfeLnvS0inCSQveVpgD6UfxhsTamqhYhd3TK8Cy1dI9EHDMacKTCnq?=
 =?us-ascii?Q?VQjiUcwIuHVTLoAJQiiEy27hiyj9k1chTYkDQuZ2MrHRByG0DWFedV7q+IXY?=
 =?us-ascii?Q?7jTpM1tsASWCqXfJCj/R962HamtFNkwY19CdJhm74pYv4P0e3TGeeJ9C9E2C?=
 =?us-ascii?Q?cwAVP/v8NtiSJkE/kqAs6hPEJ7izKE8uTW2dlqFyCWFLh5sIdTQA5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(7416014)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+g2e+nlRKC/qu82ufdjAUGUxjkv4Pn9KT3i3ko8a+nDBCc/OGnb0AcKTDwtp?=
 =?us-ascii?Q?r+EunDg0r32j2dqc7WqClObL1CmTyVmWR9mGlgMXEXAt/mf11q4gi2xmvDFZ?=
 =?us-ascii?Q?AStfeFxaoHBrc5RVPvuxcIDod+3t8OBCXpvSv1C0HnfNZ3JGeBG/6u2aOr4i?=
 =?us-ascii?Q?jX07b3zLwNtWUmIksp456HKnQwbUt6dMlFNUTIcHfk2qg/HhjrQ/25bj6epq?=
 =?us-ascii?Q?jkQFfsOYj5vNmZBsKc4LgnBHCgoMBUW3ur4woqbLxbN34PwgDu1QT1KF7oQw?=
 =?us-ascii?Q?9uGD9VBsg0a4uZNyiGFuIhwj8FlVbW8tn42MMYj6/ttFKUfEtc9HoW9BnW38?=
 =?us-ascii?Q?xMtNNXu5Cp4+sba47Sl8QhABL7ZzvMk/fH1gi0/xn5ABePtPK89oIhZkYbqO?=
 =?us-ascii?Q?T8Xsvpt//TA7n7nn9rO9b9i7VD93rk6bjX8LVEz3fb1VHjzE0StviBsYowHA?=
 =?us-ascii?Q?EhJG6KyDxDA09+mInCA5y0rM5iAzM6VhSXCaDcJXhxZXF4FEJ4md9wP7AfAR?=
 =?us-ascii?Q?RPCXMjS9ew3pvHEBTzRfbboECUM941fCCQ4XR2xjs/KEacdpJpg7QQxe8in7?=
 =?us-ascii?Q?8Wxy1LJHVooyZaJ1oEkN0kvOAi65A/DAnpF691hDm3Kfh6RX54TWdBYKDeHb?=
 =?us-ascii?Q?QCtQfqlPiHxxIouZK5p8fe4ezqoY3zQOMS3qLSlbpRkgu5ObAiuBLmbpMUgJ?=
 =?us-ascii?Q?ro7WOVPVHypu+rmCmqOjs//SX83RqHnRr2l8UmTpuKZgZAvdM7nXc4qtZOVS?=
 =?us-ascii?Q?kHCfQjZyM7ScuK6OVUJIyXkvUYUuQw8VS86IR5FBf5MmclchXxuAddz7tyxj?=
 =?us-ascii?Q?/O3qGjcU+A1Z8Km8AIGUt9A5JamWmG6I42ngbhMbTLzrtMgkrrKesJyPoq6+?=
 =?us-ascii?Q?TQtU08nYWDVGxGG92fLrc//u4Ohjve/nMKqOZKgXeM2jfZZ3aaHw9quFqOHA?=
 =?us-ascii?Q?qybzBEqMVM+sS2hdTK0Y6Sbqxi3F+ZZNC8CoVbACi1kqU7Jmr3t+YrHByhGC?=
 =?us-ascii?Q?V0kt8coBbP/Q2oHWFOl+97pqXa/tQONOUAXzjpmEzBLQqzlgfC2RlrIeeqXK?=
 =?us-ascii?Q?Nj38dr5r/y8igmdqseFNKa2JzU2tYZoJzrVWgAsLsvFNnxwSdq/Rj/jJNAmm?=
 =?us-ascii?Q?5ZWR266rFF1/MMubi66PQ2glBHoIfLiijqyOC+G+9y2suGsECtlp9DumLQ9F?=
 =?us-ascii?Q?0g1s8cakAR8BjDTuqf1MIk1hUKWo2o+JfsVWWaaz+Zt4ntmr0wuW8nIMFw2+?=
 =?us-ascii?Q?03A8cIYIpKYsiFgpvi6evM/lBBk8QtKrsMSJmbQmw9bOVyFYJi0mP0TcnurA?=
 =?us-ascii?Q?6M7tMyHXBkzFPBNky45KQtxgeVC/TeCqpsaFWAFJmgxxxCQKubGZ6u7EKACI?=
 =?us-ascii?Q?iYfTTFzOW/RR8FQ6/ZQQZBtCDHK0muuhOMEILj0ZukLzKLD5iIVq2HAjH4tO?=
 =?us-ascii?Q?N0RjL6OrDGkqLJmSL0w62BCZH05izO8fYE3TWnqECFMCUxuT2wKBHnkjhbdb?=
 =?us-ascii?Q?DCZYfI/TW07S9FVUQqSlgiiRaJ0uv/dz0tBIHdEKnLFs+GMxjMIBID568uX8?=
 =?us-ascii?Q?8d/pLNigGbgNvL3qW6+TmeWld9o8azHGt+VBtQyL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6be1d3-c609-42f0-4792-08ddf40b8815
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 03:54:12.3384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTkKVd1BRLGHbx67kk6U9cpHWBSbf1vqCq9KsNpDltQOyAVvII/t03WUr9yklWM5eOijZ26ksTRQfWAEt6Ql+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8693

On i.MX, the PCIe reference clock might come from either internal system
PLL or external clock source. Add the external reference clock source
for reference clock.

Main change in v5:
- Update the commit message of first patch refer to Bejorn's comments.
- Correct the typo error and update the description of property in the
  first patch.

Main change in v4:
- Add one more reference clock "extref" to be onhalf the reference clock
  that comes from external crystal oscillator.
https://lore.kernel.org/imx/20250626073804.3113757-1-hongxing.zhu@nxp.com/

Main change in v3:
- Update the logic check external reference clock mode is enabled or
  not in the driver codes.
https://lore.kernel.org/imx/20250620031350.674442-1-hongxing.zhu@nxp.com/

Main change in v2:
- Fix yamllint warning.
- Refine the driver codes.
https://lore.kernel.org/imx/20250619091004.338419-1-hongxing.zhu@nxp.com/

[PATCH v5 1/3] dt-bindings: PCI: dwc: Add one more reference clock
[PATCH v5 2/3] dt-bindings: pci-imx6: Add external reference clock
[PATCH v5 3/3] PCI: imx6: Add external reference clock mode support

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml      |  7 ++++++-
Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml |  6 ++++++
drivers/pci/controller/dwc/pci-imx6.c                          | 20 +++++++++++++-------
3 files changed, 25 insertions(+), 8 deletions(-)


