Return-Path: <linux-pci+bounces-42933-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59E3DCB4EE8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 07:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86697303D330
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 06:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4375B2BD582;
	Thu, 11 Dec 2025 06:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NwJ0HOcF"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED42989B5;
	Thu, 11 Dec 2025 06:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765435763; cv=fail; b=ZHVEhjsG41mAMDW+MC7q4lOe5Iq96buzmAKJicGZrA7hWjsAchE9iGK+Ust9LUHSlDmEb3PHpDHZscGIVd/YLjt2BFrQjgnKYlEZaXzVnmRxwCtM+sH+hdZzkroQGmu7N4iEw2NfxVufKO84bx/0DmyQ+P7UclgbsJE1USV1QTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765435763; c=relaxed/simple;
	bh=S3WsOY5JL8RfSWYjPBHpnrRJngncHHu2bPebEvALu3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ey1lh8s/WTXkXjC2IAcHr4VvhrzwiELyjEA37KEZ92zBxMz+M/Ix5J+hX05NKnpTCOji6hN5ZnapXW8xdK2Vy9Ju9sv3l/m5/HtM8dqLsG48fUz/d/mqU97g22ghoH7y8z/Z2xQt76JEokrNbzRFGNSi5ddX9LAYDB9Lfsc5F2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NwJ0HOcF; arc=fail smtp.client-ip=40.107.162.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3qd/nzsg9vScmBPbL+ANDhdMaVa8jv50in95DISINnlySwTteEmAkOePS43iiR9QmR2/MocBXREE+A1iW8H2xkbOrr/I41+Y0aiw0ao6pye6PWNvFxsd8ee8PRcnPbZLEBjYpyMyLT74Rj8BNYyiAcsGw12ImC9EVZ1EWHzKJvtElQ2sKx5tDpk24ToWLG+lSk4oAanFVN1w3CwKuAuyjwJl8BLgme/PpwcPkrJtu5CRpwIfU6f5FbhaTYJMJZzZ/tQEfz8Zmdjj56J6aKdTYQx18YUbE0rOjrAzuNXxzbFuRNlphCW6FX4af1tzg9OY6RvRtTTXvQdSm65ZWw3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwyqAi5orMcWa2fd6mFLtkLAyUJQ05Uk8bE67Y0+6jU=;
 b=SRkN2yEdrBNMvNxygDclJl85KrNzVWK/v99Vjkak65sctzFnZ3h7AihAXMc5Lm9w1sF5Fy/+yKZu9rQJz5T2/Q8dI84bf+A0cf9mdieSlTLyM36NsoM2hX8GsSYjX/vt4pgfRk75jsNMOLLNN+NFgdWAshCYQtfgrK6p734eXGiS8KswBCgGSqLK3vF/dcf8HJUMD67f8AM8vtJRVxqShfyeqLiUhaPWbGw6IvgePOull9ikX3G27XYLEcywoD7DQFqk8U66YIMHlT7A2ztnlfpr2XHQrKJZzR+hrVV/Hiq3D2uFNnnHX/OpviRMpWWRlPzMH43uSoBMI7vh7PpCMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwyqAi5orMcWa2fd6mFLtkLAyUJQ05Uk8bE67Y0+6jU=;
 b=NwJ0HOcFyXlKUWCXlaw5FKx03+c2zgqP0hdnLUE17nMdOziYnGr+Xy3wHFN+rbIAk/JpGx2cnvGmtQt4ey0mrcRi5+p1eNtxSXrv1L0b0z3bAisFU3hggrilk42+dxDq7t/HhWJybRA4Gzr74LRAel+X98rhsdtT3JN4jWlOulKLsD8ibZCf0sharGLOZ9m6Ljf8BpBhVr4bNQI5pkg73tvHziKfa6XsA/2Y3sFPxvPMtWPMC4J8Qc/IjvvpR0LVvKLSqKjeHP++R8pZW6mRu1oaGMYZJO7WZH8xhSrByRKlFpba9JTKpGUwneKxK8GJPUwPLBWs/7ljahHP5QG7uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV4PR04MB11944.eurprd04.prod.outlook.com (2603:10a6:150:2ec::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 06:49:18 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 06:49:18 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v10 4/4] arm64: dt: imx95: Add the missed ref clock for PCIe[0,1]
