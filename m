Return-Path: <linux-pci+bounces-15574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8829F9B5F6B
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC5B51C212AA
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 09:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8C1E6DD5;
	Wed, 30 Oct 2024 09:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m8SjvAgK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9930A1E572F;
	Wed, 30 Oct 2024 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282119; cv=fail; b=i18cT5ca52vewybYa1FiyPyf520sIsPZPz270tPKS82s4TrfkfzrsE1p42gKXpOW8HmSf2s7wNqqRBvo0abOlEIHpWroTUxGrCNkLwp3untIXsnsKK7Iz98GlaEQ9yE4vBt6OeCyMhxjwUQPGt3U6U+T+zqsx6cE8VxrSrS0qWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282119; c=relaxed/simple;
	bh=NDR7LnrQ5T15luvLkGYarvUzp0hF1MlcF1z9FzpC34w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MjCKas4on0riHluJg+KcdQpsPHTsWwdgxJgVqTxNyCQKu+pO2g6hWtr5xdmSd7qGJat37xfON6A+OfEwvY/5oUEouIUVUpJOLAeAkQoc522YjmM7Zc9FebcgTHorqPmRR28/nM1+K/uUmwxN7QGb0e7Yl1+/gzIIEFFw1dCfxJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m8SjvAgK; arc=fail smtp.client-ip=40.107.247.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MWycTAxpPFCfCAxVZHnKeyVuT7wYwNgmtfKcXD0hInxbQEb7NgWe2L5Ji9WyMj/9nYpAeDCjm2/HPRXfJK5zxohjtwRBcBtZ2c7mKdWCgUyRs7bBwtCilZBh4qAfJsTEoshdq2unRTLHVoGISwii5fLzFZdROJ5zsuzgbPahRCblJPCoEPVVQdZGdLfDsYhVBF5aNVgV6BndyHspNPWRwYXZ+OIULIukXs6uchpuCFYDwXdQ97qI6sLKqNacYb85vuWYwkh1vYzGHLBISKakyObUDJ5D6sH8JOpQik0irFbhCpFC+evm+p2H7U6WEfJUItlbZZlNeQ43V4Alv5UPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzEAYbuzQq7kWIaCobdlMT1UGL+EjI3oUibzL60t2iM=;
 b=L+43dDgcaiE5HnZ2nkwDA7iNm0U3DgiAah3Q4b6bmbEBF+uwfOTgS2aLAwfig55MXVKb9+rcdUzmB8Ow9NJDECJuXZSqdRajiczin2BtIFRS7vlQ3RwDGEISHNooKstzb1JnT1LDtHyw90kyxThtFDicy5U0jTfQQtGRfYV17mhD6boPvSzOkX/H0R1MVjAriN1bfX4mBU6TNln4QyoBwaRSWW5ZYGquOloBlnbddP/+8rBw9dQ7ppGDb4k6h4Gfherr8aUDG2gv6bPMid9DDYhz8ULy39hoFsDN8WnJPMBE8VCzm9W4f+UpN98O4GqfwitcxrpaBedCZsZ8q1bmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzEAYbuzQq7kWIaCobdlMT1UGL+EjI3oUibzL60t2iM=;
 b=m8SjvAgKP8CmTIb2CqaDKMIlXg+FDHv23XOnuqVECODjLmzB9utvReQ8T6pCJXbOCTl3niCDdod6bkCvCN+chxUaUMRv7WF2Kmsx+GoTOPhuI6FdEaoPDSOk8GmgvjVfDej8NWDSwYftZ0+FVPMnrIwFZBQVVJsQzrvb2zhdiXyj9pQ1Jrn0RXCdQ+JtegLA1jvkO0w5ngBrFF6qj7RB+TQdl7VNEhOxF0GJHPfssNbb79DZyuH3lnfBbCOKzlwuwaQCQay2S06tqVECzgOnMeFJbZruSdk2vdBCj4/HDpxvOVftHT6uJUv60XAThvBG+jJAZ7zxe3SojQMfzIOl0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10347.eurprd04.prod.outlook.com (2603:10a6:102:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 09:55:12 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:55:12 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v6 net-next 05/12] net: enetc: extract common ENETC PF parts for LS1028A and i.MX95 platforms
