Return-Path: <linux-pci+bounces-45166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC85D3A444
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 11:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41771309D0F7
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 10:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818CC3570D0;
	Mon, 19 Jan 2026 10:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UaRYoO4p"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D971E357A54;
	Mon, 19 Jan 2026 10:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817047; cv=fail; b=ZBU1sXj22KZiMrKsTTYuL4rNKqO/leIvO3ZMPuyMrIbm7E4pH5E2Fb7YYGON0RCjHjiEggJXoYbp/YIT6GVTulHFKx1TsUD6UuImtCNLj2ctF1y+2ir93kRLthAu1N8yKFJ4NXyZpuQrNihjCWsUUH4smQeUk3ZKeLnFN2k5/P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817047; c=relaxed/simple;
	bh=YaKa/+BbgQUFnYcBvlVgACtastberpM/dw6s4pKmj3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DF7wBlqmGP3BuwojBvJJJk9cp6NLGhWHMSvo0IEFIaJZTWIm498Ddq2OXx9v01afaqwMZSqKtFDyPxuovA4dxpnpCCMM+PtsN+jvLyTRWYxVFz2vvtYQyhHOX0zhe9YkST1jO53WNyaYiWrLzhBi5xirTCNCJzS7ilqoD93q0mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UaRYoO4p; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OKI3+uPJjJrgTYz3KxdHA187ddQD7VTZv8wHM3QaXCRPOahEDf1GlmKMCgnIA9HINfqco4DlqeinV2CKeMgCvhzy/Xl2/H18RG0QOJ9rBgfDbJJbFbGjXTJL2YFl9P2hd4zWaiTPrw+CDxD1Zs4+X2IgfZliJMIo2s94W/6o5VlnG+X6fkm8iKV3hhHu3LGkOcLzibs7zAPptpF5UhUJFxX3+tjUw8Md2/A9ys7NiYtmR9ef0lLKAkZUwQrwKjOZM4oQAbDvkQTgPuCbpz6+yC5Mb9v22ULFbOkix1KMBI8fLJRiSUk4UWLAuyHWAtTGWy2bxIe1HM6iALgpiveatA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m/EGs9sCGFI1zbYve5gscLLZr1XqhytJJ2un2obA1Sc=;
 b=kMPgynDu+aC2XW1wiM5rE8PXOcsxaiIBzCsIkUrtk9ZF1CmF/iI0i3L9qH8nLnbRUuNC9+XTpdu1oNyHStwqPXTPakFc5pIZB0HLCXsWmGlGGwbtvBoOwB+4coXrMGXibLqllgpTXMDDyeJiw4AwqtGOq5zsCuWNit9ZkTJX1qKITyjZ+VkepJr/3lA6gc1N721vvSxqK7h7z9yAkPsGVvz6uDxhl2R9yd2JdhCZ5zJCKyi+5VqisAZBvA5Rn5evDDsn8QFfYbAoWRsuiecztTtLXCRl2CYnIlXH0z7Bpovax5afPrff4CRVZxCf6zbvK96XO9iceVyEa5Xcnal5tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/EGs9sCGFI1zbYve5gscLLZr1XqhytJJ2un2obA1Sc=;
 b=UaRYoO4pO55NHpFHQURDwn120u29ixZZFDYnTdqLJfIAUw7GxO2bU6WF8yn57Xq5V3sCvalQsAcBhq+PZDMMFW0/mj2DfyunLa0q1z1tC2vxnXfhl/sVHiJ5DnPETxN6oofavgdHtO1YDTJeXGwVyCt3DC7ugg0FMb3MK+gyo6qcYGmhkq0fHZGQc4S0ut5GUnU9pbU1qq1mrxaDlcFKcY0xdjhEBMoL7goik2/EYbP5CcE8d1TtUb+3vP4LTdeEi5GdG+tM4f/Pg30cxNLiDUrms++JP4JaKYPOUWp2KKs0+0YQpcKmma1QEfstpPob7QTb1NWDxNHPXx7HuZmtpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by AS5PR04MB10020.eurprd04.prod.outlook.com
 (2603:10a6:20b:682::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 10:04:03 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:04:02 +0000
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
Subject: [PATCH 04/10] arm: dts: imx6sx: Add Root Port node and move PERST property to Root Port node
Date: Mon, 19 Jan 2026 18:02:29 +0800
Message-Id: <20260119100235.1173839-5-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 891a3978-f14a-4e4a-c330-08de574212c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hNfhGP9cil02j6Hqq9FbuwQjM5nTIIhJd2ElFuMwX2eKgJqp+9Px73NbqDbJ?=
 =?us-ascii?Q?RXMQ+9p8TJHJgSNqSdR+eJpVXxW1cC8bvqocB/9ebQpPcWY++l+PdPWhtffN?=
 =?us-ascii?Q?IQkeLDOzKbo/LO82F3+vrt21PvJ15iD6ziPvI2tEECgeI7AYkyCDvB9rp895?=
 =?us-ascii?Q?GBCHfH4ycOXmEVstnDfKrGOLbRTP8/JPbLQ3PK7fmG3LvOMlTSZahc/s4JTA?=
 =?us-ascii?Q?t4PIYH99q2FaRibLT61w3mi7pxWN72f/yujDcD7tzfSQ7ZRNVDatOow77NaN?=
 =?us-ascii?Q?/P4l7qtAzlJY0WE2oIVsBj62OKkrQvK4Bn7LqizjzYCSA1JmRTGyW9r/pc90?=
 =?us-ascii?Q?W5CdvG1AGXAz7nXlTTLF8rqFW67JBlSdhd3bBi7msyMsQ6af0Xv4lE5T25Zw?=
 =?us-ascii?Q?PmhTUNnHVz6zNZMFA9H2pVkpcw6rBDsG8DVLaLB7TBUONwkwuiF6Oli9Sy6k?=
 =?us-ascii?Q?T9Lf3jiE7XC/osNLAnMyLi5Zqqozh7zShn3Rz4g24icvOctqDUXsAcNhEspw?=
 =?us-ascii?Q?2qEyrnUx417H1klp01ohnOgB42qp8lIZ3rKx55P8HMIBhJH9OICAe4RGAjkr?=
 =?us-ascii?Q?jWDSFXnx2ayLq34okn4wecL1nj6yiIEazsYA5DYqkaKG/rSHs8l2ZWOb5cCp?=
 =?us-ascii?Q?asyr+xpJWiGy1QCpwT5iU1GBhqu8QRSmz6qMv4ybYzu2Xnj5sjh0ZWUPzYyF?=
 =?us-ascii?Q?vvZyoB5QJ0N8J7j11VnyeMpRzJ9qb3lJ8FfNuaXKjFk+B+c621AwUERAO5K6?=
 =?us-ascii?Q?96jz1DCrl2INsm2QhTKbInxpRi9pKeM8M5VLbwFeXMLqsrPBGeyNBJN6RlyP?=
 =?us-ascii?Q?yagM9kANTUSGcfx/quTMMFjH6AcwJpzX/TfOolmoQ0GCsirkSYsgHfPKonP+?=
 =?us-ascii?Q?kYcnbH98VgBvRjdX8ceEU9Tv40Jq2Wz2+6ORYZr2voDlP7Y17YBRtIRYp0bw?=
 =?us-ascii?Q?/5dwkNXKYxDtJwPwGL2BMn4dn7nL/XbG8uaSQQBkDgoDGarW7URloQWGzJtb?=
 =?us-ascii?Q?q1IzOtILd42B6COXCs65rHak8UV66xQD9pYTkwxVNlhZTsa4vXJixcuNaumv?=
 =?us-ascii?Q?256QCLzfWgQ+c7rdMwhyBC35WykbcZjoa1wzUR5Ag0LRiHTvHtXDa0EMkztC?=
 =?us-ascii?Q?DULVy8f8lkCc9bzTPaXR29kya+ddhhUqqHDX3oEJY7JXaCY7+/pXKN4ypowj?=
 =?us-ascii?Q?p8kkBaTFXQ5BCDj5igyxW+mfmMYhIMt3ma/swDWtVqE74DvwIjDL8eSSd8hc?=
 =?us-ascii?Q?/uuUerCWRZFZ8o1VvwgbdegJ93sGvl0GeenyYHlyG6QzSLQm/q9pAJGi1Pd3?=
 =?us-ascii?Q?3+onTHTOmMErcskLPd9CwsV5aSH2fVC2UqIcjKKrt9EKwVfEXg1PSXlbf/Li?=
 =?us-ascii?Q?LoeCWytRSEbt8iQev30H3I8FUA7RQ1PWZ/6DTybpK2C4v/HSP+3wl1JsuW7S?=
 =?us-ascii?Q?1xaOGWfiUjSS7EW8T9uG6XxA81QANOTrijJd3ke2Wc8w7jvWVVUY8PZZt5Bn?=
 =?us-ascii?Q?JeEAStJeUyvftd/3DoJyifsqHMERJZxuu99tqUD9gw520prFardKy6r37omi?=
 =?us-ascii?Q?NKxf/cUUm18fBqo65b/x0w31Onk+VJYYlexofJg8dZ7bPm5/Wi5c7DLbtQ6T?=
 =?us-ascii?Q?WdSOShLCMTYXToc3StHK2lRNRXpVdfJCGWKqanajq2Xs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k9Vai6T66ovWb1Luu0u6KjuGD/2uD4AGQpM7hbkoIwGtYARJLgC01bANj1DH?=
 =?us-ascii?Q?aF3hJfESnHBSWjeTZ/PBUiqMUtU1iYm+U4Fe2Jf4DaXL+wmVSSatQZ11IAkv?=
 =?us-ascii?Q?JCdYMxrgsl0ixIUmIPWWKFDmOujdoXzv0qxRayqDYdsmAhpe0cCKsBs4aHZP?=
 =?us-ascii?Q?ZytkDIs3PO27JFO8rfZd27lfLLpVYuDabw9uk7sWqHfnglUZvV/yCj5CIEV3?=
 =?us-ascii?Q?ZiC9+hDa3KNqQt0wb6xn/vcvmr1N12I4Y49topOYg8VUELI4mDwFBwfikJ7n?=
 =?us-ascii?Q?Vhexvt799AsPNjep8779wMXFHnVUWEtdhO1pIRezxwNShJWCH0LucmraiWJZ?=
 =?us-ascii?Q?TWWj+0rMMYYrKV4lETDeWZauHlAi+JTkQceU0Dx37zf9mhP+Bon1LX36P/uj?=
 =?us-ascii?Q?gK2UJ/5eDHZ6pvEzJQhay+jmfLLcySgU/tZEDgoZTVBYJ1tLBUVdMBMadH+0?=
 =?us-ascii?Q?GzVUbCM/tdZUMFg3ES1O1enpEyO93eieLHvfwXtxwjIUQwsVUtBwkZ8F1RXY?=
 =?us-ascii?Q?ed+PAFpMchFeoTg9BI/F8zLMYGWKLyhSply5lp+aC0PigHsaXgl33Na3d9Bf?=
 =?us-ascii?Q?ooVtYfSqCxU8UEnhI6ruJI2Ppg5nYxgAyvSFJdPjLccoCcnBFdj04ryr4wuN?=
 =?us-ascii?Q?bwMBgVGslMskFcdLAdf3pxQAkR9dyUMw6pBplqS2UpUn/vVSZPfrk2+sdObn?=
 =?us-ascii?Q?63FHfBCyYDK9EjqWee6l1a093cQ0Lo/om9Yoe00oJ7F7fhmDWalJrm8v2v+w?=
 =?us-ascii?Q?RU98wIdIdFp8xQadCguTFWZ20uVptniMooU7KgEsgXJ96/FEiGpNqxZWv0lC?=
 =?us-ascii?Q?jrAHJT0r9t64w4c8D7stCsFrIgmHEVZMHM2lFZ7ZJL8TICdYfRPqEA+jAghO?=
 =?us-ascii?Q?uhGjqhMsTL4FfFQREQnDLxmZjKGkZ4IpF6M7+YARSKVYXJsM8jvozSeyp/uz?=
 =?us-ascii?Q?vnu+oLQ2t/3NpLG8sh9wdC+hv/EmTOLG2VJdzG5MCVeCbBCEUYQk8swvUQQm?=
 =?us-ascii?Q?Dub+c+CknB0Jyh/CZX4TUPjJ3pNpycRpK2ATCn9CN/sRCT4I9Sax1B0YwV7u?=
 =?us-ascii?Q?LJf7hWacNc+hEx2YHJxmRQvZnMVM8B9JRQOL3yqRKA6UIRxFK8syiuTfUEzp?=
 =?us-ascii?Q?hQxaeF0LDjiS7A2v6ZACYDaqw5Ad5G3WtBd84+jR/NvYyhlqjx/VmLSWB+M5?=
 =?us-ascii?Q?onYfsoMVe5jSkD7RNGhGulKF7DqTvNZ8VZg7r0czsiH6HCu+I59ZQEWyPvM7?=
 =?us-ascii?Q?eoJ+gpz4sZd6vRkas2pK3a2fpwWM0hmsufJBTz5azNKqwm2cudgafGETnYbv?=
 =?us-ascii?Q?H3YOOnHY6n8cwGUxo/Ob72hnVejTyzD3lr+nPIBzKI8HVNnfxyQPuOBjsHJT?=
 =?us-ascii?Q?ZAefoMiGYkkn96PZDUKJOlA1DxGSS49d0L4g+XHWqOoo/t9+bfQax5NDmm0C?=
 =?us-ascii?Q?BC8B9S3yCVnl0x3hLq0Kd+fuhgXp+dSKEnKzTUUc7KyUX9sAlN2hjuBjMMg4?=
 =?us-ascii?Q?Q4G4i89KwpGBBm9eqE6UTV0C0fg6N3JkB+An+ZOsT4vL120NFBqZmkzQmjib?=
 =?us-ascii?Q?PbTdOJpAgb7PXzx0tBx/+iHRDWeu/wioN0yuzhDgNd9rUB2L0VaOykbafimw?=
 =?us-ascii?Q?7YUyhcWnVYoKvKq+avqsPxGSJi0FLnKpopmEybeZplN9E0xEKl5oUtw2tLiV?=
 =?us-ascii?Q?AjG0/nir68lDq76Irtc+0Ger5TMsyVLsJ2wj/CVqtdUCXDG4Jskz4oWssE4T?=
 =?us-ascii?Q?6CHgxF4SVQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 891a3978-f14a-4e4a-c330-08de574212c4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:04:02.9125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcE8pJPZihg3lfH3qoGL6eRw8ueEhsrqd5Ipcy8n9D82T8sOuDdq4UzkxbH0sJuGcwt+2M6xXwg5YnVC5OA2jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port node and move the reset-gpios property.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi |  5 ++++-
 arch/arm/boot/dts/nxp/imx/imx6sx.dtsi     | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
index 3e238d8118fa..a4170486529f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx-sdb.dtsi
@@ -282,11 +282,14 @@ codec: wm8962@1a {
 &pcie {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_pcie>;
-	reset-gpio = <&gpio2 0 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie_gpio>;
 	status = "okay";
 };
 
+&pcie_port0 {
+	reset-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
+};
+
 &lcdif1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcd>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
index 5132b575b001..c04436f4cf0d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6sx.dtsi
@@ -1470,6 +1470,17 @@ pcie: pcie@8ffc000 {
 			power-domains = <&pd_disp>, <&pd_pci>;
 			power-domain-names = "pcie", "pcie_phy";
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


