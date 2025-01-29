Return-Path: <linux-pci+bounces-20544-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC95A22045
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 16:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24F5418882AF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2025 15:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8A1DE2AA;
	Wed, 29 Jan 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mofr66Fp"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E960315B102;
	Wed, 29 Jan 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164520; cv=fail; b=QzPYyQUwjCRQduZ+xWb5d+oTysK3QhDE5vIVXp0GyTHBj9/PhnvtA9kxmPZusEyXUeGWgTVHHeZTbJkWSGQ+XmS810KSVFPFeKmc1d4rqkfMmQhcdQjCdrRvK7/hk3YVd8DPDmg2RpimNW5gfgDsnBCliSeXL9r6ebfkhFxHU6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164520; c=relaxed/simple;
	bh=/JsFHSs36jEEjCJO6QxYhL5kSRA59bZMZmAmvfNsvbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eh1P2oI/ZUuCSgSJTLSGVS0a0pF3Qc5uTWTF1eUJmxNZLkUK/sJVYQDYhLmvkcZj3KLCqstXSi+taKuOH3Zewlyl7Gme3BFkoBjsJm4LvQxmHKmZsB3vxbwpw0KTi5lzHBE7iG2UfjBgRFCfp/zlttK/maTdTRqBzvbOxSCIY5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mofr66Fp; arc=fail smtp.client-ip=40.107.22.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tid1fCj8k5KvbgG6r8zRx0u9Ad110yMQx6Sy7D8kg2CFjQYP625hjZVYA3kw85/vNOk27SJupEvOtoZWkKQ/iHlVdgnpxAf611hHbQwD4T0ahvg2z4dSZMc24+WfFgp5/cWxsQ3Z2K4qphxrSAfesFYjTPWTbtJyrLKyqKv24aM1euaUR63dnx51yf9Lximm3aJSXpg2oQm9HwHhmTtbd2hAQNYDbI5m87ABTuf4UzCzEaN6pSMsiUwAIjqnbgcqYIVyQYH/B+pE+suTcSsMlb9hgEfdkU6rM/SA++g5LBXj28TJWjOpoRexc5lXPTAtwzTqkC/Yy45MBtq2nW+j1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WLoGXo8FV0VgYhcQySSGNhTayNQPR82EobdqU4u7FE=;
 b=qYgItB9jrF7SxnAhBw6VuZkJchbGe5j/bYXunmIN/b2c8BfhQAP0IwWyFjxXQ/T+8u3PaKCaU2XFuH4qbpY0zXarB7x6+DSuJX6jRzHqXj82GUql4shpSE4rJvj5Dic7jw1vZHBtr4/9X5b0o7S0ulFjGD9/5Nl3Tfnp2v9uwwG3qo/Z/xWhv4gQ1shpFEq1W8KICGIKbcEdgYONrnqC+p6VfgVL2TrRnnKdTwVk20ufF9YNX27DEHiIzWA6hx6b8AqnPQ5/QVkgw2omWfzQJ9MDwN+8wQunLu7RxwivM4019SxTkKGhyv4yvQK3RiX0wbOx78ivg4k0xl09Uz+/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WLoGXo8FV0VgYhcQySSGNhTayNQPR82EobdqU4u7FE=;
 b=mofr66Fpqawnn8W9s8cgDNcFkcGFbTGCuwqkuGJbso1pAYYga6puhqZUMJkWwq0ej/DVOvwPQSR3N0Ee9RibnbCg+niJ9DO4onrZ4s15o8GHV6IVRQBBpBkQSIRHbAo+94XwMQTMf5JjO9XU2giAv8xdP3gf9R8rS6ZImqqBFmlkQet6TTunhDHHwRYmllVAH2fS/An86w2Nr4o0wK/GXIGvqhhkC5gTDm+GuzTpa8CqOWfjutHilfUdkLRue2Sopl9bZdjVS/KhNYmfQaOixezLzM00S1BkIOtJJosGf/rXT7T75dXQf3Zzle1wDnAMaPaUDQs0lZDHtoHHN77z0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS4PR04MB9337.eurprd04.prod.outlook.com (2603:10a6:20b:4e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 15:28:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 15:28:32 +0000
Date: Wed, 29 Jan 2025 10:28:23 -0500
From: Frank Li <Frank.li@nxp.com>
To: Niklas Cassel <cassel@kernel.org>
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
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v9 0/7] PCI: dwc: opitimaze RC Host/EP pci_fixup_addr()
Message-ID: <Z5pJF9MGENNDqq/O@lizhi-Precision-Tower-5810>
References: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
 <Z5n_VrN8HUmdVPUq@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5n_VrN8HUmdVPUq@ryzen>
