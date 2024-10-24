Return-Path: <linux-pci+bounces-15212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 851649AEBFC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 18:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054B81F239DD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 16:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50C31F80BB;
	Thu, 24 Oct 2024 16:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FHgNjBl1"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE131D5AB2;
	Thu, 24 Oct 2024 16:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787245; cv=fail; b=VERklbpY3urmMe8g2ZkzJjA68Gz/Yx3/nH9E02uPmNBJQVTz8AJm2GwW8qrNRgbE9wvsFpmeyvRekbbRDtrpNsLoAFr4xICETNe7OMfdiwMEDgBtjK+8D7E8ij0U394FZyT1wKX5qKf7zFyGIQruVcrTi/dcNDH1S/ryLXJWwWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787245; c=relaxed/simple;
	bh=4bQBje8QSk/TA3q8tTwmhzeV+rH2AtnwmeW06/lZH98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NBDKvyGT0jh2w26KPoqMq/uiin8dEBYEhpqoaLNFNcY8SFqyHrCx8dOfKtf2q1kgjIxzz9q846had0KkbFs4iwkLKk7YecFZjTkKaRtHtuvsUpWn+jecraoQqkTsis/0EzsYVzfYdL5xlqREzCGty1j59EMytQkjC8CMVlOgq+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FHgNjBl1; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/0Nrhzr8iw9HiMCjKsQhGP43l2Wpr7sW31Mwr6QKrsO4CaEPUPNo/0xmKxshSQCXLXQWaGK2obJcJicvzeQsIVKrBq0owEJ+VGT2vN9Im6OKwrd26z8S85NnJ+7LSeTu4lvnR7oKT5f0aF/6hwLcNWQx0N8s6OhF4QdOaUBL8Fzo0FYE8qGdeMeobMwsEX8uMq9JTSSeGQ1k+gEi3NZAnUR0zXSaNkD8N+IzhqXHGe56lmtj5zm9Khfe0CbTcvwXWGRU+/woOZB6D4WmL8Db4VsNY1FTlMAazOwru8WzlsMaOQOoB8zBnYP5uzPV8M4bST4ya15lkTMUuZ0g3foZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7g5hWDXNm1+fM/TIorOhJWVpJrdJ2QGWTptIGg+XtEM=;
 b=AvKTO/VhaCXjFTIYKiA2i/SG+Gxuaxgep3QDOM2Ynv3CHYALkKXmQw7ES41LRCScgpk9EzwUDKQWotsVOQhV//QHYL4NnsCdrvOTn9qESI/sug4A+lTzlQN3OK+WqUYiBn+Yy69KlyzLPWcgmWrUE8e6MnPJgzwUQss12XO37gf9tsYciY0pYhR2YwGL/58exoxHGyzXAk4pglpQq3ty05HClu7/JekDpq/mjdwGPrgTa1aqkLSGpn98D+fb5IDVxO83DQypziqRP1p21uDY++OZDu8oQrZwIrWLHcoYI80o0nNClr8z+CNM07Rl+Tcl2aRwhs3JWuSVGvKpp6ijZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7g5hWDXNm1+fM/TIorOhJWVpJrdJ2QGWTptIGg+XtEM=;
 b=FHgNjBl1R5vECyE9NFY9vURCI+KhxWRsfzwaahcqaZXiRlR7Yfa6ve7pjkcxoiHga118kgieNRvkR3vziVGYho9XevUUY1NRuUdYgvY8Kjwq0eFB6Nbh1rxFF4MsWtOs+59IMXNwHth5IvUM5RVa3oq4CwQ/iOEiQ5d9pijkPbt5P1bSsSvo2T/KoLPGdce+n89HeYMvGa+uT8tGQcudvKM+WIp8ShCpVsQz49AVK5ma/g7lD4cU2fxpF1YpGWPxss14a/0Xp/+MXbfH/MQ7/WKPv8oaZqdv2X3wdJZS/zLF2I67V5mHAf+fKTNz0NinNo4s0bfQ95p8x96IstZE6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM9PR04MB8683.eurprd04.prod.outlook.com (2603:10a6:20b:43e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Thu, 24 Oct
 2024 16:27:19 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%6]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 16:27:19 +0000
