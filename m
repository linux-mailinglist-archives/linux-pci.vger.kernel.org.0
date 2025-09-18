Return-Path: <linux-pci+bounces-36399-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 016FBB82C05
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 05:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EFB31B24EFF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 03:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722C62582;
	Thu, 18 Sep 2025 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Re6ZjZgP"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013027.outbound.protection.outlook.com [40.107.162.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DFE241C8C;
	Thu, 18 Sep 2025 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758166016; cv=fail; b=HqHAaIA5hw2UfK9EU8uL2rMg6aHsbmn9dweN45z0DTuGyFGEpVGMODL1wFrnfukrRBfOHDhkD8jgi2804Uv/9of7UZMO9E9csTEig+jNGSwVU6QsGXBVTwReiTaAHtaxTaokX/gEgf3itQigKdnjreOl6ia9YPRna2rNpy9JzQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758166016; c=relaxed/simple;
	bh=Xj3M37v1H2Uk7LzlDZ3mXJkqZfYrTwlBU9p1vvh47tU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LX2Nu67xSn/KmUv7HpEPeeH4KUN3NYxge+0tETVsUwfwYWloZG7DhhpkishZkS1a0q/U39d+BCSS3dDLUhy1aqUZpQVZWWUaQMnCUVQHEdslw1AsTYdtGQSSZnVL0ce4XNM7RuEXnxhChqziCSoX2Gw3bSm+JwW/hELfi5RuB48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Re6ZjZgP; arc=fail smtp.client-ip=40.107.162.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JP3INljNtKVG75i+4YLjQ+4c+g0Qvz2C8DwKsmip3I0fYEORlFx5DrqGdsQPYGkRZCOn1azl0hcSr4t6cIol1f9Nu4De+GlOU//iAgVcI8boU0vLJImXa7w/gnMMlRU+3oP7hSDvliRwlpmJz6Rg2mqIFHJ4ZW8nZb2OMTL9K+UniwXYrXQna/I8WlAY65coUSaJBFAqKO/bX4QqQSFihqVCluaNxucgKYPj24VY9lSKM7+5rI3hJpyKSBaEFwau4q3GnFKAHMxR76duXSw21ztE9YAknBnZsnch6RycJMDxsaUTGkycWhD7dI9nnujaUakg9ni4fDcIzT9RwTXe8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/Al2U9nOppyn2iRfOL3sb4NmOurLKKjCh4fdpNhNsY=;
 b=MR3dDsw+tuOL54e+wa0Yl3LmDy3R3iVv1vGBNJ2na7rx3/CriJbdKgpMQ8N+dKSIXxorp6LeH9+sB/vvspzFYtXyhmESzs7GOaXl0r5n1Ez8AOil5F5QjbmxGw2FCCXblknjQSpNTM4ig8rwIccCERrYW9E80J9gekWFGWyddzhIwbCMDQ/mSuYQZxmFXc1I4VPte6BJ0bMn8k3k2cG3iYVeN7dILiMnMZtkyp6WOIzG0lNHYMYPinm1roLYPNTYpSScKmWVz9dICjnMy2JZg0OySp1fOMxdv8ErLptdc1R1jciKdbtJHgN9TMKpe2P24p6sj/JFcY96eqAY9jWJhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/Al2U9nOppyn2iRfOL3sb4NmOurLKKjCh4fdpNhNsY=;
 b=Re6ZjZgPWr6jl0WnsD4O3/4qL2rS9bQ4EAkmlzsGzJv/OFN2VBpeipF8AseQwscD0IRTGou2bddURkmCUIjo3yXMomHO/V2fX80pi+3zc+LIEu2qVDObFu17MZgUtpU2hxVbvMmvxK3vtRBx0DU5Yza7b4gx3yBQ6lD2P3mCKgAEmttnEeUZwDcZLtfnPnuHwhgHHJ2UtY7aD34pIuQB0mS8zdINVKrZktEI0Ztr+/dCvMyaQbQkWWy8mVB+kzntTkZOaS9b9ZJLtT5P+C4MpOySomVG8+yKo3N5/De4YjtxMtUHOVwtuSTWP0B5YaI2d3mWwNe6f8NciMAYOcTV0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 03:26:51 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 03:26:51 +0000
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
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 1/3] dt-bindings: PCI: dwc: Add external reference clock input
Date: Thu, 18 Sep 2025 11:25:53 +0800
Message-Id: <20250918032555.3987157-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250918032555.3987157-1-hongxing.zhu@nxp.com>
References: <20250918032555.3987157-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM8PR04MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 17275074-2e0f-4287-2f40-08ddf6633574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qItQiBCI96zd/g9TGLws35YNsG6cfyQu8rGinEzScZBpFpr8G4Akxjx6Gk88?=
 =?us-ascii?Q?SKy9tIL3G6UY4GuWNOTaq7Rn4lPpJ0tNxcH6rrVkqp3lAehPdj1bJjZ9FK0/?=
 =?us-ascii?Q?k5nB14IYEr/ozIsYQ+byWA22vsd7a1QZCHwMRzg5ZraP7mnqAzpadiAHGMVT?=
 =?us-ascii?Q?L9fHVzP9L6ss5KMF16nE/kYdATt6Al/a/yYSS9Gs92n7cJknIaH6RkwqBMoq?=
 =?us-ascii?Q?In4m/oYuYRHakFMOqxUUAxRVGqMBiLZY5OziYyRlnCMvvSq6LJAH/I0HLz/z?=
 =?us-ascii?Q?hO+Vegle8LBMJubz30lPxmHCzBB6CHYpglkQlPmGo3IYLHnuLehwDrt6Dfmm?=
 =?us-ascii?Q?Q0tUhcDa7O1wTsTUek2ZO7XqrvMQp9NIzMuh7ehAJ4GQo0nqYL1LH1qG4MCu?=
 =?us-ascii?Q?3dQ0LlwktayT5+qPI/IyICTKF48QqWNhCrA83uFQ2UevDXrItFO58J5z6zbi?=
 =?us-ascii?Q?lVq9mffMTNhWVvBFg4VDvVz4RtQn5AOJ3NA8w9PEiaUNhB0U2toiwGLr5U0q?=
 =?us-ascii?Q?ID3n1ayt7a6MQyHCJvJH8B3c2ujdXBs9fjbkBJW3+i2MytYgfLcxs2FDR22b?=
 =?us-ascii?Q?cu+XdUc2Oo05l+4+NfL5BwjIOld76hklG98ete0ciN/NBbj2XiaPU7Ipwjjc?=
 =?us-ascii?Q?ju6E8nHzIumRY5Sqgtm4xU0Qnpbpa1kFuVrNqi6CrevlvS5miYdmzMjQz3yl?=
 =?us-ascii?Q?U21Zia4w4KGAmRd16ds8b4WjNlvjmS8Um7tQIqX1lc1jfTCD3mzwe+YL2abf?=
 =?us-ascii?Q?LeNZTfthuhrRnA6PQv43SWFOTmHAFSF8SfM4XOaxi+VMrpRvk+vJ9aZOWmiG?=
 =?us-ascii?Q?RtYnjdj/eMVUyV0VnjVABpJrtdyQBVuJJP9RT5/wUPi4vdehuZdSP4rZBu+Q?=
 =?us-ascii?Q?UVRVJhrP6FT1zRVD02jk7ovelGyI1G4enRTy0dEGvV8UAofHt3jvRIx00Cki?=
 =?us-ascii?Q?mYwyEQyBnQ8cBoxOlYGhKnDQJAsdn/5+mN2XZgAumZk8ZY8opA3yHOznHxV0?=
 =?us-ascii?Q?De2+b2wKYN2zUd5Yx93YlxfR4rbv6MzRKFniOxhpp9kkZs8unoDSrMrImPPJ?=
 =?us-ascii?Q?RcN5gilzPMbdrkl9z88an8oyKcv9On03sDN+dwodjS00AiDT2EyhEEhiper1?=
 =?us-ascii?Q?zptIvGounWA6TFRQBYmTZF33hpXb9vBk3OnawGgGQ+s7h9iZSmKzxnbAir/l?=
 =?us-ascii?Q?tdTbyNE18kCkHBF804nzmjGgQwSxVfFX403+liJwyZbKg+DWfduBLFSEe3q2?=
 =?us-ascii?Q?6rSAjaAGaMRY21RBemLCLc7bLN1dlCU/PlghnDPX22yQoYYA5yyOtY9Gv6WI?=
 =?us-ascii?Q?LRssD0jggBs2kXShHtW6tNR0+lC94s2p1fU8xWKaPRoVUKZbTmJqCr9ReugZ?=
 =?us-ascii?Q?EzcT8IJJARcKh8iOW5saTcl1LeWCcaD6Y9Ww9yOOtqMkdcQnVhw96b/fpiCE?=
 =?us-ascii?Q?EYq4DBTcYbY3C7kXMRw9Hptx1917A5brtvgxYKqutL6eowFO/PjqbHQ6k7Op?=
 =?us-ascii?Q?ltMOctUNMI23L6g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mR217IwZ23sOv3XhR0BdPTB+eGMKzOdO5ZrBHApHyr4DndLZ2WUQQndHDftL?=
 =?us-ascii?Q?jdcqtXU+kpmcNN4YlR0XyPuLz10Qfe5r49drAVOT3VSB9ldEjXd9LGmznJ8/?=
 =?us-ascii?Q?PGGgTHJrmCBd3lnjpeSOeu4nOCuHtf2txjQQ4EUDQNKXWKishPn/XBQhSjO+?=
 =?us-ascii?Q?v+IJNAioAcw4jVcMznJb9eGyDWMuJuyZ5UsjaR9nL64w69sOFD5aenP1yOuN?=
 =?us-ascii?Q?qMErTWsZMWiQZnJUh4/mWrgrtaypqwBEHYkpxzew2rNb/ViZ0EAlslodZuo+?=
 =?us-ascii?Q?JpYMaA5+qe9Xl/d86xU2VMA+rvQuUdou+zuEpjtfDrcVpRu0auIw7WG44SCi?=
 =?us-ascii?Q?XitmCeD4OPNaGlHm+nhHv4dMw9BwcfJUa9tqZ43O2jdk0dFdYBbk8PdAJ/qY?=
 =?us-ascii?Q?uLDiAgTsKAhp8pIscTK4OkoMpGbXAtcqkSLTBKXHJRB+W+u+6vA4nuws0rdx?=
 =?us-ascii?Q?37CE2tIysZ8laNwr5wcWNX5atpmOC0cJQR84jqxHLXwEZR8x0xPo57n0dd/T?=
 =?us-ascii?Q?ptVOy+MdCp0PKuqgnUN+pN/Q3L+slFHU8s8TE6PEFa7k1uNVgbUcG/Z0v85x?=
 =?us-ascii?Q?EOc/8ds7ZrL0YQkAi8wStOMJ6fAsZDbO/tmDdD0/lskPTxIeFxpcQCSuNQTL?=
 =?us-ascii?Q?uT3JjJwKsqXeunFugUQJZxAUiviUV/gNmZolH0tWrTlcz0P0FfxLndgO/b5U?=
 =?us-ascii?Q?HYBpyWdQ4lK2+/KNp/1ut0LmncLEAWRzekKxqqYJPq1V78bthNctiNDa5V+F?=
 =?us-ascii?Q?ox/R1FUp1c0hD0eMTJqWquwQRD3zuE2QRVbteRCtKSbrBbNyBNi/CZWhE7D8?=
 =?us-ascii?Q?HE0iYYAm7pvVEtpxc5wf9kKKSnNtB7ijiE94fJ6QbBsZZaDdqKq+eOg1R+ND?=
 =?us-ascii?Q?CcEL99RriavOhFyViZesjQI0UrwkDtGul8ELc3BGuRi454LklsKGWh3K7Mvw?=
 =?us-ascii?Q?VvKGHqDrRArFUzFfWhSFZ6hD8jMSHihmt4BSQVaJLzqzUWoiZMB8SX6GmGm8?=
 =?us-ascii?Q?hGOkd4eYdRrWDV4yVVr8n6Xq7zVb3R79HNNyUCcEKVlFGdZGPMAnrb73D+j8?=
 =?us-ascii?Q?j4G9gG9DFLp/3En2dyBuKwx69sCxlQOgu4dyLUOTkCzFW6JSQ5W/n34+KfZa?=
 =?us-ascii?Q?RTodvEXKksehhrsDGgGxd9h1c1QtK9Bbq33wfw3wthk5jkRX7TTvJTAq04FH?=
 =?us-ascii?Q?7FKOpNCzVDtV9ohoeUKD7aRKH+zUbzbNCV9X2iZiMIfmFjmiT/Oh7v2s0tJJ?=
 =?us-ascii?Q?x4/84wL/x6fdE1TWYf4ULtNeWQ8TkcouEoZu1a37uwvcbh8qU7yTzkuiMteG?=
 =?us-ascii?Q?XtOgvxZOH0bpOJK6fVz/UQ9BaW75QJlMK4QCaajzGk5ypjRDRrrnBmRSMCzB?=
 =?us-ascii?Q?m1IGDM5xwGhBvHEknoq+vqjkPn2iU2u4beYh6hPGEDpoKII+G5DxP76obFiw?=
 =?us-ascii?Q?hWMf0IO+F3AYvnthIX9hGNE22AzidXudPB9Txy+96ow7AXF6u31+sbjjATrE?=
 =?us-ascii?Q?BZ1eNpB0pYuK/Se6dkSUoxilWrbf6EZmPhoojoLFlS31MjS3LVuLAsvU1yI2?=
 =?us-ascii?Q?jgItXekbQunzbzcrl2CSIXEXokNAdECHta/g3ySe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17275074-2e0f-4287-2f40-08ddf6633574
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 03:26:51.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaqU8VEz8VkUwVz3kdTrWqYlf4XTfqDuipTGfrD1NFb8tVaXViicgFYdSh34GzldjSsZQV1c70ZsQm02RB7qQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7779

Add external reference clock input "extref" for a reference clock that
comes from external crystal oscillator.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pci/snps,dw-pcie-common.yaml        | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
index 34594972d8db..0134a759185e 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie-common.yaml
@@ -105,6 +105,12 @@ properties:
             define it with this name (for instance pipe, core and aux can
             be connected to a single source of the periodic signal).
           const: ref
+        - description:
+            Some dwc wrappers (like i.MX95 PCIes) have two reference clock
+            inputs, one from an internal PLL, the other from an off-chip crystal
+            oscillator. If present, 'extref' refers to a reference clock from
+            an external oscillator.
+          const: extref
         - description:
             Clock for the PHY registers interface. Originally this is
             a PHY-viewport-based interface, but some platform may have
-- 
2.37.1


