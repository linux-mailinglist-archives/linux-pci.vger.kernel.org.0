Return-Path: <linux-pci+bounces-4972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A5D885D54
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 17:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250C9281A48
	for <lists+linux-pci@lfdr.de>; Thu, 21 Mar 2024 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ABB12CD86;
	Thu, 21 Mar 2024 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TNbg7/GQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4012CD8A;
	Thu, 21 Mar 2024 16:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038113; cv=fail; b=nbMq2N+htKeAjXZ1mM0GLMy2KaSKHJKhfyufbrNoDAiMCLPGHPLR77XwvG+eBWaj8ha8HoDcYdNUie1HsHb4ryixC600zv1Xo3US+n8/rxsKmhkcTU2qkK3rWndham67gQEqUUF2qvtqQulMJCHKeySV6HEFb0WYrAVrzgtZfNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038113; c=relaxed/simple;
	bh=mTZ3CfE1IOB7vebwBgvXfb5P0IRa/Jj6Qh2FGXVwCYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dW1wubRBN95tL0PQpb/VQNTuJ+4AVQE62GKv+UTa1yO+bayqnTnCReGiTU2GXhfYTrxN+umar78Osyc1LZW3XiHPig+lIVPfnp5Ms36DJ/D2ejn8qdUFoczlLOsZOdkWXEsD1fLgaGGh4xjq6inghg9DcE42DduWWJ7IBLtq9wA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TNbg7/GQ; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvrvbPS0m35b9nUwThVpOTWW/ZyF0nnTccfZltbJmLFrRIgGP3Y/UfkFA6G8hK17Url1teqbFOWYih+PKLGVftKORzDmZ5vcl6MWAoH3hW7SrOrJtsk7aRUSzy8sa0qzC8iLlRjkGqSvp9Qrl1KS50vjl8LoxOlDSaSbxAWTs6hdQQa2zHPVw/XOUVqv0grILmF6bK3tAzXGLySfB/CxuYuc7Sh2jAAmEJuLtNN8jEkQ/j7VOcngkJQR9A8UrK+cDv37uXvKE8nyzgi34OnfZfnsv8KXgRMWjWKReIW1hcci/0BeCWZdZZlEeB2Dq5xlUc/iCB7FlbvtR2sVJwE+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I11FkQrsKETG1XnosOsP4PYEkWF/VAkOGuMKVDda+lA=;
 b=mf5Btkj3dvTxqHLvd5DsNlge5GPqu6Pnqj7vmsgT98v+CSA94ZvBZZ5+GDyOzUZflS0txK/50MB2BHK5NbC9vZWh8HKh7SNRVwlkHWdHCAJtEoAzlgwg/UCN4KP9QPDJpvLqy2RlzeWAsIodaEU1jYZxT2bsHLh1IxPDNr/lIdco2gaHCZJSqwCyig1V06J6l4Seir5NmVkuhCuyZmkoyhaRyOTKuCpM/cz+Wmm62Y0oaI/AlNXU59KoFXMSAhDlQ9JXcwFahCkUTEQ1wuOWaVbNO2lXeIePJq9ZockCxTs+0q8z+tkeW1DZMHNAAZZdpYDXzatKajOcWCI6d6LBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I11FkQrsKETG1XnosOsP4PYEkWF/VAkOGuMKVDda+lA=;
 b=TNbg7/GQDqlJsTN7Swb7H27De/Wm6YN7rVXdLSD3+dFXcWhQDuhNKKlZ9fqjbQEb7hZNjXnSWHhcwMl/pgGYMnXxQcVUt/a5RHNzVPyfjVGYyxx+CzO078haB/NN7Uua11wrn8W9uLaXVncRgBfqdt5hL5kVqKbiGblre4avF5E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB9002.eurprd04.prod.outlook.com (2603:10a6:20b:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Thu, 21 Mar
 2024 16:21:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 16:21:47 +0000
Date: Thu, 21 Mar 2024 12:21:37 -0400
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: mani@kernel.org, kw@linux.com, niklas.cassel@wdc.com,
	bhelgaas@google.com, gustavo.pimentel@synopsys.com,
	imx@lists.linux.dev, jdmason@kudzu.us, jingoohan1@gmail.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	lpieralisi@kernel.org, robh@kernel.org
Subject: Re: [PATCH v2 1/1] PCI: dwc: Fix index 0 incorrectly being
 interpreted as a free ATU slot
Message-ID: <ZfxekaNkAqldGKLD@lizhi-Precision-Tower-5810>
References: <20240304224616.1238966-1-Frank.Li@nxp.com>
 <ZfGJUDoGnFXKBoG0@ryzen>
 <Zfqj-mvpG442eyt2@ryzen>
 <Zfry1kaYgg2OBvQL@lizhi-Precision-Tower-5810>
 <Zfvs-AHcuH2k9x7w@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zfvs-AHcuH2k9x7w@ryzen>
X-ClientProxiedBy: SJ0PR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:332::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB9002:EE_
X-MS-Office365-Filtering-Correlation-Id: 08943564-b13f-4db9-58f8-08dc49c300d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LYTMCjn4WHbRUXaNi5liIlC7SYaMBYzPlzUWuS+R+8HSt8ifG4YQ5Ge32LFqMgsStNff9BzV0Ao5X5GrlmmT3WW8I4q7NdWb4vLX9Fai+P4CBPvb0B25ZL76D9pszbvd4n3HbFWae2sx5n9IeBAzqsvFjGUspT6UK/WbQidqFutg3q2pHb3goup4Z/IGykQLvxSy/0Pfs4hQpVBuScq4AKBj9U8vRBNu3NGrlPdrgyIE+HycF71qJVEEyYfXy9Jx6m3IT8CxOlB1bXNHAXHzWC9owjAetVPsWPLtP1/piMZ0pqgYokJvYjg5skpUv95FBvpwKvjAYSLz7QTSJb1uvi9l3Ha5ZcGcax7Aa7HROgNaKzhOeyGXcX6+vfUv1BlpALBx+TfpEry0XrC7fGbxbeTG+a1CDYffOFiitD/HwdljuzmvEAqC/0RCH0PNNA93Jdm2WUM+RPIHJyywz7KIxcBDn2h00d5Ti2jlySBm56WHrTUORF3GHF8qwCPKOYk4OKWT0bW/0fe58rZVLsSwV/gx0eGgsNdHpiWmaOFGu5o+uUHPn3RJqKFJ7rnX2DiCCyh3dhFqUIH+0WA2wlVOD/oOjc/gFkmb4SJuM6sMb/O7fg8cV/ONNl30v8dfDu8xyEbEDaWyoGF4tGWgUyXXlKX+8suR+qUkxldGpMOnCgw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3tnsfd1BuacF7yiLaEZvAp6S/HP5hvydgs/qpsf248JaphyAXAUQnAgEPnML?=
 =?us-ascii?Q?6uExd8aeZwsXl6LbzqrHFcY5TgRTXxyDe21O6CWw/HQHAF8gx8X5opnWv71K?=
 =?us-ascii?Q?6T4VvvF9SvYH9fexpD16gDv0UmNEksh9UUDfUOUb36WxkI+M7G2wBvmszP4l?=
 =?us-ascii?Q?/euEfkIL/+5mxYlUP0LFkj97dxsuirU2cBOk6psTRN5DUReIQg5dXMfaqhmZ?=
 =?us-ascii?Q?gq/dZc2F7nfDr/UMiY+qtX89LeoXlKMrCFbbh6GvxCirG52HR6khxdrAb2Ca?=
 =?us-ascii?Q?ghYMKm3YBAFhwiF4dsetxeBZfQ4dnT+nLNchGbFwuyKO1qEQbshz8Ga2ds4B?=
 =?us-ascii?Q?fI9KVZzHFIXKcRRYssOlToFuk/nc/DVPCZsFOzuHujqNvK/XdDAU7TNMYs98?=
 =?us-ascii?Q?O3YaNkBZl0j9/ChEA+thPquWE8hy5IvZ6vt8/p4fg0TDYfd8TPl5DGkf9IZa?=
 =?us-ascii?Q?xcUCn5b2+6ORvDcLafqQLibftGzVTy0uki9bmyO6RU91xyyrbOOJo+3Nrdkq?=
 =?us-ascii?Q?b+HBNl0m8qkIOBQFubPRNNyGngBf0PCfSLIpJP3SOgHaYQcqJleWGpITdJ+N?=
 =?us-ascii?Q?BMcdr/lau13hVzF4zNJEGbICfQY5KT6Iz/1Em3VHPfr57apJpkYUbbG1QYpH?=
 =?us-ascii?Q?jU/GmpJdm9lbTvBOxmmUwAyTwzBsdIT58j2JgZmEzLHBjGXFHJ1nKjKHkQ1B?=
 =?us-ascii?Q?LmZ3hnD65RznMnzz80DDRFf1XzRWEA27mcoas/YUDPzYv4GGbZbRsPiDnooN?=
 =?us-ascii?Q?y3brT6Evxqh9QcjD8XZcZ87KfW0GZtZXoXiFWS7CgFTiS3jrxNUf4FLlZtIg?=
 =?us-ascii?Q?Y17B+eHp8Wnzk4WOnzgwYYUMu9VSkPwITppTFUnDki4TkL+O4tLwwOhCOhdD?=
 =?us-ascii?Q?KpJXo8fehMSe8RbYQA1fXsKfe3hg2dkpUMrTKnsBb6nLLry8r66/bl+ZX6dN?=
 =?us-ascii?Q?8C5TpkeJJVozDuAV1VgKntkIqrHjoLaCVhGK4DgSMO9ZUkrAZU9nxj2b1Pw0?=
 =?us-ascii?Q?mlapfMm0jYLbaIRLdWPlpPGD/0O0eRE1DsPFvu/FFhGM/SB8oi4W2ZnySvKs?=
 =?us-ascii?Q?iKOfr/DVZMYkQdwlZKhtVqunDCIJQVtgJeuDz063RpymA+S5pAQpdfKWhFFs?=
 =?us-ascii?Q?USsPW+eBK4s2c9TwpGtam3LkdqUWHwO+ehbf0FnJdH3SeobZbd7YoHP7e9LM?=
 =?us-ascii?Q?4N9Wq9leMf1UuEtPXqnku9B1HBnuMGZLRIATWCGfbUnRnQHyhIpGTDyr6jX/?=
 =?us-ascii?Q?K4owxV5A3lKABZRWfkiTEC7XQksMtPxMrxM/muzxZ/tqiuSs+reuSG+w5OKO?=
 =?us-ascii?Q?7UfjGzIPRV52h+IcWNorQRt2VT3pPXhh7oYX8L646tJtqNmQHNkHBx8WBUOS?=
 =?us-ascii?Q?Qby3lXgcSjmE4xSNG3DtSxDFPESe9K5dxHnxEhBPv5Stq5GzQj0uebukaMVY?=
 =?us-ascii?Q?wKNV7V9BP7zYrRRDMN0brYlt7+0EVfW8myuxP78ZFMrg0D0mAtBW26VqMmK5?=
 =?us-ascii?Q?6kpG0Ytu13Er71eC4a2xIEP+Brmn0Hd/D8T7bK7xT3Zw4D8MaKHrQgRwyyCW?=
 =?us-ascii?Q?/6Y/2K2y1iqBzb7Ti+hBvE8n5P21aBFfy6DGOydj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08943564-b13f-4db9-58f8-08dc49c300d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 16:21:46.6333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/HqWz4MmFqU/byxx9L/2lxOoDuhFgSQ7Dbt2xqVTD4mPytWwoNK1f8wbrbI6cgknNjQFAf/uD74kMtgfc3y9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9002

On Thu, Mar 21, 2024 at 09:16:56AM +0100, Niklas Cassel wrote:
> On Wed, Mar 20, 2024 at 10:29:42AM -0400, Frank Li wrote:
> > On Wed, Mar 20, 2024 at 09:53:14AM +0100, Niklas Cassel wrote:
> > > On Wed, Mar 13, 2024 at 12:09:04PM +0100, Niklas Cassel wrote:
> > > > On Mon, Mar 04, 2024 at 05:46:16PM -0500, Frank Li wrote:
> > > > > dw_pcie_ep_inbound_atu()
> > > > > {
> > > > > 	...
> > > > > 	if (!ep->bar_to_atu[bar])
> > > > > 		free_win = find_first_zero_bit(ep->ib_window_map, pci->num_ib_windows);
> > > > > 	else
> > > > > 		free_win = ep->bar_to_atu[bar];
> > > > > 	...
> > > > > }
> > > > > 
> > > > > The atu index 0 is valid case for atu number. The find_first_zero_bit()
> > > > > will return 6 when second time call into this function if atu is 0. Suppose
> > > > > it should use branch 'free_win = ep->bar_to_atu[bar]'.
> > > > > 
> > > > > Change 'bar_to_atu' to free_win + 1. Initialize bar_to_atu as 0 to indicate
> > > > > it have not allocate atu to the bar.
> > > > > 
> > > > > Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> > > > > Closes: https://lore.kernel.org/linux-pci/ZXt2A+Fusfz3luQV@x1-carbon/T/#u
> > > > > Fixes: 4284c88fff0e ("PCI: designware-ep: Allow pci_epc_set_bar() update inbound map address")
> > > > > Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > 
> > > > Any chance of this fix being picked up?
> > > 
> > > Gentle ping.
> > 
> > Now it is v6.9 merge windows. You'd better ping two weeks after linus
> > create v6.9-rc1 tag.
> 
> I don't follow this logic.
> Two weeks after v6.9-rc1 is v6.9-rc3.
> Why wait that long to merge a fix?
> 
> The PCI pull request for v6.9-rc1 has already been merged.
> 
> Merging new features (to a submaintainer tree) might temporarily be put
> on hold in relation to the merge window, but for fixes, it is quite
> possible to both queue things (in a submaintainer tree), and to send
> accumulated fixes to Linus during the merge window.
> 
> I did it myself just a few days ago, and Linus pulled it already:
> https://lore.kernel.org/linux-ide/171087658094.21820.15365015832308818327.pr-tracker-bot@kernel.org/T/#t

I am not maintainer of PCI. It was just my observation for pci subsystem.

Frank

> 
> 
> Kind regards,
> Niklas

