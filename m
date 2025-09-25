Return-Path: <linux-pci+bounces-36991-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B12BA087B
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 18:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6DE5D4E11A6
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35AF2E6CC4;
	Thu, 25 Sep 2025 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i+DWzjws"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012062.outbound.protection.outlook.com [52.101.66.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387902F2611;
	Thu, 25 Sep 2025 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816201; cv=fail; b=Vlla8WOVKutoHb6wTSAvNtMsLlBhW8YlWRKTAf/neDcCfefZhOAFOznUxMZJ3vnFvY1Y932SNyJu/LBdQsSvWOiW5UmpEwP0U5QEXsQ2D9n7VOgWW0l/HekeFQYPsfAEgWoNiMRgTXkGLsY7NheoRySHxE7oHix+Fz5TmbOmX6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816201; c=relaxed/simple;
	bh=1UQqXrwiKj2g+7GoWENzacaSddccxVHZ9M0enf6LuE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QyMRz+9pyASa/P3SK7eOp5T3wPSVlPO0v/yG/ro9s/nDn3H7xVet0n49fffd2xeaoRkjCuJYNulahWU4cYot8AQI12Rk2KUz/Xmb8V972hn1mtKqx3OfmTVzfWgwSUYtffCON8MbKEO4gBAQ1V1nmV6C0kehnj9iqxIjTsZIdEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i+DWzjws; arc=fail smtp.client-ip=52.101.66.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/reJlgDZaIQBnnX+jP/qI0VYh5ZrqHosKVCiFTATUxVJpJlFzwVrw4BdE6I/428wMVM4w4KSI+cN47lWbtD2E1gVIjPCdfgdo/SpPpfFPPldR/+5sT5Dea4XcNQunHCT16BMTH5CHubH7ckCVNtBvjkgmluzmYvZC63huC8jyEEj8ZPKOB0P/Kb5Cj49XHybOw2nDle1dZJImaF+qHOV5y8LwX8hbW2Xp4P5j5Vpidl7fc9f6MX38sQJ7qDh5+AbUEC5hBF+ggt3V55l/nSNrnkJfu4fg0lExHEON6mwJU7Rabgd1D4aux2VDKHwreLlPc6u5bUPEEsWCVn9mXS1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhAbCiZ/ikC6sh+U+RbjO5np6yy3nTlP2+tQ8lnET0o=;
 b=dnaAU+WQ/x1DPpp6CTJ8JaCMSnA9sjLgKYp/QxmRmr7Z4zLnKv1f47kWA5dPlB5wOAxj3kJyG2KDmdqlZ3sKNV9+osIhGisspSFqiSGOBS2T+nbuPGfUWwhXTKrtO+hNC8h/8wqwqdTOChvgesLf+2sxlPpPWxk1vHD0//Qz2wlzvv33dbQjWKP85IFhOx0lqrafgYLTKtePald9sx26bQrxp8N1TTDBWvWoF5pxThA/FGPn+D+0hei6a+nOK7tif1WMhfUb6sh/OuGNi6NYfvmchS7ZyBR/XnkKJIpxvoJTiSVggGPNiupdt+APmWR+LzoMDTbadIwPrFF5nVrqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhAbCiZ/ikC6sh+U+RbjO5np6yy3nTlP2+tQ8lnET0o=;
 b=i+DWzjws0y4BRbBjcH81Pfv8GLbbXf0sGXuxRcKQ8TUUELd8Ob+lO9AbJTT5bIGj3n4vw5ODeU3XXhBBktUEW+pAiElbpgmXEEBKFhQYZ93PYdgAJ6Lg15Pcli3jLVGnow/7EbVnTHIP+vWk6oBXZdK/oYIF8avrc5Mcnsur+rSISmGWNCzxF9hib51uz1v1KQ72ogSg4V7UqYG3ubygVPgu7nPygzynbHAc1HulOcGvq/uT4wJtCfkG/FufsMJZo4hfnNbCB2sJoQ0LTA2yIKwLG466Q7SdLfLKVY4Szv8t4snO6ToapaPd2MkCJdOtp8oU6hFsi9iPvz8itvWO6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB9517.eurprd04.prod.outlook.com (2603:10a6:102:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 16:03:16 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 16:03:16 +0000
Date: Thu, 25 Sep 2025 12:03:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, jingoohan1@gmail.com,
	l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6 1/4] PCI: dwc: Remove the L1SS check before putting
 the link into L2
