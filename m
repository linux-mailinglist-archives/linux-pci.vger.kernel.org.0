Return-Path: <linux-pci+bounces-44243-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5622FD00937
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 02:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9ABA230245C5
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 01:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF3F1F4615;
	Thu,  8 Jan 2026 01:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rdL3YrCY"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020140.outbound.protection.outlook.com [52.101.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1D719CCEF;
	Thu,  8 Jan 2026 01:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767836532; cv=fail; b=jc/oWiWdMR2uUCseSZ91/oX09O/rGO68PVGijof+2jK1vVE4nlpNT5zuTTsWw/tUJg9exiA6ThF30lHy5mh+2CXICc5ywpOkrD3V7aoFtNf3UdavoZyuPwNW/J1Pfwfpu1u/xNPdWtQ91ArgqOcD0PiHSFO3E9YVaz1KiCfS4vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767836532; c=relaxed/simple;
	bh=5nA6TiQCUxBdqpTZLuVGRXKFPCwLhRiMb+yXCGLnLYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tXpMzklzRPjr1btBQDRFpO2x6h0J/gfZGVxJ5Ge34NPAv8s3Pu5frKTlAJ6KQwaSKDrq/FyIWsjxQuREPPTGBdRZL4aNWpJMsygLYeDNbb7imjMuw0ad/EmL5Kjf1twDat1MkZ61GWpR3JRZz+XSiy2pPCzFat5+uojWIldXxiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rdL3YrCY; arc=fail smtp.client-ip=52.101.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrKCgndYHaDumf+V3KI2Y857KWnu1T5YpCGzcCOH1HApdPJAQOZy39J8tOrERUaAMwMQRRJQ+cS+KFTGb/n8gwe4UterldiqYpiBdlkk0VUqD/wazO3k8S9aVYw26R5br3kEPonY/YJ3VGcGmkI07DvVDQMWCtoBVqtzMuXJAsyD4yjFDCHZTg41hMC/64Jun1yumqqbHMCJhWCPn4TBKtE+u7lQbVtb06rC/6fdVFxuGKWn3sp9MwpWJzWfZsAorFW9ZLY2Jf9mznt9mBPzqclYxubCUVBEeWHZZBvRXIdg8NuA6mBW29+MxaOd++GZaHd/gzvnv/+U7mIIe5W/ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRLvm3s9tQ7jg18Wrio7ubXlX7v9OdlS7j0ncdYJOTE=;
 b=CeJfcZYqSV/dphq/N+SPJA4ITgBjXIMiLA8lEl7rWGAxwL+sY91XITvUCUQVU3LxUD/txPe4BngmXKRVRpSl+AVjGz/U5FCQLM6BmC2PiHLrwgcx6fp/yTOKmDAn4PfLnmWpRH9RUR1JpY2D9FrUaXvRDpvgxrFmL0FYs7xbjAB55IBY9BxInhFcJU3SLsoy2LSrhSQDyKLGwFlQInvfLkXgAoWUWE1/czY5llVt6wJF+R57UcmiFBAV7juFxsQ0fg3YCOb9T9do26t4QXadcgITbkID9dWzukc4jX2g+44Y4k5rFhFfkXQDyAzlZwS15ifSbfytdjcGx8XxywQl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRLvm3s9tQ7jg18Wrio7ubXlX7v9OdlS7j0ncdYJOTE=;
 b=rdL3YrCY/7OlbUttI+erJ2gTpcJloUCXYl9h6WvR4P1JUDK9uLVSnzrK22rmvLFi8NflmfVKJ+mHWa1rJRgc+Swayj7Cizl01CYlUTXQtScxiGxRcxblRfp12hd8WExV6MuNSeCzOAkr3ALpfHYs3sWstkuxpcHi8rlgeFM/YpI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5546.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 01:42:06 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 01:42:06 +0000
Date: Thu, 8 Jan 2026 10:42:05 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, Frank.Li@nxp.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: dwc: ep: Support BAR subrange inbound
 mapping via address-match iATU
Message-ID: <e7atdf4hszeijz3pyt3deegl7tye5fjvvpe2klc5kg7m4okenu@habv7c2ys4zk>
References: <20260107041358.1986701-1-den@valinux.co.jp>
 <20260107041358.1986701-3-den@valinux.co.jp>
 <aV5tUE02ipda-R76@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV5tUE02ipda-R76@ryzen>
