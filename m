Return-Path: <linux-pci+bounces-22795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1525DA4CDC2
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 22:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD0A97A30E4
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 21:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A761F0E2E;
	Mon,  3 Mar 2025 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B0Cv12UH"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993F1E5213;
	Mon,  3 Mar 2025 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741039063; cv=fail; b=Kie+rdX8vkCWemHH7PPeNEVSJ2FfNCHxFkmvwMxq2ManCgZ6ux0WmccrRGEzSTfnI10eagojA2tX0IB05LxZo790PXBMQyzymL/PnB2gxvOAIryzTBPm9lO3Fzv/IL2wnnXjAIoZZRNug+X/BpWewHwhpk0jkGzcNStxKv3qdpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741039063; c=relaxed/simple;
	bh=2B/DmQ791OicXBAlM/f3gq1SfcoECIusIbEiJO1VAik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n4RrbKBdM3wZ5A3Oh8WUtMWmX1e4jbLPkCFLsgobl+7XM+jMJxzX5MXftTxBcAOstuwXdVnHGwiwZmkkEhTN5S85Y5ayhaSqCed2qHnPSMqyNAcTdwvL5MbF97nlMbrRALl2opDp+A7y7KTKSuA3jseu5cS6BeJxk2ISofYgDtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B0Cv12UH; arc=fail smtp.client-ip=52.101.65.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BTFZic7F9+/RwpZDpbWs2u2I0YSg5JCWTaMTfSwcE0IRgmVovzLzClMxyMM+sGoKJPYKgt7eAU3Lja9TDU3+9b+nMzi5reVYe5hNUABF3PhBEsG2ZJ7pHX2rSpBKVKfnH8+ki4KkclswbbUUgnt1e21fTWsVrVS+bew24VVG/hUI3E5xEUu1pnJud/MAMIoQHTSdeXW4XlFp1WwDOzC4rjoAhsmbU4ftXwx3eUz41lAbfGi9yCKxkjZlhKnt6iBB4qt85ut9iuHXtsZmludYw2/SK9KsEzHvs/q/7hmJzdCRXyvq/N5XZFLcPcG7ydlCyT2w2WjcfpzJXwpLYD7miQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sxxFTwBCmy07b17h1uPkhQMTyDEADvYmXs/vNiGFOM=;
 b=m+kuzeblNpYjvkOrtYC+6Z56Z8Qs9Lyl43lDx0lyMMzBw3j2F9xpa4xLSozkz9Xb0wauYs35YDL/nyfv0TUh2uLJooMoPQx6bWrfQhr4/MLDIR/X1p0yzkoQjOU+ImwaZXG1EwjFNhbE8Cjoxjxylt+6e2vTQ8lnjPhMoBgkpBGNdxgXVEZqulpgCssyHFjVaa/wm3I14/RhkcMIVtwwAUhbDN5zKoo4qbZvMUicsdWFtRAYRs9r24JXNapWpvacS+nVmhRB+5+A2zvmeRX1ISCgM+w9CC8sm4g5pFTIHSL+LoeD8/JU4rPzdxjuzRf1s2EN5fJ5YgplukvDeddWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sxxFTwBCmy07b17h1uPkhQMTyDEADvYmXs/vNiGFOM=;
 b=B0Cv12UHdXJdy2f5akpR80L2PNYZh2VIUbOtNRBBkR/jLXjPwQh7GTwk7r73AGumhdGHpDhkKsHcb/oPOemAYnpVxUb8c211+ALxO0o7CvaFKjGVBvI5VtYS8HoRT3l6Jfrjq2569GrMEShB2ACpIJJNgvGQE58+keJ0RNZ55lg/mCRZa5v7huxhHew1GRjo2hcOFxrKw1lrR7oURtQ4yWsjWU2McjqyrmPzLDUYFZGYwTBz/F7x/6XC17/MOy0fy3XBzYLPPeqTwUFIaJaXkUSGC3r50gnm9B9dsGwEGTlgWsLha67le7xCtQoi3RCl2IlU4iVGS0WrfK/1I/jx9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9910.eurprd04.prod.outlook.com (2603:10a6:102:380::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 21:57:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8489.019; Mon, 3 Mar 2025
 21:57:37 +0000
Date: Mon, 3 Mar 2025 16:57:29 -0500
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 3/7] PCI: Add parent_bus_offset to resource_entry
Message-ID: <Z8YlySM6Xtr0beo1@lizhi-Precision-Tower-5810>
References: <20250128-pci_fixup_addr-v9-3-3c4bb506f665@nxp.com>
 <20250227002326.GA566507@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227002326.GA566507@bhelgaas>
