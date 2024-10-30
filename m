Return-Path: <linux-pci+bounces-15573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6339B5F66
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 10:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0E8283FCC
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 09:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D373B1E500F;
	Wed, 30 Oct 2024 09:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZHmvG5Ek"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE81E5016;
	Wed, 30 Oct 2024 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730282113; cv=fail; b=e71457GN/sLEXp+xpUC3/KrVVM4Ybci+j80vtKSAM3Nv2h/eUl/GdyUuei2mCWkLNM+Q75a1qEH1lNCq3h7Y6SODVg+28BwRpxp8P0I96VCfCordaJlkYJmsXpQ47YHRFqpfiFdxhNL+Gt9WLYp0fQFqPWI3MT2asCFDMIEvsLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730282113; c=relaxed/simple;
	bh=wrv+kqkkPSZ6cvh0Xend1dn0/bI7PplICNknS9E+fQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aBiks3nKnWvtadHaesKGOCQeYL4PHzmKc4tJNMzfMGllVP++unk90xA7B1S4lz16O4zgDrdllo353z7CNZfitbnRGlWmAIw1vwzi/zL2ZZmK0YI79/WS1bEIDbXHeoxlBPXiNXzzfYKPY+JY09M3/go3Azl9nyCuOfiWoUMMqyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZHmvG5Ek; arc=fail smtp.client-ip=40.107.247.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKvnybDrIl26jxRDOxHx+ubdHz0bkMs/YLlvuYN4olo7LZN4gGxq9qRRxt8KRBL1HDPQKym8Jzpc7GmHOOnAsVF8BKZzcERngFfKEmGrUwcZgYdzySyXepMMPinLKYCHqgtGgpiZZ9nctjW4bVkzewG55O9Og+353qA0fZNhHst2Lwp18Xbq8bJ51t6Mnr0GhUQ1uW6/jsTqZqOV42t3tiEo+7XkmdHzGsWZ58GAtIJxeJjej+x8RXRj2S7iVoJiHnveoXkskjLX0LDyvJBQuIlIoqeSaUvfpJdT1dmYCpvoovKETVs+JUbXVWuNcZoOHfG+3MtwVctB0BvgAMIaMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARbD14h42wKT+hoa9jYlex8DCEdlnracvHxWNYQo0Vc=;
 b=zRaaqvOhp/ffI/9NBjM5fO4qQis9dDiuPlTZ38Zg8pVVAbsKHg1Vdx3uTjmzKfkNXynZuJApTAtuPOaT7b3/ZrRed5C6w01+sGQpp8aiOU/UV3vQ82qWmB6oD4F5Vv3K0zV33vQmVd6AvJz29OUtv6dMmGl6VDeNgeibw/U/sV2dZh4nN2smmcvowahw4VyJF8C5ZWbpuCaM3OF07dPbivoK8LlkZx5EF2OWV2DE8bVtiprYJoRmtP2cs0WGqYkoT9d1qMh0D0ZNtAv7inXVf1Haaq0p24zhKos9qae/m/nBjGlLwC+B6KhzR2DL4SyRpYO07Fjh6yS2/Nk/ld8Cng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARbD14h42wKT+hoa9jYlex8DCEdlnracvHxWNYQo0Vc=;
 b=ZHmvG5Ek5eNtu8xIJ+ufor5lbwCxdxuxA9HUM75KyvtMDhDy0vdNzyamjEokr9LqqXwsvVn+zq3XlPPWgWn3E8ntp/6CU3bDNh5QwkYZo11peSbMlx9gnjVDiad7Xyr+MbmdEROPysoZPNozTbUZJsCA0Qfgpw4HkAl5HodLvyJK1BNTdsOajMZU3eFKVCCwR933VZON7yvnM8r/iK0IvT9Qkf6pzUedV9AGihnI7YYJvJUzypsoXX9i3X7eQshsFVUT90Ka6A3n4WOq+nvx39pFW87UOty19WPpe7DBSS48GH1VdmVovg0FdsPL9WVWosFlNmAu2LOn2f1SlFvfeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10347.eurprd04.prod.outlook.com (2603:10a6:102:424::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 09:55:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 09:55:06 +0000
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
Subject: [PATCH v6 net-next 04/12] net: enetc: add initial netc-blk-ctrl driver support
Date: Wed, 30 Oct 2024 17:39:15 +0800
Message-Id: <20241030093924.1251343-5-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 97f6be59-d8e3-4c04-b90e-08dcf8c8eed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y72Eqvoixa9EY6UCPONxyaiDuMKMBl7HTGVTOGItea7ZO1BGzqjDzf6E5cGx?=
 =?us-ascii?Q?myxGM5kUAOyWgqQ60M3DJZ5hEsRrDf2DEWykNYfXA8ViNRxmFrSyKFRLW6w4?=
 =?us-ascii?Q?/6Li9vsAH+GnJ+ehjy78wx1rYxNFmqRTGkhvu6yxDdkjhWWpPFlxIQ7vMo2k?=
 =?us-ascii?Q?FkBUDERVznzrvn3DtMbRNDnPFvUtEgrjln7av4SXmo2kz3hEsZVtIPdwMfwb?=
 =?us-ascii?Q?0bHdfAzTYduSrp+C6ZsUEkqhfv2Ixs1yngg/Gdmv0THr8a72Mlsxfz5Qna/d?=
 =?us-ascii?Q?+HcXdvxIZxKMXdebz4+LgKGAo7a2px7jUX0iK6tKrrxVmdmgWaDKdiN47IGe?=
 =?us-ascii?Q?I7WdtonomgUCMKPkgZF1c5/c1wSg7HnW3Mj76lgg4wkoeKrSdxtt41vy+Pj7?=
 =?us-ascii?Q?z5uGD9a4ms76DKwoyLBAIj2vLGB9XcOIFkfwVxukHyokqR4Z/+3DTXQRXpib?=
 =?us-ascii?Q?bSsz/6CNb4D+fuH/7bHRJqisewFfNt7fpzlV3IcM6ihhPMofiE6IEPj9NI1b?=
 =?us-ascii?Q?qrSq866wPyV59lxtBQmM6PUmQi81timwruNUjnP+oLNzh0x9TnM0IE8FPHQ6?=
 =?us-ascii?Q?ZxopEjAEvbz5k1Es18IouZNOAhiVvygW9jNftzccF3t/dbUbEem3Q1+avWgG?=
 =?us-ascii?Q?dPIlw/SCt4Gn/r94NXPdDdFQTtOz6IFRIP6wpjzLZ6YjGQvAKhOqOfpfGmam?=
 =?us-ascii?Q?bwWjylKz27uMASEVSwac6Akx0+iWhr6fh6qwn0OuZNI6gWFAzvt4W00rbZXl?=
 =?us-ascii?Q?iKaAncElJPPWb+Spr65JVVw3WN6m7MkkU4xdk/8ghQI9u/SvIQFMOjMgQHV9?=
 =?us-ascii?Q?OzupHd/AtRMABzneSXqto751jcc2scJZvmGh4QyET8QhkkUcYNkO/svVp0Nl?=
 =?us-ascii?Q?yRrm7ZCZ6Q35E4yu7P/mNRUyVxNKl3852RQCZPvtDdXtcIerydxXI5OIXchC?=
 =?us-ascii?Q?8YmKytHxY/NzsZBcYLXw62vX7kQ0wxwfER7d/PvS2URmR4twgjJ7S7QG3H2B?=
 =?us-ascii?Q?3jXC8qQfd9dLNU8du5oEHOFdgQpcF4KSbGccdT5Yn9IGb2G3Ev01JuSlNWXB?=
 =?us-ascii?Q?hXz6BvY/XDWyZdMZZWa11zRujkrnZUEo4alE5i1bKwfgxtm98sSh/tM6IAGX?=
 =?us-ascii?Q?5WxtWTDoSdrfBVmoPDR5n4IXccKhmtgfku0CDrA8/DdUDbQ4fVujzhkkkaSO?=
 =?us-ascii?Q?Uf1yn05QXs103O46nYe7ztoEv+Bxvaud+JnHqjlx2WC4Y/DSZT4TRT/eUcCV?=
 =?us-ascii?Q?xZXg8R1AScIGi7BE+K03T/noWIsJjxHUV/J//WKVNa8wf35YPko8C3OCJi+d?=
 =?us-ascii?Q?A3Pgco8wvvFeuivt60eHVOoMzzbCaw+EJThZ1wFHnMUKz8wbW9Qg/w/xSgNO?=
 =?us-ascii?Q?po3c5FSEvOa00SMJHoOZrOG/Gk1d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vy6Umd4q3DNXAJRIT0pfwpEM23xQfVLgPF3PtU400nSqCxtYxSRilsA1c4DO?=
 =?us-ascii?Q?g0GFRjeSYYSNM77ui3dCn+fy7mbtmZoYr0NGOYj74/j9ypwUftLnnvdlXBg5?=
 =?us-ascii?Q?uiNQtO/fIUFAl3dcY2FRkdXwR1H+E3bT0SnTsHxQBy3rooxeDB6/P7XxL1bt?=
 =?us-ascii?Q?Jbg5EDNrixIIinBNvZ4ZMmS3VWiQ93Nto84KYtEm6tpFm0n1hL9jlB93dTw/?=
 =?us-ascii?Q?6cCYBZECpTFQsRXioEO4jWp4H4AlM668QHhdLuPoSmvpk1hGAaKfOJwkvreA?=
 =?us-ascii?Q?fyrSsa3yOJ6B8q9dcMqs/TPczeVo8o6V4GPjy6eZrXo3znxpqhcU4zw3AwcO?=
 =?us-ascii?Q?VycgLGV6CxxHMBsFj80aeXJHuruF9Uz8ayrhS0N+ycVQtvThiLVIMNmba6Pp?=
 =?us-ascii?Q?iVNVDtXkJ8gQb6gQK13EzyFGa8Sx+tPlmPRzohN5KShANrLvsdpekIZjop/g?=
 =?us-ascii?Q?9+rVIKbJPfo1F+g5TrJftul7GCOSd1gAcZdanZ3uNC9YnfVVcUpYBvK1lojl?=
 =?us-ascii?Q?s0GayesPhQlYrlHPB83AcxBlc6OpZQVwmTdQRcRoNPOdz9mGRUlagPXq1UAz?=
 =?us-ascii?Q?XWDJ6we7WDUMdc1FXxBN1kwgRCW1cXivKG0udfz1pktncoe7quxqjTiQxpfh?=
 =?us-ascii?Q?MQ/ME+OWcSojsjXtbxeY0qmzh0qm3qNLm/rzb6vedK6HxpvLX8nZqV6zFpsf?=
 =?us-ascii?Q?4SJbQjB1lRfD1fwGWjFV/nnfTJ9cYYt+JdW5QSZV2f9NERfGPr7xGxib0YtY?=
 =?us-ascii?Q?V5amjXhqVkYovy2CFXpFEnxRGnuJgHdmKlLpG2Dkclwc+l3PQScvKFwteNBY?=
 =?us-ascii?Q?B+F+327sLYDcyylvlDaZMePFQQruf76R1Upd7rkG7eUl3VcqKi+8ExS3G+eY?=
 =?us-ascii?Q?gVzQduLeyF3qodTimdJhGGXOmvaFj8ZRrHBf4vuAdzbr6CfTI6nn5Ev7KvwY?=
 =?us-ascii?Q?PD+yuzoJPTiEKS9sHLBcMDmf98jVm3euWTGrd6mwC2wDPCRWGxZKFchFYSs5?=
 =?us-ascii?Q?sX8It8wA5W+xpNRn23B6/gh8TRLkXGEhvbnPk27r+6xFQeHNRacIXIVxvkrD?=
 =?us-ascii?Q?SJUdWtz6yrx8PWLjhdtDgxJygoV1SwNlekarDgQdIKB3h5Ed9O7pYPK2Z8Ci?=
 =?us-ascii?Q?ev7LyQPWTvfvstxWLHkt/rSnWcObM6VJIh+V0huqXs4/dXqsciP8jRu9Pupx?=
 =?us-ascii?Q?fGM4WKKewZjYz6WygGuCCzTTy2si4ujiAfh+pSO2a0ymdLlNhoPoIEZR3Q4c?=
 =?us-ascii?Q?OOyT2vMzIIvZrwP/MYGvwWe6tVffL0CR1GH5KIZhFRxFQIy7rro/QPOeQf6L?=
 =?us-ascii?Q?8ACa+anKVQ+OCnQYVi8+iYHi6HrgaqVT8mfLGxY9z0jSUWZBXVWCbE0Twdq4?=
 =?us-ascii?Q?TKZdBFTU5ETWWBDPBbe1/mE2bXb0ovp6mdCDKPOwT8/5n3Ps6jFMD2VBE3GL?=
 =?us-ascii?Q?n63TJ0hhSNZ8qDQWBNEKj/KA4v9DXHLayivuuW/cLaTP3TOEip1VOtXaYlEF?=
 =?us-ascii?Q?Mq3aPmQig3LtfY98CVdA+pLknZC8jUKmeZnZF2xMioDu1VEGQpimuPAT1yKI?=
 =?us-ascii?Q?pUBielf/JWozQ+AwAAu8mLDJhfS0je3vZS29nGZq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97f6be59-d8e3-4c04-b90e-08dcf8c8eed2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 09:55:06.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iOJim/FYDjGT4hKw85SJnK6cKwTr1UNIF/oNC7jHnFtDqswGZVPywSx7wLctqP1eOxMj1D5pd2xsbKswmoh44w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10347

The netc-blk-ctrl driver is used to configure Integrated Endpoint
Register Block (IERB) and Privileged Register Block (PRB) of NETC.
For i.MX platforms, it is also used to configure the NETCMIX block.

The IERB contains registers that are used for pre-boot initialization,
debug, and non-customer configuration. The PRB controls global reset
and global error handling for NETC. The NETCMIX block is mainly used
to set MII protocol and PCS protocol of the links, it also contains
settings for some other functions.

Note the IERB configuration registers can only be written after being
unlocked by PRB, otherwise, all write operations are inhibited. A warm
reset is performed when the IERB is unlocked, and it results in an FLR
to all NETC devices. Therefore, all NETC device drivers must be probed
or initialized after the warm reset is finished.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
v6: only add some opening comments at the beginning of netc_blk_ctrl.c
---
 drivers/net/ethernet/freescale/enetc/Kconfig  |  14 +
 drivers/net/ethernet/freescale/enetc/Makefile |   3 +
 .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 445 ++++++++++++++++++
 include/linux/fsl/netc_global.h               |  19 +
 4 files changed, 481 insertions(+)
 create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
 create mode 100644 include/linux/fsl/netc_global.h

diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
index 4d75e6807e92..51d80ea959d4 100644
--- a/drivers/net/ethernet/freescale/enetc/Kconfig
+++ b/drivers/net/ethernet/freescale/enetc/Kconfig
@@ -75,3 +75,17 @@ config FSL_ENETC_QOS
 	  enable/disable from user space via Qos commands(tc). In the kernel
 	  side, it can be loaded by Qos driver. Currently, it is only support
 	  taprio(802.1Qbv) and Credit Based Shaper(802.1Qbu).
+
+config NXP_NETC_BLK_CTRL
+	tristate "NETC blocks control driver"
+	help
+	  This driver configures Integrated Endpoint Register Block (IERB) and
+	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
+	  includes the configuration of NETCMIX block.
+	  The IERB contains registers that are used for pre-boot initialization,
+	  debug, and non-customer configuration. The PRB controls global reset
+	  and global error handling for NETC. The NETCMIX block is mainly used
+	  to set MII protocol and PCS protocol of the links, it also contains
+	  settings for some other functions.
+
+	  If compiled as module (M), the module name is nxp-netc-blk-ctrl.
diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
index b13cbbabb2ea..737c32f83ea5 100644
--- a/drivers/net/ethernet/freescale/enetc/Makefile
+++ b/drivers/net/ethernet/freescale/enetc/Makefile
@@ -19,3 +19,6 @@ fsl-enetc-mdio-y := enetc_pci_mdio.o enetc_mdio.o
 
 obj-$(CONFIG_FSL_ENETC_PTP_CLOCK) += fsl-enetc-ptp.o
 fsl-enetc-ptp-y := enetc_ptp.o
+
+obj-$(CONFIG_NXP_NETC_BLK_CTRL) += nxp-netc-blk-ctrl.o
+nxp-netc-blk-ctrl-y := netc_blk_ctrl.o
diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
new file mode 100644
index 000000000000..bcb8eefeb93c
--- /dev/null
+++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
@@ -0,0 +1,445 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
+/*
+ * NXP NETC Blocks Control Driver
+ *
+ * Copyright 2024 NXP
+ *
+ * This driver is used for pre-initialization of NETC, such as PCS and MII
+ * protocols, LDID, warm reset, etc. Therefore, all NETC device drivers can
+ * only be probed after the netc-blk-crtl driver has completed initialization.
+ * In addition, when the system enters suspend mode, IERB, PRB, and NETCMIX
+ * will be powered off, except for WOL. Therefore, when the system resumes,
+ * these blocks need to be reinitialized.
+ */
+
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/fsl/netc_global.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_net.h>
+#include <linux/of_platform.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+
+/* NETCMIX registers */
+#define IMX95_CFG_LINK_IO_VAR		0x0
+#define  IO_VAR_16FF_16G_SERDES		0x1
+#define  IO_VAR(port, var)		(((var) & 0xf) << ((port) << 2))
+
+#define IMX95_CFG_LINK_MII_PROT		0x4
+#define CFG_LINK_MII_PORT_0		GENMASK(3, 0)
+#define CFG_LINK_MII_PORT_1		GENMASK(7, 4)
+#define  MII_PROT_MII			0x0
+#define  MII_PROT_RMII			0x1
+#define  MII_PROT_RGMII			0x2
+#define  MII_PROT_SERIAL		0x3
+#define  MII_PROT(port, prot)		(((prot) & 0xf) << ((port) << 2))
+
+#define IMX95_CFG_LINK_PCS_PROT(a)	(0x8 + (a) * 4)
+#define PCS_PROT_1G_SGMII		BIT(0)
+#define PCS_PROT_2500M_SGMII		BIT(1)
+#define PCS_PROT_XFI			BIT(3)
+#define PCS_PROT_SFI			BIT(4)
+#define PCS_PROT_10G_SXGMII		BIT(6)
+
+/* NETC privileged register block register */
+#define PRB_NETCRR			0x100
+#define  NETCRR_SR			BIT(0)
+#define  NETCRR_LOCK			BIT(1)
+
+#define PRB_NETCSR			0x104
+#define  NETCSR_ERROR			BIT(0)
+#define  NETCSR_STATE			BIT(1)
+
+/* NETC integrated endpoint register block register */
+#define IERB_EMDIOFAUXR			0x344
+#define IERB_T0FAUXR			0x444
+#define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
+#define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
+#define FAUXR_LDID			GENMASK(3, 0)
+
+/* Platform information */
+#define IMX95_ENETC0_BUS_DEVFN		0x0
+#define IMX95_ENETC1_BUS_DEVFN		0x40
+#define IMX95_ENETC2_BUS_DEVFN		0x80
+
+/* Flags for different platforms */
+#define NETC_HAS_NETCMIX		BIT(0)
+
+struct netc_devinfo {
+	u32 flags;
+	int (*netcmix_init)(struct platform_device *pdev);
+	int (*ierb_init)(struct platform_device *pdev);
+};
+
+struct netc_blk_ctrl {
+	void __iomem *prb;
+	void __iomem *ierb;
+	void __iomem *netcmix;
+
+	const struct netc_devinfo *devinfo;
+	struct platform_device *pdev;
+	struct dentry *debugfs_root;
+};
+
+static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
+{
+	netc_write(base + offset, val);
+}
+
+static u32 netc_reg_read(void __iomem *base, u32 offset)
+{
+	return netc_read(base + offset);
+}
+
+static int netc_of_pci_get_bus_devfn(struct device_node *np)
+{
+	u32 reg[5];
+	int error;
+
+	error = of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
+	if (error)
+		return error;
+
+	return (reg[0] >> 8) & 0xffff;
+}
+
+static int netc_get_link_mii_protocol(phy_interface_t interface)
+{
+	switch (interface) {
+	case PHY_INTERFACE_MODE_MII:
+		return MII_PROT_MII;
+	case PHY_INTERFACE_MODE_RMII:
+		return MII_PROT_RMII;
+	case PHY_INTERFACE_MODE_RGMII:
+	case PHY_INTERFACE_MODE_RGMII_ID:
+	case PHY_INTERFACE_MODE_RGMII_RXID:
+	case PHY_INTERFACE_MODE_RGMII_TXID:
+		return MII_PROT_RGMII;
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_2500BASEX:
+	case PHY_INTERFACE_MODE_10GBASER:
+	case PHY_INTERFACE_MODE_XGMII:
+	case PHY_INTERFACE_MODE_USXGMII:
+		return MII_PROT_SERIAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int imx95_netcmix_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	struct device_node *np = pdev->dev.of_node;
+	phy_interface_t interface;
+	int bus_devfn, mii_proto;
+	u32 val;
+	int err;
+
+	/* Default setting of MII protocol */
+	val = MII_PROT(0, MII_PROT_RGMII) | MII_PROT(1, MII_PROT_RGMII) |
+	      MII_PROT(2, MII_PROT_SERIAL);
+
+	/* Update the link MII protocol through parsing phy-mode */
+	for_each_available_child_of_node_scoped(np, child) {
+		for_each_available_child_of_node_scoped(child, gchild) {
+			if (!of_device_is_compatible(gchild, "pci1131,e101"))
+				continue;
+
+			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
+			if (bus_devfn < 0)
+				return -EINVAL;
+
+			if (bus_devfn == IMX95_ENETC2_BUS_DEVFN)
+				continue;
+
+			err = of_get_phy_mode(gchild, &interface);
+			if (err)
+				continue;
+
+			mii_proto = netc_get_link_mii_protocol(interface);
+			if (mii_proto < 0)
+				return -EINVAL;
+
+			switch (bus_devfn) {
+			case IMX95_ENETC0_BUS_DEVFN:
+				val = u32_replace_bits(val, mii_proto,
+						       CFG_LINK_MII_PORT_0);
+				break;
+			case IMX95_ENETC1_BUS_DEVFN:
+				val = u32_replace_bits(val, mii_proto,
+						       CFG_LINK_MII_PORT_1);
+				break;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+
+	/* Configure Link I/O variant */
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_IO_VAR,
+		       IO_VAR(2, IO_VAR_16FF_16G_SERDES));
+	/* Configure Link 2 PCS protocol */
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_PCS_PROT(2),
+		       PCS_PROT_10G_SXGMII);
+	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_MII_PROT, val);
+
+	return 0;
+}
+
+static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
+{
+	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
+}
+
+static int netc_lock_ierb(struct netc_blk_ctrl *priv)
+{
+	u32 val;
+
+	netc_reg_write(priv->prb, PRB_NETCRR, NETCRR_LOCK);
+
+	return read_poll_timeout(netc_reg_read, val, !(val & NETCSR_STATE),
+				 100, 2000, false, priv->prb, PRB_NETCSR);
+}
+
+static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
+{
+	u32 val;
+
+	netc_reg_write(priv->prb, PRB_NETCRR, 0);
+
+	return read_poll_timeout(netc_reg_read, val, !(val & NETCRR_LOCK),
+				 1000, 100000, true, priv->prb, PRB_NETCRR);
+}
+
+static int imx95_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+
+	/* EMDIO : No MSI-X intterupt */
+	netc_reg_write(priv->ierb, IERB_EMDIOFAUXR, 0);
+	/* ENETC0 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(0), 0);
+	/* ENETC0 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(0), 1);
+	/* ENETC0 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(1), 2);
+	/* ENETC1 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(1), 3);
+	/* ENETC1 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(2), 5);
+	/* ENETC1 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(3), 6);
+	/* ENETC2 PF */
+	netc_reg_write(priv->ierb, IERB_EFAUXR(2), 4);
+	/* ENETC2 VF0 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(4), 5);
+	/* ENETC2 VF1 */
+	netc_reg_write(priv->ierb, IERB_VFAUXR(5), 6);
+	/* NETC TIMER */
+	netc_reg_write(priv->ierb, IERB_T0FAUXR, 7);
+
+	return 0;
+}
+
+static int netc_ierb_init(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+	const struct netc_devinfo *devinfo = priv->devinfo;
+	int err;
+
+	if (netc_ierb_is_locked(priv)) {
+		err = netc_unlock_ierb_with_warm_reset(priv);
+		if (err) {
+			dev_err(&pdev->dev, "Unlock IERB failed.\n");
+			return err;
+		}
+	}
+
+	if (devinfo->ierb_init) {
+		err = devinfo->ierb_init(pdev);
+		if (err)
+			return err;
+	}
+
+	err = netc_lock_ierb(priv);
+	if (err) {
+		dev_err(&pdev->dev, "Lock IERB failed.\n");
+		return err;
+	}
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_DEBUG_FS)
+static int netc_prb_show(struct seq_file *s, void *data)
+{
+	struct netc_blk_ctrl *priv = s->private;
+	u32 val;
+
+	val = netc_reg_read(priv->prb, PRB_NETCRR);
+	seq_printf(s, "[PRB NETCRR] Lock:%d SR:%d\n",
+		   (val & NETCRR_LOCK) ? 1 : 0,
+		   (val & NETCRR_SR) ? 1 : 0);
+
+	val = netc_reg_read(priv->prb, PRB_NETCSR);
+	seq_printf(s, "[PRB NETCSR] State:%d Error:%d\n",
+		   (val & NETCSR_STATE) ? 1 : 0,
+		   (val & NETCSR_ERROR) ? 1 : 0);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(netc_prb);
+
+static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir("netc_blk_ctrl", NULL);
+	if (IS_ERR(root))
+		return;
+
+	priv->debugfs_root = root;
+
+	debugfs_create_file("prb", 0444, root, priv, &netc_prb_fops);
+}
+
+static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
+{
+	debugfs_remove_recursive(priv->debugfs_root);
+	priv->debugfs_root = NULL;
+}
+
+#else
+
+static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
+{
+}
+
+static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
+{
+}
+#endif
+
+static int netc_prb_check_error(struct netc_blk_ctrl *priv)
+{
+	if (netc_reg_read(priv->prb, PRB_NETCSR) & NETCSR_ERROR)
+		return -1;
+
+	return 0;
+}
+
+static const struct netc_devinfo imx95_devinfo = {
+	.flags = NETC_HAS_NETCMIX,
+	.netcmix_init = imx95_netcmix_init,
+	.ierb_init = imx95_ierb_init,
+};
+
+static const struct of_device_id netc_blk_ctrl_match[] = {
+	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
+	{},
+};
+MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
+
+static int netc_blk_ctrl_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	const struct netc_devinfo *devinfo;
+	struct device *dev = &pdev->dev;
+	const struct of_device_id *id;
+	struct netc_blk_ctrl *priv;
+	struct clk *ipg_clk;
+	void __iomem *regs;
+	int err;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdev = pdev;
+	ipg_clk = devm_clk_get_optional_enabled(dev, "ipg");
+	if (IS_ERR(ipg_clk))
+		return dev_err_probe(dev, PTR_ERR(ipg_clk),
+				     "Set ipg clock failed\n");
+
+	id = of_match_device(netc_blk_ctrl_match, dev);
+	if (!id)
+		return dev_err_probe(dev, -EINVAL, "Cannot match device\n");
+
+	devinfo = (struct netc_devinfo *)id->data;
+	if (!devinfo)
+		return dev_err_probe(dev, -EINVAL, "No device information\n");
+
+	priv->devinfo = devinfo;
+	regs = devm_platform_ioremap_resource_byname(pdev, "ierb");
+	if (IS_ERR(regs))
+		return dev_err_probe(dev, PTR_ERR(regs),
+				     "Missing IERB resource\n");
+
+	priv->ierb = regs;
+	regs = devm_platform_ioremap_resource_byname(pdev, "prb");
+	if (IS_ERR(regs))
+		return dev_err_probe(dev, PTR_ERR(regs),
+				     "Missing PRB resource\n");
+
+	priv->prb = regs;
+	if (devinfo->flags & NETC_HAS_NETCMIX) {
+		regs = devm_platform_ioremap_resource_byname(pdev, "netcmix");
+		if (IS_ERR(regs))
+			return dev_err_probe(dev, PTR_ERR(regs),
+					     "Missing NETCMIX resource\n");
+		priv->netcmix = regs;
+	}
+
+	platform_set_drvdata(pdev, priv);
+	if (devinfo->netcmix_init) {
+		err = devinfo->netcmix_init(pdev);
+		if (err)
+			return dev_err_probe(dev, err,
+					     "Initializing NETCMIX failed\n");
+	}
+
+	err = netc_ierb_init(pdev);
+	if (err)
+		return dev_err_probe(dev, err, "Initializing IERB failed\n");
+
+	if (netc_prb_check_error(priv) < 0)
+		dev_warn(dev, "The current IERB configuration is invalid\n");
+
+	netc_blk_ctrl_create_debugfs(priv);
+
+	err = of_platform_populate(node, NULL, NULL, dev);
+	if (err) {
+		netc_blk_ctrl_remove_debugfs(priv);
+		return dev_err_probe(dev, err, "of_platform_populate failed\n");
+	}
+
+	return 0;
+}
+
+static void netc_blk_ctrl_remove(struct platform_device *pdev)
+{
+	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
+
+	of_platform_depopulate(&pdev->dev);
+	netc_blk_ctrl_remove_debugfs(priv);
+}
+
+static struct platform_driver netc_blk_ctrl_driver = {
+	.driver = {
+		.name = "nxp-netc-blk-ctrl",
+		.of_match_table = netc_blk_ctrl_match,
+	},
+	.probe = netc_blk_ctrl_probe,
+	.remove = netc_blk_ctrl_remove,
+};
+
+module_platform_driver(netc_blk_ctrl_driver);
+
+MODULE_DESCRIPTION("NXP NETC Blocks Control Driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
new file mode 100644
index 000000000000..fdecca8c90f0
--- /dev/null
+++ b/include/linux/fsl/netc_global.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
+/* Copyright 2024 NXP
+ */
+#ifndef __NETC_GLOBAL_H
+#define __NETC_GLOBAL_H
+
+#include <linux/io.h>
+
+static inline u32 netc_read(void __iomem *reg)
+{
+	return ioread32(reg);
+}
+
+static inline void netc_write(void __iomem *reg, u32 val)
+{
+	iowrite32(val, reg);
+}
+
+#endif
-- 
2.34.1


