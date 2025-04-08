Return-Path: <linux-pci+bounces-25470-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1F1A7F2F7
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 05:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7D01899FCA
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 03:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6268A25F981;
	Tue,  8 Apr 2025 03:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TDgqghYS"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013061.outbound.protection.outlook.com [52.101.67.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7057B25F984;
	Tue,  8 Apr 2025 03:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081285; cv=fail; b=F5SUoZSCSNEY36uqbGTviJ9ie9LPbJOrCZBAp4ykgTC3lk41xUnGkf8my7XSPwoVR1/ua3HZj1ZOmQD+dTmwJHR2QL9Jrd4xsqku8KYnuKsQj+KYpevG0zbn0opo84RGWFA7l71D8c+SyjaAGqIfP8vwvFONLrNnwcLSHjNpf6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081285; c=relaxed/simple;
	bh=KePYvC/pCjBoNJNaY12I64vvDtEoAe7AkBIlpvllUQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O13NsbJO1PjurI54z3/htL3nNg+GaPQTNUihNO++1DpvWl60k12nmTqbB+UdCHTs6yh90qQlfaubGWo+Xk/Tsp9qD+5ALeeKF3uR+X3aWLwA/BkTkionC3HLxg6Uv+SjLiKShbNFGXR9ht8QrTIr9vQ5K/55tu2azJDrK96/yL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TDgqghYS; arc=fail smtp.client-ip=52.101.67.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgnGnJOBtgJARiL6nhmOgwHN6yvqpLVCmf257s0maWYo89dH0MiAPLNrQtif1uwIwJ/Gau+wG33ExT8F9F+MGBzO/JchtLzeHgS11YFjQEP33SppVGpnKibcdYzVxZJmFcYxJXqcB5CrdLXXNrfoabHvC8yDMUSMO6llNbPhs0A1d3y69WsKzsHe8/hJO1irddVo4vuhk63PMl5OV0ThynDVQsldTLTKA30wcQdpVAqB7pKwZn+ApeaCn9Z/v5Z2iaPUhHbscwc4MZ2fE7X+aBz9WCyA5AreQ1Amega3+lgm9Gj/2nTAah/Px6IDFMC1rABKw5jwImmhrmZI6HP8nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqGfTcLo1ZA8us0nOXevDpp5WaCbag6gRfiVsdF4Lus=;
 b=IX5Z26baOdNVX5A5Hv//sDU6UbWy0jqDbdwoqk0b0B8zsml2dWVjvYVsVjxzHHul8cDEdGFHJ32GjQWhJXNGK1RA0WpBqWS6PtwDp10XvkE7Sl390QAzuKtlKSwfdyTS0wDwGp7oMQzDF0FvlP6Pw6aoq9CvJP7B3G4oklxL+HV1i4TOW/t9k1F6nwuuiTu9FzAUKnqNhYJBltW3seriZB7sx8rSg/tbxluiq3722SJnB/oGpqWAckokvXoM2AJRlPI7/rT28mvXO812Y9lP8y/h7tAThmASx99gdrcpx8YlQmQePK3pzejeJSW62L31fhsDmcAM3LMMQmfYbHBhBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqGfTcLo1ZA8us0nOXevDpp5WaCbag6gRfiVsdF4Lus=;
 b=TDgqghYSQx4Klszk6BSf9RIvuyEpbywXyL+sw+XEDtoCDZZcLaGMCUgfmYL8TQ0Xxj06ISzzv7BgL8bXMCcszX5dYlw6wLiv9Cn37pIJsRl8QY3wGefehHxaFlgu5OOK2OsEqx3n+8MkbkOiaV4CtmH/hjeElUb5IhSVJo8ebkP/xtI3LLg6gUaXOZPuYFWHz0A2ylk77WxZMcuaqovK4WxgOl15otEPkIJbf27TFEqAfkUkDB67VM3YRkG4JJec33oDJXTNjEl+vgm5/qyN5aUZagwWtI85naYF0mFeMPBXPecZPQen5Zt9RHb/3UMV3D/PWn5wW56P6RZ1QAcxcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.31; Tue, 8 Apr
 2025 03:01:21 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 03:01:21 +0000
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
Subject: [PATCH v5 6/7] PCI: imx6: Add PLL clock lock check for i.MX95 PCIe
Date: Tue,  8 Apr 2025 10:59:29 +0800
Message-Id: <20250408025930.1863551-7-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0051.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::20)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PA4PR04MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: ec84bdd2-4be3-4501-5c9a-08dd7649a3a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IssO0hZ3IL7f+9OKVAywxZrGfTE0U6KLkIopgnpNBliVSEdIgJgPa3ZyfcaP?=
 =?us-ascii?Q?AYXAk6Rm2sMWD9cTrpGM16wbH7+3XdDoKKJLuSgF73i5FzAq11UhvDGVHRaF?=
 =?us-ascii?Q?RHvCwEf7Ym3INy5PdpJZ74b/HCc6gt9vo9ZYewm57VsscIoj2FPnHkPuMBz+?=
 =?us-ascii?Q?I5EkIgPIzDw5DbvqEEBfC9j5AKUD04+cdjntJLPZkHR9+fxj+zYaI/9tFgHb?=
 =?us-ascii?Q?0IrkPtn3TlgjiRL41GlZ+IxOXB2ua/qU3k27GNtkCf/u/xVbL5ekgOXEBDpX?=
 =?us-ascii?Q?00dPrMGg1Du5Az0myTkY6Z3xDD79w1DkuIifiMkoiQvU8tc2IIBjQI9yv2Dn?=
 =?us-ascii?Q?EcZdEmZrp/hmp9HGoo0RT0DR6ETynKisYGmdL/UNCYizuAJSbVf3QYsJalIO?=
 =?us-ascii?Q?oJeODMLPU1rpQtw+0n/sz2IYSZKNQqbUyMPINZgFjUdZXrGnM9Qj6QqrSRrp?=
 =?us-ascii?Q?HsCunQisYSMzgcx2dyR+Zr1IfHj1GdAwcFAnWtgSRwS6pehwqIT3zY86NPu+?=
 =?us-ascii?Q?sLkWZYoCf8R+xEUUN73fybikC9IdH+uXacpCRTTE0Qbg4/fvMXdlR/tGn71c?=
 =?us-ascii?Q?SFdf+EVvlM35P9EVxFFnPuFaDnkpBGLGlkjYDMtSXoV3vIB0PbUzFLex78Uy?=
 =?us-ascii?Q?fKi2Ei/7y/9Fh4fzX9+8xivDICdAD8OzC0zBhwVTiYpejOjW+SR+O0MfzzDM?=
 =?us-ascii?Q?IxQY1Fa+2F5ZYvWErgPC45lIWcP8LIZIjJo6SG6lBzYr0PFYRAGGyrLKuJTl?=
 =?us-ascii?Q?VAT7GCB/aDkB9pISbFfFz1ffF5EMwTNkQ5klxqeQ6tp/BwHSa9wPD1ZPUmM4?=
 =?us-ascii?Q?xxchlP0MgbvxZt5FlqXLLFBDLvYarBZGoFOLmblDaIMxzWkuf6uAjBo7E9Ke?=
 =?us-ascii?Q?8pcQaoUWQt3U0zc7EYFFJXHj0CjdcbUdauSFKzSKkYW3hlPZv7tNj2EPsFAJ?=
 =?us-ascii?Q?SE+ywy3WdyC5hpcSXqkoJ7+7CFOOVuL35ZWeYV2GRdXIXgDhMOok2O9RR4ic?=
 =?us-ascii?Q?Q3Gi8nddfjy3PcpfaDejQGWdpzYdwFSyZj2EKTaX8RmVPLq5WULiGmiLhZs+?=
 =?us-ascii?Q?7i4sGRBQMkZPPuyGR24YZK1p0ZvNvz2t3fYDOQVG8DaVdes9+eEa0QTvg727?=
 =?us-ascii?Q?Tb4xFrF/s9yUwapwlig8DnwQWg9wCkTe9tSz0b24gApkmFzzQ8Sc07LN20bN?=
 =?us-ascii?Q?DbnYk3zxRwHlVh+68M/wZo3jkpMrdIxTc7ieG+EKc/eJ07C0cgIeUiEqD4If?=
 =?us-ascii?Q?hiIWZGyjmSZjGKAsPqb4zp7tfayEtLIKq5FIUl7QjRX+cYBvU/I4VK2fCU4p?=
 =?us-ascii?Q?5+8D8FDr963USinXG7r6pJ8szAgWPulZcqE46/zCYM6ttAeIKEtENONmzMnt?=
 =?us-ascii?Q?U31XzaPWDyQ+aZfkGap/hX3LzCRQdZPSEY3XVkWRvEjB31ia4VFYqpmyBoSd?=
 =?us-ascii?Q?MVAsbWmnsSQ7Vc3QfmxZmHb7taeBRFaxsaOYnGDqLgZo2RpsSxro0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?21JhnP7NEM/9UZhZCpYEVmjnSUbFdWcgosQ+girPnn6UuxaH27vRoYI9SKqI?=
 =?us-ascii?Q?BVbSFafP/1UuA/W+JYTa34hCQArJOni1w4cpYqjodcthmEzxJZ+4EhXeiFWx?=
 =?us-ascii?Q?4IroE0e6xPem4adXmSlhL+biInZnFaeTW+hC3TxU3xpV2KfYNH4365eyJVjb?=
 =?us-ascii?Q?S1WPK1QqbaR1a+J399GrA3VsM9tPvXqFsOGBIIyB4QzNezyXL5gSxfSiNly0?=
 =?us-ascii?Q?2vlNU3985bJRvwm2uemWf1NqJbC4WoKW+izvNnl7o6bcSwEmhTzj6pG1LFWk?=
 =?us-ascii?Q?YJHi4IYzA8yhUUZBGwG8i7zZ+gFkd42sw7XY/Tt2+cfR4aPo3lMuLbqkCw6j?=
 =?us-ascii?Q?bp+vznArIdceAvwSrTLRTaLD2MV2mhOcgB2BwKICtxaANln1C117U0Vyyunb?=
 =?us-ascii?Q?iOL6wPGQHxk08MZ21Zq1sR/1qxx7Qs2kYH19udnqbpsarYXAVcNWbg8rzloQ?=
 =?us-ascii?Q?P08iu1QDjfRw4OX0MNHJv3yNZjtTZCzU8wH/zhmG3rZI9IjAiqyKxnJNxOqh?=
 =?us-ascii?Q?NDK8cqxE2m6emon3BuprwqEGjgXPQ/dFBiGUDuoakCzqLoa548FXUWmYAWEd?=
 =?us-ascii?Q?2laHNgTnW7lNRqUarAKfbfPvkP1Mm5bGN4JaKo49Su5mWwMYFfQb6Ig6yB8m?=
 =?us-ascii?Q?/aompSFJzkR+NQJbk9OzBkjFm/Roin++1yu0HjVOsj0n6I/EKB29jAvopx9F?=
 =?us-ascii?Q?Vyv0GB/0KAojWS3sjV4fY0ZpDMqgLNbXE6SWAhLkaFe+5pAOxBAke2Wojvh4?=
 =?us-ascii?Q?cD8NvLix2mXA+iCLBn78l4fYhCdM1g5jINFt/dj7Jc3pRzYLLJ45eCObYob7?=
 =?us-ascii?Q?ruy+V4ly4pn+SWu2em+M0crVnoh4YMVUBAypCoA75yLqJ8SNpuu9rUOZe60B?=
 =?us-ascii?Q?+Ol4mw6PSQY24qdI/l264+yJlihvY4fHzyAYQ2w+ii7FnOqT+/SAjuFPH8nQ?=
 =?us-ascii?Q?v5L1afcTtTjMVnTxvt5ME9kKLVAeFCKvROf1yop0qZvmKyF6SED4h/CrOf47?=
 =?us-ascii?Q?0EdwXIPY15BoHfy1CuYYKXt43XGkuMR18/YHGSww35Jxy0TYjP/P8ZW0wLLk?=
 =?us-ascii?Q?2p74jgp6GHgsVdKhigE3UCVpXxSwbSWZUksFFtNUcb0+0usJQVuCgCeN0mHh?=
 =?us-ascii?Q?8kYxnFhs4eE51XpHAwx+zZLT8I8J/jxtTIVbECp6SpWUwWRIlaiABi5mg6sh?=
 =?us-ascii?Q?UtgGSd8Vl7bLRoNen+OrYwyg8cxiRyv4TwlRSw5SwuIhUt1+3tpARX5zNx/u?=
 =?us-ascii?Q?kWZEDNZ+IcnhtJP8UtrBZNCO7t+Z9VSzZJv520PJ45IMWh3lA9pDKHRWllhl?=
 =?us-ascii?Q?rmTuA5srYjZ/We0Jj1PX7m9Lbmjju/fxfYVVre8UBOpmFp2GZvda47TPjPcD?=
 =?us-ascii?Q?I9JajJkN2YXbo+1/Jo0xZ6mWeRgIeBoqED8LlDx/cQJWxvUwps/MWCNUHauj?=
 =?us-ascii?Q?bYQTIXud6YSZOGsACB26yReLqwz8Z5qLPChYXsABQW7CfLiswD8jpuVfQNCB?=
 =?us-ascii?Q?npZgAlMqDQmTJmnX34vMepmvEbuEsHpbzyusbwXZGxCDe81V2G8qdBQIoBHD?=
 =?us-ascii?Q?1P2grbD/m5XmYZl+n+lbv71m+22F/CPiAnOJXIdb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec84bdd2-4be3-4501-5c9a-08dd7649a3a7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 03:01:20.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bX/zw8pwwrJd2VjBBf/R4uTHj51MzXAVlC5fqFYXKwdhaQwqwhrGP58Y9zHEE5Twlp3NqTEf37x+SIa41kdL1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536