Date: Thu, 24 Oct 2024 19:27:10 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	Frank.Li@nxp.com, christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk, bhelgaas@google.com, horms@kernel.org,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alexander.stein@ew.tq-group.com
Subject: Re: [PATCH v5 net-next 04/13] net: enetc: add initial netc-blk-ctrl
 driver support
Message-ID: <20241024162710.ia64w7zchbzn3tji@skbuf>
References: <20241024065328.521518-1-wei.fang@nxp.com>
 <20241024065328.521518-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024065328.521518-5-wei.fang@nxp.com>
X-ClientProxiedBy: VI1PR06CA0164.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::21) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM9PR04MB8683:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1769e2-015a-4cbf-a051-08dcf448baf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U+tpcTaC497cASPKjwK1apdf/7/aCVRVK9VwfKp5MkKli5jE7YPIalvahdrC?=
 =?us-ascii?Q?p1Qr3syX8x2e2O8TYJAmUtTvrBPl+29DKSAuERjpClBo7GQ9vhw3GLPJd74s?=
 =?us-ascii?Q?9PkdI73Tq/a88BPmykkFX5ke9qF18UEyN2tjNdr7dWWNkM8SD0YuaRlaoDt7?=
 =?us-ascii?Q?Z145uOJngt95EHdx6Mh0lKpyqeOkpS/MDCyoHPTwcAdqOg2TWvwxjgVm/dYp?=
 =?us-ascii?Q?YgsyeZBMBmhQ0PfpbR9fDBMUMTwISppFFQQAKI4N/sICGoyJQpcKOjFLa3Oz?=
 =?us-ascii?Q?+PMMvIA6nZa1ejOr5Hl3p1CTNMAj8SXhNOIhtDmlrqBtUR5X8ybGAbTPYjFW?=
 =?us-ascii?Q?Aj/e43ujSaCz1hZa8YRfzV32eJmMNhBWlUKz3RHghTyAR6c2hxpfzgQZ7t0R?=
 =?us-ascii?Q?AR6FF8ey2Ss2GehnoR3wYfAspF7mZgVyAus4aHtmO9EQjK7oXXefd0QTDqKC?=
 =?us-ascii?Q?RLH285x4i1uwAqBSvN6+FjSZDbDYCHTH0VMCpf9m4qzQGa/yOLqUz+EpwZV1?=
 =?us-ascii?Q?rTDlRyHkGEZFwx0Fy3vacicwr2bICaCfWyxjm4XwVk1PWdgMwOLCw5s10iPW?=
 =?us-ascii?Q?UhU1Sn4eqVgwonai5ide4/xdqPB/yLv2MGl0SqNmYAX0SKLI337AZK5gJG85?=
 =?us-ascii?Q?1wUZSuz9mOO1tH1+Aso1HvQoCsUq3phzgpBuTKM+em+nPj5u+pkgVooNUrW8?=
 =?us-ascii?Q?Drsr2Fa25KXuCjycX0JTSNPwoJhZS7S5qb3+lBTMQz0Bu2Gg/myxxQMXsauq?=
 =?us-ascii?Q?IleUujuXOBthfRi7TM4uaNi79/Ada0PpWH5qhbqZ4lhIZxEYRQ8HQXNXz3yl?=
 =?us-ascii?Q?gocYTs1E9fOxEBV2LqCahs4rrvrToBAoDNIVma5y/jvn557Oi7d28LWYm1+V?=
 =?us-ascii?Q?JvxS0nI52GHvtYr8Ygfit54PyQdfZlX1IVssMrjeK+c3Y3U8ApTA1WqOGEuo?=
 =?us-ascii?Q?aGQMdlwCQMzcLTXP4qZt3rlsIBC3+Rq01a8dyaVqzvMpAVIYTvEBly6olYPm?=
 =?us-ascii?Q?rSuz5ImtMgzjPBeCIEEZrmsCmk8/9LZCcpXpCYtgTeqpJNitjTgiI9RmVZEz?=
 =?us-ascii?Q?3a1qDki74TdiChPK9eU/B2H7c8x3L0+XFkmPsnXFn58O+N227tyL1h14xgNE?=
 =?us-ascii?Q?t1qDHG79/leacrShcdewCHVBfgM8CSZUlOTYTtf+AlvXFnbkHBNW36V+HLHw?=
 =?us-ascii?Q?opLZuTbJiMRhhSM+dbQa72zR9IIBkOCm3Wm+COigESoon1A1ehrpXraoJDWW?=
 =?us-ascii?Q?uyn/N8K0VSqSpNDme24iw95GbMKgCWwN3JzblQT1xmjDsVI5Odz2OaH8iNYM?=
 =?us-ascii?Q?liLlxXyn65dxV3sPmftGzcmF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oWiaEGtsvXo0A+J7ru5It6wUm4P5NsJQRuYU2qncOeaiSMKhpFSV1Ml1bnuu?=
 =?us-ascii?Q?hlLzABkcXCWBr8QDdLAXfob7QF/cXv7KhGQ4jmpRmvmorEOAsMKCoe585if2?=
 =?us-ascii?Q?G/Ayv7HY9hufite/sa3n/Bmzuj32fK+Iapx4CqqECzEq1t62ZYxhpesJYY/P?=
 =?us-ascii?Q?bYoFqFq4XXZQe68za/eSs43Y5GThwzpLcQxfUM7pXH2ELXGnZ/j7g2GH+e7P?=
 =?us-ascii?Q?JEvlZmvcySrMTz/tpPMV/SsKCCiB0BqYSabbZQeh+COwAIUqNnUt4OoqK20g?=
 =?us-ascii?Q?Wwm/MIkuMR59YNAAqwQXZVLNC0tu+20EENAR3sGAOm0mlqITtozZAjtXGxGe?=
 =?us-ascii?Q?V1Df4Knh3No3ZCLQa/qeMeRapYHi/EPGSlGtq7L7zdEctWsWipw1sp93ETqG?=
 =?us-ascii?Q?hcVZRpobX9+qwOr7FOgZfh3bH1zeEMveFMic9sQVtDLEYgPOG3LQgB7+X3pC?=
 =?us-ascii?Q?Jn80wl+qnd1AdqBy6X2hzFKsn3rpax6biqir0QqRUoMkvMnzNRewvkcATmoI?=
 =?us-ascii?Q?3RfCkQSPRFYLiGiNgtJO0BFLxXysgwsiARhtqUVxFDABy7T6ioBNl7Nq6qA5?=
 =?us-ascii?Q?fBV6fbGlpLbZMKo6+ELFiS8oLuGUIpsTcesSXmP5VNAHAvVMhrdu9f7WSGm9?=
 =?us-ascii?Q?dmJe79I5o/nY5BVOUg1EtF/EQtrx1vWEM+wMro7uMpcpJrg5pJ4PUVHrRlD1?=
 =?us-ascii?Q?nQaXAv1DHPmHrr6cCdpBgKdwbvJoWbB7ic0MdPSVE+fATHG9D7rrIN+snnpP?=
 =?us-ascii?Q?ROc3DcKId+9DZMA11Q75hOrlWuaRCyKjD8b2fyTbhVm3VYgCEkS5yneMhxpP?=
 =?us-ascii?Q?j3U9HQJyS06plE2CRd73SA1r6cBKPgkDBaVmlzHzeve4x0DCzD7sc4JM26S8?=
 =?us-ascii?Q?JdIhgDI/LEHUo7E4maXXbpx+N5/+U1eg4wVDIQd3Dr106DnLfezBK4Ul3V+u?=
 =?us-ascii?Q?rwzL3q3txPM2xT69V0T8GvF6joshrrE9cyKdy4T1NyXUsPVwugUZtALCp5Yu?=
 =?us-ascii?Q?76Zkl4eINIGSbALp7w8EwrlaYY5ZEp9L1TjskRMrIbRfBCZhx9oicp34XGAU?=
 =?us-ascii?Q?oA9RQQzLOIJkFR91TgQuzFPZGj0Nn6CfIb5BXD3busOfjzDHcSrF3Ip8+9Kn?=
 =?us-ascii?Q?9HJGz2SRwrZCrqPmh7YTPSuSXOVdEt1ie0Wtoin5dmbVR62x8Fu8eHaakdMA?=
 =?us-ascii?Q?WSxWI7u1UUXSad/lT/+K+PU8kgq9Q/9cO9yTNWBLRcxlp21CwSdjjeu3kiyN?=
 =?us-ascii?Q?3aKsB3O+dwsX4XmKEzGqWrxjC6FmpPkLUGgusfmKkZsSSeIY6L/MQ8WY5Fxs?=
 =?us-ascii?Q?MR4VovOdsFdoLsBj0rXXuabVls2O99Vw5wkY2xEitLgo987i6KvW9ek5+h2/?=
 =?us-ascii?Q?zQvDqo7+rx9bs++h5dLug/mGjpAdLPveCKWlm/xRdz0ogPbzybljzmWmijj2?=
 =?us-ascii?Q?z3CUgTH1Z599+ODCKcIuwkHreiHGMuhtYmRtRn361uMzqD0MTEJQqeE6tqKA?=
 =?us-ascii?Q?QTI7CrdD1eIqq2bcLYuut5Y449IMnKk3Vk9ihFUqS0UMHQhdsSXrb76vvKg1?=
 =?us-ascii?Q?WBssqiNNFxi76ND7z4KGaR4uFGsS8k8NEykZESxMcy0mCS/L4I8l3oOXcwl8?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1769e2-015a-4cbf-a051-08dcf448baf5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:27:19.5933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXh8HZtPh+lcKvgOnGR3TA901i4bPTIUQyjfVIagiqiwbapbjkRbQ6vj88y6pCXaCyh2Y034n9uluAlJwBJgUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8683

