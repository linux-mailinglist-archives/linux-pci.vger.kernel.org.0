Return-Path: <linux-pci+bounces-22588-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E8FA48733
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 19:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C9491691EB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 18:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEC41F5844;
	Thu, 27 Feb 2025 18:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GOZjuMJc"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBCF1F5824;
	Thu, 27 Feb 2025 18:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679404; cv=fail; b=MsJzxblaE2Rgc03c/UQuDagLyWKJblJDbvBTPVbUG9lAyppZRHggS2RFWAJc5JVxx6r6PskVf4u/qWPwpKJsyK54C0hbTmUMff6AywPDXn880CUNewCmaz1tHcgjxaiM/d79LgxU3qJ4vwLoIMWQ4KJPaa1WJPssmtOOtekpMc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679404; c=relaxed/simple;
	bh=SXxlyGiTqCgM75kzX/nZfTzPra3yc2d4BVE593ERcL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RiRMpkn+LgwZJaeoeZYv/R+20sbO9lmwWvyP6+R47P8vJGxbbg7LVgVKNjEcTZZTa63dk5pqW6Kge0/3iqUle/R9L03X8khBa80qcQT2fUUkiQY/xKDJR1rmKWO9jMgqvSHwh4O5EcJnDH94gMdpfNgU/c2vJ8uC8PmBfW8srdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GOZjuMJc; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/O0Coakp1mhJfCtTSLdkFTjtfFhtPWeDVJZdCRIuqItrXOelv64nf42qyeEhKnnBo+cfK1RG6QgWFI8/50f4/HcYnL/7xBOGP4+vs5FjG7Xj5+PR73fP3aXyQsclxSZwXQ5KCp2+HxJ/MBwT4BPudwdRCf593hoalBB+G1P9sZ/GUrVNrqg681e/hQU0boJ1wWB6TEFjr1ktVDrWDhHdA7U8N9K9Gj1DCe77sv/ZKxc0A29sLxTLbRLrCYtq/Br0jQ72+Nq1+qITgKGHGBuGNi6oXs+U/hYXhRnWe8WlOfZgv3opwbCQlLyh5uWSNhvc5GSNNzFT0BArgf8VxS5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9bLyJh2IUuk7c/OhYSJryt7HbvYHFV8wzN4u8xjJk0=;
 b=pCp5vQcJqZhWPXg30RTb/6R8x9oQ3ySOjsjFJAIT8yq5Ik8VFQbukT9pCZqcJ9sD5TeBlk+cmUfvNytDFnGPQPfpeyq8UYM7Ov/nyHvO/9rpOEr7XK5iGBAEu//1oTFX7kpUBKsZIIgYb8Bm+UPCwaLVWDSJvhKeOUwkgUUGefGCnSqcAOpD3A2LWxTkJ5Mvmss+/YUk/CUXU29elJDwZXWbgBgAFkCYpYt7ZlHUTGGTyjC5xDv/6M511JSR20XstdP+AiA+tueud/HaAHFs9Rs7L7OsxCGOFSfq/kY8cBmFDRrNdeuVU5RkGz851/V3/0IV0LrT2Wu13tlKbjSAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9bLyJh2IUuk7c/OhYSJryt7HbvYHFV8wzN4u8xjJk0=;
 b=GOZjuMJcBsVkq2oa0QJ4H12yKXlRM6cOgwFXlRerSVKbI4gagCO8CpxODV1pq2KYZB6xyRD+OvAZoP8pv8iesoSefm6lWAcI2Y9ZvfpEEIw7Qe1ARshF7Te3FxO7ta1BtCEEslSATCUNdGTnLiJ7ZarMsSh19Gpn8JXU7HsGMPR0XHI0KermC/fGdGjj7vm5N73A1/r7yZC/OlzvuDpH/4biYlDp6zDOl5lXIq0v2YQhlHypxHju1IuijP8Qk5lFBP6u0ysSkeDG8/MI3bmBxjgi0ku4V97K76JWRF0Nu1UcvycboxD0wNhC/rrzFd0VZgnTSV1sYEDIYWH9d3d46g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAWPR04MB9909.eurprd04.prod.outlook.com (2603:10a6:102:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Thu, 27 Feb
 2025 18:03:20 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 18:03:20 +0000
Date: Thu, 27 Feb 2025 13:03:13 -0500
From: Frank Li <Frank.li@nxp.com>
To: Hans Zhang <18255117159@163.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	tglx@linutronix.de, kw@linux.com, kwilczynski@kernel.org,
	bhelgaas@google.com, cassel@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/msi: Add the address and data that show MSI/MSIX
Message-ID: <Z8Co4ZnqObpnEbg7@lizhi-Precision-Tower-5810>
References: <20250227162821.253020-1-18255117159@163.com>
 <20250227163937.wv4hsucatyandde3@thinkpad>
 <f6e44f34-8800-421c-ba2c-755c10a6840e@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6e44f34-8800-421c-ba2c-755c10a6840e@163.com>
X-ClientProxiedBy: BYAPR02CA0033.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::46) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAWPR04MB9909:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fb8750-6522-42bd-d50a-08dd575904ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?56fIovvFzJynvJn06h2MPkYluDv6XwXCV6qSqfypNMsGbUGrp4MchtWvv2E9?=
 =?us-ascii?Q?Zp9njjrRIzfARmgNQjH16DO6kE6a4LK9Ya7BKgJU5m8zTUsb3GcQXFkIChHt?=
 =?us-ascii?Q?HFA3idwlsjH+bgoRPjmH7qznXsELSEAsh7zO2ySXcEV43isBJndMiyN0Mctk?=
 =?us-ascii?Q?SLXbyPQQ0njDoK8/QOuGpmlVAjTen7tTuCynMGsJZxH30KwBkTDOpwFWtmJu?=
 =?us-ascii?Q?EZGHIiQwvakMIFXDwCJJZ7vGF0DMxnHZBjfhWg3n18xiueKVpAkTIsPHgGpt?=
 =?us-ascii?Q?NApRJMY40vQRFgfFNPiK2fV2pZuRv0Ja6aKL3xWf5S+OSuTs4dwrERR0inXP?=
 =?us-ascii?Q?49PRkWn02YXfiy2OgpwAippbYOWNg/cl/OHeUrcC32mIioPTJbvE9xLhYYpn?=
 =?us-ascii?Q?AJmQ42xzF//M2rO4RrIdcH6/l6eV+aI/+mCUYIPP4dbs8Lf+wSrU2BgG2d0t?=
 =?us-ascii?Q?X2Wm1EUCX1+FhP3zN2aie8SM3qJd6B1FB9GzEvVBnBlgsCoVRboicQL1m22Z?=
 =?us-ascii?Q?+qhC4CJH6xLyfL9bUA8iKm49d0Y/C3US/IrQmAwLEs1m9Yd4woUe/VD5IBbS?=
 =?us-ascii?Q?q7euDh/MetHDx4cJYHO2uXzh9eMhojSGlz6vDpnGBY6c+c9sZwUGX5K9PpLR?=
 =?us-ascii?Q?m1kaGPzAvURRecXPkK8c47gIc1zo57QZEdIuCRYMN0XnzDZRzAq51MZvxwvV?=
 =?us-ascii?Q?bKK4WiAT4xLIOh6rs6FgMrouqi4XA+R9RNtLiTjXnnpT0vOveB8InnEsYeST?=
 =?us-ascii?Q?m8LhtHrqSMeuq+nu80YV24in9V39nBPzwl0MUNHxsqdIgjRye34JijGx2SL4?=
 =?us-ascii?Q?h1nEIQw93O9/uLn1PF921DPGKra7lmB2n8aDSjYefXrNRmSR6jr5Itph6MEI?=
 =?us-ascii?Q?NZLPWUiD4dVYUdd5De9ProakRu8dEv0c4E3Xrfj27SZW0NLdeOnMhCAs87ko?=
 =?us-ascii?Q?vK1BepH8Zwdqd9tJCzRJgR4xOt+NGJZ4kykoEIfGy8G4jjq/AuadWCIkXP4/?=
 =?us-ascii?Q?hfFolSNF2BmGldS8oQd1wqJzFagsTrlPHQ4KCkFnGZFkZh48mILcYo1uaLTa?=
 =?us-ascii?Q?z7V28VY2V780W+cJWOfTvcqB+3vXPpRBQ31wV/T/LJjLUK4gR151Kpu7D9SE?=
 =?us-ascii?Q?ZpxEt7PxGExdqIs0A8ge2qLlu8Y1Ub8+m+MdjtykROyhtyVrY4gBV/UH9iJp?=
 =?us-ascii?Q?isFygc2Y9oooDctmmrMvNYQl3+OWOvrjuSAdWBZR6Qf8IsYvQ95jmkcZSLsd?=
 =?us-ascii?Q?NHtK61cNxmdQx7SqV+BVh7TIm0ltlaDO7OrBZfoTN4LPfsXhNQgNPJVXVuap?=
 =?us-ascii?Q?ece/WSRsWqUIqJfDM5EKtRolVsG7Ws2sqn1wzfhAroxtKQte6bXn4bKyAGju?=
 =?us-ascii?Q?v9GD7m+uRMq+DVpTkJEeGNCm0RKArxJnQXJACoFSv+slGHj6U/GhHBUopGE7?=
 =?us-ascii?Q?3Xc+xywBa4LHvlJmP4Anu2pilL6J9dtx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qpm1Li14dDMZLUnubIzsanbpKKhSAcycrXM+avChLleuPcGsoyvVLJL1Uppr?=
 =?us-ascii?Q?jg1OkRGXyKQtSs1b8uSle9/R9t2IokjBkh/MlMB+mYyCmph25TvRrUKh9ZY8?=
 =?us-ascii?Q?Zi4S8eh9+WIel0oefZ71vqp+EFMXY0AGzNsDbcpCvAxqFfkZV3GQH/CPw98U?=
 =?us-ascii?Q?SQEdBqlKeSxa1vQbs08EvbBtDuj82wgqXHH6NTJZ5MWG1eu85IfGt8GslxS8?=
 =?us-ascii?Q?eaEz70/mKhDWkdEjPbaNeJJGKsu1OOJpMf83/sD7jnCGcUD0xSTFGcKgqFoJ?=
 =?us-ascii?Q?QPbDaXh8l2p12mbsHP6eJtwqm7e0RN/oQ75icNNOisVTcvUzfG4QB4VjWbbg?=
 =?us-ascii?Q?pFJiAuLHuBN9YinmFTq0qAIfAKhR4GbqHAHhDWfE1q4R/Z0tsa9cklKKJVAP?=
 =?us-ascii?Q?/YHzvIm87NhUQMVnCYh9vQXeYOZPkuMTAOulXMAUAIis+wxkQXRbE3676vn/?=
 =?us-ascii?Q?OoyLMrUj2xHKnewYbePS10vC3TYpttzFdb1UlFsmhilz+EKzO/OHZEDGiwyy?=
 =?us-ascii?Q?vAbUtDSMrpCZWQ4PIgvvEeqaguntY1caxF3SJYFG90C8k9K2WI0b5dT8Zc0J?=
 =?us-ascii?Q?ZY2uH+l/7vBQFZa+lCeRKbKS37qc8Kldipl9HalbjHjLlA6gOKwA8uhw71U+?=
 =?us-ascii?Q?KnnTKTFKdcGJcMUYeYX7afPDlXk7DIuoB9uF1jMKVMtpBxWUQnxDc2rA1rlN?=
 =?us-ascii?Q?LkdxBiLrHj/VqGg5eQfDjzWK5XkHEji+fB3ybxcOB8Fd6OC23WKWFgKDCA54?=
 =?us-ascii?Q?GGTx61lRhFjKgx1FOw90G6I+0cFhaOTOks87NfdT1uS7V9VT1slXXlFImVb0?=
 =?us-ascii?Q?SXKfHlMhgm525SkELoFdwFISYYKOUUZVnrXL33bhXYh7292PcVydZm8kxpiT?=
 =?us-ascii?Q?PtIm8UoSFAjQViJ3uZZ2vc8T3eiS/HokozhIE6svNwy2OQzJdPdR/fIBxjFO?=
 =?us-ascii?Q?P02K1rFijvzWjGMAbsLM+GldpZ8hHLPA6W4NDMo7CuNVQZX76AyeGmvlorxR?=
 =?us-ascii?Q?Pudx3BfiaHTsuGmueKbb2rufvVmxnls3rMPKAKfOLCxMjvY4mOarrWmX5TWB?=
 =?us-ascii?Q?Kdn/FjSqd/K1cns7vYexTV7+UplIJObdLh6sy6f0GEfhCwsD9m9kyxCyNYb4?=
 =?us-ascii?Q?JweCv0PegSisBM+PnL7eo0WTG5+QlY6e6V5Dod0I0WV3Xt2pxyyrqVX+5ueC?=
 =?us-ascii?Q?tefrf3pv9xG3Pa9ziEb1+fUqYK4FzQhjXR/GSvCk39BXFTlBD36R6e6LZvA0?=
 =?us-ascii?Q?RZdlRMQ3qcACmznqG8QwbH2w2zB0vpaonCmALn53kJLIoEzJ+/PUboh26/2Y?=
 =?us-ascii?Q?1SdHIGKnMKlCe9s7ROJ1eAGq6sSt0j0QZ04KP7Lz2xsr7o/YWBvBw0EieMQB?=
 =?us-ascii?Q?/gUQ9XbGEb526Q/WfK16gy/v5gRPOX4hCFY7Nw4qNxeCB3EYjPmDb3QGDmuW?=
 =?us-ascii?Q?Jdz4z+ESxpnDSUP0LyZbOQLm15X7j0cfG1pmmmzd5KCA4K6r7SvwbfB3Bhxn?=
 =?us-ascii?Q?O5JoDyXV0/X05s9WuQ4lWqX9FO0joBCr7L4rf8kECGvZvp2cSVck8PI/7AGf?=
 =?us-ascii?Q?PXxKhq26pwnaHE4+SM0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fb8750-6522-42bd-d50a-08dd575904ba
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:03:20.1475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KDJKQUfud9lGXR19Yhmgu10TRozSJYaLf55wNPsfhyD3b1sw8dnXxnjbNiBz6zRPYdc6xf/1P8X9rTH9alL64Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9909

