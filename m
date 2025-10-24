Return-Path: <linux-pci+bounces-39274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DBC6C070CB
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 17:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1872E1C25A22
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 15:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02B933101BF;
	Fri, 24 Oct 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GGu8agMq"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C781DC994;
	Fri, 24 Oct 2025 15:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761320726; cv=fail; b=eUOvX3KHH88KRQnNiQj9kAGujWiV+78p1TUOMdsTcV70XfLAAg3yPcg2gFgd6vHvxXgt84ZtUmYRhu+k9JgomtEOYDWh9fZdxoVjAz6GFUu6mFw8MqoFdPjIwyCfNKP9kPl+8OFytB+y4qgC28FmG4nVVUXQHfOj+PUJFTlX3xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761320726; c=relaxed/simple;
	bh=lgrhiVjEy8zotws1tgbNi37gg5k7V/q9hvVrCF2cmEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s+wKJItGfzLtJ1+C9ffurmD4bWFgXayHMXDQOD71QcPrnevH7yXXcBUNbPFsg7f/M2r64WFe13F7DPI1tLAc30Obb0y4aqg/JwiJcj/p86HE5ax6AYtq9N9/55N7qvZaWBhKZsQMwQgJVuJDCBqGIK6CwkDCZiRA9wFIWDH+Z8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GGu8agMq; arc=fail smtp.client-ip=52.101.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAcBKN6zvmwrnQb/UBi0r9H1QE1O3+xMiY9jMmb778SCKMqXqwIeadoybcg3NvJsmhETpAGqv4pHW6TAwNbPuW0taXkWL42PESkUJXGya7S373zPEXdV7gMshyCcbdqF9AB/4O9S8rF7D910A2jcXUPj+5VYcnVXYFvD3MyF12mUvDcOiZNgf4jxuFq6SdxirZrvhzGSWjDPAAr3pfjny8UhvTNyIjsY07zkdGMvFI4Jd8EaUt674X4OXxQYTkcK1F2FffXqhBnfkmy85Mjnu3feFrXM/1rxImzJwTVSj/hQeDyab58JRarrQ1WHPqcDtTj5kB9Foa8ay9Pc6+wUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d9k7aXSjrD40x0FBf31ippeHnSHkHlxNapv9FPo1Frg=;
 b=r19QNTu4cQDH3e6u2r2ItSd2Wnw6QkgFmn929Xrmn/dQ6e3v/4k5bhmpW/7sp4kcRHQSMCTESM9AXtntDuHfzW28MbSqV9v3aXh0tNhAsGRNWjYM1CMsbpN/+Y99nYXKgtMkB+fLX+pSEO60XkyLByNjyGsstoibGqGWfFmxlph7SgAymTVQE/0KtHXnhugS887QGPH5wT4wHzjarbpuqbe3pxQQxWoPvCNqCY6Qy/FpbuXHrKYnGOHcqNFRN2SSUHti4dfPwpu+JPMDMn+NnAY2q2pWUl0LFn04y9rw5P+Lq/rr0xJTSvM1GI2dU6cRdunXt1J1WjBDW3yB0sasYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d9k7aXSjrD40x0FBf31ippeHnSHkHlxNapv9FPo1Frg=;
 b=GGu8agMqUv/X/4BQds1UXf5MMqBBBgw1aXra71jk7fN0FgZ+VuyJHymx+jm/XE+SrmgXxLMT5Q/65OPmsyiJz21jmYyd8F+emt9sPjBD24xo84182jZjehzpF/LeD7R+HAl+oLzQ8v9o5mVV5U/tfntxjH9eh2RGUXiweuFcJPAnq5QJaDfs3NbvebIF2Whw4zjpsrqLvd8hAG/ChNrE2OEehiTGMdaqaz5qSUxS7gFzbewbvhF6sMroadyVA2GLpmI2C9OQvqEDjk1aec4beStLSEMz6x9u235X27+7zH3fQ2x8l4e30NM3fypVNvAJXYcKl0a07ETLCPzXqZYY6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by VI0PR04MB10095.eurprd04.prod.outlook.com (2603:10a6:800:246::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 15:45:22 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 15:45:21 +0000
Date: Fri, 24 Oct 2025 11:45:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, jdmason@kudzu.us,
	dave.jiang@intel.com, allenbh@gmail.com, mani@kernel.org,
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com,
	jbrunet@baylibre.com, lpieralisi@kernel.org, yebin10@huawei.com,
	geert+renesas@glider.be, arnd@arndb.de
Subject: Re: [PATCH 1/6] NTB: epf: Avoid pci_iounmap() with offset when
 PEER_SPAD and CONFIG share BAR
Message-ID: <aPufCHOKK7WrBKR+@lizhi-Precision-Tower-5810>
References: <20251023071757.901181-1-den@valinux.co.jp>
 <20251023071757.901181-2-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023071757.901181-2-den@valinux.co.jp>
X-ClientProxiedBy: BYAPR03CA0032.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::45) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|VI0PR04MB10095:EE_
X-MS-Office365-Filtering-Correlation-Id: bf12c6e7-97a4-40aa-7572-08de1314573b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OpKTlybuSwByP2ZDhnKPRNiSyaFreDypzs5KQkNNn2s56Xvoc1KRCDETvXdK?=
 =?us-ascii?Q?snVaSn6uSEANeslypsRJSwdb79QhGQKZ5+3jL9IRTla3Nl7zbPdeTc1Yl2NJ?=
 =?us-ascii?Q?zsSNqsR+DYy/HTEArJTcT0tCgMZ/F7rQecb3Ybcct2hgQgSteh+J7/1MPbMD?=
 =?us-ascii?Q?GJ+7swUVh+V5e+wAdX63am4W6BZK++anj0a7lPHLGK9+ZNczzR5HacsprOjQ?=
 =?us-ascii?Q?AqKPQDJ/VkKLzS6Waw9z33FEYG1IP2Jtt08wCg5DZXkw68k/HImXXFy29Y+2?=
 =?us-ascii?Q?DlXC/xRI+cpOc0DThwNjgjuqCoI8c4VyVk5k0PDTWKlY+SCF5hU95Ok7gQ1f?=
 =?us-ascii?Q?osjcr2mXVEyyidhl14y0QnN4LE/z+bXxgzPUNQ14glWuDN3hnseJwcZ7pqME?=
 =?us-ascii?Q?+FHzUkfk2bxv1JJgrxlVWVt/qMuwd3yGOQkRveNWHsByi+QDbGcJb9pkF7O4?=
 =?us-ascii?Q?zuE9zr9OkiUD8T3U23BJJM8S+7t8efS9kUHxklkZtmsamjlOXH8Dk95geGkj?=
 =?us-ascii?Q?8EQKKwsx+mTZUjcYwxgRQ3pmd/FBxPnzFG6tWDA7aSKesdN7uwaECJ1UNTzY?=
 =?us-ascii?Q?FTt9SwYt3wFuipUDkZdyKaMPxPvG0URM8/oKVIInUB5XpI+XCjTeNGo6hc04?=
 =?us-ascii?Q?m6H3Ybkb/NVbM+SCPYvsMJleqVumXsrMJcqgdjnGlDVCJYD6QRmlFf6Np/1a?=
 =?us-ascii?Q?fYQvPyxJsCkaxcWWMAi11vY0hLmlP3/YqMSDsmlRNQkpYkmRfQDcahECYSye?=
 =?us-ascii?Q?AzbVWMEusKB177oLoNcG3qezUUrjWsZlF4CTlAZcEPUoeWVuUsHIBgEm+jMa?=
 =?us-ascii?Q?9Hbe6xn+uXZB1sTQliG88H1DbKFEDm4QoLS+W/RpGk/gpgg8cnX+KpRvbsIr?=
 =?us-ascii?Q?RAXwIC2kRInPz66cY1Qx1fGxwmmLN5K1YtXQ7DcxEFur+0TkNPYRJF5cBh9i?=
 =?us-ascii?Q?OwDWRhzrczWcYd5a/LbzLNGHRifim/CfudH7u2MPUgGz7BJE4ocRnULK2RQh?=
 =?us-ascii?Q?IiskPV94hoL/IJ+GP31Q3yd0ZLBVFXjMDVYWnRkpDEn+AmuSEyA2pWx0JiZ+?=
 =?us-ascii?Q?1xkXNVeZCA7LnUD7EUWdPlsGvIJQDTPcLfjgPMJvpsHfCwwNHCRGpikYS1A/?=
 =?us-ascii?Q?mJW/h2w+CIwd/kjMHIZXBMCvg4aN5bOmkvREGg073Ng6mQ9nRgbRc1Ij5ocQ?=
 =?us-ascii?Q?Y4l7PMc42Z+tSlnq3lCkUI7TCTwh4z928SRKfUekls3JiDtLj72CRYAsvFeG?=
 =?us-ascii?Q?0ogep7XnclQVT1nazogrOQCuT9xlwNC8tw9lmKSJngxX2fyzduYNjHuV7UPs?=
 =?us-ascii?Q?nD5YqP7Plii0NARHlVpldqkF8+Y6KKVNQO6rrU8oC0bTlTnm8VrxTsdB9TG0?=
 =?us-ascii?Q?3TXN2WYt8a6ThUnNTbyDSHba2RkOZH6HjYYLOvfxUb1rvIHVS/WKCWTvukCP?=
 =?us-ascii?Q?jleI8CZnqwGkeg22d2abXifke4LCHsky6EWJSY/Hk1BZiKcG+927GRnCgCeW?=
 =?us-ascii?Q?IutM6hOkWHKKf2FEILARpXhvyQ/CDyM40IC/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?57LyX22u26UaLyd3Sd5lzMH+k+pd7sbL2WnK114Q834PAFeP4XxCOXHzJ1U4?=
 =?us-ascii?Q?nnfClnGDQCiR4lZPwy/2+ChuFN/MiJpWZGh0oDPQG0wQXT4Zn0AmTcVIVuBk?=
 =?us-ascii?Q?q+mtKYzUxzS+zLrchO8BrKlLVYvw0Ho8cVhEZV94Eq0AuCSJoQXRSI3CW13X?=
 =?us-ascii?Q?8pfwJ90yZpR9ifTTd0YOewnRhXqmw+2UI+hzK8L1+XqL+ybIj/L0TP/6g9eo?=
 =?us-ascii?Q?0BZku9UiM5hfkeQuiC9oU4w4Jn+wj+AUFaftdqsVVSwL3eS1ibFUHMsCXip+?=
 =?us-ascii?Q?+0aFJWzHzK2sOBMnn6NlZXvUl1Xb5Z27xkD0B14sJ+HToXyENshj3TOTAIYp?=
 =?us-ascii?Q?hPC8wWM2i3r/rVlzLIjpPd2dkbqUvJO4a3OHSuevQVrjH+wrEUefzwki2nmV?=
 =?us-ascii?Q?FVw1EhUTvyE41rHfMOouXflMHbHm/+oQPz88WZp2UwgB8f5Gjtqg7YFqmC9P?=
 =?us-ascii?Q?W1HjNJeCgDpV0r6E3NMqDeLYuUW/i18ru2YENmb7IvbAESX7d8SN83j0Jp5T?=
 =?us-ascii?Q?8xtLTNY3zA3nQzF1neTmvwtVXDGi45ujUMSv55H6aQE0A9SOHJX20kHDJx4M?=
 =?us-ascii?Q?edkSFd7l6Ju8H96w+B0epAbh4tyV1o8+4aup/RWHP/i1xi525fDP78oJavMq?=
 =?us-ascii?Q?ze3JSyuAMunUpkZGBq4AMyT7oiJ9wQd8673JjTfbKd3anJUlxtO8eIgERZ34?=
 =?us-ascii?Q?YsZiE8XgW4SIfY8wzDAQ4QS+xJCIgFfGffl6yxTtzHQxpWx+FdWPnJUslci+?=
 =?us-ascii?Q?qeBAliro7x5nZvVYlF861K/EhaP1ihItyQvF1IakQR3aWzw4KvvpwUWRKsNP?=
 =?us-ascii?Q?LKu4nStoRFI1/Ju4N0/bYOCqxKpNFp0mtBkyM44jAKrdO4Y+UC9Gv2eLRL85?=
 =?us-ascii?Q?bPAVVqM4CkA6nubeH2AdvKQCBIGcEQ8lewMEb7Ic2kVw3gbTT5VXfkHYOu/U?=
 =?us-ascii?Q?IXmFRSizvVz5Hkh6BuXqXcy0VUikUbPqZ2FE+kbzRNpw6l8kSNY5CJnbqG8d?=
 =?us-ascii?Q?HhrpyqZlswp89DxcrRNDp+CnaYFOIlqEqe3CavZQhwt5n9/sm9mF1EPxgH2a?=
 =?us-ascii?Q?ls6nqvtChaAWkbyTX/TWs0wlrtHrSV3KmX8pRLa7OT2rtI5W0bR6DDeaJE5j?=
 =?us-ascii?Q?12lTyt+B7mNIDWSldZP7/Uskg+w8+7qyco+Z7QSf1OO4IjeIwgqJwxD2rw3j?=
 =?us-ascii?Q?IWO7Jt45H5rAsblS+Y4c5t/omofu4kTTfuPDJ1Q9efFF/5qZGpwQ8RSsukT7?=
 =?us-ascii?Q?jQQheZPYb0iS1soe6wm5DhG6XZE8ddBV1E5vA9L5rf1x0Kw4S7vKKfwC/Wv/?=
 =?us-ascii?Q?4gJuh9fmgdOBTS1PEMyrp0ppzTRQy1qvXpca8PFQOlsjMWoX2CgiyyNTWdQP?=
 =?us-ascii?Q?EyHUFcG9JgZn9GhIq6kyxTlVMCM32oCunDQ1N8atfDPW2i004wORxzsUyWAW?=
 =?us-ascii?Q?94CptZSHhLB7deXa4ReJ54gNJCkMj5Re5fDEd/3r9EIq+/JCQ8PvsWSmJza2?=
 =?us-ascii?Q?aHBt2KfuyHN6EqQ3rlMz52xYiy9l1BEwtOceq78U3t6bQlQ8aQcQTvrlFlRA?=
 =?us-ascii?Q?nN6FIrMG615pslhYDj7Ls99z6w72BmUps85aP+KY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf12c6e7-97a4-40aa-7572-08de1314573b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 15:45:21.9152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LO46TbaDkk972Vhff7cEqK+sbHEFmMHSuJqrdXtB+VqngsKPOf/z1eAtmEvTklQcSb4muQDZ2eoxJzwhigC1og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10095

