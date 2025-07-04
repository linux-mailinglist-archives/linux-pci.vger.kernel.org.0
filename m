Return-Path: <linux-pci+bounces-31489-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D560AF8588
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 04:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0A34E7B9A
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 02:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD8313A41F;
	Fri,  4 Jul 2025 02:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GbeJBOsp"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010064.outbound.protection.outlook.com [52.101.69.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE204315F
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 02:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751595767; cv=fail; b=n5IMZqulvDhzV/T9IpsVsOYOiRKv7OO+wNHUj63f8YJZwOqtmrp6jUOgZ9PmWHF6uecq6wtoig6+4BUmFbgY+Yu99BoW+ele+81dJZCSawEK9b2SejFy7zYLEhgqS8P9JPfKUiBCyvs0SyvQqEPAytZZwro7C3mGfqe5B525S2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751595767; c=relaxed/simple;
	bh=YDIWqO6w6YLhoG62dWppdZBl15OBa52J4BNeqrBxbnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jjp3+olFZrbJgqVQTMyyrbWC+0mcD2z6X9N3qzJeW7hGgscBd0IpvR0t3Nd+BlxQda1k0tDvajNabGsGJSHHAZ7IMKmxZKKuXmYd6F3Wyezrdy2GvkgWpHCXbvWILj9oLQONZkgX29Rlw6AxILUXa1Azzo1YD5XGT827dYlie7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GbeJBOsp; arc=fail smtp.client-ip=52.101.69.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGCgydhBJswsabXkzqzlBh0lgHRy/NI5TVkDAEtlj59mkhJnhJ8kLm1Z2N8AY3cAI3i5jp1T6v0124qzMV7jOqoksG7U7EuWystlgFIAyGn5WDGV8v6N0cd42fDAEgYEGMgyrE0axQSv8rsfNl7ePE/cUmRsT/7Fd0m6GyniIl/iRUJaILRePS/Rsl0JRGUsdTJt6+uUCwj5nw2rY++UUBmAfmS/0UeFMz3niPcXfRr4kBSROqTQmQbjEdK9LEIhhC/2EAc8UPoq+z4wkmln6mTCjr4QThEl1IH2eg0BHl/WCONLB74XQMWEkluWZe5dY7XNDznIdTVXP+3K5bdJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O92F1jcOKd7e7vOkHZvvFlkEU3yIUiWu4+PYAfxM5gg=;
 b=ALpCBbkP44sCCEncXUxuLfZU8LkRYbVs0rFwAL9KtK9CTsa0XVK0F5yyI1WA1fuTOVnhkSKmADlDnXKpjpWhURCxZl91vDSqfEpI6/pH2dcgephlEuh8fVcY140OWq49Ei1CIt64xSdm2sjWlCv+AHhFuIfrIbKII5PwZ0F3cDZMQD6nbn9//mpFDgPgJ02N8Y71DnCUZOdrfkMq7VJYJjsaJQqBNy5QwsSyMqQZ3+O1kklrf7xZabA0lm9R4+cnaF+VGTq7BnFPNmwxHAG+nP6VpGGIrzKxiclYgLc0l+AUEEEWrRpl/o8aoqRHNoEOqCiIrIg/2JmFo3uKkqKLLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O92F1jcOKd7e7vOkHZvvFlkEU3yIUiWu4+PYAfxM5gg=;
 b=GbeJBOspF+lxjgUxUVJn6S5GIGgToVopdWmlEvS4sZo90VTnzXOEM8kwhzusMWYu/7hHcmd5nqSyNFEUKoEBNnT4rEpA/HyAQsSxaE9JpnQlZT/H3MOnsuMRN4GZUX/WBIwJXMQlSfbTRISBN8wyR9ewn1t1fwotMwkoqP/QG/tP836QQjOxz82QRo2F84QGbUlkw9fQ5M5zNSfG7ilhjjm8nux63ilZuvnSAHgCal90CiXdvS1zWL4+LVc5Ycrva7xky8a2KNWmC6jS2rjCOhQefwhR/ZKoZnECyYPlVZVifrWiULHc+0PCQ4zF7bMYY2/daa98XaPR/Yo2WC2UOw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10202.eurprd04.prod.outlook.com (2603:10a6:150:1c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 02:22:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8901.018; Fri, 4 Jul 2025
 02:22:39 +0000
Date: Thu, 3 Jul 2025 22:22:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
	Rob Herring <robh+dt@kernel.org>, imx@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: Does dwc/pci-layerscape.c support AER?
Message-ID: <aGc666o3EgtXQMGN@lizhi-Precision-Tower-5810>
References: <20250702223841.GA1905230@bhelgaas>
 <aGW8NnHUlfv1NO3g@lizhi-Precision-Tower-5810>
 <aGXEcHTfT2k2ayAj@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGXEcHTfT2k2ayAj@google.com>
X-ClientProxiedBy: AM0PR02CA0197.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10202:EE_
X-MS-Office365-Filtering-Correlation-Id: d1ca12e7-4d40-46bb-8b26-08ddbaa1a608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x0DhDrO11FU3qIGoG5TTQ/zGP6do2mftBUxXAnQjYxr0FqkWipBNUERMvPGC?=
 =?us-ascii?Q?ImEc0gDhb0WgC03HUQp9wW+VyxoXY/N2twedC1pc05oj+TldmfTrKXfCdtOC?=
 =?us-ascii?Q?y4Cbr96gYD+xzqLLHALPySaE/338Gh05L/8xOWgNj3jX6ACrjszr0em7uue2?=
 =?us-ascii?Q?ckJDkIk/RvzDG0erK4A5vH0sU81SPEVQnpvwRa9wL25uY64/+kSQWQbOjaQD?=
 =?us-ascii?Q?cf6PlW4c5OFnN9U0aoAWrryA0sNK6lqyKt1B0M7g3bFYIIOKD08+gYwjSVI+?=
 =?us-ascii?Q?Xn1CZUgoGpgoa58db93u1Puigi0XvSmIJLomXwAid05HXGSDnrC93TuMAmm1?=
 =?us-ascii?Q?HJdX/2Z6bRAaHBRVndnC5LdsII4Ho0bOQQ1D2apCRgCuA8ygLc8DWhprq/RD?=
 =?us-ascii?Q?AiyaDz+rjAFTxGvv07yB0pfLqme3knW2PpVI3GG3zYVrqsOjZYZu8FOfNGp5?=
 =?us-ascii?Q?/k2Jx/qwdADlz8vZb7TGr0mKn128ic2ta6toJdyRQuf2jAyqv8TNLsKwYimV?=
 =?us-ascii?Q?bfmoFVFvtK1ROkvrEYnka5Rt2NWhbT/Xm9LOcKEM1FEJNYcPtD+IgkAIFU2A?=
 =?us-ascii?Q?63H+lLCAv2JSVw+UXn2Po4jEZ7nRX7Ie4PIjj7y+4WmMnHOFO1YkNSxUkVkn?=
 =?us-ascii?Q?OLqpkK+lJC3ld0of7ELn8gC9fyRUbjkh8Ny/zZiGoA9olVt+ivxvhifBXSn8?=
 =?us-ascii?Q?kosbN9bFLNsjOLpO6sObgyMmSZ1x7tTXmEPpkr5HFnR1mdEb+Alkj5aY2iHM?=
 =?us-ascii?Q?mnxVyDCCwMw7wfsNolJ8VI3pwY7/OfnHQHRBbB5VdHOazoiDaZ3va7OIIACF?=
 =?us-ascii?Q?6CCS7zSwp3vXsjYxH6ZxvZyidJYrscW7uaWzkJcA+ovdIUCbCook/KOa5X6G?=
 =?us-ascii?Q?Z+wbMs1e7Ytq7xvCRpskUEXwJCmj8zKX6rZeGJXgxmhLiP3IrzaCUN0x2AhT?=
 =?us-ascii?Q?FLpOkPOSju7z37DGR9bVul4ZApMdNwH/qLNhfZfTiqf4MhsvOVGRaT8WjWeu?=
 =?us-ascii?Q?P7nsqGRH/lqBAucSFgxFBeQ47A0jTIyNjGifiVy0wQrWfpbzh6J17HRxzOEe?=
 =?us-ascii?Q?deViFz2Oz5PHjHv79CauEBzYDDCtaKH42FeSxW5np+T6nvpGBXTKfxO0PAMy?=
 =?us-ascii?Q?w1jFtmRtNKSdPf+OdcKTQlnfbt79BrRrPV6ZwOoQMDu6xV5RxsBo7B+Bj6Jj?=
 =?us-ascii?Q?5XgL9DZvsAee/QIx1NogFRrjSjGcC6oo69PvMcy+YdFIZYlU5gE86oxnE8de?=
 =?us-ascii?Q?yBPZT1pvDkJxGtip90KvEXKBw/Q7qrkbizxNCi/eZWURO8pYHt528JSJGk62?=
 =?us-ascii?Q?RwDAC5rgHxP6Vv16SUPqDqkxWk9Z9zoY5RaYj6tj5EZviTo7OXy1p3LbusnP?=
 =?us-ascii?Q?vM6C5nslRktKiJTOYqC8RI+o4fzlOPUvQi6Q0gbi4Idf4D/Af9pRD6irpfkp?=
 =?us-ascii?Q?sUTzby+4BbA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ObqwIggKnAPaIdG4bnA18cKfsaK2TCCQmKt/J2r9WIYtqTSIMdI+yRvxJO4Q?=
 =?us-ascii?Q?SV2Yz70GzAbq16QkMHIBDy7KqJm2S3utuM7tot4VcM4Ev1/HadPHv3UEv2xr?=
 =?us-ascii?Q?Vw2qfqiMo+4CWxS1fel2qMjefhmqDUOClBT55GFD6m52YPqLkiostOsOHJmV?=
 =?us-ascii?Q?zkL6uyLNbMSoDsx1itaZ8Llo/GDI0wet6q0we8ZI3j/DExAEHC173r3tb1AH?=
 =?us-ascii?Q?DDvUxv66K9QKVTLIN+Q/KaX1rWc1aSDZvJbEMcrePT2gP+DpOMYKn4PkKkkx?=
 =?us-ascii?Q?jF7L0r8Kfc7ic/iahOZiNdT24+0UJEfi9ZqCt0tSZu1mvOupT2/IzalxCb16?=
 =?us-ascii?Q?PnrA8+gZLYI4ZkJ1vb+Tjr/Au1be9cB0NC/DVsK+gkLpa1f+jTa2+HykgS0d?=
 =?us-ascii?Q?oKljHWVaRFz6EUCon5kGCaLxYBE/lUPBehgRVQjHpdKjcIS5GYTBgdilsLyw?=
 =?us-ascii?Q?RItdq3p4Y6A/UpqWaqOQntBvU4R+kZp/EDXIwaE/j44V/untWDKEaxLcWq19?=
 =?us-ascii?Q?es5nY8N20QbA/6wWGApjiZDsw7J99MPlpdlwJsMogV8+IgAW0Z4B+osLaL4x?=
 =?us-ascii?Q?HmcTZsVAeHTSNbBf3qNCJzeeT9Q/W4q741mgHIVAu2fD6Ddp/s+xRh3MqQvo?=
 =?us-ascii?Q?1HAwj8WWX0ldqk/1WKgsfXGTRqO/C33L06KPLgh8r4CB+x6AWFyjrVjlVEXO?=
 =?us-ascii?Q?WsR+mrfiC3q8DQLAUJ/TlrMbPBqYBM4lX7uXDDohUZxPbhAI2KnAkz9prD1/?=
 =?us-ascii?Q?xDibb+CZ9/4agz5K1SS+BAejK6RH7CUWMMOl8lORthOiCvv97+6pQpnosFJV?=
 =?us-ascii?Q?5KTdMtoMAwy1i0Rmp+YQ2y5ov3G/R9owXBgrU5IkLWEK5G8VR5rf5QMBebqB?=
 =?us-ascii?Q?BmbjBnS8Y+FdfyyM8YhAzzlldbLRaQpPQffR+gEfxDq+1DqnVpPfiolJgmYI?=
 =?us-ascii?Q?qfHzH4MrAlIYkGhcPpRIhjXdljWNpysNab+gBuG4ZCT6LtFuSvyHptYnt/Cx?=
 =?us-ascii?Q?YGf+e66UEh4U+4s0139DPn+a2mHnEmq7K8VUcvK0CQtYplYqRCNqIL7Fmz3X?=
 =?us-ascii?Q?jjiCbFz2J5C1vwix6rquRA/qhspyp3rgULO35kLU2NWKl1mO1N7c7Wp9nTLo?=
 =?us-ascii?Q?3vfBrBRU3fSTViK0x9p28DSDDkJfsM5uW725ygbZta1BMHTeW6EP4TR5s+pB?=
 =?us-ascii?Q?eRo3+kuFfNZ1crZwQZY3cWyl+g3qGNfNwa516Fb7+8bB+C+n4rUVlyGZkgvj?=
 =?us-ascii?Q?H4C/Y4zSPxO9hF1XiJ7JqmPuiYdJXnjQXFyvIzq0MRIkHJ3TBdDshCfRYg2N?=
 =?us-ascii?Q?ni2AwEFqHK6xeKqjlfhsm9P4xhhXRXZ70SXc1OedlUrV1eo/GPhfN1FZvLyN?=
 =?us-ascii?Q?dlNcgvqz2FRcS/eStH/DfnN13EdLQobW72EOfCgriPip7ZmeC7SFpolw0tlO?=
 =?us-ascii?Q?d72wzI+FnabohTmr24bz5ta3SHYXjWO8B6k/idkyoxmKRoiwjPf6XTRhWffy?=
 =?us-ascii?Q?h8pXwUKEupdtk0mCs+SCfcSnFL4ga3FScN4EASMzILhLbiKVHuYK2Bi3/2m4?=
 =?us-ascii?Q?aBAFhCxLgw3PuB8vsFct/7FdbmCPHBygfePcuKc2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ca12e7-4d40-46bb-8b26-08ddbaa1a608
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 02:22:39.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTbkf/krEbs3qLSdHviRhQMYLy7ajsV/mzGvEGcrNiHyeir8aed6hkJqZz1afYqVahQDVqoRNqXvzHcHXRkdPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10202

On Wed, Jul 02, 2025 at 04:44:48PM -0700, Brian Norris wrote:
> Hi Frank,
>
> On Wed, Jul 02, 2025 at 07:09:42PM -0400, Frank Li wrote:
> > > Does the AER driver actually work on these platforms?
> ...
> > There are several attempts to upstream customer Aer irq support in past years.
> >
> > For example:
> >   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1161848.html
> >
> > some change port drivers.
> >
> > If you think it is valuable to support customer AER IRQ support, I can restart
> > this work.
>
> Interesting thread. I read through it, but I'm still not convinced about
> one detail:
>
> Are you sure that AER can't possibly work over MSI? Even today, the
> Synopsys manuals say that their integrated MSI receiver "terminate[s]
> inbound MSI requests (received on the RX wire)" and after terminating,
> "an interrupt is signaled locally through the msi_ctrl_int output."
>
> That means that their msi_ctrl_int signal only handles MSI requests from
> downstream functions, and it implies that the default
> drivers/pci/controller/dwc/pcie-designware-host.c
> dw_pcie_msi_domain_info implementation will not actually see MSIs from
> the root port (such as PME and AER). So yes, it *appears* that AER does
> not work over MSI.
>
> But crucially, it does *not* mean that the port will not generate valid
> MSI requests, if you have some kind of logic that will receive it. So
> for instance, I pointed out in another reply that some SoCs choose to
> hook up GIC ITS:
>
>  commit 9c4cd0aef259 ("arm64: dts: qcom: x1e80100: enable GICv3 ITS for
>  PCIe")
>
> """
>     Note that using the GIC ITS on x1e80100 will cause Advanced Error
>     Reporting (AER) interrupts to be received on errors unlike when using
>     the internal MSI controller. Consequently, notifications about
>     (correctable) errors may now be logged for errors that previously went
>     unnoticed.
> """
>
> And in fact, your arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi seems
> to be doing the same. I'd be surprised if these port MSIs still don't
> work after that.
>
> OTOH, I do also believe there are SoCs where DWC PCIe is available, but
> there is no external MSI controller, and so that same problem still may
> exist. I may even have such SoCs available...

I saw AER and PME irq registed. But I have not seen irq increased. I am not
sure how to inject an error to test it.

I suppose it go through AER irq line.

Frank

>
> Brian

