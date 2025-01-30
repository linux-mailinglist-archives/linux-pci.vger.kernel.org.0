Return-Path: <linux-pci+bounces-20578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B047AA23167
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 17:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6C123A6AC9
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 16:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1971C1EBFEF;
	Thu, 30 Jan 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UsDFf0uQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013070.outbound.protection.outlook.com [52.101.67.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E978E1E7668;
	Thu, 30 Jan 2025 16:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738252942; cv=fail; b=SZSd/AjbPjLzoqgP0e8st7eEWANT+sNdHQlHLOVz5vMU0ZZEd3nT3xAa8F+eXP5ytoKIbDDovi+vuDqiIKKvJF8f+vSPklC0yrvda0au5feRF+tJiTDe6acL/HbXKF8E1kEmGNn45QNhw7Doqh6KRCpTLkoBhWBjR/Bcyze5kSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738252942; c=relaxed/simple;
	bh=siXu+mw85J+DAcM1MAEDhYKxcBuE1CwP2TyA9610uCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SX9lSimDVc1GBHBrXn6Xzy4RVC8NeosaaLPezt9eS+9AY6tofgnDc/rLjLaxROLQlGa47qlFDOjZWLVqZ3i+CyoMydZUPa2m0kUWxynqZ8o7ekmf7NxWKuUD9INN57IENiS+0TNQA5+Enx3VAGOf0BNEDmwDepnhm46JrFB1jlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UsDFf0uQ; arc=fail smtp.client-ip=52.101.67.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lz1kUilZ/R8IhdpT3Rhtau0tsrs2tvgtIFLXUIu0feRJIskHvazj1LyTi1+nHBDqtKvJPX0OF3SokZ56U3nHWuqp80DdfdQtXSm7TFLmFeMR6Cm7r+2zxJdYyww88nitUtJpNatfQ+MYROl4IDmVAmlWDAs4O7xYEI5UkSA1B+iCtC6SJ+3crQhodD7Nbg+G3qtpAXG4CSaCsVUN+7FF3IJj6BeyWZ7PEXVMAdc7xofEkrpo6n9SJvfCxdhbwKrg5J9joCA1PPN58nBz6aELN7HCjWXM2F/VnodY0DKEF/EWImogatennM4GHqCITBmhdqyUFUGe+f+8cmJfKu7fNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CB6sJzB6Q8GJk38e9tC5ZhC02L4dBQL3G8RyYCigd1Y=;
 b=Nxl+KwFrqMoqIEdsqyunxW6MNCTRn8eTMHwIdsavr3AsLljIUZuk9B5C39XfUmv6TkmmzxQ04vkBPYr9TjN/n00Fz2IcHMs/pngPaBQ4eYLS6kZIEl7L+SbGOxVjBCDuPrnueaxyt7Rhi+h9/RFRj9ylZX7YZi3mdYjCFkA/Tw7aZjjP2nyxL+wQO3GaVNjtrJZWz7skl2HNidzJ3RJHHHpUIREUacapb7Y9DTaUlHJ3ZH1cBzLZe2x3WKMJg4iv93fwfis/Kx5+djrt28XntKsHvqA+rsFaHbCmdQmSXVwVFQh9LnXiLCxIfHXGlLiZSybIDt5hiP9Fi1RFWDZwnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CB6sJzB6Q8GJk38e9tC5ZhC02L4dBQL3G8RyYCigd1Y=;
 b=UsDFf0uQzVe6/YfVQEtiVDztTm6sEKXjtJK7mJ8xYA86iqDEJ97v1EW/2t337OhV6AbmZZ6M7cu2pE2JALGxOyZumw+q7laiSIJ7FT3zQzytx+7lRVx6uy5tsGUOyWEfojKeESfZWv1aYHmGKWvqMhrC820gntpr7tzBHgFH0EgjPV3zI91K6/3f0YR71W+ZnGUSHYzr4xaYJTFmOs2FdjMI68DL6w/P3br9C7JwP0coPNXVBByvVQNpDUzrnbEZXRFiHSEXbWqPGq32q7h9G49crcaEaPuu59wwpGl0ZC2INRCmRggKIAR0fK+g1XuR7CIEFC6oX+TuBMwW7+T+Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB8373.eurprd04.prod.outlook.com (2603:10a6:102:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 16:02:16 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%7]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 16:02:16 +0000
Date: Thu, 30 Jan 2025 11:02:06 -0500
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
Subject: Re: [PATCH v9 2/7] PCI: dwc: Rename cpu_addr to parent_bus_addr for
 ATU configuration
Message-ID: <Z5uifr5+JE0xSi2l@lizhi-Precision-Tower-5810>
References: <20250128-pci_fixup_addr-v9-2-3c4bb506f665@nxp.com>
 <20250129232350.GA527937@bhelgaas>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129232350.GA527937@bhelgaas>
X-ClientProxiedBy: SJ0PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::9) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b23fbb-14f9-4afb-460f-08dd41477799
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7n/s9qaUgp1dRQUimWasTn6Lv/OqBXbynbtuT+/URdCFrVhOXJrv2ey5IgUP?=
 =?us-ascii?Q?DnghDLiQW9Erwn3dIX0oRlXmsoky+Lp4GZtBxJWd7BqcGpf2tsl29QIJVHVs?=
 =?us-ascii?Q?h2e7aTRC4Fh6N+2q5zt4KfZevjQj/0xs3HOeNB6btZk2zvZE44gQxx7FmAgN?=
 =?us-ascii?Q?HKtgiqvLD6/1wi4UjIhIKDYQ59CPnNMU+MHmlvd421QiUuTYq7X2Yvz9VO5b?=
 =?us-ascii?Q?Ej0JHXukZRWMJZos9MaaF6qStd7UEGwsyXcOuuCVH6KWRW1AMut2KuB5Say4?=
 =?us-ascii?Q?HsGce43D3yi5CbCvolcxbW7Ek3X4Uy+ujC/51hbjf6Cckra0XCJxo3oCD5Sx?=
 =?us-ascii?Q?qzf2/hBQhcx7+wzYSkRMY8bNvqJ9kO4Qp+dlRFxuzNJdMp9tSBqzzkY4GLcK?=
 =?us-ascii?Q?4j9ot7aYrvsTycawjBNYZGEzKqM9pKOD8y42p7tf+2lsEVLGlpvFdUcB4gGN?=
 =?us-ascii?Q?XsZGmVFWPIp4JG7c2qWPhxK8tcHEaRiAH5HxTAlHcPdoMicoDuTm9soiCDuI?=
 =?us-ascii?Q?ezSB2ieRZE2QrQ5rkFw8Nm4ldXTXfD0kKEn0GWnW2wW/8iD3824VYMC2BCsb?=
 =?us-ascii?Q?NY1TNEevO2yuUwcQnJCT4Lw6YbNjqzlxGpnyKh1UpGx15t9s1Fa7aEANbKGF?=
 =?us-ascii?Q?p/+jA7T7iagz7Vd0AoB5RZtCDgQwEJD4+tJtBu5eJekPh9RXxKhlBpgXXtll?=
 =?us-ascii?Q?QmfL4JRAkiwdH9VfzE14INF+fspbVh2bpY5EEdHBjQjcpaL5VHFnnLteDqAy?=
 =?us-ascii?Q?HEZ7vUexdT4ieBSVq4OoGhyfJVENtJE/qyT9Fldbd0cQ2It9JePlu4Y7EqHW?=
 =?us-ascii?Q?7zIX9fA/CIkPuzkM2J6FNCOibEFrR6SKNmkNmaIYbLG0oENKq5DTjPc1RzQp?=
 =?us-ascii?Q?BJOARcovohGpQktdugqKDPS/eREXCpiONxP8uPtUYaJT1Ns6X6Ut5XQMHwqn?=
 =?us-ascii?Q?K9s1X6+12YEYDbM61Xk/HykhE/VBBxhX2N0Jta6Std+o69qeNWXGhapVFpOM?=
 =?us-ascii?Q?JigxjWBdV0yxCKSA5dN/Rjr2wVq6Am+85uBvX79mc9Bwpnl1jT5kRuzUpK4U?=
 =?us-ascii?Q?9q8RvQeUq9pJwuy82Q4WUaD5y/mcFxJyXMKKTJ9sAy+InxOZgTM3PYC7156/?=
 =?us-ascii?Q?0wr0CptpDlsu/6wOFYqB/5Nid+hKdXWMxx1gEWdjYmPMNDUeCkaUq3kp5ry9?=
 =?us-ascii?Q?z5whLlAqYmO+IYscpcSE0C0WhbBg+DpiXtgze/7wh89otaE7FBJwAgyh4ylE?=
 =?us-ascii?Q?vBFUv/eLomUz07Ra/DXu4YTpuqldIFeLAqKSmbbpIifrQSDO7FlTcnHUDcGK?=
 =?us-ascii?Q?ZDrwhwcIT0TpI8wvfIVYqB8oyeX3Ii9hOyI3tD7pXIY+RNtXC2uFoihT/9el?=
 =?us-ascii?Q?CMBFYoyiTqqiwWqBUM63AZb4SoB8bygTuNQzOJdf6ffB6w0YycseAHn8BFB7?=
 =?us-ascii?Q?yVBChMPU75ml0fjXGy8FIgn8r11AHnRT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lnAMQ7sNBN47I4m/45t8OpP6QcL/xEg2oEG7dx4P0gzkyLL7D8B/AQdwdKhI?=
 =?us-ascii?Q?+w0gPfwaTGZ231il/L95i2my/y8SLmc7T2IDDmFaKZldvakuja2LpmxlfhyY?=
 =?us-ascii?Q?pFdxPmYqit3XJ3JmXyCaPeguqEEIQriF6fGN2m3T08THQzIHCvIe8D0WmEQx?=
 =?us-ascii?Q?/je9Ax6IXSpyr9eOgGs2UzhqSRpbImlCOZw60z3x8F8hcNMECdHt7B83310i?=
 =?us-ascii?Q?Q0AiF40dYypNSUHzsmHkfsuHs5n1lsKeRMniI3DZ9QhY0zpgtVcAbWAm9nmh?=
 =?us-ascii?Q?qUSIxv0ut62ci08azdJT+OTl7nvO9fgeVndpOUUOz3AtA0upxXBpwvCurXhC?=
 =?us-ascii?Q?el6mwsxaXjM4K045l5BmQuhmUs0C+5C9ujeZoy+pxWJgzfezmSEbZuFiQGV8?=
 =?us-ascii?Q?pPNHe9nZ4ivPyr16r3sFgF3FfjpU18cW3Sth0gcbNB94uVxvcIKUeFVXOPhc?=
 =?us-ascii?Q?bk7/G3MnQQ+PdJN2RP9hHuCUFbpZdbvIxxaR0+tEveh+S77G5/r/VHcE+ma6?=
 =?us-ascii?Q?akhKLlICD57ZEv+WlD9auJhXDagqJBuQ/llOgY+ldEyJE3SqSv0vPoFb3yOl?=
 =?us-ascii?Q?IQLcKnVPhXGUDaonAAGSMY8ini/7G6V7Y6ii7ySo1iFozlMvEzwK2CCRAoiN?=
 =?us-ascii?Q?1/9BMjWyKS13Azt1kPUmyEhejCqD1O5cp1mwA4NcZW8VkqGW6l1FzvQbawUn?=
 =?us-ascii?Q?OSEuMvgGUqEHylPSadRdCti2HyuBH1ZDIofWirx7F4vUQ15i0QkzW5qgUmFc?=
 =?us-ascii?Q?hBPvAL9XvLx5ngPYwUeXpaeT05VTdGHGz3EYlekPfutz4ZFuc6nmg1xyYPRZ?=
 =?us-ascii?Q?cqfj8chAND50v991MJ7SlWDeOroXUbnTP6/PMnGcGdR/iBpRKYwc7imCVqqs?=
 =?us-ascii?Q?CrTG2qWf91qBRxYRxozEv9fE0pzobqW+cmqK43jFm7zKC9Ppp4AH5fO8GFQH?=
 =?us-ascii?Q?uXcqyjJfSQi1XbGIOkfvJCtjz1fjmmOnEzg9fPKhrPXTIzo4/Dlm4L6VA08w?=
 =?us-ascii?Q?WsnD7sSj9RRzXXMnimMFI3nSv+IGXI4Z7QObVcXAxBiWx0lTIE3rLG2+17i6?=
 =?us-ascii?Q?/gMiR3hNcQxwTQg1/WFRr+evdhBOYowzlZMz/ORD7FYe5dnOXPBRImg4VUM3?=
 =?us-ascii?Q?rTu3y09JUwoT+cF0w4fqdLsLUlxjf8r2c4LiLpOQ9GeoOtrp2H68uCj86lDJ?=
 =?us-ascii?Q?EtlU2g0UlEfKfUzOSgeXl9sW0hCC5/yt9hRCvM47STg2+Hmq1lr+K1oIMXZm?=
 =?us-ascii?Q?JmblxnYMwrcNUlXZSI5nUqMGLJUoqZtAjQ9xxQv42TDVcuzJkUlZORRIzfCZ?=
 =?us-ascii?Q?odukn2xfOPQd4I39hiYjFxIBK7wQkMUQnFzGcadx53kQqj+WpTM7kJ+B7LU+?=
 =?us-ascii?Q?lXJyZduD/eQfGZrofh9EDWuj/VbM2Os0l6yq9XmY1WhC8t3p/WltBfSnw9Ts?=
 =?us-ascii?Q?WRdjkEj2xKaf07CtO2YQmalBqN9cF9qGB8vE1mYwDAnhWxpHR3WyN3gUw/Lj?=
 =?us-ascii?Q?/u8bwJHLTsLjzGANvwALckPOVX+Ok72yosrmCiPadf7GgO8d2gDbXTfMTMoQ?=
 =?us-ascii?Q?ZtuZ1O/i4xlM97RxUUzLCJ4+PaIItdEwCuny7892?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b23fbb-14f9-4afb-460f-08dd41477799
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 16:02:16.3582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CupvFe8qnJ5yY4zzZscj9f/GS0g+TbYMkKmunNJOoEGbXOlV6sM5YwRTUGaaBljA8rQxROrX1TamyrNemRIvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8373

