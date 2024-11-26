Return-Path: <linux-pci+bounces-17327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1DD9D92FA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 09:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A56E165D19
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC89B1CEE8A;
	Tue, 26 Nov 2024 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="emvWivAo"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011012.outbound.protection.outlook.com [52.101.70.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7071ABED8;
	Tue, 26 Nov 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607937; cv=fail; b=gKoZP4xVGl6+L1OEiAtx9UZlhmQ9c6pR+noNEa9I6JexTBWiaF44qKaj+dsicqYyzYug/BTFZCU33PNf+W6VaKAJVM8A9aEBortWRl8SsMBzIeLGBWUSKE9wFIWmaKl1gQVIqMscPw1UyvqP38myuK1BSg4jX99LGV0yMDpTV1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607937; c=relaxed/simple;
	bh=ZPpQAT3cu/Vn7+KUmJEZQv2hQAxAlwkqQq6y0hffUs4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XO/U5QC6DeOFD+hFGfyzHYzfaZnpbh8nWz+VRWdwYNVYJbQbcj139sA7CVxOWPzcI1GwQwrgHmQBhr4mWjD/fSjAS1Cner5KzkCurWmOEh2vSiVTODnNO6MqlKI5d5P6mItynB3bthYxyXsrL0/j1S1g7tpUBHcy7I5eiZQPZ3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=emvWivAo; arc=fail smtp.client-ip=52.101.70.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYsWZVLKG+unLiB5FRFIQ9vB/ApOw6Zc7NySS836aDdwnmdo/swbj/zIOtUAOSzEpqsCspcFeyEXmtpZ5WPb2y9KjmYUWN/ac5VueTrvqycwGrp9xOIzgVY43KvIeshvQqBQHWMpg5zIzD5uRstcU+Z//TetAtwWTqPWLv26h3/N2eDZm5KCjYQt9IL+amzVCaU+RHlnRPn/oSL6TUg8Mmqd+AVulJ2KKT09C3REdiD7a4iElbmuqe1WVfBNFxpjLClHb3mS/EePNCGKbE4yxcqAgVcDdUcs3FsNiL2tU7x/4izMbpVHX8ez82LFN0Sv+EwIbp8avwo2FJp/HlEtDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGLz3HynYw6TOgvpjS3u3DsAamlDcAkH/ZsSrZWh6/o=;
 b=hEauDj67USTtvcl3WOnPJ7crTeHU2pj+0KSXj62nDanH6TqCj6srigAlL0NlH38u1A8gKHC+CShfk73tVe6ZeDKBBIkQeGJQK23jRjzqwVYk9kzZbndn2TFbeRExb0reWuOQ2GrpZYvo2zke6aOSZjp4lzCI/QMmS87q5roJF3f3iNDHrvOAROJGYwnq43k/Th5hgHGs0Z0WprrAUrNQb5rOrKGhKj+dHAYRpXW6pIFY0+d5yppBqnSRE+a4UCTS58qJVwSzcsYeNxzi7xnEu/m0k0glLQBcjq0e/l3D7KAuiJ6OWqiQruuxt3jmyv0Nu41uMnAhXwZ20yGBySxK3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGLz3HynYw6TOgvpjS3u3DsAamlDcAkH/ZsSrZWh6/o=;
 b=emvWivAoLuMRtkEzW5Sg2HUOlCPeI9shR33uGNTn/WnNYFdYylZoYq0hq6P8p+jiWx3j0QwUnLAVFrIiP8NZ3F8RruK/1ziPKoqhMskm1ocFDASaYjRBJpmnlYp/BNEQ1S6YQm+GCpisxsjx/EKRl4u4P+nw8o8GUlvhgoCn5t4zm4zWb3Zb55dxI2E9MDzlEuSxq+0lQEzjkq6cNzDsO8O9Nftvz7ZQ/5fpqKDTBYSvQaeHD15FVeE3QhIl/9m7GUgmPCWiJzjqAoDfS3pCHvxd15FsVskGLWrD4T00qqeZLtfuNAD0tDLghUDb6FBqjQVWlMEpxPLtJLWanUZ1Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 07:58:53 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:58:53 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 10/10] arm64: dts: imx95: Add ref clock for i.MX95 PCIe