On Thu, Oct 24, 2024 at 02:53:19PM +0800, Wei Fang wrote:
> The netc-blk-ctrl driver is used to configure Integrated Endpoint
> Register Block (IERB) and Privileged Register Block (PRB) of NETC.
> For i.MX platforms, it is also used to configure the NETCMIX block.
> 
> The IERB contains registers that are used for pre-boot initialization,
> debug, and non-customer configuration. The PRB controls global reset
> and global error handling for NETC. The NETCMIX block is mainly used
> to set MII protocol and PCS protocol of the links, it also contains
> settings for some other functions.
> 
> Note the IERB configuration registers can only be written after being
> unlocked by PRB, otherwise, all write operations are inhibited. A warm
> reset is performed when the IERB is unlocked, and it results in an FLR
> to all NETC devices. Therefore, all NETC device drivers must be probed
> or initialized after the warm reset is finished.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---

Can U-Boot deal with the IERB/PRB configuration?

For LS1028A, the platform which initiated the IERB driver "trend", the
situation was a bit more complicated, as we realized the reset-time
defaults aren't what we need very late in the product life cycle, when
customer boards already had bootloaders and we didn't want to complicate
their process to have to redeploy in order to get access to such a basic
feature as flow control. Though if we knew it from day one, we would
have put the IERB fixups in U-Boot.

What is written in the IERB for MII/PCS protocols by default? I suppose
there's some other mechanism to preinitialize it with good values?