On Wed, Jan 29, 2025 at 05:23:50PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 28, 2025 at 05:07:35PM -0500, Frank Li wrote:
> > Rename `cpu_addr` to `parent_bus_addr` in the DesignWare ATU configuration.
> > The ATU translates parent bus addresses to PCI addresses, which are often
> > the same as CPU addresses but can differ in systems where the bus fabric
> > translates addresses before passing them to the PCIe controller. This
> > renaming clarifies the purpose and avoids confusion.
>
> Based on dw_pcie_ep_inbound_atu() below, I guess the ATU can also
> translate PCI addresses from incoming DMA to parent bus addresses?

Yes, but root complex don't use it. Only EP use it. because most PCI root
complex system doesn't transfer incoming address, which generally use iommu
to do that. Linux already allow a simple map by use dt's dma-ranges and dma
API already handle it.

previous 'cpu_addr' is actually 'dma_bus_addr'.

>
> It's worth noting here that this patch only renames the member, and
> IIUC, parent_bus_addr still incorrectly contains CPU physical
> addresses.

Anyway, call 'cpu_addr' for dw_pcie_ep_inbound_atu is wrong. Only one place
call dw_pcie_ep_inbound_atu(), that's dw_pcie_ep_set_bar(), which use
epf_bar->phys_addr, I think name 'phys_addr' is okay because most case it
is refer to dma address space.

Frank
>
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -128,7 +128,7 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  }
> >
> >  static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
> > -				  dma_addr_t cpu_addr, enum pci_barno bar,
> > +				  dma_addr_t parent_bus_addr, enum pci_barno bar,
> >  				  size_t size)