X-ClientProxiedBy: PH7P220CA0125.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::18) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9910:EE_
X-MS-Office365-Filtering-Correlation-Id: 79156882-b337-45ac-cf11-08dd5a9e6957
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bNSyovjhdTRrItZ4i8836Ww+okiBFq2zkAu8UZm87p3RsQL9LyorGVMw5lig?=
 =?us-ascii?Q?j7eznSV6UFOZURpFNIqje9H7Vx+M1aQRU/WTxEk86WUQkWpUuPA8NJE04OiV?=
 =?us-ascii?Q?nSrAOdca7VTtqi9vO+Qk4rLUN9H2CoqBocISXKHda5cOyTgatyXkU1hIzoka?=
 =?us-ascii?Q?Wt/1bT3z5Dsi2A4kIWRew3AJ+oPtb9l0XpdTYnDdAYuMyAdVMqrbyty915qy?=
 =?us-ascii?Q?rZvJDgztCl/Sg9f+BQ4tNCuiSH/sbdWNSnTzN9S7wRaSYiPZ4K+PWHHXw5ij?=
 =?us-ascii?Q?cp41XbOoePm9kukZ05Oq0UOriTSQjt6BWNKVtkJEUhGgp8NQ++3ah5jDoyLd?=
 =?us-ascii?Q?46AHlTmVyjJneYhqxHefYS7+IGhpmpIoudCUT8uSiKx+HaN5O+/UuFxR8Hia?=
 =?us-ascii?Q?UlEHZnPmTXGUCN9LOL8baovWeYbjyPkWiNgH3d8bJXuOnMMtp2UskH0SDBOY?=
 =?us-ascii?Q?9UGMqSBb2EmFCtqHfDH8bOaxadOlPrCDxQQY7PMIN5eg+ziyKx61wdQUvdIL?=
 =?us-ascii?Q?0wx3DfL6PfUsNfWRHfakupDsADmyO78hMKUnRIS2YqSdn8odoCRadioJDb5D?=
 =?us-ascii?Q?PF8ykhCWnUskJeoWaAFBqxFu9Dck/B9UGZ+gyYbkmoraEPiXCBfNm5uE3u7t?=
 =?us-ascii?Q?Jwfd/4ZVRaB+fQ+IplcWNDJchaVj5hmy6DTTIM7YwA/ayT/kfzTLk89Gy/vN?=
 =?us-ascii?Q?pDeY8fUBWn37WYxQK+3YUHrHG+Kps+IV43kAt12rTLnMvx+iafvVVylGSEM/?=
 =?us-ascii?Q?oRwDDjgy+Kg7C3C6gW3thsyngxICPzuxZ8vC/+ioU0B8DiJO5KMX43uWHKcp?=
 =?us-ascii?Q?BnUz3tW9FjlxMMqAJMlAGjXkoLLymSeUP/398ptmCyxLL+ocn6karLS3s9AE?=
 =?us-ascii?Q?vd+7FzKs9H9I5ZDPw/vKKASc3VMK53g4fUvPa9u+dja4tx0LDdB6yq3YLYAS?=
 =?us-ascii?Q?eWwQKlKEXD4kw58NeoF58cNIkaaAzjoOy7Bc1nXKtlUMu0Ry1qKZSb++tgsu?=
 =?us-ascii?Q?7Om/Faj2KUPG5q9CLexqWnKc7LYD/IxsXv4k62YjhlTmJtWypeubEFkVwYyG?=
 =?us-ascii?Q?OjSL3oa03mIWnmYLC1cMZa0XOBygVKVWBq8pqp/S240uU5pHMEp7l52+R8j+?=
 =?us-ascii?Q?ZArWLd5kCmXqTSu0FzOT7MpTNqbRCWuQ1XggFvtcPQo0IZVCzHgWWpJtwr1a?=
 =?us-ascii?Q?gGGi5gnaAhewciwALg1/0sS8MJaL9Fj873DqFnaVtNRMl16v7R1+46V4ToCp?=
 =?us-ascii?Q?VCBDUmm3yeOSohXrZIjNq/AQy82MSW6Q/dbrgRcp2mN4aDN2IDrYXi3FBtSc?=
 =?us-ascii?Q?L1aWr78Bsic/hZKdSjv2N1JHiqglPHkpMgVC78SOEot//P83IKY1VDJ/ehvC?=
 =?us-ascii?Q?nM5/WKi3n8kONHXfHQ3m4zFKjSNJj1WbdUJ/Il7KUU8XAl5rGxpSrGeZh552?=
 =?us-ascii?Q?2Fk2L3uIzuhJwoe7/ZqPcuj3dqz4OAVi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lde8msIyrNMcd6Fjk+rTV6eFzkJkuI51GTFnxuG25Oulw1XdN1yKxND/WrTE?=
 =?us-ascii?Q?QTP/ISodd0xYv+WxfrFH4FiBTwmIgeKN9kTThwCo6iTkSAURaB9dloHTOCV+?=
 =?us-ascii?Q?TlQwpFNq1UEGyEGEVeHxSuPXHNPp/vjD5U5/sRt7WlguCYf+Zc7JEStk0TYM?=
 =?us-ascii?Q?G02QGMxhLczJxgCUW6eSYRJCc8hMF5wbAAE2Z6IeGsF/VfKemtT4tOyCQ2WD?=
 =?us-ascii?Q?vrj3iB0uR0LncSQOWob672H3u1F2pOnidM16Go8kJCYHCIqaLeE7ws2qUNaP?=
 =?us-ascii?Q?g6P241kD/NaL7jhI8+BLsvPm99IRGBgmrxUCJvS+2LgFHY5lGsslFxUUWNPF?=
 =?us-ascii?Q?WNwzAM5x/SJIeyVAoUCFDPaWvL/QQQnZxY6ZXa1y4TY+2MNphO/Ed56qb11J?=
 =?us-ascii?Q?nrktmLR8Y9voJ/+Tw5dc9H3aZ47BQragBkg7uxBKkDlEXGxETFDOuJkjG29r?=
 =?us-ascii?Q?V76OLJfw3svFv0V+d0kONSgCMnPa+5pt+cLudTYFfQBe+OaaMunKY6QzV/0b?=
 =?us-ascii?Q?W5Pew519yMXE4t7z1XuzEznfFyjXmpU3YV4dd/nr5MiX7r/5fS7G1Otx42lz?=
 =?us-ascii?Q?xWgt9bv/co3374QDByID7WXY7xnucDSUhcCHK0M5iJAM9uY2W2DHY62Bm8mC?=
 =?us-ascii?Q?rhRT8C9P/4NXs/hfqxJdXqRPrrv3TzYBNb491pGSbA4PgBq6e56Ecig/+5Wh?=
 =?us-ascii?Q?0StLvdw1pBPsn+DmF4dURBbStXAXei6J8UODKRV65O40FDRoKoSd/QAD9rt+?=
 =?us-ascii?Q?lwAgYLny/UbcGzAT8PV5GQzCZTSs1qz5zQ+FFPpUx64m3arufZCMKywxDh+x?=
 =?us-ascii?Q?wH59DZoro+3Tjn+r3zGSbrcw5DCa3S8cDD9jC5Y2ej/OMMLoWHoVpL8l3KUb?=
 =?us-ascii?Q?80F6DA98dGObLtzhPkx1ibnEPToM+j9LCidgg8hBPMxm1uQuWe9O68A+koD5?=
 =?us-ascii?Q?9ATzKqsvPTNluEyxEvg/4TQwmeE6usUcLiIJaDYep8P5uYMMA/23YmuSvxUJ?=
 =?us-ascii?Q?LcSfKrXTi2L8Ogy/wR6Ntk7OmMri5QKuZQDSLAt45eBsX5J1o0qQh//y50li?=
 =?us-ascii?Q?ah0AhPxpn6UQFDow9ktUBgCnrQY+bPJxfQ88l0pjbchPng/DCafxyUlbwFre?=
 =?us-ascii?Q?12oJTjQkrb8h9oiXSwq9h35Sg2DNglUqCQtNwzrt1Bbfa2GIKyazP2Inx1eO?=
 =?us-ascii?Q?OSNxHkCncejhmgp9+mMO3npweply2VJiIvowjRxTwmixvwEUhqys7Nax6VLf?=
 =?us-ascii?Q?A/u2253pVJYIgBVCXvxLAcjM96SJlwc51xk75z/lPRQPIk1NnQT98OTvMcyN?=
 =?us-ascii?Q?BXx4UXFI9jFcrUvYcLhhQfN2Xa7CfdBbBjVxsAs2YKf27CG9lEfdjmLLnBo8?=
 =?us-ascii?Q?uF/xqJ21Fm2YdnN4SpQTxWcqwN5X/wkaDxcJi15GYVTjWSg2o8ntDg8KCsTg?=
 =?us-ascii?Q?rkTJmRafb12mTnaTfw7tW3JaPpCMS+8nxZW2i5mptVQQchyXTx/Ef6uphOQb?=
 =?us-ascii?Q?cRXJnxncq0cjrUH1/HPDny6G+Ryi5PSKuXCz8z7gNnseMrn3rJ6QJ6krN5Ys?=
 =?us-ascii?Q?o8by6iN214m6vqlpLNM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79156882-b337-45ac-cf11-08dd5a9e6957
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:57:37.6723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9O7epum/xtYv5U6uo9f2sMgTpQw1jJh73w0pKv51JI4WMJp3yuVL5tOM1fMcqBvo8w8p4eyqE/9mJgyUz4CvTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9910