Date: Wed, 30 Oct 2024 17:39:16 +0800
Message-Id: <20241030093924.1251343-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030093924.1251343-1-wei.fang@nxp.com>
References: <20241030093924.1251343-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0009.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::21)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10347:EE_
X-MS-Office365-Filtering-Correlation-Id: 2880330b-7bc8-4160-9ce5-08dcf8c8f275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OtgKcFTaPn/9XfFE+Hol3PVLubkADjJb6AXNzWoE3Pyh5EAZZedI4uD4zRiE?=
 =?us-ascii?Q?JKhw8PUQf8VPNHX2a5D60/D/m9QUvmM+e2/YcTB32JRoK1lg1bMkPWgjw6Fc?=
 =?us-ascii?Q?YZ84fAMbBvbm+neGErbjEJWO4hBS6PLP5GSeTgVP6p7lgQ9RvahLajf9cjG+?=
 =?us-ascii?Q?WDXT1CuRgmY98P+Y4wwFpJ8/03gyMLiHXy+a6mB5eEUYut+8779F8DLCXVHs?=
 =?us-ascii?Q?IvpUrFzR6G9pBEhlK10C8lMlWP3sUZ4if1VBuWt3WjBoI+LgU5i/xXqiNoJq?=
 =?us-ascii?Q?tRO7mhjlHhGe5RHce5MvoCjvuy3ah5rQJ2wCSmhvc02UA/mZjViVql6k7G64?=
 =?us-ascii?Q?nPVEP1FZhS6W+2GdaYxfIagOOU8DI1iOwDLkSZwdsZF8465m/xdoalw6KEGA?=
 =?us-ascii?Q?Lk94kBmqpL7tdNRo8J+772KJ0qGLyZZpKtiJ8ltB4+QwRHq7r5YsHSXsv+v2?=
 =?us-ascii?Q?taQyc3shyAnXMhMSWLwqYGCMJRI5qNA3FSzv/Mp8t1yqiux7iSFo7qx7Uh+a?=
 =?us-ascii?Q?qZ8p1Ey2RluDtIJ/UcEBsP21w3UyVP5uwal54wuaOy8ZgdujmYG1ADgjLpz6?=
 =?us-ascii?Q?pRWtQsNNbvtzPc5cBokkmk88iMKFM97XMO0erT+bbBUA0DGT62MSJbX6FMKU?=
 =?us-ascii?Q?G9KEpNfoCWANGc6AcfV0QwszJpvSv+lGmdCGbaT3X/2BJ7ENCUAlnmmizF18?=
 =?us-ascii?Q?eInLZTBBzshLXioKsECNo/LFAz25y6VbOxQVgDoesAmuXocpJHwCM2IEzVin?=
 =?us-ascii?Q?apsossyFHdq8cH7aSXJ6Q0yVP84oNPe/iBhsgd585GH5Ds19qb1fsbgZzZfk?=
 =?us-ascii?Q?m1USYQdEiD4OoQtz2Y8swB6Dc4RE7sknZlC0BiW61/wVUhbHMbAsKysGZ7ac?=
 =?us-ascii?Q?Yqs/rxjSOz9L0IyJWu2hKQCzqBpDAENIy5Wph7UQBC3H30nEKNbOgeEt4MY6?=
 =?us-ascii?Q?w1EEt74VdE9XXtU1VeuyND2tbsudMVu66OhhOptFRJvHRFPYtUVtCWUU/14V?=
 =?us-ascii?Q?/OhRoKCv9eUdFlEsbhmM8F/9OiAFSe4AdLOEXPzv49i/8ty0dLzYDY3XjtLb?=
 =?us-ascii?Q?XODiL7Jn7EhjPQ6rLCqMYPI4UmwoMIV9PAefyensKgFytlnwSmKeywi5RS02?=
 =?us-ascii?Q?2LDTGwcO5ehbIuWPsPWn6w4W5XBcGQF8+hh9rbGha9qCtj5sUi+lO+6KvEjC?=
 =?us-ascii?Q?vV+PFNoy7Qrpj0cuRCAqfhKeoaJeNUxZaYa0D5JXnWtze/qKc7MTMZqo9845?=
 =?us-ascii?Q?Xbv1NmCMfj/cuz+GGMCMJzgFE6TVmoKOnhsT+RW6GpJ9oglICcY40dBh8iMg?=
 =?us-ascii?Q?pXdmCYIuZWaJG7ve0gPXvzSFs5v25AhJH3JXfenX12CNC/fe/kS4dh05RfK4?=
 =?us-ascii?Q?TcsQgFVH4cMcBE7hj0pxiw1X+R1f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Vt2ZTa2dM2h7I/wBKEV6FheJPxbyt14DBZyVfmYaE/JlAiT4IxSLS/UKzKC?=
 =?us-ascii?Q?5betKfJ+PFtQItN9NmtytakIO+VPX/bqoJggeAKvgBAERffco0Un+68JAE0D?=
 =?us-ascii?Q?IxnVBW+oW/I1A1cbJuo1iR3LsdRtMGORvsSHzA+4pPIkHQVZro5FU78JsV1o?=
 =?us-ascii?Q?aHxZBzAZwbxOwhauVs4E9C/TKUy1QQptYh55TimVGrb5FWD1r1LCVx8LLH2r?=
 =?us-ascii?Q?YZwKnzreI6CHnYIA+UHAnSUwjEiWomPAQDpmyutGHkuQtPjUS/j9i0hZOLUK?=
 =?us-ascii?Q?FMw0TQ8lbEbwXqhWQG/j/KsDw9Dfkb75Dr1OdL9GWYCF885HpxiQ2Octay7Y?=
 =?us-ascii?Q?BMjJawy2nj6+S7TcDVekwSTQGzTQadTiL5BRW/jtMP2uIfnGKfMmeuE5aDoq?=
 =?us-ascii?Q?biXN5TEfxK0QHlDw3Z4lJa59EnXWhlVqOhPOlq1WJM57uo1l/MEJ3ZWBgg/C?=
 =?us-ascii?Q?kWTFVBo9viaMIPplxzrpxXs/tdtRPnInfZ3cf45SxQiwSi8BNO2A02eh8ft8?=
 =?us-ascii?Q?5Hwqor7J3qrrQltUKZeVDA5mrxBWOCKTMeU9FVPbiq+azW9wGtm1Iz++g1wO?=
 =?us-ascii?Q?WwbF/ap62THd29ZyB1bIayn4M656n+rBP/sBFms5YV8Iz2YIz12mSqwx916D?=
 =?us-ascii?Q?RB00xUzVYbzV/ZqEhAOL762DapRTkej7DaG+vg5Ij4MtV9pyni0kRQ4gN9hn?=
 =?us-ascii?Q?XSefaQq/+0FYjawhcZlVdaxR3Sho4tCpHjIUIhDIo0S+tuiNkOmSWf9qvEAa?=
 =?us-ascii?Q?TOST8pzgaSUpLGLpVIBbV0vwRWWaQ5ZeDU8kIYuq/YPpY3n13WuJ3hiL81kr?=
 =?us-ascii?Q?rbNuDMnvuN0vlVyjAidmYJhpzS/Mgru3s9rtIUClP+KRjthpG4VNYFHyfUsx?=
 =?us-ascii?Q?6iQrRQ+n0kByRnQXX5cEc45JwIoJIRYZb6qPnYy6YmGoD+MXNAPuecqOcy/N?=
 =?us-ascii?Q?XfSefGOC6/Y/PewdT4Zo3596dg2vAMzdFdC8+ZWZOzynZ22Locc5SRKT4ZeH?=
 =?us-ascii?Q?s0fHbZgNYB308iYZ2VKtCSiVU71bpqdqKJFeJAmNmdUCXJ+fdJMRAOljNQ79?=
 =?us-ascii?Q?jVp/ZIjp9g6hRr5Ku6R0Hx4cdAEJLJOVOxKlPrzkAinrmJYfHdJO/Uela4RI?=
 =?us-ascii?Q?VckPewKuaEX+Xn4xdVSmPL9EvgEq98Eqj2SK+5Xhixn1LlxZr0Cn+Em9sdB+?=
 =?us-ascii?Q?XOPxV9+/lqThGJqojYpMpXhWJ1VhXYgdzjIukiGTLqfb34jygL0W5JmzWP18?=
 =?us-ascii?Q?yxWBdKB7IlG0EugfLm3MWQSdc/J5gZqCDEG+UjnL/rClP6tfFPx3oixURvZc?=
 =?us-ascii?Q?gdCah5PVhOH6AWYF/qDl+jyHweV2XQDI/hb5Yn62CH+gUTVml7z2GkTrTT0z?=
 =?us-ascii?Q?kbJZhbiYLnmbjrYMOw1X06iGRWaN0TZMCrbd8KtuPo/T0R0NfqDyhMSIfCaf?=
 =?us-ascii?Q?vsianTjSJo7BqVJ5eLBpONKkE0wq/lCeIhIvvDVrU0Mf6edZnHOlfqgb8TYe?=
 =?us-ascii?Q?f0fLVqluwWuU+aZvxy8SruzLT2+yz0NOvGloBA3Sy3j+htkwjQkJNZ0zxBUR?=
 =?us-ascii?Q?kcISzfQcLzwm/B7qpVVlU5ZdWWOCnBxJYkUp6mwU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2880330b-7bc8-4160-9ce5-08dcf8c8f275
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:55:12.7514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPt8zz2uTZvviF4/MqRxMmCssXh0iJschePCRN0/cNfPGFDA0GWc9sgnfIqGpoG3txohdhOL92GRDAdATVJ/hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10347