Date: Tue, 26 Nov 2024 15:57:02 +0800
Message-Id: <20241126075702.4099164-11-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: cfe12062-92fc-408c-f6db-08dd0df02b48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IwaK9qZj3VAfHueOyvbpjhB3ASgft09gGWn3S9ZzdXPC84pk7E9OU99CYB1l?=
 =?us-ascii?Q?7eFOJVCp9Rl6TgParsAimxLs0zfK3N6Y+c1Q7aUgbpgKC1XNMnhFz1dQFaUa?=
 =?us-ascii?Q?6s9nlVaBR1F3js3C2rv/DL5EyNi+Wy8qfpDm5v6TlDR9Anz6QqkizwKWwUgU?=
 =?us-ascii?Q?GS4FI3dukKR4egzeLjd6rsi9VlwI1annVF4IYpZ47pkWhpGRFxR2zfNynzMv?=
 =?us-ascii?Q?G2ofGiNcWQPgsq+U3h7g+pIyqWGWrNbn32Tkaw2D2d5gYeIwO3k0bifZFBeR?=
 =?us-ascii?Q?wlr0F0PZNdtQF0MZYspU2bN2ruCdzY9SgGfS//Ck5HGvOYHgqq2ywx1aFnqJ?=
 =?us-ascii?Q?les/V46TqFVzkEFBFRFjrE7JgshCTyL04ddYJAj88f4keVInnl9GMsudK5EI?=
 =?us-ascii?Q?gwZPHPftan5kPAc1VDFActZBuCmYxSmoPpy9vUx0HtyuKxDdLqH3cEuOhuHj?=
 =?us-ascii?Q?16GhJLSqUKGUwOgZdM8g+RHzPYqZu3nbQtOkjT3sEij/l8nlglyDaqltGK3s?=
 =?us-ascii?Q?OpSbo+DfBexTnHv0UjylkePQW65L1uCxswz0FDUwrfloQvgp0YTLGnui/3w+?=
 =?us-ascii?Q?xNy8Ky5PWD8jmqPKc7rc3SsG28FeQydSBuOhxno1aJ/lgj50x6OcOBKoRcup?=
 =?us-ascii?Q?fb5LURsTHKNwJK1KjFhMcXyDQdrClsbbe5/lKGknWDgSDse9ZzO7o2h5pvGo?=
 =?us-ascii?Q?sRTt9j6Zlgk3UHVPTy20lbg4NKkwI8cVUhUDX+65HjfjsJLmb6jfUsqpaFzO?=
 =?us-ascii?Q?uYUCbNzK5SipUb3XADKQynVtT5yJGi8FEgrffyxjBFTBCWYtOGDMetLjIJ0I?=
 =?us-ascii?Q?+gF3PVctmcaNxxdP9ev4hvCKLWjeeNRItUH7sIqxmH5MaQmW+v+FV83pn0uF?=
 =?us-ascii?Q?1zZ2IGCmyzK7pSGKvANW3/7fl12k7vQLB31o64nToHYeqWrT29cPAJzrNydd?=
 =?us-ascii?Q?nnM9zVI7AJcdI99MrgeXI8Pd1v7hbfHFbHdM84DxekUIgw4EFmY0Gwy8jK8P?=
 =?us-ascii?Q?ZfC6hV0Z/CWJcQveFmwfI6VoBe4EQ5o/ho1izlJgc4puhW1CNNZMMpZ8RN6g?=
 =?us-ascii?Q?97eKyUSKtnukHik0WMhOBy747ZsI2gGmaZwKzFEw63tUVUfZKL0WqXZMCUqD?=
 =?us-ascii?Q?nf0xnRBbHvjVrcPWbF0IhqL9Ehk4lk1o0fdPCStGvKGsIW13rKKrGSpB2GFj?=
 =?us-ascii?Q?EP12OHSNzHBBHAT/qDeAstpWPbuMyurJvdZHcEBvtsvCqXjFx5oqbjZR/UtX?=
 =?us-ascii?Q?EuRhJMQpGyVVY5KVVx/r9/uxG0cbPH+0CG4qcqVKuZCfJyAmSFtUCO4ws+Sj?=
 =?us-ascii?Q?IZOLgFZ0LXSCuA3djgiK6NNGbRkgSPdwB1gusTZZca/CMFZzB5gO7S5TEIzZ?=
 =?us-ascii?Q?yx/rZ4Q69Yt7MOXjnJ/I79y84QzIWsR0CxnFbMo7SN/z+5T5VPnsBcquLfKw?=
 =?us-ascii?Q?B5X+GRl5R4o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fH08ZeeIUg7XCYYfrAmehuTGT1k7+3kQT4M/tNSBI9TkpFXXcYjS+ADsd/lu?=
 =?us-ascii?Q?FtCmw4n0QM24DZIzcXoi9NXaeI/3bQGOlW0+BUYF6CtsufBxDy+iMdRuXwdK?=
 =?us-ascii?Q?4Blh4BKrH11m2yLZupmFd8BOqSJesE9q1SPaltMibupZHl3XhhxGGYbbmzhN?=
 =?us-ascii?Q?+GpdXy/iLXnTFjwKPjizmTnvSyHHCA9Kuh/I5dw3gfp95qZqEiJz1uCgjiqX?=
 =?us-ascii?Q?Moi3NLlnq57aBuCY5aSu9PaoN7OQdfx11IciLlPColF/wDCZB9eDG9xbj7eY?=
 =?us-ascii?Q?9cod35g6Q0/LtffS3d74IQM/r0KBG4QaOfftTAbSX/SFyW5A6YA1ykk0YlTX?=
 =?us-ascii?Q?6qKV/ZgEYO4BJ3fYriUztemCqZivfLzO7v/sRTLxy08mZ4+87UreaSIj2XLC?=
 =?us-ascii?Q?tVvmd1r4xbOEUm8z3v6cc6cUGIWOcDkCsPBoAeMVd6GVLDzloQbQL5rQlnQJ?=
 =?us-ascii?Q?/qy0ctw+1/Z0wVFlSj19nd9UqMXLd3x1ZdQHto1ax3QwheG86Zai0LRBtV0Y?=
 =?us-ascii?Q?INTbPKKBi/hl+IDn2cqKWysmr12FZ5TYjAshaatyApocA2kFJtCUI68K/7Z3?=
 =?us-ascii?Q?emDo+7MuhR0Ei4dpUc6EHGpmF+Dt19Afx0VaNLSLKcmjdq9Nf2flcyP+sTYi?=
 =?us-ascii?Q?xmQNXR49ejcJV9xlyub3L8IuUeKC0IFlQYn1KWnbhYtVoc3pcX21APHO4HzA?=
 =?us-ascii?Q?WvTdyYbyD4eyqU97rqPUbDvH6Z/IHvH0BOr8hjnTwwYs/grPajLH/4Qzp2/n?=
 =?us-ascii?Q?FlkVLugbAstREeHl7l0hODVmc3Re7GJOwwZQllH2eIOxx9BObxspNBCn4ryy?=
 =?us-ascii?Q?AU5ytHluVKIhvMqHRDPj+/BwswsDaYwhfLRgbo5eDVLndkC7pR8v5qaf1km0?=
 =?us-ascii?Q?Vh/10uHyS72xMctPlrGyQddATVNAoXSGliv+pQgVHrrKG+yzAvrT1mq8+LlE?=
 =?us-ascii?Q?15gHhR/iWZnnIQKeZj5FEpw5zF8UfL+1uSsI4cja9txwxQ6dsR11UoYjzKT8?=
 =?us-ascii?Q?+ZnsiV/Tx7x+Cje7+doMxJYz0NaGP1ZRYjAu0NrvrmcfNRWtNrNXTc1C1Jdq?=
 =?us-ascii?Q?82cDivhlcZ46yjOxSDCztwwdogJm61wLZ+FGai48yYSlbMs24o0Fm+cZoDiW?=
 =?us-ascii?Q?v2UbqIM/sLuIGyTRCg1yYz6YKj/scOXeIPQA7geYystuutIeO0uoiKQRP9MB?=
 =?us-ascii?Q?3YAjcHX0V43tEcn2mDtfK5uWxflO4MasD3sU25WtRGk/nZoz8tXdKQ8gegR5?=
 =?us-ascii?Q?hpoUm0Dldf2jd1JB3So0OjhHsF1jUgigKAH2PiuHmu23bA0Vj7FRi+mBC333?=
 =?us-ascii?Q?ginOm6L7c1FJR6SoX4Jqdf0eTomqHSjy94w//OsekVUzxISdJqgFR+3ihH/U?=
 =?us-ascii?Q?ga9/tpXJizV4TeirMbQbGfZ4aFjPciDIR39EtDKPaQY6ii7jKdpRGFJ01Xfi?=
 =?us-ascii?Q?intixFDbF7xvhWXezeFrwdKmFb6rAaRglarfo1pL2VNUGRcDEJdZRrYeEbD+?=
 =?us-ascii?Q?bE4xx9DkRguFsJ4ySP8CH91UNA8w3+FsMUxjtr7d3W3E9Z16SMUDgxErL18m?=
 =?us-ascii?Q?VQ7Yv+w7JxHvOsWfPisI9dfyxbt/d7zEz9qOlmiR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe12062-92fc-408c-f6db-08dd0df02b48
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:58:53.0345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jdXS9AZ6nINIUjJcRLmNbVAcNw6BFUIqMTZW9oodZ2M/YbVsIvWNnUGe96wnMr63V+ML7OA0HVctv7WGZewHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

