Return-Path: <linux-pci+bounces-14812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A11F9A28F7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 18:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F0521C21AD7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CA91DF27F;
	Thu, 17 Oct 2024 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PCrf1pTy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2084.outbound.protection.outlook.com [40.107.22.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199A21DF273;
	Thu, 17 Oct 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729182842; cv=fail; b=qA8i9UyWtIjWH+02ogZWBMlXJXdc3QzAFmW3einX7NapURTWQJ8nALEnhR8g/I+dXHiEwArUlnh5vxvfqtY2Wht4u6YvkBIjYZKcUN5hJg7lK0zJ/YWkbxXUOJTFw/AgOuxOSTcpqPmoGywwXOnloQUOh+tw4HXtnnKWMwv6y4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729182842; c=relaxed/simple;
	bh=4amJesRkRvL6b022u+lel2HlmmgjVnlzKPsgSjhUEcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TrVjXXL/P716xIFzuN5I4AMTqd8EUOV4beAOJ+Ojaftj9k32zr3VFbkspJ3OsB4ULPttc/vVaVQvKOzGAFVn03MPwADPtMfqJOBCpUI5UzgFzO1v/VZWbvGNvrzqaUyQJJ//5Xahiyp7o8yg62Q30NbmnVWaoYciG00LXMbncsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PCrf1pTy; arc=fail smtp.client-ip=40.107.22.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uq/PvsXWxlugZzfQbUQJurTK5Z8JzUCTNhFU3pdoJsIlUJMLX17zfFT/tBxbjAX1hxac7IhSsehJxYlf+rKEV24yHT84aaYMjmOxCpkfqf3si/+WEmDjRadwvZuEYQ7e8kULA4vfRwiePIgsFwoJEA+1nvRKmEsJDNo0Nr4BpmjY1VYYEiV7ou9SaPrqJz9H2ai/9LFblapneDNRqax0DTnh9jqPjBkoNVUZ/bjdREj+kz9hmLjb6dkyzAk1nGDiR6r3sc87OZ0GhKHEnphuFBjNP0yckSGW+IP28NruLfm7D5of0eiahJ8XkiX+xMLZgQY5hUVEPt0+/dJbqLFxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLiO26aA8KUPJ7vqyHUdU8OSyBPe99bEl2F2se1g+Jw=;
 b=ur4aFDcWwwQqEACUEXG7JwGrqZKJRdkc2cttO0iE632dg3j/BhfMMJdFvxd2ETJHUCfIswnrDPdd7QGA7gdEaCcnj1KkReWbqYskb3Rpnc5K+uVDJCFv3eP8KEwr8Ti3/br1/s8wdFrl7vRrJkW1HZKTky7Vtv17LPSzoqU6hQoNr0MF6ZySBrD4sR1nPHqEQcK8xWwFtAeXnYogt65DUqgIbQBp6iPBpi++PgZ02RcRxlNlr7Ih8uE69kSo1w3bVFjLvSQi3miQUotcTrn6iTEcYSYTAbQ7zLJNFI28f9FPcScoEF+utlOFm1moRSZjS4A03mveXlr+j1gUClfWiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLiO26aA8KUPJ7vqyHUdU8OSyBPe99bEl2F2se1g+Jw=;
 b=PCrf1pTyU70bK5iMGxunOqDr6H7+Bpc212+UC06KqsNm3c1Z6hBMY2wSBlF/nonHGdp5Mf+Ssqhm5DZysLgwOhZBghN4RNtE1m4/Tka02G+2XWI+bOa5Unc7g50RrNVM1fkweVivolFGHZ25kKPums0fleroTmM4TdRp6GF8XsvSaCwAiW1jSf3F22NFGr0f8xcQiqfLNgMSbu3iyGYDjMf378/OBbc/dYxvtjLoVTLMv2FTSjjdjDlZBv2P1L7y1BaN/eoYDe4Xdn16r9QB3OLeyiAgCh86Kw3tOcgrDrevbVDCvC2N00P3hJwcrcVsCyEuZPLBaj8kjVUCDE+sYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 16:33:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 16:33:52 +0000
Date: Thu, 17 Oct 2024 12:33:41 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com, xiaoning.wang@nxp.com,
	christophe.leroy@csgroup.eu, linux@armlinux.org.uk,
	bhelgaas@google.com, horms@kernel.org, imx@lists.linux.dev,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 net-next 04/13] net: enetc: add initial netc-blk-ctrl
 driver support