The ENETC PF driver of LS1028A (rev 1.0) is incompatible with the version
used on the i.MX95 platform (rev 4.1), except for the station interface
(SI) part. To reduce code redundancy and prepare for a new driver for rev
4.1 and later, extract shared interfaces from enetc_pf.c and move them to
enetc_pf_common.c. This refactoring lays the groundwork for compiling
enetc_pf_common.c into a shared driver for both platforms' PF drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v6: 
1. add enetc_pf_common.h and put the prototypes of functions exported by
enetc_pf_common.c into enetc_pf_common.h
2. add linux/of.h to enetc_pf.c due to undeclared function
'of_device_is_available'
---
 drivers/net/ethernet/freescale/enetc/Makefile |   2 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 300 +-----------------
 .../freescale/enetc/enetc_pf_common.c         | 295 +++++++++++++++++
 .../freescale/enetc/enetc_pf_common.h         |  17 +
 4 files changed, 319 insertions(+), 295 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.h

diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index 737c32f83ea5..8f4d8e9c37a0 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -4,7 +4,7 @@ obj-$(CONFIG_FSL_ENETC_CORE) += fsl-enetc-core.o
 fsl-enetc-core-y := enetc.o enetc_cbdr.o enetc_ethtool.o
 
 obj-$(CONFIG_FSL_ENETC) += fsl-enetc.o
