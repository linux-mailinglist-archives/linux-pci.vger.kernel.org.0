Return-Path: <linux-pci+bounces-11211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C3946497
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 22:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166381F21FD7
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2024 20:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0AF1ABEA7;
	Fri,  2 Aug 2024 20:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="epaS/Kt/"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A81ABEBA;
	Fri,  2 Aug 2024 20:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722631625; cv=fail; b=IdhbmzLsHYklOW5gYp7Euoy75RVX9VoMa7jxdRe6nNC0fxSNiY8+QJu7ErVq3ONDm4xP6V428MrIrlBqcQtTmV50MFrSgsN/ZNGxWtpwtEZ94fs38YpWEGcskgKPsLY3nRlNkvWcaYYJbASCK4kW8c+exV2mx89wDjRnrxYJv7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722631625; c=relaxed/simple;
	bh=f2hB6UIpScnxoEB283HRzv6LuyhrV+nOh5oP5LtEoGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lcGPdWoq5sfcfHqdoevHmjUsp3LaRDntAprxrUl570esm7uzZaZp990Sg3bD4g9YMEWEOZHIxFAiHpQq72eedpHd7Tv+u+QcWca2rh67c5tJEvsKAbzGGY9pTHY97MHkJxD72Iy8OXOX9ZNSpzUoaL8aMakcVDrtr583hxhI7tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=epaS/Kt/; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlX5Lm8qeFRh3l4w1q0JS9x2i/G2Vor4mdO+mCl9DZFkXo4ebRnh3coD/jbNo0WJP8Wc4QnFPLzJMaKqYk+W1Cm3MH4O3alXPtpZFt+UsgWelOF4lYdA+Z+aXEmN9rQiKEO8HtuRavUkD3lEeCDCH3edWVMbt/U4W43x08OFWNfHYzoOPJK3/bsuss/m9ZBIhc/e7UYHHk+eMKy+zJ5e6G/vWcZchR1z3PjRYpvIv9b/gKgdKZjqEalHWiuBX+0XH8opMn5KOxRZoLQ2whDDyTtjuTj/9unC1D16W1BtQMDkammOzkJeb8cOER2vajkJTcSfmXoPx77Ha6MhsHaMyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brtn7LYV1DCGI7Wpgc9liUG1dxwGcpjqkxx3bRoVGYs=;
 b=Vl1MeKO4yd4kfp7nROH+fQx8saJqgW73SkEf9VhB4YMn4Be61l4f3fJbNHLgMiwrcz9261pgqkjykPkVWSXmOvsARMhM/tsDwhyzBWVYqZsU6j3HUcFGE7J+cmBSa1FRiknFtR2XZSXxojpR4IGNm9KodiSwI94fbwtK0zXk+CULaNMMoomXLM7OviBcXTYurIGbd1ey0D+J+DBRPoi3lLOmM4kzG5IJx4gNouCTcW+0bMFcMQeGYZZ2mOi0iJZtFPGcFmxkenKZxWOxw2druNsbJcn2yLGzSHUphH8YK/t9xHv2FRvxcYGZo8ULTT5BXqpFtZF7ZjQiwOpMbyLzdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brtn7LYV1DCGI7Wpgc9liUG1dxwGcpjqkxx3bRoVGYs=;
 b=epaS/Kt/QlXx1DvccTd0ctIOA/RVPG6M/bLoT/VvNJBwnS1P/674QNXp2YFYkj0+AFrFqZOUcFRFEL3N4QHbpl0zjtup4dp54zEXlEhb2Z7QP8+D5ugK1vW2RvpxIHwsk+nsf03kH1L5S8ijnzAGnpOvfTf5CjXIzVTmYBVxad0DYmkRmKPVKkUsunPoSXt1PSKvpQxx4QTmwkJMLCnw5DNmY7qSodJ13bOa3YXDiJeIyTukqf5rAgKn2x7kNccflEhGJNp06PEpOO16GOdBbQNcn+Eh1o9yXufxb/sE4V8irymNLueUUjXoWJ+2FjOu6IaNzNdpF1Fa83xYyvrl0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8425.eurprd04.prod.outlook.com (2603:10a6:102:1c7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 20:47:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.7828.021; Fri, 2 Aug 2024
 20:47:00 +0000
Date: Fri, 2 Aug 2024 16:46:52 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	shawnguo@kernel.org, l.stach@pengutronix.de,
	devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel@pengutronix.de, imx@lists.linux.dev
Subject: Re: [PATCH v5 5/5] ata: ahci_imx: Correct the email address
Message-ID: <Zq1FvJvxYcFt4lyc@lizhi-Precision-Tower-5810>
References: <1722581213-15221-1-git-send-email-hongxing.zhu@nxp.com>
 <1722581213-15221-6-git-send-email-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1722581213-15221-6-git-send-email-hongxing.zhu@nxp.com>
X-ClientProxiedBy: SJ0P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: bb1be2af-2fc1-41fb-f692-08dcb3344187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?52yP5M2uOX/THGSIOzqAo+Ku9396YS0MyAm+tEu9V1/pAxuz+EDWrZEc2C/6?=
 =?us-ascii?Q?zaw6gbbrhMT5+qTMlZ3nQFpEkQmtPo1FoZX5BVW81oYAU7KyDycapxdtd6dh?=
 =?us-ascii?Q?MKrxKx0w2Q6I3yWkEharuqLGaxAr3qHPw2wFvI8DHMwHkFjQiS277hxiGhVf?=
 =?us-ascii?Q?M/6Vj33D8MY5AZ6gNvoQB3SXkN91iPN8Fd63yd4pFKKMU1t6r+sViGjq613o?=
 =?us-ascii?Q?QjkKlaQtAn9CZdTpR5XuQcB2VO1eAsvupXi0VWRO2tT1GZdqQVzkIyfQ758P?=
 =?us-ascii?Q?DARMF1RCSFFBHFavWoZRg+BomLixqEgpabC6cmhZeJpmTnWxPB7ighAhzvig?=
 =?us-ascii?Q?Lb3t1u5Tvh1r1Tz3PE5iIwDjB1L4aotahCdmdLKOSg93ZZHQoDwmJ7BDHVh1?=
 =?us-ascii?Q?4Wl0/eC7sa820Oy4Vl5Vyndmel/BBMGpC7vC4ArT16zo/xzULHPf1G4VB1M9?=
 =?us-ascii?Q?LxDZGeI48ejSwulJ89Guq5AT9wdyqM+ZcbvGAHkjsoJNNPoB3GWqW6JOE9tz?=
 =?us-ascii?Q?XtCua3iIGHO76OiCA0IJ0IgWnZTcVxH+OQm3+8LIrgUWBVWNRbRVP6oAwA2y?=
 =?us-ascii?Q?zGS39DM4MPP9RFeqiCHIagw/GV1jTvYxDz2a9CNGxQrcx/54JSd/iI39iVOC?=
 =?us-ascii?Q?CU9lXGJ8YkXb41BO78JgZJyCwMnBMfYioQKVljft0VZ0Wq+rBicHsMN5kPGK?=
 =?us-ascii?Q?ut4wLs05QFqo26TXV+D8JSPmNTQACu9mPajR+VBKaatthuX45MGglUqNz6ue?=
 =?us-ascii?Q?rELNvNrf55/8mYyW5yTPBJ1Y21DUXHbh7Ovdp4xRPItedajnLAynBkfBCVcK?=
 =?us-ascii?Q?InMsmZ9xb64VClKhacSy2vnzalSBh3tydC+Tmj6qf7rX4u2csUYAHVzhgt35?=
 =?us-ascii?Q?5E0VFrIue1XQ5urN9wVL5k8S59o9fseObjefzxbLslFeEXXIlGVJL9Q6Hr5C?=
 =?us-ascii?Q?CINqoWKnqsBuR7YZygNZE3riTpMB2CNt0lF7OK8OY29Zpl1LkrT0YNhMAdhY?=
 =?us-ascii?Q?HMg5BjOUylLj53oFS1pWvYxyyq2PIHh4NlHRaGD1F7QxpGj+FPj7HEUBrxxO?=
 =?us-ascii?Q?a/SwSfWotRVdQ4TpfpCPg7LlUUMe2CfzGnz05v9z7EZqRXegHjGLkJUl4MF5?=
 =?us-ascii?Q?obg6W1LjmUJ++9k4LO6o+ybrMsN6htUK6cUbeZC0tSmiFxUamdLHWuZOM51n?=
 =?us-ascii?Q?r2n3KNRIFqDNv74goU6VLrBNcvewV/w6wKqkwSJqR7OCVPSUn7Qj0EaiOKU+?=
 =?us-ascii?Q?+dFw7c+ScwBTz/KUPGfJIMI6N97ZOpWhUbHLjkjZk2hpFMc4GerNH0mk2GqX?=
 =?us-ascii?Q?dBhEJRhyCdW8vV4op2S+RT8j7sTfA05GLSHM1JDT0sW3H+8eLJ+lEGoTOT9E?=
 =?us-ascii?Q?OOa7xQTGsmhYONrRDZr/5E01qeFM+wXArQkuvm/vlgC8ushxEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g3eRJddUFfKxDFwOlSIxNVI9Gw2/22FZjrhBcTa8qmLrxBR+DzUalRbEseMs?=
 =?us-ascii?Q?SG8cxpRRTfic4zYgVJ069b6EifABVZ7sautuDDBDc87f0FfstHoxB0zJeQEu?=
 =?us-ascii?Q?m5vp3QTGw8e3/W0wPnu7NmAp74DYMtWnx5QPzWfWhg1srQLHnY3CIFZzai+B?=
 =?us-ascii?Q?X3BCaIsO4a+UdgY0S6OG+Q1vPPGHQMsoZD9xj5ZU9B4WkbrjerK3w51sb75M?=
 =?us-ascii?Q?7DC9BkHn7JONZPsNoUaPzxrN+ZaLpCGEJWfmxf3iAahpZEl7Ow3wQtFC3XhA?=
 =?us-ascii?Q?p4u91dL9jMAXObKPJ4ntdXUAbavTjQVT149Q5+pSbP0CMcgB+3OaUYCIbv+4?=
 =?us-ascii?Q?gzESQzMVQQPt5Phh5mV+vbyiuWBhWXJdr8tgY6/W1syayie4BSGxMXUjZF2G?=
 =?us-ascii?Q?mluFMzuFvytdsrC3eP93BcetIpZuyz49a44g4EXxm5QqDC1IJwOlgZup4tRv?=
 =?us-ascii?Q?iibZQcUuJYdNPJCYTcG1Uc8NFSjw7oKVJGND2T40uVIfJKfYM63L2ehR7sVP?=
 =?us-ascii?Q?nynN3jlNQIcB5MCElTLuK6Mvjkd5hrtnexFWvMS64CDXXHXAlGy+uuryW+tN?=
 =?us-ascii?Q?9uBUorMRRBgWpY3iHhO5JtkySbk40DhsMP+FELKCUKB3NZwgMu6gKJbATv5M?=
 =?us-ascii?Q?AoUAFsTFHOBMdncyddSVryyWtKK/10zl8O1mtvk7uj0w54vMQeO3TmsKelMZ?=
 =?us-ascii?Q?OkzL5nsjr2K4wABzrAkZ896WOAyAVqqJF5esf65Fy6hHjepCoVyDq/7gIShH?=
 =?us-ascii?Q?F303k631g1NaB2ZfNC2SKB0OoNW10uQDz7m1p+HKKkAKZ5+HmQOAilVpDfJ1?=
 =?us-ascii?Q?aOasNGzk9t2pkGKt1LwrCXl7ZUX36nu0Uf86vdLEwyFGKdlx4lzULRLOIn5J?=
 =?us-ascii?Q?OEdACNGMEg41/rcvqF/5gIltaD1tNBgcsa7yzNT09q1prHTgD0rGURaVXBgQ?=
 =?us-ascii?Q?3kGRv2Q0pXSG47CLHRPOV+6IumJ0iT1SCNQ9HuD5rmy7URKIJKmSWgg5knQt?=
 =?us-ascii?Q?0R9OXlDqYV0hz35s6XgscTuvpaPgz8yWrHymP1zV8qUJ+/g48Qu3Uij81GnT?=
 =?us-ascii?Q?o08QBUkbVZV3ni6UeG7BdXI/At7d7P1PCqpx4dALMTuR4ynOh9U60TdiHsju?=
 =?us-ascii?Q?x6eGkjb9K8ZidBI3dwjKyj0nKWh1kVymJisgOb8RjiVLQb6dwuJY9gJ5h10z?=
 =?us-ascii?Q?kFpbvYvEzvAqYHaRBBi2pxuL9zLw5oQoT5bau/mbFQ5AuFrq+/U4Or/xwWF2?=
 =?us-ascii?Q?BqUS2TO8lVRrHpIFu+iI0/ArkUe6RCWbZRPR1yavFN9ieQJver+nGwDNQS7G?=
 =?us-ascii?Q?OpYW8WUEOQ5gU69vvBoA6WjGsi3r4AqLmDMZMvRdUsqwi3wDmQcwQlUJ3Mqc?=
 =?us-ascii?Q?Zn1vNjkxbJ4mXnrn72XpChFAi60TuDCAZV/IR6tGLKbh5fq9K1NjbVj4pOO/?=
 =?us-ascii?Q?YEgCuyytkdiYZfo0sNr0nMi9fxhkl64kC/hoF3CEdv9vI82pKB+25vu0XNLH?=
 =?us-ascii?Q?oiPEjG1Hn3Y18AxWlI2NbVqcVFRlYtObVwS4U6gEOX4gwOU+IMdm3r/3Nlcq?=
 =?us-ascii?Q?KCMp5sswpoeYrNvRi4N4BvnU9+/aYpLOBcLQ1i6E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1be2af-2fc1-41fb-f692-08dcb3344187
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 20:46:59.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CRcIecTgy0FmvNJMtrZ06d0hH8zzyltXzkJWh43v1EHTy3cqD+teucpNuuOqi3fauPulGcLoHmc+3e9/EZJ8DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8425

On Fri, Aug 02, 2024 at 02:46:53PM +0800, Richard Zhu wrote:
> Correct the email address of driver author.
>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/ata/ahci_imx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ata/ahci_imx.c b/drivers/ata/ahci_imx.c
> index 627b36cc4b5c1..65f98e8fdf07b 100644
> --- a/drivers/ata/ahci_imx.c
> +++ b/drivers/ata/ahci_imx.c
> @@ -1036,6 +1036,6 @@ static struct platform_driver imx_ahci_driver = {
>  module_platform_driver(imx_ahci_driver);
>
>  MODULE_DESCRIPTION("Freescale i.MX AHCI SATA platform driver");
> -MODULE_AUTHOR("Richard Zhu <Hong-Xing.Zhu@freescale.com>");
> +MODULE_AUTHOR("Richard Zhu <hongxing.zhu@nxp.com>");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:" DRV_NAME);
> --
> 2.37.1
>