Add PLL clock lock check for i.MX95 PCIe.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 28 +++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7dcc9d88740d..c1d128ec255d 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -45,6 +45,9 @@
 #define IMX95_PCIE_PHY_GEN_CTRL			0x0
 #define IMX95_PCIE_REF_USE_PAD			BIT(17)
 
+#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
+#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
+
 #define IMX95_PCIE_SS_RW_REG_0			0xf0
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
@@ -479,6 +482,23 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
 		dev_err(dev, "PCIe PLL lock timeout\n");
 }
 
+static int imx95_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
+{
+	u32 val;
+	struct device *dev = imx_pcie->pci->dev;
+
+	if (regmap_read_poll_timeout(imx_pcie->iomuxc_gpr,
+				     IMX95_PCIE_PHY_MPLLA_CTRL, val,
+				     val & IMX95_PCIE_PHY_MPLL_STATE,
+				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
+				     PHY_PLL_LOCK_WAIT_TIMEOUT)) {
+		dev_err(dev, "PCIe PLL lock timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int imx_setup_phy_mpll(struct imx_pcie *imx_pcie)
 {
 	unsigned long phy_rate = 0;
@@ -824,6 +844,8 @@ static int imx95_pcie_core_reset(struct imx_pcie *imx_pcie, bool assert)
 		regmap_read_bypassed(imx_pcie->iomuxc_gpr, IMX95_PCIE_RST_CTRL,
 				     &val);
 		udelay(10);
+	} else {
+		return imx95_pcie_wait_for_phy_pll_lock(imx_pcie);
 	}
 
 	return 0;
@@ -843,11 +865,13 @@ static void imx_pcie_assert_core_reset(struct imx_pcie *imx_pcie)
 
 static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 {
+	int ret = 0;
+
 	reset_control_deassert(imx_pcie->pciephy_reset);
 	reset_control_deassert(imx_pcie->apps_reset);
 
 	if (imx_pcie->drvdata->core_reset)
-		imx_pcie->drvdata->core_reset(imx_pcie, false);
+		ret = imx_pcie->drvdata->core_reset(imx_pcie, false);
 
 	/* Some boards don't have PCIe reset GPIO. */
 	if (imx_pcie->reset_gpiod) {
@@ -857,7 +881,7 @@ static int imx_pcie_deassert_core_reset(struct imx_pcie *imx_pcie)
 		msleep(100);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int imx_pcie_wait_for_speed_change(struct imx_pcie *imx_pcie)
-- 
2.37.1