Message-ID: <aNVnvdiIs+MBZOEa@lizhi-Precision-Tower-5810>
References: <aNRbn+bZ8MP77sdh@lizhi-Precision-Tower-5810>
 <20250924220605.GA2136377@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924220605.GA2136377@bhelgaas>
X-ClientProxiedBy: AS4P192CA0008.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB9517:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad83a72-d1ff-4f20-8358-08ddfc4d0962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lN4z5BSN9OPRT8kEG7W62/uaB/SHexUNygjNb482u38ILPGfySRDJmCfoJa6?=
 =?us-ascii?Q?CeAza7OnhVSFGzrt3fhJkWQmnzxgqE7X96/YX93Z1SLmnYJWfSxp17unUmbN?=
 =?us-ascii?Q?x7+KhjUrR910fdbxtyF/RXBjzd/HUrhKJOsWAB5broDXjAzZv/Oy8v0h6knz?=
 =?us-ascii?Q?icSYZcRYPJJkmX1xOkD8iDvClWpdA/mGgRfZnH0l5ZyW6+GyJ+L48aUIaN3A?=
 =?us-ascii?Q?2v8lh0BnMf6j4vlm+8WloOmf9v9lXtIQWZi0Nbi8jrLaMUZ/qwsr1+d6crp8?=
 =?us-ascii?Q?Bc9xCVthJiFhtyICyujKwvJNbBcAgGw4oUm1103oH6ADDQaCxrxaLHed7M+u?=
 =?us-ascii?Q?Qgt7fnnDRehAT4E+NKi/IZdrisp6cpdjpNFfhv/ppUa4MPc4BE0F5v8vSmL8?=
 =?us-ascii?Q?R6+gfYlR0JBrwCjHjSWqUpSUegz8ErlblwNZP+6EwOT/YetJhR91GHVeKxRZ?=
 =?us-ascii?Q?uUhuDw8O34bu/xNc0RwtASSrZmcdo7jejt5aCERBWb1NrhDnAIu8L1miCXNT?=
 =?us-ascii?Q?uXIBS9QLvwjVEcZEz+EgzbgAdrRkieA7bB8uBNVwuEOHNzAMubeH/17Jz1Cg?=
 =?us-ascii?Q?DvXoJiA7SCfgjoq3qpM2s3Q75V8bF6n0MQQ7W62e8MzliYbhgNR15I5xymy6?=
 =?us-ascii?Q?uVuiRekAxKaj4N/aKVLs0CjVjs3jDNBFzUXgUEC6HFJt/bryFQqwiO4xC0NT?=
 =?us-ascii?Q?HRJFQbrZ7wYMzCyMxF0hCu0adS8Xk+hcoWLROwmipyXTHSnt5umkbnM2AOkG?=
 =?us-ascii?Q?2hXtAAWk3FHgCOTY7aP7iBYJlDpM8KJSqg4MYVZtcNYpgr/pl2olpuwY7eFC?=
 =?us-ascii?Q?2HvpmdaoFsVrnDE+YyFr2qDaL1YcHvkDmW1G63AuCE4YSjpskCqlszAPnDzQ?=
 =?us-ascii?Q?0HVEBKcPq1/ZR4McgUkVuwWPSpwKuqVBakPwj2NVbL9ydjCtkqK3Kz/P7bOv?=
 =?us-ascii?Q?+bNryyC87FZzrHr41ImyJ5+iv9f/iVShja8Qabtyxe1XAPVyy4DGbcgv9FST?=
 =?us-ascii?Q?c1kiOZh5boRUJ9LyubeSlRegzijEBms/6usdRzQB6ain7ILOKz8dYvl1BgPQ?=
 =?us-ascii?Q?/NtPN6JubD94NnldzpOsauUhplgVFz2XgtjE+1sESK6KGCwBmZLXWTA6aBCC?=
 =?us-ascii?Q?saGHHo9LeSyfi8JXZafLXpIDKYa+P7+6Xb0GCiRDW5T5d5uV8NDuSBJSII/Q?=
 =?us-ascii?Q?Oh98RwN0CcXxAgyhxzrHLQO/nRhJbC+xdEV6jKIr64Bke+9iWrVXtwxG9WKG?=
 =?us-ascii?Q?Gb8/HQ7Q4vD3EIq7jqZGvdD0mNGfCQ6hHPkv2ap7Kq9rnFmDtOxEOT1OM4LX?=
 =?us-ascii?Q?Vo9mZPd3b+a5UzWpwal81cSlY9IuH6QBK50Sa3BEu62kFoy4l5DDvGRkje7V?=
 =?us-ascii?Q?bayIvXto2qj5n3ZPIWAISt3ZSpm9UIaYD3c7qOGOjNXmvwzXCYFwgSffrssP?=
 =?us-ascii?Q?GZRPvZc7x3ZPCvgDE1Rj7P/BkZYN8H+0CumOAQHAE+FmarXMd0SQRVEzCcWZ?=
 =?us-ascii?Q?KxRuDDiJcbJFqrg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X7ow/zHZI0Tn223cgI2e8pDlYKn5L0KP5vVbULhdGxLiwhV6CqpWsaUuxWod?=
 =?us-ascii?Q?CFN+NJXf9oc0bxVXuMbWhzCPz3em8rcjBgU7RGVNpOAQSvTpQGxT+bH54ku1?=
 =?us-ascii?Q?Xx9MbNG71U11DZUKHtmHGp7E8tbNnPzCYladG/HakiFy7Xkr0GJYsfj04b6n?=
 =?us-ascii?Q?OOSeN1yDPXSnSPmh8PJxtp1G/i1Z+FkrHwWZ3BFMrAOMU+vpB3slzEgVpd5A?=
 =?us-ascii?Q?8lJ5iilhWJ1FD9/gASRGR10GioaIxmTNoFtMjfhBrAjj9Mfupqbx6J+UBnT8?=
 =?us-ascii?Q?Y9Dz8HUjJeYJAmJkEUEFIDIrT0IO6gh04Sp7pebyiVTKQBwYccKAj6evQwPh?=
 =?us-ascii?Q?KCXS4FiouD9N05BpHjd7luUlQrRG178lcblsIyVHy3GEf9balTMOZ+cxwcAa?=
 =?us-ascii?Q?oA7XZBjOjhQ6YHREJEdd5J3Al/swW/wY6WXuIHUPOIZfQdWdTuX1/9JI1s7M?=
 =?us-ascii?Q?WrazW2I7cEZ7Nc9FmKq307Chv4FhKxzQDp0xL/8Tnsscm4WfVuWPRdHr3Chq?=
 =?us-ascii?Q?/m48Rj9kqWRTeu+F9yOx6Xnf/0Q7NNu0jJSwa6d4ub93UiOBEs6Hd6Fb1tSR?=
 =?us-ascii?Q?3unjQQ1q72QdocJTupJJpGCX0phFDSXHAvfEnUN5w3xid85dYGcLObyoxgTY?=
 =?us-ascii?Q?0Amygxdvtgq+mSnj/nyOJk+lqHE1LT8+MozVckmRitzTq/8TIWMVuAxYcUZc?=
 =?us-ascii?Q?aBld8i186yDnrMGPWRBiFl29PwyM63fSl7DFpcpeCx85FweDBG+r9EDB4fCB?=
 =?us-ascii?Q?QUdS9OkBkivYrLSrP99t24Koy6RiJmER6+YkHbR6CkueI6/0C0uHpUfSFEVf?=
 =?us-ascii?Q?hHR6zfKJeyvxV5QriLLQsQbFVeD+kgIuBcowt/fNcSuu9B/5jFepQu1bjCiU?=
 =?us-ascii?Q?HUPKqLBuZvo/SgSVII+x4Yi9nvGKhbKUFxeORFl+5CQ8xi72J37+RhhHSzy2?=
 =?us-ascii?Q?SztksObHUJ0xa5rMW1djPgHlNCUjJEXTnk8UitbYkXjcIpVMkTwHFOeJ1H81?=
 =?us-ascii?Q?7YA+0A2XHbTpl8/+MBjsK7yM4AkKlI1hRUa4EI+wisu8xa1DkypW0IRZSoJT?=
 =?us-ascii?Q?Cp+IbD857lD4DKcjNPO/Q5HIeJnSANElWnJl6CaoTikK3QJ89JeK+k4vlKAQ?=
 =?us-ascii?Q?D7MT8p3F8ab4rt2b3Um3hSruNBL7oY2q90K1c6cqFa3oH0pwb4VrFlZOTtWS?=
 =?us-ascii?Q?jfg6vwAwT+X16t9D/fkizd0Jn+bWYrukipg9ShBKSvwSApN4JlKxg55/IYcI?=
 =?us-ascii?Q?O3Qxgg2zKArrK0O2EbQMYGwFnP8UFhwr8Yfjb/G9bjFAn0OS98gX442SH4OR?=
 =?us-ascii?Q?KfVMXNF87G6VCJLCu7Az8PLYMrv70KRdbgMtpEaZRRMzLG83ykJJ9WsvFOux?=
 =?us-ascii?Q?1djsI5965UP0Vh0zpnk8uG3Ipzj9xsl6LoFwjbnROcoCLxq+uDUt+tGH1daS?=
 =?us-ascii?Q?UQnmPPXEM5DPRthfKKmVxkfe46pmpfLJSGE3KB2IYzDNANYSwyao28lKTDBq?=
 =?us-ascii?Q?oqU8ub541JlT4vtl6dml8Ohhgp3hbJrxr8tdyXEpaamy41fqynmBUSs0S6Ww?=
 =?us-ascii?Q?5urUBsLMD5UGQjSEG4LwpENLkEgUYfA0jBDI4oow?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad83a72-d1ff-4f20-8358-08ddfc4d0962
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 16:03:15.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xOv8Fz06YLWrwNQ1SLdaHScD4xnNqBilPqTB16jSSMFGGjLMdbKV2eK8gQX8SAXVUuXGa+DUT2OF3Q+PbSLAWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9517