X-ClientProxiedBy: TYCPR01CA0145.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5546:EE_
X-MS-Office365-Filtering-Correlation-Id: de821159-836c-4292-4d41-08de4e57217e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EyEOLa5A0v80u5XP8n0wb5vg2GqCTDf8GDq0GYV/Sy/He7wODPwY8ZcOzyRO?=
 =?us-ascii?Q?nUchNVW5wZaVdlV/wfg9L7Cq5+VkRQxkW1YXcsEIVQ2R9a2f5F7vcAPrV5W0?=
 =?us-ascii?Q?cvfYzBSaYoHQglB7qYo3AnjiidtpTTbtY3i0NkJfharY4Qp1EZjUedvZ+Qr4?=
 =?us-ascii?Q?De+G4Zs98l4EaOVcOjW69SNsd2gKNozBAq/5rzAiEkMzWFA2+tA7X1ETXEbC?=
 =?us-ascii?Q?c2fkdhOPSpNn9hsvEaRb1WZYJGAdzut/SzLhZB6++uld9ortvdIPCzJEzkp4?=
 =?us-ascii?Q?46l1EDm8LkQ+JdBjR2luRT1z7OcXLMjXqSRsXR52o2X35TYqUem/Hd570wW7?=
 =?us-ascii?Q?d2v0YD8nc0sAyFVyMzM6w3r0bHXKnOr/Jszf/JDDBTAJzQBoYVLbJ9psQIck?=
 =?us-ascii?Q?o21eB/s+iwSnBJKZ2HLme83tASGT2M8VPxbmPnTdwg4CvEzUROqHQ5cLxYmo?=
 =?us-ascii?Q?4Upo+PGfdQkO1gCyKgLXKLXWoyvDr1WRueXcvX+aokEuQ62ctWXuypDr4GnV?=
 =?us-ascii?Q?rF6OZuDx93F8Ez415krUiMh/DvJloRHQ3CsT3GfbyD0yATjSCqhyRcDECiN0?=
 =?us-ascii?Q?Yf9/ya7rbyMUbtApkBkzO96wCKPN9eD73a4yGfU+55ZTiU3uPj6oZH8wJSCX?=
 =?us-ascii?Q?vFA0qTNgdlFKzrgsM/HYDfIgVAXzXZNjfqJxMBLHbX6Jp4BGqySuBJLaF1qm?=
 =?us-ascii?Q?YWo79hwb1TU5gr5BOVFMqNpCHExK2Pa0Krf4bAffi3GsQY7dpYBezWQelVSk?=
 =?us-ascii?Q?wdLkVVkYGl4YsydEU0xx5VmCD4lIexDaANeqV8cDayybrl5D1qlV2UWtMscE?=
 =?us-ascii?Q?LHxoW8OoNihin/OtyCxg9J3kh0mRrl4wDz8bxvkv4k+jJW6ivA3JggZ+K0Qp?=
 =?us-ascii?Q?jEJhW09mpuV6mB0jt3eXqbL8Ts08QAUv9Tl+6MSafqiOsdvYGQowg7Jws2K8?=
 =?us-ascii?Q?rKhFXvervFenrW1wbAHT8+BEZS4cYWSVCPCThpviVROZxesxxw5qGzWrdQmE?=
 =?us-ascii?Q?iQQod9sMM1YaZUOQYdQmKRtYS39GlzSFuG3vPNN4KYQxUs5FlJvFYraSMmQG?=
 =?us-ascii?Q?dM4bySk+MDyb5Z2vldzpc6YSSEcibmMaNA0NLf0vuLD7yw/UP79lmGHA9RPZ?=
 =?us-ascii?Q?sXsJNMMd1/fAI0hM/m+rKrQ5euPHzCulQ6x4S02LwvTgRa7J4Jbes3rFDaWN?=
 =?us-ascii?Q?rW1Mvmf+NbONp6uRKuaJ4M+XcHz7ry+WnILLqEdmU3gz7m5BDYL+Tz2VvMre?=
 =?us-ascii?Q?SzpSXZtZQ90J8Xz5B9/QhLAnRDTLKtlVZ0YO1x1kzuMzyVEWFsuRJDJFD/Fb?=
 =?us-ascii?Q?qO7Kzfq0iUCpSAuFPj2PbwNzS1IuebmzeGpojrDZiPrQRCNPvjwtTaurf2uU?=
 =?us-ascii?Q?QwjAPxm8rqObMrr+vsz2mObqx0b2mjZYMkNEWCRLTMd8rLfnYbHlxDki0yS4?=
 =?us-ascii?Q?NzYcoe6zALAdwwoXkvski+Ol75E0emwy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g+jBggZTB3X8gIDVd8nASWX4O14KRkRXSfZz/1y+aF3Npc1MMYtYNf5JJT6y?=
 =?us-ascii?Q?3+xucvSOX31arZ5xtw4GhiPGY7vAcHKKS8E6A5sa40sRZb9QTShVmpuG/c/M?=
 =?us-ascii?Q?NpgBD5HoJGjSuLlWaDeai0lbSDPrE+1p+QiOfqb/Oik6UKJUfEIuRUFxIlli?=
 =?us-ascii?Q?vDirFIH8eRQ9I+0/ajwqWby4H7nQ/kiYpBdKfIYcR9YBooN0wnZDv6VB5BhX?=
 =?us-ascii?Q?pyPwc/9nR/euU81PdMUxbmjVy7vsfNEefuKQGB2cdVySOC3Hr39KPrfHHXLn?=
 =?us-ascii?Q?++uSP8bClTPz1QsDsl/r4TFF6HOZDLtR/Ir/nuCseIOpiS8Sg/7wheV3oqmm?=
 =?us-ascii?Q?lwmnk6x4eyHuaIlzehe46exS3hXkjMVFzXOb8C8uNQNoIU1iwelEoGyDwmpx?=
 =?us-ascii?Q?Ayhy4wsnaV1zx8CRtjroIbkPBlG8juOgwpTNQA84b4thANCla/JrYROnQw7L?=
 =?us-ascii?Q?pjXCkVVglOq2W1h2T/9Hszv95qx7f7sO2ry1uRYHnyVN+2ln00WjeubwrMCD?=
 =?us-ascii?Q?W5DWOiTY6ew+9smJ0g4Onvp5CAgDMXXMQwV8VBKj5XCit2f4TjLrkmanNFcf?=
 =?us-ascii?Q?VT5NdBUzintq4D+a1IGQ1UIGR/10AqHJUAYin75pLkdpVDMKo5xDzHj4JcYY?=
 =?us-ascii?Q?Rvr/Xsotoq/9LwsNNRLFvpfiM2SXrPgOX5MePovWbAwLE/tZjOljL9LRtV/C?=
 =?us-ascii?Q?NjT5vcZa9oM6RdNaG7pbzqH47pViTbPzEtEAZVIdeYI5PxCo1wZvAFr4iPV2?=
 =?us-ascii?Q?r03tewZULZX+P5g46/yxk+FtiNsxHNt5jEmK5++NWWfdRmI9MlUw44l5UXmx?=
 =?us-ascii?Q?ZVQzsx1ewAH+rHCi+ewgWWIuohmYira7ej/FsTsfMVDU0d1ATrjMG5bydJfo?=
 =?us-ascii?Q?qNwulxcnfiUib/CuxV4X9SkSz0+P54Mg0DGSAPb39DqFkm9UQva+gXXF5sy0?=
 =?us-ascii?Q?OPq7n+hiMTbVOfL2CeSKcPCQx6iGGFEjTS1BG+BY/uRkev2KyRRzueRQLdLN?=
 =?us-ascii?Q?jgslKTSLxw+fynF6T+HJPXoHADnlQ454y7vYKNnX45v6UGOQqtgp8i23KInl?=
 =?us-ascii?Q?Qmdg/bZNL1xVKbVRzdGolWAy5nBPikULJNk3b8+rJTXwTBdPVxN7oX0ZS/TE?=
 =?us-ascii?Q?2DSTbX6H5Dx3k1LQlx56gHEMT5aq+XgfGCddI6YsKfsei4k9+emcg5dSJ26B?=
 =?us-ascii?Q?YyxdBa+CWioqINYMjOJLw9LGgXi3EP3jiYhdnoH3M4haEg9lGwiap7TvFIPa?=
 =?us-ascii?Q?l1eC5a4w8SM/XWPwk5zLsZ2GnVS/i11pIjiUQDXLtM4YF6aagnNG5BQfer33?=
 =?us-ascii?Q?YEyS679C2FHPxyiYIosXtSIaL32wgOrzOAZ5N+GfVyrwqcBUKxwiZxUaou+j?=
 =?us-ascii?Q?fpVnocAAqxDo5ME0kXMKFC/cGYP8aof0+4qpwbT+1NqDev3MGybUhhktI7LN?=
 =?us-ascii?Q?8zJIqDKPWCsQkeJ5RtqZc4IadNwzxkT3167CvMBS4pRw17L23esmJOjrHq3X?=
 =?us-ascii?Q?qSeJF0ryy8z/zIqi58pq6KnQUfz4Tr23oaE0FUqdcklgAh27HvQWDotgjq7a?=
 =?us-ascii?Q?5h2IK6lohvmJtL9WO2zSb4+09YUevzhQ/MyIJ5YGUmugOQaEtCvrAmmUv5x/?=
 =?us-ascii?Q?aG7qb1ZV66dbdgZ56SDEOJaz3s2KBU9A2lgCVMoWN3B76gwfr/YMilaQ5qaw?=
 =?us-ascii?Q?lLEZaf01gLS3yCkn9a6OmAjTMHfmVQ0ugy3aHgcG16kc6K1qnOSTZJzyZJtO?=
 =?us-ascii?Q?GTY487MOQJWJlX1SICGihh2lUbX1nyKxC5D5awA1RSFguaUyNmYW?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: de821159-836c-4292-4d41-08de4e57217e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 01:42:06.4975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGh4HirHEt4Qs+B6ANFQ8g2juTQ/N6l8MyJJue++G/EY+Hpz96oMAvTKunJnwG6GcldRtJkOE1ayVurP5ltX1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5546

