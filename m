Return-Path: <linux-pci+bounces-45170-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B337BD3A420
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 11:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DAC10302E9C6
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 10:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE15357718;
	Mon, 19 Jan 2026 10:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mbywXWyl"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010066.outbound.protection.outlook.com [52.101.69.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C552367B5;
	Mon, 19 Jan 2026 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817073; cv=fail; b=oIzSz0QTaNX8o/AszfW6KPYwN0RwnqtZbZbyJG+P59FSvs3HFWUsv8UILyelw/H/shYLWHoBcmXNJaVi55U5p8NA1v6cqdFqmLl9Hrxyt0V4OSdQ7C3IOrel2wDVDGrGCWVrlvt7dtKnDKc/Zes46DLfLWgRKgAlXOfmfakDFbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817073; c=relaxed/simple;
	bh=GREWbiYRDM8xGZPbrvsofrZLiI2OSuUUT0Ub0vB0VKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sVS8rJ7qc+wRPpML8kqS7QxGayoXzjsEU6boKgAQRPVyxMi2luvxP+fIHEaaJg0sESgsKkO+acf8ppZpVTKb8DCKRFG7IMgAAOuRk2DIWZ2rJ9a/jEaHv9ygbdrba4puxmDYh13Ire1+7YmBMtjeMRY3IoBUASxEFRm3CkZxhts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mbywXWyl; arc=fail smtp.client-ip=52.101.69.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6z2LAEUsFEqs/tm35E/8bF3jxkUdDDqptb2wEOPEZDncnnIvQi4GACoaIfiL5bh5HSLWeIlX1Jrmw2qbUIRNbF8q21y22n89KJCWCj2VAubV2EhftntQYFRqwhZgEu4cfmqESTI+4/MUpmDs0auFALMNr5NPxVXZ/BquoNQpPr1EDKZZNerk1QurO7VqS9bF6f2YwcooESeDI5L/D9sIewr4tOgRREZ1i/d6tURCWnk9AviTZT6xTG/2VAYbX8/tZ/uEVmXEwOfdrrQZeKchwZTSzZ7QFQGTMvQOBPFrysv6rHskZe1cbZnDXtHq6cahgetd14N3cnSS9ouwNgglg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieeZaiIc2X6Pg2qHiYZWdsNW48BeE/XLvjuVs2hyk0A=;
 b=iSrNFDl+8zmLIRly34YjKw6v1XLDFJgvYIX1U3aT+50aJJKOpcp68J85/w8j5/rS+eHZe2U36HQzOLuAwkOUC/K/42I6bUavuQSRYxib3RhVAgT+4r1OwB6Mm8iiwv3acpbdPx48qO7suIWsx1XK3xxd1MSRHVnhGJJuT/eECW/Czr5b7k20WYQ4ay0t9uooNEabi0yOw1k22mnSMg0VSkJJ3UOLM2plU/G/W/BKxsEIpxpKl9xiWEwIYyKz3mNmc9f7cgEBC7r4OJuxEv8p6RYeUWB8yS155mjS9PWS8zK79eOucxMxuYdsTM7/jW6u4K0GWN5SoDWkZXtFo0RoWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieeZaiIc2X6Pg2qHiYZWdsNW48BeE/XLvjuVs2hyk0A=;
 b=mbywXWyll9NyODIYG5AIlO3J8edAAc0FVz1vCClQXQyqYT0+ZK9cy82Iyp8pI9TP32JsNNB+bFjmebBbHM9Asb3VUl9InoDciuJryJ+LLlWxI+O40kSgEeupJ0BYGtn1y0XqWt4LoS9YRkzZy+qOQwGW31/d416+7xv55Au0PZfmq+cb8ndkPnIYtqB0xxM44eW36jlpiisNO5zOpMziTykRd4ipYVjq5rlze5d9P/zW/vheVYQ99Kc9an7/MSE4L6eIFvT3WDGuofi3cC8DVFLjygTJKEMZ9S6v68Mp4EBprh6b6f5qZkelK7WSilZkNo4DzXVAeZjMSSNtn24nVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AM9PR04MB8812.eurprd04.prod.outlook.com
 (2603:10a6:20b:40b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 19 Jan
 2026 10:04:27 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:04:27 +0000
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
Subject: [PATCH 08/10] arm64: dts: imx8mq: Add Root Port nodes and move PERST property to Root Port node
Date: Mon, 19 Jan 2026 18:02:33 +0800
Message-Id: <20260119100235.1173839-9-sherry.sun@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 049dcc7e-5734-4c26-285c-08de5742218e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|366016|7416014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UWHoScJgtvjjWsbDqM2yq2+y7CSjr/OJtA92axb56IuIawhYN4ABFWdAl3P0?=
 =?us-ascii?Q?NMPpRFHLThFsmzNNO3Zp2ejniol40SqzWCFtLOx0jMdrp1Kc9hcZO0FQVaLh?=
 =?us-ascii?Q?vjFYrVUxb/iNgw9+Jlo48F0lvSz1LKRkEHZLrc4LCxF+iRg3VOfDgfTJmvTD?=
 =?us-ascii?Q?WHuhBZzCHVZYfVfACE18kh5lliJErIKVD5HJSO53JsoWI6DCJ91o9+hnA6lI?=
 =?us-ascii?Q?swHvfl+4RZrxUQCgeEGm+HOcRlH8OQ1KnopDqSE7D97rbNDPLudxqGx8otCI?=
 =?us-ascii?Q?J6koYX0dd7q1ErkGcdrj07D7l0cmLvf2WPQyFT2dP+H8hlmzF5JdwPOUMBA7?=
 =?us-ascii?Q?LtXLTaK77YjNVwxbYSgKaa+FEUsnk8CF0QCWt5Od+CGirJjsJthPl5bx5Gn4?=
 =?us-ascii?Q?b1/nWx+lda180a71GRc4a20+W6eSeF6UnTS0DAUdhA4+3w8nwpMqQkEBjsAD?=
 =?us-ascii?Q?9CcVZ0cRFxsP+/RcUI0BubsV5iP/b7OoYCSjdKvlE4gXS6j3ptkt06eZA3Oj?=
 =?us-ascii?Q?6jojhK/Up0/GbPaHuYW3/fr0OpU5Q/KsbC64Ee37aeQR+/en9SKBr6WlRJOZ?=
 =?us-ascii?Q?vcfdMCwWnR3IWBsDvcksoODnL+adibRBngZUBuBdYmKERS5sliu+mAtRUq7l?=
 =?us-ascii?Q?dw7ieNvzPymouAuXm07h1jmoUu5aB0Ktoi5NvxqrJHXMkKlNKCDd8jtyHmZd?=
 =?us-ascii?Q?iOg1JsX68XcGhHKG/ME8Ga56ttnpqyiQxZHev2OoHmyFhhTpM1iH9e6uEEYu?=
 =?us-ascii?Q?M+28KSlH8mJT3waW8kVa5v7pDE1SpQPyY3MR48+4Po77bWGrWcCY700xfNsY?=
 =?us-ascii?Q?Nj/AuHINp0jL/kWy6RDWvJS/kHZfTHV8LUOhQNKK/UECstwiLfEaGN2vNuzk?=
 =?us-ascii?Q?mfl7/vlO1IE7vEfs8qiENbQeuKgChRtysgdipGjA7wIuS2HgNLPjiNhr08jq?=
 =?us-ascii?Q?Z6bMQfQq0r/X5gXzuNd6gcNrUFwRrVEVG72l5O3312eCAZ4Co5v3j8P90+v/?=
 =?us-ascii?Q?B4xGdFnon2Svy3wJaXZQmRIP9nCQlXimmETKJgJbDWoh1xK6HWDBw5NYhLaI?=
 =?us-ascii?Q?+dTUw/GAUiqs9383H2uk063UQ5h/GNrUhxpAK+8ibNU9x5jZG9vQxq/oc/Nd?=
 =?us-ascii?Q?Sp1SUf01wQXHWZT9OLIhG47fY3FnzugUghTpHSYDAzKIMsvEtGXBWwCRUSXi?=
 =?us-ascii?Q?pX6wRCoi3dIsAhbrB2s7GrZScHjMPRLjGPw4f1mSHMBSsmM36JoDpsZrkq3P?=
 =?us-ascii?Q?0PxS2rFMSTVjp/K/nTikD+8GB3bPPDS1PnXa1PxCp4xOpzxW8J7+26wzXyCl?=
 =?us-ascii?Q?xxj1AOtDchSNwONH6p76+L+0bDH+y+W4VrlraPZarkdd67hUE6cSdEandcIn?=
 =?us-ascii?Q?99GKgyuGV3+ufPfrNPz0nKQCX0ICiD9YirVaot9Gu6Hh2RvJG6kZu2MOlTtn?=
 =?us-ascii?Q?cmjR3lHGNvFjfoI2WEapv6EMiqpE+nGcjvUpZVjwPXJjGWrZeNg7aGVGyWkK?=
 =?us-ascii?Q?z+hmHW6PLvqRXO7wjhiIn5QoRugMpL5T6i/P7Cd9vmjqdMyp87v4ySWBRRkY?=
 =?us-ascii?Q?dQa5kyMeBHo5ndHHMW9HokhkWaeUCFjCMCC6Qv9BecYEtONZ9YR/usNQed1Y?=
 =?us-ascii?Q?SEajS3pdu+QQpVQRirV86mBkLgnFp0kahQCvIVcl/zaa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(366016)(7416014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rSQ9NMUFtGwpnwzAtem5csAn3r2Lpy+4NGV8oGxu/t7iebywZNJbis3nq6DQ?=
 =?us-ascii?Q?jbmoUf4R0ARo74TEccd1YNtEZlxpEjhb7O6MhFpDw476QyzmHpsmIeXH0ZKm?=
 =?us-ascii?Q?i4XSpyWnucuVUNvc+L4gEgnkzsPnHBwzFDuaTh0225uNCxn1L9ZlYyroh5ZH?=
 =?us-ascii?Q?JIDjTZZBJvASr1lyZ/G9MaoXTBwb3VhEkw+848gNHFfVK4mFDFm8/Hd4uP3I?=
 =?us-ascii?Q?v9M7Sfj1XOnsYpm5X3wfAA7cBDzQEpFVASLIDCGw2d5pNc/dbYH09/CFoWJk?=
 =?us-ascii?Q?8Rbx5qKS++PiUPcrSbiHGfbdLvzsSjvMiyE9WiRqBN8jlQlD5zrSyllxmWLI?=
 =?us-ascii?Q?4Soeh5sa6+b5NaRU/GUvZJNAESsCRmNm9YR+cN0ZuHJZF8kczZrBJbULrsS9?=
 =?us-ascii?Q?kRT9V+i4fEx0XC/lCeBixG6qlObFYbsvefoKemgHrdzewMvsEbN+exkXgdMi?=
 =?us-ascii?Q?Qnps7exmy2LeeN+c2WTMz8Hs8CSUo/ELoaTt3Ao6xX3NBtaWMLJerS5ZScny?=
 =?us-ascii?Q?RutDLZ/P0FrwFWN2RORLxq1n7Vx9FgVdzGKQ3bfwtquQBtgfAS9qAMSKPoH1?=
 =?us-ascii?Q?0qgNWp8/t9icLi2ak0LoqzXW0qKwEfPLmcM3YGwW8dYD5P9Yo9zJElAp3R8V?=
 =?us-ascii?Q?etl5RdHeAZSrqyQdQm6X56tSGUkTSebn6RMy7Vmm7XTCsvZLp4I9d4HW4qAY?=
 =?us-ascii?Q?3HtaKG8CS4mdd1sCuoxZb/9XsiiUOyKcaWMIPU5iOGqFonuFoA6Wdo65TSNH?=
 =?us-ascii?Q?OFMsguhhDd4GS4AmKwbl8J+i5vapVSJt90WkF0nJITJ9iiRgibGSX5ksRc7a?=
 =?us-ascii?Q?d/n828xQUXL3cwRX4jGPNi+Z01GepB5mqasoB+VXFbf7rmAjgcWrTUBOQbMQ?=
 =?us-ascii?Q?A3oQkXVJjtILDfWFp2MNwjfVzvWZEz2dcu9w+gY//qDY90T8ciHC8PJabdYE?=
 =?us-ascii?Q?tk9zB+IsJ079PG40j7WoUdu8D/VjEA4DRlHlugFOXpBwS9P+NvQT2U7diYXd?=
 =?us-ascii?Q?krLv7jlby8bUm8DaZqglSTJGpFyIzsxmk8uiuPw5tAaY6aSVnZB68QVCXDCv?=
 =?us-ascii?Q?Wr53Svsj3EdvV4Em1RUGzEiyz54zPjXXlCbwYuG3ppUpn6sI83OwCYlgTPhy?=
 =?us-ascii?Q?IV/GT2/U2uJcptGmbAN/AyWNkVoD3dy8KxjycGDbvBAuwwPrR1Zs0eF7rJkR?=
 =?us-ascii?Q?oFXOxhbYntMK3LExBj85+4LVrLNlxmBtxPFXdtwAlXC+wi8tcgMb/n5A6Xaa?=
 =?us-ascii?Q?PECncETvyFgUhh4QV8Dy1W+XEIuc19SwnQ4ytv+g/R0krYWXmgFzgqksMNJ2?=
 =?us-ascii?Q?N70rykEgq/52XIIxT7y0Ovtst5v1/hqmcktv+Cf6oVwpTdScuv31ccoTnrMT?=
 =?us-ascii?Q?KUpUMS8i6Xk5vNeOUpcZKssUvo7XPlQVM15TTxzqLnu1aVLjQkN8melFSN/M?=
 =?us-ascii?Q?ghLLfUdabfLKyH+BfJau15OJsZg7sN+UgptVAkQsd1YAqY9ULAfNw6E17cGt?=
 =?us-ascii?Q?mEKXelV8bH0AMWcmap11gsuuUOxNsvrCmmxpiEQYxWkbQPE7+2sAk9jDj4Yb?=
 =?us-ascii?Q?DnNCZXRZo/TwR30fMi5L32ync9nWR9kGjchAc991kTIF3CLAGEsE9u4kCYVj?=
 =?us-ascii?Q?wwTkPIf/AIDFhFXnVqX9PnKScsxlPWrALv1zvJKMazFjpoupt0xvJPnjU6D4?=
 =?us-ascii?Q?liMmMo8Z2O1FvmY5oO32nDBW2IIbUtKFI+nr3TEqZRDJg/KaYe6hMyUsjUUm?=
 =?us-ascii?Q?lOKsMbYFCQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049dcc7e-5734-4c26-285c-08de5742218e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:04:27.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMNhjdHfKNAOSShSrYkETGBxd2pyJ4VgOkGkdUWMlutEqG04wLaRs8AcmuRxWHB62jHfbkvrbn1cRMQ+/HsfiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8812

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port nodes and move the reset-gpios property.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 10 +++++++--
 arch/arm64/boot/dts/freescale/imx8mq.dtsi    | 22 ++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index d48f901487d4..723b34100a61 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -369,7 +369,6 @@ mipi_dsi_out: endpoint {
 &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie0>;
-	reset-gpio = <&gpio5 28 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE1_ROOT>,
 		 <&pcie0_refclk>,
 		 <&clk IMX8MQ_CLK_PCIE1_PHY>,
@@ -389,10 +388,13 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 28 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie1>;
-	reset-gpio = <&gpio5 12 GPIO_ACTIVE_LOW>;
 	clocks = <&clk IMX8MQ_CLK_PCIE2_ROOT>,
 		 <&pcie0_refclk>,
 		 <&clk IMX8MQ_CLK_PCIE2_PHY>,
@@ -414,6 +416,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
+};
+
 &pgc_gpu {
 	power-supply = <&sw1a_reg>;
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 607962f807be..de2ba4ee9da6 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1768,6 +1768,17 @@ pcie0: pcie@33800000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
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
@@ -1846,6 +1857,17 @@ pcie1: pcie@33c00000 {
 			assigned-clock-rates = <250000000>, <100000000>,
 			                       <10000000>;
 			status = "disabled";
+
+			pcie1_port0: pcie@0 {
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
 
 		pcie1_ep: pcie-ep@33c00000 {
-- 
2.37.1