On Wed, Sep 24, 2025 at 05:06:05PM -0500, Bjorn Helgaas wrote:
> On Wed, Sep 24, 2025 at 04:59:11PM -0400, Frank Li wrote:
> > On Wed, Sep 24, 2025 at 02:44:57PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Sep 24, 2025 at 03:23:21PM +0800, Richard Zhu wrote:
> > > > The ASPM configuration shouldn't leak out here. Remove the L1SS check
> > > > during L2 entry.
> > >
> > > I'm all in favor of removing this code if possible, but we need to
> > > explain why this is safe.  The L1SS check was added for some reason,
> > > and we need to explain why that reason doesn't apply.
> >
> > That's original discussion
> > https://lore.kernel.org/linux-pci/20230720160738.GC48270@thinkpad/
> >
> > "To be precise, NVMe driver will shutdown the device if there is no
> > ASPM support and keep it in low power mode otherwise (there are
> > other cases as well but we do not need to worry).
> >
> > But here you are not checking for ASPM state in the suspend path,
> > and just forcing the link to be in L2/L3 (thereby D3Cold) even
> > though NVMe driver may expect it to be in low power state like
> > ASPM/APST.
> >
> > So you should only put the link to L2/L3 if there is no ASPM
> > support. Otherwise, you'll ending up with bug reports when users
> > connect NVMe to it.
> >
> > - Mani"
>
> Whatever the reasoning is, it needs to be in the commit log.  The
> above might be leading to the reasoning, but it would need a lot more
> dots to be connected to be persuasive.
>
> If NVMe is making assumptions about the ASPM configuration, there
> needs to be some generic way to keep track of that.  E.g., if NVMe
> doesn't work correctly with some ASPM states, maybe it shouldn't
> advertise support for those states.  Hacking up every host controller
> driver doesn't seem like a viable approach.

Manivannan Sadhasivam:

	Does above situation still exist at current kernel?

Frank

>
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
> > > > Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> > > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-designware-host.c | 8 --------
> > > >  1 file changed, 8 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > index 952f8594b501..9d46d1f0334b 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > > > @@ -1005,17 +1005,9 @@ static int dw_pcie_pme_turn_off(struct dw_pcie *pci)
> > > >
> > > >  int dw_pcie_suspend_noirq(struct dw_pcie *pci)
> > > >  {
> > > > -	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> > > >  	u32 val;
> > > >  	int ret;
> > > >
> > > > -	/*
> > > > -	 * If L1SS is supported, then do not put the link into L2 as some
> > > > -	 * devices such as NVMe expect low resume latency.
> > > > -	 */
> > > > -	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
> > > > -		return 0;
> > > > -
> > > >  	if (pci->pp.ops->pme_turn_off) {
> > > >  		pci->pp.ops->pme_turn_off(&pci->pp);
> > > >  	} else {
> > > > --
> > > > 2.37.1
> > > >