-fsl-enetc-y := enetc_pf.o
+fsl-enetc-y := enetc_pf.o enetc_pf_common.o
 fsl-enetc-$(CONFIG_PCI_IOV) += enetc_msg.o
 fsl-enetc-$(CONFIG_FSL_ENETC_QOS) += enetc_qos.o
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.c b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
index 8f6b0bf48139..36fc93725309 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -2,19 +2,17 @@
 /* Copyright 2017-2019 NXP */
 
 #include <linux/unaligned.h>
-#include <linux/mdio.h>
 #include <linux/module.h>
-#include <linux/fsl/enetc_mdio.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/pcs-lynx.h>
 #include "enetc_ierb.h"
-#include "enetc_pf.h"
+#include "enetc_pf_common.h"
 
 #define ENETC_DRV_NAME_STR "ENETC PF driver"
 
-static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
+void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 {
 	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
 	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
@@ -23,8 +21,8 @@ static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-					  const u8 *addr)
+void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
+				   const u8 *addr)
 {
 	u32 upper = get_unaligned_le32(addr);
 	u16 lower = get_unaligned_le16(addr + 4);
@@ -33,20 +31,6 @@ static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
 	__raw_writew(lower, hw->port + ENETC_PSIPMAR1(si));
 }
 
-static int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-	struct sockaddr *saddr = addr;
-
-	if (!is_valid_ether_addr(saddr->sa_data))
-		return -EADDRNOTAVAIL;
-
-	eth_hw_addr_set(ndev, saddr->sa_data);
-	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
-
-	return 0;
-}
-
 static void enetc_set_vlan_promisc(struct enetc_hw *hw, char si_map)
 {
 	u32 val = enetc_port_rd(hw, ENETC_PSIPVMR);
@@ -393,56 +377,6 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
 	return 0;
 }
 
