Return-Path: <linux-pci+bounces-45165-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E60D3A40F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 11:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88A0C300CEE7
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 10:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03223570BA;
	Mon, 19 Jan 2026 10:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vvyd4kF7"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB26A356A15;
	Mon, 19 Jan 2026 10:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817042; cv=fail; b=mdrDKNyyCmTsbaOJUmtsZzKVbU8e/jULQNZn2IB2nvE2JC0jswZZjpjKuhWJhwl3i7P/UKOWPTlNd6AWRsci/+vXOOvEaj4kSX1Rso6nUcTMJsBaTt1BbVSI7EXmjEJ5YNWFI3Gblb5SWPWdRQbaszB9FNY2haQskQognMaUYmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817042; c=relaxed/simple;
	bh=P3nMFHw3CwDOPfHrt0Qe0hMOARZemFsHHh/EDxEt0VU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W8OM2wPr6FbMTsZtCJIKgdrVZYoNYQU2HkOj8O1pZgEqNOEW/rt4Dqp4navXG3i5rL276LX7Zha+PJ2h+a7ZOfeIekhS0ab4XhMQBe8+YDys3GMQnWYI7lH3ME6qOcU8A+lqszlQ2m8bOEKKaU8ezvQpapfdeu2qQ4Rz+EdU2eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vvyd4kF7; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXg30ftsou7nFwP+75KIpubNeV9ti1gNnm8cy/h3dBaChZSvSZA7A0n5PwxYo4EPWuV8RGvMJmeAdLgoZWgfcIN7idfh7hKl/fJ0ca46xKdyrKHU/C2nKKIe9pGHCdhXDSnDyX39Lmh6VHIimT0EaPi2xlnIXF0YHnvZjKc666DHNVeMpchRvJ6OartDOoFQKrtQ7lffUlrMQQESCOR8Lwlcn5mF3uYqEzT8crYH6O8r/8BfJl/NOP2XEDcF83IYDb1uOpUXIvzeD2kQk7GzjsPteUm2sQHF4CDW2eeaN4KYYyL6iO9TB5sQobzNOIvqdFnn/uSp5iId9MRpvpB3aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KRIopMpflqfFo213m2yBFY09dXG2U34rhM5uBbYA/Ro=;
 b=PtgJfkj6HvKIX0ZRf7i3H7Ko1LyNLiACb930GNsI8Ow+osAYXb974yqJ2/FbaWjFKdnSE+69tqU9VC0sMy2F+08wjzw3gd+Pa28flvnHRkef94d5AGt+H415L/VNN5MAbJz+/6qgK/cT1873/fvCzm3S7upbX3jZ4kiGqHHInv40gAE/zaS6OG8qu0qRypx5SConqNSDhM/DV2QjP4O25Yq/oCNQrZtOAESS/fAXggxP/k1xBM8JtyxEXqoVgtQIeFvD99kmrjGWN8XwRGL16M5KHRxgZ0B9u+wLvTa525rWDprMkUij5N0/2S6gIx7Psb0uk9gc1eIvtAjsJtCJOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KRIopMpflqfFo213m2yBFY09dXG2U34rhM5uBbYA/Ro=;
 b=Vvyd4kF7FedlxshSBjaPD9P90SZUFiPcaSqL8CfoFp7Efc4KKA0FMhjrkE+4UVfONNxAXE8gkEhZ1IC26BXA6Sp+Cq2Y2mypu+902OIIq4CPcihDgGRdZef74aOwPCRQ/qbpUYikc6jRhi9h44qfWwRbLMF2Og8VUUZWgFDjhg+BQVCPgaVO/UuuP6nW67tDnw/p+k24JE1rVuOFDJss7LjbEv2sITEyXlKk/aoAFQUSFCMtNlotl7aC+q1K8Hj6YfPBv2KM7kqrDLIzKQF2Aih2FY7pX/n5oRKXrL6lbkDuuOIR5PrA2/sLkX0tBB7fQYHpEhgnMHFOTRLrAyTPmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by MRWPR04MB12042.eurprd04.prod.outlook.com
 (2603:10a6:501:95::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 10:03:56 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:03:56 +0000
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
Subject: [PATCH 03/10] arm: dts: imx6qdl: Add Root Port node and move PERST property to Root Port node
Date: Mon, 19 Jan 2026 18:02:28 +0800
Message-Id: <20260119100235.1173839-4-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|MRWPR04MB12042:EE_
X-MS-Office365-Filtering-Correlation-Id: cabb6941-6d64-466c-644d-08de57420f1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ri97yPqC/7aJ6i1ky9lSOUWf8rbacd6ISStO4fgvpzjqaCGy+NNdVSvqoQPP?=
 =?us-ascii?Q?NepqsvJGDnf4071VTgld0l0QUBO+SIAcSj8P7qmjs/SBIU9644m9g+B1Yi1s?=
 =?us-ascii?Q?43vODIz49tXVOBFTIqeRJKd3I8L94TYvfNCeBU1dHOTXYWdWIDSkPDfzo9bD?=
 =?us-ascii?Q?5l28ZdUtrRr4vCUI+v1tx/I8oSqscxgeiOB+bPezLhJsdsXVduXBz0Jk7Ifw?=
 =?us-ascii?Q?377WVNLfAC9WJybld9YTH6QmjvJFSl35X4DqkVT9vHqYKgiBWl6V/mjrVtLL?=
 =?us-ascii?Q?+HnFvffNbkVPHKYVc3YTAdpivJv+OJuly2AqcBUqTJyWDIyepgFbLBVWlouW?=
 =?us-ascii?Q?R96dfLf1u+bNPfy5sBEC9baq6yL+D+fKvs5W0zzCiLyciohj71awN7D6+B6s?=
 =?us-ascii?Q?ewZ9NPMKN5mAO5tTptJK0axFk9K4+s5P/BwP9ilWPm3OPo7oFXSbRpl9ct5t?=
 =?us-ascii?Q?PwttiP6YgVjxV4UH47AfKc3cC8UBQ9vkugmpabBs6naAwfsPeBGK/97pa9/L?=
 =?us-ascii?Q?w0tBJpTQmxhj6cSlSk0il38hHK4jwkGQ8sG5Y/Hoon/cK4PUXEeeIJ11wTAm?=
 =?us-ascii?Q?ODVGtZJJJyBk29p/u8hdLDPSo6cGsrk/8k0JAyJrVv2+0bq8JWX/qgu1Zwbd?=
 =?us-ascii?Q?vDE2p2UfxTAmykoqrWGGyEbrevC/lb8/gjwPGAq32/cvDpvem89mWe3z+xmX?=
 =?us-ascii?Q?ZDlduon/F1lylOSjSywVhKkh4+c/QsseX0AvZJqpW05hjpFZzU7KoQjAnvZ0?=
 =?us-ascii?Q?6CM+LWYWMC5z0kdtSBo/C5nystFlvaQM5g99jL4jIJ1hHz8XZLAunKN55F85?=
 =?us-ascii?Q?1g1VDDErQR+kvxiaJT/x9vjcCl3Jtd5esHdpCnVADqh8cjR+uG1IxxwfvgGd?=
 =?us-ascii?Q?6q71aqTKgZGG0iXudQK9POHHCj3zUyjEkVaqtaSShLlldY/Ek/irNoYnI4d+?=
 =?us-ascii?Q?NfJU7Jjmg2Cwjn+fz7SDI51C8jN71gwZiVGB89G4d/VzA8X+uCZmxrKDXXaB?=
 =?us-ascii?Q?JUg6Q4LDbwdycGR4iasEU8V9pLuW/YPK317mslutTRO2nryxBVad8eED9nCe?=
 =?us-ascii?Q?fKxo2Ahbcd6jf3bE5QHGW+OTZxH75xU/l1tfiAnRjCdH9kjr0UU0r+OSm5Kv?=
 =?us-ascii?Q?JT+Kgc216m3cpCQ/TXNaPF93Ey47NGZtZ/7GSEfk0JxYy0heXHLkqV9KXRJk?=
 =?us-ascii?Q?6FdS/3PFC36QDcXjFJGNKRwdXG9ymcknFbqsjn89z2QFeoYY5UHUsVnvhb8o?=
 =?us-ascii?Q?06WXHxJzKdtPCaQ6lCxk/A9wljqAeRQ1K68G77pup7Io/WH6zLxlBppRLyn7?=
 =?us-ascii?Q?PyyEzE0SsaZhGaVyzLFSbKzkWhozX47Wk7wDuZVoz8CUkE9vKizprmBKhhYw?=
 =?us-ascii?Q?BYKaFDv8ycD5yf7riloniPlY0XSN1gpH6MkyE8XvGJsMKVthR2y0mCb6gf3B?=
 =?us-ascii?Q?URtNYWyBN7KX9oFJqZPxM7zWtagq3QEtZcrar/hjZrE04GWIk6yl5Q2c9Kg2?=
 =?us-ascii?Q?LS5uSVANH0ugobvoTa06K4k5o2yl9vvuqmTb6ANmN7CdHiNP5O1XCwGybcC5?=
 =?us-ascii?Q?RYDC2kcExIPG77T4+v+Gman5lLv0jaFe15UPWpijhj2tptuvmRZPNLu3OMWZ?=
 =?us-ascii?Q?+glhKQOdkWdZlre4toRZDpOOU8bM2a4SR9ovaAgDIwrQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zWCk2OAlx6bnsb5U/UQxWkAS8zQp1LzxwNKXAPbTrh4JsOHAUPysKzubBagI?=
 =?us-ascii?Q?Ngcnqjg37IjbD5Q3eSjkv14gwSpEa7zI2m3UKopjmjOgdjPNSnRYXOOlQmdN?=
 =?us-ascii?Q?k9Ku0waPEKqX3V+zO2gDRcWuLoBoFRG2XXG1p0WwuotxsVLWqTufyTd+i1eM?=
 =?us-ascii?Q?f9WtuAWC+jieuSCrj8/UyeqatOEclAq8CVsxUZGEiwe8J2CsVXtX1uHdG5B4?=
 =?us-ascii?Q?uD/KIzHxuhQy2tfQSmG+YMhnqvFVHSDaSDQ6UBsmVmLhmML5Y+MgQB0aUhFk?=
 =?us-ascii?Q?uVtmmBzzwDs1lrBBkMSds7vJdxjyG2U+wHzlgpgn2rsfkIhX3ybWqy2RBZbi?=
 =?us-ascii?Q?j7KMTyhM4lAxUIOsNVyhm5Hc40fdjWQJRU4th0lQuNtv/Bt+x98Wi7BDTFjw?=
 =?us-ascii?Q?RbXcFJWsBh+7oA3cDMdfA+qxYumMpYM3lWz2TNTqpRGKlJ/5K4k1RMYFS8KY?=
 =?us-ascii?Q?8ZLrBGtjLNPtfoi1fx2ccBUmfZfC1/Fzx6TFDLLUPhk5NXt3JFkdjKC4cAGT?=
 =?us-ascii?Q?l/6GThSJvHlLHdQ0ve1e7MkmMOvhfLiy2iX7eBpGpoCWTt1C0qi0E/0EXSL0?=
 =?us-ascii?Q?4eSXGGQ1lfFrlLrQ0jqAoxL5XBWIBPWF48p5NGS7bFu+gj1DxUUOUG4Hn8HW?=
 =?us-ascii?Q?zYHaScNctdqndMbmgfcDwSLkYtvpVDq11kouiI0hd0cAaCi/B7hVsA/X36jO?=
 =?us-ascii?Q?Smz7PtB3/3C31ilt++lFYHQ+EkT3zCrh43TOQQFaaM42IjI954t0tM38IjVy?=
 =?us-ascii?Q?b7CkaFJZy/SXCUqMYDUmUOLDB5SlR1Nej6tiP51BSEDNInPfc8rLOh2eX8y2?=
 =?us-ascii?Q?BnpI3t3JCkybAbWmLS1lBIUaVuLHSsd0ywI/kEiigyjJCiP8AOCRrQiLTeQn?=
 =?us-ascii?Q?pbbN4I+dvPVj/LSGrIAB23eLHoKldletDYrDBj2XQNIzbyutSnyT6HoUe1Rh?=
 =?us-ascii?Q?+KrRj4fe+Mk3Yw02WJ9ig+lBcl1imlEx/vrmtWRn2ks+BGd/mW7Ak6FPa5Vw?=
 =?us-ascii?Q?ay9Gv8uymmRriVgKGiAbtcZXFGcFyo1ldNbutC9RKB+LDgbHrkWV4egbmJWJ?=
 =?us-ascii?Q?aJnTQQYCwD46tJTSMJrn0U9zFSuOVdAIPz1ydMaoqJG+8Kxtwrm52GXoOBEU?=
 =?us-ascii?Q?1d1NVcFO7ZdshXBN1KgXaYoBlJGm5J8KAg+AJW4Guyj7tH/LR/eGrqso3+Be?=
 =?us-ascii?Q?f08hXWtMKGyiKkNB+ewgjbNtmIGuo5sf8Nmc1Pu8K+btzyMQXH5kl4Or6AHE?=
 =?us-ascii?Q?Hc5Yob4VNZm0SD+DUQHtCZU3IDwC9Q+w4H4DpHXTI2nxWFLJUrAjlCKi8Mq9?=
 =?us-ascii?Q?m+/xwzU6POzKs8+NpVsVIqPwJQ/udc5cFAcBxRWSC4lAKELwlXEmgiK1ToqJ?=
 =?us-ascii?Q?Ph08dZpZQG6ww4GiYWetG+9+8LiWOmTFF1IH4EDOFRiodng/vqYxdu8sMbBY?=
 =?us-ascii?Q?o95zyMmKeQFvV7nAou+iNzvhUM0hfWAVEdUfPRo+AP1r/1mjYPyjiwXRvSem?=
 =?us-ascii?Q?0+tTuJh+PkwAsgiUXSH8zPIxVLmJOTF9c8HoofrmNSmDgYwV3FpvoYilhtlH?=
 =?us-ascii?Q?Zp3HGfkTgvvapuwT+VGnNbLT9999VeGzlwg02NXPlYyJgUOb4EyK1mhdzCIC?=
 =?us-ascii?Q?u8V9frhs8Xe5okXEvZ8egCzifzPt2hTJX1Vut7Da4g1Lc4zBdIbyhbAGLMnd?=
 =?us-ascii?Q?FviRmaKXjSfVmm+LO/bg2dyvFmax4/lf/1fIaH/O9M66jyk2ALj4mxEv0Y/e?=
 =?us-ascii?Q?1xwPYfZtyA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabb6941-6d64-466c-644d-08de57420f1c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:03:56.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2MvWAVJtlnz91q+2cuwhWLJlAUmkDxhtQMTlBPHGnoLEkxddONYEbtgV1HY4IN6Lm8Lw1Qu7fWkCmqONc/ZQSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12042

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and move the reset-gpios property.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 ++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
 arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 ++++-
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index ba29720e3f72..c64c8cbd0038 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -754,11 +754,14 @@ lvds0_out: endpoint {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
-	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+};
+
 &pwm1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pwm1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index 9793feee6394..c03deb2cdfab 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -287,6 +287,17 @@ pcie: pcie@1ffc000 {
 				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
 			clock-names = "pcie", "pcie_bus", "pcie_phy";
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
 
 		aips1: bus@2000000 { /* AIPS1 */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
index c5b220aeaefd..c35c24623d36 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
@@ -45,10 +45,13 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 };
 
 &pcie {
-	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&max7310_c 5 GPIO_ACTIVE_LOW>;
+};
+
 &sata {
 	status = "okay";
 };
-- 
2.37.1