On Wed, Feb 26, 2025 at 06:23:26PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 28, 2025 at 05:07:36PM -0500, Frank Li wrote:
> > Introduce `parent_bus_offset` in `resource_entry` and a new API,
> > `pci_add_resource_parent_bus_offset()`, to provide necessary information
> > for PCI controllers with address translation units.
> >
> > Typical PCI data flow involves:
> >   CPU (CPU address) -> Bus Fabric (Intermediate address) ->
> >   PCI Controller (PCI bus address) -> PCI Bus.
> >
> > While most bus fabrics preserve address consistency, some modify addresses
> > to intermediate values. The `parent_bus_offset` enables PCI controllers to
> > translate these intermediate addresses correctly to PCI bus addresses.
> >
> > Pave the road to remove hardcoded cpu_addr_fixup() and similar patterns in
> > PCI controller drivers.
> > ...
>
> > +++ b/drivers/pci/of.c
> > @@ -402,7 +402,17 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
> >  			res->flags &= ~IORESOURCE_MEM_64;
> >  		}
> >
> > -		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> > +		/*
> > +		 * IORESOURCE_IO res->start is io space start address.
> > +		 * IORESOURCE_MEM res->start is cpu start address, which is the
> > +		 * same as range.cpu_addr.
> > +		 *
> > +		 * Use (range.cpu_addr - range.parent_bus_addr) to align both
> > +		 * IO and MEM's parent_bus_offset always offset to cpu address.
> > +		 */
> > +
> > +		pci_add_resource_parent_bus_offset(resources, res, res->start - range.pci_addr,
> > +						   range.cpu_addr - range.parent_bus_addr);
>
> I don't know exactly where it needs to go, but I think we can call
> .cpu_addr_fixup() once at startup on the base of the region.  This
> will tell us the offset that applies to the entire region, i.e.,
> parent_bus_offset.
>
> Then we can remove all the .cpu_addr_fixup() calls in
> cdns_pcie_host_init_address_translation(),
> cdns_pcie_set_outbound_region(), and dw_pcie_prog_outbound_atu().
>
> Until we can get rid of all the .cpu_addr_fixup() implementations,
> We'll still have that single call at startup (I guess once for cadence
> and another for designware), but it should simplify the current
> callers quite a bit.