X-ClientProxiedBy: SJ0PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::30) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS4PR04MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a5ed4f-f1fe-4d62-10f2-08dd407996e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PMpXDznDYElczh3qQwn3J3XS8sgd9wSct431+mROCS89MlTQE5RldJTntAkZ?=
 =?us-ascii?Q?iqsA2pb9UjWL2wRWoVjehPrKDL362ba1VZLglsjRfB+ylMUISlPWsVth+mfV?=
 =?us-ascii?Q?RFy0SzK2dXqBE7eKSQliP+9j/9zXf7Ibi2Tl1g+t2PnpyUsColyBw2hQkvJe?=
 =?us-ascii?Q?vVS2Oa01u2VJyWStJihBIcHsdN7QcZ13KTpBp9xQvYs86Sgh8LRDNV7rQEMP?=
 =?us-ascii?Q?qL+cNOJN0xg+tyrj/eFvxQ9/0x2EiAMsu3rEOuZW3+755pbzeW+GLhZk0NII?=
 =?us-ascii?Q?fAODHBp4bdSBYQ4BS0UzhfFQY2eNcAW5wyfF858o8WjtqGAiTVVdck1bddAT?=
 =?us-ascii?Q?v4riXd/mgML4ylfGVeUVHXg+zv/5F07OduV+zaWynFMg7UV3TTKQ8x7Fq6eR?=
 =?us-ascii?Q?4es793mpmUpFwcQAMSsfWHbEMPMKD201EL6mlchE47qr9bq10kex3sqC8KpV?=
 =?us-ascii?Q?0f0XzvwDw18UyCX/aGpcBJF9khylXkCGzCn6QixZ606RdOFFEr/ZTGGxvXw6?=
 =?us-ascii?Q?6OExUtH2Ij2DFKwdeDCO/WXGif+uyQ9M/2/qAUqVGEvh/SE48l4eqCb/D6pD?=
 =?us-ascii?Q?ejW4TBDnvTmLB8325b159HbHzvXvv2qT5jZ9BNlNTOqcLFjsL1VSz7O1fEl+?=
 =?us-ascii?Q?fpJqbvew7lH4CLkLw36/JlLmVLOPuJQ+z4RDo1EjIr+1NqxcBaClj3UVpXy1?=
 =?us-ascii?Q?fp9X1vX/ICyb9pClKhX27Cb/U+WFE+wZIc+BjZiHQAwuwwl1k8Z5Su9HeRaE?=
 =?us-ascii?Q?/YacVQYxwe8uhmgXS4D9WC36M7Y+uFYNwo3tI+Krw+w3xb+NvmpU1TkEOkuG?=
 =?us-ascii?Q?6cp6Io6JqmY5XqhRqu0QnAJKkjf4kzokEkYF7EkQ6ah0EBVlQYCoJbO+mPVl?=
 =?us-ascii?Q?/CQEO90/4lLeTgmaFdHpXoEb4ljn6fnLL7HgYikPArXeQuTQdbTgD+G6Uvqj?=
 =?us-ascii?Q?K4RgU09GdRkjQBIt0ktWoGGWkBrGu2POxaPR/uUur9NU9+amzcdgmoEdGxgF?=
 =?us-ascii?Q?ltCGwdGfFEwgNxREqfjzZrSZAbgMfHAWUKohyxti9QhiTCB95ST/Wtlxd4kQ?=
 =?us-ascii?Q?NYDI+ekItP9dEl+A0atEUCWz6ssCw1ZgJUh7fRpeZjIUEsTM2J3QfuioFMyH?=
 =?us-ascii?Q?ZCy2QSx3aUrCLCfN31a953FkXZTs5S42zxbD2lcScPqSSVkaUgPFZRcEEcWD?=
 =?us-ascii?Q?l6Mtpajo/qTmZ78al1uX541aMXE4a3RtSrPrBEamJEZKeh1kyC5SWmRcT8Nt?=
 =?us-ascii?Q?uc6EIwRjKqGYbECnD/hH1HIXApN1FsFYQAOg80u4zjCZTPRhSGIge3rLqUTl?=
 =?us-ascii?Q?0bqgyIU4vQvuhRCschSpLBUT0A/0uY6L3SjbsoqxZ0FkHWlfO9Svi6bRlRtE?=
 =?us-ascii?Q?cXgjlul/smTw9gbyVzwfUjSLz99GoEALNysOT6FJW5oZ1l2Jow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cYxOU4mtDNpqxMg9ckUbEH8Db2J8wf4oDpj17T3m/qkJdOPbOMhvdc7hmVwU?=
 =?us-ascii?Q?DA3f+csmsJStyp/mQ53+oUaJbctYxBmgvWKnJI4pNdxXyk7PM1/bQZo9hNxR?=
 =?us-ascii?Q?9Ms5zTgVa/AqIhmKgnBv/VNuWnakgxWX3TQoJzYFQF7F/UwHHGN7DlDgpaW/?=
 =?us-ascii?Q?JB94qbUzpi0HAI0cCgKLyZWXVdX4Gjz91/fAJ0ML1Iv6oCsNWyiP/Z4M2nq/?=
 =?us-ascii?Q?IqEyM4T0+j0pMhbOO7pH0RsKfA0ugRf3HbnMrfuwwHQduBDDFHgBcKyYFCAs?=
 =?us-ascii?Q?YYjT7qZKHeWRq5oFoHRe4GV7xWSGmLyLSwxNAvxXbDSsFHJFQVWZKKcPTL1I?=
 =?us-ascii?Q?F0IFawnJrTR86lh4RBsWeiEEDB86aJw1ZMCHTJgn5yKm49SQw7noDj00t6vh?=
 =?us-ascii?Q?lrpZ9z1Uttbl+XN9pvqFa5vtIvac8gapeSR5Q2O3F+mbnbEZdIm8RJ1txC+d?=
 =?us-ascii?Q?GIsCFVF1pQxTOdL2fr6bXokPPmzfxdQzRUHYmSTd1jwdc+k4iYOda4iku+X1?=
 =?us-ascii?Q?CByH0RUXzPHY/NC0wD5mDdt1bDKswYqRvuKjCinL04DtG+OPg5EW8PHMnr7A?=
 =?us-ascii?Q?0ZQ+DNZ1hUY8Ak7Yt16X+d16Q4ekiEBhy/37BaNFLDik+ajZvZ35Y5wkzkro?=
 =?us-ascii?Q?t/BytTto5cmum5twyMgsZASE+FIv9nYPzqaHXU6qsWjRh06dgtC+znbm1y3o?=
 =?us-ascii?Q?YfEEIUZvf65tXGX8JDh0rEMN0oPAqLyegIPB+/w9XgEmTDyMu7EQdZoRFBeG?=
 =?us-ascii?Q?IQhjxYS+n/wiPVR3zhnWvHu12Dd5EmMxOAdnmISYDj0OMDg3OlYcMwQiLW6B?=
 =?us-ascii?Q?Teq2tMaKMmvFxPkVQmgAYukjwzNjNtwf/UQu0v2it7R64U2DKKNsxnmrISDT?=
 =?us-ascii?Q?lZaV4BAsAy7T9S2XPYsOG+CMxesG/RftLWKqp5vJbS+3AWJ9w80tFSNNvojK?=
 =?us-ascii?Q?ONv3H9SvGOhO8eioI498GvBSSIMrsMZAcnrfSo5KGNxyd9eqMN6ccijNB2cC?=
 =?us-ascii?Q?+tMBVXjpIxsIdytu9ERD84vVEZr7IS1ySFutGk4dYkwZd+BEzC9kvS4nyWY0?=
 =?us-ascii?Q?NkY54VFSpALm/9VCDrLfRDrBE69xfbNPIgQeVanRa+uBFLyNXZQhoe1tNczb?=
 =?us-ascii?Q?LPBJ4mbxi7TyWZHLQc9AUpxgOmu8hD+DXH9c51P7ufG8YS85YaMe1PxVCTCE?=
 =?us-ascii?Q?ThD7bDMMGozLepzP6XZ2wYxP5CIhAJkU1WrhUH198+FGD9Fgdne35hx1v7LJ?=
 =?us-ascii?Q?LDUhVYu1rbK4OJBQt15tboiMbKOKTYwRnRfxJCebHgEr7BtfzPFURwVKd4Fd?=
 =?us-ascii?Q?AwoLPGjkISR417WsL4AFXwjQFiAwP6hkf/Y8jBzmkTP2J9VdaS0Nwmqnvpl9?=
 =?us-ascii?Q?qltMpsRxyoGJ3ZAtwaOg9txHjDE80sSVQlpZJxmhcyfyVA0N9dKPKGwDe6M4?=
 =?us-ascii?Q?ZxLwHUcaDeWOMtiFBy7dohu50mmyw+X4dveKqpfr0ENPJoj74IE85kKijsmq?=
 =?us-ascii?Q?1w7+OGNREObKIZM0pZN6gDi+paCWrv8laLygguzP7DHCepsWivM+y5d87T4/?=
 =?us-ascii?Q?YqAxjgZLo9Dfi/OpXQ8wbvDy+0ah4MzEUhxlm/bY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a5ed4f-f1fe-4d62-10f2-08dd407996e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 15:28:32.4593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWhVJ2Ihp00LYNsIS2rGB8WsrpetYJU4qdb15/qubbzdan70WcUVrH/mjfVZtFynxovnaH1/LUU7rtnfRfSEzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9337

