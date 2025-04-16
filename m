Return-Path: <linux-pci+bounces-25983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2E7A8B30D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 10:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4B51904870
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EC622F169;
	Wed, 16 Apr 2025 08:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="S45aWqb0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E022FF20;
	Wed, 16 Apr 2025 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791290; cv=fail; b=bk+ZzQzATPchVieDpM0Xj653JKpzZP5yYk4xprF2hnEXLGBWagizFD6cDWhsrmfA9+CD/Nn9AW+xhjl9nPVnap6iuu4lWVfEeX4IE0806ApoxK6s59Y4UPFAZSf2THgwmBQyzCUHjrym9H4vVTcMHNhjJqam47JRj2Z/NxqdO9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791290; c=relaxed/simple;
	bh=OJaVlGIuZuLfuK43ca5IGo9AF0hfYb1Tipgg1k3Vhzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bE8MS9TwgL1FAHxeki2Rr2+PxxK5bo1SZ3bu5cXrpvBHZVta3IHrOLZTjvLvcjltcwHroPab/Z2nI57bE3/vqt/DOzhtKHpjg2W7TEDGssg2/Cy7khxPLWGuIzmlvKXVtVFB5J9jxIEUiG6wsRreoyNfwh+wQ0qJqup8MxOZgEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=S45aWqb0; arc=fail smtp.client-ip=40.107.21.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mTy2Gy2AmIhC3ZseqLh/jrt++uEw6zV0queismN6WlWjTJnZMI7BTVllJgZ3FMgAlTab4WHdwvv589szKoepeq/jLglu+Pp3C1RFlJuOTdpFLilpH9ww1z2aUJ3MEcF0vbqVyKPKIQvWjkqG+SDlcjHqjb6Stp9FMvvISOcrgNLHdu5brvkxhp2PtXVzJU+d+s6TDWeqIhJbK5ZJ4/FCVfUtY+vyOPeyxuvLMxgZHL00uFxrUpP+50dGpqD9jpkTXguLM/sYVG2mpQzXrVjEt2e1GZF7jd/GyUhk/5OqiJakGhgP6knyC+sDAPuxRFDX4k55p1GZbLiHim1FXz+7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzkuEuF3vxATR0qlAIIOxYhvBuAcc3gluQRBVeS2DXE=;
 b=W3poX+argoGT1VQFUDXBpfaeYF5AiAzF4HBfk5bxsRC4Z6nDHaMbaNmH2IagVSB1AVA7Va/VePDZmBBtWj2vtZZgeB3nbHxzLnXFPNmExo6istgzxCgKrtbmw2DYzntwVHRsbh8gvMKrtuUIqh7QdU3yO1ofHjgTGtrf0dUPCG6UHgUX8qyN6hiFnuV5GusJmJ8tQgmX4bt5da+Z2rd/FOkR2PZ9rPqIBj7+FMckOuO8+I5ZcWaYWI9sJzTaKHZ/f+z2oEqA9RtBZzSY0bXTY/HQ40ffkwjcNzcqMj6MYgLs/PG2oMuaWiJ7PQyO7d6Zl8PlB7/GxX6i65luSxkqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzkuEuF3vxATR0qlAIIOxYhvBuAcc3gluQRBVeS2DXE=;
 b=S45aWqb0WZIdTVRjNFK61iPiir4onxsQROOHQ4rDjAm69Gc9QKAD6IEjysQ2KgLhvOjpYC4aO6p43hyplEfyt3OVF5jZJ4i6+h1Wy4fCk4K9cumKmm4JCCoxeQ9HLOHxpVy8dPa/idAVNPj3RY9sG8wdLoVcKvNylVZ6hJweV8Q4ZoZh3OY9/i4LDLdLvAh4Qf31rkbryZSourfX1dTcW2Yt/jL1HZAqhnF/yhD54l3bJU25sRO4uk+BNwwXHaZslf1ZVRjcRq8Mnx2ryA896qI4BhefVbd49wjttY1sGfpE3ijxZjJ5P85n13S/rGD+Ip9AdB57bfbMiV9dnH/DDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7103.eurprd04.prod.outlook.com (2603:10a6:800:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Wed, 16 Apr
 2025 08:14:45 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 08:14:45 +0000
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
Subject: [PATCH RESEND v6 1/7] PCI: imx6: Start link directly when workaround is not required
Date: Wed, 16 Apr 2025 16:13:08 +0800
Message-Id: <20250416081314.3929794-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
References: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 906ae62c-2e00-419f-74f9-08dd7cbebf36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f91UtA4w86Y6xocZezKdt7K7diUL0dCscStLj7GjI0i6wvPB0yXF/OHA1Uo5?=
 =?us-ascii?Q?lmnQOe9rdRYNKQljmp84wM2TDcgXw7Z3BXMxSHhhVk/w8U7qVADSHcnvs+rW?=
 =?us-ascii?Q?85cSvCHcMF9eJ2xrH6XO/WiPSs9mEPRb/aRacKBtv7wPbc+VmZuoMSKA7Ar2?=
 =?us-ascii?Q?8/Mtp9e0LkAXTPih/KPw+q2R4qF0xLN6Ccir1E+hAzuoGg96CTQO9MWsOXxe?=
 =?us-ascii?Q?XOGIedlZqv6KLFsufGGZdHFmZMdAOuCe3k37INycGH+6Q5BSaW1MvfBkRGZZ?=
 =?us-ascii?Q?D3YVC1KjVnsrKblI1oSqFKUw4E8AdANpNWmbNs1ucyvRtW/9kKuklv1Y7nDb?=
 =?us-ascii?Q?ud8L3ISEuQSQEf+t2A3iyMHw6d10eL84SZlayCy5QTitJ0RsqOfOsD7lwMoE?=
 =?us-ascii?Q?Aa23Jv85Lvt5z0N6ng7rd6txJFLApsEx9UcwVgKpopCJj1e6NQUcaoTwkTJ9?=
 =?us-ascii?Q?tmsoAbN3ibWr3aR+pXMNTi0+uzvaT8N4IjLo62zN4o1Lv+7Pn2xArT7kr6+8?=
 =?us-ascii?Q?OoUqqc6Gzeu0tN6lm1Xp0CkbavwTgzF7hyghVPzvUTc8muANARPNlEbSKMpj?=
 =?us-ascii?Q?fzCTtUhPtvlFBkpaVoqAzbIuseERJ0ubHczDBBhlhgqYj5aLhPej+cywJZFb?=
 =?us-ascii?Q?RKaJm1MdrCKbM3t0yOr8GxG3op4CZNyvSxSOWOND6eP3iD94PG3GUZhw5252?=
 =?us-ascii?Q?dFh0U1oOyhb2itDNPCIbnrRMdJmUWvI7YR3+5ZoPS08WID0ld7sSDIt5B65m?=
 =?us-ascii?Q?xvy6aGbQ111Jn7/19dum5GLzDsbvf9Zqulgg9wLKTyQJEtLtl0HgkGWvEyDS?=
 =?us-ascii?Q?1LC5eTo4xFXbPHg2ssMDEZtWUYpoch4Fqe6XnjpPbycWz/hvt56b9KOmc+AT?=
 =?us-ascii?Q?fAs2lDMXMWZNNKQq6Ea3AgkiNFrhgOy2JtWBl7WA3YU1j2euCobKTalOVmrf?=
 =?us-ascii?Q?6P1JtMWnSPs5JD/xFcSaG/PG40BJu/ij5E1jsjxIB0F6G1V3Sg+jhj3k0iMv?=
 =?us-ascii?Q?uOZRaoFF7B/bXzqjgOyvBIt+Wr4IE4ynRIAMv0DOJp7xCawilCpWLvBps5Cv?=
 =?us-ascii?Q?Y8LkKaEOWu3eC11eTM8LQvcNjkGfXldyPuUX2wobCVRW+A79jwqryvQH08d2?=
 =?us-ascii?Q?l5bUKRlB5rfvQVrsXFSub4jPxL5xwIdI1SN0jAhxSvOclfLFv8wokRWOlsis?=
 =?us-ascii?Q?OX9Aa5u/oxDdo9DaiTHqDTI1LrmIBGWH+wq5NQiiFmg1W2hg/jIvWgbBgtWy?=
 =?us-ascii?Q?ApYfMCcpHs6fdYWD58ghXDR9/5dLEXt+atptiXT/LE3q25dE0ygIoUWJki8e?=
 =?us-ascii?Q?TVhiLTaA6MEi5psEk+KquJz6+3aO4fdGz4qTregcRFQItM9DpeeBgb/f8tPr?=
 =?us-ascii?Q?87fPcmACVerjvY8UU6viOKElvXfm/UsgdP7ehfLlgXZPjBGw1KCrBCGUdjXC?=
 =?us-ascii?Q?MgJXsrj+8E3qarDhnQmTMn5djysAfcgd4NCVjOr3y+SGNcebGT7SqwnXl+UC?=
 =?us-ascii?Q?KWNiOhZDikSUekI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mue990fuX2F6mcSKuYpM4pcaSKa8VkOv1ifyy3KnC8n69bU6OK9E3I43aasr?=
 =?us-ascii?Q?l5d/khx7ZpzV9e5V5/VhEvq68adIdPZte9sab9GWmuvqPSogBGl8GEB6Pv+N?=
 =?us-ascii?Q?2NnRt7vR8+exf3kVXR5ZRBptF8izd/VbLEutQ5ZbFFIg+0YLepyDNubBHm/J?=
 =?us-ascii?Q?AbSQ/ep5ho9p5UwZrGxmX9Csn1oeAxmwq/VidwTVjU4qMUtk2MHdUPN1RhfX?=
 =?us-ascii?Q?8p70qKsxjBy3yXhZYzxwIVq89s/x7ev41mVxihzmH9Qetq5bnabRJbt3EEwu?=
 =?us-ascii?Q?o3zpeEkGoddiibxc4Lp9JjBsGjrLsAQBQKahEoNm0EyIXm1PCAaDAMlkQn9B?=
 =?us-ascii?Q?Hk5bp5+G3AJlm/7s3FyrP2/XI/61h54h4G5RwyA+KXhna8QS6zjGb+gTarYC?=
 =?us-ascii?Q?C763slHXRmxhA1jzZdBRaKHlRwhMt7nUC6cdcqxqdAIsJs5z7qgo3OArOtS0?=
 =?us-ascii?Q?kQSYYlCWxnTCL7LiJCPyXmOlS0frewTBciDvFmF25YF1KX9bdaIBome0deDP?=
 =?us-ascii?Q?IPC6mGA7RWKYvYLztLG+V8LCmA4k91A1nqTyIoTbYU6zLYR9WksEWBEGReui?=
 =?us-ascii?Q?f5BigAEraNkkXEm4tRvEVdmXnTWvw3RaFwJIxSwUN4cgkyDEc4zaUTApWByV?=
 =?us-ascii?Q?EKoAfJsD0AWv264cOAhg4gs1GUNIyp1vo5zdmmqB7A0P60qCS6ScLX7I2LfF?=
 =?us-ascii?Q?hG3rKXjKcL7zpjeAhS7j6ltPD+Io0LbC4eM5YJbwhoOClF7MNKixINRGD0Ls?=
 =?us-ascii?Q?JoSRq8SUUwuJfKm5awgc/YzfX24z4bNSKafNNWbobsSbtUfeETQaxT6ysc0f?=
 =?us-ascii?Q?BHHFWNRtLSK2f4/YByRRQAPEMBUnYArt+Ys0od3LErhkGD2XhOmH12mHAC20?=
 =?us-ascii?Q?7rc2BrM+myj8rn/tOQc5F55TrYG6FsR7AdF9+CnnQeP7ZjWQ/XMSkcfd5ANL?=
 =?us-ascii?Q?MlDV1SQO0mx9jg7erQ0vA3oIUOtfB6urx81RHIQvs14ydM8jkoyEvlUqjIDV?=
 =?us-ascii?Q?pXP/7tkTg6rK6njTsIrpnfSQvOoEc2uX8ruTG8XXlurFiYJdxkXQQrQbD6sn?=
 =?us-ascii?Q?frm/x4JpfYcQEqJQ0vL6rRh2xaKAZKLMWZAeSwnPIcFZxrvKS2QKTgblU0vN?=
 =?us-ascii?Q?MoNoqcWXnDI0m50+dRG1khhDrHbzaHe92SoZTe4ECDMgkpf6rwV0v84UZuzO?=
 =?us-ascii?Q?T3ozeKY03jbNBi3i5xHQ0mHBUfxFwqJTxMEkRccPbq5SAtPTax8UMxOZ4bE2?=
 =?us-ascii?Q?1bRY/Vcad84r0gM2+QVzmxcCFs6W/gkkxutJKnUOQz1B0m10K+1ujZSoHT4K?=
 =?us-ascii?Q?atAyhJr05b/Tx+N0C98houqNZYtFQqQDdGZAugN4TpKUWkjfSa/5UG2kI9ZU?=
 =?us-ascii?Q?u0egl8YG0t+M6hKzjr1U36gaESFx+O0Xayf0J3vjaGM/sVDoQWf8HaEI/X2s?=
 =?us-ascii?Q?NkNSclQSLMAwYrWNY1jdlrO/FrxdgmazxcD3+xj/F5NJIrTgMbBbAVcAhpW4?=
 =?us-ascii?Q?D4vjGXudUdcgcyWrJY8mO5Ex3/jfQ1SHdDkv+dKDBMPIfpqhO6ghHYK1mrni?=
 =?us-ascii?Q?NiNXRV8G9qlX7uCee8Uq+M6g6OOXNswkxwhN+jNm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 906ae62c-2e00-419f-74f9-08dd7cbebf36
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 08:14:45.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tG2tJkOdSkn3BqVTHEinuiG6kZrihg7/CUPGSLSZpuEfKjM6r6oXa5+TrhkG6hNSbsozyl84eMfg4hFa92HnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7103

The current link setup procedure is one workaround to detect the device
behind PCIe switches on some i.MX6 platforms.

To describe more accurately, change the flag name from
IMX_PCIE_FLAG_IMX_SPEED_CHANGE to IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND.

Start PCIe link directly when this flag is not set on i.MX7 or later
platforms to simple and speed up link training.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-imx6.c | 34 +++++++++++----------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5f267dd261b5..a4c0714c6468 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -91,7 +91,7 @@ enum imx_pcie_variants {
 };
 
 #define IMX_PCIE_FLAG_IMX_PHY			BIT(0)
-#define IMX_PCIE_FLAG_IMX_SPEED_CHANGE		BIT(1)
+#define IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND	BIT(1)
 #define IMX_PCIE_FLAG_SUPPORTS_SUSPEND		BIT(2)
 #define IMX_PCIE_FLAG_HAS_PHYDRV		BIT(3)
 #define IMX_PCIE_FLAG_HAS_APP_RESET		BIT(4)
@@ -860,6 +860,12 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 	u32 tmp;
 	int ret;
 
+	if (!(imx_pcie->drvdata->flags &
+	    IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND)) {
+		imx_pcie_ltssm_enable(dev);
+		return 0;
+	}
+
 	/*
 	 * Force Gen1 operation when starting the link.  In case the link is
 	 * started in Gen2 mode, there is a possibility the devices on the
@@ -896,22 +902,10 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, tmp);
 		dw_pcie_dbi_ro_wr_dis(pci);
 
-		if (imx_pcie->drvdata->flags &
-		    IMX_PCIE_FLAG_IMX_SPEED_CHANGE) {
-
-			/*
-			 * On i.MX7, DIRECT_SPEED_CHANGE behaves differently
-			 * from i.MX6 family when no link speed transition
-			 * occurs and we go Gen1 -> yep, Gen1. The difference
-			 * is that, in such case, it will not be cleared by HW
-			 * which will cause the following code to report false
-			 * failure.
-			 */
-			ret = imx_pcie_wait_for_speed_change(imx_pcie);
-			if (ret) {
-				dev_err(dev, "Failed to bring link up!\n");
-				goto err_reset_phy;
-			}
+		ret = imx_pcie_wait_for_speed_change(imx_pcie);
+		if (ret) {
+			dev_err(dev, "Failed to bring link up!\n");
+			goto err_reset_phy;
 		}
 
 		/* Make sure link training is finished as well! */
@@ -1649,7 +1643,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6Q] = {
 		.variant = IMX6Q,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_BROKEN_SUSPEND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
@@ -1665,7 +1659,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6SX] = {
 		.variant = IMX6SX,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
 		.ltssm_off = IOMUXC_GPR12,
@@ -1680,7 +1674,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	[IMX6QP] = {
 		.variant = IMX6QP,
 		.flags = IMX_PCIE_FLAG_IMX_PHY |
-			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
+			 IMX_PCIE_FLAG_SPEED_CHANGE_WORKAROUND |
 			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
 		.dbi_length = 0x200,
 		.gpr = "fsl,imx6q-iomuxc-gpr",
-- 
2.37.1