I don't think it can simple code. cdns_pcie_set_outbound_region() and
dw_pcie_prog_outbound_atu() are called by EP functions, which have not use
"resource" to manage outbound windows. And there are IO/CFG/MEM space at
host side, It will involve more .cpu_addr_fixup() calls to setup these
range.

Frank
>
> >  	}
> >
> >  	/* Check for dma-ranges property */
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index 47b31ad724fa5..0d7e67b47be47 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1510,6 +1510,8 @@ static inline void pci_release_config_region(struct pci_dev *pdev,
> >  void pci_add_resource(struct list_head *resources, struct resource *res);
> >  void pci_add_resource_offset(struct list_head *resources, struct resource *res,
> >  			     resource_size_t offset);
> > +void pci_add_resource_parent_bus_offset(struct list_head *resources, struct resource *res,
> > +					resource_size_t offset, resource_size_t parent_bus_offset);
> >  void pci_free_resource_list(struct list_head *resources);
> >  void pci_bus_add_resource(struct pci_bus *bus, struct resource *res);
> >  struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
> > diff --git a/include/linux/resource_ext.h b/include/linux/resource_ext.h
> > index ff0339df56afc..b6ec6cc318203 100644
> > --- a/include/linux/resource_ext.h
> > +++ b/include/linux/resource_ext.h
> > @@ -24,6 +24,7 @@ struct resource_entry {
> >  	struct list_head	node;
> >  	struct resource		*res;	/* In master (CPU) address space */
> >  	resource_size_t		offset;	/* Translation offset for bridge */
> > +	resource_size_t		parent_bus_offset; /* Parent bus address offset for bridge */
> >  	struct resource		__res;	/* Default storage for res */
> >  };
> >
> >
> > --
> > 2.34.1
> >

