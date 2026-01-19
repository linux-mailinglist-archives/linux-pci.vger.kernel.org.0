Return-Path: <linux-pci+bounces-45168-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76413D3A45F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 11:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4196F31BDDF4
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C203587BD;
	Mon, 19 Jan 2026 10:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P48MHr7M"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D425E3587BE;
	Mon, 19 Jan 2026 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817059; cv=fail; b=Bhw+rEmQDIkCYMH02U4/W3ZxGGg6PoP/qxQkM4jOC2bMvoVQ0hkXDCoEBHblqiiCUs6PIFgXbDzC/4z0tLpqvGgoL2kTd6pvX9acoTbA5ag1/xqKATQUItgaP1lM9wCuvFEhYNQzS4apxLY3tJOGo7fZes7N3nnc+sPWTEt0svE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817059; c=relaxed/simple;
	bh=F05LVtXVIxb9iJmJRrpikAP/h4XRdF/UF8qlpUQLK9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CkZw3pJFuKMzmihz1hcSHcgofg+od7qAZbaSTzLd9H7Nd3Y5yf9e8wMIb5hggHIddDJm1l2OZwkpCXJV6BKf2iu/ki2EcLgl9zBulNlRcbKcKBa6+czNuogcZaqc/dG9DjpKRquASEph6xXMEkJ31UxD8s7L303U9RG20V85qQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P48MHr7M; arc=fail smtp.client-ip=40.107.130.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A2KrkkFIlGXQETP9A1el6ojnoBmtejmEeqN3cB8xjwmUlbprapjR+LoGZPN+WdqH7XfCRK/FPFgFDjD/wMRGQ0XKt1a7Kj0GxPUc6MhZUqfZ5QKIBQc/7110dme2GFjEJwB9rO5ZAOrnBeoHvQcAbdtWJ/svVdG58XSJV2SBRn8ZYqrjqtiuxM0q6i6YAVEwup+yZXeH33qCXm3mPcS4GTJdHUWxpvQKCpJhP95YSVaec5NDZYaxrwQsdNCXlfc/ZsjrVVkSb+2q4FrNTi003w+uprpRkz7dKh2mti9LshCY095D9CrkTOqblB2FMUl+jgwyBl8KRuM03FxuNT7eXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc+sfeLTMXzO4d2T0CwwU3vLAVt6UuElVlnhVTtUXB4=;
 b=oz5sQq0KOUZ7DN99uYeIVx8cT1M59n/aA69T2t032SIt1B+Qhs7LU4hv193a3/Yw2gJE7WZcY23XukLxfze3cIwbjZktEbhmitxR2z/b1F7NVyUFhHV/+1LgSkCVx7FzJhAUuVVtYFGPoYf1MhR0+jt4Pk8quJMeri2Dsgvb7RlljFq1BkzOpzBt17Bzi4j/aneYp1wdjPSvLC8QsqadI9LbFP6vECoiwOOjkAz537wtoJqojKDDFYloDRhT93aBIJvtoOMoPlXZ0VwNWYrRISs+B5VWUgrRjODrwSsoFm/lK1ntdKJWus99NCBl+ktdPpptjosF7teMcnNio16tSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc+sfeLTMXzO4d2T0CwwU3vLAVt6UuElVlnhVTtUXB4=;
 b=P48MHr7MYdt5Ogm/pjqEVGkQZQ6jVxBI0aiyHUDL6B/DCRen2ZZmDbHpE/8tln8nDt7PfbYLRouGFB4LEm6ETmyK/5u71VfH35ohW0dAocEXtlzaMCqF3FtsXZYVIriHmRGm3C44Qqmdk4tud4JygYcdTGOU2pHt/OQBVNeoLAV5BCQC464z5xvmmJC1Gdn2jc104Xau3jVRMd+XlLpc+pYOF5nMHz9IaiK9fD3gURfYZAuMLxGY1RNCCNVPFId1BqB0p3Mx38dUhOa0bNw7LGV5pENyZyURvX58T5iI6DFJvi4Ua7lveukUWRL9ZuAf29xu93KWtriSXZnmL2quPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8812.eurprd04.prod.outlook.com
 (2603:10a6:20b:40b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 19 Jan
 2026 10:04:15 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:04:15 +0000
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
Subject: [PATCH 06/10] arm64: dts: imx8mm: Add Root Port node and move PERST property to Root Port node
Date: Mon, 19 Jan 2026 18:02:31 +0800
Message-Id: <20260119100235.1173839-7-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 274a49c3-147b-469b-0293-08de57421a1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5eaOR0wsmplIos5lIpPQUy4TbXMnq6P5vs13xN86ZdRuWoucl29XqzPIC6PX?=
 =?us-ascii?Q?slix5N8g36S+GV2uxjH+l/65GREggtWBTmYuyWYHq6Eeo8vE+4mshGC+iJpS?=
 =?us-ascii?Q?VLLJ9lDvvHs+IAqgVedjVHaDGAp1WUMK5e3JhFR+qQjh6Oi6Fp532hqv1K3i?=
 =?us-ascii?Q?obVADTj9zx92uvRlwZyUzJJevJKAp8kDSo2ZEnAodgMwhFvHAvU3eRd7zl81?=
 =?us-ascii?Q?/DvaJK/EGGuoBxs3gsWfPlsKIbThvgybISwpvQxPquRDlaTGzrkRfdirwViI?=
 =?us-ascii?Q?66vhu/Zz/CK+hOJdDEK3ebn1mdCgjb8WvBeApmlBCIQ1fmHvQRcqf4rcvxWJ?=
 =?us-ascii?Q?ivXy4oVOc+JLfsSimGF4OJhren24erp40G+NHUIj4t+sMx1jiwWSVSA6jCa7?=
 =?us-ascii?Q?XMcDm7llFGowZLjCVQq6kQiUYutvXsx+r2o+Ewx1LtqihxUdck9f100afj01?=
 =?us-ascii?Q?j3aYvHQCcnB1ytu+4P8YHkJgE3lacRTSteYWL7QVSE055NfSs7GeHOui9TYp?=
 =?us-ascii?Q?yKt605dMZZu7srHNeNIWHu/P7Fic8+nQqhiIqck1VCC2JErue/8eQ1Qxwa/b?=
 =?us-ascii?Q?EN7Yl8i0riLCUReYrOEqHodFX9Otb/tLa5//rYqJaweYpw+Sk9AAWzEdE/Su?=
 =?us-ascii?Q?xyuRKLxUNekq+9OhbysRAPX4MDe8jv0/nLaYa3Q2L6YAhr3j0FOcqh/St/Sn?=
 =?us-ascii?Q?EAHznKbw+mbksE4vmR3BdQeZL3fNtrUpSQtb0arA3Zs8L8SJTmVhw8RU8RC0?=
 =?us-ascii?Q?6x8ow7965Q/EqbW0t/qC4LV6TbPSf9Z6BsirNZpKybCZ42pshuTUFqe/qOzh?=
 =?us-ascii?Q?/z27Ve8FeFKvEvCY04dQ5pzVsr31OJ3FeN/EpaM6wo50tIiLpTuhn/0Ss+r0?=
 =?us-ascii?Q?Dr7H882YRZ6US5GyHCQMcTDBGLAAn1M5cdmuO2ugCP6KGnE+j0e2kJ64t230?=
 =?us-ascii?Q?oDMOGlDv3hkUKRggn0z1EDyhSHeBWOYdjOI6RDiJkjba80AUHpyloMzBaOFx?=
 =?us-ascii?Q?y3WwNJAowUFazXsw3JhJ4gyz44+gCCR573s9K2bA/v8Xfr0VVAg8kSF92yQU?=
 =?us-ascii?Q?wAQxbK98lGF/dPvhFcFbmeVcPsk0H9k/T6aTHWPKiJ6SH6e0bkB2Z7PDBwku?=
 =?us-ascii?Q?TdKNUqMDnuukBG1Vdyz3SCqKv0ncPOfDIMeBpnXsXjdyRaJr/WSOget4gsxS?=
 =?us-ascii?Q?ikfMd38R4PyBJL4xDUkWNa7Dut+YgfGO/DFv27n3fzSbO+KX0JN+2l8VCQrT?=
 =?us-ascii?Q?0IAgSJM5nGCZVNFrg98VmuYt2tZtCcdaVFThbv9v+2k1agdxcQ27FU1Q3BiK?=
 =?us-ascii?Q?s4ILsyhaCkd80tJhMKfp5CMj92zBsh4pEYOxKQDUQuU3xSsDbZH/d1+M63w3?=
 =?us-ascii?Q?1fvsOezUjhEI+0nS50lFVMaVgwdrEQbHhp67dvCoTvP0xsie4dl0loqtqFbS?=
 =?us-ascii?Q?aPtDDmn4rRaVl0RIYa+JPL5NJnnMKV20M+z/IXzEopb1ieCHtR4ZQQy0BN0d?=
 =?us-ascii?Q?JhajQtuv3IzJQSz61wT2Y991PQ16i6momFueEEndZGplcDrnNWCVilRjvarQ?=
 =?us-ascii?Q?xIa0h44ulzWbufntM/z9nJWeHrHlbrH0ZWy2/C0GcC3+3n852Z7bI0aq8Nis?=
 =?us-ascii?Q?atlCGD/tGCH9xD6G6uRyduO76cx+/X1E9wFiGvb8fbfr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B7dXBxPRtH8sFGQWSvHQAO3IJirk9STazV91UmEms1rLYRRNeYqkwmAo/ZDp?=
 =?us-ascii?Q?ERbAs6lbVIRa/L/nRFPykX9Ix++xvivi0y0TFnR2KiMkjQJ6R9IiDXVEsNZb?=
 =?us-ascii?Q?FIIaQss67YTQVSX6FQklaUotF9QNxzNizXpwdGZReflPE4YuBCKNWbLCqsj/?=
 =?us-ascii?Q?AIVvY/zM2O5gfRUbc6aBYw1w17DiqggxExVQL3iIuXuRmpUzoFPMQtR8KBIX?=
 =?us-ascii?Q?Eca3y5AD6eVlLqMej8tamB6FirWBTFnRosTLhzzPyLowvkqHa2Ta4WjCodxf?=
 =?us-ascii?Q?Aw8okxLAXLPjXYA4BIjY/ycRL3XYd3wZCj7odPNPjJv+TvylMM85KRC3UkHe?=
 =?us-ascii?Q?uXtz/+UU0Kdv18HxMh+qhAllUqN/7klUf74xYOSP8INrTBAb77xJTJOwZdTR?=
 =?us-ascii?Q?kUmOp0w3GeWvC8FQMXM6s0vrJ/Rjz6ILYRSnwkXDSZdmP3G1zAZnARAh/S4x?=
 =?us-ascii?Q?Sxn8ucpFgoH6AOF6wY6UaW3gLEYZgQG4wzyONd7ftnq3Vq18R7/VGJ0MBmZt?=
 =?us-ascii?Q?pTwoxwZgvQqt53z1BOonI5U+X9SwM2NCn0smPWrgLB7KIDmybln+0An4+Bxg?=
 =?us-ascii?Q?9mrUh8CxQVQLXV6flelMVN6exN1ZIuegpNCqEG0W0KJoeM+Njv0TExV4owSH?=
 =?us-ascii?Q?1pYwN3p99IbNNpqUJFluhUnhSpLq2ACQy4oIz9zrtbe6+XRAve+bdpy/N2bG?=
 =?us-ascii?Q?wb74HwIJPAqJOIrgDIYiQkt4o8e6SzmTPNN/KBMiPGSNG9Oh84+BW5Sr+UbJ?=
 =?us-ascii?Q?eDIIO9gTefaP3w6z8k8fPcgbm4gfUtFVwEgbMk4bblr09tH1NCNSW1WfWIfM?=
 =?us-ascii?Q?502+ha1hIyk3+OLZ8R/DQ5He+7e0zPyF9sZnqYSs0WgcvXifW7OH8QXDrLTg?=
 =?us-ascii?Q?Bp/CfjYCAlnId+MPM0qYRq0JoZkw05xDYx4WV5Le98W3jnJ0CehYQ81mUL5V?=
 =?us-ascii?Q?pXpLeOTgboD3x5gl5Kg2SQgjFo/IQLN/u+SStNKao6kZsB2KUz2ZbM9gv1pH?=
 =?us-ascii?Q?E8fjZFCZI2btdJMc5i6yOdcgg8e87GfrwuIxRdz8AYk6lunGcViNf2hIoLDD?=
 =?us-ascii?Q?/x1Xhhd9hPp7LoeKbKLpysGXeCi1RGt2qvRAZl9t7APznOJFLAEEvYmy6+8w?=
 =?us-ascii?Q?WqSPPqNYDeBXULCZ6nol5YdP3CqCbVlPcEMULxZHHbFJel6ZfUK194tmOvbB?=
 =?us-ascii?Q?a+gIfNw/CczuHrzVbC0rv3h7Zl5B+a4OvxwwG7+ldx4XgVXyrqQCyH+T+gi4?=
 =?us-ascii?Q?ep9vxVe547bId/LXv6iMlb08bca/NQlkzPQHCt6hYzWRQCiIfBMvZPhmqIhj?=
 =?us-ascii?Q?tbkPJvwOZK58pP0uE396BSPlNYvvRILjlRTPgqGw8cMd5VioTKamvdQFbWZW?=
 =?us-ascii?Q?edHSR2kppso22fAobyY2ksOQoQ2X5tT8WxJS8v6r7JtdTleBFN7IHEKyh9mR?=
 =?us-ascii?Q?g9nmlI0TWSbDUihxU/Lk3WZWoVwm/eH+2VHSI4bAyqd9bwBQPnnS08vrodNi?=
 =?us-ascii?Q?tyI0dZKY7dSM6G9C0KOS3lITN7vrO95YktjPGM753PNjHVQOaoftvm+KPPX9?=
 =?us-ascii?Q?d016f9D1/JUx8P5XrJPKmNvw3e3kXUtKxiKxPuQiO5PDe1YDhI99n+vh6Nxd?=
 =?us-ascii?Q?/oePlPFPsgwZoYA4+W88nW+F761mDtUdLiYlWTOoFS1ShDUf0noA+wJF9yqY?=
 =?us-ascii?Q?aj+xmRxKW1CigjMtIdb4dYinL0mGQohUMVLQKJdxGrHzU9i8aJPnuzBN8kwM?=
 =?us-ascii?Q?zIFsLrRq1w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274a49c3-147b-469b-0293-08de57421a1d
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:04:15.3391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBiX2TxOWp8tegcM9d8i0etxXf+SfQPiAiJM7EWCsztCLu1A7zCtbtuBVzrLeJ722v0k62jlNcveThBlIs4PsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and move the reset-gpios property.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  5 ++++-
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
index 6eab8a6001db..9cd5c4087c86 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi
@@ -533,7 +533,6 @@ &pcie_phy {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
-	reset-gpio = <&gpio4 21 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MM_CLK_PCIE1_ROOT>, <&pcie0_refclk>,
 		 <&clk IMX8MM_CLK_PCIE1_AUX>;
 	assigned-clocks = <&clk IMX8MM_CLK_PCIE1_AUX>,
@@ -559,6 +558,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio4 21 GPIO_ACTIVE_LOW>;
+};
+
 &sai2 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 9f49c0b386d3..1204cc4d3f37 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1369,6 +1369,17 @@ pcie0: pcie@33800000 {
 			phys = <&pcie_phy>;
 			phy-names = "pcie-phy";
 			status = "disabled";
+
+			pcie0_port0: pcie@0 {
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
 
 		pcie0_ep: pcie-ep@33800000 {
-- 
2.37.1


