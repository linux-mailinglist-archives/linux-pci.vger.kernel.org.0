Return-Path: <linux-pci+bounces-24903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F63A742B6
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 04:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894C417B794
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 03:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B11A1AAA1F;
	Fri, 28 Mar 2025 03:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aYLJ2Cc7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2081.outbound.protection.outlook.com [40.107.241.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C07211283;
	Fri, 28 Mar 2025 03:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743131037; cv=fail; b=gE5/jzVAC3EzbNzYglw1rNdGyTj3Sk/t7fEswEFCkIBGSPBcXNIyTK2HrNQRqyIeAgZkKlrvS5ncOXvSl7pZIi+ZorStOpnP4Kp/ixVK/sXmNCzjbZCPjBYhz+q6fDwZ5MOuSEzw6/q9whgWvIQHN7Y9Xvc4ELn6LC/0Td/T0mo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743131037; c=relaxed/simple;
	bh=Zera0uwG1Hb1henNVOopJ1eIbGG7QpnHa8JqTsRyyZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d3nfNqmOPO578VsjGoz5HirHFY+s+CwrVEepjpcyCExB8+Sj43vWM2FGRxqLKjxQH85HW5KQffuT1cH/Z5/rkFH71hnj/bDADi3bYvXvXH/ccRuiFfO6lm3t1jzE/NHFR2XyKFZ6OrT7VJ4v63jOzdrAXu1vExM+E6b5eBo8VMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aYLJ2Cc7; arc=fail smtp.client-ip=40.107.241.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PGQO74s8xhHjKgkZl/YywX7JnussVlQVAku9KG3I5AeejxOFvrbYOamcp+1Y1IXUzHLRduzIiKONQ+13axz7DtY3OgaqXPSGA2f5MDPWlxQgB/StTz2Lu0o7GpZ/2OzzNBSfXXuGKbv6xC961phu1370T/aEPoggCQXBiEQd1uys0gSfgQ+nwZqvesh4/TsNOxvaJRJMd+fyazIwlqk4sTPDyNl7nAj6WXNXpAeyh0YkNEaJV6PbYCbw9QU0fz1MnpydMsEBWDPA1J+P5Pdyylx1st34P/dygpA23OfUs48n71e0ysArLel5Auu348i52R6e0HP5HYENdCCwm+DDNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZF5VMuyND9VoiyeBcaCL6u7bYuMlrmMIbrnDbkkxEo=;
 b=COHh3DyrtAkk4Tuq7ysIFOr3YH2HvzfxKOTrHcmuMODvtTT2syXcHTDdXeE2tleFKmEFDpvYjsV7wSANA27MX2blXMA/4B5zJQ+smyskFlRJZBE431KeD/nWYKRquDeDwXgwlJ8SxbzkHrcXIkRy8kj6M2gsIuqY/ojLd3xOEEOzKgA+fG3yHPHYZnkGRDpD9EJd1Z7lX+hTzs0tV0GzvlDlxcU65425bpTcIFDYNx27Jo3pX89u0jgRXJ+hP05SUyThjSZrDJ73a/ca9WZj0F9/fYxy1Dw7B+k/qGnPgXjW9Cb6gytRjsD8YRgM2Xk2rgLGvxQkvHQTbuuwZbTzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZF5VMuyND9VoiyeBcaCL6u7bYuMlrmMIbrnDbkkxEo=;
 b=aYLJ2Cc7C7qZT5SpERJSiR7kOF1ANGcrwGU/f3LagCrNOpEmcigtY/gT7hO3xDW24gwL4Ce4HFf3XAhVz3W37Xy6RxzHLsSZw/fK4dhk1JW6+dlgRBXkrK6qpjkPoBPIK9ZTXhw+4qD1m+qi0dlfKppcqpN0zQdKNQg4GVe4K+lP6tsZrEoPTocTBzviz6ftFpj/iCq9JVbviayYwdQMREaE98FABAXqPLD3MWiB7WOIj0bhRltnSHxuW8LcX8c5yPeksxW39boUkFZrSDWFwig9t48UI+MUbk7Bkb2Q5srjT+IsZE3FuACg925sD7739dBHEtOfXB6aAMcNcRpbAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8961.eurprd04.prod.outlook.com (2603:10a6:20b:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 03:03:53 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.043; Fri, 28 Mar 2025
 03:03:53 +0000
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
Subject: [PATCH v3 5/6] PCI: imx6: Add PLL clock lock check for i.MX95 PCIe
Date: Fri, 28 Mar 2025 11:02:12 +0800
Message-Id: <20250328030213.1650990-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:3:18::35) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: f42a12cd-3a24-40d3-66c2-08dd6da52bed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CP3yGYLiinFSDzu6xHC6IFJJTlxCp3ifQhu0K5iZcJ+AmctVxYaRcIcD+U5M?=
 =?us-ascii?Q?rGYCDmtduCls9Pnbr2kg/DedQwt1Naqw7KjzyXlC46Ue0hbu1BN5iPO7tyna?=
 =?us-ascii?Q?R0QXN4sfLA3wdiwSEwC+lXnyRMIu2OB9VU/Dunfe+7ysUZBWgyl3EySp01OK?=
 =?us-ascii?Q?SPka5Nv2d5o+aoqqrqVPZFrCSRe9OMmjfJSDjqpik98mNLBz27yGxy7H439G?=
 =?us-ascii?Q?6NXRQaJTiVkqg3H8XGLs0YQMhtgmh4DX0kX4MmQWd/rif9AfJqsuIQ4RkbU0?=
 =?us-ascii?Q?osIGDV3vxfEwqMK/3ES1M5nK9d57zeiuZ1bZO00X79ced8dMxpxrxhlo6Xq6?=
 =?us-ascii?Q?sHJOkAHtdJkFDcVfgCnkwcdf0AZzDI8nBdvAdDkkPtFKb5WFgMEu8YvhWK0H?=
 =?us-ascii?Q?r1z7vBFVERUMYJcKmbAi7DnyrbLL3KqhHTWP2avAY0a+yB69U8S86FYaj4mu?=
 =?us-ascii?Q?u8WU+guOMSCu62vB185ttr1T+UcFgXeQkCUyWPhAHzW9fPYHQAP3lJvgGd6a?=
 =?us-ascii?Q?m9HxImHuLVrWff54OdjOP4lBDiza13jiSe6IlJPtGFZkxZysiasODihFn/c5?=
 =?us-ascii?Q?gZ3imktiHsLxGS9kv6xNXhvZD7t9rRrMdiX1uLTyArwjbh4XeEN956wXXeGy?=
 =?us-ascii?Q?cUicnqval3uHQbO8/9vx/A4ypdWK8YVbLJje8vQN9rRwe5yG+AwAcxwuYxcc?=
 =?us-ascii?Q?Ixn3WTjCFMq9jx2ADNOKSRhXz7AdwyLlkXEt6r/mWyDGQqXxnaSKKzfAQhou?=
 =?us-ascii?Q?ez2FHobJW51l10nQ5MRH7sE2G00E/QDEL0nqko8NKakExBlMrlEPo7VOSKmU?=
 =?us-ascii?Q?MUgFcn0M5oenDYRIpzNUQ3ji5TUu+cBuGj9cCb/wFD5DkcFujuQ34DIaJqbk?=
 =?us-ascii?Q?PcgqU/WPqyCGYNh2KVKyRqtsx3we+H5guG/2kFL1bGBWGU4GLATaRsaV4Ngc?=
 =?us-ascii?Q?dexFv8ZcED7Aat6/nsOH+hLFqdSWsagxkUxz/U/zfyxqy8VIR2T0lyR+k7Bb?=
 =?us-ascii?Q?yg9vHENf8U88H6dwnmMYjSb/gcQUOymJsa+AkJ8V5ecik/PEc/OXZ56Yb4Xf?=
 =?us-ascii?Q?Hwng1oy8B70sEAtv5rGnKqpHPQZtGj3W6JvGmQAuH2JFTFozMcKJZq2bM0+q?=
 =?us-ascii?Q?0XyKPsldS2xX+03ioeF5n1EwU5MYrbcEacEOTnciIrGBQzQIFf4EhKAIWQnw?=
 =?us-ascii?Q?ZRwuhCFyawuEbtZCN2030KUTE1RbSWejcPL4oo5osX7jFMlp+xbueoCcibJb?=
 =?us-ascii?Q?x5pXp+u2Qb9PcnE6KEZf/zsA2/OZ1kcdu+bWzFfQPLJHeI9UC3S46fqKHc+X?=
 =?us-ascii?Q?+GkTuKn81+CxKPlnD/mAZQN70xCOSqTZxBpyG/ZKfnTptWfq03oEtZVP0xKC?=
 =?us-ascii?Q?svgn1sLw6A8hxpP5DDDKkG+uW6zPGAxk1hkTFNXMVRvqKdM5fBfn8c35S0Al?=
 =?us-ascii?Q?dRGEVs53DdKZKNhQbpG2UfZ7fLsGOZ7AiHBddoxo3Wt4JIhSuzU1lg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NeggUbJqeGbi9DUy5emLpFdvFcrxXlPCuBi0CgHHyfkfnDPNi5Ifnuy5dWlx?=
 =?us-ascii?Q?3w/UdjJFP4dOTSNxY1awllIiv29iy0XMj2y8fy6L94kQHxhhGxCvZUkKJrhc?=
 =?us-ascii?Q?5+CMisg4pyQC541lKcDcVB9n1/RNa86fEQEtu/umRxGGw4/nZnssaGQFeW4A?=
 =?us-ascii?Q?9Gk0ygfMeXO/4Ao2M//BI7i3bWLLNv7bHMEr1VcZxhMM2vRwzGLfbr2HmJHg?=
 =?us-ascii?Q?Yj/cUJpTPHra4BDHcfYF6UO0JgZn21GDATIFRg6t1VYrQ/FMcWjX9RUhp4lF?=
 =?us-ascii?Q?dis/MUx7YcJeVJ5RRIxtH11j1M9jSnfIvAoV4V3aPtyvUFt6KaN+kxVosVdB?=
 =?us-ascii?Q?ljbRQ6Qyw/tyqxaJpCQpcQImkMCvegYXliBTPjN6C+v6GclJNLygkOcmkg2Q?=
 =?us-ascii?Q?RQNxLmrqxkfBOdkoyhkJxd58U6pn6MjZLIhgNuE9R9lY9OuhoAAzvauCRL/F?=
 =?us-ascii?Q?bzcoUa8mUSWfQ5r2O6aRh6YlEVujIRdz3WspRb9zoPMva2XNJmF4W2+fuEnK?=
 =?us-ascii?Q?XnEmeQnEztClcX7KD4d+y6AZVd3Lnb/vpmEkoHhr53k6Xhac+SNN+DzZ2X5V?=
 =?us-ascii?Q?8S/1sU+q43/gNSt2WHOghlSLuDPZ9fbIcq7+cP+5bXRuLJpCbpqnSYv40MpV?=
 =?us-ascii?Q?IsjQvfVKFzVPuNU5ol11Ah0TyKowbAI/vEL3KVQA6YgTopSz9Cl3OvbS5t4t?=
 =?us-ascii?Q?8IsIwd6YZX6CagiXPemfaggBAppWldAENPUNvQLphYzV8R03YGtoweElBS1P?=
 =?us-ascii?Q?vBP7pnsrCX907CmGL+3NQyOckl5YI85gStDIrk3L9NQOfPM05Zqx3DvSq04P?=
 =?us-ascii?Q?7+h8d6NPzImhl4IGcqNnoJap4WKcsMjTXj9F75esadmA7YFsD/iFp9Y8RUif?=
 =?us-ascii?Q?wayxDqFCHz/NZYPEXkGx3UYQqm3Y+3mydH0H5XLHPS/XNDFaR7DshOjjAg0j?=
 =?us-ascii?Q?w1Q6if8Ko/TfzsAK7oI+kkkStUqUhYJ9TKZ7GDj/F53gYY5e5N/ObG9Vphsm?=
 =?us-ascii?Q?D/UoVCVdGYkW9sKx1nWb24KSQ/+egrPvxtTmWfqXL2jTZd/XhEIfE70uKTaK?=
 =?us-ascii?Q?78JCaJv8sb5hvirfDC+gzCiSRUm2BgkPjSN+G2fouG1m/smADau2EXU0/O/C?=
 =?us-ascii?Q?IfG5N5XI/CshONihMtFAa6HGzr2EU/JaJpwZMR+NhZzPjSUAC3HZCvRmFfBE?=
 =?us-ascii?Q?73u4y6YgkK9UA5BHPU741h5KibM5PStiEonk9PUfmc8HUUqO0Z6mJnXrP5lT?=
 =?us-ascii?Q?m6ButOknfIAlDI41RTXGLb+CaDFlunH69t2CO0MhxXsKcZmuLl13Ju4pVPvt?=
 =?us-ascii?Q?061TL0qWQkWCTkUvfSgEjmNcvDLcbjwJJUyJ8/D3P2XL5/Oe2ME4tnGTJKSf?=
 =?us-ascii?Q?4Tk6tDc5qLW5wCRKtuBauJVsd8B3pbA5hj3IpZlgXPVXGgYVBxeweYPqeHq2?=
 =?us-ascii?Q?EtUkf/BBif4Iv+Zjd8Qk6FL48ZA3p7eJEqYhJpm8/eFzdXj13nEYMx0TrWun?=
 =?us-ascii?Q?ARR44QIZmA4amIjcihK8Gxx5xYg0FAf7uWe19pQ/W44Pn5OspTbGnYIYugTA?=
 =?us-ascii?Q?UqvL2Cbmc4X/vP4qXly7Q6SyXdpg6TcsR7+dapj+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42a12cd-3a24-40d3-66c2-08dd6da52bed
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 03:03:53.2523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWkGyoAwJuT3C2oEbuMar+l2+sEK+vIRtuorpKyMr8VG67mPIT/j210iADAtGBB6hqPXDrm+KiDmQnZzgKM/WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8961

Add PLL clock lock check for i.MX95 PCIe.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 28 +++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 35194b543551..40eeb02ffb5d 100644
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
+		return -ENODEV;
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