Add ref clock for i.MX95 PCIe here, when the internal PLL is used as
PCIe reference clock.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95.dtsi | 25 ++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 03661e76550f..9951d2c84799 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -236,6 +236,13 @@ clk_ext1: clock-ext1 {
 		clock-output-names = "clk_ext1";
 	};
 
+	clk_sys100m: clock-sys100m {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000>;
+		clock-output-names = "clk_sys100m";
+	};
+
 	sai1_mclk: clock-sai-mclk1 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -1473,6 +1480,14 @@ smmu: iommu@490d0000 {
 			};
 		};
 
+		hsio_blk_ctl: syscon@4c0100c0 {
+			compatible = "nxp,imx95-hsio-blk-ctl", "syscon";
+			reg = <0x0 0x4c0100c0 0x0 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk_sys100m>;
+			power-domains = <&scmi_devpd IMX95_PD_HSIO_TOP>;
+		};
+
 		pcie0: pcie@4c300000 {
 			compatible = "fsl,imx95-pcie";
 			reg = <0 0x4c300000 0 0x10000>,
@@ -1500,8 +1515,9 @@ pcie0: pcie@4c300000 {
 			clocks = <&scmi_clk IMX95_CLK_HSIO>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
 			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
 					 <&scmi_clk IMX95_CLK_HSIOPLL>,
 					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
@@ -1567,8 +1583,9 @@ pcie1: pcie@4c380000 {
 			clocks = <&scmi_clk IMX95_CLK_HSIO>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL>,
 				 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+				 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
+				 <&hsio_blk_ctl 0>;
+			clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
 			assigned-clocks =<&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
 					 <&scmi_clk IMX95_CLK_HSIOPLL>,
 					 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-- 
2.37.1


