Return-Path: <linux-pci+bounces-15174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B30AB9ADD2F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 09:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DD8A282E0B
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 07:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E60B1AF0BB;
	Thu, 24 Oct 2024 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EcSswzuJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0A1AE863;
	Thu, 24 Oct 2024 07:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729753755; cv=fail; b=s73Ee6PRgSH+cS0i1DC/mzMA7jLILOwa2PCKn5DSS9DFMrsv117iFl9f9m191DPs/2rq23TFQNhJdzPIMutFf9SDdRWBs7FbxPj37euGKlNwiho5rXKhAT/LiEDwv3mBvsH4+LVcEAuh5cjuk9HgKC7spgRjpLkYMQJFxqJcFKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729753755; c=relaxed/simple;
	bh=nO80/WMwWr1Cszc9e3EkeHOuOGz4sV/k21NhcKa/nt4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JF5R22prouEEQfC80vl3pucorX4QJTDYQswr662+ozpz1HnhRCNCUBLwIAmM9kq5PKl8U9aWIQkkLl+thVxBxc4t0ser1zUzIHqp2KjRXuRR5oBR6r7occXoQSSlGyZvzmc9FdNIMlf0q6y2BPUxedg8CKO/G1U8ocQA5NMTCTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EcSswzuJ; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSd2A/2mKo4PqddXyC0npwYTqDG5AmCiO8D7Is3r+3i6GhLtv22J5hlgvJHk7sa4qV3+X3lnSUQ1gZfG4a1kTww0HCe5v8NAoXC5EPRtEE4SGckCysiBGcTVxLBKBeqGobmx4bBLhVUun76x/hoQyk5vWc4W44CQZmodFvP3lt38GhrSVTqmRW7QaUgLFQ+AQ1GEk1fnLq3RRhd1TAdLhrsnold25prsorTzFlyhq368M/nFfhX5fmDjCu4qP7K4UiT4ArbIhhYFyDP7uFhVC9XGzNEW2lc+B7/VrseVchufx8k/wInupSoDHWW3vl1sv4utTztKO5k2iXUoS7eMNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmcZ+77nPZe9zy1ANHkgquOqGn/FRrjur6Msixgy2AQ=;
 b=lM8toMMF/GXwD8GugOmTSEc1GkFTc1CkNiDMHVwfdaVi7rUi/iip4OTtN5vKBEtgswHKEFivF2n9cPRBmRF/MBKLHxUfuAzeqUIT8LI/0Uo9BD5ex6Xk0yqfW1ZCyGdI6JWxGppfEbG03O7pdu6y2n8AeabQ0UROYkJSkHvUi7w+fOM+0VTeX3wHylftcEBOcbsqVnwEC9kA057Fuqa2vc9zIzzFGSieaiZttHR+7U9J23TND8veczjojBziVbtdemMq4cajlLTwnSOtmKxfq64vO2B2Sl2DmTowkx5oEnNh12vh0P39TU7XWHFmdHRcWDSEF/IdY+avfTLExKyb6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmcZ+77nPZe9zy1ANHkgquOqGn/FRrjur6Msixgy2AQ=;
 b=EcSswzuJ/X4SjUUCOR4yzfajyuZbavayThzmIxs+Epyd4f35yvM1MGxzBcOpMxAlTqjuxy3UscA5wDZwC3ZZgQMSzBvqrlSccSJ4K8W9DbZB3mhhdhJsJjHYmHHII85VDQZ3Dmnh7gv90RijmWnBc18gHiQjDWaZZjLrsEPerfLV7cY74CPBIS49MqWTmSFenezdsk1CtcrMc5qJEfHl+9BB4uo5/9xDsTPJvzv80xxB742Nlak/jVECvVa6HS1z9G64Vgnkbj2F01gDCL/Yw+BZAtXrhoC8qkzCN3TtnDVBGTNvuUTdhUaIedzgdHQcfFMt7TZvW+QlaRa8jc5Axw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9153.eurprd04.prod.outlook.com (2603:10a6:102:22b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 24 Oct
 2024 07:09:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 07:09:08 +0000
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
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v5 net-next 05/13] net: enetc: extract common ENETC PF parts for LS1028A and i.MX95 platforms
Date: Thu, 24 Oct 2024 14:53:20 +0800
Message-Id: <20241024065328.521518-6-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024065328.521518-1-wei.fang@nxp.com>
References: <20241024065328.521518-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 55644329-e929-4b05-2bca-08dcf3fac10e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|7416014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QN7KLb6mOdvEsY5qJnHjVu2y11dcg0awgUn+9Jv0TTyl5co1tTr9q88dd6ug?=
 =?us-ascii?Q?DKdk1qRVXZ0L0ylHibw7RAaZp3ii3cjAagMwGg0emlW5GCPXAjzDix2ARse7?=
 =?us-ascii?Q?/XpGKkB7HdKVMYrB+kOQSOQJ0Rb/t3mVe1JdQjaMn6VDslMOmD51k84qZ7Hp?=
 =?us-ascii?Q?FkMqLgczU6Qf1QQWTWHJKqWa6tbomTdd08nIcfIa/IgL3qwZgAKXReD48uaE?=
 =?us-ascii?Q?NpsS5+IIPPJG1ri+qdmlQCYGMmNeUozgI0jYfpiVW7im2Fej67i2KKdrrISL?=
 =?us-ascii?Q?7MM9RGthJ4rikObP8vpnqIk8ksO+fi0Sh3oYh8/Nn62XDF6Lu9GG9Ldn68hA?=
 =?us-ascii?Q?VmiLKLxpeZ0KVQSQUNx9PPacut3g/p2h8FLletvVIXQQcrGlS5gvmrdUF7aA?=
 =?us-ascii?Q?ikBiqb4qJypCYjWXVdFQRQZdlPkM3tDTDbONfmnnYYvEG1ICgo/HTPmNZqbY?=
 =?us-ascii?Q?+zBMn731ediP/FewSo7PHVWRL6616R2kQo3rahPwSh5tQqFFu6ejiHYYVk8e?=
 =?us-ascii?Q?mdGOwwJpf/DPP/hd/nO1xMW/TwtYBPdV8NvW9ilzvlPBznfLxffPs/mx2FpI?=
 =?us-ascii?Q?mbdgqGnVLXHlXEifHmN3zQS/OUacNfSpU/7AiUdu7pAY8PwN1UO7wkITOWqq?=
 =?us-ascii?Q?uc/6l9rNOszUYtHSgviXBrW/9YuT3EqEbsNpAtKd5fyq0e4JH6jNkfxxzgar?=
 =?us-ascii?Q?/3iU9vBSCyO5P7RRod9ugO7E0hRe7bOvuztZF8IIQg3P0qmCBju3KVRjI7fa?=
 =?us-ascii?Q?oNScpeeraeDDni6uyjEn2+0M2IyoN3YgobupJwjjREGDdkTT+dCbVzCDrBwm?=
 =?us-ascii?Q?QGYxyrh9sRgv+4w4bv7P0eLKhxWZGYD7MbbDj1qvVe8jgPwaxeNi8ZSPbE2B?=
 =?us-ascii?Q?Zj0d0H/qrl8+nVOItAbkEPgStXmAvL/r9GeILdU9z3tRnxT+s0/ImpIoNmwd?=
 =?us-ascii?Q?MBguR9gZ4Akvpq77vWUPlPQQ8bLQEMLt3k2JI5P7yiksV+XUxuFEcPIMi+pB?=
 =?us-ascii?Q?UJnLBcYHDL2MQWt0w/OWHH1B2WtPlX1OzbvWOPhllBqFzb+KwKf4rCIlBxJU?=
 =?us-ascii?Q?5wLzK0Rl2RUMR+BwSl4Vhe1+nSKTGk9/3Xtf1WxuGQFoRnonDdTMGHfCFKJI?=
 =?us-ascii?Q?sLj2n4hCbNxc0+uOcQLt7ZI47jUEHLRGaPX8sNI2m8b+Fs50ZqQiQFbqfXeJ?=
 =?us-ascii?Q?IVNOdzjKf0D9BfLsQExmeazC94FdP/sjWuiC2nFion1AYCPIHCJqaMlB6u1o?=
 =?us-ascii?Q?8BkK3A4k6bWxeCCrpobD4+x8qOfIRyeran6q7m0MEayn+rrDuXdJgLZpqaXF?=
 =?us-ascii?Q?i1jfpyn2nUJecIEFmou1s1kHGgkQbF27iTIekIgrVxRpESm1L8ppvUnh4LWd?=
 =?us-ascii?Q?nrphNjfDvhPT2Q6htVVv9xXI1F+f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W89jyvZE+/PxCdSq+Rz9XHlE3WFr4a3wPHGoIm2CSzYghYPXbeMlU7WlLFhV?=
 =?us-ascii?Q?mSEQ+xaxVioNRewmkTHHpfHo/nd/b8toYJeZQIjiLHXh+vsJmakkCizzgwPu?=
 =?us-ascii?Q?qZAuT6U86XzgEx9xjUevb8evve0kZJFhm/e/UP5OzqKDw61SJtOB/cSAruHg?=
 =?us-ascii?Q?Rq2D2Qs+TQwSKBHqASjNLLOykeKu2WKYjpjpnMqsBYJ0DsgjxgmtewxAkSvk?=
 =?us-ascii?Q?8VyrXGCmgcESf0gy03j1+g9lWJumPMqQoDIIFvC6lDItuABVit68ey7XhaFp?=
 =?us-ascii?Q?cJfEvzg4teLq1Shtq4t4lD1SIVfy4QXwRWN8mcCYc2rtPxK4N2PpdypjcoIG?=
 =?us-ascii?Q?IjcQdM6NBPClDYOMb65RAgbkmcb8wcmq0BVWtbILAQ3c/0qv1QBN8ydu6F2N?=
 =?us-ascii?Q?mV8DZRKxaYrmjftNwQLet5FCXvNtDKVMNsbO9eat1DJsjkbs35W/xEhbaLHw?=
 =?us-ascii?Q?qpRhaTxXxmz/v5BEAGE5m3rUvcCsh8v9pZ3QAefrZ/AIJbZ9oAl1KJO/qffG?=
 =?us-ascii?Q?LmHs6EFsJfjJCaeoNILb/opFq/RmeCtIx5b5NmvWidfd4M6tsje1VowNVNvt?=
 =?us-ascii?Q?MzVzwft7a3/lcIHQgSguqMH3aPpZbQiBcev4BQ/o/PNHdo9jkKR8aG46GLPX?=
 =?us-ascii?Q?bq5StuVgI7XInE6pSi5F4BEFb3QpxMqKwNx0jZMg0aeLzxwZ+9dECRCt/VFI?=
 =?us-ascii?Q?TfrzM5fWz94UhXS+jaIvThnYv/8uSQMGWBOjS2+KcNb+c5QWCpk0jc5AY8zM?=
 =?us-ascii?Q?OL1AeO+APFQyMHFYdlCe4mgZvim/AKAuBR3ohw1LAhJuTImdpv4vv0lzKKYs?=
 =?us-ascii?Q?HXKZZtfFijmpegugSQQxEqYuGvZ5GEllYXwHXHJmj9PAIGVBePBGHzm4pbya?=
 =?us-ascii?Q?OXG+RqIMHSma4Ke7BKCiFNRHOF7Pt3AHb96OuDNd9W2tvydQWPdSxS6NGeOs?=
 =?us-ascii?Q?BMa3tIHOSNxAhSG0kigioKZXNRIAEBHDUAoXfOqpr0+Va7qM3sOvE18Sgxg9?=
 =?us-ascii?Q?Z6a34ffqd7NsUM0XiTohfQaSKKClU85tFPCEbscdJJGipmYTAcP5pR6NeNjb?=
 =?us-ascii?Q?IS9+ZLBqlaf+cwL6gVa6ofzgoliEftSiOiaBj6IuQRUTIP1ci+HeHIaIJ10T?=
 =?us-ascii?Q?uIJf93sa6UPrsWOAUVVaZZHhvKC/n2eRnITVrKtfx2t9POwfQlH8M16uU6cG?=
 =?us-ascii?Q?yHqYsBjYj65DCMX/d0SeoIWgaagWX/vUXHtFLyHHTjaZLkXNppKJ9K1/zaMi?=
 =?us-ascii?Q?Fr7IUfBQsbztCIuKWz8S//LyVZmQTtWuv2+w5Xr0k1FqC/nXigZdxfkpEgTr?=
 =?us-ascii?Q?ILJIuYKlip3/b3Frcm9j3bWsoquC8+Ay2f37Pa/V66CjfmLzOH1R833pXfdF?=
 =?us-ascii?Q?nliQ5eDbzWks1pv73kiLQaP2gyDZleuvAT7C2z809fu/4FqQ/vA3pyJR02vT?=
 =?us-ascii?Q?q9e/BBia01Hr1Z16HeznN0cde6V2y7v2lHzk5vQkCB5m6DlrTReIzp1qE3pM?=
 =?us-ascii?Q?YkFQekwifT726DepmPjTp9NlAaPwYIoLLKPAgxoYiPJiJ9A1gSozyuBjlUBj?=
 =?us-ascii?Q?d6qpuOUb3xM5WpUBqfSQj8NC0nP8sXJDpP8Xszc6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55644329-e929-4b05-2bca-08dcf3fac10e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 07:09:08.8524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 20esvJ77umcruZ5lPlLjRl3Rqr804eUQBxPktzjATE3Op7veLVkgsJdaNBvRTCLxGAzMw7mB/MZlfSBkS1Tzxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9153

