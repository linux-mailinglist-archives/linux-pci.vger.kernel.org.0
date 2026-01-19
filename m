Return-Path: <linux-pci+bounces-45167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7FDD3A45D
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 11:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43886312B11D
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 10:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CFE357A24;
	Mon, 19 Jan 2026 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IHgZN+vv"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011005.outbound.protection.outlook.com [40.107.130.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7BF283CA3;
	Mon, 19 Jan 2026 10:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817053; cv=fail; b=lu4j8mXYdNnxDMDz5qLzSEftbTOvz1dORDNQIpUfFZZ3ckSAXTmqlhpHPJ/MrX3BAnTz50juBkyf3ZPF2wlskqrYsTs41rldl9dVrnSnMSZuD2FJU5/kjYNv4fS7FPFDuQByEmPthrzdu+CCE4lL3K+3CSaWicCkqVZmIzwDnqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817053; c=relaxed/simple;
	bh=c/jFHJ4vBR9Msgpy4QzR3DJoDkihljIuYsmWKaK3xRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rda/5DvYwEOExnXSJVwoFBp36R88+Gh61gdXhhgdix3QhxQKSoYPENy+7X8fwIu7g22+J5PrPuXyJIhoWqNVZhzNcgBMf6Pmp1BbNB+s5jbts1ZzaZuqh/Kjp+N+2NebI+MVM+91b3s3SVxs8jFDYAn0RYl8Q2jb2XDn/oIJE00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IHgZN+vv; arc=fail smtp.client-ip=40.107.130.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d9R5uVa3iRJlsWDol6SXlMd40HuNYC3WtesNOiVbY3EQRqHTLFzKGW5Cmw63vt25Jkglwyl0pS6u7VskE2/68wrYcMaV4tfooGmEz/ZXbFrg2VauDnhJ5ZM2XH4QUBFAWdIVizuvfrgcBNmzqVIcEQfW1UPH9OgiCPQdH13l3cqZIlLucMkNWDa42+uIjL97IcdmNbO8E7j6Ufs2FQKX5RNNojN1aD4tlTByOIly+KIsdcCFZzUN1aKXPUkEIA1N4U6WbVwAtv0xo5fv8KUjK6SeUCXvVWqhx5CuQOG6M+16KqN14ifqAaK6bqJXiHMyZhqLhS4YzPzKkeVtnttDfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZw7zkHMMD7C9VO5AARvGxOcmznd4hoMyZFKtAHSo/s=;
 b=juslWNm/VFH+oWWiv7mXHWddqQuVyL75p13QxdCMZ2An5Jv0viP4VSryFWJ4r+2AgFHA3HoL0oII10v42bn9uy9s4AwBrZutVqaa1b4trxNs2mPuIMgEJnP0p9pZEmNyV/E6CzZXwVskWPqByK/j0iaNAjNBT0nSanHJgny2uSUsKXbTeXQ0T4QE3AQA6T8PgbDeoLpG9vnfIzByu9AbU1O4obgqUkmRoOfS+o3CN8x+4WnjYqNqduhxF2ZPKJ9b8qEDUrPJxmrfw+7hDXunD0AFY/Rzqtz1xDgxR0enlo/ka8M9bqTxWmerefP8ypyvuKL/Wu9RMpx5JETpTU/BAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZw7zkHMMD7C9VO5AARvGxOcmznd4hoMyZFKtAHSo/s=;
 b=IHgZN+vvMomY+0FfHydpmMNG8Kx0YF+x7oM+aCA/Ihtfyfp97N7NSQFsbt9cPp1DFr7Nnql2OQm09c4NZ6VZDgQ6gta+JAIMAdUeyY2OohDg+urcIsPQG3YKsYx2Va8UZyoQ+hOf8cR7ETeVVO3WymrO0KIyoiFlvrx4PB+wT/Lt6E/0fGluCDc0IUrIWxvuEc/vX91NTaxLubyZZSiAauoe1FfFuUOvm4qhdsUoWbDv5cYs1ompYisBO3mGh9Yr7N/yfMLhaWN8js1xSGHDCz5GBpqg0xeOeaP9Idf/OA+hyPdSFu9XqCjseBsOKA+qpT3ZFk0c97bUloM/wJzUEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8812.eurprd04.prod.outlook.com
 (2603:10a6:20b:40b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 19 Jan
 2026 10:04:09 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:04:09 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: hongxing.zhu@nxp.com,
	l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	frank.li@nxp.com
Cc: kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 05/10] arm: dts: imx7d: Add Root Port node and move PERST property to Root Port node
Date: Mon, 19 Jan 2026 18:02:30 +0800
Message-Id: <20260119100235.1173839-6-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260119100235.1173839-1-sherry.sun@nxp.com>
References: <20260119100235.1173839-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:4:197::12) To VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AM9PR04MB8812:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c09a33-69a2-47d0-c7ca-08de5742167b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7j6HBokxS0RgcN+gpFYiMgTRuA6beeigzHg1femF9of9M0n2tRqq5W987J/?=
 =?us-ascii?Q?0DZ+iO2/hdZffydHogcQHwSooKsXKeTZ7sxm35qhrfkabf7JueGBbuaULRg6?=
 =?us-ascii?Q?8WpLzShfhV4dRwqekgIW2+0e9m8vvTecCh6Hx/rUnueyhsi9h/WXxSRSDtKD?=
 =?us-ascii?Q?J+8WPyUyD8aI3xUOBM6RgcOiJJ++rVISN2XTU3p0+DesASH07pFYKBSJ50AE?=
 =?us-ascii?Q?JZVjZLAnCcjI56EgIWApDFXb7CLk33JUKImhPwccZ1QMHD3neCtrqwB6q38U?=
 =?us-ascii?Q?eB65tOhUWbywXpX7V2u3Di2W4EGTXIZynWwxVKYo4cA6wdH6T7HNUZAcjuYX?=
 =?us-ascii?Q?h9uGZX4yYwH/iMSNSmK2Mqp/s+YJ0UntnK2tOwBkbt5+0LHAwEUEK0sNgeWD?=
 =?us-ascii?Q?YO7DW9HX/SP3+N8luLtxx019MRe0jsbpp3FFqRSp62FKHSjvtVd+cXjuG/hm?=
 =?us-ascii?Q?offf40Hq8YXuauuxMZG/aX7nsCOR/gOCFaQnxRF60b1h7cKThvG1S4WsYZEG?=
 =?us-ascii?Q?IFO1Ynq82sJEywSz1PX7HALmDw1xQqISonVrMco9nY9BDFga48WASN9SBgHH?=
 =?us-ascii?Q?PpbTGkZK09Aiohj9FB4vEyRG/z0CJ6G2+T+IT8vbSPxgDafzxRyt8FZ6IkK4?=
 =?us-ascii?Q?9sBBe3xIlpEbyFUGplMbBmkRJDimfH0pHZNaCrrnHttJenkLrSvtaGK0jz3H?=
 =?us-ascii?Q?0Mx+zLPW8EKo7SyH0bTKkMGiYWkDDWJ98xC7hh+Q42kb9zRjvGIXxGGSoY8F?=
 =?us-ascii?Q?717m/8YLbAMhPZDf9k980baQH/MmBWlMIhHhmR6UYgcj8U7juOQJvCM85ACO?=
 =?us-ascii?Q?uX/JwTieDb1LA7/e3Cf+8pBRMw8Ub8Py4wTBP/wbN3wxsEeNwpZa9kzVh1Aj?=
 =?us-ascii?Q?eJ9Tc443BHzMKgIQXQiLmVXK8TLMWkPAM9wJBwWuKmhNxOiUAAY0ckmCF3DD?=
 =?us-ascii?Q?2z1xb4zm6YIVNzCZ38PjhCVxGKLEYBZYMdfwIJ5oyZsaJMeTq0QdGfFfr+3D?=
 =?us-ascii?Q?x8fIshsHKaqDVpHy9xLDXsG/1vUL0zfcWIvyg1zlp3atDOQfSZP4aIjSpsJ2?=
 =?us-ascii?Q?7xy63SW/777fNtaOLA5xrBnS9YsZZtzikEK1njkh3TMErDozwGwH3J/y/MQK?=
 =?us-ascii?Q?jiblLFBVf1pivUBSG2eXOA5U4KGyJCrFV9xLpkoiEzx2n7qXPwuQm5Jh/dVY?=
 =?us-ascii?Q?ht4Z2YdLIp/YiMDGKWok3S8+2EwCNdjDJZwSvKnAgWmiQsxm8hubZ3HPakzD?=
 =?us-ascii?Q?7qjaf1AW5pePOk4r6/Joi3AOxwh0m8S5SV9xD7MuLc0RphHaqNV+bt+XLoTi?=
 =?us-ascii?Q?XTGbSFpmLuDB/gi2LHWl1CQxpyd1/y2iwQop6/3mfVFgxJtNFKuc0xwZOAVt?=
 =?us-ascii?Q?TTO6D1fek5BmUbSGfTPQ8K9jy3DajiC0noLSxPtb00ezkBH7boiDoVDV85PT?=
 =?us-ascii?Q?jcRaP1wgNgEXuH4xc2+UwkVpoecepJyoOWH6zzpR+xjHjSJVS8SC9ZI+0MSm?=
 =?us-ascii?Q?G8Ady2FMQPvF/wPVUPqFPebgfZa3/xjEhBkwDi08Yo5txQG0DGSo9jB9m2Ok?=
 =?us-ascii?Q?tLR0sEsxcurPTACiY4v0vZrIVySdA/QuJsIvNCo3hoBiYeFSFI62Mn/uU4KR?=
 =?us-ascii?Q?KK/0FvubH2L44KBVUCaL6uBh1JOW57O56ZceHu8zIEqV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eAe0IOgOOXZepzAbQFf1D6iXiMpRkjsQMrK9usp3gbE41m/XuQl3ej1dTGjb?=
 =?us-ascii?Q?OUgOrHWzC29kXZUnnBp0BCvi4j+g8pLFbowFxC9yKPbPOIyZSUgiaNIBm/1W?=
 =?us-ascii?Q?6gXlcIirWHc1EyJkm0odyt3q5pW2s+Y/d3p2mAl6aVq2SuKS6/oLy3z5vF8z?=
 =?us-ascii?Q?vwl1WvZT6Q1ZkmQOG4Gw+RQ6kAYC2XGMpO+t6ZDwGjCpq8YZMZa8gTvoHNhZ?=
 =?us-ascii?Q?TBjyf1JSqypVYNQF24WF8KclHqCfDskAsf/Mc3xrjDzUbX8P8iP69nQILK+t?=
 =?us-ascii?Q?oqg9o+0uha1uA4n3VSjQNUUkdAyGgGau1B7Q1VXEF0IqIceTLaxrE4DvBUpn?=
 =?us-ascii?Q?3xrGfDXXC+zP8t8UvKe4s5GsQB0q35mSy3OdL4tfS5VSKNwyBAgyAroHRIhu?=
 =?us-ascii?Q?bQMBjdhZlak5IPTEN8nYusk0DgVJXgiGa+ZlrLqzoE1TwsoY1f8G8/Fj02vl?=
 =?us-ascii?Q?rcmQSnofy+AXW2IuaULkglqtFrwGSfzMbHiVqVJora5aJu4cDKLVWkmEa3w8?=
 =?us-ascii?Q?sznBoNzxRU8xyHwu4kKKMBsowVcitMd/rEAvGIKzEKuiH2UxVBOesKpNLZIh?=
 =?us-ascii?Q?pXuyICeuwDMRxw4xptt8zF5ReVLv7MQxsCEqDcWwCa2Hcbq92JxxCVudRQxm?=
 =?us-ascii?Q?I8BXYvsAccw0ZR7o4Iex7n5IB+UL5ncP0QmN+LV5CQJ53G3r4v0EK9fqI43A?=
 =?us-ascii?Q?0K1fwu3WU4uulGwEZizE6DuhmWKPMlGtoYF7nkpNVmCsUVlbast+Fyh8PpHG?=
 =?us-ascii?Q?Dja3xGMZ6ilfkiscee0c25mLrrbzouteNNIKP//vi8DsUEfY49hFSzWzSnje?=
 =?us-ascii?Q?Y3wqsXzKcU/dN1TSrtqspqeDNKKswWH/oaa55ZRtLhugZeZe7K4S6BJiuwES?=
 =?us-ascii?Q?aUGE5cewE/4ET5F9pCdEkhXiILSKq6LEdLwV9EvM/Dk+evPTi3vD14evtRWR?=
 =?us-ascii?Q?MVpnCmZ3Y4dTB5tqO6vtT8VzFgnm3maxIElh/OHQ3a1cNu9JdiaJ5oyFMu9J?=
 =?us-ascii?Q?BLGsZCOF6azvkt2x4J2SoHsgg9BZkiEvG94pYxEacXvSamKTf28TVPQN0mCp?=
 =?us-ascii?Q?B1mFC4uevLxfbR5OombcZNQB5JccYQAPQd2ZeoYvzgkpbddIz1Wj91J57iij?=
 =?us-ascii?Q?Z4fd/xOHzXCd9bqT6rjhRiykufLU5tkds5zqe+UEwL/pZFovmnpPfnAOgwjv?=
 =?us-ascii?Q?I4WHjHNlDE3PRFMhdpCIGwyM608DUgiOrb4Ilui/aBUFdjHP8SwJfjcfdHyO?=
 =?us-ascii?Q?PO0oRR9JtG4fbeGx+hEBURM6IOJ6EGptoS3tBiuu99B367WNW8Yt0gmHVbNh?=
 =?us-ascii?Q?pQUfluKllw6Oh5c7vU8QQka+pjU/Q05u0IF1OanP37IAD9TFvFj6SdHRAUzF?=
 =?us-ascii?Q?8NVvx26k1gFBAJG0UIzD3ax9kpCD6IgiA+os/fU8cx0iAWFFaz0twUle2D/K?=
 =?us-ascii?Q?8fy5b0mt4sVC0Ll+Y7j5jZOWIyD4LNxo3aE5pChXtrE1EO8Fx+t9JmttjdT+?=
 =?us-ascii?Q?cK+saWZ5/ZoCYMVSKvhT64wkIAtab5t1P5hmlteqBotsy99yZ/MvRE6Ns+/s?=
 =?us-ascii?Q?kdlz4zFQ8iPwxzUnFSpvJ7qupB/RgdNhsxbR5rR+lmRaY8iHzz0HIgH1/UKe?=
 =?us-ascii?Q?1gcf3aC4t73a9qyGzlPOsZi9XIvn7T2IqrpxQ90/p4dpfobyZ18FBHMm8Tns?=
 =?us-ascii?Q?g3bNMGMIB/hAYNF/lTP6PL5DcxUkTiCDVyGWKORG89AyxCWvoD10hE0xXIP7?=
 =?us-ascii?Q?OVsJ9b/k3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c09a33-69a2-47d0-c7ca-08de5742167b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:04:09.2488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oo8IBnbOo2h5U8QxemYVt0dV6NMWNtPqhdw7oBQvBw4AAmdPIPb0P2b5OZpcbgHmjp3USECCR5GmHyo++QxKXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and move the reset-gpios property.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts |  5 ++++-
 arch/arm/boot/dts/nxp/imx/imx7d.dtsi    | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
index a370e868cafe..e8fe57d6162f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx7d-sdb.dts
@@ -456,10 +456,13 @@ display_out: endpoint {
 };
 
 &pcie {
-	reset-gpio = <&extended_io 1 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&extended_io 1 GPIO_ACTIVE_LOW>;
+};
+
 &reg_1p0d {
 	vin-supply = <&sw2_reg>;
 };
diff --git a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
index d961c61a93af..3c5c1f2c1460 100644
--- a/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx7d.dtsi
@@ -155,6 +155,17 @@ pcie: pcie@33800000 {
 			reset-names = "pciephy", "apps", "turnoff";
 			fsl,imx7d-pcie-phy = <&pcie_phy>;
 			status = "disabled";
+
+			pcie_port0: pcie@0 {
+				compatible = "pciclass,0604";
+				device_type = "pci";
+				reg = <0x0 0x0 0x0 0x0 0x0>;
+				bus-range = <0x01 0xff>;
+
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges;
+			};
 		};
 	};
 };
-- 
2.37.1


