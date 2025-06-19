Return-Path: <linux-pci+bounces-30153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6B3ADFD62
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 07:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4ED117948D
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 05:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6686B243378;
	Thu, 19 Jun 2025 05:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OCTjCecK"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B269239E8D;
	Thu, 19 Jun 2025 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312652; cv=fail; b=lPufM/lqNH48G3P6ObetlAnte+GIcz8I3Nx/JV+wJmsgFLQde/zfxlW2DmrrR5sBttNzB7x5qWN4969lm3fymLMJH4VASgKTVpDzmvdQVJ+fdqXW0w8KZTC0Gj6Lbb1hZ16jUWsiUnim9hVkfDjQB30LY6EdQvjih7PlerMDbio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312652; c=relaxed/simple;
	bh=5SOzoaagh8kbDGk1Hp06KBjuukPuT1GsUsruV6RfgkU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z786v7y01z7gygdN93vZ27H2ZAeokuqW9tMZDlcvb/CmW6Rm7otgYOAdZd4RRGLtYr3DjLp267gX+DTZoJb4QH/9Zy973fMDl0Vf9crTGvl9qVnMwtRGpYDEOG8A+mp3AMP53JMCek8Uzw/LGZrQLy4unmN+pIFQdRLCZPQaDrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OCTjCecK; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hoR/9aBW+KluQv7bSp7C9xm7FpKfh/D6w6DIzfWd3F3hmrI20Fv7Wr95ciSHMZ7bdsrDQgNlYfg9y2QNjmpDhQ2sQpKZCZQ3wftt1duQY9BQTAfikNfFGo7lS5xNDWfI346Y6/AwR8i6r2lYpFBAIyDgO6Bm+nmtALBZ+LvVwe2pEA28siDFP8BKbC5VgF9z/3SUTWzvCd0rWODj1VVruWZGtUI+qyz0+6q5qFHc7cFwjg92ign8Ct7ddsgjsurXkoGeZ1tpoH6ZfqUihw4/F2SNLz8OR1oZfkv5mSxOKl6DbbE6GMH3IC6V9PYn3elaJeVPB8/MQLx6KtIjrUpbrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=an6Zq6IAtCwvPsxJNqPnc1rGgTvahlf7LILEz5H12P8=;
 b=lR2K5qgTFbHUf/arzT/kUbPNYU66fyNoqum0eBeswiw2v6aTlM9aIQcBmxzV7nm6LwFPOywBBQHtBnUwxL4FLLCPNlexAZ2sn+rCkOn3HKEnh5k9Xr9FbXqHTyOjH41WgQeFOC5Bq+2uDM/ziHJDAH1kvPjnCMebhtWrUsEuhSdP+eYyV2OHooRJf2bbUwwrybve/pZ0V4jlzp9uehR7zGYzWumBtnzvroue2BAXSDQdOQYwsXwcyok6pYZ8XLu778ctc0Ym5O9qZGhJkMy+JuNe6WCew0zp/Xs/+wXWSmyuXf/Y9K5IghcvLIuy6JHO5HwNAh10g1ppCXd434AE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=an6Zq6IAtCwvPsxJNqPnc1rGgTvahlf7LILEz5H12P8=;
 b=OCTjCecK7zUsZq3OeMvtwTe+2Qdi2wXlGTXYGrtTI3yYx/7OzQAcMX9PKUhGUAIIbmeLM+IBRwwXuBhgiu2js4q0wbAQiuGU+QILGvBp/6/4Jiet+xlpPiNLpKN6LfQZ2tUXe8yNSQ7c0atmZaG4HJlVrEfCh+KOTyf5seNq8UjCdrfdxVUHBYEb1+8XdRfhc/OXhAU4V0iZEV4py6g8Xz6yfHxqPSMjoLP+dxeqEFc7E/raL41mlf9n//bk6Rf9j8YJ/FIBCokZAFRw0F+AzOCpk/d1u+ERR2oZ4mZ5rgc/0APywGUV9Fd/Y4rDW98migG2pcbyk4XBR1Xv4eGkMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 05:57:26 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 05:57:26 +0000
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
Subject: [RESEND PATCH v1 0/2] PCI: imx6: Add external reference clock mode
Date: Thu, 19 Jun 2025 13:55:13 +0800
Message-Id: <20250619055515.74675-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: c8ff1ec9-c1de-4f58-9d69-08ddaef62afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KOohCYTL4WVe8thVg3/8nUQ/tg/GKmnbTOQywlzLOe2gq+7FxEgla/KTqxy7?=
 =?us-ascii?Q?9mxynW94bvg/FQUNcrxLocLIlVBKHfkrT344qLwo9ojyn1o6Yq4NUs7TI8Yf?=
 =?us-ascii?Q?u1hfN0cCjVNBFc4fXNVnu5O+chMLkdzscBuZ0sxrKgPzmqpHs0Ms29mr9j4i?=
 =?us-ascii?Q?MsX0M8qLZVu/55y1fM5SvVVtxSkXnWkM/NFFT+x6Z0F190CPhx4+VN2ABBTR?=
 =?us-ascii?Q?O450h/CBaJza+sSIjFkPakL+K0xgxu9E2BOlcVyDeKRDa3Me8cHbdG48rEvP?=
 =?us-ascii?Q?2YOr9TED0BzZIab9ADKA0BwDhNlwFmDOViCGeIpNL9efM/1HloI9Emz9NyQf?=
 =?us-ascii?Q?/XaMUbyP5AtNa/uVOSQ+UXpwFwHdvikvs5RdgtumX3xwdnNn7RXUCciVA2Bv?=
 =?us-ascii?Q?9AMwUSkT1MNJda4zl1yFwp/oqgsIJuLpqCGdcSOgPvCuC4Is72XZhEZVtFR0?=
 =?us-ascii?Q?ruuoE6jmjt33iqIS76A5Xh40alKWubzTjn3kE1of2wbIZGp/C45WFdIIpdum?=
 =?us-ascii?Q?B1X1ywULd+lEUOq2B5dbnAuDbEzlvfRMNPJiI6yZpOf1z9fuw0+UZbBYQbbC?=
 =?us-ascii?Q?9Pj06tRjzFE9sCDitDZDsz095F0pgvx9rfS5SnwKDQlRKmIqCdyVl34S1BCA?=
 =?us-ascii?Q?XOy8WqvD3Bklwxkm51All8nv7udxls4xoAFCWSkIwSjbr1Ghwm1CTDbM82yL?=
 =?us-ascii?Q?Rhg4fD+bx2FoI6AEqHgsi3gLluun28+Uzq1ZNcrt2m4EQdJbl9ipljl42dOb?=
 =?us-ascii?Q?sw+lCLVhcqUrt204KcbYYTLAOAWeoAyqFYYwKiPDxCGWCeblmIqYqTwiZE/B?=
 =?us-ascii?Q?UjWD0W54A4AFO9RTmXCNDkKSin/X4Saxh5QINQ06Tx1M3Ua8GXr7Fi9UfBJJ?=
 =?us-ascii?Q?E0MMDC7T/xQ2RwKt4eBEVseEbgSLKnV8Lixx02lJntfVaksCW+aRTB8xIqAd?=
 =?us-ascii?Q?CBya57PaqLLB2ZYunCrHusyvfwVdGOr5VyANAf4wZ2x0l0vvLp7DnaAHY5oB?=
 =?us-ascii?Q?NrnIiouZvaTv7IEUrjp8awENElDbiahfa/zjqmrV+6NzC0O0T1RNSRMz7Z9h?=
 =?us-ascii?Q?H2TnI9DAM4iyIcWO0uXOGv4bnhvzymuzFRapZb+5ZhL7LRcfgBciF5eKZgJP?=
 =?us-ascii?Q?lKRBsd36WTy2qAwL60FXKPPfGkQkOQhNfJ+Ba7NHuLY77d8anDNk1/KWjT50?=
 =?us-ascii?Q?MP7nEivz8H8K//jo5nDhlVFg9qx5svqQuOxUJHy798QynY74DHs1liFO0Jwd?=
 =?us-ascii?Q?W6BpaVfZdN4n0IR2YCAdqzBq6oNtArTW80wyr9PFBLqzr8niFkMmlRJI5v3d?=
 =?us-ascii?Q?j68NLDbaF2j4UMnm3H0MrLszMHJ1rmTNAkV5dGviF3Q9tvlEoxIWmKhqWpIG?=
 =?us-ascii?Q?5DopyM1fRMXfPoFJogxaMSpgw64OGfccZ0itRq0cINvA4vwQavZhaJpeZd4q?=
 =?us-ascii?Q?DDf61YrTuLscZxFx33oCKY/LKkguPxcSf9h2wYkogL9GzXWyDUdJSHf0XUsU?=
 =?us-ascii?Q?ScwNqAWwfFsQwIw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cjlpOgjKGKN1JUgDqd3kBIx+2Mhl/raP/qRgqbec6K1niDChWfG8ZLZT1ezm?=
 =?us-ascii?Q?P+1w2VQeeQVl17hS7S043qXaA9r1KfwAdTtOqFkVHNja5zTirpEghSnJt7I/?=
 =?us-ascii?Q?sN6FK8vY6Hvt+0r4M318qdtgZ1UAsYjNZCoyczBejIWzLrvsoLlAX7yArTus?=
 =?us-ascii?Q?e9Q4fMHwKFvaKPfSsasUKDprTcXb14KOmUXGu9PZfsebXZVJnREmYRn5oSGh?=
 =?us-ascii?Q?NLdxGP20/KDF5CghclGeSe+Vbc+IP95J7UzEmyf6lL4w4ZN7aNX0NDtTp87J?=
 =?us-ascii?Q?iCHGGLXCyGtmPBpF4a6A6UiC8ot5e7FsgvFfUIMhS+mfcjtjzXkRHrnaZn8i?=
 =?us-ascii?Q?QVX22uRdf7dNJl/GMn2sqid/5reov5xIjJGm21fVW75CFf99V4XQ4gIIHVc9?=
 =?us-ascii?Q?IjrqJrXDJwAmFZ9uXwHFRVQConIywEL7NYOV0XIGbHK2D8Uydicb6/kaLPmn?=
 =?us-ascii?Q?5PFZ0QeBlYTcjLlzas2aJRaDTz/eHbPTaaHkkJMHF8THfqRvYO0ti+jXRd7t?=
 =?us-ascii?Q?XA0sUqEAWrU0tX1Yewhk9N1P7BchyDPr1YT82UdHfmEqVpvQhB1Dc9ue3+Aw?=
 =?us-ascii?Q?u8R2/eRsn4GY6/sVNXI7MyyPMps8KDUD4kz8dRdovBd0eSe+/LxKM5tGTlct?=
 =?us-ascii?Q?RLksD0cYUtYmacM+6brtsyDOOqqawCqNwebfnkWVqjPUKJpKLGRvGRAlmAav?=
 =?us-ascii?Q?rUEq+NgbFcRWocib1sL2bWjvgTyPKeYlQsz5x/KUKg7a35DMvq4slFnFy8wl?=
 =?us-ascii?Q?nvsyqzkOEhO8ta0NW7Sht9xWxR/iWjcM/1zsX+t002RCcrzUgOU1GIj1BfPn?=
 =?us-ascii?Q?EMD3EedvM1lAX1bJuxSi0ZvLvESmGvt1kIDen2497Gck2K/3W9ky/BxICAze?=
 =?us-ascii?Q?GvZco7VbGbkvVW+8QM2A158m037Q5Rtxf2kiGl+jlIUl2xFFOkX9T5nPAgfI?=
 =?us-ascii?Q?zkymWPYCiB9rQjjvUrziSqxtqb3F2En5Q0v1ySN4vwEmd2dsCf0ZLwMyzMJd?=
 =?us-ascii?Q?KFPej/KKPC2c8jnr3rjK23tqz7ve2xkASvQB4tneEUa3l0W4iS1s2bzX/+Ta?=
 =?us-ascii?Q?znXmDBeyqOCSkaVUXvytN+uuUR/zzU57pnHDx5LO9ZgxKgv4vLMglDMFQl26?=
 =?us-ascii?Q?AMQ3MTK0uKuGPUeTIlsqtU7asfCOQdlRvPttQD736y1GSPMvztGr/t6EWkeJ?=
 =?us-ascii?Q?BxxchvmQoTRS/kdTYSezB123Y/9zUEsGuHf7P31ohPcCn7149IX0TceYoHPf?=
 =?us-ascii?Q?MsTGzORvV/CleVKArmlNxuAuZ9BkS3pnySUzB3A19+p59AKZjHpyLcmAqMBe?=
 =?us-ascii?Q?wj0UKig34ECCaJvtJbmR6sRlUNCY70PqbyVYfaSBca+VZNmV/faiMqydmEat?=
 =?us-ascii?Q?FdtchQTxhjV7slGLZ+3qz313UbH8Z+1wTWy86WTLgrpCuIutunvCLgaC6eHx?=
 =?us-ascii?Q?6VCPEp3B4WKPfAqAYlmUsACrWBSUEocB4TmCrJyGVkWrf9lGY0F5rGlQbhl3?=
 =?us-ascii?Q?k9kO3glUAQSXUtlA3rkM3R3Pso/Cz9R6NrMYeC5frJDJFPnW4/nLJGtgw7QG?=
 =?us-ascii?Q?1DGp1QdTxYhcrkDn7DNW9IW48QqjgGIz2etV6d4X?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8ff1ec9-c1de-4f58-9d69-08ddaef62afc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 05:57:26.6184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82JmHLc6ZGFii3Qu5nlZWHLO+98S8B1WOX/LMZbwagPZgYCMkFcwB0vSxwr9yPDWrDtDGm4gERSdl3SzRMvipg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9571

On i.MX, the PCIe reference clock might come from either internal
system PLL or external clock source.
Add the external reference clock source for reference clock.

It's my fault missing add the necessary people and lists of dt-binding
review. Resend the v1 patch-set after correct dt-binding review pepople
and list. All the comments would be addressed, then send out v2 later.

[RESEND PATCH v1 1/2] dt-binding: pci-imx6: Add external reference
[RESEND PATCH v1 2/2] PCI: imx6: Add external reference clock mode

Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml |  7 ++++++-
drivers/pci/controller/dwc/pci-imx6.c                     | 34 ++++++++++++++++++++++++++--------
2 files changed, 32 insertions(+), 9 deletions(-)