The ENETC PF driver of LS1028A (rev 1.0) is incompatible with the version
used on the i.MX95 platform (rev 4.1), except for the station interface
(SI) part. To reduce code redundancy and prepare for a new driver for rev
4.1 and later, extract shared interfaces from enetc_pf.c and move them to
enetc_pf_common.c. This refactoring lays the groundwork for compiling
enetc_pf_common.c into a shared driver for both platforms' PF drivers.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>
---
v5: no changes
---
 drivers/net/ethernet/freescale/enetc/Makefile |   2 +-
 .../net/ethernet/freescale/enetc/enetc_pf.c   | 297 +-----------------
 .../net/ethernet/freescale/enetc/enetc_pf.h   |  13 +
 .../freescale/enetc/enetc_pf_common.c         | 295 +++++++++++++++++
 4 files changed, 313 insertions(+), 294 deletions(-)
 create mode 100644 drivers/net/ethernet/freescale/enetc/enetc_pf_common.c

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
index 8f6b0bf48139..3cdd149056f9 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.c
@@ -2,11 +2,8 @@
 /* Copyright 2017-2019 NXP */
 
 #include <linux/unaligned.h>
-#include <linux/mdio.h>
 #include <linux/module.h>
-#include <linux/fsl/enetc_mdio.h>
 #include <linux/of_platform.h>