-static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
-				   int si)
-{
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_hw *hw = &pf->si->hw;
-	u8 mac_addr[ETH_ALEN] = { 0 };
-	int err;
-
-	/* (1) try to get the MAC address from the device tree */
-	if (np) {
-		err = of_get_mac_address(np, mac_addr);
-		if (err == -EPROBE_DEFER)
-			return err;
-	}
-
-	/* (2) bootloader supplied MAC address */
-	if (is_zero_ether_addr(mac_addr))
-		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
-
-	/* (3) choose a random one */
-	if (is_zero_ether_addr(mac_addr)) {
-		eth_random_addr(mac_addr);
-		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
-			 si, mac_addr);
-	}
-
-	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
-
-	return 0;
-}
-
-static int enetc_setup_mac_addresses(struct device_node *np,
-				     struct enetc_pf *pf)
-{
-	int err, i;
-
-	/* The PF might take its MAC from the device tree */
-	err = enetc_setup_mac_address(np, pf, 0);
-	if (err)
-		return err;
-
-	for (i = 0; i < pf->total_vfs; i++) {
-		err = enetc_setup_mac_address(NULL, pf, i + 1);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
 static void enetc_port_assign_rfs_entries(struct enetc_si *si)
 {
 	struct enetc_pf *pf = enetc_si_priv(si);
@@ -775,187 +709,6 @@ static const struct net_device_ops enetc_ndev_ops = {
 	.ndo_xdp_xmit		= enetc_xdp_xmit,
 };
 
-static void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
-				  const struct net_device_ops *ndev_ops)
-{
-	struct enetc_ndev_priv *priv = netdev_priv(ndev);
-
-	SET_NETDEV_DEV(ndev, &si->pdev->dev);
-	priv->ndev = ndev;
-	priv->si = si;
-	priv->dev = &si->pdev->dev;
-	si->ndev = ndev;
-
-	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
-	ndev->netdev_ops = ndev_ops;
-	enetc_set_ethtool_ops(ndev);
-	ndev->watchdog_timeo = 5 * HZ;
-	ndev->max_mtu = ENETC_MAX_MTU;
-
-	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
-			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
-			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
-			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
-	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
-			 NETIF_F_HW_VLAN_CTAG_TX |
-			 NETIF_F_HW_VLAN_CTAG_RX |
-			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
-	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
-			      NETIF_F_TSO | NETIF_F_TSO6;
-
-	if (si->num_rss)
-		ndev->hw_features |= NETIF_F_RXHASH;
-
-	ndev->priv_flags |= IFF_UNICAST_FLT;
-	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
-			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
-			     NETDEV_XDP_ACT_NDO_XMIT_SG;
-
-	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
-		priv->active_offloads |= ENETC_F_QCI;
-		ndev->features |= NETIF_F_HW_TC;
-		ndev->hw_features |= NETIF_F_HW_TC;
-	}
-
-	/* pick up primary MAC address from SI */
-	enetc_load_primary_mac_addr(&si->hw, ndev);
-}
-
-static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
-{
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_mdio_priv *mdio_priv;
-	struct mii_bus *bus;
-	int err;
-
-	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
-	if (!bus)
-		return -ENOMEM;
-
-	bus->name = "Freescale ENETC MDIO Bus";
-	bus->read = enetc_mdio_read_c22;
-	bus->write = enetc_mdio_write_c22;
-	bus->read_c45 = enetc_mdio_read_c45;
-	bus->write_c45 = enetc_mdio_write_c45;
-	bus->parent = dev;
-	mdio_priv = bus->priv;
-	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
-
-	err = of_mdiobus_register(bus, np);
-	if (err)
-		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
-
-	pf->mdio = bus;
-
-	return 0;
-}
-
-static void enetc_mdio_remove(struct enetc_pf *pf)
-{
-	if (pf->mdio)
-		mdiobus_unregister(pf->mdio);
-}
-
-static int enetc_imdio_create(struct enetc_pf *pf)
-{
-	struct device *dev = &pf->si->pdev->dev;
-	struct enetc_mdio_priv *mdio_priv;
-	struct phylink_pcs *phylink_pcs;
-	struct mii_bus *bus;
-	int err;
-
-	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
-	if (!bus)
-		return -ENOMEM;
-
-	bus->name = "Freescale ENETC internal MDIO Bus";
-	bus->read = enetc_mdio_read_c22;
-	bus->write = enetc_mdio_write_c22;
-	bus->read_c45 = enetc_mdio_read_c45;
-	bus->write_c45 = enetc_mdio_write_c45;
-	bus->parent = dev;
-	bus->phy_mask = ~0;
-	mdio_priv = bus->priv;
-	mdio_priv->hw = &pf->si->hw;
-	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
-	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
-
-	err = mdiobus_register(bus);
-	if (err) {
-		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
-		goto free_mdio_bus;
-	}
-
-	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
-	if (IS_ERR(phylink_pcs)) {
-		err = PTR_ERR(phylink_pcs);
-		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
-		goto unregister_mdiobus;
-	}
-
-	pf->imdio = bus;
-	pf->pcs = phylink_pcs;
-
-	return 0;
-
-unregister_mdiobus:
-	mdiobus_unregister(bus);
-free_mdio_bus:
-	mdiobus_free(bus);
-	return err;
-}
-
-static void enetc_imdio_remove(struct enetc_pf *pf)
-{
-	if (pf->pcs)
-		lynx_pcs_destroy(pf->pcs);
-	if (pf->imdio) {
-		mdiobus_unregister(pf->imdio);
-		mdiobus_free(pf->imdio);
-	}
-}
-
-static bool enetc_port_has_pcs(struct enetc_pf *pf)
-{
-	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
-		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
-		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
-}
-
-static int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
-{
-	struct device_node *mdio_np;
-	int err;
-
-	mdio_np = of_get_child_by_name(node, "mdio");
-	if (mdio_np) {
-		err = enetc_mdio_probe(pf, mdio_np);
-
-		of_node_put(mdio_np);
-		if (err)
-			return err;
-	}
-
-	if (enetc_port_has_pcs(pf)) {
-		err = enetc_imdio_create(pf);
-		if (err) {
-			enetc_mdio_remove(pf);
-			return err;
-		}
-	}
-
-	return 0;
-}
-
-static void enetc_mdiobus_destroy(struct enetc_pf *pf)
-{
-	enetc_mdio_remove(pf);
-	enetc_imdio_remove(pf);
-}
-
 static struct phylink_pcs *
 enetc_pl_mac_select_pcs(struct phylink_config *config, phy_interface_t iface)
 {
@@ -1101,47 +854,6 @@ static const struct phylink_mac_ops enetc_mac_phylink_ops = {
 	.mac_link_down = enetc_pl_mac_link_down,
 };
 
-static int enetc_phylink_create(struct enetc_ndev_priv *priv,
-				struct device_node *node)
-{
-	struct enetc_pf *pf = enetc_si_priv(priv->si);
-	struct phylink *phylink;
-	int err;
-
-	pf->phylink_config.dev = &priv->ndev->dev;
-	pf->phylink_config.type = PHYLINK_NETDEV;
-	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
-		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
-
-	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_SGMII,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-		  pf->phylink_config.supported_interfaces);
-	__set_bit(PHY_INTERFACE_MODE_USXGMII,
-		  pf->phylink_config.supported_interfaces);
-	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
-
-	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
-				 pf->if_mode, &enetc_mac_phylink_ops);
-	if (IS_ERR(phylink)) {
-		err = PTR_ERR(phylink);
-		return err;
-	}
-
-	priv->phylink = phylink;
-
-	return 0;
-}
-
-static void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
-{
-	phylink_destroy(priv->phylink);
-}
-
 /* Initialize the entire shared memory for the flow steering entries
  * of this port (PF + VFs)
  */