On Fri, Feb 28, 2025 at 12:49:38AM +0800, Hans Zhang wrote:
>
>
> On 2025/2/28 00:39, Manivannan Sadhasivam wrote:
> > On Fri, Feb 28, 2025 at 12:28:21AM +0800, Hans Zhang wrote:
> > > Add to view the addresses and data stored in the MSI capability or the
> > > addresses and data stored in the MSIX vector table.
> > >
> > > e.g.
> > > root@root:/sys/bus/pci/devices/<dev>/msi_irqs# ls
> > > 86  87  88  89
> > > root@root:/sys/bus/pci/devices/<dev>/msi_irqs# cat *
> > > msix
> > >   address_hi: 0x00000000
> > >   address_lo: 0x0e060040
> > >   msg_data: 0x00000000
> > > msix
> > >   address_hi: 0x00000000
> > >   address_lo: 0x0e060040
> > >   msg_data: 0x00000001
> > > msix
> > >   address_hi: 0x00000000
> > >   address_lo: 0x0e060040
> > >   msg_data: 0x00000002
> > > msix
> > >   address_hi: 0x00000000
> > >   address_lo: 0x0e060040
> > >   msg_data: 0x00000003
> > >
> > > Signed-off-by: Hans Zhang <18255117159@163.com>
> > > ---
> > >   kernel/irq/msi.c | 12 +++++++++++-
> > >   1 file changed, 11 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> > > index 396a067a8a56..a37a3e535fb8 100644
> > > --- a/kernel/irq/msi.c
> > > +++ b/kernel/irq/msi.c
> > > @@ -503,8 +503,18 @@ static ssize_t msi_mode_show(struct device *dev, struct device_attribute *attr,
> > >   {
> > >   	/* MSI vs. MSIX is per device not per interrupt */
> > >   	bool is_msix = dev_is_pci(dev) ? to_pci_dev(dev)->msix_enabled : false;
> > > +	struct msi_desc *desc;
> > > +	u32 irq;
> > > +
> > > +	if (kstrtoint(attr->attr.name, 10, &irq) < 0)
> > > +		return 0;
> > > -	return sysfs_emit(buf, "%s\n", is_msix ? "msix" : "msi");
> > > +	desc = irq_get_msi_desc(irq);
> > > +	return sysfs_emit(
> > > +		buf,
> > > +		"%s\n address_hi: 0x%08x\n address_lo: 0x%08x\n msg_data: 0x%08x\n",
> > > +		is_msix ? "msix" : "msi", desc->msg.address_hi,
> > > +		desc->msg.address_lo, desc->msg.data);
> >
> > Sysfs is an ABI. You cannot change the semantics of an attribute.
> >
>
> Thanks Mani for the tip.
>
> If I want to implement similar functionality, where should I add it? Since
> this sysfs node is the only one that displays the MSI/MSIX interrupt number,
> I don't know where to implement similar debug functionality at this time. Do
> you have any suggestions? Or it shouldn't have a similar function.

I think it is useful feature to help debug. Generally only one property
for one sys file.

A possible create 3 files under

/sys/kernel/irq/26/
	address_hi, address_lo, msg_data.

cat address_hi, only show 0x00000000. ... ABI doc need update also.

Thomas(tglx) may provide better suggestions.

Frank

>
> Best regards
> Hans
>