-#include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/pcs-lynx.h>
 #include "enetc_ierb.h"
@@ -14,7 +11,7 @@
 
 #define ENETC_DRV_NAME_STR "ENETC PF driver"
 
-static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
+void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 {
 	u32 upper = __raw_readl(hw->port + ENETC_PSIPMAR0(si));
 	u16 lower = __raw_readw(hw->port + ENETC_PSIPMAR1(si));
@@ -23,8 +20,8 @@ static void enetc_pf_get_primary_mac_addr(struct enetc_hw *hw, int si, u8 *addr)
 	put_unaligned_le16(lower, addr + 4);
 }
 
-static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
-					  const u8 *addr)
+void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
+				   const u8 *addr)
 {
 	u32 upper = get_unaligned_le32(addr);
 	u16 lower = get_unaligned_le16(addr + 4);
@@ -33,20 +30,6 @@ static void enetc_pf_set_primary_mac_addr(struct enetc_hw *hw, int si,
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
@@ -393,56 +376,6 @@ static int enetc_pf_set_vf_spoofchk(struct net_device *ndev, int vf, bool en)
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
@@ -775,187 +708,6 @@ static const struct net_device_ops enetc_ndev_ops = {
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
@@ -1101,47 +853,6 @@ static const struct phylink_mac_ops enetc_mac_phylink_ops = {
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
@@ -1338,7 +1049,7 @@ static int enetc_pf_probe(struct pci_dev *pdev,
 	if (err)
 		goto err_mdiobus_create;
 
-	err = enetc_phylink_create(priv, node);
+	err = enetc_phylink_create(priv, node, &enetc_mac_phylink_ops);
 	if (err)
 		goto err_phylink_create;
 
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf.h b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
index c26bd66e4597..92a26b09cf57 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf.h
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf.h
@@ -58,3 +58,16 @@ struct enetc_pf {
 int enetc_msg_psi_init(struct enetc_pf *pf);
 void enetc_msg_psi_free(struct enetc_pf *pf);
 void enetc_msg_handle_rxmsg(struct enetc_pf *pf, int mbox_id, u16 *status);
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
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
new file mode 100644
index 000000000000..bce81a4f6f88
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
+#include "enetc_pf.h"
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
-- 
2.34.1


