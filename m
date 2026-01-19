Return-Path: <linux-pci+bounces-45172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F2D3A469
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 11:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D037311737D
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF26F358D00;
	Mon, 19 Jan 2026 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ITf7ty5v"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B513590C8;
	Mon, 19 Jan 2026 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768817085; cv=fail; b=cbl14ym1fgacjpdYht/XsFcuvYjX7whDuG5tKqGxvT04m/DgIh9gsDwEK1Sia6qihP4hyGO8VjCYinVkIsrmNI2cyVbjGup281/5b7iNmXgSwnmabbwTHGEHQPEZh26ZG5/gQqxjWetMWjF8d3h8H+7cd/Gt5uG5p3qhOzAmQBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768817085; c=relaxed/simple;
	bh=Eb6Il8K8vEwfRYnUTqRyNpZLfgR79FuURqDhHwkOlMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T1SE2tKOiD1pByFFCM5RDVuOOgcjnIoiaFLzQvu6j44s78lc8vcRtRQlofpEiaMATN4as+EHJdnwJYRr1ZgqZt59eH6G0X3iP6l1AYDdnwWWEJsGyrm59+LrnnrBTLTLylxDaXEiMS+ytoBBGamLjAYP1GqmTFSnMAvJUkbQc+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ITf7ty5v; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXhlyAgbOlRmVYod2Nafqb9kErSUD3vyiLECHt5IEmTEdq0O293bFUYFvIsLhfAUjmlKgCr7Rd/De7IKelMQMJM0CD6oV9cclnI+UvZqVwgkJH79d/xMufxmY8JA7JXd11wydm06E07QyXXmL9S4qa6Qs8BJUPq+kU7YfXiYVrt6McaG9f6W/hen8ghZGvWfT0o9u64FvVmF+vvcrscW/U4iG4DudihWqdh3SdAFZFeZ2wMTuY+KDjTMWB1slwHrF6Bye2ulz52xmSpdGborqGYl4u9WDtO098NpYtN088kHN+UjCxKnSuUDaDWNkAWtj0DaXYNUdJ8MLyDqTjSVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwVF/i1cIpqnJmGxVoUfKC9RTL3hT5RutY3BapEAkPM=;
 b=mAQqo5nw/s1raOYvGCSwHP8+SHLg+raPFHYXRARJWs83pUgKvbdvdcc5rxpt+dxABgB8Qfxs8Lni780c6MuNaUyAMB5KvRFpQy+hPOT7Np8Tjswsa696vBPIFHo6D2GvX4oGhGwTgSqMDHfAwnHZupGzTuogIV7XEKO5ukaYC/vqOpvtH5wMkXIVwrVOADRjlrv30zfWrKX6+bJUFt59HmDoWZdXokJiOulE3qXtkstqvjv3gbQvfF7XMPBf95R6bBHhTEV9NLME1PUUiHDV+gC7/JFGMrt2Zlo4QV07rMOdpzmToceAVXM8oaqI/LFJq5L4U35GIRcyXFnWfnWMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwVF/i1cIpqnJmGxVoUfKC9RTL3hT5RutY3BapEAkPM=;
 b=ITf7ty5v9bzcKm7ydgPSWRIZAtuHTAoPGgNTXxNM+hn0PpBA+5GftUbNW7wgepb54BNC3o5pOpIver9weFeUX5zccB5V5ayTwLLAK8CUGG/m3j/xHGQUUfyKtiM1ZiqAoPwn6va8BkmiW6PPdmuxSe3u1/8KXlp56CkVlliuZ8pelW3fG84tMyN6tW0e6TY58WPC7/bVrEf7XXEWjU8OiWLi2lwb6Pjw/1whv166ZkGEsa8EnYguY6hILtKGovO8DufpZjtA7pt/vZ2JIcndm3wxoGmKTD3wepA1MJ+SloZEnTLJbf64dLNkFbLfMSDgY7No+o+p6i6qy90ersbVbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 (2603:10a6:800:315::13) by VI1PR04MB7088.eurprd04.prod.outlook.com
 (2603:10a6:800:11d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 10:04:40 +0000
Received: from VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7]) by VI0PR04MB12114.eurprd04.prod.outlook.com
 ([fe80::2943:c36f:6a8c:81f7%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:04:40 +0000
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
Subject: [PATCH 10/10] arm64: dts: imx95: Add Root Port nodes and move PERST property to Root Port node
Date: Mon, 19 Jan 2026 18:02:35 +0800
Message-Id: <20260119100235.1173839-11-sherry.sun@nxp.com>
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
X-MS-TrafficTypeDiagnostic: VI0PR04MB12114:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: edbea46f-eb66-4be4-42a9-08de574228dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|52116014|7416014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NoklWW+0u2MkEr2M3eIjPZCVVL1YGf0UM2f8RTa58A4H/eNxeTSiRhFjYPvl?=
 =?us-ascii?Q?AhHzstV5ZNv9LAzO8j6K7/Zw4/NufMUef1CCIoQd1k5ZzdIoO8yxGMR2bLsg?=
 =?us-ascii?Q?mGPKqsqT2r/KAoq0I3dCqdG7NDz0f/M061YWjcRM14tZoW9K/VaWWx2irCU5?=
 =?us-ascii?Q?7nshSHWTCE9qv4H5lxs0nVQeRZHzLxqEyEJkqMQd9yJVzYYJVm5sAjl+w2th?=
 =?us-ascii?Q?79zbVz5P4JIXoTj/z3waaK7YIaswOlk1AZDJA+J8gcLiaMv365po2nWSsiYL?=
 =?us-ascii?Q?kDhXGgWzi9nBEY7j7RrTZtqEFaKvSeNOtFnXq7bd85sK3FAQz1N0SAuiy3bt?=
 =?us-ascii?Q?+yR904uJKkp5C9yxz7rgZjZ3VZk0fNfXLCcIipo7nS/AmxosBhtWTOXaQc/O?=
 =?us-ascii?Q?ZskXTdSlZDNPAB7mPoZnfLh2lf6hxfSanoZCoIza5S5JThYPyYb4pLt4kIy2?=
 =?us-ascii?Q?tSE6tdI0M0DN4QfBd1EYagIWBfP2FJmagBmgDQLKgbmcHm/8TGnY4wfiJlxb?=
 =?us-ascii?Q?SkePzq8GtpzP7Y5cQ6EAf8bjEN024OTJHj6DbS3ubeY5KUkcIEoodKGpZ8MI?=
 =?us-ascii?Q?qRpgQ9MiUAbSGnyN9BN+iYHfwUvA2V5EiupEXDPH6TTr1SZXu5rwuOanEI5K?=
 =?us-ascii?Q?KAi3Y/U1csp4MfFnUloj5hduCwEfJBILOY3RXkziy4khBmUZ5dXAisWH5Jc3?=
 =?us-ascii?Q?auig1Y4aNVCnMjfZTYzg+6MZV3LTifJJk5ejzrnzAC+S8n0nF+QViB4UMTSl?=
 =?us-ascii?Q?jUPRirVDY7OsI3kmXJA5IYiTPtnKRUt9KF2QU+Qzsyg2xEsvaNenpONT/EIV?=
 =?us-ascii?Q?H3H7gsDPW3yQZ2QNpYzQegkgcvppMIsYgUj96WNf+GkwwU4Q9fGPHZkS4g0f?=
 =?us-ascii?Q?KyRhhuLXUS4BK5YBk9IHu8Fjv1MQ5ZphTo0FDx5I8gl6rRctdfp022RezJ3K?=
 =?us-ascii?Q?f3d2EanlGNIXcdDd7zbgbfbfI2TStTlC5xhmLzSkyDArf6zjAdPBSh9oYfMy?=
 =?us-ascii?Q?aMSujmwk4z1Nj2PkJG0655/KHiJ99VdWLH3irTDNPQ09Es/Mz0H2S3dFqWLy?=
 =?us-ascii?Q?fbEFQ8vF1FBxtesRO0at2CG8ronpGUKz5wfBMBfQkyiLOxuLNcZ8N2nUCOAl?=
 =?us-ascii?Q?RC478m1J1XbT99XZ8I3KJJIR7PxKLJ4A5WxRO4cgGXVZi1zIzTX/CJzirdxM?=
 =?us-ascii?Q?5pJ3eFpXVXa08Q2PVcA8eHeTK//jQOOyiSGZ/PC7VM0+LsEhY2QVAHP4Iap5?=
 =?us-ascii?Q?J0TM+DhXwssxLUrLX8vkS+/GFfPnMYbM6is3C9WbalcHJzYCwgnFsmpSrnOm?=
 =?us-ascii?Q?xjIHDeHye+WOXwfwbQ79HCJwihLb5HCr/No1t9MTnVoTlAYHBwjsMX/Qe+5Q?=
 =?us-ascii?Q?8hKCjyEVfGrXydN92RdT9uDRDKdXYLj7mGLxA9cNIj3JcG3JG5VRO2IJtQbI?=
 =?us-ascii?Q?3cJY30gTifcjn8UTF9XbbbAiRuK18n8xaKQyKjjO8Ukw48JLFo8z7nTrO6sA?=
 =?us-ascii?Q?KNoHva3jxB/6oNI+CM82QR29nXFqY0a2rcGi7kDpZxmqHlLSLtnvJdixnVZj?=
 =?us-ascii?Q?IhmBbfbOl+QckG7Fj1fWnPzGgJlCwnva0D94hGRoGyHtOkjffppaGvXKR/gw?=
 =?us-ascii?Q?YJQ/4AZ0drnnVddvKGYRIdWRn2pepWDEcOvzGJ3p/zjJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR04MB12114.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(52116014)(7416014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZpyJlFf4OSnGVWAkOU5qEiZ2VYsjmEq691y8WusQ6Baf+uVKLAJGOAQVj5ta?=
 =?us-ascii?Q?oV2jeXPh7aSR0XPA9U0PiJnsOkhCtVl0M0farZEolREftU61UAgpuRKBBYk0?=
 =?us-ascii?Q?rrHtyUPPKAae9zwjFOGZFXYR+TkSIWJCCTL15UjOxVJkUELe+8hpH2YkutmU?=
 =?us-ascii?Q?ZiXiTnd/zI3jSkAzrlPXOEl3/XTrx0P8LQ7B9/+yl1dG/B08fP8KzNuxxpUs?=
 =?us-ascii?Q?iHKpHD2Rk1/PxSKbokGbSS3qzv5Ms9p5EBX13V3OaktCdp7pyIBxrWi/373E?=
 =?us-ascii?Q?c5vq7tC4K3zlCN+k4qEchjtK7n0oLOQcaxKij9nKgd6qQ04lghO6y64iNFAX?=
 =?us-ascii?Q?1vaiotvp5Qc49uFI4TB30UKgCSwGMp3P6Gp5050/CQLznfMjZguLUVjrYqNc?=
 =?us-ascii?Q?5vcrYqDbDo41KctGaulGVp05YyDBrjmM4leqRP/lZXjekxKlIJiDPXfofJ9H?=
 =?us-ascii?Q?WyFegNCzvMlDzLIoIZvUrQ+FZGZbZDnfSdSWx2oaXUemxZGcpYu6GFlP0EDu?=
 =?us-ascii?Q?gJwMyHkZa+N6BtDV7y099ZCCfJRkKcAjOnWx7CcF/xUEWOBeTHth/o19PQCT?=
 =?us-ascii?Q?dfIIDn/L88PqDzwXi22EIdU79/9o07QqFSuNUZiwmR6cXo4XRlfyjB7j8Q+4?=
 =?us-ascii?Q?7EYwCL+//YErVnZzfzx+hbX2Nk3ztpci02GcZ+C+VagkBFQlL343JLiDJAbn?=
 =?us-ascii?Q?0eYehiQy0LAP0tnGlKxBhknsgK69WljdnRTRFgQDs/WH4uNZSMupvVUswOPz?=
 =?us-ascii?Q?Oy6Abq/wLNMKpg23tcB+ojzlQvHIiNB0MtcVOrj7kmltQAoYe2K2HOmVstsv?=
 =?us-ascii?Q?dmcahtlraWYMG0hY/vCxIpmlO+qaNW9wPivOmrVK7TP3XOEsdb1KOGI8JltX?=
 =?us-ascii?Q?yToZpVyiijeih5m1uAS52RFl12pbdpx6y+/vHr0GX1e6gm/nCqp6uIbRluFo?=
 =?us-ascii?Q?hC92BT/gwns/49O4SFQDEmJUWCFSUiMjn3HPa10PAXjEf7tGbGBhyq+izBvn?=
 =?us-ascii?Q?MjdiQ1290ESsFUIcHeQf8QrUvdHGPDfj/Mwxrfckg6o7//zC/IsR25Gznylg?=
 =?us-ascii?Q?rwunMZdgBgQ6nd73xL3W5YaVXMqSlEBMgmGddF9tP/PGiGyTRUCiG/T2b8oH?=
 =?us-ascii?Q?ywtcjKKPr/BKheJ1lLAdPTEQ538LiXLv04bnbGKR9zwqaS81NF8c1WPOjRmY?=
 =?us-ascii?Q?uwVnfwXEq39HSurTAFeyCe+u9BOiSKZ1+cZcVWGRn+rn7iysbTyGtx+dDh0m?=
 =?us-ascii?Q?vw+Dxc1nPbIANv4vMJxGTv1iCGjO3q9XqevU6hAE5btLhhglhSAaPMiq7dkT?=
 =?us-ascii?Q?IFLIE1tDOU1WPhs8z6MFiCbEQ9fkHz79W/QdjMKnXQ7QdEWfQ+VzXcwrdy7q?=
 =?us-ascii?Q?17udkU0ASpPO97pF6n0GQAa8Q3Us4rhuUNSgerP25Nxtx9Mk6KsZtWU93O5l?=
 =?us-ascii?Q?gFzT/WHNnIuITBiieKyuW6GIHoEZbjf+Pa6cIknPcQx0YL2bOpvVjlahymvQ?=
 =?us-ascii?Q?D4cXzF8Ba9sAYuUUCP78wMCDDGu8gfOpdYFJ1cOa2AhweGYmhNPWfmfVPSoJ?=
 =?us-ascii?Q?Oi8EBA5dPKdwpD44vEPFZd9BFTNSaMQ+nHjh7F38h/v0JQKbK1rGfzVfkJCO?=
 =?us-ascii?Q?nLYF0GIZ15Sspt+VDtzp2B+ZLboMhECyUFXVscXMB9pRksw9zTw7mnxbIH7V?=
 =?us-ascii?Q?sA2ElL2QkLORR//HrbfjIkrxwX/hDDd9cs3NF0WtRHjeFwb891rXsWhQSzNu?=
 =?us-ascii?Q?apQ32ez0Bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edbea46f-eb66-4be4-42a9-08de574228dd
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB12114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:04:40.0219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5NL1Qb3OfbrgiW2JbljCQqS1arE8/8xjYIkmds6/JyQOooC3fZM98vq15GVWbzo1zXQyZXGi1vrV/IA4of5ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

Since describing the PCIe PERST# property under Host Bridge node is now
deprecated, it is recommended to add it to the Root Port node, so
creating the Root Port nodes and move the reset-gpios property.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 .../boot/dts/freescale/imx95-15x15-evk.dts    |  5 ++++-
 .../boot/dts/freescale/imx95-19x19-evk.dts    | 10 +++++++--
 arch/arm64/boot/dts/freescale/imx95.dtsi      | 22 +++++++++++++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index d4184fb8b28c..0f4e45bb1c4a 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -554,7 +554,6 @@ &netcmix_blk_ctrl {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
-	reset-gpio = <&gpio5 13 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_m2_pwr>;
 	vpcie3v3aux-supply = <&reg_m2_pwr>;
 	supports-clkreq;
@@ -568,6 +567,10 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	assigned-clocks = <&scmi_clk IMX95_CLK_AUDIOPLL1_VCO>,
 			  <&scmi_clk IMX95_CLK_AUDIOPLL2_VCO>,
diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index aaa0da55a22b..7d16778f8d49 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -540,7 +540,6 @@ &netc_timer {
 &pcie0 {
 	pinctrl-0 = <&pinctrl_pcie0>;
 	pinctrl-names = "default";
-	reset-gpio = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pcie0>;
 	vpcie3v3aux-supply = <&reg_pcie0>;
 	supports-clkreq;
@@ -554,10 +553,13 @@ &pcie0_ep {
 	status = "disabled";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&i2c7_pcal6524 5 GPIO_ACTIVE_LOW>;
+};
+
 &pcie1 {
 	pinctrl-0 = <&pinctrl_pcie1>;
 	pinctrl-names = "default";
-	reset-gpio = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_slot_pwr>;
 	vpcie3v3aux-supply = <&reg_slot_pwr>;
 	status = "okay";
@@ -570,6 +572,10 @@ &pcie1_ep {
 	status = "disabled";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&i2c7_pcal6524 16 GPIO_ACTIVE_LOW>;
+};
+
 &sai1 {
 	#sound-dai-cells = <0>;
 	pinctrl-names = "default";
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index a4d854817559..0d5f20b8a42a 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -1883,6 +1883,17 @@ pcie0: pcie@4c300000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
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
 
 		pcie0_ep: pcie-ep@4c300000 {
@@ -1960,6 +1971,17 @@ pcie1: pcie@4c380000 {
 			iommu-map-mask = <0x1ff>;
 			fsl,max-link-speed = <3>;
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
 
 		pcie1_ep: pcie-ep@4c380000 {
-- 
2.37.1