Date: Thu, 11 Dec 2025 14:48:21 +0800
Message-Id: <20251211064821.2707001-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
References: <20251211064821.2707001-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV4PR04MB11944:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e93a50e-ff74-4396-b642-08de388167fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UQv4sqhlWWvs9/RiW3T3L/wjnX/WMbvCn03B/L83Yj65QUlaObZj5MPbuYlp?=
 =?us-ascii?Q?i3ck/zJDageaFZFHy5hsRsm0LfHT3xKXwC2Uq8ziL+CUEU/L+OazQoX2z4IM?=
 =?us-ascii?Q?0/bwwyshyWJwLR0MuE11kEBYdrwe9iTctKfWrRDhLZyTuiYDjZSv1zC07mT8?=
 =?us-ascii?Q?obuIl0riIf/e2IE4NUBYKDiYFmx6veG6i6DZSYME+EikAAvghjJBixbrc/zO?=
 =?us-ascii?Q?mMbwCLlWrLWARE6hhOGzaITZyRnWWqd1zyOuArqrdHlmqy4r5FIszi/pKQse?=
 =?us-ascii?Q?ScF56csEuomhi4hmaqdPoWCmAKGs455WtTA1Iqy3R0qCT9puEX2vwpWsj7gs?=
 =?us-ascii?Q?tx7czLQH5lPJvxyQn2VX6jK315/FIcPhnYkqWh5UcJUg0AQAf2MmAephW9ij?=
 =?us-ascii?Q?9DDDK7cvU1FRBOyp8J3nfdv64/A9FHdE/RvY0x3Y6EjWOzE3X6BQfVGqVdNK?=
 =?us-ascii?Q?TCiL7HLdDCprW7+t4KcfrwDSsjbw2ytaxux11jmqJVpp/qE0aI8y5h9v0JeQ?=
 =?us-ascii?Q?/6RaYqxV/z8VAEIq87JwSis3T//cf7yf+yasKHf7RSQTGz1g0pVmG6L6UTV7?=
 =?us-ascii?Q?O/mi259f1B1OuRQ8sgkkoe+Epp7O1UhVMU7xq1jwSMPsVpHfgro48j1TyJGf?=
 =?us-ascii?Q?ZEqJIOF43r7Xcn6QPvh3bW5MaSAn3CkJONUfXAxvKIElwmW/7IKGHxEvE2sh?=
 =?us-ascii?Q?TKOrZj+SVEhYXKNBpR5cq4uCLVTF2bZMkGI90yc16M76wysw6v1GBpJEDfUL?=
 =?us-ascii?Q?0GjQsVeLqlv6idYrY7JkJCSx73W6qqgS/9YiqAbI2DUkOoSKxrsLdKVhxXBa?=
 =?us-ascii?Q?vDKAEuv78AHotgeXZnH9knff1y0r33c3WXMVdNoy7SZfdTkaNX5ZCtj+jWHC?=
 =?us-ascii?Q?svTMDlavD50BukXsF44oYjiL8TMsWHPSVSJ1BOGk7hZyez6fLkAVbKsPLsCH?=
 =?us-ascii?Q?+hKP9RewVnWF/a/mAUteW3i61Z9/AS/66f9o35Izb8s9bsWA7+7nVgtQbY11?=
 =?us-ascii?Q?mfYTU6EtwwDKJtTkhzpWxb5xnutm94JVvuK9cO/eGNBn5y2NkPfvsT/bu5jx?=
 =?us-ascii?Q?JEZ40Ngd0dXMv39YAUq/r1uvRXVyyG/Y+FmaN1dBgHwhiG3hNbFeKv9HK8XV?=
 =?us-ascii?Q?HaPKkobdKXhkUbSSUFFFpK5Ei8HM0TxGZrvdsj+kzYfxivKsjuS3Gb/p19Nu?=
 =?us-ascii?Q?VZZLzRfzvSpMBgalXqOwAkRVjpxBf5XFYHKvuYLTHw0JDODDbOlj01eyseOg?=
 =?us-ascii?Q?o4wYgFNmSTJoOFBFaBoZZ5OP3NLU/HrDTUHChQdRZCxYOnjXEvGKD9p7212/?=
 =?us-ascii?Q?TWvggsTlZqVP+g0BxEvT/Z6LNoqm0sFAMdqOtFwB2orAqrYK0guxhARS5aZu?=
 =?us-ascii?Q?QEGj5ftgPiQbgu/AJ3HLlF1AquVspdOPDngUQHUCd5fkOacPdgSDZ8HEPwdC?=
 =?us-ascii?Q?LnQDoSABcsFgCn8mRNUWweeKJQTLgFJnfzYTA4jewKs9zKak214Yw+9WKyYM?=
 =?us-ascii?Q?79bETDe+eNHahsBWuC6LF/JyehLF4Mhg9NNZQXhxh8ur2OVlrkMib2LymA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X4WMtM52ym+7/THcyjvD71uboCeUYmPyk25TRTkNCy9HmzZgdgKFcZOgZe66?=
 =?us-ascii?Q?W0kxGAvRAfxskdrQFScOHR2+8OJNkZ7kR4kijQagGWiFw8mT8RShlUhJt528?=
 =?us-ascii?Q?+St423iLwnzuciFCdBQ/5vmGt8svXFTyJIM7lkzxD09kPMNzbIKBf27MQhXu?=
 =?us-ascii?Q?H3BTMT4FbZy1seTPuoBdD2DmAIcr+f6d5NyHiBTBDeumY5exr02uK3Yvoiak?=
 =?us-ascii?Q?UjETjuikpCq5H6XSGxfJr2ZfTsNZib6/r8zI/DWoLpKojgkRLbWOfkci1Zo9?=
 =?us-ascii?Q?vCvXtMeRKBlmSzEsiueet6HbkU7LVbjRvEQKzrXtOVvljyYcPRi8UrWR34tz?=
 =?us-ascii?Q?3iVy5PcX31dfXmQ0wjNGxP/xssGPwOLWd+SydmZo4H4w2HoY1Ms/bY48Ws5+?=
 =?us-ascii?Q?EZwp4wvFLw4Nov5BsFaAWg1FmDJW3WNnWyHPtIJJnGywoPFc0XEUbKbgIxk+?=
 =?us-ascii?Q?1fNxRawXWNXKpgWxFPHOqrJWCdnWP7HGR2lUwDJflMufcHN+O8njAXdaJVd7?=
 =?us-ascii?Q?z/rmoeC2VkCr4hT8SfKFCXTB10+5jd9H7HH4mcQqbORi2lLgxaBPAsThoc+e?=
 =?us-ascii?Q?ooV9aTPlLUB4EMHcyvmXFNK1xCbWQAzBhXC8M4LPfUNYU+8i5gDUHTOWwyM7?=
 =?us-ascii?Q?XkE67OuT1jIlug7BaFo+luf6OXj396CxLbTHOTdGweO6MGTNZWFM3Z4zNhdk?=
 =?us-ascii?Q?fOLR69ZRVXFjNEaJxWgIOIpK+bXE8oHamIwr/FXq6wodXzillU9RRm4Dp/R9?=
 =?us-ascii?Q?gJ8RrsB1tomatFwjNjklvqvptkXYU/wnQWcq/UydEJQs0bWmbVlObnTVkd6S?=
 =?us-ascii?Q?OpAFHaI7eqMSHiAkGcBVT11TR94kb8XmP6jBiOXD7Wh82gEnFDP2LlKh36Dr?=
 =?us-ascii?Q?j73ssoSFwCwEkLUULZbeyjXq3oC/Oy8FYujGxIiLiPUq85zq1yS7dx0cILoO?=
 =?us-ascii?Q?Guowlr0hp4LncRCz0q6dFKEuTnqrmbGI7J0O6kluB8R4X7FwcbiK4hASEz7T?=
 =?us-ascii?Q?F1UDLGo2EsmuIS+drH33Tb1OarLDx5zQjcTBkWmCIXAElQp0Hyi5fFqtu3+6?=
 =?us-ascii?Q?6DtYIQdS9BSxaDrUug/3LuBk1yg4NfKrdwFleTRDu5xkW1dj3l5UDkEDJwXV?=
 =?us-ascii?Q?RobEhsZOZmRqxfbxAUvdkQqY+uAKR3zx7SuKBSoNAwf0f85Rj+jdJO3YKRcj?=
 =?us-ascii?Q?dJim8c52BlJliLU5aYuF4QdQ3lTGy2sCJ2H3dZv/5INJ78x4U4GxbNW9NTEg?=
 =?us-ascii?Q?KfG36Wr1swjCiPS6OucQsvzfihQpb2n0ifLFHAdMUdeV51/DIMKLGCua5ZJD?=
 =?us-ascii?Q?H4io6MDsuWxjD34kGZCoCc0EYTh7m6V5kWDFpLes2tqaJ5zlrs42HE7wtNBw?=
 =?us-ascii?Q?IUiRAnn/zxtJ0rvfZPhaPbOoXrXcHeYuX2rmdh3G8h84J7dgV27nj8eQAogG?=
 =?us-ascii?Q?x28M875NtsVz1LXjDrhZBi0ch0t79l41Jy8p62YxnnfSfYXftK0Zc5doYf9M?=
 =?us-ascii?Q?vMmbOVzk5nb6uYn6ZsbiTKLmMAUr3VUJ/ndDLJyatXos4YgziDg9jWxzXTTG?=
 =?us-ascii?Q?7NeI6RJxtPSh99kcsC9yzG6JGlquNRbygzf8lS8+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e93a50e-ff74-4396-b642-08de388167fd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 06:49:18.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +SFtoJZRvmFGhEBY/M0uvIIHOLBTkGw9AoMKOKQeQd47pLDCHq0FphHzZrPMQMb+2R0uxnrYX8N3OZ40GI0fMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11944

i.MX95 PCIes have two reference clock inputs, one of them is from
internal PLL. It's wired inside chip and present as "ref" clock. It's
not an optional clock.

Add the missed ref clock for PCIe[0,1].

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
index 5b6b2bb80b288..1258fcb54681e 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
@@ -237,8 +237,9 @@ &pcie0 {
 	clocks = <&scmi_clk IMX95_CLK_HSIO>,
 		 <&pcieclk 1>,
 		 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
+		 <&hsio_blk_ctl 0>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
 	reset-gpio = <&expander2 9 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
@@ -250,8 +251,9 @@ &pcie1 {
 	clocks = <&scmi_clk IMX95_CLK_HSIO>,
 		 <&pcieclk 0>,
 		 <&scmi_clk IMX95_CLK_HSIOPLL_VCO>,
-		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>;
-	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux";
+		 <&scmi_clk IMX95_CLK_HSIOPCIEAUX>,
+		 <&hsio_blk_ctl 0>;
+	clock-names = "pcie", "pcie_bus", "pcie_phy", "pcie_aux", "ref";
 	reset-gpio = <&expander2 10 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
-- 
2.37.1