On Thu, Oct 23, 2025 at 04:17:52PM +0900, Koichiro Den wrote:

NTB: epf: Avoid pci_iounmap() twice when PEER_SPAD and CONFIG share one BAR.

> When BAR_PEER_SPAD equals BAR_CONFIG,

When BAR_PEER_SPAD and BAR_CONFIG share one PCI BAR, ...
> the module teardown path ends up
> calling pci_iounmap() on the same iomem with some offset, which is
> unnecessary and triggers a kernel warning like the following:
>
>   Trying to vunmap() nonexistent vm area (0000000069a5ffe8)
>   WARNING: mm/vmalloc.c:3470 at vunmap+0x58/0x68, CPU#5: modprobe/2937
>   [...]
>   Call trace:
>    vunmap+0x58/0x68 (P)
>    iounmap+0x34/0x48
>    pci_iounmap+0x2c/0x40
>    ntb_epf_pci_remove+0x44/0x80 [ntb_hw_epf]
>    pci_device_remove+0x48/0xf8
>    device_remove+0x50/0x88
>    device_release_driver_internal+0x1c8/0x228
>    driver_detach+0x50/0xb0
>    bus_remove_driver+0x74/0x100
>    driver_unregister+0x34/0x68
>    pci_unregister_driver+0x34/0xa0
>    ntb_epf_pci_driver_exit+0x14/0xfe0 [ntb_hw_epf]
>   [...]
>
> Fix it by unmapping only once and only the base mapping when the two
> windows share the same BAR.

Fix it by unmapping only when PEER_SPAD and CONFIG use difference bars.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Cc: <stable@vger.kernel.org>
> Fixes: e75d5ae8ab88 ("NTB: epf: Allow more flexibility in the memory BAR map method")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/hw/epf/ntb_hw_epf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
> index d3ecf25a5162..9935da48a52e 100644
> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
> @@ -646,7 +646,8 @@ static void ntb_epf_deinit_pci(struct ntb_epf_dev *ndev)
>  	struct pci_dev *pdev = ndev->ntb.pdev;
>
>  	pci_iounmap(pdev, ndev->ctrl_reg);
> -	pci_iounmap(pdev, ndev->peer_spad_reg);
> +	if (ndev->barno_map[BAR_PEER_SPAD] != ndev->barno_map[BAR_CONFIG])
> +		pci_iounmap(pdev, ndev->peer_spad_reg);
>  	pci_iounmap(pdev, ndev->db_reg);
>
>  	pci_release_regions(pdev);
> --
> 2.48.1
>

