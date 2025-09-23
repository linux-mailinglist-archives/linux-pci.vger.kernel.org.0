Return-Path: <linux-pci+bounces-36743-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77819B94D12
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 09:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3901216729B
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 07:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D68224F6;
	Tue, 23 Sep 2025 07:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rk/rfrip"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013003.outbound.protection.outlook.com [52.101.83.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8D930FC09;
	Tue, 23 Sep 2025 07:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613214; cv=fail; b=HmjIPfHz+eJSA9TQfd7WJJn4dT4TjF6h6w7vI3V4TDUcXk3v5muw62tkFYqMQJtHcwSwEfNS4u6w2XL12O8sm+wPP1lxhhTc/ovJ7sXvo9u0tUcXsD6UkF9HD14mDJ2qTDgMQKh3fBp8m/jKhJWa3EnVKH9QM80lXNhHLa3EJd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613214; c=relaxed/simple;
	bh=LFz9qX8KfqNEIR83sMfWu7ZX2rLQmA/hTqnpShcp7ng=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=A5q+z4KbMOIaPyAbnmC/trw0ULZ4QQUXS/8ZsO99QBvSy0IXgS9mcXLefeuvMpFdsG9FGBlTSFCl8FS4eKftX+vtwLjNBHnLRomX+fnQtJ5/V1tKIpdVaMp9ayaWwnMyEecfBfW/ItC9IqmaYH0DRrzhdmXyL9IehKhne4CmDWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rk/rfrip; arc=fail smtp.client-ip=52.101.83.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sSYYOJM9H4ZB/DVSiI0gD6ERZkMW9RcA2l49Ujg4p1DNYkHsPWspwnD+MnCrLcSPrEx6JJLWjyv94q9TN2puDdWc/H1cq2DQFnlRcjAYbtMMjD99ggOcJ4PuAlBFsYXCuyPkYhGBbD+8JGURh7PeE54/T/T7pYHsOwkgUv/c0FuK4s8gQRyQSgd8rGuvrLEBKyoBqq+q3T3PlRiXp4+sCEF775Xj5Eba1v1pgTYa8VmO7sq4FUen+xoNIdEjkXZaxtE5/S3SsxyqEG/Bk+bR9BKktTJKcVmK/n49h9n2jonRPzs4rljqnncCefd2dD5rvbFX/54B1ojsaRkCQPMGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lZRRc4Od9lp8WmLxwZAFQFru2UrqpBJoWq17TZK5H4=;
 b=C3XPb9BuBYdFPAsiRVwekvj9pW9R41/BF0XM1eLfoFhN26QDp7sCpDR/QGQYbw2caH3vBlaAkd4xWIOYT5EmVX+iGggpZBoRzJB98ntEmbekCmtyvKB10z45rPLW/mVssnoa+OhTX8ejN/3YVPL7lbZZnDk0YmhA6pT9bhdFu/0WaLKUFyC6fohjs9GOXRXi2vOpvI2kr6OX7p1UrcAqoT0BvjPFzgQSQWMvf+4dw9MEkohEkcZAnbBT1Xzb6KjrjgJz1rWCp/gXiRREu5GrkQxz3oFdTjCcccqNNBrpAmzVIrByHKbbrqFvsZfSQvrT3w4HCs/P1fcH7rl8lAXvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lZRRc4Od9lp8WmLxwZAFQFru2UrqpBJoWq17TZK5H4=;
 b=Rk/rfripa4W0Jmn+Gof1+Gss1OH3NrMnQHHxBUr9GPrmWtHNCLq03P3V5ZyTxlu4bdnkXvCI0cUTzWwguMmDVb++BglD8bwCEO7R/FHqpwzel4A9ja/QJKqVJ5uI2rX7CcX8Ffv+QkcQw4hL9trI8p01qOkAgtXZMDltI8XcYxmHYYYwdszyC1uiMvR6SCyh7Ozow328RQUEw2jU5Ga62m+UfotLJzWiPmPZL3ywtxwbANczINHB6he4tbIFctMlyR2nqIfgUop/N4ubNmwrHr8iyMZBDX6RSW7wZ1q+Va1WEBXbFsDcjp5NXKuHQUqhMmuFimEXa7z2ciqO9mEO9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV2PR04MB11327.eurprd04.prod.outlook.com (2603:10a6:150:2ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 07:40:07 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 07:40:07 +0000
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
Subject: [PATCH v5 0/2] PCI: imx6: Add a method to handle CLKREQ# override
Date: Tue, 23 Sep 2025 15:39:11 +0800
Message-Id: <20250923073913.2722668-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV2PR04MB11327:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf37271-befa-4040-171b-08ddfa746b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|7416014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I+0ju579vDPqRf7qjGdDsmoKG9XEB1QEN9xksA8oGE/d2wbRvStGAJihAx2G?=
 =?us-ascii?Q?2y6JkP5rliJ4hPINQU+PaRfVh2Lj1Pxu8ws97INLwJPREb/ab/Sn+2JVkpwn?=
 =?us-ascii?Q?cAYXELDgv2St/OZC+99S49Ne/xK9mL3e+eFUMdxlu0DQLg5w0lGB3io9Fc+c?=
 =?us-ascii?Q?NbfSCrw7lFIaljZwWxiLmUnGByIXhT/EokJX2HHuWaLk1G2KSaDH9ZoVIXWw?=
 =?us-ascii?Q?AV/PodcFfpdz6kBhqU8T8iaqTFahuNRML2LX4b1Dovsfes23jnvdsbYpX0aj?=
 =?us-ascii?Q?7zQLoqZ8pNoG+VHCBykFxFrmVt+AoV/IdeupTdHtGE8N0sTC2w6HUecL5+5w?=
 =?us-ascii?Q?hyz0G8hoODmM4NjdMBMUdsssU6ZUJ6gs4C3h29t5UzLOevWDUpOWJFOtFt0m?=
 =?us-ascii?Q?EFfyQs06s6EQgm7EZsKs88JPRBpSLpwdaaqCczJ7FmAswkVLpW3hfQOLRXcR?=
 =?us-ascii?Q?El9JINNt70KTTp+Cm8p7EQP/xxCMj09Sb0WKNY+/zmscie4Fbs9bc3mIn+gW?=
 =?us-ascii?Q?mtPICxlhnQhuc+MZZ7EHaiv8xCXv5YSCygWiRfC4wAUxz6NAKaiR9oU11Giy?=
 =?us-ascii?Q?sjcYnpg0Wjqz45YzvHJGw6T3OV6XJ9EXBMTz8ffO4oVdVAz4U3iqKGNicpoT?=
 =?us-ascii?Q?9bcIXYHsWPZMwfM1Dld6JQsnchYZGzfT+ZnC5IdYd6/jRgxwBbtgdHugmD+c?=
 =?us-ascii?Q?Tr7ZnAMsZwQ1a3dizjh85SkJ2IYJiN0RMb0z/JikqVWSlhRWxMit+4eeTk5f?=
 =?us-ascii?Q?m43W8xO7xDAbPLqfuBMHCOPCc8vIJpWeXqLKSiVVM8lWBajhuXoPDLWdjp+J?=
 =?us-ascii?Q?J9/szkVeJxR3+dAT+tM9BOUg08as0XQNBqeioTxpsEJ7mt49qyddTrWa7jKI?=
 =?us-ascii?Q?qhx3v2svhJplZVbJbTZXJBg75sXkcv5RxXx4+WCy0BcThkWk0ysyz4CLKuLo?=
 =?us-ascii?Q?yLtkVhWQqI+JLaVR2pEQd+Jz8Tin/Xso8auRCsTqhdF2gWENEGqCE3pHwMGp?=
 =?us-ascii?Q?rmP11q1KbQc/yySvOeZZ576qJClOPJHc1yaqDOBRQnzlZHjb7Z0UCZi/+hUl?=
 =?us-ascii?Q?zWzkXX3Vd3t0q3862wbqOi2DdlbLsmpvYNRQRX3eKm6X9nPeUCBA+nZwvU/9?=
 =?us-ascii?Q?Fpq4Gh5MrCpRfRWYayhS25OoJ6Nc4e/Ac9u4o0hFqy7U6scFACr/WVHT8NsE?=
 =?us-ascii?Q?mxFL131Qwlab8ifK0wyPqMWE+rXr+woU0feeUCURU6q0NfmU0RTVGI5xQC12?=
 =?us-ascii?Q?k0Gv+LACgr0vPWtvWcmRZ+ZMAtucW9zaMwbcavDkL9ZnEOYICLvQhpXZiGsR?=
 =?us-ascii?Q?PZDYJyc53maHY59Ll4fxwNt/CDmszJ3oVWqoSbLKIaaDg5zMhmWZOaxt1w6t?=
 =?us-ascii?Q?utX5jtNn4yMwADHnuFPEu5Moob6COl3FYkk1wRViZWSl4fHul30jfkZZZPLV?=
 =?us-ascii?Q?vtDelLkOOLNzJiYR+i61JykoWOQlmCvPpGDVFFdR1XRQaagibZMk88EIOPHn?=
 =?us-ascii?Q?4CDJCI09Uw7vXQY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(7416014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vDUsCsaJAfZU9LlkwTVzzeTfw976pHMHvYbQpqztmw1PrQbfWNHWHrufYD92?=
 =?us-ascii?Q?J2h+uQIsvAYDx1oAW4scXDdzTzbU7UDo0dHiFh8eJQnIKSnLr5hs5W/3ERFh?=
 =?us-ascii?Q?7ut23WwTHX8hy/Rn+2B3hpa3e23+itXemyPYl7eJbuA/f0tPNNOA3LJgabNS?=
 =?us-ascii?Q?sIxlhMpCLudWVM/UpInuoAOwDaHccQrvTzTocAdyIqta0kUE7GLiZfr3yihh?=
 =?us-ascii?Q?ENk1bV0qMUS4rCgwRX6jh0jcqGAmRQF+v5DYYj9MOtZHOK9hAlJA0tE5pvjf?=
 =?us-ascii?Q?RLsk8lNe9TGVslVW5bLF2hKrhfHPaPC+K5xs4176dzPbeo7GNIYdBOGKHFO0?=
 =?us-ascii?Q?akHwT3P5qOFXIG/QNyjlTIyARH21i4zIBvRdQzaptGL9wQYlgMHv8LDIbGUt?=
 =?us-ascii?Q?4esaN/I6wPQ6O7xq/bCTDgiK8IAW+kFPUKw1K5OhQY3q5vsHXfGqanuqnV5+?=
 =?us-ascii?Q?GaX6IUltqiYDCnFCAyEnL9t/ejqnVeynJOoMLLveFDsc1KHUSsQRH0eebA3o?=
 =?us-ascii?Q?wbK7a//wCqIa5UXsPZRm83r73ED+TB7zShq5JAE+6tioQyOHmqFiwQJ1NnD1?=
 =?us-ascii?Q?4c7LsdETabjI4moHQEbf2OFx/y5DoAKQPAHLrPW83INq4+Ljf2C2dVZauaqW?=
 =?us-ascii?Q?Z7DnwEhGNGsrsjliwWsB6OIxSSwrLV75fF7EusPj1cNpSAVusNb459q3lr8t?=
 =?us-ascii?Q?bDSiDJYyZ73yX0vN0aDv5ofyK/vf9Gf/P8QsqeZb0CqvmFK9o9XoLTuS+6dC?=
 =?us-ascii?Q?86Sb3RnstY9KiFVfUDzE/wag6k3uq8uNZCaQ/20qaLW4JvPbjvnpcFiPd4MU?=
 =?us-ascii?Q?+UkSRITKCzBm+ntXdu1foPZqez7NfyFDQqosOZ2GIHNMmslGz3et0KN/jzEL?=
 =?us-ascii?Q?1NU8hKtuN7WlatS2sxhQ/TAertHcaoiTdC9W0GaZG+TLDDSpexgOyKVTeQ73?=
 =?us-ascii?Q?TBiVoUQxhh7aeFUfTyvOpU6UWACi25tAmHvmFLA32j1Uv+Zc5lC1a5tV0706?=
 =?us-ascii?Q?iFrzrIzlmh9IpcCITrUqzwTRleJQtzFGz/41KE7Wgbl8QRTZfIHP4LvwYj+L?=
 =?us-ascii?Q?fhRTU+IvHqRwj6UARSdeKriTL/lnqT1ppvmQBYuNqsabV2cd+00kvZcSq/aB?=
 =?us-ascii?Q?IFfUsj8+aR94zNitTmXjLi31w9cMI2T8UHRZtvGEp8/WS53QbZOW1Yt+y1St?=
 =?us-ascii?Q?1Ohfg0XsNFZZ6CKy1qCi0Qmwa99aW+zU03QldTAkI/bBRNUKLJoHViDns8XY?=
 =?us-ascii?Q?eZOQwwBYVDR6gBYmqCqTWFtFLaUr3oVFzdu6RDKSMJexAfvyLBrHIKRl/3s7?=
 =?us-ascii?Q?3UN1taEzfzd98/afZoQ7m3scTsHM07IZVh3B1bJP4SgdhPoljrWIyBsfp9vo?=
 =?us-ascii?Q?PzcVXOOoNR7FnH3FUItWBFUBq+zfvea126dAC59Nw71zyQWbJNyan9yJnGMU?=
 =?us-ascii?Q?QysTsK9FgJaAbGuh803WtAcHzCUkKW7DproXin7qYA4T0Mjc4b5b9dKa4/Pv?=
 =?us-ascii?Q?OkO91FgGx3u551gxiLTGU2n++uyIJhg8pZGutg/uHxzvN2BtZXo/pKVb5mTw?=
 =?us-ascii?Q?XMNlKFFtolCPhOHXFwu6QO1ubYBabUpK6hPD5DTd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf37271-befa-4040-171b-08ddfa746b0e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:40:07.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8ctL+QlHjioTCzAWwzn5HhsnR86Eq8MJgxB1uxw8KdYMvwF+eKDDcYYEQXc8BjL1s2OfrKYWHnerfOPPuJTjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11327

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

Main changes in v5:
- New create imx8mm_pcie_clkreq_override() and keep the original
  enable_ref_clk callback function.

Main changes in v4:
- To align the function name when add the CLKREQ# override clear, rename
imx8mm_pcie_enable_ref_clk(), clean up codes refer to Mani' suggestions.

Main changes in v3:
- Rebase to v6.17-rc1.
- Update the commit message refer to Bjorn's suggestions.

Main changes in v2:
- Update the commit message, and collect the reviewed-by tag.

[PATCH v5 1/2] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
[PATCH v5 2/2] PCI: imx6: Add a method to handle CLKREQ# override

drivers/pci/controller/dwc/pci-imx6.c             | 43 ++++++++++++++++++++++++++++++++++++++++++-
drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
2 files changed, 45 insertions(+), 1 deletion(-)


