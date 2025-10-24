Return-Path: <linux-pci+bounces-39226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 269F7C04289
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C66E1A66CEE
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C399267B94;
	Fri, 24 Oct 2025 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TY4gKcgR"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4B725F7A7;
	Fri, 24 Oct 2025 02:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761273694; cv=fail; b=qrtxg+/wlgzZfA8HBk6SkcJx0vg65wD3Y3xL/ZuUMoKFZ+l8bcizqNg+TFz98p2c56RfLd4dN0ihR1uf8Mc0xmxKj2zzhPS8lJz2gRASM3AoGJxTtEVMByPZ3s70gR41+7xWSEMbBGxrIsMd5LsTfPwIkZ8LPCxkp2tEDouOpLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761273694; c=relaxed/simple;
	bh=tH3Al9/IOLOBZtwdhFd422qIFvIRx6zzICWuPwP0jdU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gd8U0gFyNF4/76w0j8PoHLU5yYJoBlqzTglJs3BvSZIHGuQZeFNhP88VPIpv8/IrI5OztUQIBXy7wlI5axUkMsUhcJPHthiBkC+TjNE7YKw3LvsFtYILfCfPOpYYv4+Tb2pV8UMe40wOPT3uPH5c1BuM4vKr2rGIZSM3k/zISh4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TY4gKcgR; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clhDvwNHQHZ5Qr4vi5WEjKdXL+3y2TJA9ez++Gw1qS1+R1a4KJpgunj7DYYT7DGPPtKUl1TvLB+82PQ1N0/pSgs5j2JoQfpqyUzJHdkPxdJdd5XXZ4UiN7YN7gTP49dm+uor/31eYFxoC6MfgFYlZDNDpYTE3Gy5Cr7+LK+Vrv7UPdW0PpDlp8tHWKU/876XfvJJiaqUg/qn7rEXxCSwN2+x9blK4b644K8zyBa9rb4mJVxSm8ALaD5Eh0PtUhhqlMFCwKzqxx4Bt0UcHLI+ILo4jWfUMNWF72+kCnzbRhIuuvsy7LRVKgHsRZhbut/fU+HnH8BhDNYJcoFN9j3kHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhY9UbUaPop72UIkfNE6Y0DQW2KPGAyjra9Snj9z5nU=;
 b=kiyOljRTdBsR2gFsUppYUlghLCgTeu/f2IsXIJgtNY7Wstk1VNvK0YRDB7uoI3ypwHgnh5wRUZ8RlVLxhccD5tTcEQLRDk4K1+kzrewKDrgCkzD4nkfLKYJ+u/Q+yqa2sbzEGat/Bxr/Iphk7/c3+d20LkuES2HqLTwejmyyMHdVTojEYf5zsOCai96LaMz/ehUheArX3RGX47RCZv7wOw0622bGEC0y39PXXD6Mg7Lp5HeeR1aTslyatCbi5f5RTgA6fvFr8SGG4oJ08xuv1G+H5kN1/M+xR6uXaVqj6Hi8L0RrffY6Xi6ESeUPjS/Yyo1Rs5UFBe9d7/ee4tejNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhY9UbUaPop72UIkfNE6Y0DQW2KPGAyjra9Snj9z5nU=;
 b=TY4gKcgRWa4MrhZQUNl/mvUiKT1NTH1cTfBIpk7r4QDaBWkELXrBpysbIs919KPPJJ7a2jtzfXO084Z8M2xprstTKCh+MmJXqBv8bG7BKMevD+eWJskI/N1qDyiUBOI2xCiFK+axt817MLH52LgKFo6ietmdb7KEbLLCXDB3k5+aOBoAvhTjdgsrbxGBn1d3IuhVCUkAmcwaYx8cGwuaX9GAc593CH49Po1+eC+NFBi/YGiUujg6gg5ZAwtKNZgnsb1EWA+RzZZE5k9hdxqxjJDPtY0SA8JXyJiwd4Qd5xg29DIowv0gLkNSv66FzihMBgugtUJtk+2BP9lOBOekIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU4PR04MB10624.eurprd04.prod.outlook.com (2603:10a6:10:592::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 02:41:29 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 02:41:29 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
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
Subject: [PATCH v8 3/3] PCI: imx6: Add external reference clock input mode support
Date: Fri, 24 Oct 2025 10:40:13 +0800
Message-Id: <20251024024013.775836-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251024024013.775836-1-hongxing.zhu@nxp.com>
References: <20251024024013.775836-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::20)
 To AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DU4PR04MB10624:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b3bdb9-a28f-4208-f125-08de12a6d396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k+NOyBw0nlACenFVivTrgGjmfMO3TuRTJVggViKy7mkbke9+9B4mgFBA+SU9?=
 =?us-ascii?Q?319MHldKioQX+npGkkPVi4Meox6hsE53/HfJYlUoTnxupvVrkfuvfefPN9lm?=
 =?us-ascii?Q?v3eVA0vwQ4uQ/JvV96PDwhjenRkTgZVdWTuptSuspneBSRKKcyb9lNzdCcaH?=
 =?us-ascii?Q?Bp/PNWBezstQjemlsVuFFvnlgtkmeBLHuk2LNgfQue1tcJ6e/loWSXojpsqX?=
 =?us-ascii?Q?zJu93qAjzTL8xZgOozzCD5iUZ2epfJkJ80YXz1a/wLl9oatHBZHFfK/9fe+r?=
 =?us-ascii?Q?BkTq4O4x5/iFlkQI74RrZBr4tz0YCbiw/k0IQG5MlvSWCqgnD8fOiDC1WmKp?=
 =?us-ascii?Q?SMSEtzbDoiAGCJfjC4NrpAg9vEUDGFlg6SJNnFuASjmaBeJoZxUeaX3LcpS5?=
 =?us-ascii?Q?RDmEToQBuc7btHq3UMjt6Y/X/JqFCzdxt181dYW8hP21JhK0hI3xJDxq/a3S?=
 =?us-ascii?Q?9d8BIegw+iJqyIADl2/rQKb85ZRmSOqKQJw5l/0QjG7uj94cJwegsPawiehQ?=
 =?us-ascii?Q?4SdqxJ6zp1dhmuZZEgbS9q5kmmUDnvYufYqV93nUQjo4drsDMJzjVnH+1j3Q?=
 =?us-ascii?Q?T0v2Kodn+TRrYNi0GQ+PzskTTgyMxRNmIVaja5UjvADB6BDb0iE48W686H/8?=
 =?us-ascii?Q?cXIG6WCLx0KUPV7ygqTH0OsCbS3cvmHbThmj5JsMkfvEGhql8luLxjN0NuIR?=
 =?us-ascii?Q?Qp5yZnxFOfKk0rfQ/Hu5hdHm1LI7YokYLRKZTc1/Oy+crSDrlQwyFdJ6RuRR?=
 =?us-ascii?Q?BknvyrXDMJfkI4itHm3NLEDvxArP/4HPfgD057BzwWkqF1i5cypqXau9CZEv?=
 =?us-ascii?Q?/UfRxx+mNoqWfoMSBFQPEdPs2m3oubamMckgu+8tsFMekEIKkkXV9oAWD4CH?=
 =?us-ascii?Q?k1ZYo2HsmvZDC15+nWrEFrwFaTEZ9oOERJLafJNaaDUXn4+y3/QQzZ+iPHR4?=
 =?us-ascii?Q?pxYkNYhKmlLAtiXIY08eE/2QkjorFuFHNsRI9UJlINgeawLy4EQHC/5HNcTd?=
 =?us-ascii?Q?OnCPnhhTXbdqyVqEX4cF0qGFYpAuwpuBaGuqUnQC9I6oL4Ytew4nWrhY/UtU?=
 =?us-ascii?Q?dJguywyxaLYjq4eSpZPAbalnNvwY+q7cCI+ZrpeBZGpEvgnAknMW3gBNK+Vw?=
 =?us-ascii?Q?GeE0Ea4MG+BXS8XMP7TFPHR7xJU0021xjrq2SVoyxKs//ybhqYJUSnpiMX53?=
 =?us-ascii?Q?kw+CNKiueXMkv+oxFeQymE8A2sKLm2R93E+BPAn7szPyKCj6raT7zdyxYsAg?=
 =?us-ascii?Q?jTBKvKBYwNVnDNlSDcOO1/jXAEHHhvFlVPOYXXSsj3e9HwVwS2H4KVYDECwv?=
 =?us-ascii?Q?55N1i9xjjwbB5t1V7wI9GqRZ5xhXzkS1vUzEuNzLGfqWu/fNRLpDnlW6kN2S?=
 =?us-ascii?Q?loScVc2QxOi8P5eEHqmVUioVnNHedYGJ6bNlAKaHnGHFbyucwXx3kfdYmJIT?=
 =?us-ascii?Q?im1krCORrH0Zd/FbFfde8a5ZG62prCb2WGGCV1x3vYq5bXRgE1Tnpijj3iyJ?=
 =?us-ascii?Q?ICoc2E08pv68kNA0DKGmtwFmlBKsjIoDX/+oBDGPLUib+aZgUdyLGl62FQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KRaWw3RMlUMCLLxRyr22/1XtZ+0OVDlOUBr6NwKFRe5qyErlRpnAnfF4akpD?=
 =?us-ascii?Q?WXNo+jQa5lqknyxMP7xQG/+RV+ZzcZblF5CnS1OWVdvF7xwfEJI5la7yGJ4W?=
 =?us-ascii?Q?5O5q/xMZoJfmw4NFEj16WNt0lKrYaTbpSG4rkiFFI6KnqRlvNocKTbW7jtCq?=
 =?us-ascii?Q?/59VQtOrt6eS5mNKYwAFFdN9t+Nl3AMbVrXt8vFIApw20NttTDCWZpJeqHWH?=
 =?us-ascii?Q?Fix59B97yDVklbxu0dz2JZ1KiqTOpVyeTl6CKLR4KyzN5i/Qyx0+GU6o/Ndo?=
 =?us-ascii?Q?I0Y2YKP9ZgmX8ZLRUS+xUY0oe402Kf0p3ah1xtYVGC641moAiVU0DWl+0JBQ?=
 =?us-ascii?Q?fcwuJ1U+NH6pmgSD3juTroCk+6djwonn+HkB8pmhPSIhnnxbwrnB/rDGiWWy?=
 =?us-ascii?Q?T5HL4U8Pz4xRKTppK5Ny4X54uhaaPkJgliN7pZIuha52Zucn95gOlPwnm3Db?=
 =?us-ascii?Q?EJqtVgRXRq7px2TNzcfqfIzzGprc+fFHiLxm9y6ErhtFH/reG1aqDQrap9OJ?=
 =?us-ascii?Q?B8Azh5QUqAcEESFgd/BBkTLzpFcHm46UCNptb/kA4QlGPDm+7eOnnvU81lCQ?=
 =?us-ascii?Q?9Vtvzi6PvZXx2xXe2BQaOgfWCci5sDtT7buepuyVkLUJ7eome2pStLkPs4ud?=
 =?us-ascii?Q?F4ExVhY3zChv5uv1oDM9OGwBZRKDxBACTuueFQcfC0/G+772JMSAwlDq19uM?=
 =?us-ascii?Q?RSgQZUzgZsGOINQcpwbd7L4EO+urK+oidY+aeLv6i3NSyaqa2+Y7f1QH/iLE?=
 =?us-ascii?Q?ZiwGS1nS4ub0+h4WoV9Ujs52EltGOJ/wn11xuCVCMZqq6mAEeS1GjQhlYjmc?=
 =?us-ascii?Q?DGHexdLsh/9B44jdTvsM73+Fq1pXE2Pw/lVOdJ0ZBrcqJ0QyrYav+3LD+Lss?=
 =?us-ascii?Q?LKYrs5EhckfzJdwsot9xZskYWih4qLzc0fZr+Ge5YTydpYUH8V+/jId1C5WV?=
 =?us-ascii?Q?uSPMB2Uz+wv2jONfLuJEbB66jra1byS2XePbjviQ93A7xOVk28+iI8IgpXqY?=
 =?us-ascii?Q?f2MyFAyfnzN/dL7dCM4POf/qvGLabAJzz5Yxhh03Iu5DgxWFMG7C4nrkiePE?=
 =?us-ascii?Q?ryzeK9DZF4YxqLLq4lzeO4s3/KwDYwcTDF9EF3tFnuBWwuCfE4hPAjGHGjhM?=
 =?us-ascii?Q?4H9zgl70aZo7t/bHaKAp/W7SbnSNU6N3b0O//VmIpqnbPMjiZj1D+Zu+8x+T?=
 =?us-ascii?Q?2Ls5y4b4YSXJ0IXLB1Bwo0ODJAX0owAK6KPglZkEK421EDnYy7WEjPNS+r7z?=
 =?us-ascii?Q?bj9slHgurAOHKFSlMyCkpv4Jdcldn0wHLmhRMv57SEjD1t1WacmKDSzrnsx5?=
 =?us-ascii?Q?qH8feXffQyxMS0CI1mM2/F7ds8i/yHXYl1E4mTH4bwDhU7cwxNGeucbsI8pw?=
 =?us-ascii?Q?eR3PkABsq0pRT9eYbMBFgaXyKievioaQ55Trr7NUTgevhqMLP2LXXuPgvICq?=
 =?us-ascii?Q?3RsBree5OoAdc5rWEDHX+tE+Jw13GkMKVENtuSTBgVP8ImOELN4/CL1GFON+?=
 =?us-ascii?Q?tHzREI078QtQn3nmjh+RzTJ+LVfuetPsknBl9esvEv2vxF8wm5tQbMNl0ADm?=
 =?us-ascii?Q?sVvfghF7V1UztX0eyx5SHIQDKwVOHsscGOJKAmey?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b3bdb9-a28f-4208-f125-08de12a6d396
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 02:41:28.4272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozOnkxcJBSMrzkgWj/nLVegA2UQqXUOwHkI1gtzybBlQyAyJ5Iouq7ntb7dj5XkvywbKImTCI85kstsvdpRHgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10624

i.MX95 PCIes have two reference clock inputs: one from internal PLL, the
other from off chip crystal oscillator. The "extref" clock refers to a
reference clock from an external crystal oscillator.

Add external reference clock input mode support for i.MX95 PCIes.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4668fc9648bff..a6db1f0f73c36 100644
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
@@ -1602,7 +1604,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	struct imx_pcie *imx_pcie;
 	struct device_node *np;
 	struct device_node *node = dev->of_node;
-	int ret, domain;
+	int i, ret, domain;
 	u16 val;
 
 	imx_pcie = devm_kzalloc(dev, sizeof(*imx_pcie), GFP_KERNEL);
@@ -1653,6 +1655,9 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (imx_pcie->num_clks < 0)
 		return dev_err_probe(dev, imx_pcie->num_clks,
 				     "failed to get clocks\n");
+	for (i = 0; i < imx_pcie->num_clks; i++)
+		if (strncmp(imx_pcie->clks[i].id, "extref", 6) == 0)
+			imx_pcie->enable_ext_refclk = true;
 
 	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {
 		imx_pcie->phy = devm_phy_get(dev, "pcie-phy");
-- 
2.37.1