@@ -1338,7 +1050,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_mdiobus_create;
 
-	err = enetc_phylink_create(priv, node);
+	err = enetc_phylink_create(priv, node, &enetc_mac_phylink_ops);
 	if (err)
 		goto err_phylink_create;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
new file mode 100644
index 000000000000..925011b16563
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -0,0 +1,295 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/* Copyright 2024 NXP */
+
+#include <linux/fsl/enetc_mdio.h>
+#include <linux/of_mdio.h>
+#include <linux/of_net.h>
+#include <linux/pcs-lynx.h>
+
+#include "enetc_pf_common.h"
+
+int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct sockaddr *saddr = addr;
+
+	if (!is_valid_ether_addr(saddr->sa_data))
+		return -EADDRNOTAVAIL;
+
+	eth_hw_addr_set(ndev, saddr->sa_data);
+	enetc_pf_set_primary_mac_addr(&priv->si->hw, 0, saddr->sa_data);
+
+	return 0;
+}
+
+static int enetc_setup_mac_address(struct device_node *np, struct enetc_pf *pf,
+				   int si)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_hw *hw = &pf->si->hw;
+	u8 mac_addr[ETH_ALEN] = { 0 };
+	int err;
+
+	/* (1) try to get the MAC address from the device tree */
+	if (np) {
+		err = of_get_mac_address(np, mac_addr);
+		if (err == -EPROBE_DEFER)
+			return err;
+	}
+
+	/* (2) bootloader supplied MAC address */
+	if (is_zero_ether_addr(mac_addr))
+		enetc_pf_get_primary_mac_addr(hw, si, mac_addr);
+
+	/* (3) choose a random one */
+	if (is_zero_ether_addr(mac_addr)) {
+		eth_random_addr(mac_addr);
+		dev_info(dev, "no MAC address specified for SI%d, using %pM\n",
+			 si, mac_addr);
+	}
+
+	enetc_pf_set_primary_mac_addr(hw, si, mac_addr);
+
+	return 0;
+}
+
+int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf)
+{
+	int err, i;
+
+	/* The PF might take its MAC from the device tree */
+	err = enetc_setup_mac_address(np, pf, 0);
+	if (err)
+		return err;
+
+	for (i = 0; i < pf->total_vfs; i++) {
+		err = enetc_setup_mac_address(NULL, pf, i + 1);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
+			   const struct net_device_ops *ndev_ops)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+
+	SET_NETDEV_DEV(ndev, &si->pdev->dev);
+	priv->ndev = ndev;
+	priv->si = si;
+	priv->dev = &si->pdev->dev;
+	si->ndev = ndev;
+
+	priv->msg_enable = (NETIF_MSG_WOL << 1) - 1;
+	ndev->netdev_ops = ndev_ops;
+	enetc_set_ethtool_ops(ndev);
+	ndev->watchdog_timeo = 5 * HZ;
+	ndev->max_mtu = ENETC_MAX_MTU;
+
+	ndev->hw_features = NETIF_F_SG | NETIF_F_RXCSUM |
+			    NETIF_F_HW_VLAN_CTAG_TX | NETIF_F_HW_VLAN_CTAG_RX |
+			    NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_LOOPBACK |
+			    NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+	ndev->features = NETIF_F_HIGHDMA | NETIF_F_SG | NETIF_F_RXCSUM |
+			 NETIF_F_HW_VLAN_CTAG_TX |
+			 NETIF_F_HW_VLAN_CTAG_RX |
+			 NETIF_F_HW_CSUM | NETIF_F_TSO | NETIF_F_TSO6;
+	ndev->vlan_features = NETIF_F_SG | NETIF_F_HW_CSUM |
+			      NETIF_F_TSO | NETIF_F_TSO6;
+
+	if (si->num_rss)
+		ndev->hw_features |= NETIF_F_RXHASH;
+
+	ndev->priv_flags |= IFF_UNICAST_FLT;
+	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
+			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
+			     NETDEV_XDP_ACT_NDO_XMIT_SG;
+
+	if (si->hw_features & ENETC_SI_F_PSFP && !enetc_psfp_enable(priv)) {
+		priv->active_offloads |= ENETC_F_QCI;
+		ndev->features |= NETIF_F_HW_TC;
+		ndev->hw_features |= NETIF_F_HW_TC;
+	}
+
+	/* pick up primary MAC address from SI */
+	enetc_load_primary_mac_addr(&si->hw, ndev);
+}
+
+static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_mdio_priv *mdio_priv;
+	struct mii_bus *bus;
+	int err;
+
+	bus = devm_mdiobus_alloc_size(dev, sizeof(*mdio_priv));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "Freescale ENETC MDIO Bus";
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
+	bus->parent = dev;
+	mdio_priv = bus->priv;
+	mdio_priv->hw = &pf->si->hw;
+	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
+
+	err = of_mdiobus_register(bus, np);
+	if (err)
+		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
+
+	pf->mdio = bus;
+
+	return 0;
+}
+
+static void enetc_mdio_remove(struct enetc_pf *pf)
+{
+	if (pf->mdio)
+		mdiobus_unregister(pf->mdio);
+}
+
+static int enetc_imdio_create(struct enetc_pf *pf)
+{
+	struct device *dev = &pf->si->pdev->dev;
+	struct enetc_mdio_priv *mdio_priv;
+	struct phylink_pcs *phylink_pcs;
+	struct mii_bus *bus;
+	int err;
+
+	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
+	if (!bus)
+		return -ENOMEM;
+
+	bus->name = "Freescale ENETC internal MDIO Bus";
+	bus->read = enetc_mdio_read_c22;
+	bus->write = enetc_mdio_write_c22;
+	bus->read_c45 = enetc_mdio_read_c45;
+	bus->write_c45 = enetc_mdio_write_c45;
+	bus->parent = dev;
+	bus->phy_mask = ~0;
+	mdio_priv = bus->priv;
+	mdio_priv->hw = &pf->si->hw;
+	mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
+	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
+
+	err = mdiobus_register(bus);
+	if (err) {
+		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
+		goto free_mdio_bus;
+	}
+
+	phylink_pcs = lynx_pcs_create_mdiodev(bus, 0);
+	if (IS_ERR(phylink_pcs)) {
+		err = PTR_ERR(phylink_pcs);
+		dev_err(dev, "cannot create lynx pcs (%d)\n", err);
+		goto unregister_mdiobus;
+	}
+
+	pf->imdio = bus;
+	pf->pcs = phylink_pcs;
+
+	return 0;
+
+unregister_mdiobus:
+	mdiobus_unregister(bus);
+free_mdio_bus:
+	mdiobus_free(bus);
+	return err;
+}
+
+static void enetc_imdio_remove(struct enetc_pf *pf)
+{
+	if (pf->pcs)
+		lynx_pcs_destroy(pf->pcs);
+
+	if (pf->imdio) {
+		mdiobus_unregister(pf->imdio);
+		mdiobus_free(pf->imdio);
+	}
+}
+
+static bool enetc_port_has_pcs(struct enetc_pf *pf)
+{
+	return (pf->if_mode == PHY_INTERFACE_MODE_SGMII ||
+		pf->if_mode == PHY_INTERFACE_MODE_1000BASEX ||
+		pf->if_mode == PHY_INTERFACE_MODE_2500BASEX ||
+		pf->if_mode == PHY_INTERFACE_MODE_USXGMII);
+}
+
+int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node)
+{
+	struct device_node *mdio_np;
+	int err;
+
+	mdio_np = of_get_child_by_name(node, "mdio");
+	if (mdio_np) {
+		err = enetc_mdio_probe(pf, mdio_np);
+
+		of_node_put(mdio_np);
+		if (err)
+			return err;
+	}
+
+	if (enetc_port_has_pcs(pf)) {
+		err = enetc_imdio_create(pf);
+		if (err) {
+			enetc_mdio_remove(pf);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+void enetc_mdiobus_destroy(struct enetc_pf *pf)
+{
+	enetc_mdio_remove(pf);
+	enetc_imdio_remove(pf);
+}
+
+int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
+			 const struct phylink_mac_ops *ops)
+{
+	struct enetc_pf *pf = enetc_si_priv(priv->si);
+	struct phylink *phylink;
+	int err;
+
+	pf->phylink_config.dev = &priv->ndev->dev;
+	pf->phylink_config.type = PHYLINK_NETDEV;
+	pf->phylink_config.mac_capabilities = MAC_ASYM_PAUSE | MAC_SYM_PAUSE |
+		MAC_10 | MAC_100 | MAC_1000 | MAC_2500FD;
+
+	__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_SGMII,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_2500BASEX,
+		  pf->phylink_config.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_USXGMII,
+		  pf->phylink_config.supported_interfaces);
+	phy_interface_set_rgmii(pf->phylink_config.supported_interfaces);
+
+	phylink = phylink_create(&pf->phylink_config, of_fwnode_handle(node),
+				 pf->if_mode, ops);
+	if (IS_ERR(phylink)) {
+		err = PTR_ERR(phylink);
+		return err;
+	}
+
+	priv->phylink = phylink;
+
+	return 0;
+}
+
+void enetc_phylink_destroy(struct enetc_ndev_priv *priv)
+{
+	phylink_destroy(priv->phylink);
+}
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
new file mode 100644
index 000000000000..2ae9c87c8c8a
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright 2024 NXP */
+
+#include "enetc_pf.h"
+
+void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr);
+void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
+				   const u8 *addr);
+int enetc_pf_set_mac_addr(struct net_device *ndev, void *addr);
+int enetc_setup_mac_addresses(struct device_node *np, struct enetc_pf *pf);
+void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
+			   const struct net_device_ops *ndev_ops);
+int enetc_mdiobus_create(struct enetc_pf *pf, struct device_node *node);
+void enetc_mdiobus_destroy(struct enetc_pf *pf);
+int enetc_phylink_create(struct enetc_ndev_priv *priv, struct device_node *node,
+			 const struct phylink_mac_ops *ops);
+void enetc_phylink_destroy(struct enetc_ndev_priv *priv);
-- 
2.34.1