On Wed, Jan 29, 2025 at 11:13:42AM +0100, Niklas Cassel wrote:
> Hello Frank,
>
> Typo in subject:
> s/opitimaze/optimize/
>
>
> On Tue, Jan 28, 2025 at 05:07:33PM -0500, Frank Li wrote:
> >
> > Bjorn's comments in https://lore.kernel.org/imx/20250123190900.GA650360@bhelgaas/
> >
> > > After all cpu_address_fixup() removed, we can remove use_parent_dt_ranges
> > > in one clean up patches.
> > >
> > >
> >   ...
> > >  dw_pcie_rd_other_conf
> > >  dw_pcie_wr_other_conf
> > >    dw_pcie_prog_outbound_atu() only called if pp->cfg0_io_shared,
> > >    after an ECAM map via dw_pcie_other_conf_map_bus() and subsequent
> > >    successful access; atu.cpu_addr came from pp->io_base, set by
> > >    dw_pcie_host_init() from pci_pio_to_address(), which I'm pretty
> > >    sure returns a CPU address.
> >
> > io_base is parent_bus_address
> >
> > >    So this still looks wrong to me.  In addition, I think doing the
> > >    ATU setup in *_map() and restore in *rd/wr_other_conf() is ugly
> > >    and looks unreliable.
> >
> > ....
> >
> > >  dw_pcie_pme_turn_off
> > >    atu.cpu_addr came from pp.msg_res, set by
> > >    dw_pcie_host_request_msg_tlp_res() to a CPU address at the end of
> > >    the first MMIO bridge window.  This one also looks wrong to me.
> >
> > Fixed at this version.
>
>
> I feel like it would have been easier if you replied to Bjorn's comments
> directly in the thread instead of pasting them here (to a cover letter).
>
>
> Please don't shoot the messenger, but I don't see any reply to (what I
> assume is the biggest reason why Bjorn did not merge this series):
>
> ""
> .cpu_addr_fixup() is a generic problem that affects dwc (dra7xx, imx6,
> artpec6, intel-gw, visconti), cadence (cadence-plat), and now
> apparently microchip.
>
> I deferred these because I'm hoping we can come up with a more generic
> solution that's easier to apply across all these cases.  I don't
> really want to merge something that immediately needs to be reworked
> for other drivers.
> ""
>
> It should probably state in the cover letter how v9 addresses Bjorn's
> concern when it comes to other PCI controller drivers, especially those
> that are not DWC based.

Thank you for your reminder, I forget mentions this in cover letter. I
create new patch to figure out this Bjorn's problem.

PCI: Add parent_bus_offset to resource_entry

With above patch, other platform will be easy apply the same method.

Frank
>
>
> Kind regards,
> Niklas