On Wed, Jan 07, 2026 at 03:27:28PM +0100, Niklas Cassel wrote:
> Hello Koichiro,
> 
> 
> I like this design way more, where you have a one-shot (all-or-nothing)
> submap programming to avoid leaving half-programmed BAR state.
> 
> 
> On Wed, Jan 07, 2026 at 01:13:58PM +0900, Koichiro Den wrote:
> > +/* Address Match Mode IB iATU mapping */
> > +static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
> > +				  const struct pci_epf_bar *epf_bar)
> > +{
> > +	struct pci_epf_bar_submap *submap = epf_bar->submap;
> > +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > +	enum pci_barno bar = epf_bar->barno;
> > +	struct device *dev = pci->dev;
> > +	u64 pci_addr, parent_bus_addr;
> > +	struct dw_pcie_ib_map *new;
> > +	u64 size, off, base;
> > +	unsigned long flags;
> > +	int free_win, ret;
> > +	unsigned int i;
> > +
> > +	if (!epf_bar->num_submap || !submap || !epf_bar->size)
> > +		return -EINVAL;
> > +
> > +	/* Work on a sorted copy */
> > +	struct pci_epf_bar_submap *smap __free(kfree) = kcalloc(
> > +				epf_bar->num_submap, sizeof(*smap), GFP_KERNEL);
> > +	if (!smap)
> > +		return -ENOMEM;
> > +
> > +	memcpy(smap, submap, epf_bar->num_submap * sizeof(*smap));
> > +	sort(smap, epf_bar->num_submap, sizeof(*smap),
> > +	     dw_pcie_ep_submap_offset_cmp, NULL);
> 
> My only comment is that:
> 
> Why not simply let dw_pcie_ep_validate_submap() return an error if the
> caller of dw_pcie_ep_set_bar() did not provide a submap with offsets in
> ascending order (i.e. sorted).
> 
> Performing an unconditional sort of the submap here looks a bit out of
> place, IMO.

There wasn't a strong reason to sort the submap here, it was just to make
things easier for callers. That said, given the one-shot (all-or-nothing)
design, the caller is expected to know the complete layout at the time of
invocation, so requring the submap to be sorted is not a strong constraint.

I'll respin this accordingly and send a v3. Thank you for the feedback.

Koichiro

> 
> 
> > +
> > +	ret = dw_pcie_ep_validate_submap(ep, smap, epf_bar->num_submap, epf_bar->size);
> > +	if (ret)
> > +		return ret;
> 
> 
> Kind regards,
> Niklas