Message-ID: <ZxE8Ze5xAhAXEzog@lizhi-Precision-Tower-5810>
References: <20241017074637.1265584-1-wei.fang@nxp.com>
 <20241017074637.1265584-5-wei.fang@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017074637.1265584-5-wei.fang@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0162.namprd03.prod.outlook.com
 (2603:10b6:a03:338::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: da89d52e-8b93-4f40-5026-08dceec97c44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+IaCSYSVxXWkbdy/RbF2ngUTL3AVY8s4NageeMPGFp7YkzP4wzkYLfKZSFJD?=
 =?us-ascii?Q?gUHF66ypjj2ZWs/+0hajvoJLjBnWxJr5oWpcEYu+Y9TRuzfQaP4vPVJCSrZA?=
 =?us-ascii?Q?e8vsobhZwAObdrE7XdmvUiEUE+Ih9r0yOiQvjuyx6BpxO2tBc4PwDfWxeoFl?=
 =?us-ascii?Q?BaOH6BkoXmvBobCq9X31jaie8rWOwYLws7nzdzUVZqFXZpd8MOjpXUC7rR53?=
 =?us-ascii?Q?EjqJoy1SBzMpdUbse4mOhy54a12FCPQX+kSOWSZJVHMLoS+hgd5CoCM87eQ8?=
 =?us-ascii?Q?tZcjbL26RUJ8bxgnY4IaC/jpBGOyBQrHyIPi+17anDqwxPs+L5G/KDVVYUFr?=
 =?us-ascii?Q?yK+pf7k4NO1EPQel7zxxvVU5M2hOk09A/jfeQ0POUn/ELrm9qzWHvQrORXZ8?=
 =?us-ascii?Q?8UeO7r0BuEgooc0LyjHcgHkY7int/ByU8gjZZPjzPkGKJfZrevPxfzHLmrGe?=
 =?us-ascii?Q?HiuQco2h5iSqdhaoAhzHxomNZH7BZrfdRP5H5TnuWo6BlNIPPB5VnZDwm/fK?=
 =?us-ascii?Q?Gvq4r8ULPpkCT8wGOtKi7/ZGXYcC/EM/0Az+3B7FRrb8UwCxYUOWtq9UnwsK?=
 =?us-ascii?Q?GlVD1m2ea9pgl9JeS+l7u6aWozd9lmbtgY5JzmJlwabz79UCstK4/FPaBRWB?=
 =?us-ascii?Q?KV2gWQnc0oBwUx2KnvMLI5hLgZGCR3nzlFgfuQlqOz3mtWvaen32ZKVM3EfU?=
 =?us-ascii?Q?HtjKg6hkr8dKgleIAp4unRIeHXJLmQ/P5ra1xiMzmJW0/9erIcPPmAds4tFz?=
 =?us-ascii?Q?6CEGDgihtMKyfv9pZGeBPKsUY6ok3SqBUkxR8g2HeQkrFjvXrRf9pPIZ7iL9?=
 =?us-ascii?Q?SMC0DuW0rmfcf8iE7HRbvnRSEC2wbQ6gq1+QZ7padgG6AycxAPpoP6Ry1AP/?=
 =?us-ascii?Q?5WgF4egM3l/XNbFNFvwUct60OYNEhiwwH1pCRNaCIpXFYI4dmD+eJrJ4gMGI?=
 =?us-ascii?Q?lCfBrDXm8nXSzbMVtKz49VdJEGYIxMKa/fW2bIi/W3VaQLD4TcQ9jXpT8Z2e?=
 =?us-ascii?Q?kYzxjICd61VpqkJCkLypNro2HCNIHr8L27y28t1qmjv7OrO0Szqqt7XRf8Jc?=
 =?us-ascii?Q?Nfe85uS9RZ29kjjKk5aTtuShUGRcyRGHR3bZresGmgqISvb8Xn0neqgqSvpw?=
 =?us-ascii?Q?sHW/VNok2x87Q714dHzvrMRaSRV6Wu/+hGDg339D6YGYILRQ+zdFd/zouoQA?=
 =?us-ascii?Q?y+zjoxB7qqJQeIYy+vFYuiJIH8AnQiBVlwTIiG8p6tbRGfRw1CuNQVhAluVH?=
 =?us-ascii?Q?qCMKK7m3ZtbdbN0GUliRT5wgP/PFkE5B1SYS7Y7zGEg6JYW2kyRpSXBxgzW9?=
 =?us-ascii?Q?8XIZCFBh+JrUxGQbVvfuLfuwq9st/UnUpY6wztNeqNJVULg6gxCduyeC4SSd?=
 =?us-ascii?Q?uNVhjdo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9NQWpJqTN6j5W+tYCcJcO2idZ9RbN2UQI3/nLVNDzpWc0hDF3M5ATnBDKZtv?=
 =?us-ascii?Q?Kg4YDgoV6zhCjh4by0mxx1emEJFxNNQdCBApAvGMh29HNaBisWQ2j1ALd59t?=
 =?us-ascii?Q?YTUl6u0jbGqUr880AVWdvvK1IKdLqS5krxNxkVqjaYCyLQfXtdqcL5yTvtsu?=
 =?us-ascii?Q?LEUAOGZsMa1/iM5Wj4p+Hl3JtSCPrINXnq7OH03dExxNQH/n7SR32Y7R+G1O?=
 =?us-ascii?Q?cptyffkipEf5m8w3Mqz49wM3srh/6xfbczb0yBDcCQyuPqm8k9hysoHNMQCu?=
 =?us-ascii?Q?IaWS95Zq8qmG0wTkujrQqFYNkAc8vsPEh9+2sCyo/zA2EljtN9KGmoHgJjdw?=
 =?us-ascii?Q?t+fYe1CAvnDhZISiWi4J8w6uNiibaKoIKhzpvTu1DRhK4yskAcmJ166t48Dj?=
 =?us-ascii?Q?T5hP7eREKlq7QZ5QkTQZsydq9TXLeo3fIxGWFd6/Zf1Tm3w1Zxb2yFw39JkS?=
 =?us-ascii?Q?/nv0MEA9C4ldl+S56xg58uNAELXndPOEesnZKtvNr/ArwEqrwDbKyMP4EEoQ?=
 =?us-ascii?Q?tdptoNwM2or3OY6FBcmbgkO9gexBdxH3/9fqUYBaxM1bSSfF2O5iNblfvVIg?=
 =?us-ascii?Q?h/d0D+RmXO3Nsf4dvBtaPYCmIhN81p3ipQi3kmunNRqLfJrJWDD3Ahs2j3oj?=
 =?us-ascii?Q?wxJRbaVZKNvgtashOaDLiOj5YfCr+FbQQUjJJjYUiilRuhWD0l3zoU8LKG0B?=
 =?us-ascii?Q?xV9AmgEeiluNX3KJa81Nf7RTcWe1CTzCzU8lJhrTQ+cz64KwRo+xtt6qB2N2?=
 =?us-ascii?Q?3Mz/awehDcRbwyrk1l7xdtm6McDr/FHPYrzPxcbgXos7DPqKPnujaxnP0JBy?=
 =?us-ascii?Q?8s5PVmfJZb1/gYXLmHFg/26vlDuwpYsHRbIBws4keVuCTVJf3gQyjRrtMx0E?=
 =?us-ascii?Q?oDULNuerZWdkDhOMsigEFxEjqXJJS9tzEvhH9+KxUbmbPn0CYBgnOakhaswe?=
 =?us-ascii?Q?WUMYbg/GEiLi40T4MA3ICcEbWoXsZN24M7HD0fytqg2NjWBfQAPTYvHndQo2?=
 =?us-ascii?Q?aBJXZRgJArp/PdVrt6sA2beuJqnEQs4FD6n8DMdRezVGbj4ZH5p9ITWOy4yr?=
 =?us-ascii?Q?P1qNLTzJbXIDp2Wnwv+N+4xJkAAJ6I4QFjgxi8e8apDbLpQbqKPDyx4+e18v?=
 =?us-ascii?Q?Oqp54OW2cZLNIStlpY0RVSog7zjmCsSJBMrZSNF5uKP78/KSZPYT1dE6TNKU?=
 =?us-ascii?Q?smC6jEZVpL3NcRBMaUOTBVL46sFkFcDMeLTogt6iF1X/AMicsuDGmrO5k+Ca?=
 =?us-ascii?Q?gXwzZtTYZi1Osv0ZddYhEDwFWHhrTWmqbLsVlzRWpk8tUva3mdzCXAd9LqX8?=
 =?us-ascii?Q?47bFG5CehmViwhzt48WKRjwZw8PGiEf/zCe/dyp03S/DV9hJALA+cFaVYzPI?=
 =?us-ascii?Q?r03vvvfJnJWPiQieOZjYtKqTzsd+MqQ1bO7Iqx2AK93AB3uvIUqQQaxdeBUF?=
 =?us-ascii?Q?ihiBZL19iNX4NcN7bGkGNkIYy1lW8On5VsjbmWq6m5RS6O19u4i5Ks1Q4QJ3?=
 =?us-ascii?Q?n2QhJFzSK56HoCWBpo/hdnv8YTZTy/3emtJJoys3xOU/rPJfHWkgri+kNazs?=
 =?us-ascii?Q?pvRn9S4cIpcnYdOWsRoOXCC9KfNuU1ZjEyx0IfmD?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da89d52e-8b93-4f40-5026-08dceec97c44
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:33:52.3564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ueSZlqwiTIUniO9ICj8gZna7KHUZWm8qZ4UjIiQiZNmme/DcB1hF44Vaw6kXbmfUEOyougQfu38VQBbJGTHIbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682

On Thu, Oct 17, 2024 at 03:46:28PM +0800, Wei Fang wrote:
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
> ---
> v2 changes:
> 1. Add linux/bits.h
> 2. Remove the useless check at the beginning of netc_blk_ctrl_probe().
> 3. Use dev_err_probe() in netc_blk_ctrl_probe().
> v3 changes:
> 1. Change the compatible string to "pci1131,e101".
> 2. Add devm_clk_get_optional_enabled() instead of devm_clk_get_optional()
> 3. Directly return dev_err_probe().
> 4. Remove unused netc_read64().
> ---
>  drivers/net/ethernet/freescale/enetc/Kconfig  |  14 +
>  drivers/net/ethernet/freescale/enetc/Makefile |   3 +
>  .../ethernet/freescale/enetc/netc_blk_ctrl.c  | 440 ++++++++++++++++++
>  include/linux/fsl/netc_global.h               |  19 +
>  4 files changed, 476 insertions(+)
>  create mode 100644 drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
>  create mode 100644 include/linux/fsl/netc_global.h
>
> diff --git a/drivers/net/ethernet/freescale/enetc/Kconfig b/drivers/net/ethernet/freescale/enetc/Kconfig
> index 4d75e6807e92..51d80ea959d4 100644
> --- a/drivers/net/ethernet/freescale/enetc/Kconfig
> +++ b/drivers/net/ethernet/freescale/enetc/Kconfig
> @@ -75,3 +75,17 @@ config FSL_ENETC_QOS
>  	  enable/disable from user space via Qos commands(tc). In the kernel
>  	  side, it can be loaded by Qos driver. Currently, it is only support
>  	  taprio(802.1Qbv) and Credit Based Shaper(802.1Qbu).
> +
> +config NXP_NETC_BLK_CTRL
> +	tristate "NETC blocks control driver"
> +	help
> +	  This driver configures Integrated Endpoint Register Block (IERB) and
> +	  Privileged Register Block (PRB) of NETC. For i.MX platforms, it also
> +	  includes the configuration of NETCMIX block.
> +	  The IERB contains registers that are used for pre-boot initialization,
> +	  debug, and non-customer configuration. The PRB controls global reset
> +	  and global error handling for NETC. The NETCMIX block is mainly used
> +	  to set MII protocol and PCS protocol of the links, it also contains
> +	  settings for some other functions.
> +
> +	  If compiled as module (M), the module name is nxp-netc-blk-ctrl.
> diff --git a/drivers/net/ethernet/freescale/enetc/Makefile b/drivers/net/ethernet/freescale/enetc/Makefile
> index b13cbbabb2ea..5c277910d538 100644
> --- a/drivers/net/ethernet/freescale/enetc/Makefile
> +++ b/drivers/net/ethernet/freescale/enetc/Makefile
> @@ -19,3 +19,6 @@ fsl-enetc-mdio-y := enetc_pci_mdio.o enetc_mdio.o
>
>  obj-$(CONFIG_FSL_ENETC_PTP_CLOCK) += fsl-enetc-ptp.o
>  fsl-enetc-ptp-y := enetc_ptp.o
> +
> +obj-$(CONFIG_NXP_NETC_BLK_CTRL) += nxp-netc-blk-ctrl.o
> +nxp-netc-blk-ctrl-y := netc_blk_ctrl.o
> \ No newline at end of file
> diff --git a/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> new file mode 100644
> index 000000000000..d720bb613b5b
> --- /dev/null
> +++ b/drivers/net/ethernet/freescale/enetc/netc_blk_ctrl.c
> @@ -0,0 +1,440 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * NXP NETC Blocks Control Driver
> + *
> + * Copyright 2024 NXP
> + */
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/fsl/netc_global.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_net.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +
> +/* NETCMIX registers */
> +#define IMX95_CFG_LINK_IO_VAR		0x0
> +#define  IO_VAR_16FF_16G_SERDES		0x1
> +#define  IO_VAR(port, var)		(((var) & 0xf) << ((port) << 2))
> +
> +#define IMX95_CFG_LINK_MII_PROT		0x4
> +#define CFG_LINK_MII_PORT_0		GENMASK(3, 0)
> +#define CFG_LINK_MII_PORT_1		GENMASK(7, 4)
> +#define  MII_PROT_MII			0x0
> +#define  MII_PROT_RMII			0x1
> +#define  MII_PROT_RGMII			0x2
> +#define  MII_PROT_SERIAL		0x3
> +#define  MII_PROT(port, prot)		(((prot) & 0xf) << ((port) << 2))
> +
> +#define IMX95_CFG_LINK_PCS_PROT(a)	(0x8 + (a) * 4)
> +#define PCS_PROT_1G_SGMII		BIT(0)
> +#define PCS_PROT_2500M_SGMII		BIT(1)
> +#define PCS_PROT_XFI			BIT(3)
> +#define PCS_PROT_SFI			BIT(4)
> +#define PCS_PROT_10G_SXGMII		BIT(6)
> +
> +/* NETC privileged register block register */
> +#define PRB_NETCRR			0x100
> +#define  NETCRR_SR			BIT(0)
> +#define  NETCRR_LOCK			BIT(1)
> +
> +#define PRB_NETCSR			0x104
> +#define  NETCSR_ERROR			BIT(0)
> +#define  NETCSR_STATE			BIT(1)
> +
> +/* NETC integrated endpoint register block register */
> +#define IERB_EMDIOFAUXR			0x344
> +#define IERB_T0FAUXR			0x444
> +#define IERB_EFAUXR(a)			(0x3044 + 0x100 * (a))
> +#define IERB_VFAUXR(a)			(0x4004 + 0x40 * (a))
> +#define FAUXR_LDID			GENMASK(3, 0)
> +
> +/* Platform information */
> +#define IMX95_ENETC0_BUS_DEVFN		0x0
> +#define IMX95_ENETC1_BUS_DEVFN		0x40
> +#define IMX95_ENETC2_BUS_DEVFN		0x80
> +
> +/* Flags for different platforms */
> +#define NETC_HAS_NETCMIX		BIT(0)
> +
> +struct netc_devinfo {
> +	u32 flags;
> +	int (*netcmix_init)(struct platform_device *pdev);
> +	int (*ierb_init)(struct platform_device *pdev);
> +};
> +
> +struct netc_blk_ctrl {
> +	void __iomem *prb;
> +	void __iomem *ierb;
> +	void __iomem *netcmix;
> +
> +	const struct netc_devinfo *devinfo;
> +	struct platform_device *pdev;
> +	struct dentry *debugfs_root;
> +};
> +
> +static void netc_reg_write(void __iomem *base, u32 offset, u32 val)
> +{
> +	netc_write(base + offset, val);
> +}
> +
> +static u32 netc_reg_read(void __iomem *base, u32 offset)
> +{
> +	return netc_read(base + offset);
> +}
> +
> +static int netc_of_pci_get_bus_devfn(struct device_node *np)
> +{
> +	u32 reg[5];
> +	int error;
> +
> +	error = of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
> +	if (error)
> +		return error;
> +
> +	return (reg[0] >> 8) & 0xffff;
> +}
> +
> +static int netc_get_link_mii_protocol(phy_interface_t interface)
> +{
> +	switch (interface) {
> +	case PHY_INTERFACE_MODE_MII:
> +		return MII_PROT_MII;
> +	case PHY_INTERFACE_MODE_RMII:
> +		return MII_PROT_RMII;
> +	case PHY_INTERFACE_MODE_RGMII:
> +	case PHY_INTERFACE_MODE_RGMII_ID:
> +	case PHY_INTERFACE_MODE_RGMII_RXID:
> +	case PHY_INTERFACE_MODE_RGMII_TXID:
> +		return MII_PROT_RGMII;
> +	case PHY_INTERFACE_MODE_SGMII:
> +	case PHY_INTERFACE_MODE_2500BASEX:
> +	case PHY_INTERFACE_MODE_10GBASER:
> +	case PHY_INTERFACE_MODE_XGMII:
> +	case PHY_INTERFACE_MODE_USXGMII:
> +		return MII_PROT_SERIAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int imx95_netcmix_init(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +	struct device_node *np = pdev->dev.of_node;
> +	phy_interface_t interface;
> +	int bus_devfn, mii_proto;
> +	u32 val;
> +	int err;
> +
> +	/* Default setting of MII protocol */
> +	val = MII_PROT(0, MII_PROT_RGMII) | MII_PROT(1, MII_PROT_RGMII) |
> +	      MII_PROT(2, MII_PROT_SERIAL);
> +
> +	/* Update the link MII protocol through parsing phy-mode */
> +	for_each_available_child_of_node_scoped(np, child) {
> +		for_each_available_child_of_node_scoped(child, gchild) {
> +			if (!of_device_is_compatible(gchild, "pci1131,e101"))
> +				continue;
> +
> +			bus_devfn = netc_of_pci_get_bus_devfn(gchild);
> +			if (bus_devfn < 0)
> +				return -EINVAL;
> +
> +			if (bus_devfn == IMX95_ENETC2_BUS_DEVFN)
> +				continue;
> +
> +			err = of_get_phy_mode(gchild, &interface);
> +			if (err)
> +				continue;
> +
> +			mii_proto = netc_get_link_mii_protocol(interface);
> +			if (mii_proto < 0)
> +				return -EINVAL;
> +
> +			switch (bus_devfn) {
> +			case IMX95_ENETC0_BUS_DEVFN:
> +				val = u32_replace_bits(val, mii_proto,
> +						       CFG_LINK_MII_PORT_0);
> +				break;
> +			case IMX95_ENETC1_BUS_DEVFN:
> +				val = u32_replace_bits(val, mii_proto,
> +						       CFG_LINK_MII_PORT_1);
> +				break;
> +			default:
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	/* Configure Link I/O variant */
> +	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_IO_VAR,
> +		       IO_VAR(2, IO_VAR_16FF_16G_SERDES));
> +	/* Configure Link 2 PCS protocol */
> +	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_PCS_PROT(2),
> +		       PCS_PROT_10G_SXGMII);
> +	netc_reg_write(priv->netcmix, IMX95_CFG_LINK_MII_PROT, val);
> +
> +	return 0;
> +}
> +
> +static bool netc_ierb_is_locked(struct netc_blk_ctrl *priv)
> +{
> +	return !!(netc_reg_read(priv->prb, PRB_NETCRR) & NETCRR_LOCK);
> +}
> +
> +static int netc_lock_ierb(struct netc_blk_ctrl *priv)
> +{
> +	u32 val;
> +
> +	netc_reg_write(priv->prb, PRB_NETCRR, NETCRR_LOCK);
> +
> +	return read_poll_timeout(netc_reg_read, val, !(val & NETCSR_STATE),
> +				 100, 2000, false, priv->prb, PRB_NETCSR);
> +}
> +
> +static int netc_unlock_ierb_with_warm_reset(struct netc_blk_ctrl *priv)
> +{
> +	u32 val;
> +
> +	netc_reg_write(priv->prb, PRB_NETCRR, 0);
> +
> +	return read_poll_timeout(netc_reg_read, val, !(val & NETCRR_LOCK),
> +				 1000, 100000, true, priv->prb, PRB_NETCRR);
> +}
> +
> +static int imx95_ierb_init(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +
> +	/* EMDIO : No MSI-X intterupt */
> +	netc_reg_write(priv->ierb, IERB_EMDIOFAUXR, 0);
> +	/* ENETC0 PF */
> +	netc_reg_write(priv->ierb, IERB_EFAUXR(0), 0);
> +	/* ENETC0 VF0 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(0), 1);
> +	/* ENETC0 VF1 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(1), 2);
> +	/* ENETC1 PF */
> +	netc_reg_write(priv->ierb, IERB_EFAUXR(1), 3);
> +	/* ENETC1 VF0 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(2), 5);
> +	/* ENETC1 VF1 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(3), 6);
> +	/* ENETC2 PF */
> +	netc_reg_write(priv->ierb, IERB_EFAUXR(2), 4);
> +	/* ENETC2 VF0 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(4), 5);
> +	/* ENETC2 VF1 */
> +	netc_reg_write(priv->ierb, IERB_VFAUXR(5), 6);
> +	/* NETC TIMER */
> +	netc_reg_write(priv->ierb, IERB_T0FAUXR, 7);
> +
> +	return 0;
> +}
> +
> +static int netc_ierb_init(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +	const struct netc_devinfo *devinfo = priv->devinfo;
> +	int err;
> +
> +	if (netc_ierb_is_locked(priv)) {
> +		err = netc_unlock_ierb_with_warm_reset(priv);
> +		if (err) {
> +			dev_err(&pdev->dev, "Unlock IERB failed.\n");
> +			return err;
> +		}
> +	}
> +
> +	if (devinfo->ierb_init) {
> +		err = devinfo->ierb_init(pdev);
> +		if (err)
> +			return err;
> +	}
> +
> +	err = netc_lock_ierb(priv);
> +	if (err) {
> +		dev_err(&pdev->dev, "Lock IERB failed.\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}
> +
> +#if IS_ENABLED(CONFIG_DEBUG_FS)
> +static int netc_prb_show(struct seq_file *s, void *data)
> +{
> +	struct netc_blk_ctrl *priv = s->private;
> +	u32 val;
> +
> +	val = netc_reg_read(priv->prb, PRB_NETCRR);
> +	seq_printf(s, "[PRB NETCRR] Lock:%d SR:%d\n",
> +		   (val & NETCRR_LOCK) ? 1 : 0,
> +		   (val & NETCRR_SR) ? 1 : 0);
> +
> +	val = netc_reg_read(priv->prb, PRB_NETCSR);
> +	seq_printf(s, "[PRB NETCSR] State:%d Error:%d\n",
> +		   (val & NETCSR_STATE) ? 1 : 0,
> +		   (val & NETCSR_ERROR) ? 1 : 0);
> +
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(netc_prb);
> +
> +static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
> +{
> +	struct dentry *root;
> +
> +	root = debugfs_create_dir("netc_blk_ctrl", NULL);
> +	if (IS_ERR(root))
> +		return;
> +
> +	priv->debugfs_root = root;
> +
> +	debugfs_create_file("prb", 0444, root, priv, &netc_prb_fops);
> +}
> +
> +static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
> +{
> +	debugfs_remove_recursive(priv->debugfs_root);
> +	priv->debugfs_root = NULL;
> +}
> +
> +#else
> +
> +static void netc_blk_ctrl_create_debugfs(struct netc_blk_ctrl *priv)
> +{
> +}
> +
> +static void netc_blk_ctrl_remove_debugfs(struct netc_blk_ctrl *priv)
> +{
> +}
> +#endif
> +
> +static int netc_prb_check_error(struct netc_blk_ctrl *priv)
> +{
> +	u32 val;
> +
> +	val = netc_reg_read(priv->prb, PRB_NETCSR);
> +	if (val & NETCSR_ERROR)
> +		return -1;

nit:
	if (netc_reg_read(priv->prb, PRB_NETCSR) & NETCSR_ERROR))
		return -1;

	return 0;

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> +
> +	return 0;
> +}
> +
> +static const struct netc_devinfo imx95_devinfo = {
> +	.flags = NETC_HAS_NETCMIX,
> +	.netcmix_init = imx95_netcmix_init,
> +	.ierb_init = imx95_ierb_init,
> +};
> +
> +static const struct of_device_id netc_blk_ctrl_match[] = {
> +	{ .compatible = "nxp,imx95-netc-blk-ctrl", .data = &imx95_devinfo },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, netc_blk_ctrl_match);
> +
> +static int netc_blk_ctrl_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	const struct netc_devinfo *devinfo;
> +	struct device *dev = &pdev->dev;
> +	const struct of_device_id *id;
> +	struct netc_blk_ctrl *priv;
> +	struct clk *ipg_clk;
> +	void __iomem *regs;
> +	int err;
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->pdev = pdev;
> +	ipg_clk = devm_clk_get_optional_enabled(dev, "ipg");
> +	if (IS_ERR(ipg_clk))
> +		return dev_err_probe(dev, PTR_ERR(ipg_clk),
> +				     "Set ipg clock failed\n");
> +
> +	id = of_match_device(netc_blk_ctrl_match, dev);
> +	if (!id)
> +		return dev_err_probe(dev, -EINVAL, "Cannot match device\n");
> +
> +	devinfo = (struct netc_devinfo *)id->data;
> +	if (!devinfo)
> +		return dev_err_probe(dev, -EINVAL, "No device information\n");
> +
> +	priv->devinfo = devinfo;
> +	regs = devm_platform_ioremap_resource_byname(pdev, "ierb");
> +	if (IS_ERR(regs))
> +		return dev_err_probe(dev, PTR_ERR(regs),
> +				     "Missing IERB resource\n");
> +
> +	priv->ierb = regs;
> +	regs = devm_platform_ioremap_resource_byname(pdev, "prb");
> +	if (IS_ERR(regs))
> +		return dev_err_probe(dev, PTR_ERR(regs),
> +				     "Missing PRB resource\n");
> +
> +	priv->prb = regs;
> +	if (devinfo->flags & NETC_HAS_NETCMIX) {
> +		regs = devm_platform_ioremap_resource_byname(pdev, "netcmix");
> +		if (IS_ERR(regs))
> +			return dev_err_probe(dev, PTR_ERR(regs),
> +					     "Missing NETCMIX resource\n");
> +		priv->netcmix = regs;
> +	}
> +
> +	platform_set_drvdata(pdev, priv);
> +	if (devinfo->netcmix_init) {
> +		err = devinfo->netcmix_init(pdev);
> +		if (err)
> +			return dev_err_probe(dev, err,
> +					     "Initializing NETCMIX failed\n");
> +	}
> +
> +	err = netc_ierb_init(pdev);
> +	if (err)
> +		return dev_err_probe(dev, err, "Initializing IERB failed\n");
> +
> +	if (netc_prb_check_error(priv) < 0)
> +		dev_warn(dev, "The current IERB configuration is invalid\n");
> +
> +	netc_blk_ctrl_create_debugfs(priv);
> +
> +	err = of_platform_populate(node, NULL, NULL, dev);
> +	if (err) {
> +		netc_blk_ctrl_remove_debugfs(priv);
> +		return dev_err_probe(dev, err, "of_platform_populate failed\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static void netc_blk_ctrl_remove(struct platform_device *pdev)
> +{
> +	struct netc_blk_ctrl *priv = platform_get_drvdata(pdev);
> +
> +	of_platform_depopulate(&pdev->dev);
> +	netc_blk_ctrl_remove_debugfs(priv);
> +}
> +
> +static struct platform_driver netc_blk_ctrl_driver = {
> +	.driver = {
> +		.name = "nxp-netc-blk-ctrl",
> +		.of_match_table = netc_blk_ctrl_match,
> +	},
> +	.probe = netc_blk_ctrl_probe,
> +	.remove = netc_blk_ctrl_remove,
> +};
> +
> +module_platform_driver(netc_blk_ctrl_driver);
> +
> +MODULE_DESCRIPTION("NXP NETC Blocks Control Driver");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/include/linux/fsl/netc_global.h b/include/linux/fsl/netc_global.h
> new file mode 100644
> index 000000000000..fdecca8c90f0
> --- /dev/null
> +++ b/include/linux/fsl/netc_global.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/* Copyright 2024 NXP
> + */
> +#ifndef __NETC_GLOBAL_H
> +#define __NETC_GLOBAL_H
> +
> +#include <linux/io.h>
> +
> +static inline u32 netc_read(void __iomem *reg)
> +{
> +	return ioread32(reg);
> +}
> +
> +static inline void netc_write(void __iomem *reg, u32 val)
> +{
> +	iowrite32(val, reg);
> +}
> +
> +#endif
> --
> 2.34.1
>

